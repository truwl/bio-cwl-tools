#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: truwl/kallisto:0.45.0--hdcc98e5_0
  SoftwareRequirement:
    packages:
      Kallisto:
        specs: [ "http://identifiers.org/biotools/kallisto" ]
        version: [ "0.45.0" ]
requirements:
  InlineJavascriptRequirement: {}

inputs:
  InputFiles:
    type: File[]
    format: edam:format_1929 # FASTA
    inputBinding:
      position: 200
    
  IndexName:
    type: string
    inputBinding:
      prefix: "--index="
      separate: false
      valueFrom: $(self + ".kl")

#Optional arguments

  kmerSize:
    type: int?
    inputBinding:
      prefix: "--kmer-size="
      separate: false

  makeUnique:
    type: boolean?
    inputBinding:
      prefix: "--make-unique"

baseCommand: [kallisto, index]

outputs:

  index:
    type: File
    outputBinding:
      glob: $(inputs.IndexName)

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - http://edamontology.org/EDAM_1.18.owl

#!/bin/bash
# Forces interlacing of a series of frames into a lossless mp4 file.

if [ "$1" = "-h" ]; then
   echo "Forces interlacing of a series of frames into a lossless."
   echo "interlace-video.sh -i [input=render/%4d.png] -o [output=render/interlaced.mp4] -r [rate=30]"
fi

input="render/%4d.png"
output="render/interlaced.mp4"
rate="30"

while getopts ":i:o:r:" opt; do
   case $opt in
      i) input="$OPTARG"
      ;;
      o) output="$OPTARG"
      ;;
      r) rate="$OPTARG"
      ;;
      \?) echo "Invalid option -$OPTARG" >&2
      ;;
   esac
done

ffmpeg -hide_banner -framerate $rate -i "$input" -c:v libx264 -vf tinterlace=interleave_top,fieldorder=tff -flags +ildct+ilme -crf 0 -preset veryslow "$output"

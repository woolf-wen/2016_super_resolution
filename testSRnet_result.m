clear;
input = imread('2.jpg');
%input = rgb2gray(input);
input = im2single(input);
[w,h,~] = size(input);
%figure(1);
%imshow(input);
img = imresize(imresize(input,1/2.5),[w,h]);
figure(2);
imshow(img);
input = imresize(imresize(input,1/2.5),[w+12,h+12]);
netstruct = load('./data/SRnet-v1-color-128/net-epoch-2.mat');
net = dagnn.DagNN.loadobj(netstruct.net);
net.mode = 'test' ;
net.conserveMemory = false;
net.move('gpu');
net.eval({'input',gpuArray(input)});
result = net.vars(6).value;
prediction = gather(result);
%prediction(prediction<0) = 0;
%prediction(prediction>1) = 1;
figure(3);
imshow(prediction);
// RUN: %dxc -E main -T cs_6_2 -enable-16bit-types %s | FileCheck %s

// CHECK: @dx.op.binary.i16
// CHECK: @dx.op.unaryBits.i16
// CHECK: @dx.op.unaryBits.i16
// CHECK: sub i16

struct SUnaryUintOp {
    uint16_t input1;
    uint16_t input2;
    uint16_t output;
};
RWStructuredBuffer<SUnaryUintOp> g_buf;
[numthreads(8,8,1)]
void main(uint GI : SV_GroupIndex) {
    SUnaryUintOp l = g_buf[GI];
    int16_t output = min(l.input1,l.input2);
    output += firstbithigh(l.input1);
    output += firstbitlow(l.input1);
    output += l.input1 - l.input2;
    l.output = output;
    g_buf[GI] = l;
};
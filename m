Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21EEC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F132080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfF0JEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:04:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:6621 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0JEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:04:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 02:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="xz'?scan'208";a="162576729"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2019 02:04:37 -0700
Date:   Thu, 27 Jun 2019 17:04:46 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, bpf@vger.kernel.org,
        lkp@01.org
Subject: [bpf/tools] cd17d77705: kernel_selftests.bpf.test_sock_addr.sh.fail
Message-ID: <20190627090446.GG7221@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qXCixuLMVvZDruUh"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qXCixuLMVvZDruUh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: cd17d77705780e2270937fb3cbd2b985adab3edc ("bpf/tools: sync bpf.h")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: kernel_selftests
with following parameters:

	group: kselftests-00

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


# selftests: bpf: test_sock_addr.sh
# Wait for testing IPv4/IPv6 to become available ... OK
# libbpf: load bpf program failed: Permission denied
# libbpf: -- BEGIN DUMP LOG ---
# libbpf: 
# ; int connect_v4_prog(struct bpf_sock_addr *ctx)
# 0: (bf) r6 = r1
# 1: (b7) r1 = 1544617984
# ; memset(&tuple.ipv4.sport, 0, sizeof(tuple.ipv4.sport));
# 2: (7b) *(u64 *)(r10 -32) = r1
# 3: (18) r1 = 0x100007f00000000
# ; memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
# 5: (7b) *(u64 *)(r10 -40) = r1
# 6: (b7) r7 = 0
# ; struct bpf_sock_tuple tuple = {};
# 7: (63) *(u32 *)(r10 -8) = r7
# 8: (63) *(u32 *)(r10 -12) = r7
# 9: (63) *(u32 *)(r10 -16) = r7
# 10: (63) *(u32 *)(r10 -20) = r7
# 11: (63) *(u32 *)(r10 -24) = r7
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 12: (61) r1 = *(u32 *)(r6 +32)
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 13: (bf) r2 = r1
# 14: (07) r2 += -1
# 15: (67) r2 <<= 32
# 16: (77) r2 >>= 32
# 17: (25) if r2 > 0x1 goto pc+24
#  R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????0000 fp-16=00000000 fp-24=00000000 fp-32=mmmmmmmm fp-40=mmmmmmmm
# ; else if (ctx->type == SOCK_STREAM)
# 18: (55) if r1 != 0x1 goto pc+8
#  R1=inv1 R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????0000 fp-16=00000000 fp-24=00000000 fp-32=mmmmmmmm fp-40=mmmmmmmm
# 19: (bf) r2 = r10
# ; sk = bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv4),
# 20: (07) r2 += -40
# 21: (bf) r1 = r6
# 22: (b7) r3 = 12
# 23: (b7) r4 = -1
# 24: (b7) r5 = 0
# 25: (85) call bpf_sk_lookup_tcp#84
# 26: (05) goto pc+7
# ; if (!sk)
# 34: (15) if r0 == 0x0 goto pc+7
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????0000 fp-16=00000000 fp-24=00000000 fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; if (sk->src_ip4 != tuple.ipv4.daddr ||
# 35: (61) r1 = *(u32 *)(r0 +24)
# ; if (sk->src_ip4 != tuple.ipv4.daddr ||
# 36: (61) r2 = *(u32 *)(r10 -36)
# ; if (sk->src_ip4 != tuple.ipv4.daddr ||
# 37: (5d) if r1 != r2 goto pc+2
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????0000 fp-16=00000000 fp-24=00000000 fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_port != DST_REWRITE_PORT4) {
# 38: (61) r1 = *(u32 *)(r0 +44)
# ; if (sk->src_ip4 != tuple.ipv4.daddr ||
# 39: (15) if r1 == 0x115c goto pc+4
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????0000 fp-16=00000000 fp-24=00000000 fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 40: (bf) r1 = r0
# 41: (85) call bpf_sk_release#86
# ; }
# 42: (bf) r0 = r7
# 43: (95) exit
# 
# from 39 to 44: R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv4444 R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????0000 fp-16=00000000 fp-24=00000000 fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 44: (bf) r1 = r0
# 45: (85) call bpf_sk_release#86
# 46: (b7) r1 = 23569
# ; ctx->user_port = bpf_htons(DST_REWRITE_PORT4);
# 47: (63) *(u32 *)(r6 +24) = r1
# 48: (b7) r1 = 16777343
# ; ctx->user_ip4 = bpf_htonl(DST_REWRITE_IP4);
# 49: (63) *(u32 *)(r6 +4) = r1
# invalid bpf_context access off=4 size=4
# processed 42 insns (limit 1000000) max_states_per_insn 0 total_states 10 peak_states 10 mark_read 8
# 
# libbpf: -- END LOG --
# libbpf: failed to load program 'cgroup/connect4'
# libbpf: failed to load object './connect4_prog.o'
# libbpf: load bpf program failed: Permission denied
# libbpf: -- BEGIN DUMP LOG ---
# libbpf: 
# ; int connect_v6_prog(struct bpf_sock_addr *ctx)
# 0: (bf) r6 = r1
# 1: (18) r1 = 0x100000000000000
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 3: (7b) *(u64 *)(r10 -16) = r1
# 4: (b7) r1 = 169476096
# ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
# 5: (63) *(u32 *)(r10 -8) = r1
# 6: (b7) r7 = 0
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 7: (7b) *(u64 *)(r10 -24) = r7
# 8: (7b) *(u64 *)(r10 -32) = r7
# 9: (7b) *(u64 *)(r10 -40) = r7
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 10: (61) r1 = *(u32 *)(r6 +32)
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 11: (bf) r2 = r1
# 12: (07) r2 += -1
# 13: (67) r2 <<= 32
# 14: (77) r2 >>= 32
# 15: (25) if r2 > 0x1 goto pc+33
#  R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# ; else if (ctx->type == SOCK_STREAM)
# 16: (55) if r1 != 0x1 goto pc+8
#  R1=inv1 R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# 17: (bf) r2 = r10
# ; sk = bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
# 18: (07) r2 += -40
# 19: (bf) r1 = r6
# 20: (b7) r3 = 36
# 21: (b7) r4 = -1
# 22: (b7) r5 = 0
# 23: (85) call bpf_sk_lookup_tcp#84
# 24: (05) goto pc+7
# ; if (!sk)
# 32: (15) if r0 == 0x0 goto pc+16
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 33: (61) r1 = *(u32 *)(r0 +28)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 34: (61) r2 = *(u32 *)(r10 -24)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 35: (5d) if r1 != r2 goto pc+11
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 36: (61) r1 = *(u32 *)(r0 +32)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 37: (61) r2 = *(u32 *)(r10 -20)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 38: (5d) if r1 != r2 goto pc+8
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 39: (61) r1 = *(u32 *)(r0 +36)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 40: (61) r2 = *(u32 *)(r10 -16)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 41: (5d) if r1 != r2 goto pc+5
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 42: (61) r1 = *(u32 *)(r0 +40)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 43: (61) r2 = *(u32 *)(r10 -12)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 44: (5d) if r1 != r2 goto pc+2
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_port != DST_REWRITE_PORT6) {
# 45: (61) r1 = *(u32 *)(r0 +44)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 46: (15) if r1 == 0x1a0a goto pc+4
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 47: (bf) r1 = r0
# 48: (85) call bpf_sk_release#86
# ; }
# 49: (bf) r0 = r7
# 50: (95) exit
# 
# from 46 to 51: R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv6666 R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 51: (bf) r1 = r0
# 52: (85) call bpf_sk_release#86
# 53: (b7) r1 = 2586
# ; ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
# 54: (63) *(u32 *)(r6 +24) = r1
# 55: (18) r1 = 0x100000000000000
# ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
# 57: (7b) *(u64 *)(r6 +16) = r1
# invalid bpf_context access off=16 size=8
# processed 49 insns (limit 1000000) max_states_per_insn 0 total_states 13 peak_states 13 mark_read 11
# 
# libbpf: -- END LOG --
# libbpf: failed to load program 'cgroup/connect6'
# libbpf: failed to load object './connect6_prog.o'
# libbpf: load bpf program failed: Permission denied
# libbpf: -- BEGIN DUMP LOG ---
# libbpf: 
# ; int connect_v6_prog(struct bpf_sock_addr *ctx)
# 0: (bf) r6 = r1
# 1: (18) r1 = 0x100000000000000
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 3: (7b) *(u64 *)(r10 -16) = r1
# 4: (b7) r1 = 169476096
# ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
# 5: (63) *(u32 *)(r10 -8) = r1
# 6: (b7) r7 = 0
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 7: (7b) *(u64 *)(r10 -24) = r7
# 8: (7b) *(u64 *)(r10 -32) = r7
# 9: (7b) *(u64 *)(r10 -40) = r7
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 10: (61) r1 = *(u32 *)(r6 +32)
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 11: (bf) r2 = r1
# 12: (07) r2 += -1
# 13: (67) r2 <<= 32
# 14: (77) r2 >>= 32
# 15: (25) if r2 > 0x1 goto pc+33
#  R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# ; else if (ctx->type == SOCK_STREAM)
# 16: (55) if r1 != 0x1 goto pc+8
#  R1=inv1 R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# 17: (bf) r2 = r10
# ; sk = bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
# 18: (07) r2 += -40
# 19: (bf) r1 = r6
# 20: (b7) r3 = 36
# 21: (b7) r4 = -1
# 22: (b7) r5 = 0
# 23: (85) call bpf_sk_lookup_tcp#84
# 24: (05) goto pc+7
# ; if (!sk)
# 32: (15) if r0 == 0x0 goto pc+16
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 33: (61) r1 = *(u32 *)(r0 +28)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 34: (61) r2 = *(u32 *)(r10 -24)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 35: (5d) if r1 != r2 goto pc+11
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 36: (61) r1 = *(u32 *)(r0 +32)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 37: (61) r2 = *(u32 *)(r10 -20)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 38: (5d) if r1 != r2 goto pc+8
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 39: (61) r1 = *(u32 *)(r0 +36)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 40: (61) r2 = *(u32 *)(r10 -16)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 41: (5d) if r1 != r2 goto pc+5
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 42: (61) r1 = *(u32 *)(r0 +40)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 43: (61) r2 = *(u32 *)(r10 -12)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 44: (5d) if r1 != r2 goto pc+2
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_port != DST_REWRITE_PORT6) {
# 45: (61) r1 = *(u32 *)(r0 +44)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 46: (15) if r1 == 0x1a0a goto pc+4
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 47: (bf) r1 = r0
# 48: (85) call bpf_sk_release#86
# ; }
# 49: (bf) r0 = r7
# 50: (95) exit
# 
# from 46 to 51: R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv6666 R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 51: (bf) r1 = r0
# 52: (85) call bpf_sk_release#86
# 53: (b7) r1 = 2586
# ; ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
# 54: (63) *(u32 *)(r6 +24) = r1
# 55: (18) r1 = 0x100000000000000
# ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
# 57: (7b) *(u64 *)(r6 +16) = r1
# invalid bpf_context access off=16 size=8
# processed 49 insns (limit 1000000) max_states_per_insn 0 total_states 13 peak_states 13 mark_read 11
# 
# libbpf: -- END LOG --
# libbpf: failed to load program 'cgroup/connect6'
# libbpf: failed to load object './connect6_prog.o'
# (test_sock_addr.c:752: errno: Bad file descriptor) >>> Loading program (./connect6_prog.o) error.
# 
# libbpf: load bpf program failed: Permission denied
# libbpf: -- BEGIN DUMP LOG ---
# libbpf: 
# ; int connect_v6_prog(struct bpf_sock_addr *ctx)
# 0: (bf) r6 = r1
# 1: (18) r1 = 0x100000000000000
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 3: (7b) *(u64 *)(r10 -16) = r1
# 4: (b7) r1 = 169476096
# ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
# 5: (63) *(u32 *)(r10 -8) = r1
# 6: (b7) r7 = 0
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 7: (7b) *(u64 *)(r10 -24) = r7
# 8: (7b) *(u64 *)(r10 -32) = r7
# 9: (7b) *(u64 *)(r10 -40) = r7
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 10: (61) r1 = *(u32 *)(r6 +32)
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 11: (bf) r2 = r1
# 12: (07) r2 += -1
# 13: (67) r2 <<= 32
# 14: (77) r2 >>= 32
# 15: (25) if r2 > 0x1 goto pc+33
#  R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# ; else if (ctx->type == SOCK_STREAM)
# 16: (55) if r1 != 0x1 goto pc+8
#  R1=inv1 R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# 17: (bf) r2 = r10
# ; sk = bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
# 18: (07) r2 += -40
# 19: (bf) r1 = r6
# 20: (b7) r3 = 36
# 21: (b7) r4 = -1
# 22: (b7) r5 = 0
# 23: (85) call bpf_sk_lookup_tcp#84
# 24: (05) goto pc+7
# ; if (!sk)
# 32: (15) if r0 == 0x0 goto pc+16
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 33: (61) r1 = *(u32 *)(r0 +28)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 34: (61) r2 = *(u32 *)(r10 -24)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 35: (5d) if r1 != r2 goto pc+11
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 36: (61) r1 = *(u32 *)(r0 +32)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 37: (61) r2 = *(u32 *)(r10 -20)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 38: (5d) if r1 != r2 goto pc+8
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 39: (61) r1 = *(u32 *)(r0 +36)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 40: (61) r2 = *(u32 *)(r10 -16)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 41: (5d) if r1 != r2 goto pc+5
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 42: (61) r1 = *(u32 *)(r0 +40)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 43: (61) r2 = *(u32 *)(r10 -12)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 44: (5d) if r1 != r2 goto pc+2
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_port != DST_REWRITE_PORT6) {
# 45: (61) r1 = *(u32 *)(r0 +44)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 46: (15) if r1 == 0x1a0a goto pc+4
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 47: (bf) r1 = r0
# 48: (85) call bpf_sk_release#86
# ; }
# 49: (bf) r0 = r7
# 50: (95) exit
# 
# from 46 to 51: R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv6666 R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 51: (bf) r1 = r0
# 52: (85) call bpf_sk_release#86
# 53: (b7) r1 = 2586
# ; ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
# 54: (63) *(u32 *)(r6 +24) = r1
# 55: (18) r1 = 0x100000000000000
# ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
# 57: (7b) *(u64 *)(r6 +16) = r1
# invalid bpf_context access off=16 size=8
# processed 49 insns (limit 1000000) max_states_per_insn 0 total_states 13 peak_states 13 mark_read 11
# 
# libbpf: -- END LOG --
# libbpf: failed to load program 'cgroup/connect6'
# libbpf: failed to load object './connect6_prog.o'
# (test_sock_addr.c:752: errno: Bad file descriptor) >>> Loading program (./connect6_prog.o) error.
# 
# libbpf: load bpf program failed: Permission denied
# libbpf: -- BEGIN DUMP LOG ---
# libbpf: 
# ; int connect_v6_prog(struct bpf_sock_addr *ctx)
# 0: (bf) r6 = r1
# 1: (18) r1 = 0x100000000000000
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 3: (7b) *(u64 *)(r10 -16) = r1
# 4: (b7) r1 = 169476096
# ; memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
# 5: (63) *(u32 *)(r10 -8) = r1
# 6: (b7) r7 = 0
# ; tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
# 7: (7b) *(u64 *)(r10 -24) = r7
# 8: (7b) *(u64 *)(r10 -32) = r7
# 9: (7b) *(u64 *)(r10 -40) = r7
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 10: (61) r1 = *(u32 *)(r6 +32)
# ; if (ctx->type != SOCK_STREAM && ctx->type != SOCK_DGRAM)
# 11: (bf) r2 = r1
# 12: (07) r2 += -1
# 13: (67) r2 <<= 32
# 14: (77) r2 >>= 32
# 15: (25) if r2 > 0x1 goto pc+33
#  R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# ; else if (ctx->type == SOCK_STREAM)
# 16: (55) if r1 != 0x1 goto pc+8
#  R1=inv1 R2=inv(id=0,umax_value=1,var_off=(0x0; 0x1)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=00000000 fp-32=00000000 fp-40=00000000
# 17: (bf) r2 = r10
# ; sk = bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple.ipv6),
# 18: (07) r2 += -40
# 19: (bf) r1 = r6
# 20: (b7) r3 = 36
# 21: (b7) r4 = -1
# 22: (b7) r5 = 0
# 23: (85) call bpf_sk_lookup_tcp#84
# 24: (05) goto pc+7
# ; if (!sk)
# 32: (15) if r0 == 0x0 goto pc+16
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 33: (61) r1 = *(u32 *)(r0 +28)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 34: (61) r2 = *(u32 *)(r10 -24)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 35: (5d) if r1 != r2 goto pc+11
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 36: (61) r1 = *(u32 *)(r0 +32)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 37: (61) r2 = *(u32 *)(r10 -20)
# ; sk->src_ip6[1] != tuple.ipv6.daddr[1] ||
# 38: (5d) if r1 != r2 goto pc+8
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 39: (61) r1 = *(u32 *)(r0 +36)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 40: (61) r2 = *(u32 *)(r10 -16)
# ; sk->src_ip6[2] != tuple.ipv6.daddr[2] ||
# 41: (5d) if r1 != r2 goto pc+5
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 42: (61) r1 = *(u32 *)(r0 +40)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 43: (61) r2 = *(u32 *)(r10 -12)
# ; sk->src_ip6[3] != tuple.ipv6.daddr[3] ||
# 44: (5d) if r1 != r2 goto pc+2
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; sk->src_port != DST_REWRITE_PORT6) {
# 45: (61) r1 = *(u32 *)(r0 +44)
# ; if (sk->src_ip6[0] != tuple.ipv6.daddr[0] ||
# 46: (15) if r1 == 0x1a0a goto pc+4
#  R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 47: (bf) r1 = r0
# 48: (85) call bpf_sk_release#86
# ; }
# 49: (bf) r0 = r7
# 50: (95) exit
# 
# from 46 to 51: R0=sock(id=0,ref_obj_id=2,off=0,imm=0) R1=inv6666 R2=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(id=0,off=0,imm=0) R7=inv0 R10=fp0,call_-1 fp-8=????mmmm fp-16=mmmmmmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm refs=2
# ; bpf_sk_release(sk);
# 51: (bf) r1 = r0
# 52: (85) call bpf_sk_release#86
# 53: (b7) r1 = 2586
# ; ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
# 54: (63) *(u32 *)(r6 +24) = r1
# 55: (18) r1 = 0x100000000000000
# ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
# 57: (7b) *(u64 *)(r6 +16) = r1
# invalid bpf_context access off=16 size=8
# processed 49 insns (limit 1000000) max_states_per_insn 0 total_states 13 peak_states 13 mark_read 11
# 
# libbpf: -- END LOG --
# libbpf: failed to load program 'cgroup/connect6'
# libbpf: failed to load object './connect6_prog.o'
# (test_sock_addr.c:752: errno: Bad file descriptor) >>> Loading program (./connect6_prog.o) error.
# 
# (test_sock_addr.c:1122: errno: Operation not permitted) Fail to send message to server
# libbpf: load bpf program failed: Permission denied
# libbpf: -- BEGIN DUMP LOG ---
# libbpf: 
# ; int sendmsg_v6_prog(struct bpf_sock_addr *ctx)
# 0: (b7) r0 = 0
# ; if (ctx->type != SOCK_DGRAM)
# 1: (61) r2 = *(u32 *)(r1 +32)
# ; if (ctx->type != SOCK_DGRAM)
# 2: (55) if r2 != 0x2 goto pc+20
#  R0=inv0 R1=ctx(id=0,off=0,imm=0) R2=inv2 R10=fp0,call_-1
# ; if (ctx->msg_src_ip6[3] == bpf_htonl(1) ||
# 3: (61) r2 = *(u32 *)(r1 +56)
# ; if (ctx->msg_src_ip6[3] == bpf_htonl(1) ||
# 4: (47) r2 |= 16777216
# 5: (15) if r2 == 0x1000000 goto pc+1
#  R0=inv0 R1=ctx(id=0,off=0,imm=0) R2=inv(id=0,umin_value=16777216,umax_value=4294967295,var_off=(0x1000000; 0xfeffffff)) R10=fp0,call_-1
# 6: (05) goto pc+16
# ; }
# 23: (95) exit
# 
# from 5 to 7: R0=inv0 R1=ctx(id=0,off=0,imm=0) R2=inv16777216 R10=fp0,call_-1
# ; if (ctx->msg_src_ip6[3] == bpf_htonl(1) ||
# 7: (b7) r2 = 100663296
# ; ctx->msg_src_ip6[3] = bpf_htonl(SRC_REWRITE_IP6_3);
# 8: (63) *(u32 *)(r1 +56) = r2
# 9: (b7) r0 = 0
# ; ctx->msg_src_ip6[2] = bpf_htonl(SRC_REWRITE_IP6_2);
# 10: (63) *(u32 *)(r1 +52) = r0
# ; ctx->msg_src_ip6[1] = bpf_htonl(SRC_REWRITE_IP6_1);
# 11: (63) *(u32 *)(r1 +48) = r0
# ; ctx->msg_src_ip6[0] = bpf_htonl(SRC_REWRITE_IP6_0);
# 12: (63) *(u32 *)(r1 +44) = r0
# ; if ((ctx->user_ip6[0] & 0xFFFF) == bpf_htons(0xFACE) &&
# 13: (61) r2 = *(u32 *)(r1 +8)
# ; if ((ctx->user_ip6[0] & 0xFFFF) == bpf_htons(0xFACE) &&
# 14: (55) if r2 != 0xcb0cefa goto pc+8
#  R0=inv0 R1=ctx(id=0,off=0,imm=0) R2=inv212913914 R10=fp0,call_-1
# 15: (b7) r2 = 2586
# ; ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
# 16: (63) *(u32 *)(r1 +24) = r2
# 17: (18) r2 = 0x100000000000000
# ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
# 19: (7b) *(u64 *)(r1 +16) = r2
# invalid bpf_context access off=16 size=8
# processed 20 insns (limit 1000000) max_states_per_insn 0 total_states 5 peak_states 5 mark_read 3
# 
# libbpf: -- END LOG --
# libbpf: failed to load program 'cgroup/sendmsg6'
# libbpf: failed to load object './sendmsg6_prog.o'
# (test_sock_addr.c:752: errno: Bad file descriptor) >>> Loading program (./sendmsg6_prog.o) error.
# 
# (test_sock_addr.c:1122: errno: Unknown error 524) Fail to send message to server
# (test_sock_addr.c:1122: errno: Operation not permitted) Fail to send message to server
# Test case: bind4: load prog with wrong expected attach type .. [PASS]
# Test case: bind4: attach prog with wrong attach type .. [PASS]
# Test case: bind4: rewrite IP & TCP port in .. [PASS]
# Test case: bind4: rewrite IP & UDP port in .. [PASS]
# Test case: bind6: load prog with wrong expected attach type .. [PASS]
# Test case: bind6: attach prog with wrong attach type .. [PASS]
# Test case: bind6: rewrite IP & TCP port in .. [PASS]
# Test case: bind6: rewrite IP & UDP port in .. [PASS]
# Test case: connect4: load prog with wrong expected attach type .. [PASS]
# Test case: connect4: attach prog with wrong attach type .. [PASS]
# Test case: connect4: rewrite IP & TCP port .. [PASS]
# Test case: connect4: rewrite IP & UDP port .. [PASS]
# Test case: connect6: load prog with wrong expected attach type .. [PASS]
# Test case: connect6: attach prog with wrong attach type .. [FAIL]
# Test case: connect6: rewrite IP & TCP port .. [FAIL]
# Test case: connect6: rewrite IP & UDP port .. [FAIL]
# Test case: sendmsg4: load prog with wrong expected attach type .. [PASS]
# Test case: sendmsg4: attach prog with wrong attach type .. [PASS]
# Test case: sendmsg4: rewrite IP & port (asm) .. [PASS]
# Test case: sendmsg4: rewrite IP & port (C) .. [PASS]
# Test case: sendmsg4: deny call .. [PASS]
# Test case: sendmsg6: load prog with wrong expected attach type .. [PASS]
# Test case: sendmsg6: attach prog with wrong attach type .. [PASS]
# Test case: sendmsg6: rewrite IP & port (asm) .. [PASS]
# Test case: sendmsg6: rewrite IP & port (C) .. [FAIL]
# Test case: sendmsg6: IPv4-mapped IPv6 .. [PASS]
# Test case: sendmsg6: set dst IP = [::] (BSD'ism) .. [PASS]
# Test case: sendmsg6: preserve dst IP = [::] (BSD'ism) .. [PASS]
# Test case: sendmsg6: deny call .. [PASS]
# Summary: 25 PASSED, 4 FAILED
not ok 34 selftests: bpf: test_sock_addr.sh


To reproduce:

        # build kernel
	cd linux
	cp config-5.2.0-rc2-00597-gcd17d77 .config
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Rong Chen


--qXCixuLMVvZDruUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.2.0-rc2-00597-gcd17d77"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.2.0-rc2 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS_PROC is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM_MIRROR=y
CONFIG_ARCH_HAS_HMM_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set
# CONFIG_IWLWIFI_PCIE_RTPM is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m
# end of ISDN feature submodules

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_NO_SENDCOMPLETE=y
CONFIG_HISAX_NO_LLC=y
CONFIG_HISAX_NO_KEYPAD=y
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_NI1=y
CONFIG_HISAX_MAX_CARDS=8

#
# HiSax supported cards
#
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NETJET_U=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y
CONFIG_HISAX_ENTERNOW_PCI=y
# CONFIG_HISAX_DEBUG is not set

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=m
# CONFIG_HISAX_HFCUSB is not set
CONFIG_HISAX_HFC4S8S=m
CONFIG_HISAX_FRITZ_PCIPNP=m
# end of Passive cards

CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# end of Serial drivers

# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
# CONFIG_IR_IMON_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
# CONFIG_TEST_VMALLOC is not set
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--qXCixuLMVvZDruUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel_selftests'
	export testcase='kernel_selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp/lkp/.src-20190626-173845/allot/cyclic:vm-p1:linux-devel:devel-hourly/vm-snb-8G/kernel_selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-8G-447'
	export tbox_group='vm-snb-8G'
	export submit_id='5d145b0cf5b23314d71f1348'
	export job_file='/lkp/jobs/scheduled/vm-snb-8G-447/kernel_selftests-kselftests-00-debian-x86_64-2018-04-03.cgz-cd17d777-20190627-5335-11potd1-8.yaml'
	export id='e25b1c535714a8f68e385376f423976a905260da'
	export queuer_version='/lkp/lkp/src'
	export arch='x86_64'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_FIRMWARE
CONFIG_TEST_USER_COPY
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_NOTIFIER_ERROR_INJECTION
CONFIG_FTRACE=y
CONFIG_TEST_BITMAP
CONFIG_TEST_PRINTF
CONFIG_TEST_STATIC_KEYS
CONFIG_BPF_SYSCALL=y
CONFIG_NET_CLS_BPF=m
CONFIG_BPF_EVENTS=y
CONFIG_TEST_BPF=m
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HIST_TRIGGERS=y
CONFIG_EMBEDDED=y
CONFIG_GPIO_MOCKUP=y
CONFIG_USERFAULTFD=y
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_RAM=m
CONFIG_EXPERT=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_EFIVAR_FS
CONFIG_TEST_KMOD=m
CONFIG_TEST_LKM=m
CONFIG_XFS_FS=m
CONFIG_TUN=m
CONFIG_BTRFS_FS=m
CONFIG_TEST_SYSCTL=m
CONFIG_BPF_STREAM_PARSER=y
CONFIG_CGROUP_BPF=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_VRF=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_MACSEC=y
CONFIG_X86_INTEL_MPX=y
CONFIG_RC_LOOPBACK
CONFIG_IPV6_SEG6_LWTUNNEL=y ~ v(4\.1[0-9]|4\.20|5\.)
CONFIG_LWTUNNEL=y
CONFIG_WW_MUTEX_SELFTEST=m ~ v(4\.1[1-9]|4\.20|5\.)
CONFIG_DRM_DEBUG_SELFTEST=m ~ v(4\.1[8-9]|4\.20|5\.)
CONFIG_TEST_LIVEPATCH=m ~ v(5\.[1-9])
CONFIG_LIRC=y
CONFIG_IR_SHARP_DECODER=m
CONFIG_ANDROID=y ~ v(3\.[3-9]|3\.1[0-9]|4\.|5\.)
CONFIG_ION=y ~ v(3\.1[4-9]|4\.|5\.)
CONFIG_ION_SYSTEM_HEAP=y ~ v(4\.1[2-9]|4\.20|5\.)
CONFIG_KVM_GUEST=y'
	export commit='cd17d77705780e2270937fb3cbd2b985adab3edc'
	export ssh_base_port=26000
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-06-27 13:58:37 +0800'
	export _id='5d145b0cf5b23314d71f1348'
	export _rt='/result/kernel_selftests/kselftests-00/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc'
	export user='lkp'
	export head_commit='5baf9011649a95b56aaa6d661cd8a37afda86ee9'
	export base_commit='4b972a01a7da614b4796475f933094751a295a2f'
	export branch='linux-devel/devel-hourly-2019062614'
	export result_root='/result/kernel_selftests/kselftests-00/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc/8'
	export scheduler_version='/lkp/lkp/.src-20190627-100540'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-8G-447/kernel_selftests-kselftests-00-debian-x86_64-2018-04-03.cgz-cd17d777-20190627-5335-11potd1-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019062614
commit=cd17d77705780e2270937fb3cbd2b985adab3edc
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc/vmlinuz-5.2.0-rc2-00597-gcd17d77
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel_selftests/kselftests-00/vm-snb-8G/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc/8
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-06-26.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2019-06-26.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-b253d5f3ecc9_2019-06-23.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc/linux-selftests.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=18
	export schedule_notify_address=
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export queue_at_least_once=1
	export vm_tbox_group='vm-snb-8G'
	export nr_vm=80
	export vm_base_id=801
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/cd17d77705780e2270937fb3cbd2b985adab3edc/vmlinuz-5.2.0-rc2-00597-gcd17d77'
	export dequeue_time='2019-06-27 13:58:42 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-8G-447/kernel_selftests-kselftests-00-debian-x86_64-2018-04-03.cgz-cd17d777-20190627-5335-11potd1-8.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='kselftests-00' $LKP_SRC/tests/wrapper kernel_selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kernel_selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel_selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--qXCixuLMVvZDruUh
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
79LvRbHEZ/sCAAAAAARZWg==

--qXCixuLMVvZDruUh
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kernel_selftests.xz"
Content-Transfer-Encoding: base64

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
lp8C05CNAQAAAE53YFcUFzswAwAAAAAEWVo=

--qXCixuLMVvZDruUh--

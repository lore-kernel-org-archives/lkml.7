Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9188C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808062173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504239;
	bh=6Tq97tdil9VtO3y1H5xtH2kXYL50kpyBtSt5K0yW0Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZ0WeMJbH5WjgShVYwdRdHOL5v8a3jviUYgFI38Di6+Z6p+cZhYvjetoGozyysJ/t
	 FUBifH0A5od55UAVcTRIh2IsLWEkix0eUyLnjx6mE5NZ1SzJJUGpAVwisiVohdkTRP
	 RZ/YJbZz5uWU6yBZKKt223/7PjqzMoMocTbpGleA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCMTKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfCMTKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8B332147C;
        Wed, 13 Mar 2019 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504234;
        bh=6Tq97tdil9VtO3y1H5xtH2kXYL50kpyBtSt5K0yW0Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NhLTjyT0AmquwCMNbQ0NXMJ/ugZlnRoQb3pM/V5xZZhg46pU5JwBz+smbmIHMfBSn
         phW2inJPq+9W7FDD1524ky0smdwXj0JcbfAedqah4inIac2agxfs47WlwrXglohJjO
         yZYpxj0xa1rH5+C2AMQw9ecxBN3I/2fxZRAA4NlE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, Joe Stringer <joe@wand.net.nz>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 06/60] bpf: Fix narrow load on a bpf_sock returned from sk_lookup()
Date:   Wed, 13 Mar 2019 15:09:27 -0400
Message-Id: <20190313191021.158171-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin KaFai Lau <kafai@fb.com>

[ Upstream commit d623876646be119439999a229a2c3ce30fd197fb ]

By adding this test to test_verifier:
{
	"reference tracking: access sk->src_ip4 (narrow load)",
	.insns = {
	BPF_SK_LOOKUP,
	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
	BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_0, offsetof(struct bpf_sock, src_ip4) + 2),
	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
	BPF_EMIT_CALL(BPF_FUNC_sk_release),
	BPF_EXIT_INSN(),
	},
	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
	.result = ACCEPT,
},

The above test loads 2 bytes from sk->src_ip4 where
sk is obtained by bpf_sk_lookup_tcp().

It hits an internal verifier error from convert_ctx_accesses():
[root@arch-fb-vm1 bpf]# ./test_verifier 665 665
Failed to load prog 'Invalid argument'!
0: (b7) r2 = 0
1: (63) *(u32 *)(r10 -8) = r2
2: (7b) *(u64 *)(r10 -16) = r2
3: (7b) *(u64 *)(r10 -24) = r2
4: (7b) *(u64 *)(r10 -32) = r2
5: (7b) *(u64 *)(r10 -40) = r2
6: (7b) *(u64 *)(r10 -48) = r2
7: (bf) r2 = r10
8: (07) r2 += -48
9: (b7) r3 = 36
10: (b7) r4 = 0
11: (b7) r5 = 0
12: (85) call bpf_sk_lookup_tcp#84
13: (bf) r6 = r0
14: (15) if r0 == 0x0 goto pc+3
 R0=sock(id=1,off=0,imm=0) R6=sock(id=1,off=0,imm=0) R10=fp0,call_-1 fp-8=????0000 fp-16=0000mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm fp-48=mmmmmmmm refs=1
15: (69) r2 = *(u16 *)(r0 +26)
16: (bf) r1 = r6
17: (85) call bpf_sk_release#86
18: (95) exit

from 14 to 18: safe
processed 20 insns (limit 131072), stack depth 48
bpf verifier is misconfigured
Summary: 0 PASSED, 0 SKIPPED, 1 FAILED

The bpf_sock_is_valid_access() is expecting src_ip4 can be narrowly
loaded (meaning load any 1 or 2 bytes of the src_ip4) by
marking info->ctx_field_size.  However, this marked
ctx_field_size is not used.  This patch fixes it.

Due to the recent refactoring in test_verifier,
this new test will be added to the bpf-next branch
(together with the bpf_tcp_sock patchset)
to avoid merge conflict.

Fixes: c64b7983288e ("bpf: Add PTR_TO_SOCKET verifier type")
Cc: Joe Stringer <joe@wand.net.nz>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
Acked-by: Joe Stringer <joe@wand.net.nz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63a9253679f2..c0fb76d1e771 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1533,12 +1533,13 @@ static int check_flow_keys_access(struct bpf_verifier_env *env, int off,
 	return 0;
 }
 
-static int check_sock_access(struct bpf_verifier_env *env, u32 regno, int off,
-			     int size, enum bpf_access_type t)
+static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
+			     u32 regno, int off, int size,
+			     enum bpf_access_type t)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = &regs[regno];
-	struct bpf_insn_access_aux info;
+	struct bpf_insn_access_aux info = {};
 
 	if (reg->smin_value < 0) {
 		verbose(env, "R%d min value is negative, either use unsigned index or do a if (index >=0) check.\n",
@@ -1552,6 +1553,8 @@ static int check_sock_access(struct bpf_verifier_env *env, u32 regno, int off,
 		return -EACCES;
 	}
 
+	env->insn_aux_data[insn_idx].ctx_field_size = info.ctx_field_size;
+
 	return 0;
 }
 
@@ -1948,7 +1951,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			verbose(env, "cannot write into socket\n");
 			return -EACCES;
 		}
-		err = check_sock_access(env, regno, off, size, t);
+		err = check_sock_access(env, insn_idx, regno, off, size, t);
 		if (!err && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
-- 
2.19.1


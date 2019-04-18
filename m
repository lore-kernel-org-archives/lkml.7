Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75709C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CA120643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611748;
	bh=e9r92e1pkkX5MwwrS1DQTiI7ltdI72Z056+3DnX8XPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pemRnt1R68c39L50Lo+/K29vesBBnCG8rqNR4o2NwLqZ+20OAxNTe5n73nIs2blTP
	 Gf381GWdRguzCis6b6GqEcObPpUDVmlXveUHywxsRL2b4LgvDiahELIRKXCQ1JgJI+
	 vMOtgaCxTjsxcC9iU9GolkjUWZtplV3OdOwcDnh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404061AbfDRSW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390731AbfDRSHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B8F21872;
        Thu, 18 Apr 2019 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610826;
        bh=e9r92e1pkkX5MwwrS1DQTiI7ltdI72Z056+3DnX8XPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yNzPNAHunaZTvFkSbwPLWSIVarXu/AaUqkJeN5i2qP2XA+n8HGl3A5GN2oLdWKFx1
         yTsn8larf5gDNlJOedt4LT4MsJk8QiDQUA3gHnOqokMQ/lYBBST6h89bzU78794cru
         R2nzT53WQBINYNac+oI/vOkpdTEI5GGdohyuCVy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 78/92] bpf: move tmp variable into ax register in interpreter
Date:   Thu, 18 Apr 2019 19:57:36 +0200
Message-Id: <20190418160437.209620696@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit 144cd91c4c2bced6eb8a7e25e590f6618a11e854 upstream.

This change moves the on-stack 64 bit tmp variable in ___bpf_prog_run()
into the hidden ax register. The latter is currently only used in JITs
for constant blinding as a temporary scratch register, meaning the BPF
interpreter will never see the use of ax. Therefore it is safe to use
it for the cases where tmp has been used earlier. This is needed to later
on allow restricted hidden use of ax in both interpreter and JITs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[backported to 4.14 sblbir]
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/filter.h |    3 ++-
 kernel/bpf/core.c      |   31 ++++++++++++++++---------------
 2 files changed, 18 insertions(+), 16 deletions(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -53,7 +53,8 @@ struct bpf_prog_aux;
  * constants. See JIT pre-step in bpf_jit_blind_constants().
  */
 #define BPF_REG_AX		MAX_BPF_REG
-#define MAX_BPF_JIT_REG		(MAX_BPF_REG + 1)
+#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
+#define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG
 
 /* unused opcode to mark special call to bpf_tail_call() helper */
 #define BPF_TAIL_CALL	0xf0
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -51,6 +51,7 @@
 #define DST	regs[insn->dst_reg]
 #define SRC	regs[insn->src_reg]
 #define FP	regs[BPF_REG_FP]
+#define AX	regs[BPF_REG_AX]
 #define ARG1	regs[BPF_REG_ARG1]
 #define CTX	regs[BPF_REG_CTX]
 #define IMM	insn->imm
@@ -939,22 +940,22 @@ select_insn:
 	ALU64_MOD_X:
 		if (unlikely(SRC == 0))
 			return 0;
-		div64_u64_rem(DST, SRC, &tmp);
-		DST = tmp;
+		div64_u64_rem(DST, SRC, &AX);
+		DST = AX;
 		CONT;
 	ALU_MOD_X:
 		if (unlikely((u32)SRC == 0))
 			return 0;
-		tmp = (u32) DST;
-		DST = do_div(tmp, (u32) SRC);
+		AX = (u32) DST;
+		DST = do_div(AX, (u32) SRC);
 		CONT;
 	ALU64_MOD_K:
-		div64_u64_rem(DST, IMM, &tmp);
-		DST = tmp;
+		div64_u64_rem(DST, IMM, &AX);
+		DST = AX;
 		CONT;
 	ALU_MOD_K:
-		tmp = (u32) DST;
-		DST = do_div(tmp, (u32) IMM);
+		AX = (u32) DST;
+		DST = do_div(AX, (u32) IMM);
 		CONT;
 	ALU64_DIV_X:
 		if (unlikely(SRC == 0))
@@ -964,17 +965,17 @@ select_insn:
 	ALU_DIV_X:
 		if (unlikely((u32)SRC == 0))
 			return 0;
-		tmp = (u32) DST;
-		do_div(tmp, (u32) SRC);
-		DST = (u32) tmp;
+		AX = (u32) DST;
+		do_div(AX, (u32) SRC);
+		DST = (u32) AX;
 		CONT;
 	ALU64_DIV_K:
 		DST = div64_u64(DST, IMM);
 		CONT;
 	ALU_DIV_K:
-		tmp = (u32) DST;
-		do_div(tmp, (u32) IMM);
-		DST = (u32) tmp;
+		AX = (u32) DST;
+		do_div(AX, (u32) IMM);
+		DST = (u32) AX;
 		CONT;
 	ALU_END_TO_BE:
 		switch (IMM) {
@@ -1278,7 +1279,7 @@ STACK_FRAME_NON_STANDARD(___bpf_prog_run
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
-	u64 regs[MAX_BPF_REG]; \
+	u64 regs[MAX_BPF_EXT_REG]; \
 \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \



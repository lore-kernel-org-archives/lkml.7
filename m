Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF07C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190062077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpDAj0fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfD0JBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:01:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45640 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0JBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:01:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so2854495pfi.12;
        Sat, 27 Apr 2019 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=yD4rnFx/DMOtG8xe7uwsgLBbomvRuA3zyALnwPA7AMY=;
        b=gpDAj0fYqwHnN5f3ZSMhq3UyjDwWzD9MKgCG7MFBS5s5kZKssLhq4wLZA4A/hzatin
         fS8MB7/npk24DgB+g0miUfRFvWXaU9AKFQA8GHblNT64hNVJya/8p2q63MRdLAw22YGC
         6T05b0ax79gDR46i+K8+Of8ZV7MlfGhzASkh2ge0XKHHrSxxN+zVjmfyCyBQAQQhwtN+
         OIi+kTm0DNTd1DJZJ0oTpaDg5GU1/xwyZdDU48mPiLdtQpjfYZTxoqHS4rURw7L5uS8Q
         5QMlymWPIPERcieFmyDFyABzdsv/7M5l4K34IB2N6AEvo2GhiiXjnMK5qnrmfb+TbzNR
         9lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=yD4rnFx/DMOtG8xe7uwsgLBbomvRuA3zyALnwPA7AMY=;
        b=NfIhUb/m7Nt9srbVJDKt+F8gmE2csTDhIrNjODiN23KwCf9RMKAbA/lZ8grpIa7gwn
         XkGXT7sf4G48iad7XilmRYOyagOFtUOLYjDp4oY9R1s7UTie3WvERYsTm7l/vEDEy6mV
         oY+cxe0rXGSrbUkaIUwJ1oz65ddyNLGeiCeX0Qn145UyFBHf5tMo2gcaIlcSQEMovDdb
         TndySxLYcUn99g8OYf2KRSotaz+nr/beOZb69a9c1ZE/1Xnie7ZrwONlhL+zumgFKGfU
         T5dG+aa8TB75O6lmvr+wvMmDZaH4I/UJh2nnDj0QxUZsUaiQcbWkqIAhOYT8RKvL0cnF
         Wx9w==
X-Gm-Message-State: APjAAAU1gJVPuFTtmtukQiWsJc6lqFE8xh57MNsK4/0Zab6Pl4bIaeMr
        zW26dJyXbbF0WYd9zUZNmlc=
X-Google-Smtp-Source: APXvYqxv8O3AXZKWtJm4EPBUEjeFk2PBon5dYpq8jq0B6zXHjXUwgeVSB4yT8HuY18DjMG8ypV4Ldg==
X-Received: by 2002:a63:6604:: with SMTP id a4mr16036662pgc.104.1556355709744;
        Sat, 27 Apr 2019 02:01:49 -0700 (PDT)
Received: from udknight.localhost ([59.57.230.163])
        by smtp.gmail.com with ESMTPSA id k5sm24674216pgi.58.2019.04.27.02.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 02:01:48 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id x3R8Sb5h016438;
        Sat, 27 Apr 2019 16:28:37 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id x3R8SQxv016424;
        Sat, 27 Apr 2019 16:28:26 +0800
Date:   Sat, 27 Apr 2019 16:28:26 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        tglx@linutronix.de, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] bpf, x32: Fix bug for BPF_JMP | {BPF_JSGT, BPF_JSLE,
 BPF_JSLT, BPF_JSGE}
Message-ID: <20190427082826.GA16311@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, tglx@linutronix.de,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current method to compare 64-bit numbers for conditional jump is:

1) Compare the high 32-bit first.

2) If the high 32-bit isn't the same, then goto step 4.

3) Compare the low 32-bit.

4) Check the desired condition.

This method is right for unsigned comparison, but it is buggy for signed
comparison, because it does signed comparison for low 32-bit too.

There is only one sign bit in 64-bit number, that is the MSB in the 64-bit
number, it is wrong to treat low 32-bit as signed number and do the signed
comparison for it.

This patch fixes the bug and adds a testcase in selftests/bpf for such bug.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes v1-v2:
 1: Add a testcase in selftests/bpf for such bug.

 arch/x86/net/bpf_jit_comp32.c              | 217 ++++++++++++++++++++++-------
 tools/testing/selftests/bpf/verifier/jit.c |  19 +++
 2 files changed, 185 insertions(+), 51 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 0d9cdff..8097b88 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -117,6 +117,8 @@ static bool is_simm32(s64 value)
 #define IA32_JLE 0x7E
 #define IA32_JG  0x7F
 
+#define COND_JMP_OPCODE_INVALID	(0xFF)
+
 /*
  * Map eBPF registers to IA32 32bit registers or stack scratch space.
  *
@@ -1613,6 +1615,75 @@ static inline void emit_push_r64(const u8 src[], u8 **pprog)
 	*pprog = prog;
 }
 
+static u8 get_cond_jmp_opcode(const u8 op, bool is_cmp_lo)
+{
+	u8 jmp_cond;
+
+	/* Convert BPF opcode to x86 */
+	switch (op) {
+	case BPF_JEQ:
+		jmp_cond = IA32_JE;
+		break;
+	case BPF_JSET:
+	case BPF_JNE:
+		jmp_cond = IA32_JNE;
+		break;
+	case BPF_JGT:
+		/* GT is unsigned '>', JA in x86 */
+		jmp_cond = IA32_JA;
+		break;
+	case BPF_JLT:
+		/* LT is unsigned '<', JB in x86 */
+		jmp_cond = IA32_JB;
+		break;
+	case BPF_JGE:
+		/* GE is unsigned '>=', JAE in x86 */
+		jmp_cond = IA32_JAE;
+		break;
+	case BPF_JLE:
+		/* LE is unsigned '<=', JBE in x86 */
+		jmp_cond = IA32_JBE;
+		break;
+	case BPF_JSGT:
+		if (!is_cmp_lo)
+			/* Signed '>', GT in x86 */
+			jmp_cond = IA32_JG;
+		else
+			/* GT is unsigned '>', JA in x86 */
+			jmp_cond = IA32_JA;
+		break;
+	case BPF_JSLT:
+		if (!is_cmp_lo)
+			/* Signed '<', LT in x86 */
+			jmp_cond = IA32_JL;
+		else
+			/* LT is unsigned '<', JB in x86 */
+			jmp_cond = IA32_JB;
+		break;
+	case BPF_JSGE:
+		if (!is_cmp_lo)
+			/* Signed '>=', GE in x86 */
+			jmp_cond = IA32_JGE;
+		else
+			/* GE is unsigned '>=', JAE in x86 */
+			jmp_cond = IA32_JAE;
+		break;
+	case BPF_JSLE:
+		if (!is_cmp_lo)
+			/* Signed '<=', LE in x86 */
+			jmp_cond = IA32_JLE;
+		else
+			/* LE is unsigned '<=', JBE in x86 */
+			jmp_cond = IA32_JBE;
+		break;
+	default: /* to silence GCC warning */
+		jmp_cond = COND_JMP_OPCODE_INVALID;
+		break;
+	}
+
+	return jmp_cond;
+}
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  int oldproglen, struct jit_context *ctx)
 {
@@ -2069,10 +2140,6 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP | BPF_JLT | BPF_X:
 		case BPF_JMP | BPF_JGE | BPF_X:
 		case BPF_JMP | BPF_JLE | BPF_X:
-		case BPF_JMP | BPF_JSGT | BPF_X:
-		case BPF_JMP | BPF_JSLE | BPF_X:
-		case BPF_JMP | BPF_JSLT | BPF_X:
-		case BPF_JMP | BPF_JSGE | BPF_X:
 		case BPF_JMP32 | BPF_JEQ | BPF_X:
 		case BPF_JMP32 | BPF_JNE | BPF_X:
 		case BPF_JMP32 | BPF_JGT | BPF_X:
@@ -2118,6 +2185,40 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			EMIT2(0x39, add_2reg(0xC0, dreg_lo, sreg_lo));
 			goto emit_cond_jmp;
 		}
+		case BPF_JMP | BPF_JSGT | BPF_X:
+		case BPF_JMP | BPF_JSLE | BPF_X:
+		case BPF_JMP | BPF_JSLT | BPF_X:
+		case BPF_JMP | BPF_JSGE | BPF_X: {
+			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
+			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
+			u8 sreg_lo = sstk ? IA32_ECX : src_lo;
+			u8 sreg_hi = sstk ? IA32_EBX : src_hi;
+
+			if (dstk) {
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
+				      STACK_VAR(dst_lo));
+				EMIT3(0x8B,
+				      add_2reg(0x40, IA32_EBP,
+					       IA32_EDX),
+				      STACK_VAR(dst_hi));
+			}
+
+			if (sstk) {
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX),
+				      STACK_VAR(src_lo));
+				EMIT3(0x8B,
+				      add_2reg(0x40, IA32_EBP,
+					       IA32_EBX),
+				      STACK_VAR(src_hi));
+			}
+
+			/* cmp dreg_hi,sreg_hi */
+			EMIT2(0x39, add_2reg(0xC0, dreg_hi, sreg_hi));
+			EMIT2(IA32_JNE, 10);
+			/* cmp dreg_lo,sreg_lo */
+			EMIT2(0x39, add_2reg(0xC0, dreg_lo, sreg_lo));
+			goto emit_cond_jmp_signed;
+		}
 		case BPF_JMP | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X: {
 			bool is_jmp64 = BPF_CLASS(insn->code) == BPF_JMP;
@@ -2194,10 +2295,6 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_JMP | BPF_JLT | BPF_K:
 		case BPF_JMP | BPF_JGE | BPF_K:
 		case BPF_JMP | BPF_JLE | BPF_K:
-		case BPF_JMP | BPF_JSGT | BPF_K:
-		case BPF_JMP | BPF_JSLE | BPF_K:
-		case BPF_JMP | BPF_JSLT | BPF_K:
-		case BPF_JMP | BPF_JSGE | BPF_K:
 		case BPF_JMP32 | BPF_JEQ | BPF_K:
 		case BPF_JMP32 | BPF_JNE | BPF_K:
 		case BPF_JMP32 | BPF_JGT | BPF_K:
@@ -2238,50 +2335,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			/* cmp dreg_lo,sreg_lo */
 			EMIT2(0x39, add_2reg(0xC0, dreg_lo, sreg_lo));
 
-emit_cond_jmp:		/* Convert BPF opcode to x86 */
-			switch (BPF_OP(code)) {
-			case BPF_JEQ:
-				jmp_cond = IA32_JE;
-				break;
-			case BPF_JSET:
-			case BPF_JNE:
-				jmp_cond = IA32_JNE;
-				break;
-			case BPF_JGT:
-				/* GT is unsigned '>', JA in x86 */
-				jmp_cond = IA32_JA;
-				break;
-			case BPF_JLT:
-				/* LT is unsigned '<', JB in x86 */
-				jmp_cond = IA32_JB;
-				break;
-			case BPF_JGE:
-				/* GE is unsigned '>=', JAE in x86 */
-				jmp_cond = IA32_JAE;
-				break;
-			case BPF_JLE:
-				/* LE is unsigned '<=', JBE in x86 */
-				jmp_cond = IA32_JBE;
-				break;
-			case BPF_JSGT:
-				/* Signed '>', GT in x86 */
-				jmp_cond = IA32_JG;
-				break;
-			case BPF_JSLT:
-				/* Signed '<', LT in x86 */
-				jmp_cond = IA32_JL;
-				break;
-			case BPF_JSGE:
-				/* Signed '>=', GE in x86 */
-				jmp_cond = IA32_JGE;
-				break;
-			case BPF_JSLE:
-				/* Signed '<=', LE in x86 */
-				jmp_cond = IA32_JLE;
-				break;
-			default: /* to silence GCC warning */
+emit_cond_jmp:		jmp_cond = get_cond_jmp_opcode(BPF_OP(code), false);
+			if (jmp_cond == COND_JMP_OPCODE_INVALID)
 				return -EFAULT;
-			}
 			jmp_offset = addrs[i + insn->off] - addrs[i];
 			if (is_imm8(jmp_offset)) {
 				EMIT2(jmp_cond, jmp_offset);
@@ -2291,7 +2347,66 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 				pr_err("cond_jmp gen bug %llx\n", jmp_offset);
 				return -EFAULT;
 			}
+			break;
+		}
+		case BPF_JMP | BPF_JSGT | BPF_K:
+		case BPF_JMP | BPF_JSLE | BPF_K:
+		case BPF_JMP | BPF_JSLT | BPF_K:
+		case BPF_JMP | BPF_JSGE | BPF_K: {
+			u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
+			u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
+			u8 sreg_lo = IA32_ECX;
+			u8 sreg_hi = IA32_EBX;
+			u32 hi;
+
+			if (dstk) {
+				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
+				      STACK_VAR(dst_lo));
+				EMIT3(0x8B,
+				      add_2reg(0x40, IA32_EBP,
+					       IA32_EDX),
+				      STACK_VAR(dst_hi));
+			}
+
+			/* mov ecx,imm32 */
+			EMIT2_off32(0xC7, add_1reg(0xC0, IA32_ECX), imm32);
+			hi = imm32 & (1 << 31) ? (u32)~0 : 0;
+			/* mov ebx,imm32 */
+			EMIT2_off32(0xC7, add_1reg(0xC0, IA32_EBX), hi);
+			/* cmp dreg_hi,sreg_hi */
+			EMIT2(0x39, add_2reg(0xC0, dreg_hi, sreg_hi));
+			EMIT2(IA32_JNE, 10);
+			/* cmp dreg_lo,sreg_lo */
+			EMIT2(0x39, add_2reg(0xC0, dreg_lo, sreg_lo));
+
+			/*
+			 * For simplicity of branch offset computation,
+			 * let's use fixed jump coding here.
+			 */
+emit_cond_jmp_signed:	/* Check the condition for low 32-bit comparison */
+			jmp_cond = get_cond_jmp_opcode(BPF_OP(code), true);
+			if (jmp_cond == COND_JMP_OPCODE_INVALID)
+				return -EFAULT;
+			jmp_offset = addrs[i + insn->off] - addrs[i] + 8;
+			if (is_simm32(jmp_offset)) {
+				EMIT2_off32(0x0F, jmp_cond + 0x10, jmp_offset);
+			} else {
+				pr_err("cond_jmp gen bug %llx\n", jmp_offset);
+				return -EFAULT;
+			}
+			EMIT2(0xEB, 6);
 
+			/* Check the condition for high 32-bit comparison */
+			jmp_cond = get_cond_jmp_opcode(BPF_OP(code), false);
+			if (jmp_cond == COND_JMP_OPCODE_INVALID)
+				return -EFAULT;
+			jmp_offset = addrs[i + insn->off] - addrs[i];
+			if (is_simm32(jmp_offset)) {
+				EMIT2_off32(0x0F, jmp_cond + 0x10, jmp_offset);
+			} else {
+				pr_err("cond_jmp gen bug %llx\n", jmp_offset);
+				return -EFAULT;
+			}
 			break;
 		}
 		case BPF_JMP | BPF_JA:
diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/selftests/bpf/verifier/jit.c
index be488b4..c33adf3 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -86,3 +86,22 @@
 	.result = ACCEPT,
 	.retval = 2,
 },
+{
+	"jit: jsgt, jslt",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_1, 0x80000000ULL),
+	BPF_LD_IMM64(BPF_REG_2, 0x0ULL),
+	BPF_JMP_REG(BPF_JSGT, BPF_REG_1, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+
+	BPF_JMP_REG(BPF_JSLT, BPF_REG_2, BPF_REG_1, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 2,
+},
-- 
1.8.5.6.2.g3d8a54e.dirty

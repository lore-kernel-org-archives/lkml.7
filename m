Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C842C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F13521883
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595923;
	bh=7kDSAc59HdI6R/TGpYI2fRcgODx/+Aont/R0HfS8mG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GYCYJxs8GJUai7sSgEL5IFvz93BinZ23syjDk6ufSUvHbuTz77vX3nWITmShQLTFA
	 w30Wsb1a7lmmW0TZ/rdXiIgPsYs4w4/MtTIJGEKjkCGiYXK3s/MQhQIQR7a8LOCnqs
	 VgvKB2md6dAIlgVXgP8Xd8TOnExr557cxnv/AwBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfF0Aim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfF0Aij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:38:39 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C0B21852;
        Thu, 27 Jun 2019 00:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595918;
        bh=7kDSAc59HdI6R/TGpYI2fRcgODx/+Aont/R0HfS8mG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JkjobWqczr7RQZB25qDE79RtpPaRTqp4Yvh7nH8IWcPqbpZRYf8VIWmovba7TcnMP
         ++yAIDfHhdFMeesT+UpjqDV4Ni7kjC48TYnVLf8aOushh1XgIv05lj4S6zHOf6omhG
         7dBFZNeUChcqnOW3am+QRM1mYYbjyNxkppk5+v/Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/60] bpf, x64: fix stack layout of JITed bpf code
Date:   Wed, 26 Jun 2019 20:36:00 -0400
Message-Id: <20190627003616.20767-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit fe8d9571dc50232b569242fac7ea6332a654f186 ]

Since commit 177366bf7ceb the %rbp stopped pointing to %rbp of the
previous stack frame. That broke frame pointer based stack unwinding.
This commit is a partial revert of it.
Note that the location of tail_call_cnt is fixed, since the verifier
enforces MAX_BPF_STACK stack size for programs with tail calls.

Fixes: 177366bf7ceb ("bpf: change x86 JITed program stack layout")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 74 +++++++++++--------------------------
 1 file changed, 21 insertions(+), 53 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2580cd2e98b1..a32fc3d99407 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -190,9 +190,7 @@ struct jit_context {
 #define BPF_MAX_INSN_SIZE	128
 #define BPF_INSN_SAFETY		64
 
-#define AUX_STACK_SPACE		40 /* Space for RBX, R13, R14, R15, tailcnt */
-
-#define PROLOGUE_SIZE		37
+#define PROLOGUE_SIZE		20
 
 /*
  * Emit x86-64 prologue code for BPF program and check its size.
@@ -203,44 +201,19 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf)
 	u8 *prog = *pprog;
 	int cnt = 0;
 
-	/* push rbp */
-	EMIT1(0x55);
-
-	/* mov rbp,rsp */
-	EMIT3(0x48, 0x89, 0xE5);
-
-	/* sub rsp, rounded_stack_depth + AUX_STACK_SPACE */
-	EMIT3_off32(0x48, 0x81, 0xEC,
-		    round_up(stack_depth, 8) + AUX_STACK_SPACE);
-
-	/* sub rbp, AUX_STACK_SPACE */
-	EMIT4(0x48, 0x83, 0xED, AUX_STACK_SPACE);
-
-	/* mov qword ptr [rbp+0],rbx */
-	EMIT4(0x48, 0x89, 0x5D, 0);
-	/* mov qword ptr [rbp+8],r13 */
-	EMIT4(0x4C, 0x89, 0x6D, 8);
-	/* mov qword ptr [rbp+16],r14 */
-	EMIT4(0x4C, 0x89, 0x75, 16);
-	/* mov qword ptr [rbp+24],r15 */
-	EMIT4(0x4C, 0x89, 0x7D, 24);
-
+	EMIT1(0x55);             /* push rbp */
+	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
+	/* sub rsp, rounded_stack_depth */
+	EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
+	EMIT1(0x53);             /* push rbx */
+	EMIT2(0x41, 0x55);       /* push r13 */
+	EMIT2(0x41, 0x56);       /* push r14 */
+	EMIT2(0x41, 0x57);       /* push r15 */
 	if (!ebpf_from_cbpf) {
-		/*
-		 * Clear the tail call counter (tail_call_cnt): for eBPF tail
-		 * calls we need to reset the counter to 0. It's done in two
-		 * instructions, resetting RAX register to 0, and moving it
-		 * to the counter location.
-		 */
-
-		/* xor eax, eax */
-		EMIT2(0x31, 0xc0);
-		/* mov qword ptr [rbp+32], rax */
-		EMIT4(0x48, 0x89, 0x45, 32);
-
+		/* zero init tail_call_cnt */
+		EMIT2(0x6a, 0x00);
 		BUILD_BUG_ON(cnt != PROLOGUE_SIZE);
 	}
-
 	*pprog = prog;
 }
 
@@ -285,13 +258,13 @@ static void emit_bpf_tail_call(u8 **pprog)
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, 36);              /* mov eax, dword ptr [rbp + 36] */
+	EMIT2_off32(0x8B, 0x85, -36 - MAX_BPF_STACK); /* mov eax, dword ptr [rbp - 548] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
 #define OFFSET2 (30 + RETPOLINE_RAX_BPF_JIT_SIZE)
 	EMIT2(X86_JA, OFFSET2);                   /* ja out */
 	label2 = cnt;
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, 36);              /* mov dword ptr [rbp + 36], eax */
+	EMIT2_off32(0x89, 0x85, -36 - MAX_BPF_STACK); /* mov dword ptr [rbp -548], eax */
 
 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x84, 0xD6,       /* mov rax, [rsi + rdx * 8 + offsetof(...)] */
@@ -1006,19 +979,14 @@ xadd:			if (is_imm8(insn->off))
 			seen_exit = true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
-			/* mov rbx, qword ptr [rbp+0] */
-			EMIT4(0x48, 0x8B, 0x5D, 0);
-			/* mov r13, qword ptr [rbp+8] */
-			EMIT4(0x4C, 0x8B, 0x6D, 8);
-			/* mov r14, qword ptr [rbp+16] */
-			EMIT4(0x4C, 0x8B, 0x75, 16);
-			/* mov r15, qword ptr [rbp+24] */
-			EMIT4(0x4C, 0x8B, 0x7D, 24);
-
-			/* add rbp, AUX_STACK_SPACE */
-			EMIT4(0x48, 0x83, 0xC5, AUX_STACK_SPACE);
-			EMIT1(0xC9); /* leave */
-			EMIT1(0xC3); /* ret */
+			if (!bpf_prog_was_classic(bpf_prog))
+				EMIT1(0x5B); /* get rid of tail_call_cnt */
+			EMIT2(0x41, 0x5F);   /* pop r15 */
+			EMIT2(0x41, 0x5E);   /* pop r14 */
+			EMIT2(0x41, 0x5D);   /* pop r13 */
+			EMIT1(0x5B);         /* pop rbx */
+			EMIT1(0xC9);         /* leave */
+			EMIT1(0xC3);         /* ret */
 			break;
 
 		default:
-- 
2.20.1


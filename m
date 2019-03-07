Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83C020835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XoNlLWyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCGLxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfCGLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MN+4GgQMDDxyGONGNWZ07gx1B4H4yQAhjpCmnwAvjn4=; b=XoNlLWyg0fqqMXr49QeNAqXWPo
        8UoSK8rBS28iWzamRyiOu8iaLaBnqVGr3gjgRQRIaKQtAP+4djz9YCUtCiLGEc/T5qND7nHpsx5q8
        hVemdUdLbMFQfXwJqC6PSnN81GSPhdyg26NIOXzg2iu1gVBAzdF7vCOPiP/ege/5JP/G0VaXPQwyr
        LDPq0MqahL2n8N+LUinf09Eo4eLeQqusLyMsmoTDUyiHuR8kaOACnvkEIJL+cdzjxniTJElWDQr63
        ecPEsmOWZg27wbY7DFTZdCUCbd6HV8INA8GSK+5k4rJ1c4qQMJn8mykyu7VYgdsB/XiEjJ9aa+j1i
        eS/tPwdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZo-0005Pr-S7; Thu, 07 Mar 2019 11:52:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E2EA82029108E; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115200.784815194@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 19/20] objtool: uaccess PUSHF/POPF support
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PUSHF / POPF state.uaccess restore logic.

XXX: should possibly be merged with the previous patch such that KASAN
doesn't explode in between. Split for review.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch.h            |    2 ++
 tools/objtool/arch/x86/decode.c |    4 ++--
 tools/objtool/check.c           |   30 ++++++++++++++++++++++++++----
 tools/objtool/check.h           |    1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -43,6 +43,7 @@ enum op_dest_type {
 	OP_DEST_REG_INDIRECT,
 	OP_DEST_MEM,
 	OP_DEST_PUSH,
+	OP_DEST_PUSHF,
 	OP_DEST_LEAVE,
 };
 
@@ -57,6 +58,7 @@ enum op_src_type {
 	OP_SRC_REG_INDIRECT,
 	OP_SRC_CONST,
 	OP_SRC_POP,
+	OP_SRC_POPF,
 	OP_SRC_ADD,
 	OP_SRC_AND,
 };
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -357,13 +357,13 @@ int arch_decode_instruction(struct elf *
 		/* pushf */
 		*type = INSN_STACK;
 		op->src.type = OP_SRC_CONST;
-		op->dest.type = OP_DEST_PUSH;
+		op->dest.type = OP_DEST_PUSHF;
 		break;
 
 	case 0x9d:
 		/* popf */
 		*type = INSN_STACK;
-		op->src.type = OP_SRC_POP;
+		op->src.type = OP_SRC_POPF;
 		op->dest.type = OP_DEST_MEM;
 		break;
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1392,11 +1392,11 @@ static int update_insn_state_regs(struct
 		return 0;
 
 	/* push */
-	if (op->dest.type == OP_DEST_PUSH)
+	if (op->dest.type == OP_DEST_PUSH || op->dest.type == OP_DEST_PUSHF)
 		cfa->offset += 8;
 
 	/* pop */
-	if (op->src.type == OP_SRC_POP)
+	if (op->src.type == OP_SRC_POP || op->src.type == OP_SRC_POPF)
 		cfa->offset -= 8;
 
 	/* add immediate to sp */
@@ -1653,6 +1653,7 @@ static int update_insn_state(struct inst
 			break;
 
 		case OP_SRC_POP:
+		case OP_SRC_POPF:
 			if (!state->drap && op->dest.type == OP_DEST_REG &&
 			    op->dest.reg == cfa->base) {
 
@@ -1717,6 +1718,7 @@ static int update_insn_state(struct inst
 		break;
 
 	case OP_DEST_PUSH:
+	case OP_DEST_PUSHF:
 		state->stack_size += 8;
 		if (cfa->base == CFI_SP)
 			cfa->offset += 8;
@@ -1807,7 +1809,7 @@ static int update_insn_state(struct inst
 		break;
 
 	case OP_DEST_MEM:
-		if (op->src.type != OP_SRC_POP) {
+		if (op->src.type != OP_SRC_POP && op->src.type != OP_SRC_POPF) {
 			WARN_FUNC("unknown stack-related memory operation",
 				  insn->sec, insn->offset);
 			return -1;
@@ -2109,6 +2111,26 @@ static int validate_branch(struct objtoo
 			if (update_insn_state(insn, &state))
 				return 1;
 
+			if (insn->stack_op.dest.type == OP_DEST_PUSHF) {
+				if (!state.uaccess_stack) {
+					state.uaccess_stack = 1;
+				} else if (state.uaccess_stack >> 31) {
+					WARN_FUNC("PUSHF stack exhausted", sec, insn->offset);
+					return 1;
+				}
+				state.uaccess_stack <<= 1;
+				state.uaccess_stack  |= state.uaccess;
+			}
+
+			if (insn->stack_op.src.type == OP_SRC_POPF) {
+				if (state.uaccess_stack) {
+					state.uaccess = state.uaccess_stack & 1;
+					state.uaccess_stack >>= 1;
+					if (state.uaccess_stack == 1)
+						state.uaccess_stack = 0;
+				}
+			}
+
 			break;
 
 		case INSN_STAC:
@@ -2126,7 +2148,7 @@ static int validate_branch(struct objtoo
 				return 1;
 			}
 
-			if (func_uaccess_safe(func)) {
+			if (func_uaccess_safe(func) && !state.uaccess_stack) {
 				WARN_FUNC("UACCESS-safe disables UACCESS", sec, insn->offset);
 				return 1;
 			}
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -32,6 +32,7 @@ struct insn_state {
 	unsigned char type;
 	bool bp_scratch;
 	bool drap, end, uaccess;
+	unsigned int uaccess_stack;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };



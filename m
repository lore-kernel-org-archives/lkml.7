Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA128C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A857E20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VsevZUf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfCGLxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51022 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCGLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mi5Ej+aTnOoeiJILF2SATJh0HnXtCp2uAt/0gTezSZY=; b=VsevZUf/DfXP60N8osQxXI5oAc
        hwBon6QGmqhc5Nc6T5XSzxxOsZIlKxtugJXSd1ri0XnjwpFjM9TYlEj1eAD/hs9Igd7izD9XiSfLN
        D7NqMNoDSm6/EGVP5wHvGRi5S7AHTlhUu2gYA0rVLqB7kijgwc8BEy0ka2QuiLy04rLW8GgBr62yU
        YC90ZE6X21pJeHkzVJxwtCOyIjqPua1bQCk5WePFOrn9VxZF1na7ry4rOx6JZRm9wk64vbGiBilFg
        f93VJ3D74ikFcXTqyhUjCVKwz/jQMzC+x9Iq9kHbP3ToVf8+HY2jp/Bi+ceMkn4WYCOOH5R/EtK3j
        HNNqdZbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZo-0005Ps-Ty; Thu, 07 Mar 2019 11:52:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E7DE22029108F; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115200.878625203@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 20/20] objtool: Add Direction Flag validation
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having DF escape is BAD(tm).

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch.h            |    4 +++-
 tools/objtool/arch/x86/decode.c |    8 ++++++++
 tools/objtool/check.c           |   25 +++++++++++++++++++++++++
 tools/objtool/check.h           |    2 +-
 4 files changed, 37 insertions(+), 2 deletions(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -35,7 +35,9 @@
 #define INSN_NOP		10
 #define INSN_STAC		11
 #define INSN_CLAC		12
-#define INSN_OTHER		13
+#define INSN_STD		13
+#define INSN_CLD		14
+#define INSN_OTHER		15
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -456,6 +456,14 @@ int arch_decode_instruction(struct elf *
 		*type = INSN_CALL;
 		break;
 
+	case 0xfc:
+		*type = INSN_CLD;
+		break;
+
+	case 0xfd:
+		*type = INSN_STD;
+		break;
+
 	case 0xff:
 		if (modrm_reg == 2 || modrm_reg == 3)
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2020,6 +2020,11 @@ static int validate_branch(struct objtoo
 				return 1;
 			}
 
+			if (state.df) {
+				WARN_FUNC("return with DF set", sec, insn->offset);
+				return 1;
+			}
+
 			if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
@@ -2043,6 +2048,12 @@ static int validate_branch(struct objtoo
 				return 1;
 			}
 
+			if (state.df) {
+				WARN_FUNC("call to %s() with DF set",
+					  sec, insn->offset, insn_dest_name(insn));
+				return 1;
+			}
+
 			if (insn->type == INSN_JUMP_UNCONDITIONAL ||
 			    insn->type == INSN_JUMP_DYNAMIC)
 				return 0;
@@ -2160,6 +2171,20 @@ static int validate_branch(struct objtoo
 			state.uaccess = false;
 			break;
 
+		case INSN_STD:
+			if (state.df)
+				WARN_FUNC("recursive STD", sec, insn->offset);
+
+			state.df = true;
+			break;
+
+		case INSN_CLD:
+			if (!state.df && insn->func)
+				WARN_FUNC("redundant CLD", sec, insn->offset);
+
+			state.df = false;
+			break;
+
 		default:
 			break;
 		}
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end, uaccess;
+	bool drap, end, uaccess, df;
 	unsigned int uaccess_stack;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];



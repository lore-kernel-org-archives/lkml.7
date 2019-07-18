Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07CBC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA4A2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R9ETAx8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391370AbfGRTWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:22:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391349AbfGRTWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:22:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJMIaK2126395
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:22:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJMIaK2126395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477739;
        bh=25VcJ1Dt0l2/VCsx/Ds7GuEHA0Z3O8CBESqu3eQxZFs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=R9ETAx8vmHh/L4o+NjGikRmyS79l6+73HfiYTVCMxbzVLog9bXN7C+fKkrF3tsfV1
         bhfMEDMCMTIBklTaAagX6PfEbcvj6wNrs6ax2ynmmRT3HBbkgTWQZmyVIb6MViQDf3
         QKru7sN6q762i+tqlf3GkFmO1CmlTVzo3A25IjrbC8SQnTt1a+/oo2cxw9TZjD8/2N
         zcPqA3UpsET7iJePpC/7VggSFds0TVIEBcYqSE1R5RD4qUnD2aHTDdL/YEO4JMXM5N
         HzuhU7srU/n0QwRZDAe1DilM1cRmovLddZB0EaP8xzo8adRGOa3QHI5Bs3yKgUFami
         mG09HGGzvqiJg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJMIFP2126387;
        Thu, 18 Jul 2019 12:22:18 -0700
Date:   Thu, 18 Jul 2019 12:22:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-9fe7b7642fe2c5158904d06fe31b740ca0695a01@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tglx@linutronix.de, ndesaulniers@google.com,
        mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          mingo@kernel.org, hpa@zytor.com, ndesaulniers@google.com
In-Reply-To: <0740e96af0d40e54cfd6a07bf09db0fbd10793cd.1563413318.git.jpoimboe@redhat.com>
References: <0740e96af0d40e54cfd6a07bf09db0fbd10793cd.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Convert insn type to enum
Git-Commit-ID: 9fe7b7642fe2c5158904d06fe31b740ca0695a01
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9fe7b7642fe2c5158904d06fe31b740ca0695a01
Gitweb:     https://git.kernel.org/tip/9fe7b7642fe2c5158904d06fe31b740ca0695a01
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:56 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:10 +0200

objtool: Convert insn type to enum

This makes it easier to add new instruction types.  Also it's hopefully
more robust since the compiler should warn about out-of-range enums.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/0740e96af0d40e54cfd6a07bf09db0fbd10793cd.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/arch.h            | 35 ++++++++++++++++++-----------------
 tools/objtool/arch/x86/decode.c |  2 +-
 tools/objtool/check.c           |  7 -------
 tools/objtool/check.h           |  2 +-
 4 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 580e344db3dd..50448c0c4bca 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -11,22 +11,23 @@
 #include "elf.h"
 #include "cfi.h"
 
-#define INSN_JUMP_CONDITIONAL	1
-#define INSN_JUMP_UNCONDITIONAL	2
-#define INSN_JUMP_DYNAMIC	3
-#define INSN_CALL		4
-#define INSN_CALL_DYNAMIC	5
-#define INSN_RETURN		6
-#define INSN_CONTEXT_SWITCH	7
-#define INSN_STACK		8
-#define INSN_BUG		9
-#define INSN_NOP		10
-#define INSN_STAC		11
-#define INSN_CLAC		12
-#define INSN_STD		13
-#define INSN_CLD		14
-#define INSN_OTHER		15
-#define INSN_LAST		INSN_OTHER
+enum insn_type {
+	INSN_JUMP_CONDITIONAL,
+	INSN_JUMP_UNCONDITIONAL,
+	INSN_JUMP_DYNAMIC,
+	INSN_CALL,
+	INSN_CALL_DYNAMIC,
+	INSN_RETURN,
+	INSN_CONTEXT_SWITCH,
+	INSN_STACK,
+	INSN_BUG,
+	INSN_NOP,
+	INSN_STAC,
+	INSN_CLAC,
+	INSN_STD,
+	INSN_CLD,
+	INSN_OTHER,
+};
 
 enum op_dest_type {
 	OP_DEST_REG,
@@ -68,7 +69,7 @@ void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, unsigned char *type,
+			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate, struct stack_op *op);
 
 bool arch_callee_saved_reg(unsigned char reg);
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 584568f27a83..0567c47a91b1 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -68,7 +68,7 @@ bool arch_callee_saved_reg(unsigned char reg)
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, unsigned char *type,
+			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate, struct stack_op *op)
 {
 	struct insn insn;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a966b22a32ef..04572a049cfc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -267,13 +267,6 @@ static int decode_instructions(struct objtool_file *file)
 			if (ret)
 				goto err;
 
-			if (!insn->type || insn->type > INSN_LAST) {
-				WARN_FUNC("invalid instruction type %d",
-					  insn->sec, insn->offset, insn->type);
-				ret = -1;
-				goto err;
-			}
-
 			hash_add(file->insn_hash, &insn->hash, insn->offset);
 			list_add_tail(&insn->list, &file->insn_list);
 		}
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index afa6a79e0715..b881fafcf55d 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct instruction {
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
-	unsigned char type;
+	enum insn_type type;
 	unsigned long immediate;
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
 	bool retpoline_safe;

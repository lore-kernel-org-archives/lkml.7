Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868DCC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A33217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbfGRBhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:37:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbfGRBhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4349E3D95A;
        Thu, 18 Jul 2019 01:37:37 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CE6F5D9CC;
        Thu, 18 Jul 2019 01:37:36 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 21/22] objtool: convert insn type to enum
Date:   Wed, 17 Jul 2019 20:36:56 -0500
Message-Id: <0740e96af0d40e54cfd6a07bf09db0fbd10793cd.1563413318.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563413318.git.jpoimboe@redhat.com>
References: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 18 Jul 2019 01:37:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easier to add new instruction types.  Also it's hopefully
more robust since the compiler should warn about out-of-range enums.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/objtool/arch.h            | 35 +++++++++++++++++----------------
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
index 082ede40c6c0..381e36dc587c 100644
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
-- 
2.20.1


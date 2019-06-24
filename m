Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FDCC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883C320679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfFXJ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:57:15 -0400
Received: from foss.arm.com ([217.140.110.172]:44918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfFXJ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA46D106F;
        Mon, 24 Jun 2019 02:56:20 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C54A3F71E;
        Mon, 24 Jun 2019 02:56:19 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC V3 07/18] objtool: Introduce INSN_UNKNOWN type
Date:   Mon, 24 Jun 2019 10:55:37 +0100
Message-Id: <20190624095548.8578-8-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624095548.8578-1-raphael.gault@arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 some object files contain data stored in the .text section.
This data is interpreted by objtool as instruction but can't be
identified as a valid one. In order to keep analysing those files we
introduce INSN_UNKNOWN type. The "unknown instruction" warning will thus
only be raised if such instructions are uncountered while validating an
execution branch.

This change doesn't impact the x86 decoding logic since 0 is still used
as a way to specify an unknown type, raising the "unknown instruction"
warning during the decoding phase still.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch.h                           |  3 ++-
 tools/objtool/arch/arm64/decode.c              |  8 ++++----
 tools/objtool/arch/arm64/include/insn_decode.h |  4 ++--
 tools/objtool/check.c                          | 10 +++++++++-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 723600aae13f..f3f94e2a1403 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -26,7 +26,8 @@
 #define INSN_CLAC		12
 #define INSN_STD		13
 #define INSN_CLD		14
-#define INSN_OTHER		15
+#define INSN_UNKNOWN		15
+#define INSN_OTHER		16
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 5be1d87b1a1c..a40338a895f5 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -37,9 +37,9 @@
  */
 static arm_decode_class aarch64_insn_class_decode_table[] = {
 	[INSN_RESERVED]			= arm_decode_reserved,
-	[INSN_UNKNOWN]			= arm_decode_unknown,
+	[INSN_UNALLOC_1]		= arm_decode_unknown,
 	[INSN_SVE_ENC]			= arm_decode_sve_encoding,
-	[INSN_UNALLOC]			= arm_decode_unknown,
+	[INSN_UNALLOC_2]		= arm_decode_unknown,
 	[INSN_LD_ST_4]			= arm_decode_ld_st,
 	[INSN_DP_REG_5]			= arm_decode_dp_reg,
 	[INSN_LD_ST_6]			= arm_decode_ld_st,
@@ -191,7 +191,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 int arm_decode_unknown(u32 instr, unsigned char *type,
 		       unsigned long *immediate, struct stack_op *op)
 {
-	*type = 0;
+	*type = INSN_UNKNOWN;
 	return 0;
 }
 
@@ -206,7 +206,7 @@ int arm_decode_reserved(u32 instr, unsigned char *type,
 			unsigned long *immediate, struct stack_op *op)
 {
 	*immediate = instr & ONES(16);
-	*type = INSN_BUG;
+	*type = INSN_UNKNOWN;
 	return 0;
 }
 
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index eb54fc39dca5..a01d76306749 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -20,9 +20,9 @@
 #include "../../../arch.h"
 
 #define INSN_RESERVED	0b0000
-#define INSN_UNKNOWN	0b0001
+#define INSN_UNALLOC_1	0b0001
 #define INSN_SVE_ENC	0b0010
-#define INSN_UNALLOC	0b0011
+#define INSN_UNALLOC_2	0b0011
 #define INSN_DP_IMM	0b1001	//0x100x
 #define INSN_BRANCH	0b1011	//0x101x
 #define INSN_LD_ST_4	0b0100	//0bx1x0
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3172f49c3a58..cba1d91451cc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1952,6 +1952,13 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
+		if (insn->type == INSN_UNKNOWN) {
+			WARN("%s+0x%lx unknown instruction type, should never be reached",
+			     insn->sec->name,
+			     insn->offset);
+			return 1;
+		}
+
 		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
@@ -2383,7 +2390,8 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		return 0;
 
 	for_each_insn(file, insn) {
-		if (insn->visited || ignore_unreachable_insn(insn))
+		if (insn->visited || ignore_unreachable_insn(insn) ||
+		    insn->type == INSN_UNKNOWN)
 			continue;
 
 		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
-- 
2.17.1


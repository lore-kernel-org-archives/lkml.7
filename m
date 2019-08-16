Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7353BC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137320644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfHPMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:25:36 -0400
Received: from foss.arm.com ([217.140.110.172]:55828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfHPMYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:24:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC81360;
        Fri, 16 Aug 2019 05:24:51 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 346983F706;
        Fri, 16 Aug 2019 05:24:50 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC v4 08/18] objtool: Refactor switch-tables code to support other architectures
Date:   Fri, 16 Aug 2019 13:23:53 +0100
Message-Id: <20190816122403.14994-9-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way to identify switch-tables and retrieves all the data necessary
to handle the different execution branches is not the same on all
architecture. In order to be able to add other architecture support,
this patch defines arch-dependent functions to process jump-tables.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch/arm64/arch_special.c | 15 ++++
 tools/objtool/arch/arm64/decode.c       |  4 +-
 tools/objtool/arch/x86/arch_special.c   | 79 ++++++++++++++++++++
 tools/objtool/check.c                   | 95 +------------------------
 tools/objtool/check.h                   |  7 ++
 tools/objtool/special.h                 | 10 ++-
 6 files changed, 114 insertions(+), 96 deletions(-)

diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
index a21d28876317..17a8a06aac2a 100644
--- a/tools/objtool/arch/arm64/arch_special.c
+++ b/tools/objtool/arch/arm64/arch_special.c
@@ -20,3 +20,18 @@ void arch_force_alt_path(unsigned short feature,
 			 struct special_alt *alt)
 {
 }
+
+int arch_add_jump_table(struct objtool_file *file, struct instruction *insn,
+			struct rela *table, struct rela *next_table)
+{
+	return 0;
+}
+
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				  struct rela *text_rela,
+				  struct section *rodata_sec,
+				  unsigned long table_offset)
+{
+	file->ignore_unreachables = true;
+	return NULL;
+}
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 4cb9402d6fe1..a20725c1bfd7 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -159,7 +159,7 @@ static int is_arm64(struct elf *elf)
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, unsigned char *type,
+			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate, struct stack_op *op)
 {
 	int arm64 = 0;
@@ -184,7 +184,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	insn = *(u32 *)(sec->data->d_buf + offset);
 
 	//dispatch according to encoding classes
-	return aarch64_insn_class_decode_table[(insn >> 25) & 0xf](insn, type,
+	return aarch64_insn_class_decode_table[(insn >> 25) & 0xf](insn, (unsigned char *)type,
 							immediate, op);
 }
 
diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
index 6583a1770bb2..c097001d805b 100644
--- a/tools/objtool/arch/x86/arch_special.c
+++ b/tools/objtool/arch/x86/arch_special.c
@@ -26,3 +26,82 @@ void arch_force_alt_path(unsigned short feature,
 				alt->skip_alt = true;
 		}
 }
+
+int arch_add_jump_table(struct objtool_file *file, struct instruction *insn,
+			struct rela *table, struct rela *next_table)
+{
+	struct rela *rela = table;
+	struct instruction *dest_insn;
+	struct alternative *alt;
+	struct symbol *pfunc = insn->func->pfunc;
+	unsigned int prev_offset = 0;
+
+	/*
+	 * Each @rela is a switch table relocation which points to the target
+	 * instruction.
+	 */
+	list_for_each_entry_from(rela, &table->sec->rela_list, list) {
+
+		/* Check for the end of the table: */
+		if (rela != table && rela->jump_table_start)
+			break;
+
+		/* Make sure the table entries are consecutive: */
+		if (prev_offset && rela->offset != prev_offset + 8)
+			break;
+
+		/* Detect function pointers from contiguous objects: */
+		if (rela->sym->sec == pfunc->sec &&
+		    rela->addend == pfunc->offset)
+			break;
+
+		dest_insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!dest_insn)
+			break;
+
+		/* Make sure the destination is in the same function: */
+		if (!dest_insn->func || dest_insn->func->pfunc != pfunc)
+			break;
+
+		alt = malloc(sizeof(*alt));
+		if (!alt) {
+			WARN("malloc failed");
+			return -1;
+		}
+
+		alt->insn = dest_insn;
+		list_add_tail(&alt->list, &insn->alts);
+		prev_offset = rela->offset;
+	}
+
+	if (!prev_offset) {
+		WARN_FUNC("can't find switch jump table",
+			  insn->sec, insn->offset);
+		return -1;
+	}
+
+	return 0;
+}
+
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				  struct rela *text_rela,
+				  struct section *rodata_sec,
+				  unsigned long table_offset)
+{
+	struct rela *rodata_rela;
+
+	rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
+	if (rodata_rela) {
+		/*
+		 * Use of RIP-relative switch jumps is quite rare, and
+		 * indicates a rare GCC quirk/bug which can leave dead
+		 * code behind.
+		 */
+		if (text_rela->type == R_X86_64_PC32)
+			file->ignore_unreachables = true;
+
+		return rodata_rela;
+	}
+
+	return NULL;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index baa6a93f37cd..18f7fb47392a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -20,12 +20,6 @@
 
 #define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
 
-struct alternative {
-	struct list_head list;
-	struct instruction *insn;
-	bool skip_orig;
-};
-
 const char *objname;
 struct cfi_state initial_func_cfi;
 
@@ -901,62 +895,6 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
-static int add_jump_table(struct objtool_file *file, struct instruction *insn,
-			    struct rela *table)
-{
-	struct rela *rela = table;
-	struct instruction *dest_insn;
-	struct alternative *alt;
-	struct symbol *pfunc = insn->func->pfunc;
-	unsigned int prev_offset = 0;
-
-	/*
-	 * Each @rela is a switch table relocation which points to the target
-	 * instruction.
-	 */
-	list_for_each_entry_from(rela, &table->sec->rela_list, list) {
-
-		/* Check for the end of the table: */
-		if (rela != table && rela->jump_table_start)
-			break;
-
-		/* Make sure the table entries are consecutive: */
-		if (prev_offset && rela->offset != prev_offset + 8)
-			break;
-
-		/* Detect function pointers from contiguous objects: */
-		if (rela->sym->sec == pfunc->sec &&
-		    rela->addend == pfunc->offset)
-			break;
-
-		dest_insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!dest_insn)
-			break;
-
-		/* Make sure the destination is in the same function: */
-		if (!dest_insn->func || dest_insn->func->pfunc != pfunc)
-			break;
-
-		alt = malloc(sizeof(*alt));
-		if (!alt) {
-			WARN("malloc failed");
-			return -1;
-		}
-
-		alt->insn = dest_insn;
-		list_add_tail(&alt->list, &insn->alts);
-		prev_offset = rela->offset;
-	}
-
-	if (!prev_offset) {
-		WARN_FUNC("can't find switch jump table",
-			  insn->sec, insn->offset);
-		return -1;
-	}
-
-	return 0;
-}
-
 /*
  * find_jump_table() - Given a dynamic jump, find the switch jump table in
  * .rodata associated with it.
@@ -1058,38 +996,9 @@ static struct rela *find_jump_table(struct objtool_file *file,
 			continue;
 
 		/* Each table entry has a rela associated with it. */
-		table_rela = find_rela_by_dest(table_sec, table_offset);
+		table_rela = arch_find_switch_table(file, text_rela, table_sec, table_offset);
 		if (!table_rela)
 			continue;
-		/*
-		 * If we are on arm64 architecture, we now that we
-		 * are in presence of a switch table thanks to
-		 * the `br <Xn>` insn. but we can't retrieve it yet.
-		 * So we just ignore unreachable for this file.
-		 */
-		if (!arch_support_switch_table()) {
-			file->ignore_unreachables = true;
-			return NULL;
-		}
-
-		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
-		if (rodata_rela) {
-			/*
-			 * Use of RIP-relative switch jumps is quite rare, and
-			 * indicates a rare GCC quirk/bug which can leave dead
-			 * code behind.
-			 */
-			if (text_rela->type == R_X86_64_PC32)
-				file->ignore_unreachables = true;
-
-		/*
-		 * Use of RIP-relative switch jumps is quite rare, and
-		 * indicates a rare GCC quirk/bug which can leave dead code
-		 * behind.
-		 */
-		if (text_rela->type == R_X86_64_PC32)
-			file->ignore_unreachables = true;
-
 		return table_rela;
 	}
 
@@ -1145,7 +1054,7 @@ static int add_func_jump_tables(struct objtool_file *file,
 		if (!insn->jump_table)
 			continue;
 
-		ret = add_jump_table(file, insn, insn->jump_table);
+		ret = arch_add_jump_table(file, insn, insn->jump_table, NULL);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index af87b55db454..267759760a3d 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -13,6 +13,7 @@
 #include "orc.h"
 #include "arch_special.h"
 #include <linux/hashtable.h>
+;
 
 struct insn_state {
 	struct cfi_reg cfa;
@@ -48,6 +49,12 @@ struct instruction {
 	struct orc_entry orc;
 };
 
+struct alternative {
+	struct list_head list;
+	struct instruction *insn;
+	bool skip_orig;
+};
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 90626a7e41cf..9b1f968a4325 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -7,7 +7,10 @@
 #define _SPECIAL_H
 
 #include <stdbool.h>
+#include <stdlib.h>
+#include "check.h"
 #include "elf.h"
+#include "warn.h"
 
 struct special_alt {
 	struct list_head list;
@@ -30,5 +33,10 @@ int special_get_alts(struct elf *elf, struct list_head *alts);
 void arch_force_alt_path(unsigned short feature,
 			 bool uaccess,
 			 struct special_alt *alt);
-
+int arch_add_jump_table(struct objtool_file *file, struct instruction *insn,
+			struct rela *table, struct rela *next_table);
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				  struct rela *text_rela,
+				  struct section *rodata_sec,
+				  unsigned long table_offset);
 #endif /* _SPECIAL_H */
-- 
2.17.1


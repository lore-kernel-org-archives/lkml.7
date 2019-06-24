Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF65DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEF92133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfFXJ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:56:25 -0400
Received: from foss.arm.com ([217.140.110.172]:44926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbfFXJ4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17463139F;
        Mon, 24 Jun 2019 02:56:22 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5403F71E;
        Mon, 24 Jun 2019 02:56:20 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC V3 08/18] objtool: Refactor switch-tables code to support other architectures
Date:   Mon, 24 Jun 2019 10:55:38 +0100
Message-Id: <20190624095548.8578-9-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624095548.8578-1-raphael.gault@arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
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
 tools/objtool/arch/arm64/arch_special.c | 15 +++++
 tools/objtool/arch/x86/arch_special.c   | 73 +++++++++++++++++++++
 tools/objtool/check.c                   | 84 +------------------------
 tools/objtool/check.h                   |  7 +++
 tools/objtool/special.h                 | 10 ++-
 5 files changed, 107 insertions(+), 82 deletions(-)

diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
index a21d28876317..a0f7066994b5 100644
--- a/tools/objtool/arch/arm64/arch_special.c
+++ b/tools/objtool/arch/arm64/arch_special.c
@@ -20,3 +20,18 @@ void arch_force_alt_path(unsigned short feature,
 			 struct special_alt *alt)
 {
 }
+
+int arch_add_switch_table(struct objtool_file *file, struct instruction *insn,
+			    struct rela *table, struct rela *next_table)
+{
+	return 0;
+}
+
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				    struct rela *text_rela,
+				    struct section *rodata_sec,
+				    unsigned long table_offset)
+{
+	file->ignore_unreachables = true;
+	return NULL;
+}
diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
index 6583a1770bb2..38ac010f8a02 100644
--- a/tools/objtool/arch/x86/arch_special.c
+++ b/tools/objtool/arch/x86/arch_special.c
@@ -26,3 +26,76 @@ void arch_force_alt_path(unsigned short feature,
 				alt->skip_alt = true;
 		}
 }
+
+int arch_add_switch_table(struct objtool_file *file, struct instruction *insn,
+			    struct rela *table, struct rela *next_table)
+{
+	struct rela *rela = table;
+	struct instruction *alt_insn;
+	struct alternative *alt;
+	struct symbol *pfunc = insn->func->pfunc;
+	unsigned int prev_offset = 0;
+
+	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
+		if (rela == next_table)
+			break;
+
+		/* Make sure the switch table entries are consecutive: */
+		if (prev_offset && rela->offset != prev_offset + 8)
+			break;
+
+		/* Detect function pointers from contiguous objects: */
+		if (rela->sym->sec == pfunc->sec &&
+		    rela->addend == pfunc->offset)
+			break;
+
+		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!alt_insn)
+			break;
+
+		/* Make sure the jmp dest is in the function or subfunction: */
+		if (alt_insn->func->pfunc != pfunc)
+			break;
+
+		alt = malloc(sizeof(*alt));
+		if (!alt) {
+			WARN("malloc failed");
+			return -1;
+		}
+
+		alt->insn = alt_insn;
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
+				    struct rela *text_rela,
+				    struct section *rodata_sec,
+				    unsigned long table_offset)
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
index cba1d91451cc..ce1165ce448a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,12 +18,6 @@
 
 #define FAKE_JUMP_OFFSET -1
 
-struct alternative {
-	struct list_head list;
-	struct instruction *insn;
-	bool skip_orig;
-};
-
 const char *objname;
 struct cfi_state initial_func_cfi;
 
@@ -901,56 +895,6 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
-static int add_switch_table(struct objtool_file *file, struct instruction *insn,
-			    struct rela *table, struct rela *next_table)
-{
-	struct rela *rela = table;
-	struct instruction *alt_insn;
-	struct alternative *alt;
-	struct symbol *pfunc = insn->func->pfunc;
-	unsigned int prev_offset = 0;
-
-	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
-		if (rela == next_table)
-			break;
-
-		/* Make sure the switch table entries are consecutive: */
-		if (prev_offset && rela->offset != prev_offset + 8)
-			break;
-
-		/* Detect function pointers from contiguous objects: */
-		if (rela->sym->sec == pfunc->sec &&
-		    rela->addend == pfunc->offset)
-			break;
-
-		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!alt_insn)
-			break;
-
-		/* Make sure the jmp dest is in the function or subfunction: */
-		if (alt_insn->func->pfunc != pfunc)
-			break;
-
-		alt = malloc(sizeof(*alt));
-		if (!alt) {
-			WARN("malloc failed");
-			return -1;
-		}
-
-		alt->insn = alt_insn;
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
  * find_switch_table() - Given a dynamic jump, find the switch jump table in
  * .rodata associated with it.
@@ -1045,29 +989,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(rodata_sec, table_offset))
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
-			return rodata_rela;
-		}
+		return arch_find_switch_table(file, text_rela, rodata_sec, table_offset);
 	}
 
 	return NULL;
@@ -1112,7 +1034,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 		 * the beginning of another switch table in the same function.
 		 */
 		if (prev_jump) {
-			ret = add_switch_table(file, prev_jump, prev_rela, rela);
+			ret = arch_add_switch_table(file, prev_jump, prev_rela, rela);
 			if (ret)
 				return ret;
 		}
@@ -1122,7 +1044,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 	}
 
 	if (prev_jump) {
-		ret = add_switch_table(file, prev_jump, prev_rela, NULL);
+		ret = arch_add_switch_table(file, prev_jump, prev_rela, NULL);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index c44f9fe40178..80e7a96525af 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -13,6 +13,7 @@
 #include "orc.h"
 #include "arch_special.h"
 #include <linux/hashtable.h>
+;
 
 struct insn_state {
 	struct cfi_reg cfa;
@@ -46,6 +47,12 @@ struct instruction {
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
index 90626a7e41cf..3fe093c1a9c5 100644
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
+int arch_add_switch_table(struct objtool_file *file, struct instruction *insn,
+			    struct rela *table, struct rela *next_table);
+struct rela *arch_find_switch_table(struct objtool_file *file,
+				    struct rela *text_rela,
+				    struct section *rodata_sec,
+				    unsigned long table_offset);
 #endif /* _SPECIAL_H */
-- 
2.17.1


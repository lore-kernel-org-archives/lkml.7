Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241CC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5CE214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfGOAh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbfGOAhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9243A308427D;
        Mon, 15 Jul 2019 00:37:49 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 878F45D9D2;
        Mon, 15 Jul 2019 00:37:48 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 18/22] objtool: Refactor jump table code
Date:   Sun, 14 Jul 2019 19:37:13 -0500
Message-Id: <6735a6cb9c18c3af5a65ee5078b9b754358935f6.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 15 Jul 2019 00:37:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that C jump tables are supported, call them "jump tables" instead of
"switch tables".  Also rename some other variables, add comments, and
simplify the code flow a bit.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 82 +++++++++++++++++++++++--------------------
 tools/objtool/elf.c   |  2 +-
 tools/objtool/elf.h   |  2 +-
 3 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a190a6e79a91..b21e9f7768d0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -627,7 +627,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * However this code can't completely replace the
 			 * read_symbols() code because this doesn't detect the
 			 * case where the parent function's only reference to a
-			 * subfunction is through a switch table.
+			 * subfunction is through a switch jump table.
 			 */
 			if (!strstr(insn->func->name, ".cold.") &&
 			    strstr(insn->jump_dest->func->name, ".cold.")) {
@@ -899,20 +899,24 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
-static int add_switch_table(struct objtool_file *file, struct instruction *insn,
+static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			    struct rela *table, struct rela *next_table)
 {
 	struct rela *rela = table;
-	struct instruction *alt_insn;
+	struct instruction *dest_insn;
 	struct alternative *alt;
 	struct symbol *pfunc = insn->func->pfunc;
 	unsigned int prev_offset = 0;
 
-	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
+	/*
+	 * Each @rela is a switch table relocation which points to the target
+	 * instruction.
+	 */
+	list_for_each_entry_from(rela, &table->sec->rela_list, list) {
 		if (rela == next_table)
 			break;
 
-		/* Make sure the switch table entries are consecutive: */
+		/* Make sure the table entries are consecutive: */
 		if (prev_offset && rela->offset != prev_offset + 8)
 			break;
 
@@ -921,12 +925,12 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 		    rela->addend == pfunc->offset)
 			break;
 
-		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!alt_insn)
+		dest_insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!dest_insn)
 			break;
 
-		/* Make sure the jmp dest is in the function or subfunction: */
-		if (alt_insn->func->pfunc != pfunc)
+		/* Make sure the destination is in the same function: */
+		if (dest_insn->func->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
@@ -935,7 +939,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 			return -1;
 		}
 
-		alt->insn = alt_insn;
+		alt->insn = dest_insn;
 		list_add_tail(&alt->list, &insn->alts);
 		prev_offset = rela->offset;
 	}
@@ -950,7 +954,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 }
 
 /*
- * find_switch_table() - Given a dynamic jump, find the switch jump table in
+ * find_jump_table() - Given a dynamic jump, find the switch jump table in
  * .rodata associated with it.
  *
  * There are 3 basic patterns:
@@ -992,13 +996,13 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
  *
  *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
-static struct rela *find_switch_table(struct objtool_file *file,
+static struct rela *find_jump_table(struct objtool_file *file,
 				      struct symbol *func,
 				      struct instruction *insn)
 {
-	struct rela *text_rela, *rodata_rela;
+	struct rela *text_rela, *table_rela;
 	struct instruction *orig_insn = insn;
-	struct section *rodata_sec;
+	struct section *table_sec;
 	unsigned long table_offset;
 
 	/*
@@ -1031,7 +1035,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
 			continue;
 
 		table_offset = text_rela->addend;
-		rodata_sec = text_rela->sym->sec;
+		table_sec = text_rela->sym->sec;
 
 		if (text_rela->type == R_X86_64_PC32)
 			table_offset += 4;
@@ -1045,29 +1049,31 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
 		 * have symbols associated with them.
 		 */
-		if (find_symbol_containing(rodata_sec, table_offset) &&
-		    strcmp(rodata_sec->name, C_JUMP_TABLE_SECTION))
+		if (find_symbol_containing(table_sec, table_offset) &&
+		    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
 			continue;
 
-		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
-		if (rodata_rela) {
-			/*
-			 * Use of RIP-relative switch jumps is quite rare, and
-			 * indicates a rare GCC quirk/bug which can leave dead
-			 * code behind.
-			 */
-			if (text_rela->type == R_X86_64_PC32)
-				file->ignore_unreachables = true;
+		/* Each table entry has a rela associated with it. */
+		table_rela = find_rela_by_dest(table_sec, table_offset);
+		if (!table_rela)
+			continue;
 
-			return rodata_rela;
-		}
+		/*
+		 * Use of RIP-relative switch jumps is quite rare, and
+		 * indicates a rare GCC quirk/bug which can leave dead code
+		 * behind.
+		 */
+		if (text_rela->type == R_X86_64_PC32)
+			file->ignore_unreachables = true;
+
+		return table_rela;
 	}
 
 	return NULL;
 }
 
 
-static int add_func_switch_tables(struct objtool_file *file,
+static int add_func_jump_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
 	struct instruction *insn, *last = NULL, *prev_jump = NULL;
@@ -1080,7 +1086,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 
 		/*
 		 * Store back-pointers for unconditional forward jumps such
-		 * that find_switch_table() can back-track using those and
+		 * that find_jump_table() can back-track using those and
 		 * avoid some potentially confusing code.
 		 */
 		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
@@ -1095,17 +1101,17 @@ static int add_func_switch_tables(struct objtool_file *file,
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
-		rela = find_switch_table(file, func, insn);
+		rela = find_jump_table(file, func, insn);
 		if (!rela)
 			continue;
 
 		/*
-		 * We found a switch table, but we don't know yet how big it
+		 * We found a jump table, but we don't know yet how big it
 		 * is.  Don't add it until we reach the end of the function or
-		 * the beginning of another switch table in the same function.
+		 * the beginning of another jump table in the same function.
 		 */
 		if (prev_jump) {
-			ret = add_switch_table(file, prev_jump, prev_rela, rela);
+			ret = add_jump_table(file, prev_jump, prev_rela, rela);
 			if (ret)
 				return ret;
 		}
@@ -1115,7 +1121,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 	}
 
 	if (prev_jump) {
-		ret = add_switch_table(file, prev_jump, prev_rela, NULL);
+		ret = add_jump_table(file, prev_jump, prev_rela, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1128,7 +1134,7 @@ static int add_func_switch_tables(struct objtool_file *file,
  * section which contains a list of addresses within the function to jump to.
  * This finds these jump tables and adds them to the insn->alts lists.
  */
-static int add_switch_table_alts(struct objtool_file *file)
+static int add_jump_table_alts(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
@@ -1142,7 +1148,7 @@ static int add_switch_table_alts(struct objtool_file *file)
 			if (func->type != STT_FUNC)
 				continue;
 
-			ret = add_func_switch_tables(file, func);
+			ret = add_func_jump_tables(file, func);
 			if (ret)
 				return ret;
 		}
@@ -1339,7 +1345,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = add_switch_table_alts(file);
+	ret = add_jump_table_alts(file);
 	if (ret)
 		return ret;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d2c211b0a5a0..4650f5d3fff2 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -385,7 +385,7 @@ static int read_relas(struct elf *elf)
 			rela->offset = rela->rela.r_offset;
 			symndx = GELF_R_SYM(rela->rela.r_info);
 			rela->sym = find_symbol_by_index(elf, symndx);
-			rela->rela_sec = sec;
+			rela->sec = sec;
 			if (!rela->sym) {
 				WARN("can't find rela entry symbol %d for %s",
 				     symndx, sec->name);
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index e44ca5d51871..1b638de4e7c0 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -57,7 +57,7 @@ struct rela {
 	struct list_head list;
 	struct hlist_node hash;
 	GElf_Rela rela;
-	struct section *rela_sec;
+	struct section *sec;
 	struct symbol *sym;
 	unsigned int type;
 	unsigned long offset;
-- 
2.20.1


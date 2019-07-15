Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF37C742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4ED214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfGOAiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:38:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbfGOAhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0FF636893;
        Mon, 15 Jul 2019 00:37:51 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE7DB5D9D2;
        Mon, 15 Jul 2019 00:37:49 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 19/22] objtool: Support repeated uses of the same C jump table
Date:   Sun, 14 Jul 2019 19:37:14 -0500
Message-Id: <7e567fc1cf5b66fccb5b3203b13670af29aab703.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 15 Jul 2019 00:37:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

This fixes objtool for both a GCC issue and a Clang issue:

1) GCC issue:

   kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8d5: sibling call from callable instruction with modified stack frame

   With CONFIG_RETPOLINE=n, GCC is doing the following optimization in
   ___bpf_prog_run().

   Before:

           select_insn:
                   jmp *jumptable(,%rax,8)
                   ...
           ALU64_ADD_X:
                   ...
                   jmp select_insn
           ALU_ADD_X:
                   ...
                   jmp select_insn

   After:

           select_insn:
                   jmp *jumptable(, %rax, 8)
                   ...
           ALU64_ADD_X:
                   ...
                   jmp *jumptable(, %rax, 8)
           ALU_ADD_X:
                   ...
                   jmp *jumptable(, %rax, 8)

   This confuses objtool.  It has never seen multiple indirect jump
   sites which use the same jump table.

   For GCC switch tables, the only way of detecting the size of a table
   is by continuing to scan for more tables.  The size of the previous
   table can only be determined after another switch table is found, or
   when the scan reaches the end of the function.

   That logic was reused for C jump tables, and was based on the
   assumption that each jump table only has a single jump site.  The
   above optimization breaks that assumption.

2) Clang issue:

   drivers/usb/misc/sisusbvga/sisusb.o: warning: objtool: sisusb_write_mem_bulk()+0x588: can't find switch jump table

   With clang 9, code can be generated where a function contains two
   indirect jump instructions which use the same switch table.

The fix is the same for both issues: split the jump table parsing into
two passes.

In the first pass, locate the heads of all switch tables for the
function and mark their locations.

In the second pass, parse the switch tables and add them.

Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 53 +++++++++++++++++++++++--------------------
 tools/objtool/check.h |  1 +
 tools/objtool/elf.h   |  1 +
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b21e9f7768d0..4ed7cb71a1d9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -900,7 +900,7 @@ static int add_special_section_alts(struct objtool_file *file)
 }
 
 static int add_jump_table(struct objtool_file *file, struct instruction *insn,
-			    struct rela *table, struct rela *next_table)
+			    struct rela *table)
 {
 	struct rela *rela = table;
 	struct instruction *dest_insn;
@@ -913,7 +913,9 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	 * instruction.
 	 */
 	list_for_each_entry_from(rela, &table->sec->rela_list, list) {
-		if (rela == next_table)
+
+		/* Check for the end of the table: */
+		if (rela != table && rela->jump_table_start)
 			break;
 
 		/* Make sure the table entries are consecutive: */
@@ -1072,13 +1074,15 @@ static struct rela *find_jump_table(struct objtool_file *file,
 	return NULL;
 }
 
-
-static int add_func_jump_tables(struct objtool_file *file,
-				  struct symbol *func)
+/*
+ * First pass: Mark the head of each jump table so that in the next pass,
+ * we know when a given jump table ends and the next one starts.
+ */
+static void mark_func_jump_tables(struct objtool_file *file,
+				    struct symbol *func)
 {
-	struct instruction *insn, *last = NULL, *prev_jump = NULL;
-	struct rela *rela, *prev_rela = NULL;
-	int ret;
+	struct instruction *insn, *last = NULL;
+	struct rela *rela;
 
 	func_for_each_insn_all(file, func, insn) {
 		if (!last)
@@ -1102,26 +1106,24 @@ static int add_func_jump_tables(struct objtool_file *file,
 			continue;
 
 		rela = find_jump_table(file, func, insn);
-		if (!rela)
-			continue;
-
-		/*
-		 * We found a jump table, but we don't know yet how big it
-		 * is.  Don't add it until we reach the end of the function or
-		 * the beginning of another jump table in the same function.
-		 */
-		if (prev_jump) {
-			ret = add_jump_table(file, prev_jump, prev_rela, rela);
-			if (ret)
-				return ret;
+		if (rela) {
+			rela->jump_table_start = true;
+			insn->jump_table = rela;
 		}
-
-		prev_jump = insn;
-		prev_rela = rela;
 	}
+}
+
+static int add_func_jump_tables(struct objtool_file *file,
+				  struct symbol *func)
+{
+	struct instruction *insn;
+	int ret;
+
+	func_for_each_insn_all(file, func, insn) {
+		if (!insn->jump_table)
+			continue;
 
-	if (prev_jump) {
-		ret = add_jump_table(file, prev_jump, prev_rela, NULL);
+		ret = add_jump_table(file, insn, insn->jump_table);
 		if (ret)
 			return ret;
 	}
@@ -1148,6 +1150,7 @@ static int add_jump_table_alts(struct objtool_file *file)
 			if (func->type != STT_FUNC)
 				continue;
 
+			mark_func_jump_tables(file, func);
 			ret = add_func_jump_tables(file, func);
 			if (ret)
 				return ret;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index cb60b9acf5cf..afa6a79e0715 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -38,6 +38,7 @@ struct instruction {
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
+	struct rela *jump_table;
 	struct list_head alts;
 	struct symbol *func;
 	struct stack_op stack_op;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 1b638de4e7c0..14e7d4c3aff1 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -62,6 +62,7 @@ struct rela {
 	unsigned int type;
 	unsigned long offset;
 	int addend;
+	bool jump_table_start;
 };
 
 struct elf {
-- 
2.20.1


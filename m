Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D74C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195FC21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DVrOET27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391279AbfGRTVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:21:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfGRTVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:21:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJKmBJ2125914
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:20:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJKmBJ2125914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477649;
        bh=qjRwOOIVq1l1u3smnm58wRFzoAFXeL7IFUivwidysUQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DVrOET27D06MwG9sythp8806bFaf8SFoAopy0yVjq1GWtbt1cmpGYcg6Xn9uUPiMx
         OE5+NB2TFDSJT0rb4TnT0zV7rLZ/Xbdi/l/IcT+or+DgIwWG7ujtp+I5zVoSgwqxSK
         g+KSUYo4XAuzWoQ5Is0VjfD7UkbQTzC+g40GeE4X8+uPaR1gsCSHtCDR/TL/Dc0TxB
         c7VQv9jhrJKyXwPlCf83bjxbM2QcxjMhluK8Fl+m8XKorm9EnIm120BRDB+b0l0fKP
         OjrU5aINkgpLusquQhob/muLqXRTOHwbtgabgxLwlhOBaAoI2fIkwXW9Lufz/WseEk
         p6SLFVMviYVwA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJKmXW2125911;
        Thu, 18 Jul 2019 12:20:48 -0700
Date:   Thu, 18 Jul 2019 12:20:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-bd98c81346468fc2f86aeeb44d4d0d6f763a62b7@git.kernel.org>
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, arnd@arndb.de,
        peterz@infradead.org, rdunlap@infradead.org, hpa@zytor.com,
        jpoimboe@redhat.com, jannh@google.com
Reply-To: hpa@zytor.com, peterz@infradead.org, rdunlap@infradead.org,
          arnd@arndb.de, jannh@google.com, jpoimboe@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, ndesaulniers@google.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <e995befaada9d4d8b2cf788ff3f566ba900d2b4d.1563413318.git.jpoimboe@redhat.com>
References: <e995befaada9d4d8b2cf788ff3f566ba900d2b4d.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Support repeated uses of the same C jump
 table
Git-Commit-ID: bd98c81346468fc2f86aeeb44d4d0d6f763a62b7
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

Commit-ID:  bd98c81346468fc2f86aeeb44d4d0d6f763a62b7
Gitweb:     https://git.kernel.org/tip/bd98c81346468fc2f86aeeb44d4d0d6f763a62b7
Author:     Jann Horn <jannh@google.com>
AuthorDate: Wed, 17 Jul 2019 20:36:54 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:09 +0200

objtool: Support repeated uses of the same C jump table

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
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/e995befaada9d4d8b2cf788ff3f566ba900d2b4d.1563413318.git.jpoimboe@redhat.com

Co-developed-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 53 +++++++++++++++++++++++++++------------------------
 tools/objtool/check.h |  1 +
 tools/objtool/elf.h   |  1 +
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4525cf677a1b..66f7c01385a4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -900,7 +900,7 @@ out:
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
index d4d3e0528d4a..44150204db4d 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -62,6 +62,7 @@ struct rela {
 	unsigned int type;
 	unsigned long offset;
 	int addend;
+	bool jump_table_start;
 };
 
 struct elf {

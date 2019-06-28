Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C6EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0866F2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfF1Bvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF1Bvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:51:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E62C30820C9;
        Fri, 28 Jun 2019 01:51:35 +0000 (UTC)
Received: from treble.redhat.com (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3441948D;
        Fri, 28 Jun 2019 01:51:32 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 1/2] objtool: Add support for C jump tables
Date:   Thu, 27 Jun 2019 20:50:46 -0500
Message-Id: <0ba2ca30442b16b97165992381ce643dc27b3d1a.1561685471.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1561685471.git.jpoimboe@redhat.com>
References: <cover.1561685471.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 28 Jun 2019 01:51:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool doesn't know how to read C jump tables, so it has to whitelist
functions which use them, causing missing ORC unwinder data for such
functions, e.g. ___bpf_prog_run().

C jump tables are very similar to GCC switch jump tables, which objtool
already knows how to read.  So adding support for C jump tables is easy.
It just needs to be able to find the tables and distinguish them from
other data.

To allow the jump tables to be found, create an __annotate_jump_table
macro which can be used to annotate them.

The annotation is done by placing the jump table in an
.rodata..c_jump_table section.  The '.rodata' prefix ensures that the
data will be placed in the rodata section by the vmlinux linker script.
The double periods are part of an existing convention which
distinguishes kernel sections from GCC sections.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/compiler.h |  5 +++++
 tools/objtool/check.c    | 27 ++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8aaf7cd026b0..f0fd5636fddb 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -116,9 +116,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	".pushsection .discard.unreachable\n\t"				\
 	".long 999b - .\n\t"						\
 	".popsection\n\t"
+
+/* Annotate a C jump table to allow objtool to follow the code flow */
+#define __annotate_jump_table __section(".rodata..c_jump_table")
+
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
+#define __annotate_jump_table
 #endif
 
 #ifndef ASM_UNREACHABLE
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..27818a93f0b1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,8 @@
 
 #define FAKE_JUMP_OFFSET -1
 
+#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -1035,9 +1037,15 @@ static struct rela *find_switch_table(struct objtool_file *file,
 
 		/*
 		 * Make sure the .rodata address isn't associated with a
-		 * symbol.  gcc jump tables are anonymous data.
+		 * symbol.  GCC jump tables are anonymous data.
+		 *
+		 * Also support C jump tables which are in the same format as
+		 * switch jump tables.  For objtool to recognize them, they
+		 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
+		 * have symbols associated with them.
 		 */
-		if (find_symbol_containing(rodata_sec, table_offset))
+		if (find_symbol_containing(rodata_sec, table_offset) &&
+		    strcmp(rodata_sec->name, C_JUMP_TABLE_SECTION))
 			continue;
 
 		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
@@ -1277,13 +1285,18 @@ static void mark_rodata(struct objtool_file *file)
 	bool found = false;
 
 	/*
-	 * This searches for the .rodata section or multiple .rodata.func_name
-	 * sections if -fdata-sections is being used. The .str.1.1 and .str.1.8
-	 * rodata sections are ignored as they don't contain jump tables.
+	 * Search for the following rodata sections, each of which can
+	 * potentially contain jump tables:
+	 *
+	 * - .rodata: can contain GCC switch tables
+	 * - .rodata.<func>: same, if -fdata-sections is being used
+	 * - .rodata..c_jump_table: contains C annotated jump tables
+	 *
+	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
-		    !strstr(sec->name, ".str1.")) {
+		if ((!strncmp(sec->name, ".rodata", 7) && !strstr(sec->name, ".str1.")) ||
+		    !strcmp(sec->name, C_JUMP_TABLE_SECTION)) {
 			sec->rodata = true;
 			found = true;
 		}
-- 
2.20.1


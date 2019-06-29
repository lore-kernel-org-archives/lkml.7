Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F13C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 05:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE0A2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 05:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0AXnGDQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfF2F7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:59:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF2F7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 01:59:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5T5wAUH1132681
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 28 Jun 2019 22:58:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5T5wAUH1132681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561787891;
        bh=tiV34zluLy+1/RVsere+ZQ118peTD7Yf7z4sQcq3w44=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=0AXnGDQH/H+nKtbfT0oOZdqgtOmHuiGRV0QCcsN5O/cnWOh8YuDkiQSlYMudJqM8h
         HVXQltSzvmCzM2WKVzTLa807JfYc5BqxChseSt8VbLGdddO/gPtfmjmTgGlsyaMfu7
         yAayJkCeKTuGD7Rmp2I82aQ95KEP+Z3fYDCTOPY/+xvT3cG89kCLDbngu23g95cpZJ
         VQp4Py03k6IPqbvE7QU5ydWsgfUy/OnaqKQ97bqLuE6BR4MChY8qhf+tc9sofvy209
         6YuUtYfwEtMO0b8TYSx8rveizBWybld/hMaLDaC2nqgaf2xRvQdhtP+vAxl6jeGOSj
         1Txdoae5bUwqA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5T5w8da1132676;
        Fri, 28 Jun 2019 22:58:08 -0700
Date:   Fri, 28 Jun 2019 22:58:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-d31acc2cc6ee313cee663ffed89c6a8f807bd87b@git.kernel.org>
Cc:     peterz@infradead.org, ast@kernel.org, kasong@redhat.com,
        hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, daniel@iogearbox.net,
        mingo@kernel.org, songliubraving@fb.com, bp@alien8.de
Reply-To: bp@alien8.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          ast@kernel.org, peterz@infradead.org, kasong@redhat.com,
          mingo@kernel.org, daniel@iogearbox.net, songliubraving@fb.com,
          rostedt@goodmis.org, tglx@linutronix.de, jpoimboe@redhat.com
In-Reply-To: <0ba2ca30442b16b97165992381ce643dc27b3d1a.1561685471.git.jpoimboe@redhat.com>
References: <0ba2ca30442b16b97165992381ce643dc27b3d1a.1561685471.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] objtool: Add support for C jump tables
Git-Commit-ID: d31acc2cc6ee313cee663ffed89c6a8f807bd87b
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

Commit-ID:  d31acc2cc6ee313cee663ffed89c6a8f807bd87b
Gitweb:     https://git.kernel.org/tip/d31acc2cc6ee313cee663ffed89c6a8f807bd87b
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 27 Jun 2019 20:50:46 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 29 Jun 2019 07:55:13 +0200

objtool: Add support for C jump tables

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
.rodata..c_jump_table section.  The '.rodata' prefix ensures that the data
will be placed in the rodata section by the vmlinux linker script.  The
double periods are part of an existing convention which distinguishes
kernel sections from GCC sections.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Kairui Song <kasong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lkml.kernel.org/r/0ba2ca30442b16b97165992381ce643dc27b3d1a.1561685471.git.jpoimboe@redhat.com

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

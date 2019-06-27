Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CEC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC14217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfF0Ag0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfF0AfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 861D9C057F2F;
        Thu, 27 Jun 2019 00:35:00 +0000 (UTC)
Received: from treble.redhat.com (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 294FF5D9C6;
        Thu, 27 Jun 2019 00:34:57 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 2/4] objtool: Add support for C jump tables
Date:   Wed, 26 Jun 2019 19:33:53 -0500
Message-Id: <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1561595111.git.jpoimboe@redhat.com>
References: <cover.1561595111.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 27 Jun 2019 00:35:00 +0000 (UTC)
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

To allow the jump tables to be found, create a standard: objtool will
automatically recognize any static local jump table named "jump_table".

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..8341c2fff14f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,6 +18,8 @@
 
 #define FAKE_JUMP_OFFSET -1
 
+#define JUMP_TABLE_SYM_PREFIX "jump_table."
+
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -997,6 +999,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
 	struct instruction *orig_insn = insn;
 	struct section *rodata_sec;
 	unsigned long table_offset;
+	struct symbol *sym;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -1035,9 +1038,18 @@ static struct rela *find_switch_table(struct objtool_file *file,
 
 		/*
 		 * Make sure the .rodata address isn't associated with a
-		 * symbol.  gcc jump tables are anonymous data.
+		 * symbol.  GCC jump tables are anonymous data.
+		 *
+		 * Also support C jump tables which are in the same format as
+		 * switch jump tables.  Each jump table should be a static
+		 * local const array named "jump_table" for objtool to
+		 * recognize it.  Note: GCC will add a numbered suffix to the
+		 * ELF symbol name, like "jump_table.12345", which it does for
+		 * all static local variables.
 		 */
-		if (find_symbol_containing(rodata_sec, table_offset))
+		sym = find_symbol_containing(rodata_sec, table_offset);
+		if (sym && strncmp(sym->name, JUMP_TABLE_SYM_PREFIX,
+				   strlen(JUMP_TABLE_SYM_PREFIX)))
 			continue;
 
 		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
-- 
2.20.1


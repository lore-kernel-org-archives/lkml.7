Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D4C742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA496214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfGOAiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbfGOAhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72B2B3082E8E;
        Mon, 15 Jul 2019 00:37:43 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 668005D9D2;
        Mon, 15 Jul 2019 00:37:42 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 13/22] objtool: Refactor function alias logic
Date:   Sun, 14 Jul 2019 19:37:08 -0500
Message-Id: <c6409c7a8f2d266ee0381b94f4a02a56d45b7385.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 15 Jul 2019 00:37:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add an alias check in validate_functions().  With this change, aliases
  no longer need uaccess_safe set.

- Add an alias check in decode_instructions().  With this change, the
  "if (!insn->func)" check is no longer needed.

- Don't create aliases for zero-length functions, as it can have
  unexpected results.  The next patch will spit out a warning for
  zero-length functions anyway.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 16 +++++++++-------
 tools/objtool/elf.c   |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bb9cfda670fd..9bf4844d9226 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -276,7 +276,7 @@ static int decode_instructions(struct objtool_file *file)
 		}
 
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
+			if (func->type != STT_FUNC || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -286,8 +286,7 @@ static int decode_instructions(struct objtool_file *file)
 			}
 
 			func_for_each_insn(file, func, insn)
-				if (!insn->func)
-					insn->func = func;
+				insn->func = func;
 		}
 	}
 
@@ -508,7 +507,7 @@ static void add_uaccess_safe(struct objtool_file *file)
 		if (!func)
 			continue;
 
-		func->alias->uaccess_safe = true;
+		func->uaccess_safe = true;
 	}
 }
 
@@ -1887,7 +1886,7 @@ static bool insn_state_match(struct instruction *insn, struct insn_state *state)
 static inline bool func_uaccess_safe(struct symbol *func)
 {
 	if (func)
-		return func->alias->uaccess_safe;
+		return func->uaccess_safe;
 
 	return false;
 }
@@ -2355,14 +2354,17 @@ static int validate_functions(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC || func->pfunc != func)
+			if (func->type != STT_FUNC)
+				continue;
+
+			if (func->pfunc != func || func->alias != func)
 				continue;
 
 			insn = find_insn(file, sec, func->offset);
 			if (!insn || insn->ignore || insn->visited)
 				continue;
 
-			state.uaccess = func->alias->uaccess_safe;
+			state.uaccess = func->uaccess_safe;
 
 			ret = validate_branch(file, func, insn, state);
 			if (ret && backtrace)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e99e1be19ad9..d2c211b0a5a0 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -278,7 +278,7 @@ static int read_symbols(struct elf *elf)
 			}
 
 			if (sym->offset == s->offset) {
-				if (sym->len == s->len && alias == sym)
+				if (sym->len && sym->len == s->len && alias == sym)
 					alias = s;
 
 				if (sym->len >= s->len) {
-- 
2.20.1


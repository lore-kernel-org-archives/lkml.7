Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDFFC742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B2721655
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfGOAi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbfGOAhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C64185362;
        Mon, 15 Jul 2019 00:37:42 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30D3F5D9D2;
        Mon, 15 Jul 2019 00:37:41 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 12/22] objtool: Track original function across branches
Date:   Sun, 14 Jul 2019 19:37:07 -0500
Message-Id: <c427b9aeb1f163eceb9019b9ad874ffc6f28d70f.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Jul 2019 00:37:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'insn->func' is NULL, objtool skips some important checks, including
sibling call validation.  So if some .fixup code does an invalid sibling
call, objtool ignores it.

Treat all code branches (including alts) as part of the original
function by keeping track of the original func value from
validate_functions().

This improves the usefulness of some clang function fallthrough
warnings, and exposes some additional kernel bugs in the process.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fd8827114c74..bb9cfda670fd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1934,13 +1934,12 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
  * each instruction and validate all the rules described in
  * tools/objtool/Documentation/stack-validation.txt.
  */
-static int validate_branch(struct objtool_file *file, struct instruction *first,
-			   struct insn_state state)
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *first, struct insn_state state)
 {
 	struct alternative *alt;
 	struct instruction *insn, *next_insn;
 	struct section *sec;
-	struct symbol *func = NULL;
 	int ret;
 
 	insn = first;
@@ -1961,9 +1960,6 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			return 1;
 		}
 
-		if (insn->func)
-			func = insn->func->pfunc;
-
 		if (func && insn->ignore) {
 			WARN_FUNC("BUG: why am I validating an ignored function?",
 				  sec, insn->offset);
@@ -1985,7 +1981,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 				i = insn;
 				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, insn->func, i) {
+				func_for_each_insn_continue_reverse(file, func, i) {
 					if (i->save) {
 						save_insn = i;
 						break;
@@ -2031,7 +2027,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 				if (alt->skip_orig)
 					skip_orig = true;
 
-				ret = validate_branch(file, alt->insn, state);
+				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(alt)", insn);
@@ -2069,7 +2065,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			if (state.bp_scratch) {
 				WARN("%s uses BP as a scratch register",
-				     insn->func->name);
+				     func->name);
 				return 1;
 			}
 
@@ -2109,8 +2105,8 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			} else if (insn->jump_dest &&
 				   (!func || !insn->jump_dest->func ||
 				    insn->jump_dest->func->pfunc == func)) {
-				ret = validate_branch(file, insn->jump_dest,
-						      state);
+				ret = validate_branch(file, func,
+						      insn->jump_dest, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(branch)", insn);
@@ -2176,7 +2172,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			break;
 
 		case INSN_CLAC:
-			if (!state.uaccess && insn->func) {
+			if (!state.uaccess && func) {
 				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
 				return 1;
 			}
@@ -2197,7 +2193,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			break;
 
 		case INSN_CLD:
-			if (!state.df && insn->func)
+			if (!state.df && func)
 				WARN_FUNC("redundant CLD", sec, insn->offset);
 
 			state.df = false;
@@ -2236,7 +2232,7 @@ static int validate_unwind_hints(struct objtool_file *file)
 
 	for_each_insn(file, insn) {
 		if (insn->hint && !insn->visited) {
-			ret = validate_branch(file, insn, state);
+			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -2363,12 +2359,12 @@ static int validate_functions(struct objtool_file *file)
 				continue;
 
 			insn = find_insn(file, sec, func->offset);
-			if (!insn || insn->ignore)
+			if (!insn || insn->ignore || insn->visited)
 				continue;
 
 			state.uaccess = func->alias->uaccess_safe;
 
-			ret = validate_branch(file, insn, state);
+			ret = validate_branch(file, func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (func)", insn);
 			warnings += ret;
-- 
2.20.1


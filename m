Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EBC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0DA21734
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfGOAhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbfGOAhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DD5685376;
        Mon, 15 Jul 2019 00:37:48 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FB405D9D2;
        Mon, 15 Jul 2019 00:37:47 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 17/22] objtool: Refactor sibling call detection logic
Date:   Sun, 14 Jul 2019 19:37:12 -0500
Message-Id: <50a783c4ccc47479806e2147f0447315fd5be228.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Jul 2019 00:37:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the sibling call detection logic a bit.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 65 ++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3fb656ea96b9..a190a6e79a91 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -97,6 +97,20 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static bool is_sibling_call(struct instruction *insn)
+{
+	/* An indirect jump is either a sibling call or a jump to a table. */
+	if (insn->type == INSN_JUMP_DYNAMIC)
+		return list_empty(&insn->alts);
+
+	if (insn->type != INSN_JUMP_CONDITIONAL &&
+	    insn->type != INSN_JUMP_UNCONDITIONAL)
+		return false;
+
+	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
+	return !!insn->call_dest;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -167,34 +181,25 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * of the sibling call returns.
 	 */
 	func_for_each_insn_all(file, func, insn) {
-		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+		if (is_sibling_call(insn)) {
 			struct instruction *dest = insn->jump_dest;
 
 			if (!dest)
 				/* sibling call to another file */
 				return false;
 
-			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
-
-				/* local sibling call */
-				if (recursion == 5) {
-					/*
-					 * Infinite recursion: two functions
-					 * have sibling calls to each other.
-					 * This is a very rare case.  It means
-					 * they aren't dead ends.
-					 */
-					return false;
-				}
-
-				return __dead_end_function(file, dest->func,
-							   recursion + 1);
+			/* local sibling call */
+			if (recursion == 5) {
+				/*
+				 * Infinite recursion: two functions have
+				 * sibling calls to each other.  This is a very
+				 * rare case.  It means they aren't dead ends.
+				 */
+				return false;
 			}
-		}
 
-		if (insn->type == INSN_JUMP_DYNAMIC && list_empty(&insn->alts))
-			/* sibling call */
-			return false;
+			return __dead_end_function(file, dest->func, recursion+1);
+		}
 	}
 
 	return true;
@@ -581,9 +586,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			insn->retpoline_safe = true;
 			continue;
 		} else {
-			/* sibling call */
+			/* external sibling call */
 			insn->call_dest = rela->sym;
-			insn->jump_dest = NULL;
 			continue;
 		}
 
@@ -633,9 +637,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
 
-				/* sibling class */
+				/* internal sibling call */
 				insn->call_dest = insn->jump_dest->func;
-				insn->jump_dest = NULL;
 			}
 		}
 	}
@@ -1889,7 +1892,7 @@ static inline bool func_uaccess_safe(struct symbol *func)
 	return false;
 }
 
-static inline const char *insn_dest_name(struct instruction *insn)
+static inline const char *call_dest_name(struct instruction *insn)
 {
 	if (insn->call_dest)
 		return insn->call_dest->name;
@@ -1901,13 +1904,13 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 {
 	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
 		WARN_FUNC("call to %s() with UACCESS enabled",
-				insn->sec, insn->offset, insn_dest_name(insn));
+				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
 
 	if (state->df) {
 		WARN_FUNC("call to %s() with DF set",
-				insn->sec, insn->offset, insn_dest_name(insn));
+				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
 
@@ -2088,14 +2091,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (func && !insn->jump_dest) {
+			if (func && is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
 
-			} else if (insn->jump_dest &&
-				   (!func || !insn->jump_dest->func ||
-				    insn->jump_dest->func->pfunc == func)) {
+			} else if (insn->jump_dest) {
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
@@ -2111,7 +2112,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (func && list_empty(&insn->alts)) {
+			if (func && is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
-- 
2.20.1


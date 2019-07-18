Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1945DC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C4021019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hc+MMoyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbfGRTT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:19:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41493 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRTT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:19:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJJDeJ2125739
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:19:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJJDeJ2125739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477554;
        bh=HfsYD/s5hnd0Wqifza4N1bGlDvMBmupgw4LOg9JnZ7g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hc+MMoyd0DWVOQeaYx/aXgjDM3d105kztB7fDvXYHq9nQKgZt6Hv6chrqh1l+oye9
         VRDnhD09nEoGIvI38HPx5eT5Rjdq6hN58Jp2Ilu/9Z4NFqof8VsfJUhNNpkU0fnNvG
         CKogGzT4y9xn9O9h+yOaKA7BuxJD7XNC0ZYLT4lWrf1sUyxqHHVmiRByGD96Us84S0
         NMJMxWQryYPjgF459AXyZlNIFHfYomZ29CwchrisXVxGX8ojAXS0Vfps9O75GzSl0O
         866vNT+7FDdeBDzxS20yhnkC+LdBcUCYyn3TICmzrnAnkH1I4ss8K+C0n58dbQ1ECy
         cvmSxNYUPln3Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJJDVo2125732;
        Thu, 18 Jul 2019 12:19:13 -0700
Date:   Thu, 18 Jul 2019 12:19:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-0c1ddd33177530feb3685a800bba1ac4cc58cc4b@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, mingo@kernel.org, jpoimboe@redhat.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          ndesaulniers@google.com, jpoimboe@redhat.com
In-Reply-To: <8357dbef9e7f5512e76bf83a76c81722fc09eb5e.1563413318.git.jpoimboe@redhat.com>
References: <8357dbef9e7f5512e76bf83a76c81722fc09eb5e.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Refactor sibling call detection logic
Git-Commit-ID: 0c1ddd33177530feb3685a800bba1ac4cc58cc4b
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

Commit-ID:  0c1ddd33177530feb3685a800bba1ac4cc58cc4b
Gitweb:     https://git.kernel.org/tip/0c1ddd33177530feb3685a800bba1ac4cc58cc4b
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:52 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:08 +0200

objtool: Refactor sibling call detection logic

Simplify the sibling call detection logic a bit.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8357dbef9e7f5512e76bf83a76c81722fc09eb5e.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 65 ++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0d2a8e54a82e..7fe31e0f8afe 100644
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

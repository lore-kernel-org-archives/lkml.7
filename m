Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F4BC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6372721019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bmsOTizp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbfGRTPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:15:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfGRTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:15:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJFbTS2125129
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:15:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJFbTS2125129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477338;
        bh=VWx9MCOOFJz1GDP1tSCeOcfNQGoIEiycyvcfSUEDyN8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bmsOTizpy2hx6qx9FjsOfjVfhi2+BWJNaRO1ZG6/dJDPhzAQj8CT4hyjWBIFFjFeG
         ns0YEB69b9/ztOdAjm5OE9PQoz9aX8AH3/n54juur4m7MoGrUpEXCHp7oeCboBBS5G
         O/C7lzN2aj0uJj+Laun1ZyfXCQh3TTwpxjyj5LFSg2IGZjEYt8yzyK181iox+ntsUP
         Q6bMZxPxQp8bCHPKWwOS0JO9QGyh+Gj4TaD2Tv8C59oDNBj1O6z36TqwSQk54PnBFN
         TvFS3xpjE3FuqT0NMu5kpUso2HTT9OOuz97RC1+Ib8o0ipQuP9bVzdmx6Vb+x6TmNn
         O+lKd2LuaiCHw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJFbWc2125126;
        Thu, 18 Jul 2019 12:15:37 -0700
Date:   Thu, 18 Jul 2019 12:15:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-c705cecc8431951b4f34178e6b1db51b4a504c43@git.kernel.org>
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        ndesaulniers@google.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, ndesaulniers@google.com,
          mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com
In-Reply-To: <505df630f33c9717e1ccde6e4b64c5303135c25f.1563413318.git.jpoimboe@redhat.com>
References: <505df630f33c9717e1ccde6e4b64c5303135c25f.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Track original function across branches
Git-Commit-ID: c705cecc8431951b4f34178e6b1db51b4a504c43
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

Commit-ID:  c705cecc8431951b4f34178e6b1db51b4a504c43
Gitweb:     https://git.kernel.org/tip/c705cecc8431951b4f34178e6b1db51b4a504c43
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:47 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:07 +0200

objtool: Track original function across branches

If 'insn->func' is NULL, objtool skips some important checks, including
sibling call validation.  So if some .fixup code does an invalid sibling
call, objtool ignores it.

Treat all code branches (including alts) as part of the original
function by keeping track of the original func value from
validate_functions().

This improves the usefulness of some clang function fallthrough
warnings, and exposes some additional kernel bugs in the process.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/505df630f33c9717e1ccde6e4b64c5303135c25f.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f9494ff8c286..d8a1ce80fded 100644
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

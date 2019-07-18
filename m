Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0FCC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCD521019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Xd4SjiAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbfGRTSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:18:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfGRTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:18:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJHjNw2125329
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:17:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJHjNw2125329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477466;
        bh=Q1tBsD/0Pd9DEsappsRA20ksFX/R82Dtp+wHnHiHzOw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Xd4SjiAWXN5bi/h8KYmUkmnfWvTIVBWy/5uMd7D0040+N2QFVuz3W4RT1XgrcQNgz
         533IRNJ2Now5juP7hTZUnolMyo3HrTG2XYxqlmeDwFSH8BSG0ShuMuppoeLl5udCCj
         yzjAYuaRM78d/5Fk59ip2Gy0wY6nZb8qFQu2eRGvLawOmIPO5zaEOO+3Ywz4j9/4a6
         wM6HvQY15RP1AjOm+zdxSSytb3rUDZe1ZPSRAUTo4455QJ23V3Kf+3E1sQRWx6VtYB
         xuK7Vz8/Oe0xfGgDiXIR64hVSoAuqbLb73cn6hqmzMR0BbbE6I6qzUfQ40qooC3YXn
         MIvn0922zpdqA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJHj612125326;
        Thu, 18 Jul 2019 12:17:45 -0700
Date:   Thu, 18 Jul 2019 12:17:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-8e25c9f8b482ea8d8b6fb4f6f5c09bcc5ee18663@git.kernel.org>
Cc:     peterz@infradead.org, jpoimboe@redhat.com, ndesaulniers@google.com,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: jpoimboe@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, ndesaulniers@google.com
In-Reply-To: <9e6679610768fb6e6c51dca23f7d4d0c03b0c910.1563413318.git.jpoimboe@redhat.com>
References: <9e6679610768fb6e6c51dca23f7d4d0c03b0c910.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Change dead_end_function() to return
 boolean
Git-Commit-ID: 8e25c9f8b482ea8d8b6fb4f6f5c09bcc5ee18663
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

Commit-ID:  8e25c9f8b482ea8d8b6fb4f6f5c09bcc5ee18663
Gitweb:     https://git.kernel.org/tip/8e25c9f8b482ea8d8b6fb4f6f5c09bcc5ee18663
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:50 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:08 +0200

objtool: Change dead_end_function() to return boolean

dead_end_function() can no longer return an error.  Simplify its
interface by making it return boolean.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/9e6679610768fb6e6c51dca23f7d4d0c03b0c910.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dece3253ff6a..d9d1c9b54947 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -105,14 +105,9 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
  *
  * For local functions, we have to detect them manually by simply looking for
  * the lack of a return instruction.
- *
- * Returns:
- *  -1: error
- *   0: no dead end
- *   1: dead end
  */
-static int __dead_end_function(struct objtool_file *file, struct symbol *func,
-			       int recursion)
+static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
+				int recursion)
 {
 	int i;
 	struct instruction *insn;
@@ -139,29 +134,29 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 	};
 
 	if (func->bind == STB_WEAK)
-		return 0;
+		return false;
 
 	if (func->bind == STB_GLOBAL)
 		for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
 			if (!strcmp(func->name, global_noreturns[i]))
-				return 1;
+				return true;
 
 	if (!func->len)
-		return 0;
+		return false;
 
 	insn = find_insn(file, func->sec, func->offset);
 	if (!insn->func)
-		return 0;
+		return false;
 
 	func_for_each_insn_all(file, func, insn) {
 		empty = false;
 
 		if (insn->type == INSN_RETURN)
-			return 0;
+			return false;
 	}
 
 	if (empty)
-		return 0;
+		return false;
 
 	/*
 	 * A function can have a sibling call instead of a return.  In that
@@ -174,7 +169,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 			if (!dest)
 				/* sibling call to another file */
-				return 0;
+				return false;
 
 			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
 
@@ -186,7 +181,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 					 * This is a very rare case.  It means
 					 * they aren't dead ends.
 					 */
-					return 0;
+					return false;
 				}
 
 				return __dead_end_function(file, dest->func,
@@ -196,13 +191,13 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 
 		if (insn->type == INSN_JUMP_DYNAMIC && list_empty(&insn->alts))
 			/* sibling call */
-			return 0;
+			return false;
 	}
 
-	return 1;
+	return true;
 }
 
-static int dead_end_function(struct objtool_file *file, struct symbol *func)
+static bool dead_end_function(struct objtool_file *file, struct symbol *func)
 {
 	return __dead_end_function(file, func, 0);
 }
@@ -2080,11 +2075,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				if (is_fentry_call(insn))
 					break;
 
-				ret = dead_end_function(file, insn->call_dest);
-				if (ret == 1)
+				if (dead_end_function(file, insn->call_dest))
 					return 0;
-				if (ret == -1)
-					return 1;
 			}
 
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {

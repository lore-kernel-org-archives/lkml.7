Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4015C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B628721019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JPGM7XsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391132AbfGRTQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:16:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfGRTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:16:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJGKKH2125202
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:16:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJGKKH2125202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477380;
        bh=T+IXuzDIw9YQGbnGWuy3UCysTLAiLf1XKXf+zmgXcoc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JPGM7XsR9z7ChFK1AbVu4na1iwhocpLUK4y+XbSx9KB4DUty6lmvhb4sq33SfJVDC
         WT9gz10l02Acl1WdU/jLqYtlPWy+vaBEU3274QbN+63gkVrsm1N54onqlq9KxmLWgZ
         PI2rWCGU3Wxv5TwdBsrqbHlVZ2RK7jQeOXiPZoiIhKBbMUExezYg2g+HjHlJl5E67I
         AwMH2TrpJks6aiyXCzDJ+hJf3JEfB8jVALNainBQot9Zvjs0y3JeRabvK85wIKE2I0
         56t7/M6SxU2eXW6T7WkxmUKlZ1nMbrID+Uj257ND5rzX6DQYqx6Rgl5fkd4O3iO+eg
         dQl5ifxfwSLEA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJGJS22125199;
        Thu, 18 Jul 2019 12:16:19 -0700
Date:   Thu, 18 Jul 2019 12:16:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-e10cd8fe8ddfd28a172d2be57ae0e90c7f752e6a@git.kernel.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com, hpa@zytor.com,
        ndesaulniers@google.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, ndesaulniers@google.com, jpoimboe@redhat.com,
          hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <26a99c31426540f19c9a58b9e10727c385a147bc.1563413318.git.jpoimboe@redhat.com>
References: <26a99c31426540f19c9a58b9e10727c385a147bc.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Refactor function alias logic
Git-Commit-ID: e10cd8fe8ddfd28a172d2be57ae0e90c7f752e6a
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

Commit-ID:  e10cd8fe8ddfd28a172d2be57ae0e90c7f752e6a
Gitweb:     https://git.kernel.org/tip/e10cd8fe8ddfd28a172d2be57ae0e90c7f752e6a
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:48 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:07 +0200

objtool: Refactor function alias logic

- Add an alias check in validate_functions().  With this change, aliases
  no longer need uaccess_safe set.

- Add an alias check in decode_instructions().  With this change, the
  "if (!insn->func)" check is no longer needed.

- Don't create aliases for zero-length functions, as it can have
  unexpected results.  The next patch will spit out a warning for
  zero-length functions anyway.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/26a99c31426540f19c9a58b9e10727c385a147bc.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 16 +++++++++-------
 tools/objtool/elf.c   |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d8a1ce80fded..3f8664b0e3f9 100644
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
index e18698262837..9194732a673d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -278,7 +278,7 @@ static int read_symbols(struct elf *elf)
 			}
 
 			if (sym->offset == s->offset) {
-				if (sym->len == s->len && alias == sym)
+				if (sym->len && sym->len == s->len && alias == sym)
 					alias = s;
 
 				if (sym->len >= s->len) {

Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B5C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EC821019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X7/M34Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391292AbfGRTSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:18:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391001AbfGRTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:18:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJISvT2125646
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:18:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJISvT2125646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477509;
        bh=zDXBFijOI5n8xrFOXccgBe4iMRgjz9k5pZpnntkYfgw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X7/M34Viqv+mfwHk9ljXECgdCqM0LBZqPYsu/jBWc/jmRRv/L1LK+IGYxceHF7xv/
         BBMDkEMMnsH3k6JDmWSS8KJT/HYtzcPRW67VXZduxVWsocLuhtzfSCexr5CXMmYT+n
         veU7gD0iCl/fRf7d3cp3J2/YILFmkyzOPuVhcDDSPwSLXZVio92GthHANxrsexUQ+B
         OPd0D37wVaJ5MNlGmmyRyk08Qdoh3+vC/9qJUh5Z1DjdjbF10Wqjix9ZmYSYVQhu4B
         e4ueUK10Pf1BuhA1QtZR230VEHFMQM9Zmpo+tIcC5Z20RvLWod4vQoRUk8SflEtWL5
         esjWNCSww5R4g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJISOg2125641;
        Thu, 18 Jul 2019 12:18:28 -0700
Date:   Thu, 18 Jul 2019 12:18:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-c9bab22bc449ad2496a6bbbf68acc711d9c5301c@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, tglx@linutronix.de, jpoimboe@redhat.com,
        mingo@kernel.org
Reply-To: ndesaulniers@google.com, tglx@linutronix.de, jpoimboe@redhat.com,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <aed62fbd60e239280218be623f751a433658e896.1563413318.git.jpoimboe@redhat.com>
References: <aed62fbd60e239280218be623f751a433658e896.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Do frame pointer check before dead end
 check
Git-Commit-ID: c9bab22bc449ad2496a6bbbf68acc711d9c5301c
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

Commit-ID:  c9bab22bc449ad2496a6bbbf68acc711d9c5301c
Gitweb:     https://git.kernel.org/tip/c9bab22bc449ad2496a6bbbf68acc711d9c5301c
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:51 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:08 +0200

objtool: Do frame pointer check before dead end check

Even calls to __noreturn functions need the frame pointer setup first.
Such functions often dump the stack.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/aed62fbd60e239280218be623f751a433658e896.1563413318.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d9d1c9b54947..0d2a8e54a82e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -133,6 +133,9 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"rewind_stack_do_exit",
 	};
 
+	if (!func)
+		return false;
+
 	if (func->bind == STB_WEAK)
 		return false;
 
@@ -2071,19 +2074,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (insn->type == INSN_CALL) {
-				if (is_fentry_call(insn))
-					break;
-
-				if (dead_end_function(file, insn->call_dest))
-					return 0;
-			}
-
-			if (!no_fp && func && !has_valid_stack_frame(&state)) {
+			if (!no_fp && func && !is_fentry_call(insn) &&
+			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
 			}
+
+			if (dead_end_function(file, insn->call_dest))
+				return 0;
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:

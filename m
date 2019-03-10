Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF092C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D54206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jB3uZtdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfCJNLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:11:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfCJNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 09:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5ANnafL2+ApcZqGhIs/isw5XVQimXlXsoVTCwDNi1MQ=; b=jB3uZtdGI7tuQNHtk6ijF++FY
        PBtr6ZXtU0/EkC96GeijPRM5B+4hUDudHS7DpJXsRnLCDdBnkQM/C5hM7koeiDhR8+yU5jh290M1G
        yO6JzDQAQWJxSDnpqK6wNSgRvpYsT9qrJYwnRg7kuY+kqWwmVOgmUKSHtSnWMNfRWJweWw9PGq319
        jaTt+iQ5dfJduwWCyTZlU0WnEPZnBk72PrjEWY/gD69T8LUHCzE/a691YfRaacucrMQ/6ty7BMF61
        sPqXPWTXZb3o1ubxTz9ZdJFAqs0PcVEBteQl7s+he71Lo1lNd+wNOT8IWQwyz9tpILJFiDS/Pjvil
        bWk3aVjjA==;
Received: from [188.207.104.17] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2yEB-0005zg-4r; Sun, 10 Mar 2019 13:10:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E53DD981BBE; Sun, 10 Mar 2019 14:10:46 +0100 (CET)
Date:   Sun, 10 Mar 2019 14:10:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190310131046.GI2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <20190308210209.usq2rpedccz25va5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308210209.usq2rpedccz25va5@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:02:09PM -0600, Josh Poimboeuf wrote:

> These gotos make my head spin.  Again I would much prefer a small amount
> of code duplication over this.

something like so then?

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1888,6 +1888,23 @@ static inline const char *insn_dest_name
 	return "{dynamic}";
 }
 
+static int validate_call(struct instruction *insn, struct insn_state *state)
+{
+	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
+		WARN_FUNC("call to %s() with UACCESS enabled",
+				insn->sec, insn->offset, insn_dest_name(insn));
+		return 1;
+	}
+
+	if (state->df) {
+		WARN_FUNC("call to %s() with DF set",
+				insn->sec, insn->offset, insn_dest_name(insn));
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2036,25 +2053,9 @@ static int validate_branch(struct objtoo
 
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:
-do_call:
-			if (state.uaccess && !func_uaccess_safe(insn->call_dest)) {
-				WARN_FUNC("call to %s() with UACCESS enabled",
-					  sec, insn->offset, insn_dest_name(insn));
-				return 1;
-			}
-
-			if (state.df) {
-				WARN_FUNC("call to %s() with DF set",
-					  sec, insn->offset, insn_dest_name(insn));
-				return 1;
-			}
-
-			if (insn->type == INSN_JUMP_UNCONDITIONAL ||
-			    insn->type == INSN_JUMP_DYNAMIC)
-				return 0;
-
-			if (insn->type == INSN_JUMP_CONDITIONAL)
-				break;
+			ret = validate_call(insn, &state);
+			if (ret)
+				return ret;
 
 			if (insn->type == INSN_CALL) {
 				if (is_fentry_call(insn))
@@ -2077,13 +2078,15 @@ static int validate_branch(struct objtoo
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
 			if (func && !insn->jump_dest) {
-do_sibling_call:
+				/* sibling call */
 				if (has_modified_stack_frame(&state)) {
 					WARN_FUNC("sibling call from callable instruction with modified stack frame",
 							sec, insn->offset);
 					return 1;
 				}
-				goto do_call;
+				ret = validate_call(insn, &state);
+				if (ret)
+					return ret;
 
 			} else if (insn->jump_dest &&
 				   (!func || !insn->jump_dest->func ||
@@ -2104,8 +2107,17 @@ static int validate_branch(struct objtoo
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (func && list_empty(&insn->alts))
-				goto do_sibling_call;
+			if (func && list_empty(&insn->alts)) {
+				/* sibling call */
+				if (has_modified_stack_frame(&state)) {
+					WARN_FUNC("sibling call from callable instruction with modified stack frame",
+							sec, insn->offset);
+					return 1;
+				}
+				ret = validate_call(insn, &state);
+				if (ret)
+					return ret;
+			}
 
 			return 0;
 


Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F73C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D8D216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEOC2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 22:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEOC2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 22:28:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C8420879;
        Wed, 15 May 2019 02:28:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQjef-0005NT-Lo; Tue, 14 May 2019 22:28:29 -0400
Message-Id: <20190515022829.570207954@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 14 May 2019 22:27:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-next][PATCH 1/5] tracing: Simplify "if" macro code
References: <20190515022747.719887946@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

Peter Zijlstra noticed that with CONFIG_PROFILE_ALL_BRANCHES, the "if"
macro converts the conditional to an array index.  This can cause GCC
to create horrible code.  When there are nested ifs, the generated code
uses register values to encode branching decisions.

Josh Poimboeuf found that replacing the define "if" macro from using
the condition as an array index and incrementing the branch statics
with an if statement itself, reduced the asm complexity and shrinks the
generated code quite a bit.

But this can be simplified even further by replacing the internal if
statement with a ternary operator.

Link: https://lkml.kernel.org/r/20190307174802.46fmpysxyo35hh43@treble
Link: http://lkml.kernel.org/r/CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com

Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/compiler.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 445348facea9..8aaf7cd026b0 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -53,23 +53,24 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * "Define 'is'", Bill Clinton
  * "Define 'if'", Steven Rostedt
  */
-#define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
-#define __trace_if(cond) \
-	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
-	({								\
-		int ______r;						\
-		static struct ftrace_branch_data			\
-			__aligned(4)					\
-			__section("_ftrace_branch")			\
-			______f = {					\
-				.func = __func__,			\
-				.file = __FILE__,			\
-				.line = __LINE__,			\
-			};						\
-		______r = !!(cond);					\
-		______f.miss_hit[______r]++;					\
-		______r;						\
-	}))
+#define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
+
+#define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
+
+#define __trace_if_value(cond) ({			\
+	static struct ftrace_branch_data		\
+		__aligned(4)				\
+		__section("_ftrace_branch")		\
+		__if_trace = {				\
+			.func = __func__,		\
+			.file = __FILE__,		\
+			.line = __LINE__,		\
+		};					\
+	(cond) ?					\
+		(__if_trace.miss_hit[1]++,1) :		\
+		(__if_trace.miss_hit[0]++,0);		\
+})
+
 #endif /* CONFIG_PROFILE_ALL_BRANCHES */
 
 #else
-- 
2.20.1



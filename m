Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4E7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C6A2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEIT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfEIT2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:28:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9521E21479;
        Thu,  9 May 2019 19:28:41 +0000 (UTC)
Date:   Thu, 9 May 2019 15:28:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190509152840.7fd261a4@gandalf.local.home>
In-Reply-To: <20190509150644.13d4a046@gandalf.local.home>
References: <20190318153840.906404905@infradead.org>
        <20190318155140.058627431@infradead.org>
        <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
        <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
        <20190509090058.6554dc81@gandalf.local.home>
        <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
        <20190509142902.08a32f20@gandalf.local.home>
        <20190509184531.jhinxi2x2pdfaefb@treble>
        <20190509150644.13d4a046@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 15:06:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, I'm still working on my pull request for the merge window, and if
> this already went in, I could just add this, and let it conflict. I'm
> sure Linus will have no problems in fixing up the conflicts.
> 
> I should change the subject, as it is the same ;-) Perhaps to:
> 
>  tracing: Clean up "if" macro
> 
> But it would be good to find out why this fixes the issue you see.
> Perhaps its because we remove the internal if statement?

I'm adding this to my tree, if that's alright with everyone. It will
conflict with your patch, but like I said, Linus should have no problem
fixing up the conflicts.

But it probably would probably still be good to know why this fixes the
issues you see.

-- Steve

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] tracing: Simplify "if" macro code

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


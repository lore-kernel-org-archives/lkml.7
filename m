Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF17C20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCGRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfCGRsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:48:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1E9B307D98B;
        Thu,  7 Mar 2019 17:48:05 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E24245D9C6;
        Thu,  7 Mar 2019 17:48:03 +0000 (UTC)
Date:   Thu, 7 Mar 2019 11:48:02 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307174802.46fmpysxyo35hh43@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
 <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
 <20190307174322.GK32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307174322.GK32477@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 07 Mar 2019 17:48:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 06:43:22PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 07, 2019 at 10:47:05AM -0600, Josh Poimboeuf wrote:
> 
> > This "fixes" it, and also seems to help -Os make much code:
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 445348facea9..8de63db58fdd 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -67,7 +67,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  				.line = __LINE__,			\
> >  			};						\
> >  		______r = !!(cond);					\
> > -		______f.miss_hit[______r]++;					\
> > +		if (______r) ______f.miss_hit[1]++; else ______f.miss_hit[0]++; \
> >  		______r;						\
> >  	}))
> >  #endif /* CONFIG_PROFILE_ALL_BRANCHES */
> 
> Excellen; let me put the kids to bed and then I'll have a poke.

Here's a proper patch.

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] tracing: Improve "if" macro code generation

With CONFIG_PROFILE_ALL_BRANCHES, the "if" macro converts the
conditional to an array index.  This can cause GCC to create horrible
code.  When there are nested ifs, the generated code uses register
values to encode branching decisions.

Make it easier for GCC to optimize by keeping the conditional as a
conditional rather than converting it to an integer.  This shrinks the
generated code quite a bit, and also makes the code sane enough for
objtool to understand.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 445348facea9..d58aa0db05f9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -67,7 +67,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 				.line = __LINE__,			\
 			};						\
 		______r = !!(cond);					\
-		______f.miss_hit[______r]++;					\
+		______r ? ______f.miss_hit[1]++ : ______f.miss_hit[0]++;\
 		______r;						\
 	}))
 #endif /* CONFIG_PROFILE_ALL_BRANCHES */
-- 
2.17.2


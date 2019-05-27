Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3085EC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060392173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="duGMKqrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE0IXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:23:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfE0IXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9Cqtg9UPfEA5JSmjwU1bBb5BiL2AfMKr2caD33f0ga8=; b=duGMKqrN8nbwR7fMu0h47yrLx
        7zLXYhNZDSr6gPUfOe97yW6PTg5Gnkiedof17BTdnu7Y9TBM4DfLKr0TwAc+KTQs/1mFmQ6+Vd+Nj
        1EbaAZTCB5MQNLlkF872l0XWIVQUf7wkglApOyfuIqVAyASQT/JS/W/OWxpkmXQfcpA/2d2kDYmms
        jHno/2pSqDQTHs28KYWCKhhSliHO5MuJKjTqBI5sEtUOlDN41vGidNjfql9oO0H8cerNNtCLjPB5Z
        LbtdXfI5vcu1AGkKZYFjZYIXCuCYjWOvX0ivUOCti9UbgcoNpPF0jOgG9YCSpmEbG3emEiNZLjtuD
        vx1rTrlZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVAun-0001IS-OA; Mon, 27 May 2019 08:23:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C55A720137ADA; Mon, 27 May 2019 10:23:26 +0200 (CEST)
Date:   Mon, 27 May 2019 10:23:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4] locking/lock_events: Use this_cpu_add() when necessary
Message-ID: <20190527082326.GP2623@hirez.programming.kicks-ass.net>
References: <20190524194222.8398-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524194222.8398-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:42:22PM -0400, Waiman Long wrote:
> +#ifdef CONFIG_DEBUG_PREEMPT
> +#define lockevent_percpu_inc(x)		this_cpu_inc(x)
> +#define lockevent_percpu_add(x, v)	this_cpu_add(x, v)
> +#else
> +#define lockevent_percpu_inc(x)		__this_cpu_inc(x)
> +#define lockevent_percpu_add(x, v)	__this_cpu_add(x, v)
> +#endif

That's disguisting... I see Linus already applied it, but yuck. That's
what we have raw_cpu_*() for.

Something like the below perhaps.

---

diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index 46b71af8eef2..8c7e7d25f09c 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -31,50 +31,13 @@ enum lock_events {
 DECLARE_PER_CPU(unsigned long, lockevents[lockevent_num]);
 
 /*
- * The purpose of the lock event counting subsystem is to provide a low
- * overhead way to record the number of specific locking events by using
- * percpu counters. It is the percpu sum that matters, not specifically
- * how many of them happens in each cpu.
- *
- * It is possible that the same percpu counter may be modified in both
- * the process and interrupt contexts. For architectures that perform
- * percpu operation with multiple instructions, it is possible to lose
- * count if a process context percpu update is interrupted in the middle
- * and the same counter is updated in the interrupt context. Therefore,
- * the generated percpu sum may not be precise. The error, if any, should
- * be small and insignificant.
- *
- * For those architectures that do multi-instruction percpu operation,
- * preemption in the middle and moving the task to another cpu may cause
- * a larger error in the count. Again, this will be few and far between.
- * Given the imprecise nature of the count and the possibility of resetting
- * the count and doing the measurement again, this is not really a big
- * problem.
- *
- * To get a better picture of what is happening under the hood, it is
- * suggested that a few measurements should be taken with the counts
- * reset in between to stamp out outliner because of these possible
- * error conditions.
- *
- * To minimize overhead, we use __this_cpu_*() in all cases except when
- * CONFIG_DEBUG_PREEMPT is defined. In this particular case, this_cpu_*()
- * will be used to avoid the appearance of unwanted BUG messages.
- */
-#ifdef CONFIG_DEBUG_PREEMPT
-#define lockevent_percpu_inc(x)		this_cpu_inc(x)
-#define lockevent_percpu_add(x, v)	this_cpu_add(x, v)
-#else
-#define lockevent_percpu_inc(x)		__this_cpu_inc(x)
-#define lockevent_percpu_add(x, v)	__this_cpu_add(x, v)
-#endif
-
-/*
- * Increment the PV qspinlock statistical counters
+ * Increment the statistical counters. use raw_cpu_inc() because of lower
+ * overhead and we don't care if we loose the occasional update.
  */
 static inline void __lockevent_inc(enum lock_events event, bool cond)
 {
 	if (cond)
-		lockevent_percpu_inc(lockevents[event]);
+		raw_cpu_inc(lockevents[event]);
 }
 
 #define lockevent_inc(ev)	  __lockevent_inc(LOCKEVENT_ ##ev, true)
@@ -82,7 +45,7 @@ static inline void __lockevent_inc(enum lock_events event, bool cond)
 
 static inline void __lockevent_add(enum lock_events event, int inc)
 {
-	lockevent_percpu_add(lockevents[event], inc);
+	raw_cpu_add(lockevents[event], inc);
 }
 
 #define lockevent_add(ev, c)	__lockevent_add(LOCKEVENT_ ##ev, c)


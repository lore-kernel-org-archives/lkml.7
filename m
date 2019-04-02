Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C93C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896142084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQOTi2Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbfDBI22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:28:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53170 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ILUHKsUfn/mk416QsVy2aU9MFH9mS6iWQedO1xJFU88=; b=gQOTi2Zx2n69shgOOBx10+bV3
        qDAG2IG94qF9pU2EJHYAUNI1vS1wCo0vV+GK/ToZFR2Urmec6AyFOBgI++L/RACoqDzaDlitsYd1c
        bepD/KXupMLuwodzlMXeHwr47asigQ6wHkODnz4cPYO90Fry189RVhW4BBffDmCx+SSXJW+/GMuAB
        chrKssnh0xzjqXTPhcol5ae07RNkxCLMmh/7Jr8DlF8a82O7wkzrfg/shVDwvf7ck7C1FRzDaeQis
        kq+9WPxzE7hx6PJ4/VuYBz2NrTzp10rvIcI1MHQnzlZZ9AtuzkOe8dYcas0ZaLnstMSJUbeXvpYPx
        3+YTKKReA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBEmE-0000Ov-TY; Tue, 02 Apr 2019 08:28:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2066329A270FB; Tue,  2 Apr 2019 10:28:12 +0200 (CEST)
Date:   Tue, 2 Apr 2019 10:28:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20190402082812.GJ12232@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.667598558@infradead.org>
 <20190402064612.GA46500@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402064612.GA46500@aaronlu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:46:13PM +0800, Aaron Lu wrote:
> On Mon, Feb 18, 2019 at 05:56:33PM +0100, Peter Zijlstra wrote:

> > +static struct task_struct *
> > +pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
> > +{
> > +	struct task_struct *class_pick, *cookie_pick;
> > +	unsigned long cookie = 0UL;
> > +
> > +	/*
> > +	 * We must not rely on rq->core->core_cookie here, because we fail to reset
> > +	 * rq->core->core_cookie on new picks, such that we can detect if we need
> > +	 * to do single vs multi rq task selection.
> > +	 */
> > +
> > +	if (max && max->core_cookie) {
> > +		WARN_ON_ONCE(rq->core->core_cookie != max->core_cookie);
> > +		cookie = max->core_cookie;
> > +	}
> > +
> > +	class_pick = class->pick_task(rq);
> > +	if (!cookie)
> > +		return class_pick;
> > +
> > +	cookie_pick = sched_core_find(rq, cookie);
> > +	if (!class_pick)
> > +		return cookie_pick;
> > +
> > +	/*
> > +	 * If class > max && class > cookie, it is the highest priority task on
> > +	 * the core (so far) and it must be selected, otherwise we must go with
> > +	 * the cookie pick in order to satisfy the constraint.
> > +	 */
> > +	if (cpu_prio_less(cookie_pick, class_pick) && cpu_prio_less(max, class_pick))
> > +		return class_pick;
> 
> I have a question about the use of cpu_prio_less(max, class_pick) here
> and core_prio_less(max, p) below in pick_next_task().
> 
> Assume cpu_prio_less(max, class_pick) thinks class_pick has higher
> priority and class_pick is returned here. Then in pick_next_task(),
> core_prio_less(max, p) is used to decide if max should be replaced.
> Since core_prio_less(max, p) doesn't compare vruntime, it could return
> fasle for this class_pick and the same max. Then max isn't replaced
> and we could end up scheduling two processes belonging to two different
> cgroups...

> > +
> > +	return cookie_pick;
> > +}
> > +
> > +static struct task_struct *
> > +pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > +{

> > +			/*
> > +			 * If this new candidate is of higher priority than the
> > +			 * previous; and they're incompatible; we need to wipe
> > +			 * the slate and start over.
> > +			 *
> > +			 * NOTE: this is a linear max-filter and is thus bounded
> > +			 * in execution time.
> > +			 */
> > +			if (!max || core_prio_less(max, p)) {
> 
> This is the place to decide if max should be replaced.

Hummm.... very good spotting that. Yes, I'm afraid you're very much
right about this.

> Perhaps we can test if max is on the same cpu as class_pick and then
> use cpu_prio_less() or core_prio_less() accordingly here, or just
> replace core_prio_less(max, p) with cpu_prio_less(max, p) in
> pick_next_task(). The 2nd obviously breaks the comment of
> core_prio_less() though: /* cannot compare vruntime across CPUs */.

Right, so as the comment states, you cannot directly compare vruntime
across CPUs, doing that is completely buggered.

That also means that the cpu_prio_less(max, class_pick) in pick_task()
is buggered, because there is no saying @max is on this CPU to begin
with.

Changing that to core_prio_less() doesn't fix this though.

> I'm still evaluating, your comments are appreciated.

We could change the above condition to:

		if (!max || !cookie_match(max, p))

I suppose. But please double check the thikning.



> > +				struct task_struct *old_max = max;
> > +
> > +				rq->core->core_cookie = p->core_cookie;
> > +				max = p;
> > +
> > +				if (old_max && !cookie_match(old_max, p)) {
> > +					for_each_cpu(j, smt_mask) {
> > +						if (j == i)
> > +							continue;
> > +
> > +						cpu_rq(j)->core_pick = NULL;
> > +					}
> > +					goto again;
> > +				}
> > +			}
> > +		}
> > +next_class:;
> > +	}


Another approach would be something like the below:


--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -87,7 +87,7 @@ static inline int __task_prio(struct tas
  */
 
 /* real prio, less is less */
-static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool runtime)
+static inline bool __prio_less(struct task_struct *a, struct task_struct *b, u64 vruntime)
 {
 	int pa = __task_prio(a), pb = __task_prio(b);
 
@@ -104,21 +104,25 @@ static inline bool __prio_less(struct ta
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE && runtime) /* fair */
-		return !((s64)(a->se.vruntime - b->se.vruntime) < 0);
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return !((s64)(a->se.vruntime - vruntime) < 0);
 
 	return false;
 }
 
 static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
 {
-	return __prio_less(a, b, true);
+	return __prio_less(a, b, b->se.vruntime);
 }
 
 static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
 {
-	/* cannot compare vruntime across CPUs */
-	return __prio_less(a, b, false);
+	u64 vruntime = b->se.vruntime;
+
+	vruntime -= task_rq(b)->cfs.min_vruntime;
+	vruntime += task_rq(a)->cfs.min_vruntime
+
+	return __prio_less(a, b, vruntime);
 }
 
 static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)

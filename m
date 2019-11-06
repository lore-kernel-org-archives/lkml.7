Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76360C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37591214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T/i/LwYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfKFMGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:06:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfKFMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h7Q/VpWcRolkxnzJlWRo5ZIwRLYBOQsoWn2rdGM8xD4=; b=T/i/LwYNe01OEFCR+Bfyd6Hk7
        bLAWCEdvGjEDw26YFQTAcyEv8cQP0GvHeyQY9ROjp2mMeKoo/yIksU/UvoCLVa0xztNyYUqOKSdTi
        bHJP338uFEXvnojdE9BrAChihrXKkYfrJIVrV7CFi284+mRlpk+7TEQXM2DGo2xyVbmzKS4psXV3W
        B0AFOq8TYnFPrkq8EdrTzRPkD37pNOdn0Ouk118gtk7KX7YqFHl58fZ0iQaBUeDlpd29rz1rTI1kH
        8/WzwwJPW4AKaAguL+9qTqIxi9WKt8xKKUt0u8jM7Th2C5hcPgZ6UX9w0jVhMmIX1fDDyzEEu1pNx
        zmSGqSlyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSK42-0006dA-Ou; Wed, 06 Nov 2019 12:05:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2ABF300692;
        Wed,  6 Nov 2019 13:04:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C46C12025EDB2; Wed,  6 Nov 2019 13:05:25 +0100 (CET)
Date:   Wed, 6 Nov 2019 13:05:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191106120525.GX4131@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028174603.GA246917@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:46:03PM +0000, Quentin Perret wrote:
> 
> After digging a bit, the offending commit seems to be:
> 
>     67692435c411 ("sched: Rework pick_next_task() slow-path")
> 
> By 'offending' I mean that reverting it makes the issue go away. The
> issue comes from the fact that pick_next_entity() returns a NULL se in
> the 'simple' path of pick_next_task_fair(), which causes obvious
> problems in the subsequent call to set_next_entity().
> 
> I'll dig more, but if anybody understands the issue in the meatime feel
> free to send me a patch to try out :)

So for all those who didn't follow along on IRC, the below seems to cure
things.

The only thing I'm now considering is if we shouldn't be setting
->on_cpu=2 _before_ calling put_prev_task(). I'll go audit the RT/DL
cases.

---
Subject: sched: Fix pick_next_task() vs 'change' pattern race
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Nov 4 22:18:14 CET 2019

Commit 67692435c411 ("sched: Rework pick_next_task() slow-path")
inadvertly introduced a race because it changed a previously
unexplored dependency between dropping the rq->lock and
sched_class::put_prev_task().

The comments about dropping rq->lock, in for example
newidle_balance(), only mentions the task being current and ->on_cpu
being set. But when we look at the 'change' pattern (in for example
sched_setnuma()):

	queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
	running = task_current(rq, p); /* rq->curr == p */

	if (queued)
		dequeue_task(...);
	if (running)
		put_prev_task(...);

	/* change task properties */

	if (queued)
		enqueue_task(...);
	if (running)
		set_next_task(...);

It becomes obvious that if we do this after put_prev_task() has
already been called on @p, things go sideways. This is exactly what
the commit in question allows to happen when it does:

	prev->sched_class->put_prev_task(rq, prev, rf);
	if (!rq->nr_running)
		newidle_balance(rq, rf);

The newidle_balance() call will drop rq->lock after we've called
put_prev_task() and that allows the above 'change' pattern to
interleave and mess up the state.

The order in pick_next_task() is mandated by the fact that RT/DL
put_prev_task() can pull other RT tasks, in which case we should not
call newidle_balance() since we'll not be going idle. Similarly, we
cannot put newidle_balance() in put_prev_task_fair() because it should
be called every time we'll end up selecting the idle task.

Given that we're stuck with this order, the only solution is fixing
the 'change' pattern. The simplest fix seems to be to 'absuse'
p->on_cpu to carry more state. Adding more state to p->on_rq is
possible but is far more invasive and also ends up duplicating much of
the state we already carry in p->on_cpu.

Introduce task_on_rq_curr() to indicate the if
sched_class::set_next_task() has been called -- and we thus need to
call put_prev_task().

Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Quentin Perret <qperret@google.com>
Tested-by: Qais Yousef <qais.yousef@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |   22 +++++++++++++++-------
 kernel/sched/sched.h |   16 ++++++++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1595,7 +1595,7 @@ void do_set_cpus_allowed(struct task_str
 	lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 
 	if (queued) {
 		/*
@@ -3934,8 +3934,16 @@ pick_next_task(struct rq *rq, struct tas
 	 * can PULL higher prio tasks when we lower the RQ 'priority'.
 	 */
 	prev->sched_class->put_prev_task(rq, prev, rf);
-	if (!rq->nr_running)
+#ifdef CONFIG_SMP
+	if (!rq->nr_running) {
+		/*
+		 * Make sure task_on_rq_curr() fails, such that we don't do
+		 * put_prev_task() + set_next_task() on this task again.
+		 */
+		prev->on_cpu = 2;
 		newidle_balance(rq, rf);
+	}
+#endif
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq, NULL, NULL);
@@ -4422,7 +4430,7 @@ void rt_mutex_setprio(struct task_struct
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -4509,7 +4517,7 @@ void set_user_nice(struct task_struct *p
 		goto out_unlock;
 	}
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -4957,7 +4965,7 @@ static int __sched_setscheduler(struct t
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -6141,7 +6149,7 @@ void sched_setnuma(struct task_struct *p
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -7031,7 +7039,7 @@ void sched_move_task(struct task_struct
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_on_rq_curr(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1628,6 +1628,22 @@ static inline int task_running(struct rq
 #endif
 }
 
+/*
+ * If true, @p has had sched_class::set_next_task() called on it.
+ * See pick_next_task().
+ */
+static inline bool task_on_rq_curr(struct rq *rq, struct task_struct *p)
+{
+#ifdef CONFIG_SMP
+	return rq->curr == p && p->on_cpu == 1;
+#else
+	return rq->curr == p;
+#endif
+}
+
+/*
+ * If true, @p has has sched_class::enqueue_task() called on it.
+ */
 static inline int task_on_rq_queued(struct task_struct *p)
 {
 	return p->on_rq == TASK_ON_RQ_QUEUED;

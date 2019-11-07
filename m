Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F3C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880C32178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XG9AjzbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfKGN0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:26:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388250AbfKGN0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qbs4Unt62pEeVFmxllR77NlFdcNg9z3uuNGSR69iJ2Q=; b=XG9AjzbXAdjzzis5psEwBRXMT
        sLX248EjswxOfJyF56y9paAcqPw1z0+63UReVvGxivi4JhCv/5yuAAMdp3QobligJDt2hdUxQ2lQr
        ErQFGGpxD52Wlz4iAsGp6Mj2NBZr6t4bkHay5HW0yGed5urBQc4TAqRmqdJHUSFk/xlkO86P7A7Gw
        W1tCRfNCEvCxuJ13TauQYYFms/x3EQKAvKoeqO2tdoTSesJWbJvz4JQATRD8Si1s9oomCnwOhShq8
        hQEJMHoWoLOId4SNTFE7mHjiS57V1raOGDlGF9S4G/c9ZM2JF5u6Z8lgssRUktj6hxt/FMX7eV0eE
        5UWQx6mvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iShnz-0004CJ-Bu; Thu, 07 Nov 2019 13:26:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B8EB301A79;
        Thu,  7 Nov 2019 14:25:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB57220241336; Thu,  7 Nov 2019 14:26:28 +0100 (CET)
Date:   Thu, 7 Nov 2019 14:26:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:36:50AM +0300, Kirill Tkhai wrote:
> On 06.11.2019 20:27, Peter Zijlstra wrote:
> > On Wed, Nov 06, 2019 at 05:54:37PM +0100, Peter Zijlstra wrote:
> >> On Wed, Nov 06, 2019 at 06:51:40PM +0300, Kirill Tkhai wrote:
> >>>> +#ifdef CONFIG_SMP
> >>>> +	if (!rq->nr_running) {
> >>>> +		/*
> >>>> +		 * Make sure task_on_rq_curr() fails, such that we don't do
> >>>> +		 * put_prev_task() + set_next_task() on this task again.
> >>>> +		 */
> >>>> +		prev->on_cpu = 2;
> >>>>  		newidle_balance(rq, rf);
> >>>
> >>> Shouldn't we restore prev->on_cpu = 1 after newidle_balance()? Can't prev
> >>> become pickable again after newidle_balance() releases rq->lock, and we
> >>> take it again, so this on_cpu == 2 never will be cleared?
> >>
> >> Indeed so.
> > 
> > Oh wait, the way it was written this is not possible. Because
> > rq->nr_running == 0 and prev->on_cpu > 0 it means the current task is
> > going to sleep and cannot be woken back up.
> 
> I mostly mean throttling. AFAIR, tasks of throttled rt_rq are not accounted
> in rq->nr_running. But it seems rt_rq may become unthrottled again after
> newidle_balance() unlocks rq lock, and prev will become pickable again.

Urgh... throttling.

Bah.. I had just named the "->on_cpu = 2" thing leave_task(), to match
prepare_task() and finish_task(), but when we have to flip it back to 1
that doesn't really work.

Also, I'm still flip-flopping on where to place it. Yesterday I
suggested placing it before put_prev_task(), but then I went to write a
comment, and either way around put_prev_task() needs to be very careful.

So I went back to placing it after and putting lots of comments on.

How does the below look?

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
 kernel/sched/core.c     |   35 ++++++++++++++++++++++++++++-------
 kernel/sched/deadline.c |    9 +++++++++
 kernel/sched/rt.c       |    9 +++++++++
 kernel/sched/sched.h    |   21 +++++++++++++++++++++
 4 files changed, 67 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1595,7 +1595,7 @@ void do_set_cpus_allowed(struct task_str
 	lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 
 	if (queued) {
 		/*
@@ -3078,6 +3078,19 @@ static inline void prepare_task(struct t
 #endif
 }
 
+static inline void leave_task(struct task_struct *prev)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * The task is on its way out, we'll have called put_prev_task() on it.
+	 *
+	 * Make sure task_on_rq_curr() fails, such that we don't do
+	 * put_prev_task() + set_next_task() on this task again.
+	 */
+	prev->on_cpu = 2;
+#endif
+}
+
 static inline void finish_task(struct task_struct *prev)
 {
 #ifdef CONFIG_SMP
@@ -3934,8 +3947,16 @@ pick_next_task(struct rq *rq, struct tas
 	 * can PULL higher prio tasks when we lower the RQ 'priority'.
 	 */
 	prev->sched_class->put_prev_task(rq, prev, rf);
-	if (!rq->nr_running)
+	if (!rq->nr_running) {
+		leave_task(prev);
 		newidle_balance(rq, rf);
+		/*
+		 * When the below pick loop results in @p == @prev, then we
+		 * will not go through context_switch() but the
+		 * pick_next_task() will have done set_next_task() again.
+		 */
+		prepare_task(prev);
+	}
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq, NULL, NULL);
@@ -4422,7 +4443,7 @@ void rt_mutex_setprio(struct task_struct
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -4509,7 +4530,7 @@ void set_user_nice(struct task_struct *p
 		goto out_unlock;
 	}
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -4957,7 +4978,7 @@ static int __sched_setscheduler(struct t
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -6141,7 +6162,7 @@ void sched_setnuma(struct task_struct *p
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_on_rq_curr(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -7031,7 +7052,7 @@ void sched_move_task(struct task_struct
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_on_rq_curr(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1778,6 +1778,15 @@ pick_next_task_dl(struct rq *rq, struct
 	return p;
 }
 
+/*
+ * As per the note for sched_class::put_prev_task() we must only drop
+ * the rq->lock before any permanent state change.
+ *
+ * In this case, the state change and the pull action are mutually exclusive.
+ * If @prev is still on the runqueue, the priority will not have dropped and we
+ * don't need to pull. If @prev is no longer on the runqueue we don't need
+ * to add it back to the pushable list.
+ */
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
 	update_curr_dl(rq);
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1566,6 +1566,15 @@ pick_next_task_rt(struct rq *rq, struct
 	return p;
 }
 
+/*
+ * As per the note for sched_class::put_prev_task() we must only drop
+ * the rq->lock before any permanent state change.
+ *
+ * In this case, the state change and the pull action are mutually exclusive.
+ * If @prev is still on the runqueue, the priority will not have dropped and we
+ * don't need to pull. If @prev is no longer on the runqueue we don't need
+ * to add it back to the pushable list.
+ */
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
 	update_curr_rt(rq);
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
@@ -1727,6 +1743,11 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
+	/*
+	 * When put_prev_task() drops the rq->lock (RT/DL) it must do this
+	 * before any effective state change, such that a nested
+	 * 'put_prev_task() + set_next_task' pair will work correctly.
+	 */
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 

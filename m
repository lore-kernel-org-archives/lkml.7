Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611B0FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205662084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mZGlr1CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403802AbfKHL4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:56:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389715AbfKHL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rt0cBAqjkAXJh9O4x4c8DVDARkw/ZG57+S0UVTBi104=; b=mZGlr1CNUkbl8GO8qF9eSwEsW
        ztAXz1ys6dMuN8lSBG8vBmP/1KWYa5iqBxK9xWBgg+Tul6zd5FqriUUhSh5NPgCKeOKD7let8LEeV
        FwigUm8JDUOvpBwVMcAjT0J2q5f5AzBGzuiT4q/bx3F3WZ5AEfjYRcifUiSBmutihLEZ10xysG7M2
        Qp9uh/fs+iPTDdPuNL9PKxVV6C012MgMbnJzcLNgEm+/BF7mGSnaUYzH3jtKIMhKf9GCXI+KBU9Ey
        VpeCsslx1OMGWnH1eDvwaaRGfboNEN6oIpwU/df5mYAQ7/4f2ipK66Vdb3m/2f9pU64RlD+fJfc2B
        +y9ULCpqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT2rw-0003Al-5K; Fri, 08 Nov 2019 11:56:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E19D3075D7;
        Fri,  8 Nov 2019 12:54:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B04E2025EDB2; Fri,  8 Nov 2019 12:55:57 +0100 (CET)
Date:   Fri, 8 Nov 2019 12:55:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108115557.GP5671@hirez.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107192907.GA30258@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 08:29:07PM +0100, Peter Zijlstra wrote:
> I still havne't had food, but this here compiles...

A more polished patch.

---
Subject: sched: Fix pick_next_task() vs 'change' pattern race
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Nov 8 11:11:52 CET 2019

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

Furthermore, it turns out we lost the RT-pull when we put the last DL
task.

Fix both problems by extracting the balancing from put_prev_task() and
doing a multi-class balance() pass before put_prev_task().

Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   17 +++++++++--------
 kernel/sched/deadline.c  |   40 ++++++++++++++++++++--------------------
 kernel/sched/fair.c      |   15 ++++++++++++---
 kernel/sched/idle.c      |    9 ++++++++-
 kernel/sched/rt.c        |   37 +++++++++++++++++++------------------
 kernel/sched/sched.h     |   30 +++++++++++++++++++++++++++---
 kernel/sched/stop_task.c |   18 +++++++++++-------
 7 files changed, 106 insertions(+), 60 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3929,13 +3929,14 @@ pick_next_task(struct rq *rq, struct tas
 	}
 
 restart:
-	/*
-	 * Ensure that we put DL/RT tasks before the pick loop, such that they
-	 * can PULL higher prio tasks when we lower the RQ 'priority'.
-	 */
-	prev->sched_class->put_prev_task(rq, prev, rf);
-	if (!rq->nr_running)
-		newidle_balance(rq, rf);
+#ifdef CONFIG_SMP
+	for_class_range(class, prev->sched_class, &idle_sched_class) {
+		if (class->balance(rq, prev, rf))
+			break;
+	}
+#endif
+
+	put_prev_task(rq, prev);
 
 	for_each_class(class) {
 		p = class->pick_next_task(rq, NULL, NULL);
@@ -6201,7 +6202,7 @@ static struct task_struct *__pick_migrat
 	for_each_class(class) {
 		next = class->pick_next_task(rq, NULL, NULL);
 		if (next) {
-			next->sched_class->put_prev_task(rq, next, NULL);
+			next->sched_class->put_prev_task(rq, next);
 			return next;
 		}
 	}
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1691,6 +1691,22 @@ static void check_preempt_equal_dl(struc
 	resched_curr(rq);
 }
 
+static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+{
+	if (!on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+
+	return sched_stop_runnable(rq) || sched_dl_runnable(rq);
+}
 #endif /* CONFIG_SMP */
 
 /*
@@ -1758,45 +1774,28 @@ static struct task_struct *
 pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
+	struct dl_rq *dl_rq = &rq->dl;
 	struct task_struct *p;
-	struct dl_rq *dl_rq;
 
 	WARN_ON_ONCE(prev || rf);
 
-	dl_rq = &rq->dl;
-
-	if (unlikely(!dl_rq->dl_nr_running))
+	if (!sched_dl_runnable(rq))
 		return NULL;
 
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
-
 	p = dl_task_of(dl_se);
-
 	set_next_task_dl(rq, p);
-
 	return p;
 }
 
-static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
-
-	if (rf && !on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we've
-		 * not yet started the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_dl_task(rq);
-		rq_repin_lock(rq, rf);
-	}
 }
 
 /*
@@ -2442,6 +2441,7 @@ const struct sched_class dl_sched_class
 	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6423,6 +6423,15 @@ static void task_dead_fair(struct task_s
 {
 	remove_entity_load_avg(&p->se);
 }
+
+static int
+balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	if (rq->nr_running)
+		return 1;
+
+	return newidle_balance(rq, rf) != 0;
+}
 #endif /* CONFIG_SMP */
 
 static unsigned long wakeup_gran(struct sched_entity *se)
@@ -6599,7 +6608,7 @@ pick_next_task_fair(struct rq *rq, struc
 	int new_tasks;
 
 again:
-	if (!cfs_rq->nr_running)
+	if (!sched_fair_runnable(rq))
 		goto idle;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -6737,7 +6746,7 @@ done: __maybe_unused;
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
@@ -10597,11 +10606,11 @@ const struct sched_class fair_sched_clas
 	.check_preempt_curr	= check_preempt_wakeup,
 
 	.pick_next_task		= pick_next_task_fair,
-
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -365,6 +365,12 @@ select_task_rq_idle(struct task_struct *
 {
 	return task_cpu(p); /* IDLE tasks as never migrated */
 }
+
+static int
+balance_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return WARN_ON_ONCE(1);
+}
 #endif
 
 /*
@@ -375,7 +381,7 @@ static void check_preempt_curr_idle(stru
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
 }
 
@@ -460,6 +466,7 @@ const struct sched_class idle_sched_clas
 	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1469,6 +1469,22 @@ static void check_preempt_equal_prio(str
 	resched_curr(rq);
 }
 
+static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+{
+	if (!on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
+		/*
+		 * This is OK, because current is on_cpu, which avoids it being
+		 * picked for load-balance and preemption/IRQs are still
+		 * disabled avoiding further scheduler activity on it and we've
+		 * not yet started the picking loop.
+		 */
+		rq_unpin_lock(rq, rf);
+		pull_rt_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+
+	return sched_stop_runnable(rq) || sched_dl_runnable(rq) || sched_rt_runnable(rq);
+}
 #endif /* CONFIG_SMP */
 
 /*
@@ -1552,21 +1568,18 @@ static struct task_struct *
 pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *p;
-	struct rt_rq *rt_rq = &rq->rt;
 
 	WARN_ON_ONCE(prev || rf);
 
-	if (!rt_rq->rt_queued)
+	if (!sched_rt_runnable(rq))
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-
 	set_next_task_rt(rq, p);
-
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	update_curr_rt(rq);
 
@@ -1578,18 +1591,6 @@ static void put_prev_task_rt(struct rq *
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_task(rq, p);
-
-	if (rf && !on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
-		/*
-		 * This is OK, because current is on_cpu, which avoids it being
-		 * picked for load-balance and preemption/IRQs are still
-		 * disabled avoiding further scheduler activity on it and we've
-		 * not yet started the picking loop.
-		 */
-		rq_unpin_lock(rq, rf);
-		pull_rt_task(rq);
-		rq_repin_lock(rq, rf);
-	}
 }
 
 #ifdef CONFIG_SMP
@@ -2366,8 +2367,8 @@ const struct sched_class rt_sched_class
 	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_rt,
 	.select_task_rq		= select_task_rq_rt,
-
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
 	.rq_offline             = rq_offline_rt,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1727,10 +1727,11 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
+	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
@@ -1773,7 +1774,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev, NULL);
+	prev->sched_class->put_prev_task(rq, prev);
 }
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
@@ -1787,8 +1788,12 @@ static inline void set_next_task(struct
 #else
 #define sched_class_highest (&dl_sched_class)
 #endif
+
+#define for_class_range(class, _from, _to) \
+	for (class = (_from); class != (_to); class = class->next)
+
 #define for_each_class(class) \
-   for (class = sched_class_highest; class; class = class->next)
+	for_class_range(class, sched_class_highest, NULL)
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
@@ -1796,6 +1801,25 @@ extern const struct sched_class rt_sched
 extern const struct sched_class fair_sched_class;
 extern const struct sched_class idle_sched_class;
 
+static inline bool sched_stop_runnable(struct rq *rq)
+{
+	return rq->stop && task_on_rq_queued(rq->stop);
+}
+
+static inline bool sched_dl_runnable(struct rq *rq)
+{
+	return rq->dl.dl_nr_running > 0;
+}
+
+static inline bool sched_rt_runnable(struct rq *rq)
+{
+	return rq->rt.rt_queued > 0;
+}
+
+static inline bool sched_fair_runnable(struct rq *rq)
+{
+	return rq->cfs.nr_running > 0;
+}
 
 #ifdef CONFIG_SMP
 
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -15,6 +15,12 @@ select_task_rq_stop(struct task_struct *
 {
 	return task_cpu(p); /* stop tasks as never migrate */
 }
+
+static int
+balance_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return sched_stop_runnable(rq);
+}
 #endif /* CONFIG_SMP */
 
 static void
@@ -31,16 +37,13 @@ static void set_next_task_stop(struct rq
 static struct task_struct *
 pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *stop = rq->stop;
-
 	WARN_ON_ONCE(prev || rf);
 
-	if (!stop || !task_on_rq_queued(stop))
+	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, stop);
-
-	return stop;
+	set_next_task_stop(rq, rq->stop);
+	return rq->stop;
 }
 
 static void
@@ -60,7 +63,7 @@ static void yield_task_stop(struct rq *r
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
 	struct task_struct *curr = rq->curr;
 	u64 delta_exec;
@@ -129,6 +132,7 @@ const struct sched_class stop_sched_clas
 	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
+	.balance		= balance_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif

Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851182087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+6/owWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKGT32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:29:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfKGT32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mruhdMayNO2zUrJBpiSsPdMto9fSfmHFCyz85Qb9jD0=; b=Q+6/owWVKe6k6WUgnm+Ib+p3c
        3hxnrYfA186dZ63J3pmEtQWM+morOPU5k+tEUNA79jR3qvSOmJdTk7JDlKgi0c4oiOM5FAlXfFHU9
        FhUxqh8KSIqfdKgwld38QlVuFa7nobj7MBspryjobC06DxTva9EnehBD39BMUZKGLUAjUkUjkAolx
        Gg9vC2w4yzeV6o0ONIbFKIfyHFYYhLV2WWIABKuze8sBfqMfhX6CDhY8W6Fw8S6DwZRnDequDN2vb
        NJS5MWpPM3tiZ7Rmhv9juCrdzdHSXP0S/REUtPVcR4W+qEt5y4SUkpFMMrFOVlp/NhMVnipPiassf
        BXGHO/2LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSnT1-0003EL-Tu; Thu, 07 Nov 2019 19:29:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64E37980E2D; Thu,  7 Nov 2019 20:29:07 +0100 (CET)
Date:   Thu, 7 Nov 2019 20:29:07 +0100
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
Message-ID: <20191107192907.GA30258@worktop.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107184356.GF4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 07:43:56PM +0100, Peter Zijlstra wrote:
> But you mean something like:
> 
> 	for (class = prev->sched_class; class; class = class->next) {
> 		if (class->balance(rq, rf))
> 			break;
> 	}
> 
> 	put_prev_task(rq, prev);
> 
> 	for_each_class(class) {
> 		p = class->pick_next_task(rq);
> 		if (p)
> 			return p;
> 	}
> 
> 	BUG();
> 
> like?

I still havne't had food, but this here compiles...

---
 kernel/sched/core.c      | 20 ++++++++++++--------
 kernel/sched/deadline.c  | 23 +++++++++++++++--------
 kernel/sched/fair.c      | 12 ++++++++++--
 kernel/sched/idle.c      |  8 +++++++-
 kernel/sched/rt.c        | 32 +++++++++++++++++++-------------
 kernel/sched/sched.h     |  5 +++--
 kernel/sched/stop_task.c |  8 +++++++-
 7 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb42b71faab9..d9909606806d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3929,13 +3929,17 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
+	for (class = prev->sched_class;
+	     class != &idle_sched_class;
+	     class = class->next) {
+
+		if (class->balance(rq, prev, rf))
+			break;
+	}
+#endif
+
+	put_prev_task(rq, prev);

 	for_each_class(class) {
 		p = class->pick_next_task(rq, NULL, NULL);
@@ -6201,7 +6205,7 @@ static struct task_struct *__pick_migrate_task(struct rq *rq)
 	for_each_class(class) {
 		next = class->pick_next_task(rq, NULL, NULL);
 		if (next) {
-			next->sched_class->put_prev_task(rq, next, NULL);
+			next->sched_class->put_prev_task(rq, next);
 			return next;
 		}
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2dc48720f189..b6c3fb10cf57 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1778,15 +1778,9 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return p;
 }

-static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
-	update_curr_dl(rq);
-
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
-	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_dl_task(rq, p);
-
-	if (rf && !on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
+	if (!on_dl_rq(&p->dl) && need_pull_dl_task(rq, p)) {
 		/*
 		 * This is OK, because current is on_cpu, which avoids it being
 		 * picked for load-balance and preemption/IRQs are still
@@ -1797,6 +1791,18 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct rq_fla
 		pull_dl_task(rq);
 		rq_repin_lock(rq, rf);
 	}
+
+	return rq->dl.dl_nr_running > 0;
+}
+
+
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
+{
+	update_curr_dl(rq);
+
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
+	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
+		enqueue_pushable_dl_task(rq, p);
 }

 /*
@@ -2438,6 +2444,7 @@ const struct sched_class dl_sched_class = {
 	.check_preempt_curr	= check_preempt_curr_dl,

 	.pick_next_task		= pick_next_task_dl,
+	.balance		= balance_dl,
 	.put_prev_task		= put_prev_task_dl,
 	.set_next_task		= set_next_task_dl,

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a14487462b6c..6b983214e00f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6746,10 +6746,18 @@ done: __maybe_unused;
 	return NULL;
 }

+static int balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	if (rq->cfs.nr_running)
+		return 1;
+
+	return newidle_balance(rq, rf) != 0;
+}
+
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
@@ -10609,7 +10617,7 @@ const struct sched_class fair_sched_class = {
 	.check_preempt_curr	= check_preempt_wakeup,

 	.pick_next_task		= pick_next_task_fair,
-
+	.balance		= balance_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa600ea..2ff65fd2fe7e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -375,7 +375,12 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }

-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static int balance_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return 1; /* always runnable */
+}
+
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
 }

@@ -456,6 +461,7 @@ const struct sched_class idle_sched_class = {
 	.check_preempt_curr	= check_preempt_curr_idle,

 	.pick_next_task		= pick_next_task_idle,
+	.balance		= balance_idle,
 	.put_prev_task		= put_prev_task_idle,
 	.set_next_task          = set_next_task_idle,

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ebaa4e619684..3aa3e0fca796 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1566,20 +1566,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return p;
 }

-static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
+static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 {
-	update_curr_rt(rq);
-
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
-
-	/*
-	 * The previous task needs to be made eligible for pushing
-	 * if it is still active
-	 */
-	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
-
-	if (rf && !on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
+	if (!on_rt_rq(&p->rt) && need_pull_rt_task(rq, p)) {
 		/*
 		 * This is OK, because current is on_cpu, which avoids it being
 		 * picked for load-balance and preemption/IRQs are still
@@ -1590,6 +1579,22 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct rq_fla
 		pull_rt_task(rq);
 		rq_repin_lock(rq, rf);
 	}
+
+	return rq->rt.rt_queued > 0;
+}
+
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
+{
+	update_curr_rt(rq);
+
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
+
+	/*
+	 * The previous task needs to be made eligible for pushing
+	 * if it is still active
+	 */
+	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
+		enqueue_pushable_task(rq, p);
 }

 #ifdef CONFIG_SMP
@@ -2362,6 +2367,7 @@ const struct sched_class rt_sched_class = {
 	.check_preempt_curr	= check_preempt_curr_rt,

 	.pick_next_task		= pick_next_task_rt,
+	.balance		= balance_rt,
 	.put_prev_task		= put_prev_task_rt,
 	.set_next_task          = set_next_task_rt,

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..3b50450428dc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1727,7 +1727,8 @@ struct sched_class {
 	struct task_struct * (*pick_next_task)(struct rq *rq,
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct rq_flags *rf);
+	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);

 #ifdef CONFIG_SMP
@@ -1773,7 +1774,7 @@ struct sched_class {
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->curr != prev);
-	prev->sched_class->put_prev_task(rq, prev, NULL);
+	prev->sched_class->put_prev_task(rq, prev);
 }

 static inline void set_next_task(struct rq *rq, struct task_struct *next)
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 7e1cee4e65b2..8a5b3e5540ee 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -60,7 +60,12 @@ static void yield_task_stop(struct rq *rq)
 	BUG(); /* the stop task should never yield, its pointless. */
 }

-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static int balance_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	return 0;
+}
+
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
 	struct task_struct *curr = rq->curr;
 	u64 delta_exec;
@@ -125,6 +130,7 @@ const struct sched_class stop_sched_class = {
 	.check_preempt_curr	= check_preempt_curr_stop,

 	.pick_next_task		= pick_next_task_stop,
+	.balance		= balance_stop,
 	.put_prev_task		= put_prev_task_stop,
 	.set_next_task          = set_next_task_stop,



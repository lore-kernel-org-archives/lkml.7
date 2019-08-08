Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45C8C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A143B2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GT2ZM0qB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfHHK5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:57:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfHHK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:57:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78AvFHo3127800
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:57:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78AvFHo3127800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261836;
        bh=tcmcAhyf7z7pLX/p5cR2ZjNg0sEyBXgzBf+TUi5m8vI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GT2ZM0qBEluzujLKokj19FUqpL5doWNw+QXr9eiKcPfUceODgA+2gLsJyASOUva/4
         GTyuLteIP+IiaHW0HqqWy1sZPfAo1+csyqs9hq6Fd7rDw1nYXATq+qmDmLhJiz88ee
         B0ISJ7HTIlnWXWCxlTWK7UILqfGzdu9jOQEm5JehJlT1lFjzU8zdN9aeBt6dpwQUqd
         F6oWu+d0OfgAzYl5TIZ1524Tc9cgjinCF/RvBTGf9CcvAFnIHbv5SKN29BHVXV7anP
         vaCzFro8sYOd4Zcj+ZR/94RSSuvMvVPLnyn90t8LAjQA1lx5PCphUshE5eMpFZS78S
         oKFHqQ7KM7KLQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78AvFDs3127797;
        Thu, 8 Aug 2019 03:57:15 -0700
Date:   Thu, 8 Aug 2019 03:57:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-03b7fad167efca3b7abbbb39733933f9df56e79c@git.kernel.org>
Cc:     peterz@infradead.org, naravamudan@digitalocean.com, hpa@zytor.com,
        jdesfossez@digitalocean.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        pauld@redhat.com, aaron.lwe@gmail.com
Reply-To: hpa@zytor.com, jdesfossez@digitalocean.com, tglx@linutronix.de,
          naravamudan@digitalocean.com, peterz@infradead.org,
          pauld@redhat.com, aaron.lwe@gmail.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          valentin.schneider@arm.com
In-Reply-To: <a96d1bcdd716db4a4c5da2fece647a1456c0ed78.1559129225.git.vpillai@digitalocean.com>
References: <a96d1bcdd716db4a4c5da2fece647a1456c0ed78.1559129225.git.vpillai@digitalocean.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched: Add task_struct pointer to
 sched_class::set_curr_task
Git-Commit-ID: 03b7fad167efca3b7abbbb39733933f9df56e79c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  03b7fad167efca3b7abbbb39733933f9df56e79c
Gitweb:     https://git.kernel.org/tip/03b7fad167efca3b7abbbb39733933f9df56e79c
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 29 May 2019 20:36:41 +0000
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:31 +0200

sched: Add task_struct pointer to sched_class::set_curr_task

In preparation of further separating pick_next_task() and
set_curr_task() we have to pass the actual task into it, while there,
rename the thing to better pair with put_prev_task().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Link: https://lkml.kernel.org/r/a96d1bcdd716db4a4c5da2fece647a1456c0ed78.1559129225.git.vpillai@digitalocean.com
---
 kernel/sched/core.c      | 12 ++++++------
 kernel/sched/deadline.c  |  7 +------
 kernel/sched/fair.c      | 17 ++++++++++++++---
 kernel/sched/idle.c      | 27 +++++++++++++++------------
 kernel/sched/rt.c        |  7 +------
 kernel/sched/sched.h     |  7 ++++---
 kernel/sched/stop_task.c | 17 +++++++----------
 7 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 364b6d7da2be..0c4220789092 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1494,7 +1494,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 }
 
 /*
@@ -4325,7 +4325,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -4392,7 +4392,7 @@ void set_user_nice(struct task_struct *p, long nice)
 			resched_curr(rq);
 	}
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 out_unlock:
 	task_rq_unlock(rq, p, &rf);
 }
@@ -4840,7 +4840,7 @@ change:
 		enqueue_task(rq, p, queue_flags);
 	}
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 
@@ -6042,7 +6042,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 	task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -6919,7 +6919,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
 	if (running)
-		set_curr_task(rq, tsk);
+		set_next_task(rq, tsk);
 
 	task_rq_unlock(rq, tsk, &rf);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2dc2784b196c..6eae79350303 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1844,11 +1844,6 @@ static void task_fork_dl(struct task_struct *p)
 	 */
 }
 
-static void set_curr_task_dl(struct rq *rq)
-{
-	set_next_task_dl(rq, rq->curr);
-}
-
 #ifdef CONFIG_SMP
 
 /* Only try algorithms three times */
@@ -2466,6 +2461,7 @@ const struct sched_class dl_sched_class = {
 
 	.pick_next_task		= pick_next_task_dl,
 	.put_prev_task		= put_prev_task_dl,
+	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_dl,
@@ -2476,7 +2472,6 @@ const struct sched_class dl_sched_class = {
 	.task_woken		= task_woken_dl,
 #endif
 
-	.set_curr_task		= set_curr_task_dl,
 	.task_tick		= task_tick_dl,
 	.task_fork              = task_fork_dl,
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d8043fc8317..8ce1b8893947 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10150,9 +10150,19 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
  * This routine is mostly called to set cfs_rq->curr field when a task
  * migrates between groups/classes.
  */
-static void set_curr_task_fair(struct rq *rq)
+static void set_next_task_fair(struct rq *rq, struct task_struct *p)
 {
-	struct sched_entity *se = &rq->curr->se;
+	struct sched_entity *se = &p->se;
+
+#ifdef CONFIG_SMP
+	if (task_on_rq_queued(p)) {
+		/*
+		 * Move the next running task to the front of the list, so our
+		 * cfs_tasks list becomes MRU one.
+		 */
+		list_move(&se->group_node, &rq->cfs_tasks);
+	}
+#endif
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -10423,7 +10433,9 @@ const struct sched_class fair_sched_class = {
 	.check_preempt_curr	= check_preempt_wakeup,
 
 	.pick_next_task		= pick_next_task_fair,
+
 	.put_prev_task		= put_prev_task_fair,
+	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_fair,
@@ -10436,7 +10448,6 @@ const struct sched_class fair_sched_class = {
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
 
-	.set_curr_task          = set_curr_task_fair,
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..54194d41035c 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -374,14 +374,25 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 	resched_curr(rq);
 }
 
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
+{
+}
+
+static void set_next_task_idle(struct rq *rq, struct task_struct *next)
+{
+	update_idle_core(rq);
+	schedstat_inc(rq->sched_goidle);
+}
+
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
+	struct task_struct *next = rq->idle;
+
 	put_prev_task(rq, prev);
-	update_idle_core(rq);
-	schedstat_inc(rq->sched_goidle);
+	set_next_task_idle(rq, next);
 
-	return rq->idle;
+	return next;
 }
 
 /*
@@ -397,10 +408,6 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 	raw_spin_lock_irq(&rq->lock);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
-{
-}
-
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -413,10 +420,6 @@ static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 {
 }
 
-static void set_curr_task_idle(struct rq *rq)
-{
-}
-
 static void switched_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
@@ -451,13 +454,13 @@ const struct sched_class idle_sched_class = {
 
 	.pick_next_task		= pick_next_task_idle,
 	.put_prev_task		= put_prev_task_idle,
+	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
 
-	.set_curr_task          = set_curr_task_idle,
 	.task_tick		= task_tick_idle,
 
 	.get_rr_interval	= get_rr_interval_idle,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 40bb71004325..f71bcbe1a00c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2354,11 +2354,6 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	}
 }
 
-static void set_curr_task_rt(struct rq *rq)
-{
-	set_next_task_rt(rq, rq->curr);
-}
-
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 {
 	/*
@@ -2380,6 +2375,7 @@ const struct sched_class rt_sched_class = {
 
 	.pick_next_task		= pick_next_task_rt,
 	.put_prev_task		= put_prev_task_rt,
+	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_rt,
@@ -2391,7 +2387,6 @@ const struct sched_class rt_sched_class = {
 	.switched_from		= switched_from_rt,
 #endif
 
-	.set_curr_task          = set_curr_task_rt,
 	.task_tick		= task_tick_rt,
 
 	.get_rr_interval	= get_rr_interval_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3449d0dd7f0..f3c50445bf22 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1707,6 +1707,7 @@ struct sched_class {
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
@@ -1721,7 +1722,6 @@ struct sched_class {
 	void (*rq_offline)(struct rq *rq);
 #endif
 
-	void (*set_curr_task)(struct rq *rq);
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
 	void (*task_fork)(struct task_struct *p);
 	void (*task_dead)(struct task_struct *p);
@@ -1755,9 +1755,10 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
-static inline void set_curr_task(struct rq *rq, struct task_struct *curr)
+static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	curr->sched_class->set_curr_task(rq);
+	WARN_ON_ONCE(rq->curr != next);
+	next->sched_class->set_next_task(rq, next);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index c183b790ca54..47a3d2a18a9a 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -23,6 +23,11 @@ check_preempt_curr_stop(struct rq *rq, struct task_struct *p, int flags)
 	/* we're never preempted */
 }
 
+static void set_next_task_stop(struct rq *rq, struct task_struct *stop)
+{
+	stop->se.exec_start = rq_clock_task(rq);
+}
+
 static struct task_struct *
 pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -32,8 +37,7 @@ pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		return NULL;
 
 	put_prev_task(rq, prev);
-
-	stop->se.exec_start = rq_clock_task(rq);
+	set_next_task_stop(rq, stop);
 
 	return stop;
 }
@@ -86,13 +90,6 @@ static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
 {
 }
 
-static void set_curr_task_stop(struct rq *rq)
-{
-	struct task_struct *stop = rq->stop;
-
-	stop->se.exec_start = rq_clock_task(rq);
-}
-
 static void switched_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
@@ -128,13 +125,13 @@ const struct sched_class stop_sched_class = {
 
 	.pick_next_task		= pick_next_task_stop,
 	.put_prev_task		= put_prev_task_stop,
+	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
 
-	.set_curr_task          = set_curr_task_stop,
 	.task_tick		= task_tick_stop,
 
 	.get_rr_interval	= get_rr_interval_stop,

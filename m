Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB3CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBEE20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CguR/CMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfJ3SeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:12 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42753 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfJ3SeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:10 -0400
Received: by mail-yb1-f195.google.com with SMTP id 4so1303781ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ruMl8U1eicE+dz/k1xehJtxtfJHaD+tW/qxfrKmCV/U=;
        b=CguR/CMyCXX4ZBV2GUVryNSoHMEdrTQizN5sbCrMuGMzsqr7CK8ES2JSLTBhIvgIyi
         bKtAVGZ5CTSYDDYhLthR5D4dQDdkDRz/NdlCMUtBVUkvK1l+qz1Ak67nElJK5phP3yZP
         2nJH4b0gZaH0CwWXmzMzkCYqVl4b7DzXQ0PPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ruMl8U1eicE+dz/k1xehJtxtfJHaD+tW/qxfrKmCV/U=;
        b=eMyAx8PA4Q7iZB/U7gJ298pOLhP/QyzlKBsHUXk/TVYFbFmvv3PvFKF/dZp36hcRa3
         vTUGmn0YXhzCgrEcM+T0+T5TbViEW8Olq7QcSVHokS2UAWV+L7kfTUqnuCVlzqKPJ32P
         GqHuplih3wTzAd3Xpf0n7+TL1OSFljFQscd70XZHUXMDZFC9Mrh7f0sF8YmmkGUvW5Bf
         4oZ5qpisYHAIU+L6YM9ahD6NZRaTw7W4X8SNrREQ2AZkLIfJdL79eXUuerMuCmjX6Mh5
         2HLB0x3aA6AuHydwr5jqBs0UKFip9gPxgyZ62IoIhOnMK0GOw86/oQ6/+pbSyQeFTjrr
         C72Q==
X-Gm-Message-State: APjAAAVUwZMxRPpKyLD8xaFHKN/4F6UXUWA42QIUIzTrWm5/3mLP/SJg
        cL0OySFiVvMWVRQvwi/5OmsEDA==
X-Google-Smtp-Source: APXvYqyhzGcahVnYH4SqzXAfoHN1Sb9T9tv9Q4dgRB+qDcPM259Jd1JQe8xsgmfmDz2sT6K3/lKkpA==
X-Received: by 2002:a25:ab8d:: with SMTP id v13mr570135ybi.351.1572460447661;
        Wed, 30 Oct 2019 11:34:07 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id 23sm872276ywf.91.2019.10.30.11.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:07 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 05/19] sched: Add task_struct pointer to sched_class::set_curr_task
Date:   Wed, 30 Oct 2019 18:33:18 +0000
Message-Id: <fb12cb8ab1de390afd741c7f74c021c9ce09df99.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation of further separating pick_next_task() and
set_curr_task() we have to pass the actual task into it, while there,
rename the thing to better pair with put_prev_task().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      | 12 ++++++------
 kernel/sched/deadline.c  |  7 +------
 kernel/sched/fair.c      | 17 ++++++++++++++---
 kernel/sched/idle.c      | 27 +++++++++++++++------------
 kernel/sched/rt.c        |  7 +------
 kernel/sched/sched.h     |  8 +++++---
 kernel/sched/stop_task.c | 17 +++++++----------
 7 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9c93cf71f5f..95cc10ecc7c9 100644
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
@@ -4276,7 +4276,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -4343,7 +4343,7 @@ void set_user_nice(struct task_struct *p, long nice)
 			resched_curr(rq);
 	}
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 out_unlock:
 	task_rq_unlock(rq, p, &rf);
 }
@@ -4786,7 +4786,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		enqueue_task(rq, p, queue_flags);
 	}
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 
@@ -5975,7 +5975,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
 	if (running)
-		set_curr_task(rq, p);
+		set_next_task(rq, p);
 	task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -6856,7 +6856,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
 	if (running)
-		set_curr_task(rq, tsk);
+		set_next_task(rq, tsk);
 
 	task_rq_unlock(rq, tsk, &rf);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4b53e7c696c8..38b45f2f890b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1812,11 +1812,6 @@ static void task_fork_dl(struct task_struct *p)
 	 */
 }
 
-static void set_curr_task_dl(struct rq *rq)
-{
-	set_next_task_dl(rq, rq->curr);
-}
-
 #ifdef CONFIG_SMP
 
 /* Only try algorithms three times */
@@ -2396,6 +2391,7 @@ const struct sched_class dl_sched_class = {
 
 	.pick_next_task		= pick_next_task_dl,
 	.put_prev_task		= put_prev_task_dl,
+	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_dl,
@@ -2406,7 +2402,6 @@ const struct sched_class dl_sched_class = {
 	.task_woken		= task_woken_dl,
 #endif
 
-	.set_curr_task		= set_curr_task_dl,
 	.task_tick		= task_tick_dl,
 	.task_fork              = task_fork_dl,
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1e8b811ce1f..a58e5de1732d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10180,9 +10180,19 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
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
@@ -10453,7 +10463,9 @@ const struct sched_class fair_sched_class = {
 	.check_preempt_curr	= check_preempt_wakeup,
 
 	.pick_next_task		= pick_next_task_fair,
+
 	.put_prev_task		= put_prev_task_fair,
+	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_fair,
@@ -10466,7 +10478,6 @@ const struct sched_class fair_sched_class = {
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
 
-	.set_curr_task          = set_curr_task_fair,
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 0d2f83899c83..3ff4889196e1 100644
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
 	raw_spin_lock_irq(rq_lockp(rq));
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
index f4590ac6fd92..a857945772d1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2355,11 +2355,6 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
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
@@ -2381,6 +2376,7 @@ const struct sched_class rt_sched_class = {
 
 	.pick_next_task		= pick_next_task_rt,
 	.put_prev_task		= put_prev_task_rt,
+	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
 	.select_task_rq		= select_task_rq_rt,
@@ -2392,7 +2388,6 @@ const struct sched_class rt_sched_class = {
 	.switched_from		= switched_from_rt,
 #endif
 
-	.set_curr_task          = set_curr_task_rt,
 	.task_tick		= task_tick_rt,
 
 	.get_rr_interval	= get_rr_interval_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index af2a9972149a..657831e26008 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1715,6 +1715,7 @@ struct sched_class {
 					       struct task_struct *prev,
 					       struct rq_flags *rf);
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
+	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
@@ -1729,7 +1730,6 @@ struct sched_class {
 	void (*rq_offline)(struct rq *rq);
 #endif
 
-	void (*set_curr_task)(struct rq *rq);
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
 	void (*task_fork)(struct task_struct *p);
 	void (*task_dead)(struct task_struct *p);
@@ -1759,12 +1759,14 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
+	WARN_ON_ONCE(rq->curr != prev);
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
-- 
2.17.1


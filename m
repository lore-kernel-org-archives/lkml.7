Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81AEC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8352417E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Vu9DgS1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE2UhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:06 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51477 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfE2UhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:02 -0400
Received: by mail-it1-f193.google.com with SMTP id m3so6275562itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5ukSjuEeZUaEKRbYHbK5KsyVHnoKo4mJOZBuoyZvGps=;
        b=Vu9DgS1JlgTD+hH+W6aqHEGd5zmo3HrKjPODQITYSgyGQ39BuRRYYsPkuWp0Ihf0fV
         /bU4lntf9wrSmrTNB81rI6ZK8bC+G97RN1XBinh+evS+Wt9y7lcwUm6i720WNq7dGySA
         JB5S7HRfdgZZqs+m/2RTuVUtSB4Mxn2eiSvAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5ukSjuEeZUaEKRbYHbK5KsyVHnoKo4mJOZBuoyZvGps=;
        b=fabQ8/qPlPnZd6WXSKRJ6HpcjDoC5Z+GdCPWyo5N+EzvK1Qk1Qwu9cJ7nkvcwsmgI2
         tsI1bB2tyZibVQcyTZBRaDzL/tDzahAbOE6yM929Y+qY1kf4UX2JFoPbpEgoHlZVEkkf
         w5bJp+VSRXm4MCnkoVpx8KCkxKaUetuqDYCxQAemTVj9x/287scBkoSVJq5xrKaHnnus
         Jjtwz/fylWh8Y+Sdh11F36A5qzceB7HtiZJHXeu6Dx6W5P7soCV4i8lCwB4zfBTv8GOS
         qM8KEp+lRP+Ra99LH0+UlibCfeMJTmyCnObaqA52v8RlFilzb1iPcxfkbtZcO16NjKYe
         8pBQ==
X-Gm-Message-State: APjAAAXG8vKbCanxDxR3JL5B5ONlhhJbog+4vsEH1JzAKGyILJLxAKSk
        OnZt+0giWx8ZlMfP/h5Ik8XNLg==
X-Google-Smtp-Source: APXvYqxzkdfSUIcMXO6BJjCBkTvSctqr7pEIRMoifPsMW9t7pCsYeRB4i3a/3sgOEsyMNXcXEJCUTQ==
X-Received: by 2002:a05:6638:5b3:: with SMTP id b19mr27798782jar.107.1559162220417;
        Wed, 29 May 2019 13:37:00 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id c2sm190896iok.53.2019.05.29.13.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:36:59 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH v3 03/16] sched: Wrap rq::lock access
Date:   Wed, 29 May 2019 20:36:39 +0000
Message-Id: <d9392e6b7debe93bcc393b31b8cb771da96cfebd.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation of playing games with rq->lock, abstract the thing
using an accessor.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---

Changes in v2
-------------
- Fixes a deadlock due in double_rq_lock and double_lock_lock
  - Vineeth Pillai
  - Julien Desfossez
- Fixes 32bit build.
  - Aubrey Li

---
 kernel/sched/core.c     |  46 ++++++++---------
 kernel/sched/cpuacct.c  |  12 ++---
 kernel/sched/deadline.c |  18 +++----
 kernel/sched/debug.c    |   4 +-
 kernel/sched/fair.c     |  40 +++++++--------
 kernel/sched/idle.c     |   4 +-
 kernel/sched/pelt.h     |   2 +-
 kernel/sched/rt.c       |   8 +--
 kernel/sched/sched.h    | 106 ++++++++++++++++++++--------------------
 kernel/sched/topology.c |   4 +-
 10 files changed, 123 insertions(+), 121 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 416ea613eda8..6f4861ae85dc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -72,12 +72,12 @@ struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 
 	for (;;) {
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 
 		while (unlikely(task_on_rq_migrating(p)))
 			cpu_relax();
@@ -96,7 +96,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	for (;;) {
 		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
 		rq = task_rq(p);
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		/*
 		 *	move_queued_task()		task_rq_lock()
 		 *
@@ -118,7 +118,7 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 			rq_pin_lock(rq, rf);
 			return rq;
 		}
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 
 		while (unlikely(task_on_rq_migrating(p)))
@@ -188,7 +188,7 @@ void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (rq->clock_update_flags & RQCF_ACT_SKIP)
 		return;
@@ -497,7 +497,7 @@ void resched_curr(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	int cpu;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (test_tsk_need_resched(curr))
 		return;
@@ -521,10 +521,10 @@ void resched_cpu(int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	if (cpu_online(cpu) || cpu == smp_processor_id())
 		resched_curr(rq);
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 }
 
 #ifdef CONFIG_SMP
@@ -956,7 +956,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 				   struct task_struct *p, int new_cpu)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
@@ -1070,7 +1070,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		 * Because __kthread_bind() calls this on blocked tasks without
 		 * holding rq->lock.
 		 */
-		lockdep_assert_held(&rq->lock);
+		lockdep_assert_held(rq_lockp(rq));
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	}
 	if (running)
@@ -1203,7 +1203,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 * task_rq_lock().
 	 */
 	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
-				      lockdep_is_held(&task_rq(p)->lock)));
+				      lockdep_is_held(rq_lockp(task_rq(p)))));
 #endif
 	/*
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
@@ -1732,7 +1732,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 {
 	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 #ifdef CONFIG_SMP
 	if (p->sched_contributes_to_load)
@@ -2123,7 +2123,7 @@ static void try_to_wake_up_local(struct task_struct *p, struct rq_flags *rf)
 	    WARN_ON_ONCE(p == current))
 		return;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (!raw_spin_trylock(&p->pi_lock)) {
 		/*
@@ -2609,10 +2609,10 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
-	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
+	spin_release(&rq_lockp(rq)->dep_map, 1, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
-	rq->lock.owner = next;
+	rq_lockp(rq)->owner = next;
 #endif
 }
 
@@ -2623,8 +2623,8 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
-	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
-	raw_spin_unlock_irq(&rq->lock);
+	spin_acquire(&rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
+	raw_spin_unlock_irq(rq_lockp(rq));
 }
 
 /*
@@ -2698,7 +2698,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 *	schedule()
 	 *	  preempt_disable();			// 1
 	 *	  __schedule()
-	 *	    raw_spin_lock_irq(&rq->lock)	// 2
+	 *	    raw_spin_lock_irq(rq_lockp(rq))	// 2
 	 *
 	 * Also, see FORK_PREEMPT_COUNT.
 	 */
@@ -2774,7 +2774,7 @@ static void __balance_callback(struct rq *rq)
 	void (*func)(struct rq *rq);
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	head = rq->balance_callback;
 	rq->balance_callback = NULL;
 	while (head) {
@@ -2785,7 +2785,7 @@ static void __balance_callback(struct rq *rq)
 
 		func(rq);
 	}
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 }
 
 static inline void balance_callback(struct rq *rq)
@@ -5414,7 +5414,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 
 	__sched_fork(0, idle);
 	idle->state = TASK_RUNNING;
@@ -5451,7 +5451,7 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
 #endif
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 	raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
@@ -6019,7 +6019,7 @@ void __init sched_init(void)
 		struct rq *rq;
 
 		rq = cpu_rq(i);
-		raw_spin_lock_init(&rq->lock);
+		raw_spin_lock_init(&rq->__lock);
 		rq->nr_running = 0;
 		rq->calc_load_active = 0;
 		rq->calc_load_update = jiffies + LOAD_FREQ;
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb10383434..78de28ebc45d 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -111,7 +111,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	/*
 	 * Take rq->lock to make 64-bit read safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	if (index == CPUACCT_STAT_NSTATS) {
@@ -125,7 +125,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	}
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	return data;
@@ -140,14 +140,14 @@ static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
 	/*
 	 * Take rq->lock to make 64-bit write safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
 		cpuusage->usages[i] = val;
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 }
 
@@ -252,13 +252,13 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 			 * Take rq->lock to make 64-bit read safe on 32-bit
 			 * platforms.
 			 */
-			raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 			seq_printf(m, " %llu", cpuusage->usages[index]);
 
 #ifndef CONFIG_64BIT
-			raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 		}
 		seq_puts(m, "\n");
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43901fa3f269..e683d4c19ab8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -80,7 +80,7 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
@@ -93,7 +93,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
 	dl_rq->running_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
@@ -107,7 +107,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
 	dl_rq->this_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
 }
@@ -117,7 +117,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->this_bw;
 
-	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
+	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
 	dl_rq->this_bw -= dl_bw;
 	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
@@ -892,7 +892,7 @@ static int start_dl_timer(struct task_struct *p)
 	ktime_t now, act;
 	s64 delta;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	/*
 	 * We want the timer to fire at the deadline, but considering
@@ -1002,9 +1002,9 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 		 * If the runqueue is no longer available, migrate the
 		 * task elsewhere. This necessarily changes rq.
 		 */
-		lockdep_unpin_lock(&rq->lock, rf.cookie);
+		lockdep_unpin_lock(rq_lockp(rq), rf.cookie);
 		rq = dl_task_offline_migration(rq, p);
-		rf.cookie = lockdep_pin_lock(&rq->lock);
+		rf.cookie = lockdep_pin_lock(rq_lockp(rq));
 		update_rq_clock(rq);
 
 		/*
@@ -1619,7 +1619,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
 	 * rq->lock is not... So, lock it
 	 */
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	if (p->dl.dl_non_contending) {
 		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
@@ -1634,7 +1634,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 			put_task_struct(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8039d62ae36e..bfeed9658a83 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -515,7 +515,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
 			SPLIT_NS(cfs_rq->exec_clock));
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 	if (rb_first_cached(&cfs_rq->tasks_timeline))
 		MIN_vruntime = (__pick_first_entity(cfs_rq))->vruntime;
 	last = __pick_last_entity(cfs_rq);
@@ -523,7 +523,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 		max_vruntime = last->vruntime;
 	min_vruntime = cfs_rq->min_vruntime;
 	rq0_min_vruntime = cpu_rq(0)->cfs.min_vruntime;
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "MIN_vruntime",
 			SPLIT_NS(MIN_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35f3ea375084..c17faf672dcf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4996,7 +4996,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -5015,7 +5015,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 {
 	struct task_group *tg;
 
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(tg, &task_groups, list) {
@@ -6773,7 +6773,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
 		 * rq->lock and can modify state directly.
 		 */
-		lockdep_assert_held(&task_rq(p)->lock);
+		lockdep_assert_held(rq_lockp(task_rq(p)));
 		detach_entity_cfs_rq(&p->se);
 
 	} else {
@@ -7347,7 +7347,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 {
 	s64 delta;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	if (p->sched_class != &fair_sched_class)
 		return 0;
@@ -7441,7 +7441,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
 	int tsk_cache_hot;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	/*
 	 * We do not migrate tasks that are:
@@ -7519,7 +7519,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
  */
 static void detach_task(struct task_struct *p, struct lb_env *env)
 {
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	p->on_rq = TASK_ON_RQ_MIGRATING;
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
@@ -7536,7 +7536,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	list_for_each_entry_reverse(p,
 			&env->src_rq->cfs_tasks, se.group_node) {
@@ -7572,7 +7572,7 @@ static int detach_tasks(struct lb_env *env)
 	unsigned long load;
 	int detached = 0;
 
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(rq_lockp(env->src_rq));
 
 	if (env->imbalance <= 0)
 		return 0;
@@ -7653,7 +7653,7 @@ static int detach_tasks(struct lb_env *env)
  */
 static void attach_task(struct rq *rq, struct task_struct *p)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	BUG_ON(task_rq(p) != rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
@@ -9206,7 +9206,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		if (need_active_balance(&env)) {
 			unsigned long flags;
 
-			raw_spin_lock_irqsave(&busiest->lock, flags);
+			raw_spin_lock_irqsave(rq_lockp(busiest), flags);
 
 			/*
 			 * Don't kick the active_load_balance_cpu_stop,
@@ -9214,7 +9214,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			 * moved to this_cpu:
 			 */
 			if (!cpumask_test_cpu(this_cpu, &busiest->curr->cpus_allowed)) {
-				raw_spin_unlock_irqrestore(&busiest->lock,
+				raw_spin_unlock_irqrestore(rq_lockp(busiest),
 							    flags);
 				env.flags |= LBF_ALL_PINNED;
 				goto out_one_pinned;
@@ -9230,7 +9230,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_unlock_irqrestore(&busiest->lock, flags);
+			raw_spin_unlock_irqrestore(rq_lockp(busiest), flags);
 
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
@@ -9969,7 +9969,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
 
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 	/*
 	 * This CPU is going to be idle and blocked load of idle CPUs
 	 * need to be updated. Run the ilb locally as it is a good
@@ -9978,7 +9978,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	 */
 	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 		kick_ilb(NOHZ_STATS_KICK);
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock(rq_lockp(this_rq));
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -10038,7 +10038,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 		goto out;
 	}
 
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 
 	update_blocked_averages(this_cpu);
 	rcu_read_lock();
@@ -10079,7 +10079,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	}
 	rcu_read_unlock();
 
-	raw_spin_lock(&this_rq->lock);
+	raw_spin_lock(rq_lockp(this_rq));
 
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
@@ -10515,11 +10515,11 @@ void online_fair_sched_group(struct task_group *tg)
 		rq = cpu_rq(i);
 		se = tg->se[i];
 
-		raw_spin_lock_irq(&rq->lock);
+		raw_spin_lock_irq(rq_lockp(rq));
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
 		sync_throttle(tg, i);
-		raw_spin_unlock_irq(&rq->lock);
+		raw_spin_unlock_irq(rq_lockp(rq));
 	}
 }
 
@@ -10542,9 +10542,9 @@ void unregister_fair_sched_group(struct task_group *tg)
 
 		rq = cpu_rq(cpu);
 
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_lock_irqsave(rq_lockp(rq), flags);
 		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 	}
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516bae0c1b..39788d3a40ec 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -390,10 +390,10 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 static void
 dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
 {
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_unlock_irq(rq_lockp(rq));
 	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 	dump_stack();
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_lock_irq(rq_lockp(rq));
 }
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 7489d5f56960..dd604947e9f8 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -116,7 +116,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 
 static inline u64 rq_clock_pelt(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock_pelt - rq->lost_idle_time;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 90fa23d36565..3d9db8c75d53 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -845,7 +845,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		if (skip)
 			continue;
 
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		update_rq_clock(rq);
 
 		if (rt_rq->rt_time) {
@@ -883,7 +883,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 		if (enqueue)
 			sched_rt_rq_enqueue(rt_rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 	}
 
 	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
@@ -2034,9 +2034,9 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 * When it gets updated, a check is made if a push is possible.
 	 */
 	if (has_pushable_tasks(rq)) {
-		raw_spin_lock(&rq->lock);
+		raw_spin_lock(rq_lockp(rq));
 		push_rt_tasks(rq);
-		raw_spin_unlock(&rq->lock);
+		raw_spin_unlock(rq_lockp(rq));
 	}
 
 	raw_spin_lock(&rd->rto_lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index efa686eeff26..c4cd252dba29 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -806,7 +806,7 @@ extern void rto_push_irq_work_func(struct irq_work *work);
  */
 struct rq {
 	/* runqueue lock: */
-	raw_spinlock_t		lock;
+	raw_spinlock_t		__lock;
 
 	/*
 	 * nr_running and cpu_load should be in the same cacheline because
@@ -979,6 +979,10 @@ static inline int cpu_of(struct rq *rq)
 #endif
 }
 
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	return &rq->__lock;
+}
 
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
@@ -1046,7 +1050,7 @@ static inline void assert_clock_updated(struct rq *rq)
 
 static inline u64 rq_clock(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock;
@@ -1054,7 +1058,7 @@ static inline u64 rq_clock(struct rq *rq)
 
 static inline u64 rq_clock_task(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	assert_clock_updated(rq);
 
 	return rq->clock_task;
@@ -1062,7 +1066,7 @@ static inline u64 rq_clock_task(struct rq *rq)
 
 static inline void rq_clock_skip_update(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	rq->clock_update_flags |= RQCF_REQ_SKIP;
 }
 
@@ -1072,7 +1076,7 @@ static inline void rq_clock_skip_update(struct rq *rq)
  */
 static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
@@ -1091,7 +1095,7 @@ struct rq_flags {
 
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	rf->cookie = lockdep_pin_lock(&rq->lock);
+	rf->cookie = lockdep_pin_lock(rq_lockp(rq));
 
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
@@ -1106,12 +1110,12 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
 
-	lockdep_unpin_lock(&rq->lock, rf->cookie);
+	lockdep_unpin_lock(rq_lockp(rq), rf->cookie);
 }
 
 static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	lockdep_repin_lock(&rq->lock, rf->cookie);
+	lockdep_repin_lock(rq_lockp(rq), rf->cookie);
 
 #ifdef CONFIG_SCHED_DEBUG
 	/*
@@ -1132,7 +1136,7 @@ static inline void __task_rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static inline void
@@ -1141,7 +1145,7 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	__releases(p->pi_lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
@@ -1149,7 +1153,7 @@ static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irqsave(&rq->lock, rf->flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), rf->flags);
 	rq_pin_lock(rq, rf);
 }
 
@@ -1157,7 +1161,7 @@ static inline void
 rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irq(&rq->lock);
+	raw_spin_lock_irq(rq_lockp(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -1165,7 +1169,7 @@ static inline void
 rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -1173,7 +1177,7 @@ static inline void
 rq_relock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock(rq_lockp(rq));
 	rq_repin_lock(rq, rf);
 }
 
@@ -1182,7 +1186,7 @@ rq_unlock_irqrestore(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), rf->flags);
 }
 
 static inline void
@@ -1190,7 +1194,7 @@ rq_unlock_irq(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock_irq(&rq->lock);
+	raw_spin_unlock_irq(rq_lockp(rq));
 }
 
 static inline void
@@ -1198,7 +1202,7 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	__releases(rq->lock)
 {
 	rq_unpin_lock(rq, rf);
-	raw_spin_unlock(&rq->lock);
+	raw_spin_unlock(rq_lockp(rq));
 }
 
 static inline struct rq *
@@ -1261,7 +1265,7 @@ queue_balance_callback(struct rq *rq,
 		       struct callback_head *head,
 		       void (*func)(struct rq *rq))
 {
-	lockdep_assert_held(&rq->lock);
+	lockdep_assert_held(rq_lockp(rq));
 
 	if (unlikely(head->next))
 		return;
@@ -1917,7 +1921,7 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	raw_spin_unlock(&this_rq->lock);
+	raw_spin_unlock(rq_lockp(this_rq));
 	double_rq_lock(this_rq, busiest);
 
 	return 1;
@@ -1936,20 +1940,22 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	int ret = 0;
-
-	if (unlikely(!raw_spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
-			raw_spin_unlock(&this_rq->lock);
-			raw_spin_lock(&busiest->lock);
-			raw_spin_lock_nested(&this_rq->lock,
-					      SINGLE_DEPTH_NESTING);
-			ret = 1;
-		} else
-			raw_spin_lock_nested(&busiest->lock,
-					      SINGLE_DEPTH_NESTING);
+	if (rq_lockp(this_rq) == rq_lockp(busiest))
+		return 0;
+
+	if (likely(raw_spin_trylock(rq_lockp(busiest))))
+		return 0;
+
+	if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
+		raw_spin_lock_nested(rq_lockp(busiest), SINGLE_DEPTH_NESTING);
+		return 0;
 	}
-	return ret;
+
+	raw_spin_unlock(rq_lockp(this_rq));
+	raw_spin_lock(rq_lockp(busiest));
+	raw_spin_lock_nested(rq_lockp(this_rq), SINGLE_DEPTH_NESTING);
+
+	return 1;
 }
 
 #endif /* CONFIG_PREEMPT */
@@ -1959,20 +1965,16 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
  */
 static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 {
-	if (unlikely(!irqs_disabled())) {
-		/* printk() doesn't work well under rq->lock */
-		raw_spin_unlock(&this_rq->lock);
-		BUG_ON(1);
-	}
-
+	lockdep_assert_irqs_disabled();
 	return _double_lock_balance(this_rq, busiest);
 }
 
 static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 	__releases(busiest->lock)
 {
-	raw_spin_unlock(&busiest->lock);
-	lock_set_subclass(&this_rq->lock.dep_map, 0, _RET_IP_);
+	if (rq_lockp(this_rq) != rq_lockp(busiest))
+		raw_spin_unlock(rq_lockp(busiest));
+	lock_set_subclass(&rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
 
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
@@ -2013,16 +2015,16 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	__acquires(rq2->lock)
 {
 	BUG_ON(!irqs_disabled());
-	if (rq1 == rq2) {
-		raw_spin_lock(&rq1->lock);
+	if (rq_lockp(rq1) == rq_lockp(rq2)) {
+		raw_spin_lock(rq_lockp(rq1));
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1 < rq2) {
-			raw_spin_lock(&rq1->lock);
-			raw_spin_lock_nested(&rq2->lock, SINGLE_DEPTH_NESTING);
+		if (rq_lockp(rq1) < rq_lockp(rq2)) {
+			raw_spin_lock(rq_lockp(rq1));
+			raw_spin_lock_nested(rq_lockp(rq2), SINGLE_DEPTH_NESTING);
 		} else {
-			raw_spin_lock(&rq2->lock);
-			raw_spin_lock_nested(&rq1->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock(rq_lockp(rq2));
+			raw_spin_lock_nested(rq_lockp(rq1), SINGLE_DEPTH_NESTING);
 		}
 	}
 }
@@ -2037,9 +2039,9 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	raw_spin_unlock(&rq1->lock);
-	if (rq1 != rq2)
-		raw_spin_unlock(&rq2->lock);
+	raw_spin_unlock(rq_lockp(rq1));
+	if (rq_lockp(rq1) != rq_lockp(rq2))
+		raw_spin_unlock(rq_lockp(rq2));
 	else
 		__release(rq2->lock);
 }
@@ -2062,7 +2064,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 {
 	BUG_ON(!irqs_disabled());
 	BUG_ON(rq1 != rq2);
-	raw_spin_lock(&rq1->lock);
+	raw_spin_lock(rq_lockp(rq1));
 	__acquire(rq2->lock);	/* Fake it out ;) */
 }
 
@@ -2077,7 +2079,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq2->lock)
 {
 	BUG_ON(rq1 != rq2);
-	raw_spin_unlock(&rq1->lock);
+	raw_spin_unlock(rq_lockp(rq1));
 	__release(rq2->lock);
 }
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ab7f371a3a17..14b8be81dab2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -442,7 +442,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	struct root_domain *old_rd = NULL;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&rq->lock, flags);
+	raw_spin_lock_irqsave(rq_lockp(rq), flags);
 
 	if (rq->rd) {
 		old_rd = rq->rd;
@@ -468,7 +468,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
-	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
 
 	if (old_rd)
 		call_rcu(&old_rd->rcu, free_rootdomain);
-- 
2.17.1


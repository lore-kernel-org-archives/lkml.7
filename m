Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDEC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE0GVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:21:38 -0400
Received: from foss.arm.com ([217.140.101.70]:56106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE0GVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A289F15A2;
        Sun, 26 May 2019 23:21:34 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFB0E3F59C;
        Sun, 26 May 2019 23:21:32 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] sched: Remove rq->cpu_load[] update code
Date:   Mon, 27 May 2019 07:21:10 +0100
Message-Id: <20190527062116.11512-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527062116.11512-1-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LB_BIAS disabled, there is no need to update the rq->cpu_load[idx]
any more.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched/nohz.h |   8 --
 kernel/sched/core.c        |   1 -
 kernel/sched/fair.c        | 255 -------------------------------------
 kernel/sched/sched.h       |   6 -
 kernel/time/tick-sched.c   |   2 -
 5 files changed, 272 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index b36f4cf38111..1abe91ff6e4a 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -6,14 +6,6 @@
  * This is the interface between the scheduler and nohz/dynticks:
  */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-extern void cpu_load_update_nohz_start(void);
-extern void cpu_load_update_nohz_stop(void);
-#else
-static inline void cpu_load_update_nohz_start(void) { }
-static inline void cpu_load_update_nohz_stop(void) { }
-#endif
-
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf0a29a..e8bee37b78fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3032,7 +3032,6 @@ void scheduler_tick(void)
 
 	update_rq_clock(rq);
 	curr->sched_class->task_tick(rq, curr, 0);
-	cpu_load_update_active(rq);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..f619b93ca331 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5325,71 +5325,6 @@ DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
-/*
- * per rq 'load' arrray crap; XXX kill this.
- */
-
-/*
- * The exact cpuload calculated at every tick would be:
- *
- *   load' = (1 - 1/2^i) * load + (1/2^i) * cur_load
- *
- * If a CPU misses updates for n ticks (as it was idle) and update gets
- * called on the n+1-th tick when CPU may be busy, then we have:
- *
- *   load_n   = (1 - 1/2^i)^n * load_0
- *   load_n+1 = (1 - 1/2^i)   * load_n + (1/2^i) * cur_load
- *
- * decay_load_missed() below does efficient calculation of
- *
- *   load' = (1 - 1/2^i)^n * load
- *
- * Because x^(n+m) := x^n * x^m we can decompose any x^n in power-of-2 factors.
- * This allows us to precompute the above in said factors, thereby allowing the
- * reduction of an arbitrary n in O(log_2 n) steps. (See also
- * fixed_power_int())
- *
- * The calculation is approximated on a 128 point scale.
- */
-#define DEGRADE_SHIFT		7
-
-static const u8 degrade_zero_ticks[CPU_LOAD_IDX_MAX] = {0, 8, 32, 64, 128};
-static const u8 degrade_factor[CPU_LOAD_IDX_MAX][DEGRADE_SHIFT + 1] = {
-	{   0,   0,  0,  0,  0,  0, 0, 0 },
-	{  64,  32,  8,  0,  0,  0, 0, 0 },
-	{  96,  72, 40, 12,  1,  0, 0, 0 },
-	{ 112,  98, 75, 43, 15,  1, 0, 0 },
-	{ 120, 112, 98, 76, 45, 16, 2, 0 }
-};
-
-/*
- * Update cpu_load for any missed ticks, due to tickless idle. The backlog
- * would be when CPU is idle and so we just decay the old load without
- * adding any new load.
- */
-static unsigned long
-decay_load_missed(unsigned long load, unsigned long missed_updates, int idx)
-{
-	int j = 0;
-
-	if (!missed_updates)
-		return load;
-
-	if (missed_updates >= degrade_zero_ticks[idx])
-		return 0;
-
-	if (idx == 1)
-		return load >> missed_updates;
-
-	while (missed_updates) {
-		if (missed_updates % 2)
-			load = (load * degrade_factor[idx][j]) >> DEGRADE_SHIFT;
-
-		missed_updates >>= 1;
-		j++;
-	}
-	return load;
-}
 
 static struct {
 	cpumask_var_t idle_cpus_mask;
@@ -5401,201 +5336,12 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
-/**
- * __cpu_load_update - update the rq->cpu_load[] statistics
- * @this_rq: The rq to update statistics for
- * @this_load: The current load
- * @pending_updates: The number of missed updates
- *
- * Update rq->cpu_load[] statistics. This function is usually called every
- * scheduler tick (TICK_NSEC).
- *
- * This function computes a decaying average:
- *
- *   load[i]' = (1 - 1/2^i) * load[i] + (1/2^i) * load
- *
- * Because of NOHZ it might not get called on every tick which gives need for
- * the @pending_updates argument.
- *
- *   load[i]_n = (1 - 1/2^i) * load[i]_n-1 + (1/2^i) * load_n-1
- *             = A * load[i]_n-1 + B ; A := (1 - 1/2^i), B := (1/2^i) * load
- *             = A * (A * load[i]_n-2 + B) + B
- *             = A * (A * (A * load[i]_n-3 + B) + B) + B
- *             = A^3 * load[i]_n-3 + (A^2 + A + 1) * B
- *             = A^n * load[i]_0 + (A^(n-1) + A^(n-2) + ... + 1) * B
- *             = A^n * load[i]_0 + ((1 - A^n) / (1 - A)) * B
- *             = (1 - 1/2^i)^n * (load[i]_0 - load) + load
- *
- * In the above we've assumed load_n := load, which is true for NOHZ_FULL as
- * any change in load would have resulted in the tick being turned back on.
- *
- * For regular NOHZ, this reduces to:
- *
- *   load[i]_n = (1 - 1/2^i)^n * load[i]_0
- *
- * see decay_load_misses(). For NOHZ_FULL we get to subtract and add the extra
- * term.
- */
-static void cpu_load_update(struct rq *this_rq, unsigned long this_load,
-			    unsigned long pending_updates)
-{
-	unsigned long __maybe_unused tickless_load = this_rq->cpu_load[0];
-	int i, scale;
-
-	this_rq->nr_load_updates++;
-
-	/* Update our load: */
-	this_rq->cpu_load[0] = this_load; /* Fasttrack for idx 0 */
-	for (i = 1, scale = 2; i < CPU_LOAD_IDX_MAX; i++, scale += scale) {
-		unsigned long old_load, new_load;
-
-		/* scale is effectively 1 << i now, and >> i divides by scale */
-
-		old_load = this_rq->cpu_load[i];
-#ifdef CONFIG_NO_HZ_COMMON
-		old_load = decay_load_missed(old_load, pending_updates - 1, i);
-		if (tickless_load) {
-			old_load -= decay_load_missed(tickless_load, pending_updates - 1, i);
-			/*
-			 * old_load can never be a negative value because a
-			 * decayed tickless_load cannot be greater than the
-			 * original tickless_load.
-			 */
-			old_load += tickless_load;
-		}
-#endif
-		new_load = this_load;
-		/*
-		 * Round up the averaging division if load is increasing. This
-		 * prevents us from getting stuck on 9 if the load is 10, for
-		 * example.
-		 */
-		if (new_load > old_load)
-			new_load += scale - 1;
-
-		this_rq->cpu_load[i] = (old_load * (scale - 1) + new_load) >> i;
-	}
-}
-
 /* Used instead of source_load when we know the type == 0 */
 static unsigned long weighted_cpuload(struct rq *rq)
 {
 	return cfs_rq_runnable_load_avg(&rq->cfs);
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
-/*
- * There is no sane way to deal with nohz on smp when using jiffies because the
- * CPU doing the jiffies update might drift wrt the CPU doing the jiffy reading
- * causing off-by-one errors in observed deltas; {0,2} instead of {1,1}.
- *
- * Therefore we need to avoid the delta approach from the regular tick when
- * possible since that would seriously skew the load calculation. This is why we
- * use cpu_load_update_periodic() for CPUs out of nohz. However we'll rely on
- * jiffies deltas for updates happening while in nohz mode (idle ticks, idle
- * loop exit, nohz_idle_balance, nohz full exit...)
- *
- * This means we might still be one tick off for nohz periods.
- */
-
-static void cpu_load_update_nohz(struct rq *this_rq,
-				 unsigned long curr_jiffies,
-				 unsigned long load)
-{
-	unsigned long pending_updates;
-
-	pending_updates = curr_jiffies - this_rq->last_load_update_tick;
-	if (pending_updates) {
-		this_rq->last_load_update_tick = curr_jiffies;
-		/*
-		 * In the regular NOHZ case, we were idle, this means load 0.
-		 * In the NOHZ_FULL case, we were non-idle, we should consider
-		 * its weighted load.
-		 */
-		cpu_load_update(this_rq, load, pending_updates);
-	}
-}
-
-/*
- * Called from nohz_idle_balance() to update the load ratings before doing the
- * idle balance.
- */
-static void cpu_load_update_idle(struct rq *this_rq)
-{
-	/*
-	 * bail if there's load or we're actually up-to-date.
-	 */
-	if (weighted_cpuload(this_rq))
-		return;
-
-	cpu_load_update_nohz(this_rq, READ_ONCE(jiffies), 0);
-}
-
-/*
- * Record CPU load on nohz entry so we know the tickless load to account
- * on nohz exit. cpu_load[0] happens then to be updated more frequently
- * than other cpu_load[idx] but it should be fine as cpu_load readers
- * shouldn't rely into synchronized cpu_load[*] updates.
- */
-void cpu_load_update_nohz_start(void)
-{
-	struct rq *this_rq = this_rq();
-
-	/*
-	 * This is all lockless but should be fine. If weighted_cpuload changes
-	 * concurrently we'll exit nohz. And cpu_load write can race with
-	 * cpu_load_update_idle() but both updater would be writing the same.
-	 */
-	this_rq->cpu_load[0] = weighted_cpuload(this_rq);
-}
-
-/*
- * Account the tickless load in the end of a nohz frame.
- */
-void cpu_load_update_nohz_stop(void)
-{
-	unsigned long curr_jiffies = READ_ONCE(jiffies);
-	struct rq *this_rq = this_rq();
-	unsigned long load;
-	struct rq_flags rf;
-
-	if (curr_jiffies == this_rq->last_load_update_tick)
-		return;
-
-	load = weighted_cpuload(this_rq);
-	rq_lock(this_rq, &rf);
-	update_rq_clock(this_rq);
-	cpu_load_update_nohz(this_rq, curr_jiffies, load);
-	rq_unlock(this_rq, &rf);
-}
-#else /* !CONFIG_NO_HZ_COMMON */
-static inline void cpu_load_update_nohz(struct rq *this_rq,
-					unsigned long curr_jiffies,
-					unsigned long load) { }
-#endif /* CONFIG_NO_HZ_COMMON */
-
-static void cpu_load_update_periodic(struct rq *this_rq, unsigned long load)
-{
-#ifdef CONFIG_NO_HZ_COMMON
-	/* See the mess around cpu_load_update_nohz(). */
-	this_rq->last_load_update_tick = READ_ONCE(jiffies);
-#endif
-	cpu_load_update(this_rq, load, 1);
-}
-
-/*
- * Called from scheduler_tick()
- */
-void cpu_load_update_active(struct rq *this_rq)
-{
-	unsigned long load = weighted_cpuload(this_rq);
-
-	if (tick_nohz_tick_stopped())
-		cpu_load_update_nohz(this_rq, READ_ONCE(jiffies), load);
-	else
-		cpu_load_update_periodic(this_rq, load);
-}
-
 /*
  * Return a low guess at the load of a migration-source CPU weighted
  * according to the scheduling class and "nice" value.
@@ -9879,7 +9625,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 
 			rq_lock_irqsave(rq, &rf);
 			update_rq_clock(rq);
-			cpu_load_update_idle(rq);
 			rq_unlock_irqrestore(rq, &rf);
 
 			if (flags & NOHZ_BALANCE_KICK)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1ada0be..a83827eec1d1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -96,12 +96,6 @@ extern atomic_long_t calc_load_tasks;
 extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
-#ifdef CONFIG_SMP
-extern void cpu_load_update_active(struct rq *this_rq);
-#else
-static inline void cpu_load_update_active(struct rq *this_rq) { }
-#endif
-
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f4ee1a3428ae..be9707f68024 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -782,7 +782,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
-		cpu_load_update_nohz_start();
 		quiet_vmstat();
 
 		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
@@ -829,7 +828,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 {
 	/* Update jiffies first */
 	tick_do_update_jiffies64(now);
-	cpu_load_update_nohz_stop();
 
 	/*
 	 * Clear the timer idle flag, so we avoid IPIs on remote queueing and
-- 
2.17.1


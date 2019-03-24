Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08D4222EB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfCXOOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:14:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43625 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfCXOOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:14:07 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h83sx-0001zC-Ik; Sun, 24 Mar 2019 15:14:03 +0100
Date:   Sun, 24 Mar 2019 14:12:21 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] scheduler updates for 5.1
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
Message-ID: <155343674152.28403.9250472064220526031.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

Second more careful attempt for this set of fixes:

 - Prevent a 32bit math overflow in the cpufreq code

 - Fix a buffer overflow when scanning the cgroup2 cpu.max property

 - A set of fixes for the NOHZ scheduler logic to prevent waking up CPUs
   even if the capacity of the busy CPUs is sufficient along with other
   tweaks optimizing the behaviour for asymmetric systems (big/little).


Thanks,

	tglx

------------------>
Konstantin Khlebnikov (1):
      sched/core: Fix buffer overflow in cgroup2 property cpu.max

Peter Zijlstra (1):
      sched/cpufreq: Fix 32-bit math overflow

Valentin Schneider (3):
      sched/fair: Comment some nohz_balancer_kick() kick conditions
      sched/fair: Tune down misfit NOHZ kicks
      sched/fair: Skip LLC NOHZ logic for asymmetric systems


 kernel/sched/core.c              |  2 +-
 kernel/sched/cpufreq_schedutil.c | 59 ++++++++++++----------------
 kernel/sched/fair.c              | 84 ++++++++++++++++++++++++++++++----------
 3 files changed, 89 insertions(+), 56 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6b2c055564b5..b7a4afdc33cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6943,7 +6943,7 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 {
 	char tok[21];	/* U64_MAX */
 
-	if (!sscanf(buf, "%s %llu", tok, periodp))
+	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 033ec7c45f13..1ccf77f6d346 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -48,10 +48,10 @@ struct sugov_cpu {
 
 	bool			iowait_boost_pending;
 	unsigned int		iowait_boost;
-	unsigned int		iowait_boost_max;
 	u64			last_update;
 
 	unsigned long		bw_dl;
+	unsigned long		min;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -303,8 +303,7 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 	if (delta_ns <= TICK_NSEC)
 		return false;
 
-	sg_cpu->iowait_boost = set_iowait_boost
-		? sg_cpu->sg_policy->policy->min : 0;
+	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
 	sg_cpu->iowait_boost_pending = set_iowait_boost;
 
 	return true;
@@ -344,14 +343,13 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
-		sg_cpu->iowait_boost <<= 1;
-		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
-			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		sg_cpu->iowait_boost =
+			min_t(unsigned int, sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
 		return;
 	}
 
 	/* First wakeup after IO: start with minimum boost */
-	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
+	sg_cpu->iowait_boost = sg_cpu->min;
 }
 
 /**
@@ -373,47 +371,38 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * This mechanism is designed to boost high frequently IO waiting tasks, while
  * being more conservative on tasks which does sporadic IO operations.
  */
-static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
-			       unsigned long *util, unsigned long *max)
+static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
+					unsigned long util, unsigned long max)
 {
-	unsigned int boost_util, boost_max;
+	unsigned long boost;
 
 	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
-		return;
+		return util;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sugov_iowait_reset(sg_cpu, time, false))
-		return;
+		return util;
 
-	/*
-	 * An IO waiting task has just woken up:
-	 * allow to further double the boost value
-	 */
-	if (sg_cpu->iowait_boost_pending) {
-		sg_cpu->iowait_boost_pending = false;
-	} else {
+	if (!sg_cpu->iowait_boost_pending) {
 		/*
-		 * Otherwise: reduce the boost value and disable it when we
-		 * reach the minimum.
+		 * No boost pending; reduce the boost value.
 		 */
 		sg_cpu->iowait_boost >>= 1;
-		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
+		if (sg_cpu->iowait_boost < sg_cpu->min) {
 			sg_cpu->iowait_boost = 0;
-			return;
+			return util;
 		}
 	}
 
+	sg_cpu->iowait_boost_pending = false;
+
 	/*
-	 * Apply the current boost value: a CPU is boosted only if its current
-	 * utilization is smaller then the current IO boost level.
+	 * @util is already in capacity scale; convert iowait_boost
+	 * into the same scale so we can compare.
 	 */
-	boost_util = sg_cpu->iowait_boost;
-	boost_max = sg_cpu->iowait_boost_max;
-	if (*util * boost_max < *max * boost_util) {
-		*util = boost_util;
-		*max = boost_max;
-	}
+	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
+	return max(boost, util);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -460,7 +449,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-	sugov_iowait_apply(sg_cpu, time, &util, &max);
+	util = sugov_iowait_apply(sg_cpu, time, util, max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -500,7 +489,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 		j_util = sugov_get_util(j_sg_cpu);
 		j_max = j_sg_cpu->max;
-		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
+		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
 		if (j_util * max > j_max * util) {
 			util = j_util;
@@ -837,7 +826,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu			= cpu;
 		sg_cpu->sg_policy		= sg_policy;
-		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
+		sg_cpu->min			=
+			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
+			policy->cpuinfo.max_freq;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8213ff6e365d..51003e1c794d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8058,6 +8058,18 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 				(rq->cpu_capacity_orig * 100));
 }
 
+/*
+ * Check whether a rq has a misfit task and if it looks like we can actually
+ * help that task: we can migrate the task to a CPU of higher capacity, or
+ * the task's current CPU is heavily pressured.
+ */
+static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+{
+	return rq->misfit_task_load &&
+		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
+		 check_cpu_capacity(rq, sd));
+}
+
 /*
  * Group imbalance indicates (and tries to solve) the problem where balancing
  * groups is inadequate due to ->cpus_allowed constraints.
@@ -9585,35 +9597,21 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	if (rq->nr_running >= 2 || rq->misfit_task_load) {
+	if (rq->nr_running >= 2) {
 		flags = NOHZ_KICK_MASK;
 		goto out;
 	}
 
 	rcu_read_lock();
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds) {
-		/*
-		 * If there is an imbalance between LLC domains (IOW we could
-		 * increase the overall cache use), we need some less-loaded LLC
-		 * domain to pull some load. Likewise, we may need to spread
-		 * load within the current LLC domain (e.g. packed SMT cores but
-		 * other CPUs are idle). We can't really know from here how busy
-		 * the others are - so just get a nohz balance going if it looks
-		 * like this LLC domain has tasks we could move.
-		 */
-		nr_busy = atomic_read(&sds->nr_busy_cpus);
-		if (nr_busy > 1) {
-			flags = NOHZ_KICK_MASK;
-			goto unlock;
-		}
-
-	}
 
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
-		if ((rq->cfs.h_nr_running >= 1) &&
-		    check_cpu_capacity(rq, sd)) {
+		/*
+		 * If there's a CFS task and the current CPU has reduced
+		 * capacity; kick the ILB to see if there's a better CPU to run
+		 * on.
+		 */
+		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -9621,6 +9619,11 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
+		/*
+		 * When ASYM_PACKING; see if there's a more preferred CPU
+		 * currently idle; in which case, kick the ILB to move tasks
+		 * around.
+		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_KICK_MASK;
@@ -9628,6 +9631,45 @@ static void nohz_balancer_kick(struct rq *rq)
 			}
 		}
 	}
+
+	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
+	if (sd) {
+		/*
+		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
+		 * to run the misfit task on.
+		 */
+		if (check_misfit_status(rq, sd)) {
+			flags = NOHZ_KICK_MASK;
+			goto unlock;
+		}
+
+		/*
+		 * For asymmetric systems, we do not want to nicely balance
+		 * cache use, instead we want to embrace asymmetry and only
+		 * ensure tasks have enough CPU capacity.
+		 *
+		 * Skip the LLC logic because it's not relevant in that case.
+		 */
+		goto unlock;
+	}
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
+		/*
+		 * If there is an imbalance between LLC domains (IOW we could
+		 * increase the overall cache use), we need some less-loaded LLC
+		 * domain to pull some load. Likewise, we may need to spread
+		 * load within the current LLC domain (e.g. packed SMT cores but
+		 * other CPUs are idle). We can't really know from here how busy
+		 * the others are - so just get a nohz balance going if it looks
+		 * like this LLC domain has tasks we could move.
+		 */
+		nr_busy = atomic_read(&sds->nr_busy_cpus);
+		if (nr_busy > 1) {
+			flags = NOHZ_KICK_MASK;
+			goto unlock;
+		}
+	}
 unlock:
 	rcu_read_unlock();
 out:


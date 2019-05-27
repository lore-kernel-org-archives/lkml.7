Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82AC216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE0GVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:21:41 -0400
Received: from foss.arm.com ([217.140.101.70]:56122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfE0GVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2BF01684;
        Sun, 26 May 2019 23:21:36 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFD1B3F59C;
        Sun, 26 May 2019 23:21:34 -0700 (PDT)
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
Subject: [PATCH 2/7] sched/fair: Replace source_load() & target_load() w/ weighted_cpuload()
Date:   Mon, 27 May 2019 07:21:11 +0100
Message-Id: <20190527062116.11512-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527062116.11512-1-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LB_BIAS disabled, source_load() & target_load() return
weighted_cpuload(). Replace both with calls to weighted_cpuload().

The function to obtain the load index (sd->*_idx) for an sd,
get_sd_load_idx(), can be removed as well.

Finally, get rid of the sched feature LB_BIAS.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c     | 90 ++---------------------------------------
 kernel/sched/features.h |  1 -
 2 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f619b93ca331..88779c45e8e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1467,8 +1467,6 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 }
 
 static unsigned long weighted_cpuload(struct rq *rq);
-static unsigned long source_load(int cpu, int type);
-static unsigned long target_load(int cpu, int type);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -5336,45 +5334,11 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
-/* Used instead of source_load when we know the type == 0 */
 static unsigned long weighted_cpuload(struct rq *rq)
 {
 	return cfs_rq_runnable_load_avg(&rq->cfs);
 }
 
-/*
- * Return a low guess at the load of a migration-source CPU weighted
- * according to the scheduling class and "nice" value.
- *
- * We want to under-estimate the load of migration sources, to
- * balance conservatively.
- */
-static unsigned long source_load(int cpu, int type)
-{
-	struct rq *rq = cpu_rq(cpu);
-	unsigned long total = weighted_cpuload(rq);
-
-	if (type == 0 || !sched_feat(LB_BIAS))
-		return total;
-
-	return min(rq->cpu_load[type-1], total);
-}
-
-/*
- * Return a high guess at the load of a migration-target CPU weighted
- * according to the scheduling class and "nice" value.
- */
-static unsigned long target_load(int cpu, int type)
-{
-	struct rq *rq = cpu_rq(cpu);
-	unsigned long total = weighted_cpuload(rq);
-
-	if (type == 0 || !sched_feat(LB_BIAS))
-		return total;
-
-	return max(rq->cpu_load[type-1], total);
-}
-
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -5482,7 +5446,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = target_load(this_cpu, sd->wake_idx);
+	this_eff_load = weighted_cpuload(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5500,7 +5464,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = source_load(prev_cpu, sd->wake_idx);
+	prev_eff_load = weighted_cpuload(cpu_rq(this_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5561,14 +5525,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 	unsigned long this_runnable_load = ULONG_MAX;
 	unsigned long min_avg_load = ULONG_MAX, this_avg_load = ULONG_MAX;
 	unsigned long most_spare = 0, this_spare = 0;
-	int load_idx = sd->forkexec_idx;
 	int imbalance_scale = 100 + (sd->imbalance_pct-100)/2;
 	unsigned long imbalance = scale_load_down(NICE_0_LOAD) *
 				(sd->imbalance_pct-100) / 100;
 
-	if (sd_flag & SD_BALANCE_WAKE)
-		load_idx = sd->wake_idx;
-
 	do {
 		unsigned long load, avg_load, runnable_load;
 		unsigned long spare_cap, max_spare_cap;
@@ -5592,12 +5552,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			/* Bias balancing toward CPUs of our domain */
-			if (local_group)
-				load = source_load(i, load_idx);
-			else
-				load = target_load(i, load_idx);
-
+			load = weighted_cpuload(cpu_rq(i));
 			runnable_load += load;
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
@@ -7679,34 +7634,6 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 	};
 }
 
-/**
- * get_sd_load_idx - Obtain the load index for a given sched domain.
- * @sd: The sched_domain whose load_idx is to be obtained.
- * @idle: The idle status of the CPU for whose sd load_idx is obtained.
- *
- * Return: The load index.
- */
-static inline int get_sd_load_idx(struct sched_domain *sd,
-					enum cpu_idle_type idle)
-{
-	int load_idx;
-
-	switch (idle) {
-	case CPU_NOT_IDLE:
-		load_idx = sd->busy_idx;
-		break;
-
-	case CPU_NEWLY_IDLE:
-		load_idx = sd->newidle_idx;
-		break;
-	default:
-		load_idx = sd->idle_idx;
-		break;
-	}
-
-	return load_idx;
-}
-
 static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7995,9 +7922,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
 {
-	int local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
-	int load_idx = get_sd_load_idx(env->sd, env->idle);
-	unsigned long load;
 	int i, nr_running;
 
 	memset(sgs, 0, sizeof(*sgs));
@@ -8008,13 +7932,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		/* Bias balancing toward CPUs of our domain: */
-		if (local_group)
-			load = target_load(i, load_idx);
-		else
-			load = source_load(i, load_idx);
-
-		sgs->group_load += load;
+		sgs->group_load += weighted_cpuload(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 858589b83377..2410db5e9a35 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -39,7 +39,6 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(DOUBLE_TICK, false)
-SCHED_FEAT(LB_BIAS, false)
 
 /*
  * Decrement CPU capacity based on time not spent running tasks
-- 
2.17.1


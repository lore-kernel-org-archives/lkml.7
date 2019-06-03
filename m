Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1BD2182B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tQvVjQQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfFCNDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:03:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFCNDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:03:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D2lQq602107
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:02:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D2lQq602107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559566968;
        bh=K3urjQF6gb2vS7AitEUt69E8yo4hQfAk4YYunD66sR0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tQvVjQQeLE/KL3GrjZGLGpJzpJ9MzaBgYWhMgDgPTpFCXjgQ5pWhbS//XXot89yTu
         knC8qfi73AwXtkbscZJs7EPX2Px3gCjea1QLgg09qFAt070J/8m38ZCqP/GjtOgBUW
         80A6aKhm08fFkrGK+cVGIdxPRFbMhbIt98mpoKQuoMG0zz+5KDc7zCuk/Dyb691SJ8
         kjlOA+B2gt1+l4JQsmn8lwstyJlY5LiyKbKSi3Jg6ZxMIFf+W9rSgvq9++iMpLLE1O
         WlsYoMOUMl4xTyUBh3RxlBSeGemxx+I00iM4DhZtlBpZ51yRCT70JNQTurFH53ipVE
         CYDNKwndrG9lg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D2k6d602103;
        Mon, 3 Jun 2019 06:02:46 -0700
Date:   Mon, 3 Jun 2019 06:02:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-1c1b8a7b03ef50f80f5d0c871ee261c04a6c967e@git.kernel.org>
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, torvalds@linux-foundation.org,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        fweisbec@gmail.com, hpa@zytor.com, patrick.bellasi@arm.com,
        mingo@kernel.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: valentin.schneider@arm.com, morten.rasmussen@arm.com,
          dietmar.eggemann@arm.com, quentin.perret@arm.com,
          vincent.guittot@linaro.org, torvalds@linux-foundation.org,
          patrick.bellasi@arm.com, fweisbec@gmail.com, hpa@zytor.com,
          mingo@kernel.org, riel@surriel.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20190527062116.11512-3-dietmar.eggemann@arm.com>
References: <20190527062116.11512-3-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Replace source_load() & target_load()
 with weighted_cpuload()
Git-Commit-ID: 1c1b8a7b03ef50f80f5d0c871ee261c04a6c967e
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

Commit-ID:  1c1b8a7b03ef50f80f5d0c871ee261c04a6c967e
Gitweb:     https://git.kernel.org/tip/1c1b8a7b03ef50f80f5d0c871ee261c04a6c967e
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Mon, 27 May 2019 07:21:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:49:39 +0200

sched/fair: Replace source_load() & target_load() with weighted_cpuload()

With LB_BIAS disabled, source_load() & target_load() return
weighted_cpuload(). Replace both with calls to weighted_cpuload().

The function to obtain the load index (sd->*_idx) for an sd,
get_sd_load_idx(), can be removed as well.

Finally, get rid of the sched feature LB_BIAS.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20190527062116.11512-3-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c     | 90 +++----------------------------------------------
 kernel/sched/features.h |  1 -
 2 files changed, 4 insertions(+), 87 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1aab323f1b4b..5b9691e5ea59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1467,8 +1467,6 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 }
 
 static unsigned long weighted_cpuload(struct rq *rq);
-static unsigned long source_load(int cpu, int type);
-static unsigned long target_load(int cpu, int type);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -5333,45 +5331,11 @@ static struct {
 
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
@@ -5479,7 +5443,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = target_load(this_cpu, sd->wake_idx);
+	this_eff_load = weighted_cpuload(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5497,7 +5461,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = source_load(prev_cpu, sd->wake_idx);
+	prev_eff_load = weighted_cpuload(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5558,14 +5522,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
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
@@ -5589,12 +5549,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
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
@@ -7676,34 +7631,6 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
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
@@ -7992,9 +7919,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
 {
-	int local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
-	int load_idx = get_sd_load_idx(env->sd, env->idle);
-	unsigned long load;
 	int i, nr_running;
 
 	memset(sgs, 0, sizeof(*sgs));
@@ -8005,13 +7929,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
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

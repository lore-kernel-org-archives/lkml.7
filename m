Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045C5C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED2E21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSbKJaDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfGSH7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:59:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfGSH7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:59:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so31235934wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/KfcFBbb+ZMXtCKjffZI7DjKNIQmY0DhBpSVTvXDk4=;
        b=tSbKJaDzYn04vsyAPXCzH8/Oo06qouGQp5loCPD8LQP+lL/2iKLTKbe4YcS+isotqN
         XKnSOT6oU6+8ZH0k87vqhTPOqb36fEO1cgc8Ims+OYOoFy0KoX5h9lEvOi8lixsD9QFh
         txvNjHx+8yECz/mO7fIpc1IbCdCrMIp8gTXtiIt47UjDzBykucXv3ZwNbTNlQqZVYt6J
         1syv2xz7dE8bPjit9rY3EKM0HWLPt0kQ3lo596d6/7906BPqF83f+CZcHBDP9qwK91yG
         l6Fb6DiTpUnd73uLu83had836v/gulM06nx19VfMVcF16Ivp32rH7Sa+q1jpGETLbO4A
         N+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/KfcFBbb+ZMXtCKjffZI7DjKNIQmY0DhBpSVTvXDk4=;
        b=LZfxuzv8aXq4RlkTVuXpMG9A2RppB0HQYJybLMAeY2bHella/5OjWsWA5p05jVnzj/
         9K0JQQtJFulbWKd2YokEdP97JOxUGwYAiID5W/8Fxshh/MdIcoI5RtU+FPJ9hwyS+xsu
         C1qE9NKu4UnUgrPqflcv+YbCTEuqbpepGR24yLRzpy+tgAa/5boM7yBrI67Y4NBgOUm3
         mYXq4ClSNOiSUHj/1uV9Tbepi8Yp/RuJ0HnMWzkXrAaZJyXNpvQjXvs8w0JzPv+EYg7y
         Ukl1yFKpZVPujpnOGoEBsR18qLmhqdslpAyi+M9T5GU0IeRbcU6q+Idip10P10XytyYH
         jP6Q==
X-Gm-Message-State: APjAAAUw1TeyP8jJL/pyE6cymR2az9IL3mvjrulBQj32K26r/wWcdx3j
        ZLcKCwANGw/aOikiApftjMKrpuPynpI=
X-Google-Smtp-Source: APXvYqzMRfi3LEICGO2nRSB99gcrlFkv/52PUob/qeOI8hwpMTtOXPHN9z9Fp/1NFLl3mOMN3y859w==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr4693868wrw.266.1563523137439;
        Fri, 19 Jul 2019 00:58:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:484b:32fe:1cf4:f69b])
        by smtp.gmail.com with ESMTPSA id c1sm58673826wrh.1.2019.07.19.00.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 00:58:56 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/5] sched/fair: rework load_balance
Date:   Fri, 19 Jul 2019 09:58:23 +0200
Message-Id: <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The load_balance algorithm contains some heuristics which have becomes
meaningless since the rework of metrics and the introduction of PELT.

Furthermore, it's sometimes difficult to fix wrong scheduling decisions
because everything is based on load whereas some imbalances are not
related to the load. The current algorithm ends up to create virtual and
meaningless value like the avg_load_per_task or tweaks the state of a
group to make it overloaded whereas it's not, in order to try to migrate
tasks.

load_balance should better qualify the imbalance of the group and define
cleary what has to be moved to fix this imbalance.

The type of sched_group has been extended to better reflect the type of
imbalance. We now have :
	group_has_spare
	group_fully_busy
	group_misfit_task
	group_asym_capacity
	group_imbalanced
	group_overloaded

Based on the type fo sched_group, load_balance now sets what it wants to
move in order to fix the imnbalance. It can be some load as before but
also some utilization, a number of task or a type of task:
	migrate_task
	migrate_util
	migrate_load
	migrate_misfit

This new load_balance algorithm fixes several pending wrong tasks
placement:
- the 1 task per CPU case with asymetrics system
- the case of cfs task preempted by other class
- the case of tasks not evenly spread on groups with spare capacity

The load balance decisions have been gathered in 3 functions:
- update_sd_pick_busiest() select the busiest sched_group.
- find_busiest_group() checks if there is an imabalance between local and
  busiest group.
- calculate_imbalance() decides what have to be moved.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 539 ++++++++++++++++++++++++++++------------------------
 1 file changed, 289 insertions(+), 250 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 67f0acd..472959df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3771,7 +3771,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}
 
-	rq->misfit_task_load = task_h_load(p);
+	rq->misfit_task_load = task_util_est(p);
 }
 
 #else /* CONFIG_SMP */
@@ -5376,18 +5376,6 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
-static unsigned long cpu_avg_load_per_task(int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-	unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
-	unsigned long load_avg = cpu_runnable_load(rq);
-
-	if (nr_running)
-		return load_avg / nr_running;
-
-	return 0;
-}
-
 static void record_wakee(struct task_struct *p)
 {
 	/*
@@ -7060,12 +7048,21 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 enum fbq_type { regular, remote, all };
 
 enum group_type {
-	group_other = 0,
+	group_has_spare = 0,
+	group_fully_busy,
 	group_misfit_task,
+	group_asym_capacity,
 	group_imbalanced,
 	group_overloaded,
 };
 
+enum group_migration {
+	migrate_task = 0,
+	migrate_util,
+	migrate_load,
+	migrate_misfit,
+};
+
 #define LBF_ALL_PINNED	0x01
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
@@ -7096,7 +7093,7 @@ struct lb_env {
 	unsigned int		loop_max;
 
 	enum fbq_type		fbq_type;
-	enum group_type		src_grp_type;
+	enum group_migration	src_grp_type;
 	struct list_head	tasks;
 };
 
@@ -7328,7 +7325,6 @@ static int detach_tasks(struct lb_env *env)
 {
 	struct list_head *tasks = &env->src_rq->cfs_tasks;
 	struct task_struct *p;
-	unsigned long load;
 	int detached = 0;
 
 	lockdep_assert_held(&env->src_rq->lock);
@@ -7361,19 +7357,46 @@ static int detach_tasks(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			goto next;
 
-		load = task_h_load(p);
+		if (env->src_grp_type == migrate_load) {
+			unsigned long load = task_h_load(p);
 
-		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
-			goto next;
+			if (sched_feat(LB_MIN) &&
+			    load < 16 && !env->sd->nr_balance_failed)
+				goto next;
+
+			if ((load / 2) > env->imbalance)
+				goto next;
+
+			env->imbalance -= load;
+		} else	if (env->src_grp_type == migrate_util) {
+			unsigned long util = task_util_est(p);
+
+			if (util > env->imbalance)
+				goto next;
+
+			env->imbalance -= util;
+		} else if (env->src_grp_type == migrate_misfit) {
+			unsigned long util = task_util_est(p);
+
+			/*
+			 * utilization of misfit task might decrease a bit
+			 * since it has been recorded. Be conservative in the
+			 * condition.
+			 */
+			if (2*util < env->imbalance)
+				goto next;
+
+			env->imbalance = 0;
+		} else {
+			/* Migrate task */
+			env->imbalance--;
+		}
 
-		if ((load / 2) > env->imbalance)
-			goto next;
 
 		detach_task(p, env);
 		list_add(&p->se.group_node, &env->tasks);
 
 		detached++;
-		env->imbalance -= load;
 
 #ifdef CONFIG_PREEMPT
 		/*
@@ -7646,7 +7669,6 @@ static unsigned long task_h_load(struct task_struct *p)
 struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
-	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
 	unsigned int sum_nr_running; /* Nr tasks running in the group */
@@ -7654,8 +7676,7 @@ struct sg_lb_stats {
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
-	int group_no_capacity;
-	int group_asym_capacity;
+	unsigned int group_asym_capacity; /* tasks should be move to preferred cpu */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -7670,10 +7691,10 @@ struct sg_lb_stats {
 struct sd_lb_stats {
 	struct sched_group *busiest;	/* Busiest group in this sd */
 	struct sched_group *local;	/* Local group in this sd */
-	unsigned long total_running;
 	unsigned long total_load;	/* Total load of all groups in sd */
 	unsigned long total_capacity;	/* Total capacity of all groups in sd */
 	unsigned long avg_load;	/* Average load across all groups in sd */
+	unsigned int prefer_sibling; /* tasks should go to sibling first */
 
 	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
 	struct sg_lb_stats local_stat;	/* Statistics of the local group */
@@ -7690,14 +7711,14 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 	*sds = (struct sd_lb_stats){
 		.busiest = NULL,
 		.local = NULL,
-		.total_running = 0UL,
 		.total_load = 0UL,
 		.total_capacity = 0UL,
 		.busiest_stat = {
 			.avg_load = 0UL,
 			.sum_nr_running = 0,
 			.sum_h_nr_running = 0,
-			.group_type = group_other,
+			.idle_cpus = UINT_MAX,
+			.group_type = group_has_spare,
 		},
 	};
 }
@@ -7887,7 +7908,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running < sgs->group_weight)
+	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7908,7 +7929,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running <= sgs->group_weight)
+	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -7941,10 +7962,11 @@ group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 }
 
 static inline enum
-group_type group_classify(struct sched_group *group,
+group_type group_classify(struct lb_env *env,
+			  struct sched_group *group,
 			  struct sg_lb_stats *sgs)
 {
-	if (sgs->group_no_capacity)
+	if (group_is_overloaded(env, sgs))
 		return group_overloaded;
 
 	if (sg_imbalanced(group))
@@ -7953,7 +7975,13 @@ group_type group_classify(struct sched_group *group,
 	if (sgs->group_misfit_task_load)
 		return group_misfit_task;
 
-	return group_other;
+	if (sgs->group_asym_capacity)
+		return group_asym_capacity;
+
+	if (group_has_capacity(env, sgs))
+		return group_has_spare;
+
+	return group_fully_busy;
 }
 
 static bool update_nohz_stats(struct rq *rq, bool force)
@@ -7990,10 +8018,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
 {
-	int i, nr_running;
+	int i, nr_running, local_group;
 
 	memset(sgs, 0, sizeof(*sgs));
 
+	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
@@ -8003,9 +8033,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
-		sgs->sum_nr_running += rq->cfs.h_nr_running;
-
 		nr_running = rq->nr_running;
+		sgs->sum_nr_running += nr_running;
+
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
 
@@ -8022,6 +8052,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (!nr_running && idle_cpu(i))
 			sgs->idle_cpus++;
 
+		if (local_group)
+			continue;
+
+		/* Check for a misfit task on the cpu */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
 		    sgs->group_misfit_task_load < rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
@@ -8029,17 +8063,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		}
 	}
 
-	/* Adjust by relative CPU capacity of the group */
-	sgs->group_capacity = group->sgc->capacity;
-	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
+	/* Check if dst cpu is idle and preferred to this group */
+	if (env->sd->flags & SD_ASYM_PACKING &&
+	    env->idle != CPU_NOT_IDLE &&
+	    sgs->sum_h_nr_running &&
+	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
+		sgs->group_asym_capacity = 1;
+	}
 
-	if (sgs->sum_h_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
+	sgs->group_capacity = group->sgc->capacity;
 
 	sgs->group_weight = group->group_weight;
 
-	sgs->group_no_capacity = group_is_overloaded(env, sgs);
-	sgs->group_type = group_classify(group, sgs);
+	sgs->group_type = group_classify(env, group, sgs);
+
+	/* Computing avg_load makes sense only when group is overloaded */
+	if (sgs->group_type != group_overloaded)
+		sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
+				sgs->group_capacity;
 }
 
 /**
@@ -8070,7 +8111,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 */
 	if (sgs->group_type == group_misfit_task &&
 	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
-	     !group_has_capacity(env, &sds->local_stat)))
+	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
 	if (sgs->group_type > busiest->group_type)
@@ -8079,11 +8120,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	if (sgs->group_type < busiest->group_type)
 		return false;
 
-	if (sgs->avg_load <= busiest->avg_load)
+	/* Select the overloaded group with highest avg_load */
+	if (sgs->group_type == group_overloaded &&
+	    sgs->avg_load <= busiest->avg_load)
+		return false;
+
+	/* Prefer to move from lowest priority CPU's work */
+	if (sgs->group_type == group_asym_capacity && sds->busiest &&
+	    sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
 		return false;
 
 	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
-		goto asym_packing;
+		goto spare_capacity;
 
 	/*
 	 * Candidate sg has no more than one task per CPU and
@@ -8091,7 +8139,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * capable CPUs may harm throughput. Maximize throughput,
 	 * power/energy consequences are not considered.
 	 */
-	if (sgs->sum_h_nr_running <= sgs->group_weight &&
+	if (sgs->group_type <= group_fully_busy &&
 	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
@@ -8102,39 +8150,32 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	    sgs->group_misfit_task_load < busiest->group_misfit_task_load)
 		return false;
 
-asym_packing:
-	/* This is the busiest node in its class. */
-	if (!(env->sd->flags & SD_ASYM_PACKING))
-		return true;
-
-	/* No ASYM_PACKING if target CPU is already busy */
-	if (env->idle == CPU_NOT_IDLE)
-		return true;
+spare_capacity:
 	/*
-	 * ASYM_PACKING needs to move all the work to the highest
-	 * prority CPUs in the group, therefore mark all groups
-	 * of lower priority than ourself as busy.
-	 *
-	 * This is primarily intended to used at the sibling level.  Some
-	 * cores like POWER7 prefer to use lower numbered SMT threads.  In the
-	 * case of POWER7, it can move to lower SMT modes only when higher
-	 * threads are idle.  When in lower SMT modes, the threads will
-	 * perform better since they share less core resources.  Hence when we
-	 * have idle threads, we want them to be the higher ones.
-	 */
-	if (sgs->sum_h_nr_running &&
-	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
-		sgs->group_asym_capacity = 1;
-		if (!sds->busiest)
-			return true;
+	 * Select not overloaded group with lowest number of idle cpus.
+	 * We could also compare the spare capacity which is more stable
+	 * but it can end up that the group has less spare capacity but
+	 * finally more idle cpus which means less opportunity to pull
+	 * tasks.
+	 */
+	if (sgs->group_type == group_has_spare &&
+	    sgs->idle_cpus > busiest->idle_cpus)
+		return false;
 
-		/* Prefer to move from lowest priority CPU's work */
-		if (sched_asym_prefer(sds->busiest->asym_prefer_cpu,
-				      sg->asym_prefer_cpu))
-			return true;
-	}
+	/*
+	 * Select the fully busy group with highest avg_load.
+	 * In theory, there is no need to pull task from such kind of group
+	 * because tasks have all compute capacity that they need but we can
+	 * still improve the overall throughput by reducing contention
+	 * when accessing shared HW resources.
+	 * XXX for now avg_load is not computed and always 0 so we select the
+	 * 1st one.
+	 */
+	if (sgs->group_type == group_fully_busy &&
+	    sgs->avg_load <= busiest->avg_load)
+		return false;
 
-	return false;
+	return true;
 }
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -8172,13 +8213,13 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
  * @env: The load balancing environment.
  * @sds: variable to hold the statistics for this sched_domain.
  */
+
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
 	struct sched_domain *child = env->sd->child;
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	bool prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
 	int sg_status = 0;
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -8205,22 +8246,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		if (local_group)
 			goto next_group;
 
-		/*
-		 * In case the child domain prefers tasks go to siblings
-		 * first, lower the sg capacity so that we'll try
-		 * and move all the excess tasks away. We lower the capacity
-		 * of a group only if the local group has the capacity to fit
-		 * these excess tasks. The extra check prevents the case where
-		 * you always pull from the heaviest group when it is already
-		 * under-utilized (possible with a large weight task outweighs
-		 * the tasks on the system).
-		 */
-		if (prefer_sibling && sds->local &&
-		    group_has_capacity(env, local) &&
-		    (sgs->sum_h_nr_running > local->sum_h_nr_running + 1)) {
-			sgs->group_no_capacity = 1;
-			sgs->group_type = group_classify(sg, sgs);
-		}
 
 		if (update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
@@ -8229,13 +8254,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 next_group:
 		/* Now, start updating sd_lb_stats */
-		sds->total_running += sgs->sum_h_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
 
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
+	/* Tag domain that child domain prefers tasks go to siblings first */
+	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
+
 #ifdef CONFIG_NO_HZ_COMMON
 	if ((env->flags & LBF_NOHZ_AGAIN) &&
 	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
@@ -8266,76 +8293,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 }
 
 /**
- * fix_small_imbalance - Calculate the minor imbalance that exists
- *			amongst the groups of a sched_domain, during
- *			load balancing.
- * @env: The load balancing environment.
- * @sds: Statistics of the sched_domain whose imbalance is to be calculated.
- */
-static inline
-void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
-{
-	unsigned long tmp, capa_now = 0, capa_move = 0;
-	unsigned int imbn = 2;
-	unsigned long scaled_busy_load_per_task;
-	struct sg_lb_stats *local, *busiest;
-
-	local = &sds->local_stat;
-	busiest = &sds->busiest_stat;
-
-	if (!local->sum_h_nr_running)
-		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
-	else if (busiest->load_per_task > local->load_per_task)
-		imbn = 1;
-
-	scaled_busy_load_per_task =
-		(busiest->load_per_task * SCHED_CAPACITY_SCALE) /
-		busiest->group_capacity;
-
-	if (busiest->avg_load + scaled_busy_load_per_task >=
-	    local->avg_load + (scaled_busy_load_per_task * imbn)) {
-		env->imbalance = busiest->load_per_task;
-		return;
-	}
-
-	/*
-	 * OK, we don't have enough imbalance to justify moving tasks,
-	 * however we may be able to increase total CPU capacity used by
-	 * moving them.
-	 */
-
-	capa_now += busiest->group_capacity *
-			min(busiest->load_per_task, busiest->avg_load);
-	capa_now += local->group_capacity *
-			min(local->load_per_task, local->avg_load);
-	capa_now /= SCHED_CAPACITY_SCALE;
-
-	/* Amount of load we'd subtract */
-	if (busiest->avg_load > scaled_busy_load_per_task) {
-		capa_move += busiest->group_capacity *
-			    min(busiest->load_per_task,
-				busiest->avg_load - scaled_busy_load_per_task);
-	}
-
-	/* Amount of load we'd add */
-	if (busiest->avg_load * busiest->group_capacity <
-	    busiest->load_per_task * SCHED_CAPACITY_SCALE) {
-		tmp = (busiest->avg_load * busiest->group_capacity) /
-		      local->group_capacity;
-	} else {
-		tmp = (busiest->load_per_task * SCHED_CAPACITY_SCALE) /
-		      local->group_capacity;
-	}
-	capa_move += local->group_capacity *
-		    min(local->load_per_task, local->avg_load + tmp);
-	capa_move /= SCHED_CAPACITY_SCALE;
-
-	/* Move if we gain throughput */
-	if (capa_move > capa_now)
-		env->imbalance = busiest->load_per_task;
-}
-
-/**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
  * @env: load balance environment
@@ -8343,13 +8300,17 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
  */
 static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	unsigned long max_pull, load_above_capacity = ~0UL;
 	struct sg_lb_stats *local, *busiest;
 
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
-	if (busiest->group_asym_capacity) {
+	if (busiest->group_type == group_asym_capacity) {
+		/*
+		 * In case of asym capacity, we will try to migrate all load
+		 * to the preferred CPU
+		 */
+		env->src_grp_type = migrate_load;
 		env->imbalance = busiest->group_load;
 		return;
 	}
@@ -8357,72 +8318,115 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
-		 * to ensure CPU-load equilibrium, look at wider averages. XXX
+		 * to ensure CPU-load equilibrium, try to move any task to fix
+		 * the imbalance. The next load balance will take care of
+		 * balancing back the system.
 		 */
-		busiest->load_per_task =
-			min(busiest->load_per_task, sds->avg_load);
+		env->src_grp_type = migrate_task;
+		env->imbalance = 1;
+		return;
 	}
 
-	/*
-	 * Avg load of busiest sg can be less and avg load of local sg can
-	 * be greater than avg load across all sgs of sd because avg load
-	 * factors in sg capacity and sgs with smaller group_type are
-	 * skipped when updating the busiest sg:
-	 */
-	if (busiest->group_type != group_misfit_task &&
-	    (busiest->avg_load <= sds->avg_load ||
-	     local->avg_load >= sds->avg_load)) {
-		env->imbalance = 0;
-		return fix_small_imbalance(env, sds);
+	if (busiest->group_type == group_misfit_task) {
+		/* Set imbalance to allow misfit task to be balanced. */
+		env->src_grp_type = migrate_misfit;
+		env->imbalance = busiest->group_misfit_task_load;
+		return;
 	}
 
 	/*
-	 * If there aren't any idle CPUs, avoid creating some.
+	 * Try to use spare capacity of local group without overloading it or
+	 * emptying busiest
 	 */
-	if (busiest->group_type == group_overloaded &&
-	    local->group_type   == group_overloaded) {
-		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
-		if (load_above_capacity > busiest->group_capacity) {
-			load_above_capacity -= busiest->group_capacity;
-			load_above_capacity *= scale_load_down(NICE_0_LOAD);
-			load_above_capacity /= busiest->group_capacity;
-		} else
-			load_above_capacity = ~0UL;
+	if (local->group_type == group_has_spare) {
+		long imbalance;
+
+		/*
+		 * If there is no overload, we just want to even the number of
+		 * idle cpus.
+		 */
+		env->src_grp_type = migrate_task;
+		imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
+
+		if (sds->prefer_sibling)
+			/*
+			 * When prefer sibling, evenly spread running tasks on
+			 * groups.
+			 */
+			imbalance = (busiest->sum_nr_running - local->sum_nr_running) >> 1;
+
+		if (busiest->group_type > group_fully_busy) {
+			/*
+			 * If busiest is overloaded, try to fill spare
+			 * capacity. This might end up creating spare capacity
+			 * in busiest or busiest still being overloaded but
+			 * there is no simple way to directly compute the
+			 * amount of load to migrate in order to balance the
+			 * system.
+			 */
+			env->src_grp_type = migrate_util;
+			imbalance = max(local->group_capacity, local->group_util) -
+				    local->group_util;
+		}
+
+		env->imbalance = imbalance;
+		return;
 	}
 
 	/*
-	 * We're trying to get all the CPUs to the average_load, so we don't
-	 * want to push ourselves above the average load, nor do we wish to
-	 * reduce the max loaded CPU below the average load. At the same time,
-	 * we also don't want to reduce the group load below the group
-	 * capacity. Thus we look for the minimum possible imbalance.
+	 * Local is fully busy but have to take more load to relieve the
+	 * busiest group
 	 */
-	max_pull = min(busiest->avg_load - sds->avg_load, load_above_capacity);
+	if (local->group_type < group_overloaded) {
+		/*
+		 * Local will become overvloaded so the avg_load metrics are
+		 * finally needed
+		 */
 
-	/* How much load to actually move to equalise the imbalance */
-	env->imbalance = min(
-		max_pull * busiest->group_capacity,
-		(sds->avg_load - local->avg_load) * local->group_capacity
-	) / SCHED_CAPACITY_SCALE;
+		local->avg_load = (local->group_load*SCHED_CAPACITY_SCALE)
+						/ local->group_capacity;
 
-	/* Boost imbalance to allow misfit task to be balanced. */
-	if (busiest->group_type == group_misfit_task) {
-		env->imbalance = max_t(long, env->imbalance,
-				       busiest->group_misfit_task_load);
+		sds->avg_load = (SCHED_CAPACITY_SCALE * sds->total_load)
+						/ sds->total_capacity;
 	}
 
 	/*
-	 * if *imbalance is less than the average load per runnable task
-	 * there is no guarantee that any tasks will be moved so we'll have
-	 * a think about bumping its value to force at least one task to be
-	 * moved
+	 * Both group are or will become overloaded and we're trying to get
+	 * all the CPUs to the average_load, so we don't want to push
+	 * ourselves above the average load, nor do we wish to reduce the
+	 * max loaded CPU below the average load. At the same time, we also
+	 * don't want to reduce the group load below the group capacity.
+	 * Thus we look for the minimum possible imbalance.
 	 */
-	if (env->imbalance < busiest->load_per_task)
-		return fix_small_imbalance(env, sds);
+	env->src_grp_type = migrate_load;
+	env->imbalance = min(
+		(busiest->avg_load - sds->avg_load) * busiest->group_capacity,
+		(sds->avg_load - local->avg_load) * local->group_capacity
+	) / SCHED_CAPACITY_SCALE;
 }
 
 /******* find_busiest_group() helpers end here *********************/
 
+/*
+ * Decision matrix according to the local and busiest group state
+ *
+ * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
+ * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
+ * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
+ * misfit_task      force     N/A        N/A    N/A  force      force
+ * asym_capacity    force     force      N/A    N/A  force      force
+ * imbalanced       force     force      N/A    N/A  force      force
+ * overloaded       force     force      N/A    N/A  force      avg_load
+ *
+ * N/A :      Not Applicable because already filtered while updating
+ *            statistics.
+ * balanced : The system is balanced for these 2 groups.
+ * force :    Calculate the imbalance as load migration is probably needed.
+ * avg_load : Only if imbalance is significant enough.
+ * nr_idle :  dst_cpu is not busy and the number of idle cpus is quite
+ *            different in groups.
+ */
+
 /**
  * find_busiest_group - Returns the busiest group within the sched_domain
  * if there is an imbalance.
@@ -8457,17 +8461,13 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	local = &sds.local_stat;
 	busiest = &sds.busiest_stat;
 
-	/* ASYM feature bypasses nice load balance check */
-	if (busiest->group_asym_capacity)
-		goto force_balance;
-
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest || busiest->sum_h_nr_running == 0)
 		goto out_balanced;
 
-	/* XXX broken for overlapping NUMA groups */
-	sds.avg_load = (SCHED_CAPACITY_SCALE * sds.total_load)
-						/ sds.total_capacity;
+	/* ASYM feature bypasses nice load balance check */
+	if (busiest->group_type == group_asym_capacity)
+		goto force_balance;
 
 	/*
 	 * If the busiest group is imbalanced the below checks don't
@@ -8477,14 +8477,6 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;
 
-	/*
-	 * When dst_cpu is idle, prevent SMP nice and/or asymmetric group
-	 * capacities from resulting in underutilization due to avg_load.
-	 */
-	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
-	    busiest->group_no_capacity)
-		goto force_balance;
-
 	/* Misfit tasks should be dealt with regardless of the avg load */
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;
@@ -8493,44 +8485,68 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
 	 */
-	if (local->avg_load >= busiest->avg_load)
+	if (local->group_type > busiest->group_type)
 		goto out_balanced;
 
 	/*
-	 * Don't pull any tasks if this group is already above the domain
-	 * average load.
+	 * When groups are overloaded, use the avg_load to ensure fairness
+	 * between tasks.
 	 */
-	if (local->avg_load >= sds.avg_load)
-		goto out_balanced;
+	if (local->group_type == group_overloaded) {
+		/*
+		 * If the local group is more loaded than the selected
+		 * busiest group don't try and pull any tasks.
+		 */
+		if (local->avg_load >= busiest->avg_load)
+			goto out_balanced;
+
+		/* XXX broken for overlapping NUMA groups */
+		sds.avg_load = (SCHED_CAPACITY_SCALE * sds.total_load)
+						/ sds.total_capacity;
 
-	if (env->idle == CPU_IDLE) {
 		/*
-		 * This CPU is idle. If the busiest group is not overloaded
-		 * and there is no imbalance between this and busiest group
-		 * wrt idle CPUs, it is balanced. The imbalance becomes
-		 * significant if the diff is greater than 1 otherwise we
-		 * might end up to just move the imbalance on another group
+		 * Don't pull any tasks if this group is already above the
+		 * domain average load.
 		 */
-		if ((busiest->group_type != group_overloaded) &&
-				(local->idle_cpus <= (busiest->idle_cpus + 1)))
+		if (local->avg_load >= sds.avg_load)
 			goto out_balanced;
-	} else {
+
 		/*
-		 * In the CPU_NEWLY_IDLE, CPU_NOT_IDLE cases, use
-		 * imbalance_pct to be conservative.
+		 * If the busiest group is more loaded, use imbalance_pct to be
+		 * conservative.
 		 */
 		if (100 * busiest->avg_load <=
 				env->sd->imbalance_pct * local->avg_load)
 			goto out_balanced;
+
 	}
 
+	/* Try to move all excess tasks to child's sibling domain */
+	if (sds.prefer_sibling && local->group_type == group_has_spare &&
+	    busiest->sum_nr_running > local->sum_nr_running + 1)
+		goto force_balance;
+
+	if (busiest->group_type != group_overloaded &&
+	     (env->idle == CPU_NOT_IDLE ||
+	      local->idle_cpus <= (busiest->idle_cpus + 1)))
+		/*
+		 * If the busiest group is not overloaded
+		 * and there is no imbalance between this and busiest group
+		 * wrt idle CPUs, it is balanced. The imbalance
+		 * becomes significant if the diff is greater than 1 otherwise
+		 * we might end up to just move the imbalance on another
+		 * group.
+		 */
+		goto out_balanced;
+
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
-	env->src_grp_type = busiest->group_type;
 	calculate_imbalance(env, &sds);
+
 	return env->imbalance ? sds.busiest : NULL;
 
 out_balanced:
+
 	env->imbalance = 0;
 	return NULL;
 }
@@ -8542,11 +8558,13 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 				     struct sched_group *group)
 {
 	struct rq *busiest = NULL, *rq;
-	unsigned long busiest_load = 0, busiest_capacity = 1;
+	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
+	unsigned int busiest_nr = 0;
 	int i;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
-		unsigned long capacity, load;
+		unsigned long capacity, load, util;
+		unsigned int nr_running;
 		enum fbq_type rt;
 
 		rq = cpu_rq(i);
@@ -8578,7 +8596,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * For ASYM_CPUCAPACITY domains with misfit tasks we simply
 		 * seek the "biggest" misfit task.
 		 */
-		if (env->src_grp_type == group_misfit_task) {
+		if (env->src_grp_type == migrate_misfit) {
 			if (rq->misfit_task_load > busiest_load) {
 				busiest_load = rq->misfit_task_load;
 				busiest = rq;
@@ -8600,12 +8618,33 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    rq->nr_running == 1)
 			continue;
 
-		load = cpu_runnable_load(rq);
+		if (env->src_grp_type == migrate_task) {
+			nr_running = rq->cfs.h_nr_running;
+
+			if (busiest_nr < nr_running) {
+				busiest_nr = nr_running;
+				busiest = rq;
+			}
+
+			continue;
+		}
+
+		if (env->src_grp_type == migrate_util) {
+			util = cpu_util(cpu_of(rq));
+
+			if (busiest_util < util) {
+				busiest_util = util;
+				busiest = rq;
+			}
+
+			continue;
+		}
 
 		/*
-		 * When comparing with imbalance, use cpu_runnable_load()
+		 * When comparing with load imbalance, use weighted_cpuload()
 		 * which is not scaled with the CPU capacity.
 		 */
+		load = cpu_runnable_load(rq);
 
 		if (rq->nr_running == 1 && load > env->imbalance &&
 		    !check_cpu_capacity(rq, env->sd))
@@ -8671,7 +8710,7 @@ voluntary_active_balance(struct lb_env *env)
 			return 1;
 	}
 
-	if (env->src_grp_type == group_misfit_task)
+	if (env->src_grp_type == migrate_misfit)
 		return 1;
 
 	return 0;
-- 
2.7.4


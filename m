Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A87C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A0520B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3/l69pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfHAOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:40:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33222 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHAOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:40:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so3829329wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWULD1yOxuZk7ZTMNvQPb2EL6Rg2ROVoM8OcY0sNXWs=;
        b=R3/l69pwolMxHzVPTgmcrZLViUfhf0L4QDCzyXR+PE/FPIdh982cRj3jKZrtdEGXa8
         7yZH+YLfRkl15rQJ6vbK4QAIw8zmtpN6RcpY12WLF2bvM+FmYjbUQ7T1GaBFhMIVWuYx
         dHu7+PHw6+QCk3hxZgKqe/qQwOinV+YQV+DwPxlHGx8ELrYdl+4bEdn4L7iIxLfFQQ0d
         U7LWmuJZTOU0wLUhChSJ9rhhYMidd8fQzMrmizDSdafj8mazT+3QY2h0ZdgdmWNkIZqA
         a1+2PgWA9kEUv8uQzw3EqY5uIOvELqYGL2WIP0g8gpR8xlayZ8cZhbi4zhgS8jDrZqtq
         7SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWULD1yOxuZk7ZTMNvQPb2EL6Rg2ROVoM8OcY0sNXWs=;
        b=nSBF4TsmHGvjgTTHUWJnMUPd1U1maiuSC413ZUjeO7QshpOWbkPylNcFdpGl3ek2qr
         AEvnIbG1Z9Bh5DMhsyZd9jTTAFi68vdEm++PZCJtxLURoIMtJ0lwcAoM7awZ4WT2qhft
         KGGfGHE39tVvIqkpK22TuHi9HRYX8vXckBSFUXEf7dYwAIBYy0t7IiPVIRzVIIcOHYob
         XXR0DOTZL1i/iLyotgqIceaKAFDVsdy0bCW04o0EK4prOG7w6hXNs0d+gYoG0Bam5vWD
         PXoRE7EqKP1KGoc3t/MWgh7u5Hqc7tbaB+fjKw2OjS9XcA1COQYHs1GWT6ubgP8lUzYb
         ILEA==
X-Gm-Message-State: APjAAAWdEWrpVJDrqQgEArlXYf5e3uPJRxXyfS5p/M22To23M6urszZP
        lcvkla2mlrnz4WUrWO8IXxxp/YxDbaA=
X-Google-Smtp-Source: APXvYqye32Xrcw1cyv0H0DpR6A/SgYoasMFw9kfoSN59IuKe2Vm1SwWAwO3xfh+VmQOFK4befDZw+A==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr121592254wmj.13.1564670435285;
        Thu, 01 Aug 2019 07:40:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9865:5ad1:5ff3:80c])
        by smtp.gmail.com with ESMTPSA id y10sm58768873wmj.2.2019.08.01.07.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 07:40:34 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 4/8] sched/fair: rework load_balance
Date:   Thu,  1 Aug 2019 16:40:20 +0200
Message-Id: <1564670424-26023-5-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
References: <1564670424-26023-1-git-send-email-vincent.guittot@linaro.org>
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

Based on the type of sched_group, load_balance now sets what it wants to
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
 kernel/sched/fair.c | 581 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 379 insertions(+), 202 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7f4a7e..a8681c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7136,13 +7136,28 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 
 enum fbq_type { regular, remote, all };
 
+/*
+ * group_type describes the group of CPUs at the moment of the load balance.
+ * The enum is ordered by pulling priority, with the group with lowest priority
+ * first so the groupe_type can be simply compared when selecting the busiest
+ * group. see update_sd_pick_busiest().
+ */
 enum group_type {
-	group_other = 0,
+	group_has_spare = 0,
+	group_fully_busy,
 	group_misfit_task,
+	group_asym_capacity,
 	group_imbalanced,
 	group_overloaded,
 };
 
+enum migration_type {
+	migrate_task = 0,
+	migrate_util,
+	migrate_load,
+	migrate_misfit,
+};
+
 #define LBF_ALL_PINNED	0x01
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
@@ -7173,7 +7188,7 @@ struct lb_env {
 	unsigned int		loop_max;
 
 	enum fbq_type		fbq_type;
-	enum group_type		src_grp_type;
+	enum migration_type	balance_type;
 	struct list_head	tasks;
 };
 
@@ -7405,7 +7420,7 @@ static int detach_tasks(struct lb_env *env)
 {
 	struct list_head *tasks = &env->src_rq->cfs_tasks;
 	struct task_struct *p;
-	unsigned long load;
+	unsigned long util, load;
 	int detached = 0;
 
 	lockdep_assert_held(&env->src_rq->lock);
@@ -7438,19 +7453,53 @@ static int detach_tasks(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			goto next;
 
-		load = task_h_load(p);
+		switch (env->balance_type) {
+		case migrate_task:
+			/* Migrate task */
+			env->imbalance--;
+			break;
 
-		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
-			goto next;
+		case migrate_util:
+			util = task_util_est(p);
 
-		if ((load / 2) > env->imbalance)
-			goto next;
+			if (util > env->imbalance)
+				goto next;
+
+			env->imbalance -= util;
+			break;
+
+		case migrate_load:
+			load = task_h_load(p);
+
+			if (sched_feat(LB_MIN) &&
+			    load < 16 && !env->sd->nr_balance_failed)
+				goto next;
+
+			if ((load / 2) > env->imbalance)
+				goto next;
+
+			env->imbalance -= load;
+			break;
+
+		case migrate_misfit:
+			load = task_h_load(p);
+
+			/*
+			 * utilization of misfit task might decrease a bit
+			 * since it has been recorded. Be conservative in the
+			 * condition.
+			 */
+			if (load < env->imbalance)
+				goto next;
+
+			env->imbalance = 0;
+			break;
+		}
 
 		detach_task(p, env);
 		list_add(&p->se.group_node, &env->tasks);
 
 		detached++;
-		env->imbalance -= load;
 
 #ifdef CONFIG_PREEMPT
 		/*
@@ -7729,8 +7778,7 @@ struct sg_lb_stats {
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
-	int group_no_capacity;
-	int group_asym_capacity;
+	unsigned int group_asym_capacity; /* tasks should be move to preferred cpu */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -7745,10 +7793,10 @@ struct sg_lb_stats {
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
@@ -7765,13 +7813,11 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 	*sds = (struct sd_lb_stats){
 		.busiest = NULL,
 		.local = NULL,
-		.total_running = 0UL,
 		.total_load = 0UL,
 		.total_capacity = 0UL,
 		.busiest_stat = {
-			.avg_load = 0UL,
-			.sum_h_nr_running = 0,
-			.group_type = group_other,
+			.idle_cpus = UINT_MAX,
+			.group_type = group_has_spare,
 		},
 	};
 }
@@ -8013,19 +8059,26 @@ group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
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
 		return group_imbalanced;
 
+	if (sgs->group_asym_capacity)
+		return group_asym_capacity;
+
 	if (sgs->group_misfit_task_load)
 		return group_misfit_task;
 
-	return group_other;
+	if (!group_has_capacity(env, sgs))
+		return group_fully_busy;
+
+	return group_has_spare;
 }
 
 static bool update_nohz_stats(struct rq *rq, bool force)
@@ -8062,10 +8115,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
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
 
@@ -8090,9 +8145,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
 		 */
-		if (!nr_running && idle_cpu(i))
+		if (!nr_running && idle_cpu(i)) {
 			sgs->idle_cpus++;
+			/* Idle cpu can't have misfit task */
+			continue;
+		}
+
+		if (local_group)
+			continue;
 
+		/* Check for a misfit task on the cpu */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
 		    sgs->group_misfit_task_load < rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
@@ -8100,14 +8162,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		}
 	}
 
-	/* Adjust by relative CPU capacity of the group */
+	/* Check if dst cpu is idle and preferred to this group */
+	if (env->sd->flags & SD_ASYM_PACKING &&
+	    env->idle != CPU_NOT_IDLE &&
+	    sgs->sum_h_nr_running &&
+	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
+		sgs->group_asym_capacity = 1;
+	}
+
 	sgs->group_capacity = group->sgc->capacity;
-	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
 	sgs->group_weight = group->group_weight;
 
-	sgs->group_no_capacity = group_is_overloaded(env, sgs);
-	sgs->group_type = group_classify(group, sgs);
+	sgs->group_type = group_classify(env, group, sgs);
+
+	/* Computing avg_load makes sense only when group is overloaded */
+	if (sgs->group_type == group_overloaded)
+		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
+				sgs->group_capacity;
 }
 
 /**
@@ -8130,6 +8202,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 {
 	struct sg_lb_stats *busiest = &sds->busiest_stat;
 
+
+	/* Make sure that there is at least one task to pull */
+	if (!sgs->sum_h_nr_running)
+		return false;
 	/*
 	 * Don't try to pull misfit tasks we can't help.
 	 * We can use max_capacity here as reduction in capacity on some
@@ -8138,7 +8214,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 */
 	if (sgs->group_type == group_misfit_task &&
 	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
-	     !group_has_capacity(env, &sds->local_stat)))
+	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
 	if (sgs->group_type > busiest->group_type)
@@ -8147,11 +8223,67 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	if (sgs->group_type < busiest->group_type)
 		return false;
 
-	if (sgs->avg_load <= busiest->avg_load)
+	/*
+	 * The candidate and the current busiest group are the same type of
+	 * group. Let check which one is the busiest according to the type.
+	 */
+
+	switch (sgs->group_type) {
+	case group_overloaded:
+		/* Select the overloaded group with highest avg_load. */
+		if (sgs->avg_load <= busiest->avg_load)
+			return false;
+		break;
+
+	case group_imbalanced:
+		/* Select the 1st imbalanced group as we don't have
+		 * any way to choose one more than another
+		 */
 		return false;
+		break;
 
-	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
-		goto asym_packing;
+	case group_asym_capacity:
+		/* Prefer to move from lowest priority CPU's work */
+		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
+			 return false;
+		break;
+
+	case group_misfit_task:
+		/*
+		 * If we have more than one misfit sg go with the
+		 * biggest misfit.
+		 */
+		if (sgs->group_misfit_task_load < busiest->group_misfit_task_load)
+			return false;
+		break;
+
+	case group_fully_busy:
+		/*
+		 * Select the fully busy group with highest avg_load.
+		 * In theory, there is no need to pull task from such
+		 * kind of group because tasks have all compute
+		 * capacity that they need but we can still improve the
+		 * overall throughput by reducing contention when
+		 * accessing shared HW resources.
+		 * XXX for now avg_load is not computed and always 0 so
+		 * we select the 1st one.
+		 */
+		if (sgs->avg_load <= busiest->avg_load)
+			return false;
+		break;
+
+	case group_has_spare:
+		/*
+		 * Select not overloaded group with lowest number of
+		 * idle cpus. We could also compare the spare capacity
+		 * which is more stable but it can end up that the
+		 * group has less spare capacity but finally more idle
+		 * cpus which means less opportunity to pull tasks.
+		 */
+		if (sgs->idle_cpus >= busiest->idle_cpus)
+			return false;
+		break;
+	}
 
 	/*
 	 * Candidate sg has no more than one task per CPU and
@@ -8159,50 +8291,12 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * capable CPUs may harm throughput. Maximize throughput,
 	 * power/energy consequences are not considered.
 	 */
-	if (sgs->sum_h_nr_running <= sgs->group_weight &&
-	    group_smaller_min_cpu_capacity(sds->local, sg))
-		return false;
-
-	/*
-	 * If we have more than one misfit sg go with the biggest misfit.
-	 */
-	if (sgs->group_type == group_misfit_task &&
-	    sgs->group_misfit_task_load < busiest->group_misfit_task_load)
+	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
+	    (sgs->group_type <= group_fully_busy) &&
+	    (group_smaller_min_cpu_capacity(sds->local, sg)))
 		return false;
 
-asym_packing:
-	/* This is the busiest node in its class. */
-	if (!(env->sd->flags & SD_ASYM_PACKING))
-		return true;
-
-	/* No ASYM_PACKING if target CPU is already busy */
-	if (env->idle == CPU_NOT_IDLE)
-		return true;
-	/*
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
-
-		/* Prefer to move from lowest priority CPU's work */
-		if (sched_asym_prefer(sds->busiest->asym_prefer_cpu,
-				      sg->asym_prefer_cpu))
-			return true;
-	}
-
-	return false;
+	return true;
 }
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -8240,13 +8334,13 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
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
@@ -8273,22 +8367,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -8297,13 +8375,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
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
@@ -8341,69 +8421,132 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
  */
 static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	unsigned long max_pull, load_above_capacity = ~0UL;
 	struct sg_lb_stats *local, *busiest;
 
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
+	if (busiest->group_type == group_imbalanced) {
+		/*
+		 * In the group_imb case we cannot rely on group-wide averages
+		 * to ensure CPU-load equilibrium, try to move any task to fix
+		 * the imbalance. The next load balance will take care of
+		 * balancing back the system.
+		 */
+		env->balance_type = migrate_task;
+		env->imbalance = 1;
+		return;
+	}
 
-	if (busiest->group_asym_capacity) {
+	if (busiest->group_type == group_asym_capacity) {
+		/*
+		 * In case of asym capacity, we will try to migrate all load
+		 * to the preferred CPU
+		 */
+		env->balance_type = migrate_load;
 		env->imbalance = busiest->group_load;
 		return;
 	}
 
+	if (busiest->group_type == group_misfit_task) {
+		/* Set imbalance to allow misfit task to be balanced. */
+		env->balance_type = migrate_misfit;
+		env->imbalance = busiest->group_misfit_task_load;
+		return;
+	}
+
 	/*
-	 * Avg load of busiest sg can be less and avg load of local sg can
-	 * be greater than avg load across all sgs of sd because avg load
-	 * factors in sg capacity and sgs with smaller group_type are
-	 * skipped when updating the busiest sg:
+	 * Try to use spare capacity of local group without overloading it or
+	 * emptying busiest
 	 */
-	if (busiest->group_type != group_misfit_task &&
-	    (busiest->avg_load <= sds->avg_load ||
-	     local->avg_load >= sds->avg_load)) {
-		env->imbalance = 0;
+	if (local->group_type == group_has_spare) {
+		if (busiest->group_type > group_fully_busy) {
+			/*
+			 * If busiest is overloaded, try to fill spare
+			 * capacity. This might end up creating spare capacity
+			 * in busiest or busiest still being overloaded but
+			 * there is no simple way to directly compute the
+			 * amount of load to migrate in order to balance the
+			 * system.
+			 */
+			env->balance_type = migrate_util;
+			env->imbalance = max(local->group_capacity, local->group_util) -
+				    local->group_util;
+			return;
+		}
+
+		if (busiest->group_weight == 1 || sds->prefer_sibling) {
+			/*
+			 * When prefer sibling, evenly spread running tasks on
+			 * groups.
+			 */
+			env->balance_type = migrate_task;
+			env->imbalance = (busiest->sum_h_nr_running - local->sum_h_nr_running) >> 1;
+			return;
+		}
+
+		/*
+		 * If there is no overload, we just want to even the number of
+		 * idle cpus.
+		 */
+		env->balance_type = migrate_task;
+		env->imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
 		return;
 	}
 
 	/*
-	 * If there aren't any idle CPUs, avoid creating some.
+	 * Local is fully busy but have to take more load to relieve the
+	 * busiest group
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
+	if (local->group_type < group_overloaded) {
+		/*
+		 * Local will become overvloaded so the avg_load metrics are
+		 * finally needed
+		 */
+
+		local->avg_load = (local->group_load * SCHED_CAPACITY_SCALE) /
+				  local->group_capacity;
+
+		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
+				sds->total_capacity;
 	}
 
 	/*
-	 * We're trying to get all the CPUs to the average_load, so we don't
-	 * want to push ourselves above the average load, nor do we wish to
-	 * reduce the max loaded CPU below the average load. At the same time,
-	 * we also don't want to reduce the group load below the group
-	 * capacity. Thus we look for the minimum possible imbalance.
+	 * Both group are or will become overloaded and we're trying to get
+	 * all the CPUs to the average_load, so we don't want to push
+	 * ourselves above the average load, nor do we wish to reduce the
+	 * max loaded CPU below the average load. At the same time, we also
+	 * don't want to reduce the group load below the group capacity.
+	 * Thus we look for the minimum possible imbalance.
 	 */
-	max_pull = min(busiest->avg_load - sds->avg_load, load_above_capacity);
-
-	/* How much load to actually move to equalise the imbalance */
+	env->balance_type = migrate_load;
 	env->imbalance = min(
-		max_pull * busiest->group_capacity,
+		(busiest->avg_load - sds->avg_load) * busiest->group_capacity,
 		(sds->avg_load - local->avg_load) * local->group_capacity
 	) / SCHED_CAPACITY_SCALE;
-
-	/* Boost imbalance to allow misfit task to be balanced. */
-	if (busiest->group_type == group_misfit_task) {
-		env->imbalance = max_t(long, env->imbalance,
-				       busiest->group_misfit_task_load);
-	}
-
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
@@ -8438,17 +8581,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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
+	/* Misfit tasks should be dealt with regardless of the avg load */
+	if (busiest->group_type == group_misfit_task)
+		goto force_balance;
+
+	/* ASYM feature bypasses nice load balance check */
+	if (busiest->group_type == group_asym_capacity)
+		goto force_balance;
 
 	/*
 	 * If the busiest group is imbalanced the below checks don't
@@ -8459,59 +8602,71 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	/*
-	 * When dst_cpu is idle, prevent SMP nice and/or asymmetric group
-	 * capacities from resulting in underutilization due to avg_load.
-	 */
-	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
-	    busiest->group_no_capacity)
-		goto force_balance;
-
-	/* Misfit tasks should be dealt with regardless of the avg load */
-	if (busiest->group_type == group_misfit_task)
-		goto force_balance;
-
-	/*
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
+		sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
+				sds.total_capacity;
 
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
+	    busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
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
@@ -8523,11 +8678,13 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
@@ -8555,20 +8712,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		/*
-		 * For ASYM_CPUCAPACITY domains with misfit tasks we simply
-		 * seek the "biggest" misfit task.
-		 */
-		if (env->src_grp_type == group_misfit_task) {
-			if (rq->misfit_task_load > busiest_load) {
-				busiest_load = rq->misfit_task_load;
-				busiest = rq;
-			}
-
-			continue;
-		}
-
 		capacity = capacity_of(i);
+		nr_running = rq->cfs.h_nr_running;
 
 		/*
 		 * For ASYM_CPUCAPACITY domains, don't pick a CPU that could
@@ -8578,35 +8723,67 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
 		    capacity_of(env->dst_cpu) < capacity &&
-		    rq->nr_running == 1)
+		    nr_running == 1)
 			continue;
 
-		load = cpu_runnable_load(rq);
+		switch (env->balance_type) {
+		case migrate_task:
+			if (busiest_nr < nr_running) {
+				busiest_nr = nr_running;
+				busiest = rq;
+			}
+			break;
 
-		/*
-		 * When comparing with imbalance, use cpu_runnable_load()
-		 * which is not scaled with the CPU capacity.
-		 */
+		case migrate_util:
+			util = cpu_util(cpu_of(rq));
 
-		if (rq->nr_running == 1 && load > env->imbalance &&
-		    !check_cpu_capacity(rq, env->sd))
-			continue;
+			if (busiest_util < util) {
+				busiest_util = util;
+				busiest = rq;
+			}
+			break;
+
+		case migrate_load:
+			/*
+			 * When comparing with load imbalance, use cpu_runnable_load()
+			 * which is not scaled with the CPU capacity.
+			 */
+			load = cpu_runnable_load(rq);
+
+			if (nr_running == 1 && load > env->imbalance &&
+			    !check_cpu_capacity(rq, env->sd))
+				break;
+
+			/*
+			 * For the load comparisons with the other CPU's, consider
+			 * the cpu_runnable_load() scaled with the CPU capacity, so
+			 * that the load can be moved away from the CPU that is
+			 * potentially running at a lower capacity.
+			 *
+			 * Thus we're looking for max(load_i / capacity_i), crosswise
+			 * multiplication to rid ourselves of the division works out
+			 * to: load_i * capacity_j > load_j * capacity_i;  where j is
+			 * our previous maximum.
+			 */
+			if (load * busiest_capacity > busiest_load * capacity) {
+				busiest_load = load;
+				busiest_capacity = capacity;
+				busiest = rq;
+			}
+			break;
+
+		case migrate_misfit:
+			/*
+			 * For ASYM_CPUCAPACITY domains with misfit tasks we simply
+			 * seek the "biggest" misfit task.
+			 */
+			if (rq->misfit_task_load > busiest_load) {
+				busiest_load = rq->misfit_task_load;
+				busiest = rq;
+			}
+
+			break;
 
-		/*
-		 * For the load comparisons with the other CPU's, consider
-		 * the cpu_runnable_load() scaled with the CPU capacity, so
-		 * that the load can be moved away from the CPU that is
-		 * potentially running at a lower capacity.
-		 *
-		 * Thus we're looking for max(load_i / capacity_i), crosswise
-		 * multiplication to rid ourselves of the division works out
-		 * to: load_i * capacity_j > load_j * capacity_i;  where j is
-		 * our previous maximum.
-		 */
-		if (load * busiest_capacity > busiest_load * capacity) {
-			busiest_load = load;
-			busiest_capacity = capacity;
-			busiest = rq;
 		}
 	}
 
@@ -8652,7 +8829,7 @@ voluntary_active_balance(struct lb_env *env)
 			return 1;
 	}
 
-	if (env->src_grp_type == group_misfit_task)
+	if (env->balance_type == migrate_misfit)
 		return 1;
 
 	return 0;
@@ -8765,7 +8942,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	env.src_rq = busiest;
 
 	ld_moved = 0;
-	if (busiest->cfs.h_nr_running > 1) {
+	if (busiest->nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
 		 * an imbalance but busiest->nr_running <= 1, the group is
-- 
2.7.4


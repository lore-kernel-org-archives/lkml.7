Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2113DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDC5222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VttkybTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634091AbfJRN1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:27:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34331 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439247AbfJRN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:27:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so9362293wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYd+mUbPd3e33Spb/1ehWk7tN88cH6YOPs4EY/LiqPc=;
        b=VttkybTh0QZIjCzC2bL9vxvKkoHzzSICvaje+Ck9uoTmQo6hcy1P7WgvpAdsOq2m8w
         Fh0UvF1w+ZRdvAdvCU0grNxC1Ndrkm6dVKebiqp2buBE7ksvLv9fRKPnNcCSFWQEwcxq
         4qpjAeLtfWk6fShNIG1MiuawVKEHdVCBYbthScqRbPPGxvGgUfmEGQsbTmSmNdEsU2YD
         oRLy1GYqYsvLsKil3zQrKxQq1WCYzWfyJy1UD9dyt9VjhGOHHwyKwWKBZ670xWXe41bR
         wF0nLhao8m6Xt8NCYnKlTy774zRu9rpEqnAlG0JVdgn0yXKbIGBCB4GlbPt4W09QIHkN
         8rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYd+mUbPd3e33Spb/1ehWk7tN88cH6YOPs4EY/LiqPc=;
        b=NVKqxDmB1rWiOjoIw8UXXNGpfkbnTn5x6VTwSe4P8DTnfb0FU4eTpM2rqMUaj0sg19
         KgZoQNmo5JlCB/CoMT6AEmSTIFl4uaCMYkCqasTpsH5ZpeSAQLb20LdrzryRYP2FBfeP
         ouW9hFSLcBywIT7aysvQOZmKW21w2JuoQcJ1G5f6q1Jucmu3Gj/am2AOfOI4WIK3SNZ/
         kd+h+mfuSFyPdD7QwNka0dSimO/I1W0gNGzLG3S7rphmi62FtxeaqiitD5KLAF2JamSy
         tGq8HsVs2+rZoWkK/tkgZd/cSGgZA733HG94d7ZlRld95DD8K5AJLohraUU/GjRkhCV4
         SfzQ==
X-Gm-Message-State: APjAAAWQ6pmyi9NiSyUaHozugvpCVPXQuT5pZa4qeD3E6mOIJvKIQCet
        d3OsOIvdVvC5ljMKCgVfOZqOYV+ov4M=
X-Google-Smtp-Source: APXvYqxO3djWwVn9qUh8zWWBe2cWKDIhgawrD9elLpYpWK0CX1oUYGEInRSUKMimIwR4kpikQQl3cg==
X-Received: by 2002:a1c:f401:: with SMTP id z1mr7425910wma.66.1571405223931;
        Fri, 18 Oct 2019 06:27:03 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:27:02 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 11/11] sched/fair: rework find_idlest_group
Date:   Fri, 18 Oct 2019 15:26:38 +0200
Message-Id: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The slow wake up path computes per sched_group statisics to select the
idlest group, which is quite similar to what load_balance() is doing
for selecting busiest group. Rework find_idlest_group() to classify the
sched_group and select the idlest one following the same steps as
load_balance().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 384 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 256 insertions(+), 128 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed1800d..fbaafae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5541,127 +5541,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return target;
 }
 
-static unsigned long cpu_util_without(int cpu, struct task_struct *p);
-
-static unsigned long capacity_spare_without(int cpu, struct task_struct *p)
-{
-	return max_t(long, capacity_of(cpu) - cpu_util_without(cpu, p), 0);
-}
-
-/*
- * find_idlest_group finds and returns the least busy CPU group within the
- * domain.
- *
- * Assumes p is allowed on at least one CPU in sd.
- */
 static struct sched_group *
 find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag)
-{
-	struct sched_group *idlest = NULL, *group = sd->groups;
-	struct sched_group *most_spare_sg = NULL;
-	unsigned long min_load = ULONG_MAX, this_load = ULONG_MAX;
-	unsigned long most_spare = 0, this_spare = 0;
-	int imbalance_scale = 100 + (sd->imbalance_pct-100)/2;
-	unsigned long imbalance = scale_load_down(NICE_0_LOAD) *
-				(sd->imbalance_pct-100) / 100;
-
-	do {
-		unsigned long load;
-		unsigned long spare_cap, max_spare_cap;
-		int local_group;
-		int i;
-
-		/* Skip over this group if it has no CPUs allowed */
-		if (!cpumask_intersects(sched_group_span(group),
-					p->cpus_ptr))
-			continue;
-
-		local_group = cpumask_test_cpu(this_cpu,
-					       sched_group_span(group));
-
-		/*
-		 * Tally up the load of all CPUs in the group and find
-		 * the group containing the CPU with most spare capacity.
-		 */
-		load = 0;
-		max_spare_cap = 0;
-
-		for_each_cpu(i, sched_group_span(group)) {
-			load += cpu_load(cpu_rq(i));
-
-			spare_cap = capacity_spare_without(i, p);
-
-			if (spare_cap > max_spare_cap)
-				max_spare_cap = spare_cap;
-		}
-
-		/* Adjust by relative CPU capacity of the group */
-		load = (load * SCHED_CAPACITY_SCALE) /
-					group->sgc->capacity;
-
-		if (local_group) {
-			this_load = load;
-			this_spare = max_spare_cap;
-		} else {
-			if (load < min_load) {
-				min_load = load;
-				idlest = group;
-			}
-
-			if (most_spare < max_spare_cap) {
-				most_spare = max_spare_cap;
-				most_spare_sg = group;
-			}
-		}
-	} while (group = group->next, group != sd->groups);
-
-	/*
-	 * The cross-over point between using spare capacity or least load
-	 * is too conservative for high utilization tasks on partially
-	 * utilized systems if we require spare_capacity > task_util(p),
-	 * so we allow for some task stuffing by using
-	 * spare_capacity > task_util(p)/2.
-	 *
-	 * Spare capacity can't be used for fork because the utilization has
-	 * not been set yet, we must first select a rq to compute the initial
-	 * utilization.
-	 */
-	if (sd_flag & SD_BALANCE_FORK)
-		goto skip_spare;
-
-	if (this_spare > task_util(p) / 2 &&
-	    imbalance_scale*this_spare > 100*most_spare)
-		return NULL;
-
-	if (most_spare > task_util(p) / 2)
-		return most_spare_sg;
-
-skip_spare:
-	if (!idlest)
-		return NULL;
-
-	/*
-	 * When comparing groups across NUMA domains, it's possible for the
-	 * local domain to be very lightly loaded relative to the remote
-	 * domains but "imbalance" skews the comparison making remote CPUs
-	 * look much more favourable. When considering cross-domain, add
-	 * imbalance to the load on the remote node and consider staying
-	 * local.
-	 */
-	if ((sd->flags & SD_NUMA) &&
-	     min_load + imbalance >= this_load)
-		return NULL;
-
-	if (min_load >= this_load + imbalance)
-		return NULL;
-
-	if ((this_load < (min_load + imbalance)) &&
-	    (100*this_load < imbalance_scale*min_load))
-		return NULL;
-
-	return idlest;
-}
+		  int this_cpu, int sd_flag);
 
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -5734,7 +5616,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 		return prev_cpu;
 
 	/*
-	 * We need task's util for capacity_spare_without, sync it up to
+	 * We need task's util for cpu_util_without, sync it up to
 	 * prev_cpu's last_update_time.
 	 */
 	if (!(sd_flag & SD_BALANCE_FORK))
@@ -7915,13 +7797,13 @@ static inline int sg_imbalanced(struct sched_group *group)
  * any benefit for the load balance.
  */
 static inline bool
-group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
+group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 {
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
-			(sgs->group_util * env->sd->imbalance_pct))
+			(sgs->group_util * imbalance_pct))
 		return true;
 
 	return false;
@@ -7936,13 +7818,13 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
  *  false.
  */
 static inline bool
-group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
+group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 {
 	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
-			(sgs->group_util * env->sd->imbalance_pct))
+			(sgs->group_util * imbalance_pct))
 		return true;
 
 	return false;
@@ -7969,11 +7851,11 @@ group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 }
 
 static inline enum
-group_type group_classify(struct lb_env *env,
+group_type group_classify(unsigned int imbalance_pct,
 			  struct sched_group *group,
 			  struct sg_lb_stats *sgs)
 {
-	if (group_is_overloaded(env, sgs))
+	if (group_is_overloaded(imbalance_pct, sgs))
 		return group_overloaded;
 
 	if (sg_imbalanced(group))
@@ -7985,7 +7867,7 @@ group_type group_classify(struct lb_env *env,
 	if (sgs->group_misfit_task_load)
 		return group_misfit_task;
 
-	if (!group_has_capacity(env, sgs))
+	if (!group_has_capacity(imbalance_pct, sgs))
 		return group_fully_busy;
 
 	return group_has_spare;
@@ -8086,7 +7968,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_weight = group->group_weight;
 
-	sgs->group_type = group_classify(env, group, sgs);
+	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	/* Computing avg_load makes sense only when group is overloaded */
 	if (sgs->group_type == group_overloaded)
@@ -8241,6 +8123,252 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+
+struct sg_lb_stats;
+
+/*
+ * update_sg_wakeup_stats - Update sched_group's statistics for wakeup.
+ * @denv: The ched_domain level to look for idlest group.
+ * @group: sched_group whose statistics are to be updated.
+ * @sgs: variable to hold the statistics for this group.
+ */
+static inline void update_sg_wakeup_stats(struct sched_domain *sd,
+					  struct sched_group *group,
+					  struct sg_lb_stats *sgs,
+					  struct task_struct *p)
+{
+	int i, nr_running;
+
+	memset(sgs, 0, sizeof(*sgs));
+
+	for_each_cpu(i, sched_group_span(group)) {
+		struct rq *rq = cpu_rq(i);
+
+		sgs->group_load += cpu_load(rq);
+		sgs->group_util += cpu_util_without(i, p);
+		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
+
+		nr_running = rq->nr_running;
+		sgs->sum_nr_running += nr_running;
+
+		/*
+		 * No need to call idle_cpu() if nr_running is not 0
+		 */
+		if (!nr_running && idle_cpu(i))
+			sgs->idle_cpus++;
+
+
+	}
+
+	/* Check if task fits in the group */
+	if (sd->flags & SD_ASYM_CPUCAPACITY &&
+	    !task_fits_capacity(p, group->sgc->max_capacity)) {
+		sgs->group_misfit_task_load = 1;
+	}
+
+	sgs->group_capacity = group->sgc->capacity;
+
+	sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
+
+	/*
+	 * Computing avg_load makes sense only when group is fully busy or
+	 * overloaded
+	 */
+	if (sgs->group_type < group_fully_busy)
+		sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
+				sgs->group_capacity;
+}
+
+static bool update_pick_idlest(struct sched_group *idlest,
+			       struct sg_lb_stats *idlest_sgs,
+			       struct sched_group *group,
+			       struct sg_lb_stats *sgs)
+{
+	if (sgs->group_type < idlest_sgs->group_type)
+		return true;
+
+	if (sgs->group_type > idlest_sgs->group_type)
+		return false;
+
+	/*
+	 * The candidate and the current idles group are the same type of
+	 * group. Let check which one is the idlest according to the type.
+	 */
+
+	switch (sgs->group_type) {
+	case group_overloaded:
+	case group_fully_busy:
+		/* Select the group with lowest avg_load. */
+		if (idlest_sgs->avg_load <= sgs->avg_load)
+			return false;
+		break;
+
+	case group_imbalanced:
+	case group_asym_packing:
+		/* Those types are not used in the slow wakeup path */
+		return false;
+
+	case group_misfit_task:
+		/* Select group with the highest max capacity */
+		if (idlest->sgc->max_capacity >= group->sgc->max_capacity)
+			return false;
+		break;
+
+	case group_has_spare:
+		/* Select group with most idle CPUs */
+		if (idlest_sgs->idle_cpus >= sgs->idle_cpus)
+			return false;
+		break;
+	}
+
+	return true;
+}
+
+/*
+ * find_idlest_group finds and returns the least busy CPU group within the
+ * domain.
+ *
+ * Assumes p is allowed on at least one CPU in sd.
+ */
+static struct sched_group *
+find_idlest_group(struct sched_domain *sd, struct task_struct *p,
+		  int this_cpu, int sd_flag)
+{
+	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
+	struct sg_lb_stats local_sgs, tmp_sgs;
+	struct sg_lb_stats *sgs;
+	unsigned long imbalance;
+	struct sg_lb_stats idlest_sgs = {
+			.avg_load = UINT_MAX,
+			.group_type = group_overloaded,
+	};
+
+	imbalance = scale_load_down(NICE_0_LOAD) *
+				(sd->imbalance_pct-100) / 100;
+
+	do {
+		int local_group;
+
+		/* Skip over this group if it has no CPUs allowed */
+		if (!cpumask_intersects(sched_group_span(group),
+					p->cpus_ptr))
+			continue;
+
+		local_group = cpumask_test_cpu(this_cpu,
+					       sched_group_span(group));
+
+		if (local_group) {
+			sgs = &local_sgs;
+			local = group;
+		} else {
+			sgs = &tmp_sgs;
+		}
+
+		update_sg_wakeup_stats(sd, group, sgs, p);
+
+		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
+			idlest = group;
+			idlest_sgs = *sgs;
+		}
+
+	} while (group = group->next, group != sd->groups);
+
+
+	/* There is no idlest group to push tasks to */
+	if (!idlest)
+		return NULL;
+
+	/*
+	 * If the local group is idler than the selected idlest group
+	 * don't try and push the task.
+	 */
+	if (local_sgs.group_type < idlest_sgs.group_type)
+		return NULL;
+
+	/*
+	 * If the local group is busier than the selected idlest group
+	 * try and push the task.
+	 */
+	if (local_sgs.group_type > idlest_sgs.group_type)
+		return idlest;
+
+	switch (local_sgs.group_type) {
+	case group_overloaded:
+	case group_fully_busy:
+		/*
+		 * When comparing groups across NUMA domains, it's possible for
+		 * the local domain to be very lightly loaded relative to the
+		 * remote domains but "imbalance" skews the comparison making
+		 * remote CPUs look much more favourable. When considering
+		 * cross-domain, add imbalance to the load on the remote node
+		 * and consider staying local.
+		 */
+
+		if ((sd->flags & SD_NUMA) &&
+		    ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
+			return NULL;
+
+		/*
+		 * If the local group is less loaded than the selected
+		 * idlest group don't try and push any tasks.
+		 */
+		if (idlest_sgs.avg_load >= (local_sgs.avg_load + imbalance))
+			return NULL;
+
+		if (100 * local_sgs.avg_load <= sd->imbalance_pct * idlest_sgs.avg_load)
+			return NULL;
+		break;
+
+	case group_imbalanced:
+	case group_asym_packing:
+		/* Those type are not used in the slow wakeup path */
+		return NULL;
+
+	case group_misfit_task:
+		/* Select group with the highest max capacity */
+		if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
+			return NULL;
+		break;
+
+	case group_has_spare:
+		if (sd->flags & SD_NUMA) {
+#ifdef CONFIG_NUMA_BALANCING
+			int idlest_cpu;
+			/*
+			 * If there is spare capacity at NUMA, try to select
+			 * the preferred node
+			 */
+			if (cpu_to_node(this_cpu) == p->numa_preferred_nid)
+				return NULL;
+
+			idlest_cpu = cpumask_first(sched_group_span(idlest));
+			if (cpu_to_node(idlest_cpu) == p->numa_preferred_nid)
+				return idlest;
+#endif
+			/*
+			 * Otherwise, keep the task on this node to stay close
+			 * its wakeup source and improve locality. If there is
+			 * a real need of migration, periodic load balance will
+			 * take care of it.
+			 */
+			if (local_sgs.idle_cpus)
+				return NULL;
+		}
+
+		/*
+		 * Select group with highest number of idle cpus. We could also
+		 * compare the utilization which is more stable but it can end
+		 * up that the group has less spare capacity but finally more
+		 * idle cpus which means more opportunity to run task.
+		 */
+		if (local_sgs.idle_cpus >= idlest_sgs.idle_cpus)
+			return NULL;
+		break;
+	}
+
+	return idlest;
+}
+
 /**
  * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
  * @env: The load balancing environment.
-- 
2.7.4


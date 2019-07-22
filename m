Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDC3C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6714E21900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfGVRe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:34:27 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37688 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGVReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:22 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hpcC7-0003HL-Um; Mon, 22 Jul 2019 13:33:51 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 01/14] sched: introduce task_se_h_load helper
Date:   Mon, 22 Jul 2019 13:33:35 -0400
Message-Id: <20190722173348.9241-2-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722173348.9241-1-riel@surriel.com>
References: <20190722173348.9241-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the hierarchical load of a sched_entity needs to be calculated.
Rename task_h_load to task_se_h_load, and directly pass a sched_entity to
that function.

Move the function declaration up above where it will be used later.

No functional changes.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sched/fair.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..eadf9a96b3e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -242,6 +242,7 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 
 
 const struct sched_class fair_sched_class;
+static unsigned long task_se_h_load(struct sched_entity *se);
 
 /**************************************************************
  * CFS operations on generic schedulable entities:
@@ -706,7 +707,6 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #ifdef CONFIG_SMP
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
-static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
 /* Give new sched_entity start runnable values to heavy its load in infant time */
@@ -1668,7 +1668,7 @@ static void task_numa_compare(struct task_numa_env *env,
 	/*
 	 * In the overloaded case, try and keep the load balanced.
 	 */
-	load = task_h_load(env->p) - task_h_load(cur);
+	load = task_se_h_load(env->p->se) - task_se_h_load(cur->se);
 	if (!load)
 		goto assign;
 
@@ -1706,7 +1706,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	bool maymove = false;
 	int cpu;
 
-	load = task_h_load(env->p);
+	load = task_se_h_load(env->p->se);
 	dst_load = env->dst_stats.load + load;
 	src_load = env->src_stats.load - load;
 
@@ -3389,7 +3389,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
  * avg. The immediate corollary is that all (fair) tasks must be attached, see
  * post_init_entity_util_avg().
  *
- * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
+ * cfs_rq->avg is used for task_se_h_load() and update_cfs_share() for example.
  *
  * Returns true if the load decayed or we removed load.
  *
@@ -3522,7 +3522,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
-	 * track group sched_entity load average for task_h_load calc in migration
+	 * track group sched_entity load average for task_se_h_load calc in migration
 	 */
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
 		__update_load_avg_se(now, cfs_rq, se);
@@ -3751,7 +3751,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}
 
-	rq->misfit_task_load = task_h_load(p);
+	rq->misfit_task_load = task_se_h_load(&p->se);
 }
 
 #else /* CONFIG_SMP */
@@ -5739,7 +5739,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	this_eff_load = target_load(this_cpu, sd->wake_idx);
 
 	if (sync) {
-		unsigned long current_load = task_h_load(current);
+		unsigned long current_load = task_se_h_load(&current->se);
 
 		if (current_load > this_eff_load)
 			return this_cpu;
@@ -5747,7 +5747,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load -= current_load;
 	}
 
-	task_load = task_h_load(p);
+	task_load = task_se_h_load(&p->se);
 
 	this_eff_load += task_load;
 	if (sched_feat(WA_BIAS))
@@ -7600,7 +7600,7 @@ static int detach_tasks(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			goto next;
 
-		load = task_h_load(p);
+		load = task_se_h_load(&p->se);
 
 		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
 			goto next;
@@ -7833,12 +7833,12 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	}
 }
 
-static unsigned long task_h_load(struct task_struct *p)
+static unsigned long task_se_h_load(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = task_cfs_rq(p);
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	update_cfs_rq_h_load(cfs_rq);
-	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
+	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
 			cfs_rq_load_avg(cfs_rq) + 1);
 }
 #else
@@ -7865,9 +7865,9 @@ static inline void update_blocked_averages(int cpu)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-static unsigned long task_h_load(struct task_struct *p)
+static unsigned long task_se_h_load(struct sched_entity *se)
 {
-	return p->se.avg.load_avg;
+	return se->avg.load_avg;
 }
 #endif
 
-- 
2.20.1


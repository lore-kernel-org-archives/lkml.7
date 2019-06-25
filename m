Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D4C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A098205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AKP9wXz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfFYI3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:29:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:29:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8TJR73530445
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:29:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8TJR73530445
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451359;
        bh=wztTXxPY2E/t++kBl3uWCGfra7HrGxAl4nv80eYLt4E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AKP9wXz92KeOshD+FZC3ANzv0lEE5xHV3c1PRk2GboM7OSkmeuzlu18tTRHBGK92R
         z0/6YgHdCW5yML0NPEWc42YQerxJIobnQCUo9sEcq4Ohdy/l4D8gsG0aW7tEzIJqnj
         DwHVKqXnw0JkPNv5WOPHM3PORl+2seuIPfeCaHbPYWDm3x3Li59V75HQe8ulF7+Ycl
         k89Rrb7h4YA6i3XPhiLKqPxQz3XOefw41omTokusup1dgneD3Ode3skJec9rKFYN46
         CH82tC9ItY2kb44Rtmck2Tksx7O+6ZWAzhG4Lh0RtOuzEB0ESzQmCApYuxH5mPwqMB
         XOUEAI1BuglmQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8TIox3530442;
        Tue, 25 Jun 2019 01:29:18 -0700
Date:   Tue, 25 Jun 2019 01:29:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-a3df067974c52df936f548ed218120f623c4c560@git.kernel.org>
Cc:     tglx@linutronix.de, morten.rasmussen@arm.com, hpa@zytor.com,
        fweisbec@gmail.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        mingo@kernel.org, quentin.perret@arm.com, patrick.bellasi@arm.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        riel@surriel.com, vincent.guittot@linaro.org
Reply-To: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          vincent.guittot@linaro.org, riel@surriel.com,
          patrick.bellasi@arm.com, quentin.perret@arm.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          morten.rasmussen@arm.com, tglx@linutronix.de, fweisbec@gmail.com,
          hpa@zytor.com
In-Reply-To: <57f27a7f-2775-d832-e965-0f4d51bb1954@arm.com>
References: <57f27a7f-2775-d832-e965-0f4d51bb1954@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Rename weighted_cpuload() to
 cpu_runnable_load()
Git-Commit-ID: a3df067974c52df936f548ed218120f623c4c560
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

Commit-ID:  a3df067974c52df936f548ed218120f623c4c560
Gitweb:     https://git.kernel.org/tip/a3df067974c52df936f548ed218120f623c4c560
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Tue, 18 Jun 2019 14:23:10 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:43 +0200

sched/fair: Rename weighted_cpuload() to cpu_runnable_load()

The term 'weighted' is not needed since there is no 'unweighted' load.
Instead use the term 'runnable' to distinguish 'runnable' load
(avg.runnable_load_avg) used in load balance from load (avg.load_avg)
which is the sum of 'runnable' and 'blocked' load.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/57f27a7f-2775-d832-e965-0f4d51bb1954@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11ec52709323..3bdcd3c718bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1485,7 +1485,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
 }
 
-static unsigned long weighted_cpuload(struct rq *rq);
+static unsigned long cpu_runnable_load(struct rq *rq);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -1506,7 +1506,7 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
-		ns->load += weighted_cpuload(rq);
+		ns->load += cpu_runnable_load(rq);
 		ns->compute_capacity += capacity_of(cpu);
 	}
 
@@ -5366,7 +5366,7 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
-static unsigned long weighted_cpuload(struct rq *rq)
+static unsigned long cpu_runnable_load(struct rq *rq)
 {
 	return cfs_rq_runnable_load_avg(&rq->cfs);
 }
@@ -5380,7 +5380,7 @@ static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
-	unsigned long load_avg = weighted_cpuload(rq);
+	unsigned long load_avg = cpu_runnable_load(rq);
 
 	if (nr_running)
 		return load_avg / nr_running;
@@ -5478,7 +5478,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = weighted_cpuload(cpu_rq(this_cpu));
+	this_eff_load = cpu_runnable_load(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5496,7 +5496,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = weighted_cpuload(cpu_rq(prev_cpu));
+	prev_eff_load = cpu_runnable_load(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5584,7 +5584,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = weighted_cpuload(cpu_rq(i));
+			load = cpu_runnable_load(cpu_rq(i));
 			runnable_load += load;
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
@@ -5720,7 +5720,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				shallowest_idle_cpu = i;
 			}
 		} else if (shallowest_idle_cpu == -1) {
-			load = weighted_cpuload(cpu_rq(i));
+			load = cpu_runnable_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
 				least_loaded_cpu = i;
@@ -7291,7 +7291,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 static const unsigned int sched_nr_migrate_break = 32;
 
 /*
- * detach_tasks() -- tries to detach up to imbalance weighted load from
+ * detach_tasks() -- tries to detach up to imbalance runnable load from
  * busiest_rq, as part of a balancing operation within domain "sd".
  *
  * Returns number of detached tasks if successful and 0 otherwise.
@@ -7359,7 +7359,7 @@ static int detach_tasks(struct lb_env *env)
 
 		/*
 		 * We only want to steal up to the prescribed amount of
-		 * weighted load.
+		 * runnable load.
 		 */
 		if (env->imbalance <= 0)
 			break;
@@ -7969,7 +7969,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		sgs->group_load += weighted_cpuload(rq);
+		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
@@ -8427,7 +8427,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  * find_busiest_group - Returns the busiest group within the sched_domain
  * if there is an imbalance.
  *
- * Also calculates the amount of weighted load which should be moved
+ * Also calculates the amount of runnable load which should be moved
  * to restore balance.
  *
  * @env: The load balancing environment.
@@ -8546,7 +8546,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	int i;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
-		unsigned long capacity, wl;
+		unsigned long capacity, load;
 		enum fbq_type rt;
 
 		rq = cpu_rq(i);
@@ -8600,30 +8600,30 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    rq->nr_running == 1)
 			continue;
 
-		wl = weighted_cpuload(rq);
+		load = cpu_runnable_load(rq);
 
 		/*
-		 * When comparing with imbalance, use weighted_cpuload()
+		 * When comparing with imbalance, use cpu_runnable_load()
 		 * which is not scaled with the CPU capacity.
 		 */
 
-		if (rq->nr_running == 1 && wl > env->imbalance &&
+		if (rq->nr_running == 1 && load > env->imbalance &&
 		    !check_cpu_capacity(rq, env->sd))
 			continue;
 
 		/*
 		 * For the load comparisons with the other CPU's, consider
-		 * the weighted_cpuload() scaled with the CPU capacity, so
+		 * the cpu_runnable_load() scaled with the CPU capacity, so
 		 * that the load can be moved away from the CPU that is
 		 * potentially running at a lower capacity.
 		 *
-		 * Thus we're looking for max(wl_i / capacity_i), crosswise
+		 * Thus we're looking for max(load_i / capacity_i), crosswise
 		 * multiplication to rid ourselves of the division works out
-		 * to: wl_i * capacity_j > wl_j * capacity_i;  where j is
+		 * to: load_i * capacity_j > load_j * capacity_i;  where j is
 		 * our previous maximum.
 		 */
-		if (wl * busiest_capacity > busiest_load * capacity) {
-			busiest_load = wl;
+		if (load * busiest_capacity > busiest_load * capacity) {
+			busiest_load = load;
 			busiest_capacity = capacity;
 			busiest = rq;
 		}

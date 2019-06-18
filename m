Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45BFC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDC920873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfFRMXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:23:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfFRMXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7D2D2B;
        Tue, 18 Jun 2019 05:23:13 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00C83F246;
        Tue, 18 Jun 2019 05:23:11 -0700 (PDT)
Subject: Re: [PATCH 7/7] sched/fair: Rename weighted_cpuload() to cpu_load()
To:     Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
 <20190527062116.11512-8-dietmar.eggemann@arm.com>
 <686351aab73911569a7c22a7e104d1b9f0d579b9.camel@surriel.com>
 <20190527191320.GH2623@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <57f27a7f-2775-d832-e965-0f4d51bb1954@arm.com>
Date:   Tue, 18 Jun 2019 14:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190527191320.GH2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/19 9:13 PM, Peter Zijlstra wrote:
> On Mon, May 27, 2019 at 12:24:07PM -0400, Rik van Riel wrote:
>> On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
>>> This is done to align the per cpu (i.e. per rq) load with the util
>>> counterpart (cpu_util(int cpu)). The term 'weighted' is not needed
>>> since there is no 'unweighted' load to distinguish it from.
>>
>> I can see why you want to make cpu_util() and cpu_load()
>> have the same parameter, but ...
>>
>>> @@ -7931,7 +7928,7 @@ static inline void update_sg_lb_stats(struct
>>> lb_env *env,
>>>  		if ((env->flags & LBF_NOHZ_STATS) &&
>>> update_nohz_stats(rq, false))
>>>  			env->flags |= LBF_NOHZ_AGAIN;
>>>  
>>> -		sgs->group_load += weighted_cpuload(rq);
>>> +		sgs->group_load += cpu_load(i);
>>>  		sgs->group_util += cpu_util(i);
>>>  		sgs->sum_nr_running += rq->cfs.h_nr_running;
>>
>> ... now we end up dereferencing cpu_rq(cpu) 3 times.
>>
>> I guess per-cpu variables are so cheap that we should
>> never notice, but I thought I'd ask anyway while looking
>> over these patches :)
> 
> I was going to say CSE should fix that, but then I noticed per_cpu
> contains that hideous RELOC_HIDE() thing and I figure that might
> confuse GCC enough to break that :/

--->8---

From 25fcbbd9f654f243a70e38b0d59d38eb3c3f9313 Mon Sep 17 00:00:00 2001
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Mon, 13 May 2019 11:50:32 +0100
Subject: [PATCH] sched/fair: Rename weighted_cpuload() to cpu_runnable_load()

The term 'weighted' is not needed since there is no 'unweighted' load.
Instead use the term 'runnable' to distinguish 'runnable' load
(avg.runnable_load_avg) used in load balance from load (avg.load_avg)
which is the sum of 'runnable' and 'blocked' load.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

Related to the question whether replacing the 'struct rq *rq' parameter
with 'int cpu' (cpu_rq(cpu)) for cpu_runnable_load() has an influence
on the code:

RELOC_HIDE() (in per_cpu_ptr() -> SHIFT_PERCPU_PTR()) hinders the
compiler to generate similar code (e.g. in update_sg_lb_stats()).
When using 'int cpu' the addressing mode changed from Based Addressing
to Based_indexed-Scaled. Moreover, the text size of fair.o grows by 32
bytes.

 kernel/sched/fair.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c11dcdedcbc..0436f8eba556 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1466,7 +1466,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
 }
 
-static unsigned long weighted_cpuload(struct rq *rq);
+static unsigned long cpu_runnable_load(struct rq *rq);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -1487,7 +1487,7 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
-		ns->load += weighted_cpuload(rq);
+		ns->load += cpu_runnable_load(rq);
 		ns->compute_capacity += capacity_of(cpu);
 	}
 
@@ -5338,7 +5338,7 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
-static unsigned long weighted_cpuload(struct rq *rq)
+static unsigned long cpu_runnable_load(struct rq *rq)
 {
 	return cfs_rq_runnable_load_avg(&rq->cfs);
 }
@@ -5352,7 +5352,7 @@ static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long nr_running = READ_ONCE(rq->cfs.h_nr_running);
-	unsigned long load_avg = weighted_cpuload(rq);
+	unsigned long load_avg = cpu_runnable_load(rq);
 
 	if (nr_running)
 		return load_avg / nr_running;
@@ -5450,7 +5450,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = weighted_cpuload(cpu_rq(this_cpu));
+	this_eff_load = cpu_runnable_load(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5468,7 +5468,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = weighted_cpuload(cpu_rq(prev_cpu));
+	prev_eff_load = cpu_runnable_load(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5556,7 +5556,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = weighted_cpuload(cpu_rq(i));
+			load = cpu_runnable_load(cpu_rq(i));
 			runnable_load += load;
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
@@ -5692,7 +5692,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				shallowest_idle_cpu = i;
 			}
 		} else if (shallowest_idle_cpu == -1) {
-			load = weighted_cpuload(cpu_rq(i));
+			load = cpu_runnable_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
 				least_loaded_cpu = i;
@@ -7263,7 +7263,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 static const unsigned int sched_nr_migrate_break = 32;
 
 /*
- * detach_tasks() -- tries to detach up to imbalance weighted load from
+ * detach_tasks() -- tries to detach up to imbalance runnable load from
  * busiest_rq, as part of a balancing operation within domain "sd".
  *
  * Returns number of detached tasks if successful and 0 otherwise.
@@ -7331,7 +7331,7 @@ static int detach_tasks(struct lb_env *env)
 
 		/*
 		 * We only want to steal up to the prescribed amount of
-		 * weighted load.
+		 * runnable load.
 		 */
 		if (env->imbalance <= 0)
 			break;
@@ -7941,7 +7941,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		sgs->group_load += weighted_cpuload(rq);
+		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
@@ -8395,7 +8395,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  * find_busiest_group - Returns the busiest group within the sched_domain
  * if there is an imbalance.
  *
- * Also calculates the amount of weighted load which should be moved
+ * Also calculates the amount of runnable load which should be moved
  * to restore balance.
  *
  * @env: The load balancing environment.
@@ -8514,7 +8514,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	int i;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
-		unsigned long capacity, wl;
+		unsigned long capacity, load;
 		enum fbq_type rt;
 
 		rq = cpu_rq(i);
@@ -8568,30 +8568,30 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
-- 
2.17.1

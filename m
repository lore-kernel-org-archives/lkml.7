Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E05C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BEB2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLYKjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40645 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfLYKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44C-00088X-8D; Wed, 25 Dec 2019 11:39:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D4B1E1C2B24;
        Wed, 25 Dec 2019 11:38:59 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:38:59 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Make RT capacity-aware
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191009104611.15363-1-qais.yousef@arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <157727033975.30329.7470668057758283009.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     804d402fb6f6487b825aae8cf42fda6426c62867
Gitweb:        https://git.kernel.org/tip/804d402fb6f6487b825aae8cf42fda6426c62867
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Wed, 09 Oct 2019 11:46:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:10 +01:00

sched/rt: Make RT capacity-aware

Capacity Awareness refers to the fact that on heterogeneous systems
(like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
when placing tasks we need to be aware of this difference of CPU
capacities.

In such scenarios we want to ensure that the selected CPU has enough
capacity to meet the requirement of the running task. Enough capacity
means here that capacity_orig_of(cpu) >= task.requirement.

The definition of task.requirement is dependent on the scheduling class.

For CFS, utilization is used to select a CPU that has >= capacity value
than the cfs_task.util.

	capacity_orig_of(cpu) >= cfs_task.util

DL isn't capacity aware at the moment but can make use of the bandwidth
reservation to implement that in a similar manner CFS uses utilization.
The following patchset implements that:

https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/

	capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime

For RT we don't have a per task utilization signal and we lack any
information in general about what performance requirement the RT task
needs. But with the introduction of uclamp, RT tasks can now control
that by setting uclamp_min to guarantee a minimum performance point.

ATM the uclamp value are only used for frequency selection; but on
heterogeneous systems this is not enough and we need to ensure that the
capacity of the CPU is >= uclamp_min. Which is what implemented here.

	capacity_orig_of(cpu) >= rt_task.uclamp_min

Note that by default uclamp.min is 1024, which means that RT tasks will
always be biased towards the big CPUs, which make for a better more
predictable behavior for the default case.

Must stress that the bias acts as a hint rather than a definite
placement strategy. For example, if all big cores are busy executing
other RT tasks we can't guarantee that a new RT task will be placed
there.

On non-heterogeneous systems the original behavior of RT should be
retained. Similarly if uclamp is not selected in the config.

[ mingo: Minor edits to comments. ]

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191009104611.15363-1-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpupri.c | 25 +++++++++++--
 kernel/sched/cpupri.h |  4 +-
 kernel/sched/rt.c     | 83 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index b7abca9..1a2719e 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -46,6 +46,8 @@ static int convert_prio(int prio)
  * @cp: The cpupri context
  * @p: The task
  * @lowest_mask: A mask to fill in with selected CPUs (or NULL)
+ * @fitness_fn: A pointer to a function to do custom checks whether the CPU
+ *              fits a specific criteria so that we only return those CPUs.
  *
  * Note: This function returns the recommended CPUs as calculated during the
  * current invocation.  By the time the call returns, the CPUs may have in
@@ -57,7 +59,8 @@ static int convert_prio(int prio)
  * Return: (int)bool - CPUs were found
  */
 int cpupri_find(struct cpupri *cp, struct task_struct *p,
-		struct cpumask *lowest_mask)
+		struct cpumask *lowest_mask,
+		bool (*fitness_fn)(struct task_struct *p, int cpu))
 {
 	int idx = 0;
 	int task_pri = convert_prio(p->prio);
@@ -98,6 +101,8 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
 			continue;
 
 		if (lowest_mask) {
+			int cpu;
+
 			cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
 
 			/*
@@ -108,7 +113,23 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
 			 * condition, simply act as though we never hit this
 			 * priority level and continue on.
 			 */
-			if (cpumask_any(lowest_mask) >= nr_cpu_ids)
+			if (cpumask_empty(lowest_mask))
+				continue;
+
+			if (!fitness_fn)
+				return 1;
+
+			/* Ensure the capacity of the CPUs fit the task */
+			for_each_cpu(cpu, lowest_mask) {
+				if (!fitness_fn(p, cpu))
+					cpumask_clear_cpu(cpu, lowest_mask);
+			}
+
+			/*
+			 * If no CPU at the current priority can fit the task
+			 * continue looking
+			 */
+			if (cpumask_empty(lowest_mask))
 				continue;
 		}
 
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index 7dc20a3..32dd520 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -18,7 +18,9 @@ struct cpupri {
 };
 
 #ifdef CONFIG_SMP
-int  cpupri_find(struct cpupri *cp, struct task_struct *p, struct cpumask *lowest_mask);
+int  cpupri_find(struct cpupri *cp, struct task_struct *p,
+		 struct cpumask *lowest_mask,
+		 bool (*fitness_fn)(struct task_struct *p, int cpu));
 void cpupri_set(struct cpupri *cp, int cpu, int pri);
 int  cpupri_init(struct cpupri *cp);
 void cpupri_cleanup(struct cpupri *cp);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e591d40..4043abe 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -437,6 +437,45 @@ static inline int on_rt_rq(struct sched_rt_entity *rt_se)
 	return rt_se->on_rq;
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+/*
+ * Verify the fitness of task @p to run on @cpu taking into account the uclamp
+ * settings.
+ *
+ * This check is only important for heterogeneous systems where uclamp_min value
+ * is higher than the capacity of a @cpu. For non-heterogeneous system this
+ * function will always return true.
+ *
+ * The function will return true if the capacity of the @cpu is >= the
+ * uclamp_min and false otherwise.
+ *
+ * Note that uclamp_min will be clamped to uclamp_max if uclamp_min
+ * > uclamp_max.
+ */
+static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
+{
+	unsigned int min_cap;
+	unsigned int max_cap;
+	unsigned int cpu_cap;
+
+	/* Only heterogeneous systems can benefit from this check */
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return true;
+
+	min_cap = uclamp_eff_value(p, UCLAMP_MIN);
+	max_cap = uclamp_eff_value(p, UCLAMP_MAX);
+
+	cpu_cap = capacity_orig_of(cpu);
+
+	return cpu_cap >= min(min_cap, max_cap);
+}
+#else
+static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
+{
+	return true;
+}
+#endif
+
 #ifdef CONFIG_RT_GROUP_SCHED
 
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
@@ -1391,6 +1430,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
+	bool test;
 
 	/* For anything but wake ups, just return the task_cpu */
 	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
@@ -1422,10 +1462,16 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 *
 	 * This test is optimistic, if we get it wrong the load-balancer
 	 * will have to sort it out.
+	 *
+	 * We take into account the capacity of the CPU to ensure it fits the
+	 * requirement of the task - which is only important on heterogeneous
+	 * systems like big.LITTLE.
 	 */
-	if (curr && unlikely(rt_task(curr)) &&
-	    (curr->nr_cpus_allowed < 2 ||
-	     curr->prio <= p->prio)) {
+	test = curr &&
+	       unlikely(rt_task(curr)) &&
+	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+
+	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
 
 		/*
@@ -1449,15 +1495,15 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL, NULL))
 		return;
 
 	/*
 	 * p is migratable, so let's not schedule it and
 	 * see if it is pushed or pulled somewhere else.
 	 */
-	if (p->nr_cpus_allowed != 1
-	    && cpupri_find(&rq->rd->cpupri, p, NULL))
+	if (p->nr_cpus_allowed != 1 &&
+	    cpupri_find(&rq->rd->cpupri, p, NULL, NULL))
 		return;
 
 	/*
@@ -1601,7 +1647,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
+	    rt_task_fits_capacity(p, cpu))
 		return 1;
 
 	return 0;
@@ -1643,7 +1690,8 @@ static int find_lowest_rq(struct task_struct *task)
 	if (task->nr_cpus_allowed == 1)
 		return -1; /* No other targets possible */
 
-	if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask))
+	if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask,
+			 rt_task_fits_capacity))
 		return -1; /* No targets found */
 
 	/*
@@ -2147,12 +2195,14 @@ skip:
  */
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
-	if (!task_running(rq, p) &&
-	    !test_tsk_need_resched(rq->curr) &&
-	    p->nr_cpus_allowed > 1 &&
-	    (dl_task(rq->curr) || rt_task(rq->curr)) &&
-	    (rq->curr->nr_cpus_allowed < 2 ||
-	     rq->curr->prio <= p->prio))
+	bool need_to_push = !task_running(rq, p) &&
+			    !test_tsk_need_resched(rq->curr) &&
+			    p->nr_cpus_allowed > 1 &&
+			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
+			    (rq->curr->nr_cpus_allowed < 2 ||
+			     rq->curr->prio <= p->prio);
+
+	if (need_to_push || !rt_task_fits_capacity(p, cpu_of(rq)))
 		push_rt_tasks(rq);
 }
 
@@ -2224,7 +2274,10 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (task_on_rq_queued(p) && rq->curr != p) {
 #ifdef CONFIG_SMP
-		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
+		bool need_to_push = rq->rt.overloaded ||
+				    !rt_task_fits_capacity(p, cpu_of(rq));
+
+		if (p->nr_cpus_allowed > 1 && need_to_push)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
 		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))

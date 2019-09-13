Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD900C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E67420830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404157AbfIMWnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:43:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35706 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404064AbfIMWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:43:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i8uHm-0005iK-V8; Sat, 14 Sep 2019 00:43:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 15E871C0E22;
        Sat, 14 Sep 2019 00:43:26 +0200 (CEST)
Date:   Fri, 13 Sep 2019 22:43:25 -0000
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Speed-up energy-aware wake-ups
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, morten.rasmussen@arm.com,
        qais.yousef@arm.com, qperret@qperret.net, rjw@rjwysocki.net,
        tkjos@google.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190912094404.13802-1-qperret@qperret.net>
References: <20190912094404.13802-1-qperret@qperret.net>
MIME-Version: 1.0
Message-ID: <156841460590.24167.6583017884035348096.tip-bot2@tip-bot2>
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

Commit-ID:     eb92692b2544d3f415887dbbc98499843dfe568b
Gitweb:        https://git.kernel.org/tip/eb92692b2544d3f415887dbbc98499843dfe568b
Author:        Quentin Perret <quentin.perret@arm.com>
AuthorDate:    Thu, 12 Sep 2019 11:44:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Sep 2019 07:45:17 +02:00

sched/fair: Speed-up energy-aware wake-ups

EAS computes the energy impact of migrating a waking task when deciding
on which CPU it should run. However, the current approach is known to
have a high algorithmic complexity, which can result in prohibitively
high wake-up latencies on systems with complex energy models, such as
systems with per-CPU DVFS. On such systems, the algorithm complexity is
in O(n^2) (ignoring the cost of searching for performance states in the
EM) with 'n' the number of CPUs.

To address this, re-factor the EAS wake-up path to compute the energy
'delta' (with and without the task) on a per-performance domain basis,
rather than system-wide, which brings the complexity down to O(n).

No functional changes intended.

Test results
~~~~~~~~~~~~

* Setup: Tested on a Google Pixel 3, with a Snapdragon 845 (4+4 CPUs,
  A55/A75). Base kernel is 5.3-rc5 + Pixel3 specific patches. Android
  userspace, no graphics.

* Test case:  Run a periodic rt-app task, with 16ms period, ramping down
  from 70% to 10%, in 5% steps of 500 ms each (json avail. at [1]).
  Frequencies of all CPUs are pinned to max (using scaling_min_freq
  CPUFreq sysfs entries) to reduce variability. The time to run
  select_task_rq_fair() is measured using the function profiler
  (/sys/kernel/debug/tracing/trace_stat/function*). See the test script
  for more details [2].

Test 1:

I hacked the DT to 'fake' per-CPU DVFS. That is, we end up with one
CPUFreq policy per CPU (8 policies in total). Since all frequencies are
pinned to max for the test, this should have no impact on the actual
frequency selection, but it does in the EAS calculation.

      +---------------------------+----------------------------------+
      | Without patch             | With patch                       |
+-----+-----+----------+----------+-----+-----------------+----------+
| CPU | Hit | Avg (us) | s^2 (us) | Hit | Avg (us)        | s^2 (us) |
|-----+-----+----------+----------+-----+-----------------+----------+
|  0  | 274 | 38.303   | 1750.239 | 401 | 14.126 (-63.1%) | 146.625  |
|  1  | 197 | 49.529   | 1695.852 | 314 | 16.135 (-67.4%) | 167.525  |
|  2  | 142 | 34.296   | 1758.665 | 302 | 14.133 (-58.8%) | 130.071  |
|  3  | 172 | 31.734   | 1490.975 | 641 | 14.637 (-53.9%) | 139.189  |
|  4  | 316 | 7.834    | 178.217  | 425 | 5.413  (-30.9%) | 20.803   |
|  5  | 447 | 8.424    | 144.638  | 556 | 5.929  (-29.6%) | 27.301   |
|  6  | 581 | 14.886   | 346.793  | 456 | 5.711  (-61.6%) | 23.124   |
|  7  | 456 | 10.005   | 211.187  | 997 | 4.708  (-52.9%) | 21.144   |
+-----+-----+----------+----------+-----+-----------------+----------+
             * Hit, Avg and s^2 are as reported by the function profiler

Test 2:
I also ran the same test with a normal DT, with 2 CPUFreq policies, to
see if this causes regressions in the most common case.

      +---------------------------+----------------------------------+
      | Without patch             | With patch                       |
+-----+-----+----------+----------+-----+-----------------+----------+
| CPU | Hit | Avg (us) | s^2 (us) | Hit | Avg (us)        | s^2 (us) |
|-----+-----+----------+----------+-----+-----------------+----------+
|  0  | 345 | 22.184   | 215.321  | 580 | 18.635 (-16.0%) | 146.892  |
|  1  | 358 | 18.597   | 200.596  | 438 | 12.934 (-30.5%) | 104.604  |
|  2  | 359 | 25.566   | 200.217  | 397 | 10.826 (-57.7%) | 74.021   |
|  3  | 362 | 16.881   | 200.291  | 718 | 11.455 (-32.1%) | 102.280  |
|  4  | 457 | 3.822    | 9.895    | 757 | 4.616  (+20.8%) | 13.369   |
|  5  | 344 | 4.301    | 7.121    | 594 | 5.320  (+23.7%) | 18.798   |
|  6  | 472 | 4.326    | 7.849    | 464 | 5.648  (+30.6%) | 22.022   |
|  7  | 331 | 4.630    | 13.937   | 408 | 5.299  (+14.4%) | 18.273   |
+-----+-----+----------+----------+-----+-----------------+----------+
             * Hit, Avg and s^2 are as reported by the function profiler

In addition to these two tests, I also ran 50 iterations of the Lisa
EAS functional test suite [3] with this patch applied on Arm Juno r0,
Arm Juno r2, Arm TC2 and Hikey960, and could not see any regressions
(all EAS functional tests are passing).

 [1] https://paste.debian.net/1100055/
 [2] https://paste.debian.net/1100057/
 [3] https://github.com/ARM-software/lisa/blob/master/lisa/tests/scheduler/eas_behaviour.py

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: qais.yousef@arm.com
Cc: qperret@qperret.net
Cc: rjw@rjwysocki.net
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190912094404.13802-1-qperret@qperret.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 110 +++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 60 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1054d2c..8b66511 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6251,69 +6251,55 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 }
 
 /*
- * compute_energy(): Estimates the energy that would be consumed if @p was
+ * compute_energy(): Estimates the energy that @pd would consume if @p was
  * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
- * landscape of the * CPUs after the task migration, and uses the Energy Model
+ * landscape of @pd's CPUs after the task migration, and uses the Energy Model
  * to compute what would be the energy if we decided to actually migrate that
  * task.
  */
 static long
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
-	unsigned int max_util, util_cfs, cpu_util, cpu_cap;
-	unsigned long sum_util, energy = 0;
-	struct task_struct *tsk;
+	struct cpumask *pd_mask = perf_domain_span(pd);
+	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
+	unsigned long max_util = 0, sum_util = 0;
 	int cpu;
 
-	for (; pd; pd = pd->next) {
-		struct cpumask *pd_mask = perf_domain_span(pd);
+	/*
+	 * The capacity state of CPUs of the current rd can be driven by CPUs
+	 * of another rd if they belong to the same pd. So, account for the
+	 * utilization of these CPUs too by masking pd with cpu_online_mask
+	 * instead of the rd span.
+	 *
+	 * If an entire pd is outside of the current rd, it will not appear in
+	 * its pd list and will not be accounted by compute_energy().
+	 */
+	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+		unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
+		struct task_struct *tsk = cpu == dst_cpu ? p : NULL;
 
 		/*
-		 * The energy model mandates all the CPUs of a performance
-		 * domain have the same capacity.
+		 * Busy time computation: utilization clamping is not
+		 * required since the ratio (sum_util / cpu_capacity)
+		 * is already enough to scale the EM reported power
+		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
-		max_util = sum_util = 0;
+		sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+					       ENERGY_UTIL, NULL);
 
 		/*
-		 * The capacity state of CPUs of the current rd can be driven by
-		 * CPUs of another rd if they belong to the same performance
-		 * domain. So, account for the utilization of these CPUs too
-		 * by masking pd with cpu_online_mask instead of the rd span.
-		 *
-		 * If an entire performance domain is outside of the current rd,
-		 * it will not appear in its pd list and will not be accounted
-		 * by compute_energy().
+		 * Performance domain frequency: utilization clamping
+		 * must be considered since it affects the selection
+		 * of the performance domain frequency.
+		 * NOTE: in case RT tasks are running, by default the
+		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
-			util_cfs = cpu_util_next(cpu, p, dst_cpu);
-
-			/*
-			 * Busy time computation: utilization clamping is not
-			 * required since the ratio (sum_util / cpu_capacity)
-			 * is already enough to scale the EM reported power
-			 * consumption at the (eventually clamped) cpu_capacity.
-			 */
-			sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
-						       ENERGY_UTIL, NULL);
-
-			/*
-			 * Performance domain frequency: utilization clamping
-			 * must be considered since it affects the selection
-			 * of the performance domain frequency.
-			 * NOTE: in case RT tasks are running, by default the
-			 * FREQUENCY_UTIL's utilization can be max OPP.
-			 */
-			tsk = cpu == dst_cpu ? p : NULL;
-			cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
-						      FREQUENCY_UTIL, tsk);
-			max_util = max(max_util, cpu_util);
-		}
-
-		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
+		cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+					      FREQUENCY_UTIL, tsk);
+		max_util = max(max_util, cpu_util);
 	}
 
-	return energy;
+	return em_pd_energy(pd->em_pd, max_util, sum_util);
 }
 
 /*
@@ -6355,21 +6341,19 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  * other use-cases too. So, until someone finds a better way to solve this,
  * let's keep things simple by re-using the existing slow path.
  */
-
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
-	unsigned long prev_energy = ULONG_MAX, best_energy = ULONG_MAX;
+	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
+	unsigned long cpu_cap, util, base_energy = 0;
 	int cpu, best_energy_cpu = prev_cpu;
-	struct perf_domain *head, *pd;
-	unsigned long cpu_cap, util;
 	struct sched_domain *sd;
+	struct perf_domain *pd;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
 	if (!pd || READ_ONCE(rd->overutilized))
 		goto fail;
-	head = pd;
 
 	/*
 	 * Energy-aware wake-up happens on the lowest sched_domain starting
@@ -6386,9 +6370,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		goto unlock;
 
 	for (; pd; pd = pd->next) {
-		unsigned long cur_energy, spare_cap, max_spare_cap = 0;
+		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
+		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
+		/* Compute the 'base' energy of the pd, without @p */
+		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy += base_energy_pd;
+
 		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
@@ -6401,9 +6390,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 			/* Always use prev_cpu as a candidate. */
 			if (cpu == prev_cpu) {
-				prev_energy = compute_energy(p, prev_cpu, head);
-				best_energy = min(best_energy, prev_energy);
-				continue;
+				prev_delta = compute_energy(p, prev_cpu, pd);
+				prev_delta -= base_energy_pd;
+				best_delta = min(best_delta, prev_delta);
 			}
 
 			/*
@@ -6419,9 +6408,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using this CPU. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_energy = compute_energy(p, max_spare_cap_cpu, head);
-			if (cur_energy < best_energy) {
-				best_energy = cur_energy;
+			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			cur_delta -= base_energy_pd;
+			if (cur_delta < best_delta) {
+				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
 			}
 		}
@@ -6433,10 +6423,10 @@ unlock:
 	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
 	 * least 6% of the energy used by prev_cpu.
 	 */
-	if (prev_energy == ULONG_MAX)
+	if (prev_delta == ULONG_MAX)
 		return best_energy_cpu;
 
-	if ((prev_energy - best_energy) > (prev_energy >> 4))
+	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
 		return best_energy_cpu;
 
 	return prev_cpu;

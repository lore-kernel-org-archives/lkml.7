Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B05C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BAE2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLYKjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40624 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfLYKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44G-0008Ac-Nm; Wed, 25 Dec 2019 11:39:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4FFA41C2BA3;
        Wed, 25 Dec 2019 11:39:01 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:39:01 -0000
From:   "tip-bot2 for Viresh Kumar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make sched-idle CPU selection
 consistent throughout
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cb90cbcce608cef4e02a7bbfe178335f76d201bab=2E15737?=
 =?utf-8?q?28344=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3Cb90cbcce608cef4e02a7bbfe178335f76d201bab=2E157372?=
 =?utf-8?q?8344=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <157727034115.30329.920144434327367815.tip-bot2@tip-bot2>
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

Commit-ID:     17346452b25b98acfb395d2a82ec2e4ad0cb7a01
Gitweb:        https://git.kernel.org/tip/17346452b25b98acfb395d2a82ec2e4ad0cb7a01
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Thu, 14 Nov 2019 16:19:27 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:07 +01:00

sched/fair: Make sched-idle CPU selection consistent throughout

There are instances where we keep searching for an idle CPU despite
already having a sched-idle CPU (in find_idlest_group_cpu(),
select_idle_smt() and select_idle_cpu() and then there are places where
we don't necessarily do that and return a sched-idle CPU as soon as we
find one (in select_idle_sibling()). This looks a bit inconsistent and
it may be worth having the same policy everywhere.

On the other hand, choosing a sched-idle CPU over a idle one shall be
beneficial from performance and power point of view as well, as we don't
need to get the CPU online from a deep idle state which wastes quite a
lot of time and energy and delays the scheduling of the newly woken up
task.

This patch tries to simplify code around sched-idle CPU selection and
make it consistent throughout.

Testing is done with the help of rt-app on hikey board (ARM64 octa-core,
2 clusters, 0-3 and 4-7). The cpufreq governor was set to performance to
avoid any side affects from CPU frequency. Following are the tests
performed:

Test 1: 1-cfs-task:

 A single SCHED_NORMAL task is pinned to CPU5 which runs for 2333 us
 out of 7777 us (so gives time for the cluster to go in deep idle
 state).

Test 2: 1-cfs-1-idle-task:

 A single SCHED_NORMAL task is pinned on CPU5 and single SCHED_IDLE
 task is pinned on CPU6 (to make sure cluster 1 doesn't go in deep idle
 state).

Test 3: 1-cfs-8-idle-task:

 A single SCHED_NORMAL task is pinned on CPU5 and eight SCHED_IDLE
 tasks are created which run forever (not pinned anywhere, so they run
 on all CPUs). Checked with kernelshark that as soon as NORMAL task
 sleeps, the SCHED_IDLE task starts running on CPU5.

And here are the results on mean latency (in us), using the "st" tool.

  $ st 1-cfs-task/rt-app-cfs_thread-0.log
  N       min     max     sum     mean    stddev
  642     90      592     197180  307.134 109.906

  $ st 1-cfs-1-idle-task/rt-app-cfs_thread-0.log
  N       min     max     sum     mean    stddev
  642     67      311     113850  177.336 41.4251

  $ st 1-cfs-8-idle-task/rt-app-cfs_thread-0.log
  N       min     max     sum     mean    stddev
  643     29      173     41364   64.3297 13.2344

The mean latency when we need to:

 - wakeup from deep idle state is 307 us.
 - wakeup from shallow idle state is 177 us.
 - preempt a SCHED_IDLE task is 64 us.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/b90cbcce608cef4e02a7bbfe178335f76d201bab.1573728344.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8da0222..1f34fa9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5588,7 +5588,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
-	int shallowest_idle_cpu = -1, si_cpu = -1;
+	int shallowest_idle_cpu = -1;
 	int i;
 
 	/* Check if we have any choice: */
@@ -5597,6 +5597,9 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		if (sched_idle_cpu(i))
+			return i;
+
 		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
@@ -5619,12 +5622,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			}
-		} else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
-			if (sched_idle_cpu(i)) {
-				si_cpu = i;
-				continue;
-			}
-
+		} else if (shallowest_idle_cpu == -1) {
 			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
@@ -5633,11 +5631,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		}
 	}
 
-	if (shallowest_idle_cpu != -1)
-		return shallowest_idle_cpu;
-	if (si_cpu != -1)
-		return si_cpu;
-	return least_loaded_cpu;
+	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
 }
 
 static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
@@ -5790,7 +5784,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int 
  */
 static int select_idle_smt(struct task_struct *p, int target)
 {
-	int cpu, si_cpu = -1;
+	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -5798,13 +5792,11 @@ static int select_idle_smt(struct task_struct *p, int target)
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
-		if (available_idle_cpu(cpu))
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
-		if (si_cpu == -1 && sched_idle_cpu(cpu))
-			si_cpu = cpu;
 	}
 
-	return si_cpu;
+	return -1;
 }
 
 #else /* CONFIG_SCHED_SMT */
@@ -5834,7 +5826,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 time, cost;
 	s64 delta;
 	int this = smp_processor_id();
-	int cpu, nr = INT_MAX, si_cpu = -1;
+	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -5864,11 +5856,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
-			return si_cpu;
-		if (available_idle_cpu(cpu))
+			return -1;
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			break;
-		if (si_cpu == -1 && sched_idle_cpu(cpu))
-			si_cpu = cpu;
 	}
 
 	time = cpu_clock(this) - time;

Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8674C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C2122BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="t0H8ByBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbfGYQQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:16:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390045AbfGYQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:16:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGG3cD1075138
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:16:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGG3cD1075138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071364;
        bh=WDeeX8BvGqaCTB/0Sgu9Omxb4koUAUlpjeF0FBdEe4U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=t0H8ByBg3JW8l0LFYU/T2sWghQwLehNsZ3ylbDwaWUa/sy365KEdpNAsSkQev9nRI
         Ef/5DzPP9KrznpiF60riA4SXNKn+lk8U9Sr2NX9M0+jUd25iT9eaEsVjL1mYERDCGj
         CMuHQN/hZF50mq95e4e6ioeb218oNyHoFxP/P+9sJrqufhlsnxt0Qlly33fVmgQUyS
         9Nx5f0G8epEYHRWsINP7xlgGpEiTQKwIRZlV+F/uKHMTIfGcutuevUi92hElsTJRl3
         ipGFtXUFXZaR7gdkqVvUbE+cU8f0IeX68hfjsTJzPZJfMSfuUgf2qcGbjgS7HdPiOA
         kneaRV3LddPSw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGG3RB1075134;
        Thu, 25 Jul 2019 09:16:03 -0700
Date:   Thu, 25 Jul 2019 09:16:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-3c29e651e16dd3b3179cfb2d055ee9538e37515c@git.kernel.org>
Cc:     tglx@linutronix.de, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        hpa@zytor.com, peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, daniel.lezcano@linaro.org,
          linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
          hpa@zytor.com, vincent.guittot@linaro.org, peterz@infradead.org,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
References: <eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fall back to sched-idle CPU if idle
 CPU isn't found
Git-Commit-ID: 3c29e651e16dd3b3179cfb2d055ee9538e37515c
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

Commit-ID:  3c29e651e16dd3b3179cfb2d055ee9538e37515c
Gitweb:     https://git.kernel.org/tip/3c29e651e16dd3b3179cfb2d055ee9538e37515c
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Wed, 26 Jun 2019 10:36:30 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:54 +0200

sched/fair: Fall back to sched-idle CPU if idle CPU isn't found

We try to find an idle CPU to run the next task, but in case we don't
find an idle CPU it is better to pick a CPU which will run the task the
soonest, for performance reason.

A CPU which isn't idle but has only SCHED_IDLE activity queued on it
should be a good target based on this criteria as any normal fair task
will most likely preempt the currently running SCHED_IDLE task
immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
shall give better results as it should be able to run the task sooner
than an idle CPU (which requires to be woken up from an idle state).

This patch updates both fast and slow paths with this optimization.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chris.redpath@arm.com
Cc: quentin.perret@linaro.org
Cc: songliubraving@fb.com
Cc: steven.sistare@oracle.com
Cc: subhra.mazumdar@oracle.com
Cc: tkjos@google.com
Link: https://lkml.kernel.org/r/eeafa25fdeb6f6edd5b2da716bc8f0ba7708cbcf.1561523542.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ed5ab53872f..52564e050062 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5431,6 +5431,15 @@ static struct {
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
+/* CPU only has SCHED_IDLE tasks enqueued */
+static int sched_idle_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
+			rq->nr_running);
+}
+
 static unsigned long cpu_runnable_load(struct rq *rq)
 {
 	return cfs_rq_runnable_load_avg(&rq->cfs);
@@ -5753,7 +5762,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
-	int shallowest_idle_cpu = -1;
+	int shallowest_idle_cpu = -1, si_cpu = -1;
 	int i;
 
 	/* Check if we have any choice: */
@@ -5784,7 +5793,12 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			}
-		} else if (shallowest_idle_cpu == -1) {
+		} else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
+			if (sched_idle_cpu(i)) {
+				si_cpu = i;
+				continue;
+			}
+
 			load = cpu_runnable_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
@@ -5793,7 +5807,11 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 		}
 	}
 
-	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
+	if (shallowest_idle_cpu != -1)
+		return shallowest_idle_cpu;
+	if (si_cpu != -1)
+		return si_cpu;
+	return least_loaded_cpu;
 }
 
 static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
@@ -5946,7 +5964,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
  */
 static int select_idle_smt(struct task_struct *p, int target)
 {
-	int cpu;
+	int cpu, si_cpu = -1;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -5956,9 +5974,11 @@ static int select_idle_smt(struct task_struct *p, int target)
 			continue;
 		if (available_idle_cpu(cpu))
 			return cpu;
+		if (si_cpu == -1 && sched_idle_cpu(cpu))
+			si_cpu = cpu;
 	}
 
-	return -1;
+	return si_cpu;
 }
 
 #else /* CONFIG_SCHED_SMT */
@@ -5986,8 +6006,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
 	int this = smp_processor_id();
+	int cpu, nr = INT_MAX, si_cpu = -1;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6015,11 +6035,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
 		if (!--nr)
-			return -1;
+			return si_cpu;
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
 		if (available_idle_cpu(cpu))
 			break;
+		if (si_cpu == -1 && sched_idle_cpu(cpu))
+			si_cpu = cpu;
 	}
 
 	time = cpu_clock(this) - time;
@@ -6038,13 +6060,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
-	if (available_idle_cpu(target))
+	if (available_idle_cpu(target) || sched_idle_cpu(target))
 		return target;
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) && available_idle_cpu(prev))
+	if (prev != target && cpus_share_cache(prev, target) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
 		return prev;
 
 	/* Check a recently used CPU as a potential idle candidate: */
@@ -6052,7 +6075,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    available_idle_cpu(recent_used_cpu) &&
+	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential

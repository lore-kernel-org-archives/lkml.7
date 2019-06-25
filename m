Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF9C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016C0204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R0nW3DNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfFYIhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:37:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfFYIhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:37:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8bCeW3532160
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:37:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8bCeW3532160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451833;
        bh=9OWmNZrsFeUsUQTMAeP1yRrYsAinw7/4KeT7uBB6goQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=R0nW3DNIesVxaFzGv15cO5ovmD8N2GKrCJCC2Sm1gM/vgCe7rs2/HQ3MKtRR1Kjtp
         4cvvbSSNRzbykzt2vmXWmpTg9TO/rP0BJbSZL2v6np764F91Upv82i0vY+1jiuO+JL
         qc+u5jQ+dxszaoHOAltA+SarukXqOPoocp3sWbx9UbSJ315ZT0huarCdVUWHRHB/ai
         0ALDT/FauQ05UJWU2DYs2xq+McLZjB+zSzcx5TAxQE3Ek3HSNRjRD05By95y0a48mV
         INcNo0Mh/P9/rGrz4n43R2yvs8mw5lddGQ2+NJtLssOaR134owATypZ3UaN3YrExkw
         ZGmWTOrAFcisg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8bBQm3532157;
        Tue, 25 Jun 2019 01:37:11 -0700
Date:   Tue, 25 Jun 2019 01:37:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-af24bde8df2029f067dc46aff0393c8f18ff6e2f@git.kernel.org>
Cc:     vincent.guittot@linaro.org, joelaf@google.com,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        juri.lelli@redhat.com, mingo@kernel.org, balsini@android.com,
        tj@kernel.org, linux-kernel@vger.kernel.org, smuckle@google.com,
        hpa@zytor.com, morten.rasmussen@arm.com, surenb@google.com,
        quentin.perret@arm.com, pjt@google.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, tkjos@google.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        viresh.kumar@linaro.org
Reply-To: rafael.j.wysocki@intel.com, tglx@linutronix.de,
          juri.lelli@redhat.com, mingo@kernel.org, balsini@android.com,
          tj@kernel.org, vincent.guittot@linaro.org, joelaf@google.com,
          surenb@google.com, quentin.perret@arm.com,
          dietmar.eggemann@arm.com, pjt@google.com, smuckle@google.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          morten.rasmussen@arm.com, patrick.bellasi@arm.com,
          tkjos@google.com, torvalds@linux-foundation.org,
          peterz@infradead.org, viresh.kumar@linaro.org
In-Reply-To: <20190621084217.8167-12-patrick.bellasi@arm.com>
References: <20190621084217.8167-12-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Add uclamp support to
 energy_compute()
Git-Commit-ID: af24bde8df2029f067dc46aff0393c8f18ff6e2f
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

Commit-ID:  af24bde8df2029f067dc46aff0393c8f18ff6e2f
Gitweb:     https://git.kernel.org/tip/af24bde8df2029f067dc46aff0393c8f18ff6e2f
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:12 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:49 +0200

sched/uclamp: Add uclamp support to energy_compute()

The Energy Aware Scheduler (EAS) estimates the energy impact of waking
up a task on a given CPU. This estimation is based on:

 a) an (active) power consumption defined for each CPU frequency
 b) an estimation of which frequency will be used on each CPU
 c) an estimation of the busy time (utilization) of each CPU

Utilization clamping can affect both b) and c).

A CPU is expected to run:

 - on an higher than required frequency, but for a shorter time, in case
   its estimated utilization will be smaller than the minimum utilization
   enforced by uclamp
 - on a smaller than required frequency, but for a longer time, in case
   its estimated utilization is bigger than the maximum utilization
   enforced by uclamp

While compute_energy() already accounts clamping effects on busy time,
the clamping effects on frequency selection are currently ignored.

Fix it by considering how CPU clamp values will be affected by a
task waking up and being RUNNABLE on that CPU.

Do that by refactoring schedutil_freq_util() to take an additional
task_struct* which allows EAS to evaluate the impact on clamp values of
a task being eventually queued in a CPU. Clamp values are applied to the
RT+CFS utilization only when a FREQUENCY_UTIL is required by
compute_energy().

Do note that switching from ENERGY_UTIL to FREQUENCY_UTIL in the
computation of the cpu_util signal implies that we are more likely to
estimate the highest OPP when a RT task is running in another CPU of
the same performance domain. This can have an impact on energy
estimation but:

 - it's not easy to say which approach is better, since it depends on
   the use case
 - the original approach could still be obtained by setting a smaller
   task-specific util_min whenever required

Since we are at that:

 - rename schedutil_freq_util() into schedutil_cpu_util(),
   since it's not only used for frequency selection.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alessio Balsini <balsini@android.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190621084217.8167-12-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c |  9 +++++----
 kernel/sched/fair.c              | 40 ++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h             | 21 +++++++++------------
 3 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d84e036a7536..636ca6f88c8e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -196,8 +196,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-				  unsigned long max, enum schedutil_type type)
+unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum schedutil_type type,
+				 struct task_struct *p)
 {
 	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
@@ -230,7 +231,7 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	 */
 	util = util_cfs + cpu_util_rt(rq);
 	if (type == FREQUENCY_UTIL)
-		util = uclamp_util(rq, util);
+		util = uclamp_util_with(rq, util, p);
 
 	dl_util = cpu_util_dl(rq);
 
@@ -290,7 +291,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	return schedutil_freq_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL);
+	return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
 }
 
 /**
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28db7ce5c3a6..b798fe7ff7cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6231,11 +6231,21 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 static long
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
-	long util, max_util, sum_util, energy = 0;
+	unsigned int max_util, util_cfs, cpu_util, cpu_cap;
+	unsigned long sum_util, energy = 0;
+	struct task_struct *tsk;
 	int cpu;
 
 	for (; pd; pd = pd->next) {
+		struct cpumask *pd_mask = perf_domain_span(pd);
+
+		/*
+		 * The energy model mandates all the CPUs of a performance
+		 * domain have the same capacity.
+		 */
+		cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
 		max_util = sum_util = 0;
+
 		/*
 		 * The capacity state of CPUs of the current rd can be driven by
 		 * CPUs of another rd if they belong to the same performance
@@ -6246,11 +6256,29 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * it will not appear in its pd list and will not be accounted
 		 * by compute_energy().
 		 */
-		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
-			util = cpu_util_next(cpu, p, dst_cpu);
-			util = schedutil_energy_util(cpu, util);
-			max_util = max(util, max_util);
-			sum_util += util;
+		for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+			util_cfs = cpu_util_next(cpu, p, dst_cpu);
+
+			/*
+			 * Busy time computation: utilization clamping is not
+			 * required since the ratio (sum_util / cpu_capacity)
+			 * is already enough to scale the EM reported power
+			 * consumption at the (eventually clamped) cpu_capacity.
+			 */
+			sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+						       ENERGY_UTIL, NULL);
+
+			/*
+			 * Performance domain frequency: utilization clamping
+			 * must be considered since it affects the selection
+			 * of the performance domain frequency.
+			 * NOTE: in case RT tasks are running, by default the
+			 * FREQUENCY_UTIL's utilization can be max OPP.
+			 */
+			tsk = cpu == dst_cpu ? p : NULL;
+			cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+						      FREQUENCY_UTIL, tsk);
+			max_util = max(max_util, cpu_util);
 		}
 
 		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1783f6b4c2e0..802b1f3405f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2322,7 +2322,6 @@ static inline unsigned long capacity_orig_of(int cpu)
 }
 #endif
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 /**
  * enum schedutil_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
@@ -2338,15 +2337,11 @@ enum schedutil_type {
 	ENERGY_UTIL,
 };
 
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-				  unsigned long max, enum schedutil_type type);
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 
-static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
-{
-	unsigned long max = arch_scale_cpu_capacity(cpu);
-
-	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
-}
+unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum schedutil_type type,
+				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
@@ -2375,11 +2370,13 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
 #else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
+static inline unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum schedutil_type type,
+				 struct task_struct *p)
 {
-	return cfs;
+	return 0;
 }
-#endif
+#endif /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)

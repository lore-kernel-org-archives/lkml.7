Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC55C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387C2206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnNFrw9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:49:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36931 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:49:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so3537188pgu.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WLUvG+xBquRbDbfYUrQqVG4OAZBybXDHZbDNbjPzH0=;
        b=fnNFrw9xMEm1srXbGCBxFwySimQqZh7tf3owcLyW3R6MxImMXZC/vFS5p55Vyq0X75
         TLAVAJDK3sOZ6HTfoaenLI3DUFUyg3bORuLzdionUVOsbaHhl86jETeGZeKnlLoXclza
         tyGIEJ67fwFvqNtoOpCDWXqBxYougkYaNQXHaJ7OT1guOQBe70w/YAQBETE8ayj6W0Hr
         nX6sJJ6P1CuEVigP3lh1SQjGE/Q2XZ1XU2BrWnMaFNHxH1/Mde8PrMB0LdkGJblzXgZu
         dHrO+nrezb7A4QVbvX0br5ia7/2fZ8y1WOpexm1eED9W5RZ4KhqQL4/0yxiBxIytuhPb
         IStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WLUvG+xBquRbDbfYUrQqVG4OAZBybXDHZbDNbjPzH0=;
        b=AX41TlO1WaEXmDGndC2GwR91vikrqeqFpuSNZtLSSfU9TGnYydI1+VbdG4IP2nkMlQ
         l5C8NopVBZHdKHW+cNh+vYj6Y7g0lNGbqejSnXBcWAUv5LlqOHlRV7UzWRA+/YmE8c/C
         UAr6H8TlxJw/w11Cln5rquUKkQE9xL6hxDJAST3bYSkQAXixzL0ADEg2E6qlNff08eon
         xoxA8evewksb6uoRMS3Fp0TL5cOuPXLEzeqtXKl8Xk8FVaSBc2Y4gyU8dw0Oj73Jhoae
         RGKkZPPX7+SQqvjqT9C8HKirpAQQXLlIJnAnz9ZN6ef3nDq/Qb2mPb2akt37o5fmVpk0
         QMcQ==
X-Gm-Message-State: APjAAAU7j0z+9k1LPgvnCdTWyTvEn2htkot35biCgin5RdqpxGzkiYCn
        NHXzwZU7bYtmR3MYLV+gAQhUHw==
X-Google-Smtp-Source: APXvYqxKcoZRjfAJmrYepooFU1l7wf4k6AdFFhjFcD2K436DA7XWNbW8YIn4zny+IgQDtgP0DmIfNw==
X-Received: by 2002:a63:6744:: with SMTP id b65mr9343331pgc.13.1573728575398;
        Thu, 14 Nov 2019 02:49:35 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id p7sm5733328pfn.14.2019.11.14.02.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 02:49:34 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, Parth Shah <parth@linux.ibm.com>
Subject: [PATCH V2] sched/fair: Make sched-idle CPU selection consistent throughout
Date:   Thu, 14 Nov 2019 16:19:27 +0530
Message-Id: <b90cbcce608cef4e02a7bbfe178335f76d201bab.1573728344.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
V1->V2:
- Updated commit log with the numbers received from rt-app tests.

 kernel/sched/fair.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a81c36472822..bb367f48c1ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5545,7 +5545,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
-	int shallowest_idle_cpu = -1, si_cpu = -1;
+	int shallowest_idle_cpu = -1;
 	int i;
 
 	/* Check if we have any choice: */
@@ -5554,6 +5554,9 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		if (sched_idle_cpu(i))
+			return i;
+
 		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
@@ -5576,12 +5579,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
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
@@ -5590,11 +5588,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
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
@@ -5747,7 +5741,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
  */
 static int select_idle_smt(struct task_struct *p, int target)
 {
-	int cpu, si_cpu = -1;
+	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
 		return -1;
@@ -5755,13 +5749,11 @@ static int select_idle_smt(struct task_struct *p, int target)
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
@@ -5790,7 +5782,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 time, cost;
 	s64 delta;
 	int this = smp_processor_id();
-	int cpu, nr = INT_MAX, si_cpu = -1;
+	int cpu, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -5818,13 +5810,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
 		if (!--nr)
-			return si_cpu;
+			return -1;
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
-		if (available_idle_cpu(cpu))
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			break;
-		if (si_cpu == -1 && sched_idle_cpu(cpu))
-			si_cpu = cpu;
 	}
 
 	time = cpu_clock(this) - time;
-- 
2.21.0.rc0.269.g1a574e7a288b


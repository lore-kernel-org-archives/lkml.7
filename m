Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF52A20878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfKTR5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:57:37 -0500
Received: from foss.arm.com ([217.140.110.172]:44010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfKTR5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:57:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386251FB;
        Wed, 20 Nov 2019 09:57:35 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE26D3F6C4;
        Wed, 20 Nov 2019 09:57:33 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity" checks
Date:   Wed, 20 Nov 2019 17:55:33 +0000
Message-Id: <20191120175533.4672-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191120175533.4672-1-valentin.schneider@arm.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_fits_capacity() drives CPU selection at wakeup time, and is also used
to detect misfit tasks. Right now it does so by comparing task_util_est()
with a CPU's capacity, but doesn't take into account uclamp restrictions.

There's a few interesting uses that can come out of doing this. For
instance, a low uclamp.max value could prevent certain tasks from being
flagged as misfit tasks, so they could merrily remain on low-capacity CPUs.
Similarly, a high uclamp.min value would steer tasks towards high capacity
CPU at wakeup (and, should that fail, later steered via misfit balancing),
so such "boosted" tasks would favor CPUs of higher capacity.

Introduce uclamp_task_util() and make task_fits_capacity() use it. To keep
things consistent between overutilized wakeup CPU selection (wake_cap())
and !overutilized wakeup CPU selection (find_energy_efficient_cpu()),
add a task_fits_capacity() check to find_energy_efficient_cpu().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c  | 11 ++++++++++-
 kernel/sched/sched.h | 13 +++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..446409252b23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3822,7 +3822,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 
 static inline int task_fits_capacity(struct task_struct *p, long capacity)
 {
-	return fits_capacity(task_util_est(p), capacity);
+	return fits_capacity(uclamp_task_util(p, task_util_est(p)), capacity);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6274,6 +6274,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!fits_capacity(util, cpu_cap))
 				continue;
 
+			/*
+			 * Skip CPUs that don't satisfy uclamp requests. Note
+			 * that the above already ensures the CPU has enough
+			 * spare capacity for the task; this is only really for
+			 * uclamp restrictions.
+			 */
+			if (!task_fits_capacity(p, capacity_orig_of(cpu)))
+				continue;
+
 			/* Always use prev_cpu as a candidate. */
 			if (cpu == prev_cpu) {
 				prev_delta = compute_energy(p, prev_cpu, pd);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 900328c4eeef..74bf08ec1a01 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2329,6 +2329,14 @@ static inline unsigned long uclamp_rq_util(struct rq *rq, unsigned long util)
 {
 	return uclamp_rq_util_with(rq, util, NULL);
 }
+
+static inline
+unsigned long uclamp_task_util(struct task_struct *p, unsigned long util)
+{
+	return clamp(util,
+		     (unsigned long)uclamp_eff_value(p, UCLAMP_MIN),
+		     (unsigned long)uclamp_eff_value(p, UCLAMP_MAX));
+}
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 						struct task_struct *p)
@@ -2339,6 +2347,11 @@ static inline unsigned long uclamp_rq_util(struct rq *rq, unsigned long util)
 {
 	return util;
 }
+static inline
+unsigned long uclamp_task_util(struct task_struct *p, unsigned long util)
+{
+	return util;
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef arch_scale_freq_capacity
-- 
2.22.0


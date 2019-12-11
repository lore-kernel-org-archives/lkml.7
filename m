Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A89C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61F12073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfLKLj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:39:28 -0500
Received: from foss.arm.com ([217.140.110.172]:55028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbfLKLjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:39:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8ABD1FB;
        Wed, 11 Dec 2019 03:39:19 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A01A3F6CF;
        Wed, 11 Dec 2019 03:39:18 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v3 4/5] sched/fair: Make task_fits_capacity() consider uclamp restrictions
Date:   Wed, 11 Dec 2019 11:38:50 +0000
Message-Id: <20191211113851.24241-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211113851.24241-1-valentin.schneider@arm.com>
References: <20191211113851.24241-1-valentin.schneider@arm.com>
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
CPUs at wakeup (and, should that fail, later steered via misfit balancing),
so such "boosted" tasks would favor CPUs of higher capacity.

Introduce uclamp_task_util() and make task_fits_capacity() use it.

Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..a9c93c5427bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3711,6 +3711,20 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline unsigned long uclamp_task_util(struct task_struct *p)
+{
+	return clamp(task_util_est(p),
+		     uclamp_eff_value(p, UCLAMP_MIN),
+		     uclamp_eff_value(p, UCLAMP_MAX));
+}
+#else
+static inline unsigned long uclamp_task_util(struct task_struct *p)
+{
+	return task_util_est(p);
+}
+#endif
+
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -3822,7 +3836,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 
 static inline int task_fits_capacity(struct task_struct *p, long capacity)
 {
-	return fits_capacity(task_util_est(p), capacity);
+	return fits_capacity(uclamp_task_util(p), capacity);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
-- 
2.24.0


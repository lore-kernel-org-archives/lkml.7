Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E2DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D902084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfFTPGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:06:05 -0400
Received: from foss.arm.com ([217.140.110.172]:43370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfFTPGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:06:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 553EF28;
        Thu, 20 Jun 2019 08:06:04 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BECFE3F718;
        Thu, 20 Jun 2019 08:06:02 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
Date:   Thu, 20 Jun 2019 16:05:55 +0100
Message-Id: <20190620150555.15717-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The estimated utilization for a task is currently defined based on:
 - enqueued: the utilization value at the end of the last activation
 - ewma:     an exponential moving average which samples are the enqueued values

According to this definition, when a task suddenly change it's bandwidth
requirements from small to big, the EWMA will need to collect multiple
samples before converging up to track the new big utilization.

Moreover, after the PELT scale invariance update [1], in the above scenario we
can see that the utilization of the task has a significant drop from the first
big activation to the following one. That's implied by the new "time-scaling"
mechanisms instead of the previous "delta-scaling" approach.

Unfortunately, these drops cannot be fully absorbed by the current util_est
implementation. Indeed, the low-frequency filtering introduced by the "ewma" is
entirely useless while converging up and it does not help in stabilizing sooner
the PELT signal.

To make util_est do better service in the above scenario, do change its
definition to slow down only utilization decreases. Do that by resetting the
"ewma" every time the last collected sample increases.

This change makes also the default util_est implementation more aligned with
the major scheduler behavior, which is to optimize for performance.
In the future, this implementation can be further refined to consider
task specific hints.

[1] sched/fair: Update scale invariance of PELT
    Message-ID: <tip-23127296889fe84b0762b191b5d041e8ba6f2599@git.kernel.org>

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/fair.c     | 14 +++++++++++++-
 kernel/sched/features.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c11dcdedcbc..27b33caaaaf4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3685,11 +3685,22 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	if (ue.enqueued & UTIL_AVG_UNCHANGED)
 		return;
 
+	/*
+	 * Reset EWMA on utilization increases, the moving average is used only
+	 * to smooth utilization decreases.
+	 */
+	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
+	if (sched_feat(UTIL_EST_FASTUP)) {
+		if (ue.ewma < ue.enqueued) {
+			ue.ewma = ue.enqueued;
+			goto done;
+		}
+	}
+
 	/*
 	 * Skip update of task's estimated utilization when its EWMA is
 	 * already ~1% close to its last activation value.
 	 */
-	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
 	last_ewma_diff = ue.enqueued - ue.ewma;
 	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
 		return;
@@ -3722,6 +3733,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
 	ue.ewma  += last_ewma_diff;
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
+done:
 	WRITE_ONCE(p->se.avg.util_est, ue);
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 2410db5e9a35..7481cd96f391 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -89,3 +89,4 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+SCHED_FEAT(UTIL_EST_FASTUP, true)
-- 
2.21.0


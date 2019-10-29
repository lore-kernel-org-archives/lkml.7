Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C4CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF04F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfJ2JxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:53:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbfJ2Jwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAs-0004Ue-9c; Tue, 29 Oct 2019 10:52:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 785BC1C04DF;
        Tue, 29 Oct 2019 10:52:23 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:23 -0000
From:   "tip-bot2 for Patrick Bellasi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair/util_est: Implement faster ramp-up EWMA
 on utilization increases
Cc:     Patrick Bellasi <patrick.bellasi@matbug.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Quentin Perret <qperret@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191023205630.14469-1-patrick.bellasi@matbug.net>
References: <20191023205630.14469-1-patrick.bellasi@matbug.net>
MIME-Version: 1.0
Message-ID: <157234274323.29376.7566420504850484825.tip-bot2@tip-bot2>
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

Commit-ID:     b8c96361402aa3e74ad48ceef18aed99153d8da8
Gitweb:        https://git.kernel.org/tip/b8c96361402aa3e74ad48ceef18aed99153d8da8
Author:        Patrick Bellasi <patrick.bellasi@matbug.net>
AuthorDate:    Wed, 23 Oct 2019 21:56:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:07 +01:00

sched/fair/util_est: Implement faster ramp-up EWMA on utilization increases

The estimated utilization for a task:

   util_est = max(util_avg, est.enqueue, est.ewma)

is defined based on:

 - util_avg: the PELT defined utilization
 - est.enqueued: the util_avg at the end of the last activation
 - est.ewma:     a exponential moving average on the est.enqueued samples

According to this definition, when a task suddenly changes its bandwidth
requirements from small to big, the EWMA will need to collect multiple
samples before converging up to track the new big utilization.

This slow convergence towards bigger utilization values is not
aligned to the default scheduler behavior, which is to optimize for
performance. Moreover, the est.ewma component fails to compensate for
temporarely utilization drops which spans just few est.enqueued samples.

To let util_est do a better job in the scenario depicted above, change
its definition by making util_est directly follow upward motion and
only decay the est.ewma on downward.

Signed-off-by: Patrick Bellasi <patrick.bellasi@matbug.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <qperret@google.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191023205630.14469-1-patrick.bellasi@matbug.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c     | 14 +++++++++++++-
 kernel/sched/features.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a81c364..a144874 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3769,10 +3769,21 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 		return;
 
 	/*
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
+	/*
 	 * Skip update of task's estimated utilization when its EWMA is
 	 * already ~1% close to its last activation value.
 	 */
-	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
 	last_ewma_diff = ue.enqueued - ue.ewma;
 	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
 		return;
@@ -3805,6 +3816,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
 	ue.ewma  += last_ewma_diff;
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
+done:
 	WRITE_ONCE(p->se.avg.util_est, ue);
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 2410db5..7481cd9 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -89,3 +89,4 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+SCHED_FEAT(UTIL_EST_FASTUP, true)

Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624D0C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A18221955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGVReX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:34:23 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37692 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbfGVReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:22 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hpcC8-0003HL-FQ; Mon, 22 Jul 2019 13:33:52 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 12/14] sched,fair: track cfs_rq->max_h_load for more legitimate h_weight
Date:   Mon, 22 Jul 2019 13:33:46 -0400
Message-Id: <20190722173348.9241-13-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722173348.9241-1-riel@surriel.com>
References: <20190722173348.9241-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cfs_rq->h_load decays to zero quite rapidly, which can easily lead
to tasks getting enqueued with an h_weight and h_load of zero, confusing
the load balancer, the preemption code, and other parts of the kernel.

Add a slow moving cfs_rq->max_h_load, with a half life of just over a minute,
to help tasks get enqueued with more legitimate h_weight values.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  |  6 +++++-
 kernel/sched/pelt.c  | 16 ++++++++++++++++
 kernel/sched/pelt.h  |  1 +
 kernel/sched/sched.h |  2 ++
 5 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 6e7c8ff210a8..88ed6d4429e6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -553,6 +553,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			atomic_long_read(&cfs_rq->tg->load_avg));
 	SEQ_printf(m, "  .%-30s: %lu\n", "h_load",
 			cfs_rq->h_load);
+	SEQ_printf(m, "  .%-30s: %lu\n", "max_h_load",
+			cfs_rq->max_h_load);
 #endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d5145cb6096..224cd9b20887 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7636,6 +7636,8 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 	if (!se) {
 		cfs_rq->h_load = cfs_rq_load_avg(cfs_rq);
+		slow_decay(&cfs_rq->max_h_load, &cfs_rq->last_max_h_decay);
+		cfs_rq->max_h_load = max(cfs_rq->max_h_load, cfs_rq->h_load);
 		cfs_rq->last_h_load_update = now;
 	}
 
@@ -7645,6 +7647,8 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 			cfs_rq_load_avg(cfs_rq) + 1);
 		cfs_rq = group_cfs_rq(se);
 		cfs_rq->h_load = load;
+		slow_decay(&cfs_rq->max_h_load, &cfs_rq->last_max_h_decay);
+		cfs_rq->max_h_load = max(load, cfs_rq->max_h_load);
 		cfs_rq->last_h_load_update = now;
 	}
 }
@@ -7660,7 +7664,7 @@ static unsigned long task_se_h_weight(struct sched_entity *se)
 	update_cfs_rq_h_load(cfs_rq);
 
 	/* Reduce the load.weight by the h_load of the group the task is in. */
-	return (cfs_rq->h_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;
+	return (cfs_rq->max_h_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;
 }
 
 static unsigned long task_se_h_load(struct sched_entity *se)
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2c901e0f9fbd..2173db8c6209 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -58,6 +58,22 @@ static u64 decay_load(u64 val, u64 n)
 	return val;
 }
 
+/*
+ * Like above, with a period of close to a minute for very slow decay.
+ * At 2 seconds per period, LOAD_AVG_PERIOD periods is just over a minute.
+ */
+void slow_decay(unsigned long *load, unsigned long *time)
+{
+	unsigned long periods = (jiffies - *time) / 2;
+
+	if (!periods)
+		return;
+
+	*time += periods * 2;
+
+	*load = decay_load(*load, periods);
+}
+
 static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
 {
 	u32 c1, c2, c3 = d3; /* y^0 == 1 */
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 1152c4ebf314..f16042e2aa06 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+void slow_decay(unsigned long *load, unsigned long *time);
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b05fd87cf8b5..b627ca594f97 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -540,6 +540,8 @@ struct cfs_rq {
 	 * this group.
 	 */
 	unsigned long		h_load;
+	unsigned long		max_h_load;
+	unsigned long		last_max_h_decay;
 	u64			last_h_load_update;
 	struct sched_entity	*h_load_next;
 #endif /* CONFIG_FAIR_GROUP_SCHED */
-- 
2.20.1


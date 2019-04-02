Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3755C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9245B20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfDBKma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:42:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48328 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDBKm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:42:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E74BB168F;
        Tue,  2 Apr 2019 03:42:27 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C461D3F59C;
        Tue,  2 Apr 2019 03:42:24 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v8 03/16] sched/core: uclamp: Enforce last task's UCLAMP_MAX
Date:   Tue,  2 Apr 2019 11:41:39 +0100
Message-Id: <20190402104153.25404-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402104153.25404-1-patrick.bellasi@arm.com>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task sleeps it removes its max utilization clamp from its CPU.
However, the blocked utilization on that CPU can be higher than the max
clamp value enforced while the task was running. This allows undesired
CPU frequency increases while a CPU is idle, for example, when another
CPU on the same frequency domain triggers a frequency update, since
schedutil can now see the full not clamped blocked utilization of the
idle CPU.

Fix this by using
  uclamp_rq_dec_id(p, rq, UCLAMP_MAX)
    uclamp_rq_max_value(rq, UCLAMP_MAX, clamp_value)
to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
condition.

Don't track any minimum utilization clamps since an idle CPU never
requires a minimum frequency. The decay of the blocked utilization is
good enough to reduce the CPU frequency.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

--
Changes in v8:
 Message-ID: <20190314170619.rt6yhelj3y6dzypu@e110439-lin>
 - moved flag reset into uclamp_rq_inc()
---
 kernel/sched/core.c  | 45 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  2 ++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e1beae5f348..046f61d33f00 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -754,8 +754,35 @@ static inline unsigned int uclamp_none(int clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
+static inline unsigned int
+uclamp_idle_value(struct rq *rq, unsigned int clamp_id, unsigned int clamp_value)
+{
+	/*
+	 * Avoid blocked utilization pushing up the frequency when we go
+	 * idle (which drops the max-clamp) by retaining the last known
+	 * max-clamp.
+	 */
+	if (clamp_id == UCLAMP_MAX) {
+		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
+		return clamp_value;
+	}
+
+	return uclamp_none(UCLAMP_MIN);
+}
+
+static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
+				     unsigned int clamp_value)
+{
+	/* Reset max-clamp retention only on idle exit */
+	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
+		return;
+
+	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
+}
+
 static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
+unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
+				 unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
 	int bucket_id = UCLAMP_BUCKETS - 1;
@@ -771,7 +798,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
 	}
 
 	/* No tasks -- default clamp values */
-	return uclamp_none(clamp_id);
+	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
 /*
@@ -794,6 +821,8 @@ static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	bucket->tasks++;
 
+	uclamp_idle_reset(rq, clamp_id, uc_se->value);
+
 	/*
 	 * Local max aggregation: rq buckets always track the max
 	 * "requested" clamp value of its RUNNABLE tasks.
@@ -820,6 +849,7 @@ static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
 	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
 	struct uclamp_bucket *bucket;
+	unsigned int bkt_clamp;
 	unsigned int rq_clamp;
 
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
@@ -848,7 +878,8 @@ static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
 		 * there are anymore RUNNABLE tasks refcounting it.
 		 */
 		bucket->value = uclamp_bucket_base_value(bucket->value);
-		WRITE_ONCE(uc_rq->value, uclamp_rq_max_value(rq, clamp_id));
+		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
+		WRITE_ONCE(uc_rq->value, bkt_clamp);
 	}
 }
 
@@ -861,6 +892,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
 		uclamp_rq_inc_id(p, rq, clamp_id);
+
+	/* Reset clamp idle holding when there is one RUNNABLE task */
+	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }
 
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
@@ -879,8 +914,10 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		cpu_rq(cpu)->uclamp_flags = 0;
+	}
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		struct uclamp_se *uc_se = &init_task.uclamp[clamp_id];
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c3d1ae1e7eec..d8b182f1782c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -880,6 +880,8 @@ struct rq {
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
+	unsigned int		uclamp_flags;
+#define UCLAMP_FLAG_IDLE 0x01
 #endif
 
 	struct cfs_rq		cfs;
-- 
2.20.1


Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9683DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3D72148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="o0fkawdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfDHVqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:46:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54604 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726507AbfDHVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:46:13 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38Li43m008373
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=OO9TirhM3pC6EEM2ULmWIFa5L79pomgcK4+Z3m72rLA=;
 b=o0fkawdqF2jtGf4hnMQsOuOcL+MUhUG66Oo/zmF+rUKp8btKYu1MEcals4hNlWUBP8r4
 w5YgZbTGEeUM0zN/xDpA1LjqIBW7YHvK/LGuYOWFJDZwxOrkVlMqsfNVI50m1BqTqqj9
 QDhQBIaChgGkfNYfTU62n//JhBv8R0s8eew= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrb4v8tuf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:46:12 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:46:09 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D6ECD62E1F66; Mon,  8 Apr 2019 14:46:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <tglx@linutronix.de>,
        <morten.rasmussen@arm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 6/7] sched/fair: throttle task runtime based on cpu.headroom
Date:   Mon, 8 Apr 2019 14:45:38 -0700
Message-ID: <20190408214539.2705660-7-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408214539.2705660-1-songliubraving@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables task runtime throttling based on cpu.headroom setting.
The throttling leverages the same mechanism of the cpu.max knob. Task
groups with non-zero target_idle get throttled.

In __refill_cfs_bandwidth_runtime(), global idleness measured by function
cfs_global_idleness_update() is compared against target_idle of the task
group. If the measured idleness is lower than the target, runtime of this
task group is reduced to min_runtime.

A new variable "prev_runtime" is added to struct cfs_bandwidth, so that
the new runtime could be adjust accordingly.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/sched/fair.c  | 69 +++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |  4 +++
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 49c68daffe7e..3b0535cda7cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4331,6 +4331,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
 	return (u64)sysctl_sched_cfs_bandwidth_slice * NSEC_PER_USEC;
 }
 
+static inline bool cfs_bandwidth_throttling_on(struct cfs_bandwidth *cfs_b)
+{
+	return cfs_b->quota != RUNTIME_INF || cfs_b->target_idle != 0;
+}
+
+static inline u64 cfs_bandwidth_pct_to_ns(u64 period, unsigned long pct)
+{
+	return div_u64(period * num_online_cpus() * pct, 100) >> FSHIFT;
+}
+
 /*
  * Replenish runtime according to assigned quota and update expiration time.
  * We use sched_clock_cpu directly instead of rq->clock to avoid adding
@@ -4340,9 +4350,12 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
+	/* runtimes in nanoseconds */
+	u64 idle_time, target_idle_time, max_runtime, min_runtime;
+	unsigned long idle_pct;
 	u64 now;
 
-	if (cfs_b->quota == RUNTIME_INF)
+	if (!cfs_bandwidth_throttling_on(cfs_b))
 		return;
 
 	now = sched_clock_cpu(smp_processor_id());
@@ -4353,7 +4366,49 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	if (cfs_b->target_idle == 0)
 		return;
 
-	cfs_global_idleness_update(now, cfs_b->period);
+	/*
+	 * max_runtime is the maximal possible runtime for given
+	 * target_idle and quota. In other words:
+	 *     max_runtime = min(quota,
+	 *                       total_time * (100% - target_idle))
+	 */
+	max_runtime = min_t(u64, cfs_b->quota,
+			    cfs_bandwidth_pct_to_ns(cfs_b->period,
+						    (100 << FSHIFT) - cfs_b->target_idle));
+	idle_pct = cfs_global_idleness_update(now, cfs_b->period);
+
+	/*
+	 * Throttle runtime if idle_pct is less than target_idle:
+	 *     idle_pct < cfs_b->target_idle
+	 *
+	 * or if the throttling is on in previous period:
+	 *     max_runtime != cfs_b->prev_runtime
+	 */
+	if (idle_pct < cfs_b->target_idle ||
+	    max_runtime != cfs_b->prev_runtime) {
+		idle_time = cfs_bandwidth_pct_to_ns(cfs_b->period, idle_pct);
+		target_idle_time = cfs_bandwidth_pct_to_ns(cfs_b->period,
+							   cfs_b->target_idle);
+
+		/* minimal runtime to avoid starving */
+		min_runtime = max_t(u64, min_cfs_quota_period,
+				    cfs_bandwidth_pct_to_ns(cfs_b->period,
+							    cfs_b->min_runtime));
+		if (cfs_b->prev_runtime + idle_time < target_idle_time) {
+			cfs_b->runtime = min_runtime;
+		} else {
+			cfs_b->runtime = cfs_b->prev_runtime + idle_time -
+				target_idle_time;
+			if (cfs_b->runtime > max_runtime)
+				cfs_b->runtime = max_runtime;
+			if (cfs_b->runtime < min_runtime)
+				cfs_b->runtime = min_runtime;
+		}
+	} else {
+		/* no need for throttling */
+		cfs_b->runtime = max_runtime;
+	}
+	cfs_b->prev_runtime = cfs_b->runtime;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4382,7 +4437,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
 
 	raw_spin_lock(&cfs_b->lock);
-	if (cfs_b->quota == RUNTIME_INF)
+	if (!cfs_bandwidth_throttling_on(cfs_b))
 		amount = min_amount;
 	else {
 		start_cfs_bandwidth(cfs_b);
@@ -4690,7 +4745,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	int throttled;
 
 	/* no need to continue the timer with no bandwidth constraint */
-	if (cfs_b->quota == RUNTIME_INF)
+	if (!cfs_bandwidth_throttling_on(cfs_b))
 		goto out_deactivate;
 
 	throttled = !list_empty(&cfs_b->throttled_cfs_rq);
@@ -4806,7 +4861,7 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 		return;
 
 	raw_spin_lock(&cfs_b->lock);
-	if (cfs_b->quota != RUNTIME_INF &&
+	if (cfs_bandwidth_throttling_on(cfs_b) &&
 	    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
 		cfs_b->runtime += slack_runtime;
 
@@ -4854,7 +4909,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		return;
 	}
 
-	if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
+	if (cfs_bandwidth_throttling_on(cfs_b) && cfs_b->runtime > slice)
 		runtime = cfs_b->runtime;
 
 	expires = cfs_b->runtime_expires;
@@ -5048,7 +5103,7 @@ static void __maybe_unused update_runtime_enabled(struct rq *rq)
 		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
 
 		raw_spin_lock(&cfs_b->lock);
-		cfs_rq->runtime_enabled = cfs_b->quota != RUNTIME_INF;
+		cfs_rq->runtime_enabled = cfs_bandwidth_throttling_on(cfs_b);
 		raw_spin_unlock(&cfs_b->lock);
 	}
 	rcu_read_unlock();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9309bf05ff0c..92e8a824c6fe 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -338,6 +338,7 @@ extern struct list_head task_groups;
 
 #ifdef CONFIG_CFS_BANDWIDTH
 extern void cfs_bandwidth_has_tasks_changed_work(struct work_struct *work);
+extern const u64 min_cfs_quota_period;
 #endif
 
 struct cfs_bandwidth {
@@ -370,6 +371,9 @@ struct cfs_bandwidth {
 	/* work_struct to adjust settings asynchronously */
 	struct work_struct	has_tasks_changed_work;
 
+	/* runtime assigned to previous period */
+	u64			prev_runtime;
+
 	short			idle;
 	short			period_active;
 	struct hrtimer		period_timer;
-- 
2.17.1


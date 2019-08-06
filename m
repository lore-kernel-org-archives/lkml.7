Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA71C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF88214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfHFOHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:07:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3767 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728836AbfHFOHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:07:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E96F6A1A2E2A146353F6;
        Tue,  6 Aug 2019 22:06:59 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 22:06:52 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>,
        <bobo.shaobowang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/core: decrease rq->nr_uninterruptible before set_task_cpu
Date:   Tue, 6 Aug 2019 22:12:50 +0800
Message-ID: <1565100770-110193-1-git-send-email-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migration may occur when wake up a process, so we must update
the rq->nr_uninterruptible before set_task_cpu, otherwise we
will decrease the nr_interuptible of the incorrect rq. Over
time, it cause some rq accounting according to be too large,
but others are negative.

Also change the type of rq->nr_uninterruptible to atomic_t.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/sched/core.c    | 14 +++++++++-----
 kernel/sched/debug.c   |  2 +-
 kernel/sched/loadavg.c |  2 +-
 kernel/sched/sched.h   |  2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f1..4d3bbc1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1198,7 +1198,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible--;
+		atomic_dec(&rq->nr_uninterruptible);
 
 	enqueue_task(rq, p, flags);
 
@@ -1210,7 +1210,7 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;
 
 	if (task_contributes_to_load(p))
-		rq->nr_uninterruptible++;
+		atomic_inc(&rq->nr_uninterruptible);
 
 	dequeue_task(rq, p, flags);
 }
@@ -2135,9 +2135,6 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 	lockdep_assert_held(&rq->lock);
 
 #ifdef CONFIG_SMP
-	if (p->sched_contributes_to_load)
-		rq->nr_uninterruptible--;
-
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
 #endif
@@ -2500,11 +2497,15 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	p->sched_contributes_to_load = !!task_contributes_to_load(p);
 	p->state = TASK_WAKING;
 
+	/* update the rq accounting according before set_task_cpu */
 	if (p->in_iowait) {
 		delayacct_blkio_end(p);
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
+	if (p->sched_contributes_to_load)
+		atomic_dec(&task_rq(p)->nr_uninterruptible);
+
 	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
 	if (task_cpu(p) != cpu) {
 		wake_flags |= WF_MIGRATED;
@@ -2519,6 +2520,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
+	if (p->sched_contributes_to_load)
+		atomic_dec(&task_rq(p)->nr_uninterruptible);
+
 #endif /* CONFIG_SMP */
 
 	ttwu_queue(p, cpu, wake_flags);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579..fa2c1bc 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -641,7 +641,7 @@ do {									\
 	P(nr_running);
 	P(nr_switches);
 	P(nr_load_updates);
-	P(nr_uninterruptible);
+	SEQ_printf(m, "  .%-30s: %d\n", "nr_uninterruptible", atomic_read(&rq->nr_uninterruptible));
 	PN(next_balance);
 	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq->curr)));
 	PN(clock);
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 28a5165..cae7643 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -81,7 +81,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (long)this_rq->nr_uninterruptible;
+	nr_active += (long)atomic_read(&this_rq->nr_uninterruptible);
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3..8429281 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -890,7 +890,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned long		nr_uninterruptible;
+	atomic_t		nr_uninterruptible;
 
 	struct task_struct	*curr;
 	struct task_struct	*idle;
-- 
2.7.4


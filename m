Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7DDC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105E5207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfJNHKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:10:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11425 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729966AbfJNHKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:10:04 -0400
X-UUID: 8eee07bc3d824392818720a56a3afcfa-20191014
X-UUID: 8eee07bc3d824392818720a56a3afcfa-20191014
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1525608313; Mon, 14 Oct 2019 15:09:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 15:09:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 15:09:53 +0800
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Jing-Ting Wu <jing-ting.wu@mediatek.com>
Subject: [PATCH v2 1/1] sched/rt: avoid contend with CFS task
Date:   Mon, 14 Oct 2019 15:09:08 +0800
Message-ID: <1571036948-25034-2-git-send-email-jing-ting.wu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1571036948-25034-1-git-send-email-jing-ting.wu@mediatek.com>
References: <1571036948-25034-1-git-send-email-jing-ting.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At original linux design, RT & CFS scheduler are independent.
Current RT task placement policy will select the first cpu in
lowest_mask, even if the first CPU is running a CFS task.
This may put RT task to a running cpu and let CFS task runnable.

So we select idle cpu in lowest_mask first to avoid preempting
CFS task.

We use some third-party application to test the application launch time.
We apply this RT patch, and compare it with original design.
Both this RT patch test case and original design test case are
already apply the series patches: sched/fair: rework the CFS load balance.

Application  Original(ms)  RT patch(ms)  Difference(ms)  Difference(%)
-----------------------------------------------------------------------
weibo          1325.72       1214.88        -110.84         -8.36
weixin          615.92        567.32         -48.60         -7.89
alipay          702.41        649.24         -53.17         -7.57

After apply this RT patch, launch time decrease about 8%.

Change-Id: Ia0a7a61d38cb406d82b7049787c62b95dfa0a69f
Signed-off-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
---
 kernel/sched/rt.c |   56 +++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558..81085ed 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1388,7 +1388,6 @@ static void yield_task_rt(struct rq *rq)
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 {
-	struct task_struct *curr;
 	struct rq *rq;
 
 	/* For anything but wake ups, just return the task_cpu */
@@ -1398,33 +1397,15 @@ static void yield_task_rt(struct rq *rq)
 	rq = cpu_rq(cpu);
 
 	rcu_read_lock();
-	curr = READ_ONCE(rq->curr); /* unlocked access */
 
 	/*
-	 * If the current task on @p's runqueue is an RT task, then
-	 * try to see if we can wake this RT task up on another
-	 * runqueue. Otherwise simply start this RT task
-	 * on its current runqueue.
-	 *
-	 * We want to avoid overloading runqueues. If the woken
-	 * task is a higher priority, then it will stay on this CPU
-	 * and the lower prio task should be moved to another CPU.
-	 * Even though this will probably make the lower prio task
-	 * lose its cache, we do not want to bounce a higher task
-	 * around just because it gave up its CPU, perhaps for a
-	 * lock?
-	 *
-	 * For equal prio tasks, we just let the scheduler sort it out.
-	 *
-	 * Otherwise, just let it ride on the affined RQ and the
-	 * post-schedule router will push the preempted task away
-	 *
-	 * This test is optimistic, if we get it wrong the load-balancer
-	 * will have to sort it out.
+	 * If the task p is allowed to put more than one CPU or
+	 * it is not allowed to put on this CPU.
+	 * Let p use find_lowest_rq to choose other idle CPU first,
+	 * instead of choose this cpu and preempt curr cfs task.
 	 */
-	if (curr && unlikely(rt_task(curr)) &&
-	    (curr->nr_cpus_allowed < 2 ||
-	     curr->prio <= p->prio)) {
+	if ((p->nr_cpus_allowed > 1) ||
+	    (!cpumask_test_cpu(cpu, p->cpus_ptr))) {
 		int target = find_lowest_rq(p);
 
 		/*
@@ -1648,6 +1629,9 @@ static int find_lowest_rq(struct task_struct *task)
 	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
 	int this_cpu = smp_processor_id();
 	int cpu      = task_cpu(task);
+	int i;
+	struct rq *prev_rq = cpu_rq(cpu);
+	struct sched_domain *prev_sd;
 
 	/* Make sure the mask is initialized first */
 	if (unlikely(!lowest_mask))
@@ -1659,6 +1643,28 @@ static int find_lowest_rq(struct task_struct *task)
 	if (!cpupri_find(&task_rq(task)->rd->cpupri, task, lowest_mask))
 		return -1; /* No targets found */
 
+	/* Choose previous cpu if it is idle and it fits lowest_mask */
+	if (cpumask_test_cpu(cpu, lowest_mask) && idle_cpu(cpu))
+		return cpu;
+
+	rcu_read_lock();
+	prev_sd = rcu_dereference(prev_rq->sd);
+
+	if (prev_sd) {
+		/*
+		 * Choose idle_cpu among lowest_mask and it is closest
+		 * to our hot cache data.
+		 */
+		for_each_cpu(i, lowest_mask) {
+			if (idle_cpu(i) &&
+			    cpumask_test_cpu(i, sched_domain_span(prev_sd))) {
+				rcu_read_unlock();
+				return i;
+			}
+		}
+	}
+	rcu_read_unlock();
+
 	/*
 	 * At this point we have built a mask of CPUs representing the
 	 * lowest priority tasks in the system.  Now we want to elect
-- 
1.7.9.5


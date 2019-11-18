Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D38C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3532190F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKRRnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:43:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfKRRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:43:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iWl2v-00013C-Ky; Mon, 18 Nov 2019 18:42:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 471B61C19BB;
        Mon, 18 Nov 2019 18:42:41 +0100 (CET)
Date:   Mon, 18 Nov 2019 17:42:41 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix rework of find_idlest_group()
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten.Rasmussen@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, dietmar.eggemann@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, pauld@redhat.com,
        quentin.perret@arm.com, riel@surriel.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
References: <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157409896125.12247.17306137104024475114.tip-bot2@tip-bot2>
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

Commit-ID:     3318544b721d3072fdd1f85ee0f1f214c0b211ee
Gitweb:        https://git.kernel.org/tip/3318544b721d3072fdd1f85ee0f1f214c0b211ee
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 22 Oct 2019 18:46:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Nov 2019 14:11:56 +01:00

sched/fair: Fix rework of find_idlest_group()

The task, for which the scheduler looks for the idlest group of CPUs, must
be discounted from all statistics in order to get a fair comparison
between groups. This includes utilization, load, nr_running and idle_cpus.

Such unfairness can be easily highlighted with the unixbench execl 1 task.
This test continuously call execve() and the scheduler looks for the idlest
group/CPU on which it should place the task. Because the task runs on the
local group/CPU, the latter seems already busy even if there is nothing
else running on it. As a result, the scheduler will always select another
group/CPU than the local one.

This recovers most of the performance regression on my system from the
recent load-balancer rewrite.

[ mingo: Minor cleanups. ]

Reported-by: kernel test robot <rong.a.chen@intel.com>
Tested-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: hdanton@sina.com
Cc: parth@linux.ibm.com
Cc: pauld@redhat.com
Cc: quentin.perret@arm.com
Cc: riel@surriel.com
Cc: srikar@linux.vnet.ibm.com
Cc: valentin.schneider@arm.com
Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Link: https://lkml.kernel.org/r/1571762798-25900-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 91 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81eba55..2fc08e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5391,6 +5391,37 @@ static unsigned long cpu_load(struct rq *rq)
 	return cfs_rq_load_avg(&rq->cfs);
 }
 
+/*
+ * cpu_load_without - compute CPU load without any contributions from *p
+ * @cpu: the CPU which load is requested
+ * @p: the task which load should be discounted
+ *
+ * The load of a CPU is defined by the load of tasks currently enqueued on that
+ * CPU as well as tasks which are currently sleeping after an execution on that
+ * CPU.
+ *
+ * This method returns the load of the specified CPU by discounting the load of
+ * the specified task, whenever the task is currently contributing to the CPU
+ * load.
+ */
+static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq;
+	unsigned int load;
+
+	/* Task has no contribution or is new */
+	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+		return cpu_load(rq);
+
+	cfs_rq = &rq->cfs;
+	load = READ_ONCE(cfs_rq->avg.load_avg);
+
+	/* Discount task's util from CPU's util */
+	lsub_positive(&load, task_h_load(p));
+
+	return load;
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -8142,10 +8173,55 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
 struct sg_lb_stats;
 
 /*
+ * task_running_on_cpu - return 1 if @p is running on @cpu.
+ */
+
+static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
+{
+	/* Task has no contribution or is new */
+	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+		return 0;
+
+	if (task_on_rq_queued(p))
+		return 1;
+
+	return 0;
+}
+
+/**
+ * idle_cpu_without - would a given CPU be idle without p ?
+ * @cpu: the processor on which idleness is tested.
+ * @p: task which should be ignored.
+ *
+ * Return: 1 if the CPU would be idle. 0 otherwise.
+ */
+static int idle_cpu_without(int cpu, struct task_struct *p)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (rq->curr != rq->idle && rq->curr != p)
+		return 0;
+
+	/*
+	 * rq->nr_running can't be used but an updated version without the
+	 * impact of p on cpu must be used instead. The updated nr_running
+	 * be computed and tested before calling idle_cpu_without().
+	 */
+
+#ifdef CONFIG_SMP
+	if (!llist_empty(&rq->wake_list))
+		return 0;
+#endif
+
+	return 1;
+}
+
+/*
  * update_sg_wakeup_stats - Update sched_group's statistics for wakeup.
- * @denv: The ched_domain level to look for idlest group.
+ * @sd: The sched_domain level to look for idlest group.
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
+ * @p: The task for which we look for the idlest group/CPU.
  */
 static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 					  struct sched_group *group,
@@ -8158,21 +8234,22 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	for_each_cpu(i, sched_group_span(group)) {
 		struct rq *rq = cpu_rq(i);
+		unsigned int local;
 
-		sgs->group_load += cpu_load(rq);
+		sgs->group_load += cpu_load_without(rq, p);
 		sgs->group_util += cpu_util_without(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
+		local = task_running_on_cpu(i, p);
+		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
 
-		nr_running = rq->nr_running;
+		nr_running = rq->nr_running - local;
 		sgs->sum_nr_running += nr_running;
 
 		/*
-		 * No need to call idle_cpu() if nr_running is not 0
+		 * No need to call idle_cpu_without() if nr_running is not 0
 		 */
-		if (!nr_running && idle_cpu(i))
+		if (!nr_running && idle_cpu_without(i, p))
 			sgs->idle_cpus++;
 
-
 	}
 
 	/* Check if task fits in the group */

Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD10CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68172084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbxmdyVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbfJVQrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:47:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36734 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732115AbfJVQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:47:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so7733814wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ynJ+EIg0nJoZIPxTbdiibFb7a004wEX5Rn38cExKDPQ=;
        b=lbxmdyVRraePCLsE7fkYie86Ytun531L5V2lxKzkfAsi7ZljJ8vueA4x1y7xd0rUcp
         W5IW19zTIKGOSSK8wVBDcK6y1KrgyKNYFCtwlwTsXQHizfke699CSccUtM55xfT2iFdw
         zXn3E0gyOR2gtXVpL3YLhlQOVBKKVhBUNYXorGVSWcT8xcYz1ncrzHUiIcn72732cIXX
         ak3lU8F+tcjpQtDKyMpyGNQ0uVeij8K1Yy2wtydDLk8XBRWaUI6Tn7/4bY8n1+v9gWMJ
         tZA5FJC3jhpnzAS/wddcE13KQe3WJ5QpY61EodEJoxULBUIwh44zW7VoAMTilg9utNYJ
         2ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ynJ+EIg0nJoZIPxTbdiibFb7a004wEX5Rn38cExKDPQ=;
        b=N97NyHIoUbeGoWycKoXxXrFoTN+blu5N5+UxM73hoQbisrEaKHL1a4go2dseISoVFe
         McVp/sxNs3BuXU4siymoagTl41Ac05UsOeaXk7fVbVDSPRAU7tO5acjuTAcmP7RIWVeO
         0wYrHNEmEUGjI9OcTkifscHapD0i6s2pxTkiYcmHJ6DIoN60Zv9VI0YrXV3lhHMeqIxR
         aDDjHF4abuede2+oJ15Oyd4tSdz7QIYh4mTM99B/rtzWoASw29J9t0fdhfCBmrPWk+Ty
         rvAfeOWgAr+tHvXXmCiB4KOW2UnwddXpnstwOEJ/4VGys9Y15vQz14oFjHB2v6TnvB9h
         phPw==
X-Gm-Message-State: APjAAAWvPXNxJVP9AEUw7JlWOVHPR3M/sZ82HsSqAapJM85XiLd5TFV0
        +F89suSu1xoSy2e915n98/oA2V4escw=
X-Google-Smtp-Source: APXvYqyFQFE1bfsJH0qZDrjvw1tNSUbHF31Rw87l4fS7snIOKCM7yZ3N7J/fBZGl+11NfKgQ7kvrMg==
X-Received: by 2002:a7b:cf36:: with SMTP id m22mr3716719wmg.98.1571762852648;
        Tue, 22 Oct 2019 09:47:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5555:46b4:8533:7ed2])
        by smtp.gmail.com with ESMTPSA id n17sm7184466wrt.25.2019.10.22.09.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 09:47:31 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        rong.a.chen@intel.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix rework of find_idlest_group()
Date:   Tue, 22 Oct 2019 18:46:38 +0200
Message-Id: <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task, for which the scheduler looks for the idlest group of CPUs, must
be discounted from all statistics in order to get a fair comparison
between groups. This includes utilization, load, nr_running and idle_cpus.

Such unfairness can be easily highlighted with the unixbench execl 1 task.
This test continuously call execve() and the scheduler looks for the idlest
group/CPU on which it should place the task. Because the task runs on the
local group/CPU, the latter seems already busy even if there is nothing
else running on it. As a result, the scheduler will always select another
group/CPU than the local one.

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

This recover most of the perf regression on my system and I have asked
Rong if he can rerun the test with the patch to check that it fixes his
system as well.

 kernel/sched/fair.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a81c364..0ad4b21 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5379,6 +5379,36 @@ static unsigned long cpu_load(struct rq *rq)
 {
 	return cfs_rq_load_avg(&rq->cfs);
 }
+/*
+ * cpu_load_without - compute cpu load without any contributions from *p
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
 
 static unsigned long capacity_of(int cpu)
 {
@@ -8117,10 +8147,55 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
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
+	if ((rq->curr != rq->idle) && (rq->curr != p))
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
@@ -8133,21 +8208,22 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
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
-- 
2.7.4


Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7325C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C15621781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK1PR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:17:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:39027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfK1PR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:17:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 07:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="199551673"
Received: from otc-lr-04.jf.intel.com ([10.54.39.104])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2019 07:17:26 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH 2/8] perf: Helpers for alloc/init/fini PMU specific data
Date:   Thu, 28 Nov 2019 07:14:25 -0800
Message-Id: <1574954071-6321-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU specific data for the monitored tasks is
allocated/initialized/freed during LBR call stack monitoring. Several
helper functions are provided.

alloc_task_ctx_data_rcu() is used to allocate the perf_ctx_data for a
task when RCU protected perf_ctx_data is NULL. It doesn't update the
refcount if the perf_ctx_data has already been allocated.

init_task_ctx_data_rcu() is similar as alloc_task_ctx_data_rcu(). But it
updates the refcount if the perf_ctx_data was already allocated.

fini_task_ctx_data_rcu() is to free the RCU protected perf_ctx_data when
there are no users, or force flag is set.

A lock is required for these functions, which is used to sync the
writers of perf_ctx_data RCU pointer and refcount.

The functions will be used by the following patch.

Reviewed-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 43567d1..b4976e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4440,6 +4440,160 @@ static void unaccount_freq_event(void)
 		atomic_dec(&nr_freq_events);
 }
 
+static int
+alloc_perf_ctx_data(size_t ctx_size, gfp_t flags,
+		    struct perf_ctx_data **task_ctx_data)
+{
+	struct perf_ctx_data *ctx_data;
+
+	ctx_data = kzalloc(sizeof(struct perf_ctx_data), flags);
+	if (!ctx_data)
+		return -ENOMEM;
+
+	ctx_data->data = kzalloc(ctx_size, flags);
+	if (!ctx_data->data) {
+		kfree(ctx_data);
+		return -ENOMEM;
+	}
+
+	ctx_data->data_size = ctx_size;
+	*task_ctx_data = ctx_data;
+
+	return 0;
+}
+
+static int
+__alloc_task_ctx_data_rcu(struct task_struct *task,
+			  size_t ctx_size, gfp_t flags)
+{
+	struct perf_ctx_data *ctx_data = task->perf_ctx_data;
+	int ret;
+
+	lockdep_assert_held_once(&task->perf_ctx_data_lock);
+
+	ret = alloc_perf_ctx_data(ctx_size, flags, &ctx_data);
+	if (ret)
+		return ret;
+
+	ctx_data->refcount = 1;
+
+	rcu_assign_pointer(task->perf_ctx_data, ctx_data);
+
+	return 0;
+}
+
+/**
+ * alloc perf_ctx_data for a task
+ * @task:        Target Task
+ * @ctx_size:    Size of PMU specific data
+ * @flags:       Allocation flags
+ *
+ * Allocate perf_ctx_data and update the RCU pointer.
+ * If the perf_ctx_data has been allocated, return 0.
+ * Lock is required to sync the writers of perf_ctx_data RCU pointer
+ * and refcount.
+ */
+static int
+alloc_task_ctx_data_rcu(struct task_struct *task,
+			size_t ctx_size, gfp_t flags)
+{
+	unsigned long lock_flags;
+	int ret = 0;
+
+	raw_spin_lock_irqsave(&task->perf_ctx_data_lock, lock_flags);
+
+	if (task->perf_ctx_data)
+		goto unlock;
+
+	ret = __alloc_task_ctx_data_rcu(task, ctx_size, flags);
+
+unlock:
+	raw_spin_unlock_irqrestore(&task->perf_ctx_data_lock, lock_flags);
+
+	return ret;
+}
+
+static int
+__init_task_ctx_data_rcu(struct task_struct *task, size_t ctx_size, gfp_t flags)
+{
+	struct perf_ctx_data *ctx_data = task->perf_ctx_data;
+
+	lockdep_assert_held_once(&task->perf_ctx_data_lock);
+
+	if (ctx_data) {
+		ctx_data->refcount++;
+		return 0;
+	}
+
+	return __alloc_task_ctx_data_rcu(task, ctx_size, flags);
+}
+
+/**
+ * Init perf_ctx_data for a task
+ * @task:        Target Task
+ * @ctx_size:    Size of PMU specific data
+ * @flags:       Allocation flags
+ *
+ * If the perf_ctx_data has been allocated, update the refcount.
+ * Otherwise, allocate perf_ctx_data and update the RCU pointer.
+ * Lock is required to sync the writers of perf_ctx_data RCU pointer
+ * and refcount.
+ */
+static int
+init_task_ctx_data_rcu(struct task_struct *task, size_t ctx_size, gfp_t flags)
+{
+	unsigned long lock_flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&task->perf_ctx_data_lock, lock_flags);
+	ret = __init_task_ctx_data_rcu(task, ctx_size, flags);
+	raw_spin_unlock_irqrestore(&task->perf_ctx_data_lock, lock_flags);
+
+	return ret;
+}
+
+static void
+free_perf_ctx_data(struct rcu_head *rcu_head)
+{
+	struct perf_ctx_data *ctx_data;
+
+	ctx_data = container_of(rcu_head, struct perf_ctx_data, rcu_head);
+	kfree(ctx_data->data);
+	kfree(ctx_data);
+}
+
+/**
+ * Free perf_ctx_data RCU pointer for a task
+ * @task:        Target Task
+ * @force:       Unconditionally free perf_ctx_data
+ *
+ * If force is set, free perf_ctx_data unconditionally.
+ * Otherwise, free perf_ctx_data when there are no users.
+ * Lock is required to sync the writers of perf_ctx_data RCU pointer
+ * and refcount.
+ */
+static void
+fini_task_ctx_data_rcu(struct task_struct *task, bool force)
+{
+	struct perf_ctx_data *ctx_data;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&task->perf_ctx_data_lock, flags);
+
+	ctx_data = task->perf_ctx_data;
+	if (!ctx_data)
+		goto unlock;
+
+	if (!force && --ctx_data->refcount)
+		goto unlock;
+
+	RCU_INIT_POINTER(task->perf_ctx_data, NULL);
+	call_rcu(&ctx_data->rcu_head, free_perf_ctx_data);
+
+unlock:
+	raw_spin_unlock_irqrestore(&task->perf_ctx_data_lock, flags);
+}
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
-- 
2.7.4


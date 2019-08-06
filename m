Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FF8C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22F821743
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LLppZc2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfHFVU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:20:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42502 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHFVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:20:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so42178600pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01Z7KPmsDPbjU4b8J1t9pHgMezzTkqyFHd5rBVu5BpA=;
        b=LLppZc2nQvCztaEdlOl3Fn5aSZlOqQpi54g7OSBjQFprgfXHP5mqZYMGMo6KuwGAL1
         ja+ykZYf0UVtlm7fyckwl4od525ZOJqOmvACNrkcsVEbcSDx2vRN9M8Uj4ZTs+AmBB6X
         M/4gM7h+1EOpyVP4xutan07zgB8x3IPuyb/D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=01Z7KPmsDPbjU4b8J1t9pHgMezzTkqyFHd5rBVu5BpA=;
        b=apliU5kPh8EVja8MPTZqUu7qW+mw7+kkiokkyPKJQj6WA9m+siUV4zwWu+E3Vd3O9a
         8B/XoSVihx3vE/QP6wTAaHQpI8jNXprdjaTWdgRnsjCBCPXU0cSIr8kDv4Zu1AIuRUl+
         rzBu/SM45a4VrBNQH/NEJj4FbxsrJBoxJuHz3oGB5SLPNBPwDS7WPNdSwIF7UpHVSgfk
         kSdy1scojiuzBgemRBfLcB3L1UamzSJojP+xT7FZ9M/RKJ9pJpvb4WIG6kLW8BEinfS7
         0wq1iddfEPYpWoYsMl6SNaV+0piSWv1qnTi+ipRuRk/taeYd7K9g42PbUa7l0bNodU+m
         6csA==
X-Gm-Message-State: APjAAAVIQjG0vYo7KSmXmZ1KItmrXJaVdk70gqJ1EfJ2+8ZkRlwBy498
        vGypnECHsiwE8LKii73j9MEkpNXdVSk=
X-Google-Smtp-Source: APXvYqzTE2aMkc8tu+2Wd1LpXbEWZu2K+gP4OExQieViso7Rh4B6OgF9ar8y8SgNV+YNkASIqMfHNw==
X-Received: by 2002:aa7:90d8:: with SMTP id k24mr5715204pfk.115.1565126455586;
        Tue, 06 Aug 2019 14:20:55 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b126sm128786325pfa.126.2019.08.06.14.20.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:20:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu batching
Date:   Tue,  6 Aug 2019 17:20:40 -0400
Message-Id: <20190806212041.118146-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a discussion about performance of system involving a high rate
of kfree_rcu() calls surfaced on the list [1] which led to another
discussion how to prepare for this situation.

This patch adds basic batching support for kfree_rcu. It is "basic"
because we do none of the slab management, dynamic allocation, code
moving or any of the other things, some of which previous attempts did
[2]. These fancier improvements can be follow-up patches and there are
several ideas being experimented in those regards.

Torture tests follow in the next patch and show improvements of around
~13% with continuous flooding of kfree_rcu() calls on a 16 CPU system.

[1] http://lore.kernel.org/lkml/20190723035725-mutt-send-email-mst@kernel.org
[2] https://lkml.org/lkml/2017/12/19/824

This is an effort just to start simple, and build up from there.

Cc: Rao Shoaib <rao.shoaib@oracle.com>
Cc: max.byungchul.park@gmail.com
Cc: byungchul.park@lge.com
Cc: kernel-team@android.com
Cc: kernel-team@lge.com
Co-developed-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 198 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 193 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a14e5fbbea46..bdbd483606ce 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2593,19 +2593,194 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+
+/* Maximum number of jiffies to wait before draining batch */
+#define KFREE_DRAIN_JIFFIES 50
+
+/*
+ * Maximum number of kfree(s) to batch, if limit is hit
+ * then RCU work is queued right away
+ */
+#define KFREE_MAX_BATCH	200000ULL
+
+struct kfree_rcu_cpu {
+	/* The work done to free objects after GP */
+	struct rcu_work rcu_work;
+
+	/* The list of objects being queued */
+	struct rcu_head *head;
+	int kfree_batch_len;
+
+	/* The list of objects pending a free */
+	struct rcu_head *head_free;
+
+	/* Protect concurrent access to this structure */
+	spinlock_t lock;
+
+	/* The work done to monitor whether objects need free */
+	struct delayed_work monitor_work;
+	bool monitor_todo;
+};
+
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+
+/* Free all heads after a grace period (worker function) */
+static void kfree_rcu_work(struct work_struct *work)
+{
+	unsigned long flags;
+	struct rcu_head *head, *next;
+	struct kfree_rcu_cpu *krc = container_of(to_rcu_work(work),
+					struct kfree_rcu_cpu, rcu_work);
+
+	spin_lock_irqsave(&krc->lock, flags);
+	head = krc->head_free;
+	krc->head_free = NULL;
+	spin_unlock_irqrestore(&krc->lock, flags);
+
+	/* The head must be detached and not referenced from anywhere */
+	for (; head; head = next) {
+		next = head->next;
+		head->next = NULL;
+		/* Could be possible to optimize with kfree_bulk in future */
+		__rcu_reclaim(rcu_state.name, head);
+	}
+}
+
+/*
+ * Schedule the kfree batch RCU work to run after GP.
+ *
+ * Either the batch reached its maximum size, or the monitor's
+ * time reached, either way schedule the batch work.
+ */
+static bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krc)
+{
+	lockdep_assert_held(&krc->lock);
+
+	/*
+	 * Someone already drained, probably before the monitor's worker
+	 * thread ran. Just return to avoid useless work.
+	 */
+	if (!krc->head)
+		return true;
+
+	/*
+	 * If RCU batch work already in progress, we cannot
+	 * queue another one, just refuse the optimization.
+	 */
+	if (krc->head_free)
+		return false;
+
+	krc->head_free = krc->head;
+	krc->head = NULL;
+	krc->kfree_batch_len = 0;
+	INIT_RCU_WORK(&krc->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krc->rcu_work);
+
+	return true;
+}
+
+static void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krc,
+				   unsigned long flags)
+{
+	struct rcu_head *head, *next;
+
+	/* It is time to do bulk reclaim after grace period */
+	krc->monitor_todo = false;
+	if (queue_kfree_rcu_work(krc)) {
+		spin_unlock_irqrestore(&krc->lock, flags);
+		return;
+	}
+
+	/*
+	 * Use non-batch regular call_rcu for kfree_rcu in case things are too
+	 * busy and batching of kfree_rcu could not be used.
+	 */
+	head = krc->head;
+	krc->head = NULL;
+	krc->kfree_batch_len = 0;
+	spin_unlock_irqrestore(&krc->lock, flags);
+
+	for (; head; head = next) {
+		next = head->next;
+		head->next = NULL;
+		__call_rcu(head, head->func, -1, 1);
+	}
+}
+
+/*
+ * If enough time has passed, the kfree batch has to be drained
+ * and the monitor takes care of that.
+ */
+static void kfree_rcu_monitor(struct work_struct *work)
+{
+	bool todo;
+	unsigned long flags;
+	struct kfree_rcu_cpu *krc = container_of(work, struct kfree_rcu_cpu,
+						 monitor_work.work);
+
+	/* It is time to do bulk reclaim after grace period */
+	spin_lock_irqsave(&krc->lock, flags);
+	todo = krc->monitor_todo;
+	krc->monitor_todo = false;
+	if (todo)
+		kfree_rcu_drain_unlock(krc, flags);
+	else
+		spin_unlock_irqrestore(&krc->lock, flags);
+}
+
+static void kfree_rcu_batch(struct rcu_head *head, rcu_callback_t func)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *this_krc;
+	bool monitor_todo;
+
+	local_irq_save(flags);
+	this_krc = this_cpu_ptr(&krc);
+
+	spin_lock(&this_krc->lock);
+
+	/* Queue the kfree but don't yet schedule the batch */
+	head->func = func;
+	head->next = this_krc->head;
+	this_krc->head = head;
+	this_krc->kfree_batch_len++;
+
+	if (this_krc->kfree_batch_len == KFREE_MAX_BATCH) {
+		kfree_rcu_drain_unlock(this_krc, flags);
+		return;
+	}
+
+	/* Maximum has not been reached, schedule monitor for timely drain */
+	monitor_todo = this_krc->monitor_todo;
+	this_krc->monitor_todo = true;
+	spin_unlock(&this_krc->lock);
+
+	if (!monitor_todo) {
+		schedule_delayed_work_on(smp_processor_id(),
+				&this_krc->monitor_work,  KFREE_DRAIN_JIFFIES);
+	}
+	local_irq_restore(flags);
+}
+
 /*
  * Queue an RCU callback for lazy invocation after a grace period.
- * This will likely be later named something like "call_rcu_lazy()",
- * but this change will require some way of tagging the lazy RCU
- * callbacks in the list of pending callbacks. Until then, this
- * function may only be called from __kfree_rcu().
  */
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, -1, 1);
+	kfree_rcu_batch(head, func);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
+/*
+ * The version of kfree_call_rcu that does not do batching of kfree_rcu()
+ * requests. To be used only for performance testing comparisons with
+ * kfree_rcu_batch().
+ */
+void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
+{
+	__call_rcu(head, func, -1, 1);
+}
+
 /*
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.  Later on, this is never the case for PREEMPT.
@@ -3452,6 +3627,17 @@ static void __init rcu_dump_rcu_node_tree(void)
 	pr_cont("\n");
 }
 
+void kfree_rcu_batch_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+	}
+}
+
 struct workqueue_struct *rcu_gp_wq;
 struct workqueue_struct *rcu_par_gp_wq;
 
@@ -3459,6 +3645,8 @@ void __init rcu_init(void)
 {
 	int cpu;
 
+	kfree_rcu_batch_init();
+
 	rcu_early_boot_tests();
 
 	rcu_bootup_announce();
-- 
2.22.0.770.g0f2c4a37fd-goog


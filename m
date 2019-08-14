Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AABC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FDC2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="T8OcqaXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfHNQER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:04:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44239 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfHNQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:04:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so50846208plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZ63yERlWQu6vm3W85uUFuJyauZsWXowKFr0dbCOVlw=;
        b=T8OcqaXL5tn+NAnZmOJP4NEk2sw/3QCi+9SRE9DFOIU5/GQQxOrfENzedDKJEWHZ7D
         r8e2AbQatwRWmhXJHNje8LpQo6F+UvG+Qqw/K1EtjoDnvQ8EjHj7GGMzb0AE1L2fsoeL
         IBDdihMdBwpqmTEmWCklRok2CYVAavej6RJ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZ63yERlWQu6vm3W85uUFuJyauZsWXowKFr0dbCOVlw=;
        b=DENDqu0fL0Wnbs6j90QF5GCSKhu8/Bchp0fh9RQBAIOh9UoPutTgMc94hLud67qvE2
         r5x1qdnF6af325VxMWgk5szRLG64p6OODOlLwkMK2b+F6jFFKeDUuDA6kPcY80a61/QD
         QpR+DxY87fIgSPRw4wHAU8AzmCdZzoRyQb0eK5vcKargF7JMa6CRPLshdhZ+n+4XpRQ9
         z1N/bdkUk7JBl58bSXTbIxugB61bXxJ5LMLT42YxkdD21IE+rt/jbFXM9e/XbY2qQAZj
         NOiS81EZdN1qKMLTy/ZwDIaMn0qo1wePqCnkQTDv1tKYqTjljHXKs6JzWlNBFBLtr+Ut
         qqMQ==
X-Gm-Message-State: APjAAAX2w/W2F3cF609YbA+pLm5CKGUCHh9bkCHX13Rg8zQA8DbhNTeq
        LKhuP1/G07ocLQXo6NZJq8g1DKwjcHo=
X-Google-Smtp-Source: APXvYqyK7vE0QpubhiHO0uZ+EQ+9dgCgCmQi9z1Y0secVNZNgMUHThCWG9QhGe6+9sekTizghXJJZA==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr148891plk.35.1565798655445;
        Wed, 14 Aug 2019 09:04:15 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q69sm369674pjb.0.2019.08.14.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 09:04:14 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kernel-team@android.com, kernel-team@lge.com,
        Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu() batching
Date:   Wed, 14 Aug 2019 12:04:10 -0400
Message-Id: <20190814160411.58591-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a discussion about stability and performance of a system
involving a high rate of kfree_rcu() calls surfaced on the list [1]
which led to another discussion how to prepare for this situation.

This patch adds basic batching support for kfree_rcu(). It is "basic"
because we do none of the slab management, dynamic allocation, code
moving or any of the other things, some of which previous attempts did
[2]. These fancier improvements can be follow-up patches and there are
different ideas being discussed in those regards. This is an effort to
start simple, and build up from there. In the future, an extension to
use kfree_bulk and possibly per-slab batching could be done to further
improve performance due to cache-locality and slab-specific bulk free
optimizations. By using an array of pointers, the worker thread
processing the work would need to read lesser data since it does not
need to deal with large rcu_head(s) any longer.

Torture tests follow in the next patch and show improvements of around
5x reduction in number of  grace periods on a 16 CPU system. More
details and test data are in that patch.

There is an implication with rcu_barrier() with this patch. Since the
kfree_rcu() calls can be batched, and may not be handed yet to the RCU
machinery in fact, the monitor may not have even run yet to do the
queue_rcu_work(), there seems no easy way of implementing rcu_barrier()
to wait for those kfree_rcu()s that are already made. So this means a
kfree_rcu() followed by an rcu_barrier() does not imply that memory will
be freed once rcu_barrier() returns.

Another implication is higher active memory usage (although not
run-away..) until the kfree_rcu() flooding ends, in comparison to
without batching. More details about this are in the second patch which
adds an rcuperf test.

Finally, in the near future we will get rid of kfree_rcu() special casing
within RCU such as in rcu_do_batch and switch everything to just
batching. Currently we don't do that since timer subsystem is not yet up
and we cannot schedule the kfree_rcu() monitor as the timer subsystem's
lock are not initialized. That would also mean getting rid of
kfree_call_rcu_nobatch() entirely.

[1] http://lore.kernel.org/lkml/20190723035725-mutt-send-email-mst@kernel.org
[2] https://lkml.org/lkml/2017/12/19/824

Cc: kernel-team@android.com
Cc: kernel-team@lge.com
Co-developed-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
v3->v4: Some corrections by Paul.
	Used xchg in places to simplify code.

v2->v3: Just some code comment changes thanks to Byungchul.

RFCv1->PATCH v2: Removed limits on the ->head list, just let it grow.
                   Dropped KFREE_MAX_JIFFIES to HZ/50 from HZ/20 to reduce OOM occurrence.
                   Removed sleeps in rcuperf test, just using cond_resched()in loop.
                   Better code comments ;)

 include/linux/rcutiny.h |   5 ++
 include/linux/rcutree.h |   1 +
 kernel/rcu/tree.c       | 194 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 194 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8e727f57d814..383f2481750f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -39,6 +39,11 @@ static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	call_rcu(head, func);
 }
 
+static inline void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 735601ac27d3..7e38b39ec634 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -34,6 +34,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
 
 void synchronize_rcu_expedited(void);
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a14e5fbbea46..1d1847cadea2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2593,17 +2593,185 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+
+/* Maximum number of jiffies to wait before draining a batch. */
+#define KFREE_DRAIN_JIFFIES (HZ / 50)
+
 /*
- * Queue an RCU callback for lazy invocation after a grace period.
- * This will likely be later named something like "call_rcu_lazy()",
- * but this change will require some way of tagging the lazy RCU
- * callbacks in the list of pending callbacks. Until then, this
- * function may only be called from __kfree_rcu().
+ * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
+ * kfree(s) is queued for freeing after a grace period, right away.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+struct kfree_rcu_cpu {
+	/* The rcu_work node for queuing work with queue_rcu_work(). The work
+	 * is done after a grace period.
+	 */
+	struct rcu_work rcu_work;
+
+	/* The list of objects being queued in a batch but are not yet
+	 * scheduled to be freed.
+	 */
+	struct rcu_head *head;
+
+	/* The list of objects that have now left ->head and are queued for
+	 * freeing after a grace period.
+	 */
+	struct rcu_head *head_free;
+
+	/* Protect concurrent access to this structure. */
+	spinlock_t lock;
+
+	/* The delayed work that flushes ->head to ->head_free incase ->head
+	 * within KFREE_DRAIN_JIFFIES. In case flushing cannot be done if RCU
+	 * is busy, ->head just continues to grow and we retry flushing later.
+	 */
+	struct delayed_work monitor_work;
+	bool monitor_todo;	/* Is a delayed work pending execution? */
+};
+
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+
+/*
+ * This function is invoked in workqueue context after a grace period.
+ * It frees all the objects queued on ->head_free.
+ */
+static void kfree_rcu_work(struct work_struct *work)
+{
+	unsigned long flags;
+	struct rcu_head *head, *next;
+	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
+					struct kfree_rcu_cpu, rcu_work);
+
+	spin_lock_irqsave(&krcp->lock, flags);
+	head = krcp->head_free;
+	krcp->head_free = NULL;
+	spin_unlock_irqrestore(&krcp->lock, flags);
+
+	/*
+	 * The head is detached and not referenced from anywhere, so lockless
+	 * access is Ok.
+	 */
+	for (; head; head = next) {
+		next = head->next;
+		/* Could be possible to optimize with kfree_bulk in future */
+		__rcu_reclaim(rcu_state.name, head);
+		cond_resched_tasks_rcu_qs();
+	}
+}
+
+/*
+ * Schedule the kfree batch RCU work to run in workqueue context after a GP.
+ *
+ * This function is invoked by kfree_rcu_monitor() when the KFREE_DRAIN_JIFFIES
+ * timeout has been reached.
+ */
+static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
+{
+	lockdep_assert_held(&krcp->lock);
+
+	/* If a previous RCU batch work is already in progress, we cannot queue
+	 * another one, just refuse the optimization and it will be retried
+	 * again in KFREE_DRAIN_JIFFIES time.
+	 */
+	if (krcp->head_free)
+		return false;
+
+	krcp->head_free = krcp->head;
+	krcp->head = NULL;
+	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krcp->rcu_work);
+
+	return true;
+}
+
+static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
+				   unsigned long flags)
+{
+	/* Flush ->head to ->head_free, all objects on ->head_free will be
+	 * kfree'd after a grace period.
+	 */
+	if (queue_kfree_rcu_work(krcp)) {
+		/* Success! Our job is done here. */
+		spin_unlock_irqrestore(&krcp->lock, flags);
+		return;
+	}
+
+	/* Previous batch that was queued to RCU did not get free yet, let us
+	 * try again soon.
+	 */
+	if (!xchg(&krcp->monitor_todo, true))
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
+/*
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout has elapsed,
+ * and it drains the specified kfree_rcu_cpu structure's ->head list.
+ */
+static void kfree_rcu_monitor(struct work_struct *work)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
+						 monitor_work.work);
+
+	spin_lock_irqsave(&krcp->lock, flags);
+	if (xchg(&krcp->monitor_todo, false))
+		kfree_rcu_drain_unlock(krcp, flags);
+	else
+		spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
+/*
+ * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
+ * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
+ */
+void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
 {
 	__call_rcu(head, func, -1, 1);
 }
+EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
+
+/*
+ * Queue a request for lazy invocation of kfree() after a grace period.
+ *
+ * Each kfree_call_rcu() request is added to a batch. The batch will be drained
+ * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
+ * will be kfree'd in workqueue context. This allows us to:
+ *
+ * 1. Batch requests together to reduce the number of grace periods during
+ * heavy kfree_rcu() load.
+ *
+ * 2. In the future, makes it possible to use kfree_bulk() on a large number of
+ * kfree_rcu() requests thus reducing the per-object overhead of kfree() and
+ * also reducing cache misses.
+ */
+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *krcp;
+
+	/* kfree_call_rcu() batching requires timers to be up. If the scheduler
+	 * is not yet up, just skip batching and do the non-batched version.
+	 */
+	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
+		return kfree_call_rcu_nobatch(head, func);
+
+	head->func = func;
+
+	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
+	krcp = this_cpu_ptr(&krc);
+	spin_lock(&krcp->lock);
+
+	/* Queue the kfree but don't yet schedule the batch. */
+	head->next = krcp->head;
+	krcp->head = head;
+
+	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
+	if (!xchg(&krcp->monitor_todo, true))
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+
+	spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
 /*
@@ -3455,10 +3623,24 @@ static void __init rcu_dump_rcu_node_tree(void)
 struct workqueue_struct *rcu_gp_wq;
 struct workqueue_struct *rcu_par_gp_wq;
 
+static void __init kfree_rcu_batch_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		spin_lock_init(&krcp->lock);
+		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+	}
+}
+
 void __init rcu_init(void)
 {
 	int cpu;
 
+	kfree_rcu_batch_init();
+
 	rcu_early_boot_tests();
 
 	rcu_bootup_announce();
-- 
2.23.0.rc1.153.gdeed80330f-goog

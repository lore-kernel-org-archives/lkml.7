Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D41C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7824B2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpWImdgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLTM4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:56:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32790 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:56:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so1888915lji.0;
        Fri, 20 Dec 2019 04:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6QpQ5ckfYip1RRJdfwhs3rCAiJayS+WAgNGsVaPWR4=;
        b=LpWImdgDqlfEtP0j2v5twFKAnBlmhBHMyQXf8uBGxhTqOhEXmAVM2NQFaN4W6xXWOI
         yz1x45J8N9MyQ/zC9czuiulH1Jsngy3eNlRkcS4uQYEdw0thiOkC+dVCOkG5u6WVFITk
         pRRh+dKtIUHoSdMXVU1o82YeXwqgSGSAgb1OlE5U/sgWIK+QFjq5lvc2htInNM3iXqMn
         QtsOHJEOTMVkkVSO4tXHDgiCFu/8gIdrKGmA1FR5IJZKllu1+2ZpBT+llv9jtgrY/ksT
         Yjp5pYQ+7XT2upWESev41Cv2EOmUGgupj1hPhg1XRoOfsrwJueXaD83WVVCYAg48UChN
         c5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6QpQ5ckfYip1RRJdfwhs3rCAiJayS+WAgNGsVaPWR4=;
        b=ejYV3YL8pl1+j5qwv2cs9ZejPuJdn/BFicCDuMYQF90pTrn3nMZirwnwSc5jaAg2+E
         35ylybpuUH0mouPk4zPOaE8TsLsS7q1y3dJH/GlhmssTp7/dfd8eG56v5b1pX4Wqwm2x
         uC32Jb1t4PqwBdd9wuYlNprYYaC4tB2ZNzNWOrjGw5OlTEaJwxrbK8KHNkwoqIVUZl4b
         T/DEWRTxGT4sbeiLDux3Mo4+h3eRN8rPJNLjJGsHPDvIsaIrYMjhndLFQ39yM6ulnPvj
         JnIZ2Z9/qS9rFOuSfOkYCp3+naIbCey6KrVL/pw71upUjpqeGlIwwkT49/upkCZB56QO
         oS8w==
X-Gm-Message-State: APjAAAXz5QcmygdBXbwosIq7OZVqgfMqd7c28at+jb0eYr2D7ELMb3Yf
        EI7M5jEHmSlDXtp4Y6e8+CpRZro2pZTxuA==
X-Google-Smtp-Source: APXvYqwuTkRD5GVN6imSDVN2RPEOCf0b03VWsxGhomoRRYzWfGx8GRMZS4hSgRzE47foT7/ES4rH4A==
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr9888394ljc.100.1576846591991;
        Fri, 20 Dec 2019 04:56:31 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z7sm4308659lji.30.2019.12.20.04.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 04:56:31 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in kfree_rcu()
Date:   Fri, 20 Dec 2019 13:56:24 +0100
Message-Id: <20191220125624.3953-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree_rcu() logic can be improved further by using kfree_bulk()
interface along with "basic batching support" introduced earlier.

The are at least two advantages of using "bulk" interface:
- in case of large number of kfree_rcu() requests kfree_bulk()
  reduces the per-object overhead caused by calling kfree()
  per-object.

- reduces the number of cache-misses due to "pointer chasing"
  between objects which can be far spread between each other.

This approach defines a new kfree_rcu_bulk_data structure that
stores pointers in an array with a specific size. Number of
entries in that array depends on PAGE_SIZE, i.e. it is based
on the fact that the size of kfree_rcu_bulk_data should not
exceed one page therefore there is such dependency.

Since it deals with "block-chain" technique there is an extra
need in dynamic allocation when a new block is required. Memory
is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
allows to skip direct reclaim under low memory condition to
prevent stalling and fail silently under high memory pressure.

The "emergency path" gets maintained when a system is run out
of memory. In that case objects are linked into regular list
and that is it.

In order to evaluate it, the "rcuperf" was run to analyze how
much memory is consumed and what is kfree_bulk() throughput.

Testing on the Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz 12xCPUs
with below parameters:

CONFIG_SLAB=y
kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1

Total time taken by all kfree'ers: 56828146341 ns, loops: 200000, batches: 2096
Total time taken by all kfree'ers: 57329844331 ns, loops: 200000, batches: 2379

Total time taken by all kfree'ers: 45498404821 ns, loops: 200000, batches: 2271
Total time taken by all kfree'ers: 45313811813 ns, loops: 200000, batches: 2263

rcuperf shows approximately ~21% better throughput(Total time)
in case of using "bulk" interface. The "drain logic" or its RCU
callback does the work faster that leads to better throughput.

During the test an average memory usage(see below run_2) is ~469MB
with "Default" configuration and ~399MB in the "Bulk interface" case.

See below detailed plots of three run:

ftp://vps418301.ovh.net/incoming/rcuperf_mem_usage_run_0.png
ftp://vps418301.ovh.net/incoming/rcuperf_mem_usage_run_1.png
ftp://vps418301.ovh.net/incoming/rcuperf_mem_usage_run_2.png

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 123 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d8e250c8a48f..942a1beb06bb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2655,6 +2655,28 @@ EXPORT_SYMBOL_GPL(call_rcu);
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure should not exceed one page
+ * therefore there is a dependency on PAGE_SIZE.
+ *
+ * To be more specific it is set to half of the PAGE_SIZE.
+ * For example if the PAGE_SIZE is 4096, the record size
+ * is 8, the structure size becomes 2048 thus number of
+ * entries are 254.
+ *
+ * We also can reserve exactly one page for that purpose
+ * and switch to using directly "page allocator" instead.
+ */
+#define KFREE_BULK_MAX_ENTR (((PAGE_SIZE / sizeof(void *)) >> 1) - 2)
+
+struct kfree_rcu_bulk_data {
+	unsigned long nr_records;
+	void *records[KFREE_BULK_MAX_ENTR];
+	struct kfree_rcu_bulk_data *next;
+};
+
 /*
  * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
  * kfree(s) is queued for freeing after a grace period, right away.
@@ -2666,21 +2688,40 @@ struct kfree_rcu_cpu {
 	struct rcu_work rcu_work;
 
 	/* The list of objects being queued in a batch but are not yet
-	 * scheduled to be freed.
+	 * scheduled to be freed. For emergency path only.
 	 */
 	struct rcu_head *head;
 
 	/* The list of objects that have now left ->head and are queued for
-	 * freeing after a grace period.
+	 * freeing after a grace period. For emergency path only.
 	 */
 	struct rcu_head *head_free;
 
+	/*
+	 * The bulk list that keeps pointers in the array of
+	 * specific size for later take over to bhead_free.
+	 */
+	struct kfree_rcu_bulk_data *bhead;
+
+	/*
+	 * The bulk list that is detached from the bhead to
+	 * perform draining using kfree_bulk() interface.
+	 */
+	struct kfree_rcu_bulk_data *bhead_free;
+
+	/*
+	 * Keeps at most one object for late reuse.
+	 */
+	struct kfree_rcu_bulk_data *bcached;
+
 	/* Protect concurrent access to this structure. */
 	spinlock_t lock;
 
-	/* The delayed work that flushes ->head to ->head_free incase ->head
-	 * within KFREE_DRAIN_JIFFIES. In case flushing cannot be done if RCU
-	 * is busy, ->head just continues to grow and we retry flushing later.
+	/*
+	 * The delayed work that flushes ->bhead/head to ->bhead_free/head_free
+	 * incase ->bhead/head within KFREE_DRAIN_JIFFIES. In case flushing cannot
+	 * be done if RCU is busy, ->bhead/head just continues to grow and we retry
+	 * flushing later.
 	 */
 	struct delayed_work monitor_work;
 	bool monitor_todo;      /* Is a delayed work pending execution? */
@@ -2690,27 +2731,44 @@ static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->head_free.
+ * It frees all the objects queued on ->head_free or bhead_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
 	struct rcu_head *head, *next;
+	struct kfree_rcu_bulk_data *bhead, *bnext;
 	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
 											  struct kfree_rcu_cpu, rcu_work);
 
 	spin_lock_irqsave(&krcp->lock, flags);
 	head = krcp->head_free;
 	krcp->head_free = NULL;
+	bhead = krcp->bhead_free;
+	krcp->bhead_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	/*
 	 * The head is detached and not referenced from anywhere, so lockless
 	 * access is Ok.
 	 */
+	for (; bhead; bhead = bnext) {
+		bnext = bhead->next;
+		kfree_bulk(bhead->nr_records, bhead->records);
+
+		if (cmpxchg(&krcp->bcached, NULL, bhead))
+			kfree(bhead);
+
+		cond_resched_tasks_rcu_qs();
+	}
+
+	/*
+	 * Emergency case only. It can happen under low
+	 * memory condition when kmalloc gets failed, so
+	 * the "bulk" path can not be temporary maintained.
+	 */
 	for (; head; head = next) {
 		next = head->next;
-		/* Could be possible to optimize with kfree_bulk in future */
 		__rcu_reclaim(rcu_state.name, head);
 		cond_resched_tasks_rcu_qs();
 	}
@@ -2730,11 +2788,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 	 * another one, just refuse the optimization and it will be retried
 	 * again in KFREE_DRAIN_JIFFIES time.
 	 */
-	if (krcp->head_free)
+	if (krcp->bhead_free || krcp->head_free)
 		return false;
 
 	krcp->head_free = krcp->head;
 	krcp->head = NULL;
+
+	krcp->bhead_free = krcp->bhead;
+	krcp->bhead = NULL;
+
 	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
 	queue_rcu_work(system_wq, &krcp->rcu_work);
 
@@ -2744,8 +2806,9 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 										  unsigned long flags)
 {
-	/* Flush ->head to ->head_free, all objects on ->head_free will be
-	 * kfree'd after a grace period.
+	/*
+	 * Flush ->bhead/head to ->bhead_free/head_free, so all objects
+	 * on ->bhead_free/head_free will be freed after a grace period.
 	 */
 	if (queue_kfree_rcu_work(krcp)) {
 		/* Success! Our job is done here. */
@@ -2763,7 +2826,7 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout has elapsed,
- * and it drains the specified kfree_rcu_cpu structure's ->head list.
+ * and it drains the specified kfree_rcu_cpu structure's ->bhead/head list.
  */
 static void kfree_rcu_monitor(struct work_struct *work)
 {
@@ -2795,17 +2858,15 @@ EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
  * will be kfree'd in workqueue context. This allows us to:
  *
- * 1. Batch requests together to reduce the number of grace periods during
+ * Batch requests together to reduce the number of grace periods during
  * heavy kfree_rcu() load.
- *
- * 2. In the future, makes it possible to use kfree_bulk() on a large number of
- * kfree_rcu() requests thus reducing the per-object overhead of kfree() and
- * also reducing cache misses.
  */
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	struct kfree_rcu_bulk_data *bnode;
+	bool maintain_bulk_list = true;
 
 	/* kfree_call_rcu() batching requires timers to be up. If the scheduler
 	 * is not yet up, just skip batching and do the non-batched version.
@@ -2813,15 +2874,37 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
 		return kfree_call_rcu_nobatch(head, func);
 
-	head->func = func;
-
 	local_irq_save(flags);  /* For safely calling this_cpu_ptr(). */
 	krcp = this_cpu_ptr(&krc);
 	spin_lock(&krcp->lock);
 
+	/* Check if we need a new block. */
+	if (!krcp->bhead ||
+			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
+		bnode = xchg(&krcp->bcached, NULL);
+		if (!bnode)
+			bnode = kmalloc(sizeof(struct kfree_rcu_bulk_data),
+				GFP_NOWAIT | __GFP_NOWARN);
+
+		if (likely(bnode)) {
+			bnode->nr_records = 0;
+			bnode->next = krcp->bhead;
+			krcp->bhead = bnode;
+		} else {
+			/* If gets failed, maintain the list instead. */
+			maintain_bulk_list = false;
+		}
+	}
+
 	/* Queue the kfree but don't yet schedule the batch. */
-	head->next = krcp->head;
-	krcp->head = head;
+	if (likely(maintain_bulk_list)) {
+		krcp->bhead->records[krcp->bhead->nr_records++] =
+			(void *) head - (unsigned long) func;
+	} else {
+		head->func = func;
+		head->next = krcp->head;
+		krcp->head = head;
+	}
 
 	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
 	if (!xchg(&krcp->monitor_todo, true))
-- 
2.20.1


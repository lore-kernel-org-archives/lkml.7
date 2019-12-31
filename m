Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8827FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593BD206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 12:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLg+WlhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLaMW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 07:22:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34187 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 07:22:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so31396569ljg.1;
        Tue, 31 Dec 2019 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMaKh9p/GbIC/usk2NUnus/zNMM2CjwICdHi6ZH4YFQ=;
        b=GLg+WlhB1OempL0PUprVXNtQC0OkogANbCWSOYhxsVbXyQzyiiSniH+OZNUn3MMRWW
         88wxD603liuO0PkKi2X/PXIp7fg29bhPdynd8sCEw3OxgUl47LvijMgMcbe/jgQ9qncp
         Agh+A/ENKeoUFVpaK7LSqeB8m90T/Cl3Bsi6ILM7wjD7z9BAEuSz1RE1Yo+x+EQztmIg
         rs2NHF3SLyufrt9aQ7REixRWqd0JFyxkRgfDuYYBKH+opaL7lJSpf1Zcet8CeblBXXWd
         YhJRIHo/uxmoQYNcyENgpDFq0s6oVT1+5YemuE0iP54fZfYs7VWDK8KCo1yB6WqrqAhD
         tiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMaKh9p/GbIC/usk2NUnus/zNMM2CjwICdHi6ZH4YFQ=;
        b=QREZLgjNxF1GdOwwK3ABw1eTbJCpsjpEIoDXOcqOrzgeYxZT+PM62yFyXv+SnoNxfT
         CMdOFZfvYhyLPh1s1JCq6e7PQEb74V/UHmTcCyHU4rm5W2msxbUN41Rf66a9bDSjR5uc
         M1wo0tJNbPbjxTINCZbZtbkEDuoWd3i2cGS+LEcS0paj+FlRt6pOQpqAfFE3g65N1riY
         9UnmSQJk4QzZuFH8ROTZrw11ZFHD0iVoTyQ2znXkJxtwTErXSBt5V/zDaZ+LXZrjMJT8
         8ql0NHUO6r1LPb+KebKVOXX0zlepFTuwyUdKHxJKfZEkMAyEV4Px8PyC+XA51dDov+AS
         fx3g==
X-Gm-Message-State: APjAAAVOwA1m0vJ5phMgXanw+ayGTclyxqhg07Ac21oJqIGeHXcVxdU9
        eHpC7F5C+GywkchdjN0Z6aGtfNX/luM=
X-Google-Smtp-Source: APXvYqytHK2RHHG8xd83no0un2NtP2G//vjpOI1er1UKRiRBPMVI+E41xeGQeYXUxqQD2kYLV5ZEyQ==
X-Received: by 2002:a2e:8152:: with SMTP id t18mr42396153ljg.255.1577794971742;
        Tue, 31 Dec 2019 04:22:51 -0800 (PST)
Received: from localhost.localdomain ([37.212.207.117])
        by smtp.gmail.com with ESMTPSA id s13sm19487874lje.35.2019.12.31.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 04:22:51 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in kfree_rcu()
Date:   Tue, 31 Dec 2019 13:22:41 +0100
Message-Id: <20191231122241.5702-1-urezki@gmail.com>
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
stores pointers in an array with a specific size. Number of entries
in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
structure to be exactly one page.

Since it deals with "block-chain" technique there is an extra
need in dynamic allocation when a new block is required. Memory
is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
allows to skip direct reclaim under low memory condition to
prevent stalling and fails silently under high memory pressure.

The "emergency path" gets maintained when a system is run out
of memory. In that case objects are linked into regular list
and that is it.

In order to evaluate it, the "rcuperf" was run to analyze how
much memory is consumed and what is kfree_bulk() throughput.

Testing on the HiKey-960, arm64, 8xCPUs with below parameters:

CONFIG_SLAB=y
kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1

102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB

rcuperf shows approximately ~12% better throughput(Total time)
in case of using "bulk" interface. The "drain logic" or its RCU
callback does the work faster that leads to better throughput.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 154 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 130 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 48fba2257748..4ee5c737558b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2754,22 +2754,45 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 2)
+
+/**
+ * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
+ * @nr_records: Number of active pointers in the array
+ * @records: Array of the kfree_rcu() pointers
+ * @next: Next bulk object in the block chain
+ */
+struct kfree_rcu_bulk_data {
+	unsigned long nr_records;
+	void *records[KFREE_BULK_MAX_ENTR];
+	struct kfree_rcu_bulk_data *next;
+};
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @bhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
+	struct kfree_rcu_bulk_data *bhead_free;
 	struct kfree_rcu_cpu *krcp;
 };
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
+ * @bcached: Keeps at most one object for later reuse when build chain blocks
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2783,6 +2806,8 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
+	struct kfree_rcu_bulk_data *bhead;
+	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -2800,6 +2825,7 @@ static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
 	struct rcu_head *head, *next;
+	struct kfree_rcu_bulk_data *bhead, *bnext;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
 
@@ -2809,22 +2835,39 @@ static void kfree_rcu_work(struct work_struct *work)
 	spin_lock_irqsave(&krcp->lock, flags);
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+	bhead = krwp->bhead_free;
+	krwp->bhead_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
-	// List "head" is now private, so traverse locklessly.
+	/* List "bhead" is now private, so traverse locklessly. */
+	for (; bhead; bhead = bnext) {
+		bnext = bhead->next;
+
+		rcu_lock_acquire(&rcu_callback_map);
+		kfree_bulk(bhead->nr_records, bhead->records);
+		rcu_lock_release(&rcu_callback_map);
+
+		if (cmpxchg(&krcp->bcached, NULL, bhead))
+			free_page((unsigned long) bhead);
+
+		cond_resched_tasks_rcu_qs();
+	}
+
+	/*
+	 * Emergency case only. It can happen under low memory
+	 * condition when an allocation gets failed, so the "bulk"
+	 * path can not be temporary maintained.
+	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
 
 		next = head->next;
-		// Potentially optimize with kfree_bulk in future.
 		debug_rcu_head_unqueue(head);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
-			/* Could be optimized with kfree_bulk() in future. */
+		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
 			kfree((void *)head - offset);
-		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -2839,26 +2882,45 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	struct kfree_rcu_cpu_work *krwp;
+	bool queued = false;
 	int i;
-	struct kfree_rcu_cpu_work *krwp = NULL;
 
 	lockdep_assert_held(&krcp->lock);
-	for (i = 0; i < KFREE_N_BATCHES; i++)
-		if (!krcp->krw_arr[i].head_free) {
-			krwp = &(krcp->krw_arr[i]);
-			break;
-		}
 
-	// If a previous RCU batch is in progress, we cannot immediately
-	// queue another one, so return false to tell caller to retry.
-	if (!krwp)
-		return false;
+	for (i = 0; i < KFREE_N_BATCHES; i++) {
+		krwp = &(krcp->krw_arr[i]);
 
-	krwp->head_free = krcp->head;
-	krcp->head = NULL;
-	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krwp->rcu_work);
-	return true;
+		/*
+		 * Try to detach bhead or head and attach it over any
+		 * available corresponding free channel. It can be that
+		 * a previous RCU batch is in progress, it means that
+		 * immediately to queue another one is not possible so
+		 * return false to tell caller to retry.
+		 */
+		if ((krcp->bhead && !krwp->bhead_free) ||
+				(krcp->head && !krwp->head_free)) {
+			if (!krwp->bhead_free) {
+				krwp->bhead_free = krcp->bhead;
+				krcp->bhead = NULL;
+			}
+
+			if (!krwp->head_free) {
+				krwp->head_free = krcp->head;
+				krcp->head = NULL;
+			}
+
+			/*
+			 * The work can already be queued. If so, it means that
+			 * within a short time, second, either head or bhead has
+			 * been detached as well.
+			 */
+			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queued = true;
+		}
+	}
+
+	return queued;
 }
 
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
@@ -2895,6 +2957,39 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+static inline bool
+kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+{
+	struct kfree_rcu_bulk_data *bnode;
+
+	if (unlikely(!krcp->initialized))
+		return false;
+
+	lockdep_assert_held(&krcp->lock);
+
+	/* Check if a new block is required. */
+	if (!krcp->bhead ||
+			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
+		bnode = xchg(&krcp->bcached, NULL);
+		if (!bnode)
+			bnode = (struct kfree_rcu_bulk_data *)
+				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+		/* No cache or an allocation got failed. */
+		if (unlikely(!bnode))
+			return false;
+
+		/* Initialize the new block. */
+		bnode->nr_records = 0;
+		bnode->next = krcp->bhead;
+		krcp->bhead = bnode;
+	}
+
+	/* Finally insert. */
+	krcp->bhead->records[krcp->bhead->nr_records++] = ptr;
+	return true;
+}
+
 /*
  * Queue a request for lazy invocation of kfree() after a grace period.
  *
@@ -2926,9 +3021,17 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			  __func__, head);
 		goto unlock_return;
 	}
-	head->func = func;
-	head->next = krcp->head;
-	krcp->head = head;
+
+	/*
+	 * Under high memory pressure GFP_NOWAIT can fail,
+	 * in that case the emergency path is maintained.
+	 */
+	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp,
+			(void *) head - (unsigned long) func))) {
+		head->func = func;
+		head->next = krcp->head;
+		krcp->head = head;
+	}
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
@@ -3834,8 +3937,11 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_init(&krcp->lock);
-		for (i = 0; i < KFREE_N_BATCHES; i++)
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
+		}
+
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
-- 
2.20.1


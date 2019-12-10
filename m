Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B3BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B722071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951125;
	bh=/LfJ179iSRjX9U5OQ1imnIbhgs8AjgLPRCPfNeJe4O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mORlhISEV7GIT8Xf2wGan5jQgEyurTNaXNgPo0PiWE4dUTGloPxB9VJ6AOAfN40t6
	 +C9huQNodOFWl8bcmjQ91BxKPAx/AGZmxkeivUPpEMLhBqXu2PMDSpDMYBSVGykJWe
	 dY8e5NCqsRWNoJnxP/0mmc8rTdi8u3TEBD63SwzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfLJEMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:12:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfLJELx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:11:53 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE8920838;
        Tue, 10 Dec 2019 04:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951111;
        bh=/LfJ179iSRjX9U5OQ1imnIbhgs8AjgLPRCPfNeJe4O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6oDfv4DDjy+HMl4HACBFut/FGG/3XIpMspG8e9Ibq951xIwie7Y4+UPD4r3XjxST
         LZoVAJvqvVbANuKzy2m5ifpMPw3JWNs6rDTjui9JHSqMXgTsBTP4mBOsgnlasX2QYu
         fFwdyK97mCH9WBanYKHRbOOpzpT9M6BS2BlYa+7U=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/7] rcu: Add multiple in-flight batches of kfree_rcu() work
Date:   Mon,  9 Dec 2019 20:11:44 -0800
Message-Id: <20191210041147.3181-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041118.GA3115@paulmck-ThinkPad-P72>
References: <20191210041118.GA3115@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

During testing, it was observed that amount of memory consumed due
kfree_rcu() batching is 300-400MB. Previously we had only a single
head_free pointer pointing to the list of rcu_head(s) that are to be
freed after a grace period. Until this list is drained, we cannot queue
any more objects on it since such objects may not be ready to be
reclaimed when the worker thread eventually gets to drainin g the
head_free list.

We can do better by maintaining multiple lists as done by this patch.
Testing shows that memory consumption came down by around 100-150MB with
just adding another list. Adding more than 1 additional list did not
show any improvement.

Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Code style and initialization handling. ]
[ paulmck: Fix field name, reported by kbuild test robot <lkp@intel.com>. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6106b9e..a40fd58 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2686,12 +2686,25 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_N_BATCHES 2
 
 /**
- * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
+ * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @krcp: Pointer to @kfree_rcu_cpu structure
+ */
+
+struct kfree_rcu_cpu_work {
+	struct rcu_work rcu_work;
+	struct rcu_head *head_free;
+	struct kfree_rcu_cpu *krcp;
+};
+
+/**
+ * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
- * @head_free: List of kfree_rcu() objects already waiting for a grace period
+ * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
@@ -2703,9 +2716,8 @@ EXPORT_SYMBOL_GPL(call_rcu);
  * the interactions with the slab allocators.
  */
 struct kfree_rcu_cpu {
-	struct rcu_work rcu_work;
 	struct rcu_head *head;
-	struct rcu_head *head_free;
+	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
@@ -2723,11 +2735,14 @@ static void kfree_rcu_work(struct work_struct *work)
 	unsigned long flags;
 	struct rcu_head *head, *next;
 	struct kfree_rcu_cpu *krcp;
+	struct kfree_rcu_cpu_work *krwp;
 
-	krcp = container_of(to_rcu_work(work), struct kfree_rcu_cpu, rcu_work);
+	krwp = container_of(to_rcu_work(work),
+			    struct kfree_rcu_cpu_work, rcu_work);
+	krcp = krwp->krcp;
 	spin_lock_irqsave(&krcp->lock, flags);
-	head = krcp->head_free;
-	krcp->head_free = NULL;
+	head = krwp->head_free;
+	krwp->head_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// List "head" is now private, so traverse locklessly.
@@ -2747,17 +2762,25 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	int i;
+	struct kfree_rcu_cpu_work *krwp = NULL;
+
 	lockdep_assert_held(&krcp->lock);
+	for (i = 0; i < KFREE_N_BATCHES; i++)
+		if (!krcp->krw_arr[i].head_free) {
+			krwp = &(krcp->krw_arr[i]);
+			break;
+		}
 
 	// If a previous RCU batch is in progress, we cannot immediately
 	// queue another one, so return false to tell caller to retry.
-	if (krcp->head_free)
+	if (!krwp)
 		return false;
 
-	krcp->head_free = krcp->head;
+	krwp->head_free = krcp->head;
 	krcp->head = NULL;
-	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krcp->rcu_work);
+	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krwp->rcu_work);
 	return true;
 }
 
@@ -2863,7 +2886,8 @@ void __init kfree_rcu_scheduler_running(void)
 			continue;
 		}
 		krcp->monitor_todo = true;
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		schedule_delayed_work_on(cpu, &krcp->monitor_work,
+					 KFREE_DRAIN_JIFFIES);
 		spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
@@ -3732,11 +3756,14 @@ struct workqueue_struct *rcu_par_gp_wq;
 static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
+	int i;
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_init(&krcp->lock);
+		for (i = 0; i < KFREE_N_BATCHES; i++)
+			krcp->krw_arr[i].krcp = krcp;
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
-- 
2.9.5


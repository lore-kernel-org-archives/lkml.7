Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA21C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DE52189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GBbT5UQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfH1OKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:10:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46398 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfH1OKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:10:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so1522559pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZRhNAxweazD8NBV7eTpA6CYJ/gd+z7Ql9WdGyX+FwE=;
        b=GBbT5UQ7j3ObgzNNU7cgMooQCCCx3dRxBHnZqv1rFtHUA2POQnoDDQsvAbZyCl/cwf
         SJVF1fxU7Fh/6Jci262clcMHzRVM+GP2ao39pPIEJrIcw/mDLPyMyRd4+66KT2/3A9Sy
         PRos7CgZ5HzSpKREFBlGsJooDNCVvYNec7KlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZRhNAxweazD8NBV7eTpA6CYJ/gd+z7Ql9WdGyX+FwE=;
        b=kohvujtrnN1ZTJG1rtie7glMQe4jQxYPuKymIVjH7XFfAkTjCeoSrVhFzl6Mt+nl/m
         L1lmG6+zaOzz5OKPLkRRoWhpAI4FdXuKCtQ37xKRqxkQVfDBHZcEZCPCD/KBs4Ui57h3
         c/tZ6DEdhglLVh4Ie+NYvNFpPRp2EDIo33B4JYOaDCu1f5WAe2/ZN59JnHv5I7E+NRhW
         lUSMAxHphvcuNtQ3qv+1lm3VZafkxKRMel9LELirn14SHS2ST73ABSMBRnrph+j7gfzH
         z1LShykSryndwF6zu+0MTs4yQ3u2aU4dSgwRhHSlDHyVUh+u9Ns9yscLvqwdeZwcrtTd
         Ij0A==
X-Gm-Message-State: APjAAAU0RP+fK4YW5DfB244Hwt0N2iJqXaQBknoI8M4VAB3RHDWa3+kI
        wXK3xqrHCk5R8XD4ta5juvyCxi709t8=
X-Google-Smtp-Source: APXvYqzvdFe17PVHbUCFnJwUB7HFOOAdpLphkVC6hDocrD+EALSi3m1Fl5NCIiZY36dfgBic1u3gug==
X-Received: by 2002:a17:90a:326e:: with SMTP id k101mr4660392pjb.15.1567001399024;
        Wed, 28 Aug 2019 07:09:59 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w2sm4550209pjr.27.2019.08.28.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 07:09:58 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: [PATCH v2] rcu/tree: Add multiple in-flight batches of kfree_rcu work
Date:   Wed, 28 Aug 2019 10:09:52 -0400
Message-Id: <20190828140952.258739-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <5d657e35.1c69fb81.54250.01de@mx.google.com>
References: <5d657e35.1c69fb81.54250.01de@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/rcu/tree.c | 61 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4f7c3096d786..5bf8f7e793ea 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2688,28 +2688,37 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_N_BATCHES 2
+
+struct kfree_rcu_work {
+	/* The rcu_work node for queuing work with queue_rcu_work(). The work
+	 * is done after a grace period.
+	 */
+	struct rcu_work rcu_work;
+
+	/* The list of objects that have now left ->head and are queued for
+	 * freeing after a grace period.
+	 */
+	struct rcu_head *head_free;
+
+	struct kfree_rcu_cpu *krcp;
+};
 
 /*
  * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
  * kfree(s) is queued for freeing after a grace period, right away.
  */
 struct kfree_rcu_cpu {
-	/* The rcu_work node for queuing work with queue_rcu_work(). The work
-	 * is done after a grace period.
-	 */
-	struct rcu_work rcu_work;
 
 	/* The list of objects being queued in a batch but are not yet
 	 * scheduled to be freed.
 	 */
 	struct rcu_head *head;
 
-	/* The list of objects that have now left ->head and are queued for
-	 * freeing after a grace period.
-	 */
-	struct rcu_head *head_free;
+	/* Pointer to the per-cpu array of kfree_rcu_work structures */
+	struct kfree_rcu_work krw_arr[KFREE_N_BATCHES];
 
-	/* Protect concurrent access to this structure. */
+	/* Protect concurrent access to this structure and kfree_rcu_work. */
 	spinlock_t lock;
 
 	/* The delayed work that flushes ->head to ->head_free incase ->head
@@ -2730,12 +2739,14 @@ static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
 	struct rcu_head *head, *next;
-	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
-					struct kfree_rcu_cpu, rcu_work);
+	struct kfree_rcu_work *krwp = container_of(to_rcu_work(work),
+					struct kfree_rcu_work, rcu_work);
+	struct kfree_rcu_cpu *krcp;
+
+	krcp = krwp->krcp;
 
 	spin_lock_irqsave(&krcp->lock, flags);
-	head = krcp->head_free;
-	krcp->head_free = NULL;
+	head = xchg(&krwp->head_free, NULL);
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	/*
@@ -2758,19 +2769,28 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	int i = 0;
+	struct kfree_rcu_work *krwp = NULL;
+
 	lockdep_assert_held(&krcp->lock);
+	while (i < KFREE_N_BATCHES) {
+		if (!krcp->krw_arr[i].head_free) {
+			krwp = &(krcp->krw_arr[i]);
+			break;
+		}
+		i++;
+	}
 
-	/* If a previous RCU batch work is already in progress, we cannot queue
+	/* If both RCU batches are already in progress, we cannot queue
 	 * another one, just refuse the optimization and it will be retried
 	 * again in KFREE_DRAIN_JIFFIES time.
 	 */
-	if (krcp->head_free)
+	if (!krwp)
 		return false;
 
-	krcp->head_free = krcp->head;
-	krcp->head = NULL;
-	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krcp->rcu_work);
+	krwp->head_free = xchg(&krcp->head, NULL);
+	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krwp->rcu_work);
 
 	return true;
 }
@@ -3736,8 +3756,11 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+		int i = KFREE_N_BATCHES;
 
 		spin_lock_init(&krcp->lock);
+		while (i--)
+			krcp->krw_arr[i].krcp = krcp;
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 	}
 }
-- 
2.23.0.187.g17f5b7556c-goog


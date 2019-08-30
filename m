Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C17CC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253C62342C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jy+2e+Dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfH3QhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:37:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35321 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfH3Qgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:36:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so3606468plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRRAKHP+TeMLOfdEkPz78mE6/XzzXHbplfWwmAEFQbU=;
        b=jy+2e+DnlFE70yobG3oJBSNjdOuxGh4bVEd8HSv/vzLRZXIwk0wFhKeCkxjeb0Y+Mm
         yAidZofNWg+5XRfi4ZxnorMyJxqWltlDaSqykXDT9X3bEvSxRrzOvwe3Wvi55Dq4WxsW
         XJ3BYWdHEseerTrYcvfJNj/z1WNYqw6FJrDUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRRAKHP+TeMLOfdEkPz78mE6/XzzXHbplfWwmAEFQbU=;
        b=m0XCKwBappgn+SAM5KGP1H/MW85y1HX/uVX4g2ps/TGogs1YnepHwA/K8mUmT8PSFD
         wBdlQQtfr5f8rgEgYTo8vznp6zM/8A14UyXgGMxt4ymc1SbyRaCbQpasumnoXaN8ZAaE
         NwPNPW6Sen92ZCJw3vn3hIuCik8l/R993zpq4+2z0Z71q/KFfo7qj3pez/URds0B2Hz8
         ES0g9wQ8x03zGmhs6C5qLWh2zhCEyBQoIx5ohmfEvFyQrxgpBFPZHsvnRzQ9aBz1zOxF
         rvVlp4NhIk+dlwT9VphVfrTVGg4b8GRFcdwuKYY8DRr2cSQimL0GifHphuy7QvELOWyF
         WRag==
X-Gm-Message-State: APjAAAXmUE0hcL9u6Jv+ZPcd/5dnW9E/wB1b9GrbPUl1lQHitsg3oFKY
        9wDAznGsSj6D/JCHaCJYyCRXWRNHTH8=
X-Google-Smtp-Source: APXvYqwlzGRPt+1qTfJqIXlH0pS7PJ/6oPF+xP9srHo4iFsnnCfBBtvDBJy+ekt+tKk8OddEXP1kqA==
X-Received: by 2002:a17:902:7006:: with SMTP id y6mr12847878plk.320.1567183006160;
        Fri, 30 Aug 2019 09:36:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j74sm6114080pje.14.2019.08.30.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:36:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 -rcu dev 2/5] rcu/tree: Add multiple in-flight batches of kfree_rcu work
Date:   Fri, 30 Aug 2019 12:36:30 -0400
Message-Id: <20190830163633.104099-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830163633.104099-1-joel@joelfernandes.org>
References: <20190830163633.104099-1-joel@joelfernandes.org>
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
 kernel/rcu/tree.c | 80 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 68ebf0eb64c8..2e1772469de9 100644
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
@@ -2717,7 +2726,7 @@ struct kfree_rcu_cpu {
 	 * is busy, ->head just continues to grow and we retry flushing later.
 	 */
 	struct delayed_work monitor_work;
-	int monitor_todo;	/* Is a delayed work pending execution? */
+	bool monitor_todo;	/* Is a delayed work pending execution? */
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
@@ -2730,12 +2739,15 @@ static void kfree_rcu_work(struct work_struct *work)
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
+	head = krwp->head_free;
+	krwp->head_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	/*
@@ -2758,19 +2770,30 @@ static void kfree_rcu_work(struct work_struct *work)
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
+	/*
+	 * If both RCU batches are already in progress, we cannot queue
 	 * another one, just refuse the optimization and it will be retried
 	 * again in KFREE_DRAIN_JIFFIES time.
 	 */
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
@@ -2778,7 +2801,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 				   unsigned long flags)
 {
-	/* Flush ->head to ->head_free, all objects on ->head_free will be
+	/*
+	 * Flush ->head to ->head_free, all objects on ->head_free will be
 	 * kfree'd after a grace period.
 	 */
 	if (queue_kfree_rcu_work(krcp)) {
@@ -2787,11 +2811,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 		return;
 	}
 
-	/* Previous batch that was queued to RCU did not get free yet, let us
+	/*
+	 * Previous batch that was queued to RCU did not get free yet, let us
 	 * try again soon.
 	 */
-	if (!xchg(&krcp->monitor_todo, true))
+	if (!krcp->monitor_todo) {
+		krcp->monitor_todo = true;
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	}
 	spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
@@ -2806,10 +2833,12 @@ static void kfree_rcu_monitor(struct work_struct *work)
 						 monitor_work.work);
 
 	spin_lock_irqsave(&krcp->lock, flags);
-	if (xchg(&krcp->monitor_todo, false))
+	if (krcp->monitor_todo) {
+		krcp->monitor_todo = false;
 		kfree_rcu_drain_unlock(krcp, flags);
-	else
+	} else {
 		spin_unlock_irqrestore(&krcp->lock, flags);
+	}
 }
 
 /*
@@ -3736,8 +3765,11 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+		int i;
 
 		spin_lock_init(&krcp->lock);
+		for (i = 0; i < KFREE_N_BATCHES; i++)
+			krcp->krw_arr[i].krcp = krcp;
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 	}
 }
-- 
2.23.0.187.g17f5b7556c-goog


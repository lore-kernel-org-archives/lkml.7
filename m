Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCD3C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724A22342C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yZYEjORQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfH3Qg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:36:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45812 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfH3Qgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:36:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so4950975pfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TViz/uEfbOEpUzpTGIb4VAmFAq4QMSx9O81NrsKCuu4=;
        b=yZYEjORQokx0B2GT1yT24lWUwOnxfga4krCgK+5Q4NbTIhprOYfyP9pUR0j4mqLxZK
         VrmPj33kz6NcKz4cZ4D7752udnhATqSZRnndrEhCzKgni4d4u5ukv/1A1iyYnB+QX0oA
         HfLFNkPdbBhYcdJwPwN1qwlT1PhB4SzhJiJrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TViz/uEfbOEpUzpTGIb4VAmFAq4QMSx9O81NrsKCuu4=;
        b=ccS1hkAcm9QX6dzE3dAz9sjK+vRYWe9C3Zfeo2kg1gWD3o6jvLDWGilHPvz15U8CQL
         nMKfLoFE6Lw6e60OzNxA2CEgiViMdtZZ6M4Jd9h6Jy9XBpKr0qtKLWyRvcGZVN+ejCGC
         df7ByT6BvUMNs4IcCCqUOAjGrnRh6jI1y1sL/tZGQEmDwOe0YnZn9EPB18llOa2pqyFt
         hHbx5oeFGVdzUxSjFKCpVjgT+w7DncM2W2btwCFyCsMLTwDnZ5Yz8xE2aPuxw6VPvDts
         dz/LCLRLTwXBPpvO3WSNRvHpV/LKTSI8iTFyzGKPZDJT4t6q3VbyGOdjlgda4KAqyGEV
         TKCQ==
X-Gm-Message-State: APjAAAUkvwOCCdtTce7bPHHYzZhsLdkDxDBJVXxteQRkdgGIxutiAwFw
        RONbAGrsuvqO+XipzRQ2W7gg4IFBDSQ=
X-Google-Smtp-Source: APXvYqzMFutjCIXOhhdAJ0KrwGE/+N3XG40IdxseUnqxCDZz1f2DOhSYq+Jce275lA9FhpNDRHxnkg==
X-Received: by 2002:a62:38d7:: with SMTP id f206mr19357850pfa.102.1567183012573;
        Fri, 30 Aug 2019 09:36:52 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j74sm6114080pje.14.2019.08.30.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:36:51 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 -rcu dev 5/5] rcu: Remove kfree_call_rcu_nobatch()
Date:   Fri, 30 Aug 2019 12:36:33 -0400
Message-Id: <20190830163633.104099-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830163633.104099-1-joel@joelfernandes.org>
References: <20190830163633.104099-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that kfree_rcu() special casing have been removed from tree RCU,
remove kfree_call_rcu_nobatch() since it is not needed.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 ---
 include/linux/rcutiny.h                       |  5 ---
 include/linux/rcutree.h                       |  1 -
 kernel/rcu/rcuperf.c                          | 10 +-----
 kernel/rcu/tree.c                             | 34 ++++++++-----------
 5 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 24fe8aefb12c..56be0e30100b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3909,10 +3909,6 @@
 			Number of loops doing rcuperf.kfree_alloc_num number
 			of allocations and frees.
 
-	rcuperf.kfree_no_batch= [KNL]
-			Use the non-batching (less efficient) version of kfree_rcu().
-			This is useful for comparing with the batched version.
-
 	rcuperf.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N, where N is the number of CPUs.  A value
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index b7607e2667ae..37b6f0c2b79d 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -39,11 +39,6 @@ static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	call_rcu(head, func);
 }
 
-static inline void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 961b7e05d141..0b68aa952f8b 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -34,7 +34,6 @@ static inline void rcu_virt_note_context_switch(int cpu)
 
 void synchronize_rcu_expedited(void);
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
-void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index c1e25fd10f2a..da94b89cd531 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -593,7 +593,6 @@ rcu_perf_shutdown(void *arg)
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
 torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
-torture_param(int, kfree_no_batch, 0, "Use the non-batching (slower) version of kfree_rcu().");
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
@@ -632,14 +631,7 @@ kfree_perf_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			if (!kfree_no_batch) {
-				kfree_rcu(alloc_ptr, rh);
-			} else {
-				rcu_callback_t cb;
-
-				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
-				kfree_call_rcu_nobatch(&(alloc_ptr->rh), cb);
-			}
+			kfree_rcu(alloc_ptr, rh);
 		}
 
 		cond_resched();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cd7bbc74ae20..72550343843f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2770,8 +2770,10 @@ static void kfree_rcu_work(struct work_struct *work)
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
-		/* Could be possible to optimize with kfree_bulk in future */
-		kfree((void *)head - offset);
+		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
+			/* Could be optimized with kfree_bulk() in future. */
+			kfree((void *)head - offset);
+		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -2857,16 +2859,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	}
 }
 
-/*
- * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
- * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
- */
-void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func);
-}
-EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
-
 /*
  * Queue a request for lazy invocation of kfree() after a grace period.
  *
@@ -2886,12 +2878,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 
-	/* kfree_call_rcu() batching requires timers to be up. If the scheduler
-	 * is not yet up, just skip batching and do the non-batched version.
-	 */
-	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
-		return kfree_call_rcu_nobatch(head, func);
-
 	if (debug_rcu_head_queue(head)) {
 		/* Probable double kfree_rcu() */
 		WARN_ONCE(1, "kfree_call_rcu(): Double-freed call. rcu_head %p\n",
@@ -2910,8 +2896,16 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	krcp->head = head;
 
 	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
-	if (!xchg(&krcp->monitor_todo, true))
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+	if (!krcp->monitor_todo) {
+		krcp->monitor_todo = true;
+		/* Scheduling the monitor requires scheduler/timers to be up,
+		 * if it is not, just skip it. An eventual kfree_rcu() will
+		 * kick it again.
+		 */
+		if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING) {
+			schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+		}
+	}
 
 	spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
-- 
2.23.0.187.g17f5b7556c-goog


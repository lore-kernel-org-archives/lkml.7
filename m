Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5449C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770512071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951128;
	bh=OVD6KEtAOYqNiZX6otgsMUJ/x4w6OflIm8Y3UChCx9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GLGYP/vGvWMSkOo/Qly1UrD8C62XbF6Ng7yshCH6abeDjL5Q+8njMlG6sdygMarVv
	 EgB8i2wPGo7w9IJdGs44hCyfHYj1pQbdjvj5nHO8X9DDspGNNNrguEu6urNlYRM3L+
	 zwcMmvDDmkzgKVW6alJkIXovBAU1lqSFlDCAtPOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfLJEL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:11:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfLJELy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:11:54 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D13222C4;
        Tue, 10 Dec 2019 04:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951113;
        bh=OVD6KEtAOYqNiZX6otgsMUJ/x4w6OflIm8Y3UChCx9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2+N5DrRKV5FcDLB5/NRy4/G1wtzG5u66XVwwmhcifIXjTIZwPrOH1m7gHPY1npJT
         HYa4mZDX71dN2OT6z7u2L0ub4peI+tsqgzWKqZGJKYVwbVnoESlxKQ6gHXFXcogM1H
         f8VQcO41MKJIm4yKnzColDnRU68r7TcDHVZFZ4Fk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 7/7] rcu: Remove kfree_call_rcu_nobatch()
Date:   Mon,  9 Dec 2019 20:11:47 -0800
Message-Id: <20191210041147.3181-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041118.GA3115@paulmck-ThinkPad-P72>
References: <20191210041118.GA3115@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Now that the kfree_rcu() special-casing has been removed from tree RCU,
this commit removes kfree_call_rcu_nobatch() since it is no longer needed.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ----
 include/linux/rcutiny.h                         |  5 -----
 include/linux/rcutree.h                         |  1 -
 kernel/rcu/rcuperf.c                            | 10 +---------
 kernel/rcu/tree.c                               | 18 ++++--------------
 5 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3ce270b..ed83d6d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3991,10 +3991,6 @@
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
index 1bd166a..b2b2dc9 100644
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
index 6a65d3a..2f787b9 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -34,7 +34,6 @@ static inline void rcu_virt_note_context_switch(int cpu)
 
 void synchronize_rcu_expedited(void);
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
-void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index c1e25fd..da94b89 100644
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
index a8dd612..31d2d92 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2763,8 +2763,10 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -2836,16 +2838,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 }
 
 /*
- * This version of kfree_call_rcu does not do batching of kfree_rcu() requests.
- * Used only by rcuperf torture test for comparison with kfree_rcu_batch().
- */
-void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func);
-}
-EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
-
-/*
  * Queue a request for lazy invocation of kfree() after a grace period.
  *
  * Each kfree_call_rcu() request is added to a batch. The batch will be drained
@@ -2864,8 +2856,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 
-	head->func = func;
-
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
-- 
2.9.5


Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3EAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7201C2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951122;
	bh=Kgc8JIPZ27JqCFdU4cpKDb8I63aqqJjeiyEY9eoHPf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NQrzavxcE+w0u8KBKRmYPoxz693XzRGEZcpgSgAiGt9Sg3+5nKRJVJprHetU9V4T7
	 HsHqDFB7yJe36COwNrh8I5RqxWxeYzkbUk+e9RH0fW6uXZXa0W/UHKZCObsb7TejgZ
	 queHXHeaVzC5rTUNOIOuZKcYKvhJ1BnNcew6Tt58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJEMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfLJELy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:11:54 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A1421556;
        Tue, 10 Dec 2019 04:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951113;
        bh=Kgc8JIPZ27JqCFdU4cpKDb8I63aqqJjeiyEY9eoHPf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOe0wAKkrYh/JaixJTcr3g+M8sA6KzeD3XNjs6iWsIsHJJJJXCSbyPrkB0WSnYA8Z
         a1Np6TlzREkg0u00WW8/QJHqX5GBSlUr4ZmOIesenPapUHDTm12fhit+krMZrpqJFu
         +8Zj4Vb6fmMd8kr1JClfTxIvvO4brRrlI8JRTyt4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/7] rcu: Remove kfree_rcu() special casing and lazy-callback handling
Date:   Mon,  9 Dec 2019 20:11:46 -0800
Message-Id: <20191210041147.3181-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041118.GA3115@paulmck-ThinkPad-P72>
References: <20191210041118.GA3115@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit removes kfree_rcu() special-casing and the lazy-callback
handling from Tree RCU.  It moves some of this special casing to Tiny RCU,
the removal of which will be the subject of later commits.

This results in a nice negative delta.

Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Add slab.h #include, thanks to kbuild test robot <lkp@intel.com>. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.txt | 11 +++-------
 include/linux/rcu_segcblist.h   |  2 --
 include/trace/events/rcu.h      | 32 +++++++++++----------------
 kernel/rcu/rcu.h                | 27 -----------------------
 kernel/rcu/rcu_segcblist.c      | 25 +++------------------
 kernel/rcu/rcu_segcblist.h      | 25 ++-------------------
 kernel/rcu/srcutree.c           |  4 ++--
 kernel/rcu/tiny.c               | 28 +++++++++++++++++++++++-
 kernel/rcu/tree.c               | 40 +++++++++++++++++++++++-----------
 kernel/rcu/tree.h               |  1 -
 kernel/rcu/tree_plugin.h        | 48 ++++++++++-------------------------------
 kernel/rcu/tree_stall.h         |  6 ++----
 12 files changed, 90 insertions(+), 159 deletions(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index f48f462..a360a87 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -225,18 +225,13 @@ an estimate of the total number of RCU callbacks queued across all CPUs
 In kernels with CONFIG_RCU_FAST_NO_HZ, more information is printed
 for each CPU:
 
-	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 Nonlazy posted: ..D
+	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 dyntick_enabled: 1
 
 The "last_accelerate:" prints the low-order 16 bits (in hex) of the
 jiffies counter when this CPU last invoked rcu_try_advance_all_cbs()
 from rcu_needs_cpu() or last invoked rcu_accelerate_cbs() from
-rcu_prepare_for_idle().  The "Nonlazy posted:" indicates lazy-callback
-status, so that an "l" indicates that all callbacks were lazy at the start
-of the last idle period and an "L" indicates that there are currently
-no non-lazy callbacks (in both cases, "." is printed otherwise, as
-shown above) and "D" indicates that dyntick-idle processing is enabled
-("." is printed otherwise, for example, if disabled via the "nohz="
-kernel boot parameter).
+rcu_prepare_for_idle(). "dyntick_enabled: 1" indicates that dyntick-idle
+processing is enabled.
 
 If the grace period ends just as the stall warning starts printing,
 there will be a spurious stall-warning message, which will include
diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 6467590..b36afe7 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -22,7 +22,6 @@ struct rcu_cblist {
 	struct rcu_head *head;
 	struct rcu_head **tail;
 	long len;
-	long len_lazy;
 };
 
 #define RCU_CBLIST_INITIALIZER(n) { .head = NULL, .tail = &n.head }
@@ -73,7 +72,6 @@ struct rcu_segcblist {
 #else
 	long len;
 #endif
-	long len_lazy;
 	u8 enabled;
 	u8 offloaded;
 };
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 6612260..4ab16fc 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -481,16 +481,14 @@ TRACE_EVENT_RCU(rcu_dyntick,
  */
 TRACE_EVENT_RCU(rcu_callback,
 
-	TP_PROTO(const char *rcuname, struct rcu_head *rhp, long qlen_lazy,
-		 long qlen),
+	TP_PROTO(const char *rcuname, struct rcu_head *rhp, long qlen),
 
-	TP_ARGS(rcuname, rhp, qlen_lazy, qlen),
+	TP_ARGS(rcuname, rhp, qlen),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
 		__field(void *, rhp)
 		__field(void *, func)
-		__field(long, qlen_lazy)
 		__field(long, qlen)
 	),
 
@@ -498,13 +496,12 @@ TRACE_EVENT_RCU(rcu_callback,
 		__entry->rcuname = rcuname;
 		__entry->rhp = rhp;
 		__entry->func = rhp->func;
-		__entry->qlen_lazy = qlen_lazy;
 		__entry->qlen = qlen;
 	),
 
-	TP_printk("%s rhp=%p func=%ps %ld/%ld",
+	TP_printk("%s rhp=%p func=%ps %ld",
 		  __entry->rcuname, __entry->rhp, __entry->func,
-		  __entry->qlen_lazy, __entry->qlen)
+		  __entry->qlen)
 );
 
 /*
@@ -518,15 +515,14 @@ TRACE_EVENT_RCU(rcu_callback,
 TRACE_EVENT_RCU(rcu_kfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
-		 long qlen_lazy, long qlen),
+		 long qlen),
 
-	TP_ARGS(rcuname, rhp, offset, qlen_lazy, qlen),
+	TP_ARGS(rcuname, rhp, offset, qlen),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
 		__field(void *, rhp)
 		__field(unsigned long, offset)
-		__field(long, qlen_lazy)
 		__field(long, qlen)
 	),
 
@@ -534,13 +530,12 @@ TRACE_EVENT_RCU(rcu_kfree_callback,
 		__entry->rcuname = rcuname;
 		__entry->rhp = rhp;
 		__entry->offset = offset;
-		__entry->qlen_lazy = qlen_lazy;
 		__entry->qlen = qlen;
 	),
 
-	TP_printk("%s rhp=%p func=%ld %ld/%ld",
+	TP_printk("%s rhp=%p func=%ld %ld",
 		  __entry->rcuname, __entry->rhp, __entry->offset,
-		  __entry->qlen_lazy, __entry->qlen)
+		  __entry->qlen)
 );
 
 /*
@@ -552,27 +547,24 @@ TRACE_EVENT_RCU(rcu_kfree_callback,
  */
 TRACE_EVENT_RCU(rcu_batch_start,
 
-	TP_PROTO(const char *rcuname, long qlen_lazy, long qlen, long blimit),
+	TP_PROTO(const char *rcuname, long qlen, long blimit),
 
-	TP_ARGS(rcuname, qlen_lazy, qlen, blimit),
+	TP_ARGS(rcuname, qlen, blimit),
 
 	TP_STRUCT__entry(
 		__field(const char *, rcuname)
-		__field(long, qlen_lazy)
 		__field(long, qlen)
 		__field(long, blimit)
 	),
 
 	TP_fast_assign(
 		__entry->rcuname = rcuname;
-		__entry->qlen_lazy = qlen_lazy;
 		__entry->qlen = qlen;
 		__entry->blimit = blimit;
 	),
 
-	TP_printk("%s CBs=%ld/%ld bl=%ld",
-		  __entry->rcuname, __entry->qlen_lazy, __entry->qlen,
-		  __entry->blimit)
+	TP_printk("%s CBs=%ld bl=%ld",
+		  __entry->rcuname, __entry->qlen, __entry->blimit)
 );
 
 /*
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ab504fb..c30a1f7 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -198,33 +198,6 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 }
 #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
-void kfree(const void *);
-
-/*
- * Reclaim the specified callback, either by invoking it (non-lazy case)
- * or freeing it directly (lazy case).  Return true if lazy, false otherwise.
- */
-static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
-{
-	rcu_callback_t f;
-	unsigned long offset = (unsigned long)head->func;
-
-	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kfree_rcu_offset(offset)) {
-		trace_rcu_invoke_kfree_callback(rn, head, offset);
-		kfree((void *)head - offset);
-		rcu_lock_release(&rcu_callback_map);
-		return true;
-	} else {
-		trace_rcu_invoke_callback(rn, head);
-		f = head->func;
-		WRITE_ONCE(head->func, (rcu_callback_t)0L);
-		f(head);
-		rcu_lock_release(&rcu_callback_map);
-		return false;
-	}
-}
-
 #ifdef CONFIG_RCU_STALL_COMMON
 
 extern int rcu_cpu_stall_ftrace_dump;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index cbc87b8..5f4fd3b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -20,14 +20,10 @@ void rcu_cblist_init(struct rcu_cblist *rclp)
 	rclp->head = NULL;
 	rclp->tail = &rclp->head;
 	rclp->len = 0;
-	rclp->len_lazy = 0;
 }
 
 /*
  * Enqueue an rcu_head structure onto the specified callback list.
- * This function assumes that the callback is non-lazy because it
- * is intended for use by no-CBs CPUs, which do not distinguish
- * between lazy and non-lazy RCU callbacks.
  */
 void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
 {
@@ -54,7 +50,6 @@ void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
 	else
 		drclp->tail = &drclp->head;
 	drclp->len = srclp->len;
-	drclp->len_lazy = srclp->len_lazy;
 	if (!rhp) {
 		rcu_cblist_init(srclp);
 	} else {
@@ -62,16 +57,12 @@ void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
 		srclp->head = rhp;
 		srclp->tail = &rhp->next;
 		WRITE_ONCE(srclp->len, 1);
-		srclp->len_lazy = 0;
 	}
 }
 
 /*
  * Dequeue the oldest rcu_head structure from the specified callback
- * list.  This function assumes that the callback is non-lazy, but
- * the caller can later invoke rcu_cblist_dequeued_lazy() if it
- * finds otherwise (and if it cares about laziness).  This allows
- * different users to have different ways of determining laziness.
+ * list.
  */
 struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
 {
@@ -161,7 +152,6 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
 		rsclp->tails[i] = &rsclp->head;
 	rcu_segcblist_set_len(rsclp, 0);
-	rsclp->len_lazy = 0;
 	rsclp->enabled = 1;
 }
 
@@ -173,7 +163,6 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 {
 	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
-	WARN_ON_ONCE(rcu_segcblist_n_lazy_cbs(rsclp));
 	rsclp->enabled = 0;
 }
 
@@ -253,11 +242,9 @@ bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
  * absolutely not OK for it to ever miss posting a callback.
  */
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
-			   struct rcu_head *rhp, bool lazy)
+			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
-	if (lazy)
-		rsclp->len_lazy++;
 	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
@@ -275,15 +262,13 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
  * period.  You have been warned.
  */
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
-			   struct rcu_head *rhp, bool lazy)
+			   struct rcu_head *rhp)
 {
 	int i;
 
 	if (rcu_segcblist_n_cbs(rsclp) == 0)
 		return false;
 	rcu_segcblist_inc_len(rsclp);
-	if (lazy)
-		rsclp->len_lazy++;
 	smp_mb(); /* Ensure counts are updated before callback is entrained. */
 	rhp->next = NULL;
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
@@ -307,8 +292,6 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
 					       struct rcu_cblist *rclp)
 {
-	rclp->len_lazy += rsclp->len_lazy;
-	rsclp->len_lazy = 0;
 	rclp->len = rcu_segcblist_xchg_len(rsclp, 0);
 }
 
@@ -361,9 +344,7 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
 				struct rcu_cblist *rclp)
 {
-	rsclp->len_lazy += rclp->len_lazy;
 	rcu_segcblist_add_len(rsclp, rclp->len);
-	rclp->len_lazy = 0;
 	rclp->len = 0;
 }
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 815c2fd..5c293af 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,15 +15,6 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
-/*
- * Account for the fact that a previously dequeued callback turned out
- * to be marked as lazy.
- */
-static inline void rcu_cblist_dequeued_lazy(struct rcu_cblist *rclp)
-{
-	rclp->len_lazy--;
-}
-
 void rcu_cblist_init(struct rcu_cblist *rclp);
 void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
@@ -59,18 +50,6 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 #endif
 }
 
-/* Return number of lazy callbacks in segmented callback list. */
-static inline long rcu_segcblist_n_lazy_cbs(struct rcu_segcblist *rsclp)
-{
-	return rsclp->len_lazy;
-}
-
-/* Return number of lazy callbacks in segmented callback list. */
-static inline long rcu_segcblist_n_nonlazy_cbs(struct rcu_segcblist *rsclp)
-{
-	return rcu_segcblist_n_cbs(rsclp) - rsclp->len_lazy;
-}
-
 /*
  * Is the specified rcu_segcblist enabled, for example, not corresponding
  * to an offline CPU?
@@ -106,9 +85,9 @@ struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
-			   struct rcu_head *rhp, bool lazy);
+			   struct rcu_head *rhp);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
-			   struct rcu_head *rhp, bool lazy);
+			   struct rcu_head *rhp);
 void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
 				 struct rcu_cblist *rclp);
 void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5dffade..d0a9d5b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -853,7 +853,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	local_irq_save(flags);
 	sdp = this_cpu_ptr(ssp->sda);
 	spin_lock_rcu_node(sdp);
-	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp, false);
+	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
 	s = rcu_seq_snap(&ssp->srcu_gp_seq);
@@ -1052,7 +1052,7 @@ void srcu_barrier(struct srcu_struct *ssp)
 		sdp->srcu_barrier_head.func = srcu_barrier_cb;
 		debug_rcu_head_queue(&sdp->srcu_barrier_head);
 		if (!rcu_segcblist_entrain(&sdp->srcu_cblist,
-					   &sdp->srcu_barrier_head, 0)) {
+					   &sdp->srcu_barrier_head)) {
 			debug_rcu_head_unqueue(&sdp->srcu_barrier_head);
 			atomic_dec(&ssp->srcu_barrier_cpu_cnt);
 		}
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 477b4eb..dd572ce 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -22,6 +22,7 @@
 #include <linux/time.h>
 #include <linux/cpu.h>
 #include <linux/prefetch.h>
+#include <linux/slab.h>
 
 #include "rcu.h"
 
@@ -73,6 +74,31 @@ void rcu_sched_clock_irq(int user)
 	}
 }
 
+/*
+ * Reclaim the specified callback, either by invoking it for non-kfree cases or
+ * freeing it directly (for kfree). Return true if kfreeing, false otherwise.
+ */
+static inline bool rcu_reclaim_tiny(struct rcu_head *head)
+{
+	rcu_callback_t f;
+	unsigned long offset = (unsigned long)head->func;
+
+	rcu_lock_acquire(&rcu_callback_map);
+	if (__is_kfree_rcu_offset(offset)) {
+		trace_rcu_invoke_kfree_callback("", head, offset);
+		kfree((void *)head - offset);
+		rcu_lock_release(&rcu_callback_map);
+		return true;
+	}
+
+	trace_rcu_invoke_callback("", head);
+	f = head->func;
+	WRITE_ONCE(head->func, (rcu_callback_t)0L);
+	f(head);
+	rcu_lock_release(&rcu_callback_map);
+	return false;
+}
+
 /* Invoke the RCU callbacks whose grace period has elapsed.  */
 static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
 {
@@ -100,7 +126,7 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
 		prefetch(next);
 		debug_rcu_head_unqueue(list);
 		local_bh_disable();
-		__rcu_reclaim("", list);
+		rcu_reclaim_tiny(list);
 		local_bh_enable();
 		list = next;
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0512221..a8dd612 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -55,6 +55,7 @@
 #include <linux/oom.h>
 #include <linux/smpboot.h>
 #include <linux/jiffies.h>
+#include <linux/slab.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/clock.h>
 #include "../time/tick-internal.h"
@@ -2146,7 +2147,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
 		trace_rcu_batch_start(rcu_state.name,
-				      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 				      rcu_segcblist_n_cbs(&rdp->cblist), 0);
 		trace_rcu_batch_end(rcu_state.name, 0,
 				    !rcu_segcblist_empty(&rdp->cblist),
@@ -2168,7 +2168,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	if (unlikely(bl > 100))
 		tlimit = local_clock() + rcu_resched_ns;
 	trace_rcu_batch_start(rcu_state.name,
-			      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
@@ -2179,9 +2178,19 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		rcu_callback_t f;
+
 		debug_rcu_head_unqueue(rhp);
-		if (__rcu_reclaim(rcu_state.name, rhp))
-			rcu_cblist_dequeued_lazy(&rcl);
+
+		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_callback(rcu_state.name, rhp);
+
+		f = rhp->func;
+		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+		f(rhp);
+
+		rcu_lock_release(&rcu_callback_map);
+
 		/*
 		 * Stop only if limit reached and CPU has something to do.
 		 * Note: The rcl structure counts down from zero.
@@ -2583,7 +2592,7 @@ static void rcu_leak_callback(struct rcu_head *rhp)
  * is expected to specify a CPU.
  */
 static void
-__call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
+__call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct rcu_data *rdp;
@@ -2618,18 +2627,17 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
 	}
+
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	/* If we get here, rcu_nocb_try_bypass() acquired ->nocb_lock. */
-	rcu_segcblist_enqueue(&rdp->cblist, head, lazy);
+	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kfree_rcu_offset((unsigned long)func))
 		trace_rcu_kfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
-					 rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 					 rcu_segcblist_n_cbs(&rdp->cblist));
 	else
 		trace_rcu_callback(rcu_state.name, head,
-				   rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
@@ -2679,7 +2687,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, 0);
+	__call_rcu(head, func);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
@@ -2747,10 +2755,18 @@ static void kfree_rcu_work(struct work_struct *work)
 
 	// List "head" is now private, so traverse locklessly.
 	for (; head; head = next) {
+		unsigned long offset = (unsigned long)head->func;
+
 		next = head->next;
 		// Potentially optimize with kfree_bulk in future.
 		debug_rcu_head_unqueue(head);
-		__rcu_reclaim(rcu_state.name, head);
+		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
+
+		/* Could be possible to optimize with kfree_bulk in future */
+		kfree((void *)head - offset);
+
+		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
 	}
 }
@@ -2825,7 +2841,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
  */
 void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, 1);
+	__call_rcu(head, func);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
 
@@ -3100,7 +3116,7 @@ static void rcu_barrier_func(void *unused)
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
-	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
+	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 055c317..1540542 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -183,7 +183,6 @@ struct rcu_data {
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
 #ifdef CONFIG_RCU_FAST_NO_HZ
-	bool all_lazy;			/* All CPU's CBs lazy at idle start? */
 	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
 	unsigned long last_advance_all;	/* Last jiffy CBs were all advanced. */
 	int tick_nohz_enabled_snap;	/* Previously seen value from sysfs. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa08d55..d5334e4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1262,10 +1262,9 @@ static void rcu_prepare_for_idle(void)
 /*
  * This code is invoked when a CPU goes idle, at which point we want
  * to have the CPU do everything required for RCU so that it can enter
- * the energy-efficient dyntick-idle mode.  This is handled by a
- * state machine implemented by rcu_prepare_for_idle() below.
+ * the energy-efficient dyntick-idle mode.
  *
- * The following three proprocessor symbols control this state machine:
+ * The following preprocessor symbol controls this:
  *
  * RCU_IDLE_GP_DELAY gives the number of jiffies that a CPU is permitted
  *	to sleep in dyntick-idle mode with RCU callbacks pending.  This
@@ -1274,21 +1273,15 @@ static void rcu_prepare_for_idle(void)
  *	number, be warned: Setting RCU_IDLE_GP_DELAY too high can hang your
  *	system.  And if you are -that- concerned about energy efficiency,
  *	just power the system down and be done with it!
- * RCU_IDLE_LAZY_GP_DELAY gives the number of jiffies that a CPU is
- *	permitted to sleep in dyntick-idle mode with only lazy RCU
- *	callbacks pending.  Setting this too high can OOM your system.
  *
- * The values below work well in practice.  If future workloads require
+ * The value below works well in practice.  If future workloads require
  * adjustment, they can be converted into kernel config parameters, though
  * making the state machine smarter might be a better option.
  */
 #define RCU_IDLE_GP_DELAY 4		/* Roughly one grace period. */
-#define RCU_IDLE_LAZY_GP_DELAY (6 * HZ)	/* Roughly six seconds. */
 
 static int rcu_idle_gp_delay = RCU_IDLE_GP_DELAY;
 module_param(rcu_idle_gp_delay, int, 0644);
-static int rcu_idle_lazy_gp_delay = RCU_IDLE_LAZY_GP_DELAY;
-module_param(rcu_idle_lazy_gp_delay, int, 0644);
 
 /*
  * Try to advance callbacks on the current CPU, but only if it has been
@@ -1327,8 +1320,7 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
 /*
  * Allow the CPU to enter dyntick-idle mode unless it has callbacks ready
  * to invoke.  If the CPU has callbacks, try to advance them.  Tell the
- * caller to set the timeout based on whether or not there are non-lazy
- * callbacks.
+ * caller about what to set the timeout.
  *
  * The caller must have disabled interrupts.
  */
@@ -1354,25 +1346,18 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 	}
 	rdp->last_accelerate = jiffies;
 
-	/* Request timer delay depending on laziness, and round. */
-	rdp->all_lazy = !rcu_segcblist_n_nonlazy_cbs(&rdp->cblist);
-	if (rdp->all_lazy) {
-		dj = round_jiffies(rcu_idle_lazy_gp_delay + jiffies) - jiffies;
-	} else {
-		dj = round_up(rcu_idle_gp_delay + jiffies,
-			       rcu_idle_gp_delay) - jiffies;
-	}
+	/* Request timer and round. */
+	dj = round_up(rcu_idle_gp_delay + jiffies, rcu_idle_gp_delay) - jiffies;
+
 	*nextevt = basemono + dj * TICK_NSEC;
 	return 0;
 }
 
 /*
- * Prepare a CPU for idle from an RCU perspective.  The first major task
- * is to sense whether nohz mode has been enabled or disabled via sysfs.
- * The second major task is to check to see if a non-lazy callback has
- * arrived at a CPU that previously had only lazy callbacks.  The third
- * major task is to accelerate (that is, assign grace-period numbers to)
- * any recently arrived callbacks.
+ * Prepare a CPU for idle from an RCU perspective.  The first major task is to
+ * sense whether nohz mode has been enabled or disabled via sysfs.  The second
+ * major task is to accelerate (that is, assign grace-period numbers to) any
+ * recently arrived callbacks.
  *
  * The caller must have disabled interrupts.
  */
@@ -1399,17 +1384,6 @@ static void rcu_prepare_for_idle(void)
 		return;
 
 	/*
-	 * If a non-lazy callback arrived at a CPU having only lazy
-	 * callbacks, invoke RCU core for the side-effect of recalculating
-	 * idle duration on re-entry to idle.
-	 */
-	if (rdp->all_lazy && rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)) {
-		rdp->all_lazy = false;
-		invoke_rcu_core();
-		return;
-	}
-
-	/*
 	 * If we have not yet accelerated this jiffy, accelerate all
 	 * callbacks on this CPU.
 	 */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c0b8c45..806f2dd 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -263,11 +263,9 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
 
-	sprintf(cp, "last_accelerate: %04lx/%04lx, Nonlazy posted: %c%c%c",
+	sprintf(cp, "last_accelerate: %04lx/%04lx dyntick_enabled: %d",
 		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
-		".l"[rdp->all_lazy],
-		".L"[!rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)],
-		".D"[!!rdp->tick_nohz_enabled_snap]);
+		!!rdp->tick_nohz_enabled_snap);
 }
 
 #else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-- 
2.9.5


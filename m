Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0F21883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RJg63Mmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfH0TCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:02:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44718 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbfH0TCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:02:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so13173868pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEQuD01Zplp2l4641radeUvCNXuIGyiOoIcOa4DyeNo=;
        b=RJg63MmfOU9qPBvYGaFl/ft+7Vk9hhvENk1EtqyVDO4OXqRt7PLFwin8fK/cYIFHDQ
         VGiHO1kOwYocBAE0X69bxFyVQo/p3zi9ohkJzw1Rt0xEagGH/OEDlXTH54W6TkYaErjY
         JCQh0aagd0HpbGRbNyHUsUcCfslmFMOSqVru8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEQuD01Zplp2l4641radeUvCNXuIGyiOoIcOa4DyeNo=;
        b=GMksg+L9dzdPd2Re1X6Jd7dL4HWzElf4QaqABEoxXF/5UTnUp1XAPbEeu96A6RcFz7
         9+On0Swb0ueXAVTGtPJrpHCtvaa4c7EkEWEBbZYDcHvIkXrX+1w6tf8ozuM1Ke+DkHUj
         6G4FlYz88GkUGlBkBHF/FHpobrW9mBsgKoTZs4qNeRsAHAoSeY+eI3NGKJl4Yk3/efW0
         i4lIIS1XVp44AwFclFHCEHdG/4ODhOkkE7ufWvv0dRSdPCQFInAvelLCE2u62bysVgF/
         pajAM5kIwj7tpgfxnnBWiKF1of9mghne4Wge49LnQzIukwSSRk0812vf8BXK7zRs/2rx
         pvEw==
X-Gm-Message-State: APjAAAW4u3x6FxWtyz4wZlwkn8KBHposJwRbm5Z4wWvmU+Ynvy3iJ6Hx
        /eF1qlf4/UEz+teeBUK4oJ+bH1tQoGw=
X-Google-Smtp-Source: APXvYqyci7a7t3JxD/EiUI140hNSaukz77puDPHVDluEs/VWwlsrjbBIOZWzoitQ4y+X7okf2QHhlA==
X-Received: by 2002:a17:90b:14c:: with SMTP id em12mr240763pjb.22.1566932538242;
        Tue, 27 Aug 2019 12:02:18 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k14sm33196pfi.98.2019.08.27.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 12:02:17 -0700 (PDT)
Message-ID: <5d657e39.1c69fb81.54250.01e0@mx.google.com>
X-Google-Original-Message-ID: 15669324726461@cam.corp.google.com
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
Subject: [PATCH 4/5] rcu: Remove kfree_rcu() special casing and lazy handling
Date:   Tue, 27 Aug 2019 15:01:58 -0400
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: 156693247224727@cam.corp.google.com
References: 156693247224727@cam.corp.google.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove kfree_rcu() special casing and lazy handling from RCU.
For Tiny RCU we fold the special handling into just Tiny RCU code.

Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/stallwarn.txt | 13 +++------
 include/linux/rcu_segcblist.h   |  2 --
 include/trace/events/rcu.h      | 32 +++++++++-------------
 kernel/rcu/rcu.h                | 27 -------------------
 kernel/rcu/rcu_segcblist.c      | 25 +++--------------
 kernel/rcu/rcu_segcblist.h      | 25 ++---------------
 kernel/rcu/srcutree.c           |  4 +--
 kernel/rcu/tiny.c               | 29 +++++++++++++++++++-
 kernel/rcu/tree.c               | 48 ++++++++++++++++++++++++---------
 kernel/rcu/tree.h               |  1 -
 kernel/rcu/tree_plugin.h        | 42 +++++++----------------------
 kernel/rcu/tree_stall.h         |  6 ++---
 12 files changed, 97 insertions(+), 157 deletions(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index f48f4621ccbc..2c02b8de01e7 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -225,18 +225,12 @@ an estimate of the total number of RCU callbacks queued across all CPUs
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
+rcu_prepare_for_idle().
 
 If the grace period ends just as the stall warning starts printing,
 there will be a spurious stall-warning message, which will include
@@ -249,7 +243,8 @@ possible for a zero-jiffy stall to be flagged in this case, depending
 on how the stall warning and the grace-period initialization happen to
 interact.  Please note that it is not possible to entirely eliminate this
 sort of false positive without resorting to things like stop_machine(),
-which is overkill for this sort of problem.
+which is overkill for this sort of problem. "dyntick_enabled: 1" indicates that
+dyntick-idle processing is enabled.
 
 If all CPUs and tasks have passed through quiescent states, but the
 grace period has nevertheless failed to end, the stall-warning splat
diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 646759042333..b36afe7b22c9 100644
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
index 694bd040cf51..0dd3478597ee 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -474,16 +474,14 @@ TRACE_EVENT_RCU(rcu_dyntick,
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
 
@@ -491,13 +489,12 @@ TRACE_EVENT_RCU(rcu_callback,
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
@@ -511,15 +508,14 @@ TRACE_EVENT_RCU(rcu_callback,
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
 
@@ -527,13 +523,12 @@ TRACE_EVENT_RCU(rcu_kfree_callback,
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
@@ -545,27 +540,24 @@ TRACE_EVENT_RCU(rcu_kfree_callback,
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
index aeec70fda82c..3f5a30ca7ed7 100644
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
index cbc87b804db9..5f4fd3b8777c 100644
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
index 815c2fdd3fcc..5c293afc07b8 100644
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
index 5dffade2d7cd..d0a9d5b69087 100644
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
index 477b4eb44af5..cc64dc8b3893 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -73,6 +73,33 @@ void rcu_sched_clock_irq(int user)
 	}
 }
 
+void kfree(const void *);
+
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
@@ -100,7 +127,7 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
 		prefetch(next);
 		debug_rcu_head_unqueue(list);
 		local_bh_disable();
-		__rcu_reclaim("", list);
+		rcu_reclaim_tiny(list);
 		local_bh_enable();
 		list = next;
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 64568f12641d..12c17e10f2b4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2129,6 +2129,23 @@ int rcutree_dead_cpu(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Reclaim the specified callback.
+ */
+static inline void rcu_reclaim_tree(const char *rn, struct rcu_head *head)
+{
+	rcu_callback_t f;
+
+	rcu_lock_acquire(&rcu_callback_map);
+	trace_rcu_invoke_callback(rn, head);
+
+	f = head->func;
+	WRITE_ONCE(head->func, (rcu_callback_t)0L);
+	f(head);
+
+	rcu_lock_release(&rcu_callback_map);
+}
+
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Thottle as specified by rdp->blimit.
@@ -2146,7 +2163,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
 		trace_rcu_batch_start(rcu_state.name,
-				      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 				      rcu_segcblist_n_cbs(&rdp->cblist), 0);
 		trace_rcu_batch_end(rcu_state.name, 0,
 				    !rcu_segcblist_empty(&rdp->cblist),
@@ -2168,7 +2184,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	if (unlikely(bl > 100))
 		tlimit = local_clock() + rcu_resched_ns;
 	trace_rcu_batch_start(rcu_state.name,
-			      rcu_segcblist_n_lazy_cbs(&rdp->cblist),
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
@@ -2181,8 +2196,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rhp = rcu_cblist_dequeue(&rcl);
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		debug_rcu_head_unqueue(rhp);
-		if (__rcu_reclaim(rcu_state.name, rhp))
-			rcu_cblist_dequeued_lazy(&rcl);
+		rcu_reclaim_tree(rcu_state.name, rhp);
+
 		/*
 		 * Stop only if limit reached and CPU has something to do.
 		 * Note: The rcl structure counts down from zero.
@@ -2585,7 +2600,7 @@ static void rcu_leak_callback(struct rcu_head *rhp)
  * is expected to specify a CPU.
  */
 static void
-__call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
+__call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct rcu_data *rdp;
@@ -2620,18 +2635,17 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
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
@@ -2681,7 +2695,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, bool lazy)
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, 0);
+	__call_rcu(head, func);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
@@ -2755,10 +2769,18 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * access is Ok.
 	 */
 	for (; head; head = next) {
+		unsigned long offset = (unsigned long)head->func;
+
 		next = head->next;
-		/* Could be possible to optimize with kfree_bulk in future */
+
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
@@ -2840,7 +2862,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
  */
 void kfree_call_rcu_nobatch(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, 1);
+	__call_rcu(head, func);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
 
@@ -3094,7 +3116,7 @@ static void rcu_barrier_func(void *unused)
 	debug_rcu_head_queue(&rdp->barrier_head);
 	rcu_nocb_lock(rdp);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
-	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head, 0)) {
+	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 055c31781d3a..15405420b40c 100644
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
index 2defc7fe74c3..0d0fa615c5fa 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1274,21 +1274,15 @@ static void rcu_prepare_for_idle(void)
  *	number, be warned: Setting RCU_IDLE_GP_DELAY too high can hang your
  *	system.  And if you are -that- concerned about energy efficiency,
  *	just power the system down and be done with it!
- * RCU_IDLE_LAZY_GP_DELAY gives the number of jiffies that a CPU is
- *	permitted to sleep in dyntick-idle mode with only lazy RCU
- *	callbacks pending.  Setting this too high can OOM your system.
  *
  * The values below work well in practice.  If future workloads require
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
@@ -1327,8 +1321,7 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
 /*
  * Allow the CPU to enter dyntick-idle mode unless it has callbacks ready
  * to invoke.  If the CPU has callbacks, try to advance them.  Tell the
- * caller to set the timeout based on whether or not there are non-lazy
- * callbacks.
+ * caller about what to set the timeout.
  *
  * The caller must have disabled interrupts.
  */
@@ -1354,25 +1347,19 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
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
+	dj = round_up(rcu_idle_gp_delay + jiffies,
+		      rcu_idle_gp_delay) - jiffies;
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
@@ -1398,17 +1385,6 @@ static void rcu_prepare_for_idle(void)
 	if (!tne)
 		return;
 
-	/*
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
 	/*
 	 * If we have not yet accelerated this jiffy, accelerate all
 	 * callbacks on this CPU.
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 841ab43f3e60..67530c23c708 100644
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
2.23.0.187.g17f5b7556c-goog


Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E55C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C2218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373986;
	bh=5RIzJA16dCRxS/jInDW+ZTPXqj27b5l7CRM+Emi/IqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d3sU6ETkTNNGDRrZV85GpdNM+oIuOW+fLQTRxyR5j2symswRvqVzlRHKQwUyp4/Cj
	 ID0fUDvgKO3OoQeBFw8fhbQJSaE77vPWl2T6T5QsCJG7DS719t6akaT02moncOVUXq
	 strq7R/AhcgMkIGC/IcAxZ2CPL/xPooJP+zcxC5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbfB1RNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733080AbfB1RNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:02 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638DF218D8;
        Thu, 28 Feb 2019 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373981;
        bh=5RIzJA16dCRxS/jInDW+ZTPXqj27b5l7CRM+Emi/IqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXb3DdqJIIL0YhJ6lwdf3rnHoFoX38BkInrWYzA7XVGae1nbxCcIiogvHe55FLb56
         Oq3fy8nj4eySIuq5mLhby5PzG69SLMWde4bnRGw6YF/7/qsi2RW3e3pLMF4ulJD2iF
         3qsQVwxqPOXjszAopzifzUF12ieMd0gRxKGlk/AY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/37] locking/lockdep: Introduce struct lock_usage
Date:   Thu, 28 Feb 2019 18:12:08 +0100
Message-Id: <20190228171242.32144-4-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support softirq per-vector locking validation, we could
simply iterate over all enabled vectors and perform separate validation
for all of them on every lock event. We can expect that to introduce a
severe performance penalty though.

Therefore, we instead plan to validate the LOCK_USED_IN_*_SOFTIRQ and
LOCK_ENABLED_*_SOFTIRQ events with grouping the involved softirq vector
bits. It implies that we'll rather validate expanded usage mask than
usage bit in the end.

Before the usage mask to be expanded though, we need to play with the
usage bit that defines the nature of the event relevant to a group of
vectors.

Introduce struct lock_usage to implement that. This is made of the
classical lock usage bit that defines the nature of a lock usage
along which we carry the vectors to which that usage applies.

Once high level functions are done dealing with the nature of the lock
usage, lower level functions dealing with validation can expand the
struct lock_usage to a usage mask through lock_usage_mask().

For now, vector is always 0 until we get the proper vector finegrained
informations on softirq usage events.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c           | 122 +++++++++++++++++------------
 kernel/locking/lockdep_internals.h |   6 ++
 2 files changed, 79 insertions(+), 49 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 11db7ba29660..4fc859c0a799 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -468,6 +468,11 @@ static inline unsigned long lock_flag(enum lock_usage_bit bit)
 	return 1UL << bit;
 }
 
+static unsigned long lock_usage_mask(struct lock_usage *usage)
+{
+	return lock_flag(usage->bit);
+}
+
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
 	char c = '.';
@@ -2410,7 +2415,7 @@ static void check_chain_key(struct task_struct *curr)
 }
 
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit new_bit);
+		     struct lock_usage *new_usage);
 
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
@@ -2484,7 +2489,6 @@ valid_state(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-
 /*
  * print irq inversion bug:
  */
@@ -2650,11 +2654,14 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
+	      struct lock_usage *new_usage)
 {
-	int excl_bit = exclusive_bit(new_bit);
-	int read = new_bit & LOCK_USAGE_READ_MASK;
-	int dir = new_bit & LOCK_USAGE_DIR_MASK;
+	struct lock_usage excl_usage = {
+		.bit = exclusive_bit(new_usage->bit),
+		.vector = new_usage->vector
+	};
+	int read = new_usage->bit & LOCK_USAGE_READ_MASK;
+	int dir = new_usage->bit & LOCK_USAGE_DIR_MASK;
 
 	/*
 	 * mark USED_IN has to look forwards -- to ensure no dependency
@@ -2670,7 +2677,7 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * Validate that this particular lock does not have conflicting
 	 * usage states.
 	 */
-	if (!valid_state(curr, this, new_bit, excl_bit))
+	if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
 		return 0;
 
 	/*
@@ -2678,23 +2685,24 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-	    !usage(curr, this, BIT(excl_bit), state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, lock_usage_mask(&excl_usage), state_name(new_usage->bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
 	 * Check for read in write conflicts
 	 */
 	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
+		excl_usage.bit += LOCK_USAGE_READ_MASK;
+		if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-		    !usage(curr, this, BIT(excl_bit + LOCK_USAGE_READ_MASK),
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
+		    !usage(curr, this, lock_usage_mask(&excl_usage),
+			   state_name(new_usage->bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
 
-	if (state_verbose(new_bit, hlock_class(this)))
+	if (state_verbose(new_usage->bit, hlock_class(this)))
 		return 2;
 
 	return 1;
@@ -2704,24 +2712,24 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
  * Mark all held locks with a usage bit:
  */
 static int
-mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
+mark_held_locks(struct task_struct *curr, struct lock_usage *base_usage)
 {
 	struct held_lock *hlock;
 	int i;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
-		enum lock_usage_bit hlock_bit = base_bit;
+		struct lock_usage hlock_usage = *base_usage;
 		hlock = curr->held_locks + i;
 
 		if (hlock->read)
-			hlock_bit += LOCK_USAGE_READ_MASK;
+			hlock_usage.bit += LOCK_USAGE_READ_MASK;
 
-		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
+		BUG_ON(hlock_usage.bit >= LOCK_USAGE_STATES);
 
 		if (!hlock->check)
 			continue;
 
-		if (!mark_lock(curr, hlock, hlock_bit))
+		if (!mark_lock(curr, hlock, &hlock_usage))
 			return 0;
 	}
 
@@ -2734,6 +2742,7 @@ mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
 static void __trace_hardirqs_on_caller(unsigned long ip)
 {
 	struct task_struct *curr = current;
+	struct lock_usage usage = { .bit = LOCK_ENABLED_HARDIRQ };
 
 	/* we'll do an OFF -> ON transition: */
 	curr->hardirqs_enabled = 1;
@@ -2742,16 +2751,18 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 * We are going to turn hardirqs on, so set the
 	 * usage bit for all held locks:
 	 */
-	if (!mark_held_locks(curr, LOCK_ENABLED_HARDIRQ))
+	if (!mark_held_locks(curr, &usage))
 		return;
 	/*
 	 * If we have softirqs enabled, then set the usage
 	 * bit for all held locks. (disabled hardirqs prevented
 	 * this bit from being set before)
 	 */
-	if (curr->softirqs_enabled)
-		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
+	if (curr->softirqs_enabled) {
+		usage.bit = LOCK_ENABLED_SOFTIRQ;
+		if (!mark_held_locks(curr, &usage))
 			return;
+	}
 
 	curr->hardirq_enable_ip = ip;
 	curr->hardirq_enable_event = ++curr->irq_events;
@@ -2834,6 +2845,9 @@ void lockdep_hardirqs_off(unsigned long ip)
 void trace_softirqs_on(unsigned long ip)
 {
 	struct task_struct *curr = current;
+	struct lock_usage usage = {
+		.bit = LOCK_ENABLED_SOFTIRQ,
+	};
 
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
@@ -2864,7 +2878,7 @@ void trace_softirqs_on(unsigned long ip)
 	 * enabled too:
 	 */
 	if (curr->hardirqs_enabled)
-		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
+		mark_held_locks(curr, &usage);
 	current->lockdep_recursion = 0;
 }
 
@@ -2902,46 +2916,55 @@ void trace_softirqs_off(unsigned long ip)
 
 static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 {
+	struct lock_usage usage = { .vector = 0 };
 	/*
 	 * If non-trylock use in a hardirq or softirq context, then
 	 * mark the lock as used in these contexts:
 	 */
 	if (!hlock->trylock) {
 		if (hlock->read) {
-			if (curr->hardirq_context)
-				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_HARDIRQ_READ))
+			if (curr->hardirq_context) {
+				usage.bit = LOCK_USED_IN_HARDIRQ_READ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
-			if (curr->softirq_context)
-				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_SOFTIRQ_READ))
+			}
+			if (curr->softirq_context) {
+				usage.bit = LOCK_USED_IN_SOFTIRQ_READ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		} else {
-			if (curr->hardirq_context)
-				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
+			if (curr->hardirq_context) {
+				usage.bit = LOCK_USED_IN_HARDIRQ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
-			if (curr->softirq_context)
-				if (!mark_lock(curr, hlock, LOCK_USED_IN_SOFTIRQ))
+			}
+			if (curr->softirq_context) {
+				usage.bit = LOCK_USED_IN_SOFTIRQ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		}
 	}
 	if (!hlock->hardirqs_off) {
 		if (hlock->read) {
-			if (!mark_lock(curr, hlock,
-					LOCK_ENABLED_HARDIRQ_READ))
+			usage.bit = LOCK_ENABLED_HARDIRQ_READ;
+			if (!mark_lock(curr, hlock, &usage))
 				return 0;
-			if (curr->softirqs_enabled)
-				if (!mark_lock(curr, hlock,
-						LOCK_ENABLED_SOFTIRQ_READ))
+			if (curr->softirqs_enabled) {
+				usage.bit = LOCK_ENABLED_SOFTIRQ_READ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		} else {
-			if (!mark_lock(curr, hlock,
-					LOCK_ENABLED_HARDIRQ))
+			usage.bit = LOCK_ENABLED_HARDIRQ;
+			if (!mark_lock(curr, hlock, &usage))
 				return 0;
-			if (curr->softirqs_enabled)
-				if (!mark_lock(curr, hlock,
-						LOCK_ENABLED_SOFTIRQ))
+			if (curr->softirqs_enabled) {
+				usage.bit = LOCK_ENABLED_SOFTIRQ;
+				if (!mark_lock(curr, hlock, &usage))
 					return 0;
+			}
 		}
 	}
 
@@ -2980,7 +3003,7 @@ static int separate_irq_context(struct task_struct *curr,
 
 static inline
 int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
+		  struct lock_usage *new_usage)
 {
 	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
 	return 1;
@@ -3009,9 +3032,9 @@ static inline int separate_irq_context(struct task_struct *curr,
  * Mark a lock with a usage bit, and validate the state transition:
  */
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
-			     enum lock_usage_bit new_bit)
+		     struct lock_usage *new_usage)
 {
-	unsigned int new_mask = 1 << new_bit, ret = 1;
+	unsigned long new_mask = lock_usage_mask(new_usage), ret = 1;
 
 	/*
 	 * If already set then do not dirty the cacheline,
@@ -3032,10 +3055,10 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	hlock_class(this)->usage_mask |= new_mask;
 
-	if (!save_trace(hlock_class(this)->usage_traces + new_bit))
+	if (!save_trace(hlock_class(this)->usage_traces + new_usage->bit))
 		return 0;
 
-	switch (new_bit) {
+	switch (new_usage->bit) {
 #define LOCKDEP_STATE(__STATE)			\
 	case LOCK_USED_IN_##__STATE:		\
 	case LOCK_USED_IN_##__STATE##_READ:	\
@@ -3043,7 +3066,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	case LOCK_ENABLED_##__STATE##_READ:
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
-		ret = mark_lock_irq(curr, this, new_bit);
+		ret = mark_lock_irq(curr, this, new_usage);
 		if (!ret)
 			return 0;
 		break;
@@ -3063,7 +3086,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * We must printk outside of the graph_lock:
 	 */
 	if (ret == 2) {
-		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
+		printk("\nmarked lock as {%s}:\n", usage_str[new_usage->bit]);
 		print_lock(this);
 		print_irqtrace_events(curr);
 		dump_stack();
@@ -3187,6 +3210,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 {
 	struct task_struct *curr = current;
 	struct lock_class *class = NULL;
+	struct lock_usage usage = { .bit = LOCK_USED };
 	struct held_lock *hlock;
 	unsigned int depth;
 	int chain_head = 0;
@@ -3280,7 +3304,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		return 0;
 
 	/* mark it as used: */
-	if (!mark_lock(curr, hlock, LOCK_USED))
+	if (!mark_lock(curr, hlock, &usage))
 		return 0;
 
 	/*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 2ebb9d0ea91c..e714c823f594 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -26,6 +26,12 @@ enum lock_usage_bit {
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
 
+struct lock_usage {
+	enum lock_usage_bit bit;
+	unsigned long vector; /* Softirq vector */
+};
+
+
 /*
  * Usage-state bitmasks:
  */
-- 
2.21.0


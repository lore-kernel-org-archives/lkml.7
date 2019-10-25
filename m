Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42403CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC8221928
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfJYArd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 20:47:33 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:39706 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387940AbfJYArd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:47:33 -0400
X-QQ-mid: bizesmtp19t1571964445tmlukhg6
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 25 Oct 2019 08:47:23 +0800 (CST)
X-QQ-SSF: 01400000000000X0ZN82B00A0000000
X-QQ-FEAT: z1EB+cZNM6E1ZUKCImxKOdtxKQRypn7j0NDSDU8g38+vMzqyfdw3HouTlFnVe
        5wZNJm0UqpEAlmbEalgvHk/tz9KbH5a4sfasDolIQq2br4TMmolm7vNKnNfcPLiBUs6W7FI
        0RX5DogT2Lf4KZqEt0XGGXesTBD3CSxTg+urBcOwtyb0Opc2eAPFX4RtJDaJhHfbMKu+bfG
        6WbVfC0+1ps0pTrhZZ3RujuSdsgR6EAj/KtSUnc+r8ThBljYq3wuC+KuhrcG8kKXmrIVARc
        cY4vGEfdXfyHUsuwZlfCjAfm4xAVEyJ5UUM+k8jxo/0vVIFLFetu57ymBDmQScswO731QCA
        z7Z/MskkBmLHI7+qDRDnh8UP7UU+w==
X-QQ-GoodBg: 2
From:   wangqi <wangqi@kylinos.cn>
To:     zhangduo@kylinos.cn
Cc:     nh@kylinos.cn, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        wangqi <wangqi@kylinos.cn>
Subject: [PATCH v1 4/6] locking/mutex: Add lock handoff to avoid starvation
Date:   Fri, 25 Oct 2019 08:46:56 +0800
Message-Id: <1571964418-215707-4-git-send-email-wangqi@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571964418-215707-1-git-send-email-wangqi@kylinos.cn>
References: <1571964418-215707-1-git-send-email-wangqi@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Implement lock handoff to avoid lock starvation.

Lock starvation is possible because mutex_lock() allows lock stealing,
where a running (or optimistic spinning) task beats the woken waiter
to the acquire.

Lock stealing is an important performance optimization because waiting
for a waiter to wake up and get runtime can take a significant time,
during which everyboy would stall on the lock.

The down-side is of course that it allows for starvation.

This patch has the waiter requesting a handoff if it fails to acquire
the lock upon waking. This re-introduces some of the wait time,
because once we do a handoff we have to wait for the waiter to wake up
again.

A future patch will add a round of optimistic spinning to attempt to
alleviate this penalty, but if that turns out to not be enough, we can
add a counter and only request handoff after multiple failed wakeups.

There are a few tricky implementation details:

 - accepting a handoff must only be done in the wait-loop. Since the
   handoff condition is owner == current, it can easily cause
   recursive locking trouble.

 - accepting the handoff must be careful to provide the ACQUIRE
   semantics.

 - having the HANDOFF bit set on unlock requires care, we must not
   clear the owner.

 - we must be careful to not leave HANDOFF set after we've acquired
   the lock. The tricky scenario is setting the HANDOFF bit on an
   unlocked mutex.

Tested-by: Jason Low <jason.low2@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <Waiman.Long@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: wangqi <wangqi@kylinos.cn>
---
 kernel/locking/mutex.c | 142 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 119 insertions(+), 23 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index de1ce0b..b4ebd8b 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -54,8 +54,10 @@ EXPORT_SYMBOL(__mutex_init);
  * bits to store extra state.
  *
  * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
+ * Bit1 indicates unlock needs to hand the lock to the top-waiter
  */
 #define MUTEX_FLAG_WAITERS	0x01
+#define MUTEX_FLAG_HANDOFF	0x02
 
 #define MUTEX_FLAGS		0x03
 
@@ -71,20 +73,48 @@ static inline unsigned long __owner_flags(unsigned long owner)
 
 /*
  * Actual trylock that will work on any unlocked state.
+ *
+ * When setting the owner field, we must preserve the low flag bits.
+ *
+ * Be careful with @handoff, only set that in a wait-loop (where you set
+ * HANDOFF) to avoid recursive lock attempts.
  */
-static inline bool __mutex_trylock(struct mutex *lock)
+static inline bool __mutex_trylock(struct mutex *lock, const bool handoff)
 {
 	unsigned long owner, curr = (unsigned long)current;
 
 	owner = atomic_long_read(&lock->owner);
 	for (;;) { /* must loop, can race against a flag */
-		unsigned long old;
+		unsigned long old, flags = __owner_flags(owner);
+
+		if (__owner_task(owner)) {
+			if (handoff && unlikely(__owner_task(owner) == current)) {
+				/*
+				 * Provide ACQUIRE semantics for the lock-handoff.
+				 *
+				 * We cannot easily use load-acquire here, since
+				 * the actual load is a failed cmpxchg, which
+				 * doesn't imply any barriers.
+				 *
+				 * Also, this is a fairly unlikely scenario, and
+				 * this contains the cost.
+				 */
+				smp_mb(); /* ACQUIRE */
+				return true;
+			}
 
-		if (__owner_task(owner))
 			return false;
+		}
+
+		/*
+		 * We set the HANDOFF bit, we must make sure it doesn't live
+		 * past the point where we acquire it. This would be possible
+		 * if we (accidentally) set the bit on an unlocked mutex.
+		 */
+		if (handoff)
+			flags &= ~MUTEX_FLAG_HANDOFF;
 
-		old = atomic_long_cmpxchg_acquire(&lock->owner, owner,
-						  curr | __owner_flags(owner));
+		old = atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags);
 		if (old == owner)
 			return true;
 
@@ -134,6 +164,39 @@ static inline void __mutex_clear_flag(struct mutex *lock, unsigned long flag)
 	atomic_long_andnot(flag, &lock->owner);
 }
 
+static inline bool __mutex_waiter_is_first(struct mutex *lock, struct mutex_waiter *waiter)
+{
+	return list_first_entry(&lock->wait_list, struct mutex_waiter, list) == waiter;
+}
+
+/*
+ * Give up ownership to a specific task, when @task = NULL, this is equivalent
+ * to a regular unlock. Clears HANDOFF, preserves WAITERS. Provides RELEASE
+ * semantics like a regular unlock, the __mutex_trylock() provides matching
+ * ACQUIRE semantics for the handoff.
+ */
+static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
+{
+	unsigned long owner = atomic_long_read(&lock->owner);
+
+	for (;;) {
+		unsigned long old, new;
+
+#ifdef CONFIG_DEBUG_MUTEXES
+		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
+#endif
+
+		new = (owner & MUTEX_FLAG_WAITERS);
+		new |= (unsigned long)task;
+
+		old = atomic_long_cmpxchg_release(&lock->owner, owner, new);
+		if (old == owner)
+			break;
+
+		owner = old;
+	}
+}
+
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * We split the mutex lock/unlock logic into separate fastpath and
@@ -398,7 +461,7 @@ static bool mutex_optimistic_spin(struct mutex *lock,
 			break;
 
 		/* Try to acquire the mutex if it is unlocked. */
-		if (__mutex_trylock(lock)) {
+		if (__mutex_trylock(lock, false)) {
 			osq_unlock(&lock->osq);
 			return true;
 		}
@@ -523,6 +586,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	struct task_struct *task = current;
 	struct mutex_waiter waiter;
 	unsigned long flags;
+	bool first = false;
 	int ret;
 
 	if (use_ww_ctx) {
@@ -534,7 +598,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	preempt_disable();
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
-	if (__mutex_trylock(lock) || mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx)) {
+	if (__mutex_trylock(lock, false) ||
+	    mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
 		if (use_ww_ctx) {
@@ -551,7 +616,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
-	if (__mutex_trylock(lock))
+	if (__mutex_trylock(lock, false))
 		goto skip_wait;
 
 	debug_mutex_lock_common(lock, &waiter);
@@ -561,13 +626,13 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	list_add_tail(&waiter.list, &lock->wait_list);
 	waiter.task = task;
 
-	if (list_first_entry(&lock->wait_list, struct mutex_waiter, list) == &waiter)
+	if (__mutex_waiter_is_first(lock, &waiter))
 		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
 
 	lock_contended(&lock->dep_map, ip);
 
 	for (;;) {
-		if (__mutex_trylock(lock))
+		if (__mutex_trylock(lock, first))
 			break;
 
 		/*
@@ -586,17 +651,20 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		}
 
 		__set_task_state(task, state);
-
-		/* didn't get the lock, go to sleep: */
 		spin_unlock_mutex(&lock->wait_lock, flags);
 		schedule_preempt_disabled();
 		spin_lock_mutex(&lock->wait_lock, flags);
+
+		if (!first && __mutex_waiter_is_first(lock, &waiter)) {
+			first = true;
+			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
+		}
 	}
 	__set_task_state(task, TASK_RUNNING);
 
 	mutex_remove_waiter(lock, &waiter, task);
 	if (likely(list_empty(&lock->wait_list)))
-		__mutex_clear_flag(lock, MUTEX_FLAG_WAITERS);
+		__mutex_clear_flag(lock, MUTEX_FLAGS);
 
 	debug_mutex_free_waiter(&waiter);
 
@@ -724,33 +792,61 @@ EXPORT_SYMBOL_GPL(__ww_mutex_lock_interruptible);
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
 {
+	struct task_struct *next = NULL;
 	unsigned long owner, flags;
 	WAKE_Q(wake_q);
 
 	mutex_release(&lock->dep_map, 1, ip);
 
 	/*
-	 * Release the lock before (potentially) taking the spinlock
-	 * such that other contenders can get on with things ASAP.
+	 * Release the lock before (potentially) taking the spinlock such that
+	 * other contenders can get on with things ASAP.
+	 *
+	 * Except when HANDOFF, in that case we must not clear the owner field,
+	 * but instead set it to the top waiter.
 	 */
-	owner = atomic_long_fetch_and_release(MUTEX_FLAGS, &lock->owner);
-	if (!__owner_flags(owner))
-		return;
+	owner = atomic_long_read(&lock->owner);
+	for (;;) {
+		unsigned long old;
+
+#ifdef CONFIG_DEBUG_MUTEXES
+		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
+#endif
+
+		if (owner & MUTEX_FLAG_HANDOFF)
+			break;
+
+		old = atomic_long_cmpxchg_release(&lock->owner, owner,
+						  __owner_flags(owner));
+		if (old == owner) {
+			if (owner & MUTEX_FLAG_WAITERS)
+				break;
+
+			return;
+		}
+
+		owner = old;
+	}
 
 	spin_lock_mutex(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
-				list_entry(lock->wait_list.next,
-					   struct mutex_waiter, list);
+			list_first_entry(&lock->wait_list,
+					 struct mutex_waiter, list);
+
+		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		wake_q_add(&wake_q, waiter->task);
+		wake_q_add(&wake_q, next);
 	}
 
+	if (owner & MUTEX_FLAG_HANDOFF)
+		__mutex_handoff(lock, next);
+
 	spin_unlock_mutex(&lock->wait_lock, flags);
+
 	wake_up_q(&wake_q);
 }
 
@@ -853,7 +949,7 @@ __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
  */
 int __sched mutex_trylock(struct mutex *lock)
 {
-	bool locked = __mutex_trylock(lock);
+	bool locked = __mutex_trylock(lock, false);
 
 	if (locked)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-- 
2.7.4




Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDE7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F912175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfDETW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731950AbfDETW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:22:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2538BC05B017;
        Fri,  5 Apr 2019 19:22:27 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 569816058F;
        Fri,  5 Apr 2019 19:22:24 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 12/12] locking/rwsem: Remove redundant computation of writer lock word
Date:   Fri,  5 Apr 2019 15:21:15 -0400
Message-Id: <20190405192115.17416-13-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
References: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 05 Apr 2019 19:22:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit architectures, each rwsem writer will have its unique lock
word for acquiring the lock. Right now, the writer code recomputes the
lock word every time it tries to acquire the lock. This is a waste of
time. The lock word is now cached and reused when it is needed.

On 32-bit architectures, the extra constant argument to
rwsem_try_write_lock() and rwsem_try_write_lock_unqueued() should be
optimized out by the compiler.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index ebdf21fcd75e..24ce7e2d4716 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -230,8 +230,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
  */
-static inline bool
-rwsem_try_write_lock(long count, struct rw_semaphore *sem, bool first)
+static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+					const long wlock, bool first)
 {
 	long new;
 
@@ -241,7 +241,7 @@ rwsem_try_write_lock(long count, struct rw_semaphore *sem, bool first)
 	if (!first && RWSEM_COUNT_HANDOFF(count))
 		return false;
 
-	new = (count & ~RWSEM_FLAG_HANDOFF) + RWSEM_WRITER_LOCKED -
+	new = (count & ~RWSEM_FLAG_HANDOFF) + wlock -
 	      (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
 
 	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
@@ -280,13 +280,14 @@ static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
-static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
+static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
+						 const long wlock)
 {
 	long count = atomic_long_read(&sem->count);
 
 	while (!RWSEM_COUNT_LOCKED_OR_HANDOFF(count)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
-					count + RWSEM_WRITER_LOCKED)) {
+						    count + wlock)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_wlock);
 			return true;
@@ -436,7 +437,7 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 		: 25 * NSEC_PER_USEC);
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 {
 	bool taken = false;
 	bool is_rt_task = rt_task(current);
@@ -465,7 +466,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		/*
 		 * Try to acquire the lock
 		 */
-		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
+		taken = wlock ? rwsem_try_write_lock_unqueued(sem, wlock)
 			      : rwsem_try_read_lock_unqueued(sem);
 
 		if (taken)
@@ -544,7 +545,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	return false;
 }
 
-static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem,
+					 const long wlock)
 {
 	return false;
 }
@@ -601,7 +603,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state, long count)
 	 */
 	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
 	adjustment = 0;
-	if (rwsem_optimistic_spin(sem, false)) {
+	if (rwsem_optimistic_spin(sem, 0)) {
 		unsigned long flags;
 
 		/*
@@ -717,10 +719,11 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
+	const long wlock = RWSEM_WRITER_LOCKED;
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem) &&
-	    rwsem_optimistic_spin(sem, true))
+	    rwsem_optimistic_spin(sem, wlock))
 		return sem;
 
 	/*
@@ -779,7 +782,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	while (true) {
-		if (rwsem_try_write_lock(count, sem, first))
+		if (rwsem_try_write_lock(count, sem, wlock, first))
 			break;
 
 		raw_spin_unlock_irq(&sem->wait_lock);
-- 
2.18.1


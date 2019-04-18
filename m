Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3156B217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfDRXrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfDRXr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BA073078A1F;
        Thu, 18 Apr 2019 23:47:28 +0000 (UTC)
Received: from llong.com (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCE7A5D707;
        Thu, 18 Apr 2019 23:47:24 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 18/18] locking/rwsem: Remove redundant computation of writer lock word
Date:   Thu, 18 Apr 2019 19:46:28 -0400
Message-Id: <20190418234628.3675-19-longman@redhat.com>
In-Reply-To: <20190418234628.3675-1-longman@redhat.com>
References: <20190418234628.3675-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 18 Apr 2019 23:47:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit architectures, each rwsem writer will have its unique lock
word for acquiring the lock. Right now, the writer code recomputes the
lock word every time it tries to acquire the lock. This is a waste of
time. The lock word is now cached and reused when it is needed.

When CONFIG_RWSEM_OWNER_COUNT isn't defined, the extra constant argument
to rwsem_try_write_lock() and rwsem_try_write_lock_unqueued() should
be optimized out by the compiler.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2dc975f7eb8e..19d8fbd50d17 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -578,6 +578,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * bit is set or the lock is acquired with handoff bit cleared.
  */
 static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+					const long wlock,
 					enum writer_wait_state wstate)
 {
 	long new;
@@ -594,8 +595,7 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
 				return false;
 			new = count | RWSEM_FLAG_HANDOFF;
 		} else {
-			new = (count | RWSEM_WRITER_LOCKED) &
-				~RWSEM_FLAG_HANDOFF;
+			new = (count | wlock) & ~RWSEM_FLAG_HANDOFF;
 
 			if (list_is_singular(&sem->wait_list))
 				new &= ~RWSEM_FLAG_WAITERS;
@@ -641,13 +641,14 @@ static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
-static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
+static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
+						 const long wlock)
 {
 	long count = atomic_long_read(&sem->count);
 
 	while (!(count & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
-					count | RWSEM_WRITER_LOCKED)) {
+					count | wlock)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_wlock);
 			return true;
@@ -813,7 +814,7 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 	return sched_clock() + delta;
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 {
 	bool taken = false;
 	int prev_owner_state = OWNER_NULL;
@@ -841,7 +842,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		/*
 		 * Try to acquire the lock
 		 */
-		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
+		taken = wlock ? rwsem_try_write_lock_unqueued(sem, wlock)
 			      : rwsem_try_read_lock_unqueued(sem);
 
 		if (taken)
@@ -957,7 +958,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 	return false;
 }
 
-static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem,
+					 const long wlock)
 {
 	return false;
 }
@@ -1122,10 +1124,11 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
+	const long wlock = RWSEM_WRITER_LOCKED;
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem, true) &&
-	    rwsem_optimistic_spin(sem, true))
+	    rwsem_optimistic_spin(sem, wlock))
 		return sem;
 
 	/*
@@ -1193,7 +1196,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	while (true) {
-		if (rwsem_try_write_lock(count, sem, wstate))
+		if (rwsem_try_write_lock(count, sem, wlock, wstate))
 			break;
 
 		raw_spin_unlock_irq(&sem->wait_lock);
-- 
2.18.1


Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2712C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9210E20679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfD1V1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfD1V1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 17:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35F78C049D67;
        Sun, 28 Apr 2019 21:27:07 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C760646A5;
        Sun, 28 Apr 2019 21:27:00 +0000 (UTC)
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
Subject: [PATCH-tip v7 15/20] locking/rwsem: Adaptive disabling of reader optimistic spinning
Date:   Sun, 28 Apr 2019 17:25:52 -0400
Message-Id: <20190428212557.13482-16-longman@redhat.com>
In-Reply-To: <20190428212557.13482-1-longman@redhat.com>
References: <20190428212557.13482-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 28 Apr 2019 21:27:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reader optimistic spinning is helpful when the reader critical section
is short and there aren't that many readers around. It makes readers
relatively more preferred than writers. When a writer times out spinning
on a reader-owned lock and set the nospinnable bits, there are two main
reasons for that.

 1) The reader critical section is long, perhaps the task sleeps after
    acquiring the read lock.
 2) There are just too many readers contending the lock causing it to
    take a while to service all of them.

In the former case, long reader critical section will impede the progress
of writers which is usually more important for system performance.
In the later case, reader optimistic spinning tends to make the reader
groups that contain readers that acquire the lock together smaller
leading to more of them. That may hurt performance in some cases. In
other words, the setting of nonspinnable bits indicates that reader
optimistic spinning may not be helpful for those workloads that cause it.

Therefore, any writers that have observed the setting of the writer
nonspinnable bit for a given rwsem after they fail to acquire the lock
via optimistic spinning will set the reader nonspinnable bit once they
acquire the write lock. Similarly, readers that observe the setting
of reader nonspinnable bit at slowpath entry will also set the reader
nonspinnable bit when they acquire the read lock via the wakeup path.

Once the reader nonspinnable bit is on, it will only be reset when
a writer is able to acquire the rwsem in the fast path or somehow a
reader or writer in the slowpath doesn't observe the nonspinable bit.

This is to discourage reader optmistic spinning on that particular
rwsem and make writers more preferred. This adaptive disabling of reader
optimistic spinning will alleviate some of the negative side effect of
this feature.

In addition, this patch tries to make readers in the spinning queue
follow the phase-fair principle after quitting optimistic spinning
by checking if another reader has somehow acquired a read lock after
this reader enters the optimistic spinning queue. If so and the rwsem
is still reader-owned, this reader is in the right read-phase and can
attempt to acquire the lock.

On a 2-socket 40-core 80-thread Skylake system, the page_fault1 test of
the will-it-scale benchmark was run with various number of threads. The
number of operations done before reader optimistic spinning patches,
this patch and after this patch were:

  Threads  Before rspin  Before patch  After patch    %change
  -------  ------------  ------------  -----------    -------
    20        5541068      5345484       5455667    -3.5%/ +2.1%
    40       10185150      7292313       9219276   -28.5%/+26.4%
    60        8196733      6460517       7181209   -21.2%/+11.2%
    80        9508864      6739559       8107025   -29.1%/+20.3%

This patch doesn't recover all the lost performance, but it is more
than half. Given the fact that reader optimistic spinning does benefit
some workloads, this is a good compromise.

Using the rwsem locking microbenchmark with very short critical section,
this patch doesn't have too much impact on locking performance as shown
by the locking rates (kops/s) below with equal numbers of readers and
writers before and after this patch:

   # of Threads  Pre-patch    Post-patch
   ------------  ---------    ----------
        2          4,730        4,969
        4          4,814        4,786
        8          4,866        4,815
       16          4,715        4,511
       32          3,338        3,500
       64          3,212        3,389
       80          3,110        3,044

When running the locking microbenchmark with 40 dedicated reader and writer
threads, however, the reader performance is curtailed to favor the writer.

Before patch:

  40 readers, Iterations Min/Mean/Max = 204,026/234,309/254,816
  40 writers, Iterations Min/Mean/Max = 88,515/95,884/115,644

After patch:

  40 readers, Iterations Min/Mean/Max = 33,813/35,260/36,791
  40 writers, Iterations Min/Mean/Max = 95,368/96,565/97,798

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  10 ++-
 kernel/locking/rwsem.c            | 131 +++++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index baa998401052..239039d0ce21 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -56,10 +56,12 @@ LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
 LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
 LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
 LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
-LOCK_EVENT(rwsem_opt_rlock)	/* # of read locks opt-spin acquired	*/
-LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
-LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
-LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled reader opt-spinnings	*/
+LOCK_EVENT(rwsem_opt_rlock)	/* # of opt-acquired read locks		*/
+LOCK_EVENT(rwsem_opt_wlock)	/* # of opt-acquired write locks	*/
+LOCK_EVENT(rwsem_opt_fail)	/* # of failed optspins			*/
+LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
+LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
+LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 62fcb8bacfab..a5025a63b7c3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -59,6 +59,42 @@
  * seems to hang on a reader owned rwsem especially if only one reader
  * is involved. Ideally we would like to track all the readers that own
  * a rwsem, but the overhead is simply too big.
+ *
+ * Reader optimistic spinning is helpful when the reader critical section
+ * is short and there aren't that many readers around. It makes readers
+ * relatively more preferred than writers. When a writer times out spinning
+ * on a reader-owned lock and set the nospinnable bits, there are two main
+ * reasons for that.
+ *
+ *  1) The reader critical section is long, perhaps the task sleeps after
+ *     acquiring the read lock.
+ *  2) There are just too many readers contending the lock causing it to
+ *     take a while to service all of them.
+ *
+ * In the former case, long reader critical section will impede the progress
+ * of writers which is usually more important for system performance. In
+ * the later case, reader optimistic spinning tends to make the reader
+ * groups that contain readers that acquire the lock together smaller
+ * leading to more of them. That may hurt performance in some cases. In
+ * other words, the setting of nonspinnable bits indicates that reader
+ * optimistic spinning may not be helpful for those workloads that cause
+ * it.
+ *
+ * Therefore, any writers that had observed the setting of the writer
+ * nonspinnable bit for a given rwsem after they fail to acquire the lock
+ * via optimistic spinning will set the reader nonspinnable bit once they
+ * acquire the write lock. Similarly, readers that observe the setting
+ * of reader nonspinnable bit at slowpath entry will set the reader
+ * nonspinnable bits when they acquire the read lock via the wakeup path.
+ *
+ * Once the reader nonspinnable bit is on, it will only be reset when
+ * a writer is able to acquire the rwsem in the fast path or somehow a
+ * reader or writer in the slowpath doesn't observe the nonspinable bit.
+ *
+ * This is to discourage reader optmistic spinning on that particular
+ * rwsem and make writers more preferred. This adaptive disabling of reader
+ * optimistic spinning will alleviate the negative side effect of this
+ * feature.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
 #define RWSEM_RD_NONSPINNABLE	(1UL << 1)
@@ -136,11 +172,15 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
  * Note that the owner value just indicates the task has owned the rwsem
  * previously, it may not be the real owner or one of the real owners
  * anymore when that field is examined, so take it with a grain of salt.
+ *
+ * The reader non-spinnable bit is preserved.
  */
 static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
-	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED;
+	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED |
+			   ((unsigned long)READ_ONCE(sem->owner) &
+			     RWSEM_RD_NONSPINNABLE);
 
 	WRITE_ONCE(sem->owner, (struct task_struct *)val);
 }
@@ -265,6 +305,7 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
+	unsigned long last_rowner;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -346,6 +387,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * so we can bail out early if a writer stole the lock.
 	 */
 	if (wake_type != RWSEM_WAKE_READ_OWNED) {
+		struct task_struct *owner;
+
 		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
@@ -366,8 +409,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		/*
 		 * Set it to reader-owned to give spinners an early
 		 * indication that readers now have the lock.
+		 * The reader nonspinnable bit seen at slowpath entry of
+		 * the reader is copied over.
 		 */
-		__rwsem_set_reader_owned(sem, waiter->task);
+		owner = waiter->task;
+		if (waiter->last_rowner & RWSEM_RD_NONSPINNABLE) {
+			owner = (void *)((long)owner | RWSEM_RD_NONSPINNABLE);
+			lockevent_inc(rwsem_opt_norspin);
+		}
+		__rwsem_set_reader_owned(sem, owner);
 	}
 
 	/*
@@ -831,6 +881,43 @@ static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
 		atomic_long_andnot(RWSEM_WR_NONSPINNABLE,
 				  (atomic_long_t *)&sem->owner);
 }
+
+/*
+ * This function is called when the reader fails to acquire the lock via
+ * optimistic spinning. In this case we will still attempt to do a trylock
+ * when comparing the rwsem state right now with the state when entering
+ * the slowpath indicates that the reader is still in a valid reader phase.
+ * This happens when the following conditions are true:
+ *
+ * 1) The lock is currently reader owned, and
+ * 2) The lock is previously not reader-owned or the last read owner changes.
+ *
+ * In the former case, we have transitioned from a writer phase to a
+ * reader-phase while spinning. In the latter case, it means the reader
+ * phase hasn't ended when we entered the optimistic spinning loop. In
+ * both cases, the reader is eligible to acquire the lock. This is the
+ * secondary path where a read lock is acquired optimistically.
+ *
+ * The reader non-spinnable bit wasn't set at time of entry or it will
+ * not be here at all.
+ */
+static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
+					      unsigned long last_rowner)
+{
+	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
+
+	if (!(owner & RWSEM_READER_OWNED))
+		return false;
+
+	owner	    &= ~RWSEM_OWNER_FLAGS_MASK;
+	last_rowner &= ~RWSEM_OWNER_FLAGS_MASK;
+	if ((owner != last_rowner) && rwsem_try_read_lock_unqueued(sem)) {
+		lockevent_inc(rwsem_opt_rlock2);
+		lockevent_add(rwsem_opt_fail, -1);
+		return true;
+	}
+	return false;
+}
 #else
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
@@ -843,6 +930,12 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 }
 
 static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
+
+static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
+					      unsigned long last_rowner)
+{
+	return false;
+}
 #endif
 
 /*
@@ -856,6 +949,14 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	/*
+	 * Save the current read-owner of rwsem, if available, and the
+	 * reader nonspinnable bit.
+	 */
+	waiter.last_rowner = (long)READ_ONCE(sem->owner);
+	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
+		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
+
 	if (!rwsem_can_spin_on_owner(sem, false))
 		goto queue;
 
@@ -878,6 +979,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 			wake_up_q(&wake_q);
 		}
 		return sem;
+	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
+		return sem;
 	}
 
 queue:
@@ -958,6 +1061,15 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	return ERR_PTR(-EINTR);
 }
 
+static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
+						bool disable)
+{
+	if (unlikely(disable)) {
+		*((unsigned long *)&sem->owner) |= RWSEM_RD_NONSPINNABLE;
+		lockevent_inc(rwsem_opt_norspin);
+	}
+}
+
 /*
  * Wait until we successfully acquire the write lock
  */
@@ -965,6 +1077,7 @@ static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
+	bool disable_rspin;
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
@@ -975,6 +1088,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	    rwsem_optimistic_spin(sem, true))
 		return sem;
 
+	/*
+	 * Disable reader optimistic spinning for this rwsem after
+	 * acquiring the write lock when the setting of the nonspinnable
+	 * bits are observed.
+	 */
+	disable_rspin = (long)READ_ONCE(sem->owner) & RWSEM_NONSPINNABLE;
+
 	/*
 	 * Optimistic spinning failed, proceed to the slowpath
 	 * and block until we can acquire the sem.
@@ -1081,6 +1201,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
+	rwsem_disable_reader_optspin(sem, disable_rspin);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
 
@@ -1202,7 +1323,8 @@ static inline void __down_write(struct rw_semaphore *sem)
 	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 						      RWSEM_WRITER_LOCKED)))
 		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
-	rwsem_set_owner(sem);
+	else
+		rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
@@ -1213,8 +1335,9 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 						      RWSEM_WRITER_LOCKED))) {
 		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
+	} else {
+		rwsem_set_owner(sem);
 	}
-	rwsem_set_owner(sem);
 	return 0;
 }
 
-- 
2.18.1


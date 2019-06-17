Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B46AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42502084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gxO3HOVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfFQOeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:34:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43823 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:34:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEXR8w3457890
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:33:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEXR8w3457890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782008;
        bh=W6hX3hn/8osMu+EMj6K6eKg+J20HKeC9o0wNUDWWQD4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gxO3HOVRFayU4pzXCi+QsFP0sH2A0pBgPEKvezDM+hvj9J7k5DoKkkn1qwmw7OAaB
         o+px/w73TtMZJSsjQXcYYdCWlR+MSGUTdM0t/2V6g8gBD8ZXJi2+QUR4kmauRvVCJq
         1pdMdK3Pa4eCi64T7qDOgjNVMYSRC/JixSxkTKak2urLMJu88zFZS4ZxrjNCQaZMYt
         EXx0Mzr++qmS5uQJD3B0wU9UfKB7IKE5FyYy3+SXwyGeN/joJP094wufuX+Ayg8KmS
         HmBQiORxNqcUf1nhf70eeEVBl/gA3alyP54pTZZYB9AT08drCyPR/9hr973MwL6pEn
         nWzQKgEHzk1oQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEXRKf3457886;
        Mon, 17 Jun 2019 07:33:27 -0700
Date:   Mon, 17 Jun 2019 07:33:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-5cfd92e12e13432251981b9d0cd68dbd7aa8d690@git.kernel.org>
Cc:     bp@alien8.de, dave@stgolabs.net, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, longman@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        huang.ying.caritas@gmail.com, tim.c.chen@linux.intel.com
Reply-To: huang.ying.caritas@gmail.com, tim.c.chen@linux.intel.com,
          dave@stgolabs.net, bp@alien8.de, hpa@zytor.com,
          peterz@infradead.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, longman@redhat.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190520205918.22251-16-longman@redhat.com>
References: <20190520205918.22251-16-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Git-Commit-ID: 5cfd92e12e13432251981b9d0cd68dbd7aa8d690
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5cfd92e12e13432251981b9d0cd68dbd7aa8d690
Gitweb:     https://git.kernel.org/tip/5cfd92e12e13432251981b9d0cd68dbd7aa8d690
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:14 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:09 +0200

locking/rwsem: Adaptive disabling of reader optimistic spinning

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Link: https://lkml.kernel.org/r/20190520205918.22251-16-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lock_events_list.h |  10 +--
 kernel/locking/rwsem.c            | 133 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 135 insertions(+), 8 deletions(-)

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
index 2d7cabcfca50..e1e0bac957c4 100644
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
@@ -144,11 +180,14 @@ static inline bool rwsem_test_oflags(struct rw_semaphore *sem, long flags)
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
+		(atomic_long_read(&sem->owner) & RWSEM_RD_NONSPINNABLE);
 
 	atomic_long_set(&sem->owner, val);
 }
@@ -287,6 +326,7 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
+	unsigned long last_rowner;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -368,6 +408,8 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 * so we can bail out early if a writer stole the lock.
 	 */
 	if (wake_type != RWSEM_WAKE_READ_OWNED) {
+		struct task_struct *owner;
+
 		adjustment = RWSEM_READER_BIAS;
 		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
@@ -388,8 +430,15 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		/*
 		 * Set it to reader-owned to give spinners an early
 		 * indication that readers now have the lock.
+		 * The reader nonspinnable bit seen at slowpath entry of
+		 * the reader is copied over.
 		 */
-		__rwsem_set_reader_owned(sem, waiter->task);
+		owner = waiter->task;
+		if (waiter->last_rowner & RWSEM_RD_NONSPINNABLE) {
+			owner = (void *)((unsigned long)owner | RWSEM_RD_NONSPINNABLE);
+			lockevent_inc(rwsem_opt_norspin);
+		}
+		__rwsem_set_reader_owned(sem, owner);
 	}
 
 	/*
@@ -836,6 +885,42 @@ static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
 	if (rwsem_test_oflags(sem, RWSEM_WR_NONSPINNABLE))
 		atomic_long_andnot(RWSEM_WR_NONSPINNABLE, &sem->owner);
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
+	unsigned long owner = atomic_long_read(&sem->owner);
+
+	if (!(owner & RWSEM_READER_OWNED))
+		return false;
+
+	if (((owner ^ last_rowner) & ~RWSEM_OWNER_FLAGS_MASK) &&
+	    rwsem_try_read_lock_unqueued(sem)) {
+		lockevent_inc(rwsem_opt_rlock2);
+		lockevent_add(rwsem_opt_fail, -1);
+		return true;
+	}
+	return false;
+}
 #else
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 					   unsigned long nonspinnable)
@@ -849,6 +934,12 @@ static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
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
@@ -862,6 +953,14 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	/*
+	 * Save the current read-owner of rwsem, if available, and the
+	 * reader nonspinnable bit.
+	 */
+	waiter.last_rowner = atomic_long_read(&sem->owner);
+	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
+		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
+
 	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
 		goto queue;
 
@@ -884,6 +983,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 			wake_up_q(&wake_q);
 		}
 		return sem;
+	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
+		return sem;
 	}
 
 queue:
@@ -964,6 +1065,19 @@ out_nolock:
 	return ERR_PTR(-EINTR);
 }
 
+/*
+ * This function is called by the a write lock owner. So the owner value
+ * won't get changed by others.
+ */
+static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
+						bool disable)
+{
+	if (unlikely(disable)) {
+		atomic_long_or(RWSEM_RD_NONSPINNABLE, &sem->owner);
+		lockevent_inc(rwsem_opt_norspin);
+	}
+}
+
 /*
  * Wait until we successfully acquire the write lock
  */
@@ -971,6 +1085,7 @@ static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
+	bool disable_rspin;
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
@@ -981,6 +1096,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	    rwsem_optimistic_spin(sem, true))
 		return sem;
 
+	/*
+	 * Disable reader optimistic spinning for this rwsem after
+	 * acquiring the write lock when the setting of the nonspinnable
+	 * bits are observed.
+	 */
+	disable_rspin = atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE;
+
 	/*
 	 * Optimistic spinning failed, proceed to the slowpath
 	 * and block until we can acquire the sem.
@@ -1077,6 +1199,7 @@ wait:
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
+	rwsem_disable_reader_optspin(sem, disable_rspin);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
 
@@ -1196,7 +1319,8 @@ static inline void __down_write(struct rw_semaphore *sem)
 	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 						      RWSEM_WRITER_LOCKED)))
 		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
-	rwsem_set_owner(sem);
+	else
+		rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
@@ -1207,8 +1331,9 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 						      RWSEM_WRITER_LOCKED))) {
 		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
+	} else {
+		rwsem_set_owner(sem);
 	}
-	rwsem_set_owner(sem);
 	return 0;
 }
 

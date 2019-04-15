Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E950C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65068218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfDOU67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfDOU66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F0B559454;
        Mon, 15 Apr 2019 20:58:58 +0000 (UTC)
Received: from llong.com (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2199619C68;
        Mon, 15 Apr 2019 20:58:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 2/2] locking/rwsem: Adaptive disabling of reader optimistic spinning
Date:   Mon, 15 Apr 2019 16:58:29 -0400
Message-Id: <20190415205829.32707-3-longman@redhat.com>
In-Reply-To: <20190415205829.32707-1-longman@redhat.com>
References: <20190415205829.32707-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 15 Apr 2019 20:58:58 +0000 (UTC)
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

Therefore, any writers that had observed the setting of the writer
nonspinnable bit for a given rwsem after they fail to acquire the lock
via optimistic spinning will set the reader nonspinnable bit once they
acquire the write lock. This is to discourage reader optmistic spinning
on that particular rwsem and make writers more preferred. This adaptive
disabling of reader optimistic spinning will alleviate some of the
negative side effect of this feature.

On a 2-socket 40-core 80-thread Skylake system, the page_fault1 test of
the will-it-scale benchmark was run with various number of threads. The
number of operations done before and after the patch were:

  Threads   Before patch   After patch   % change
  -------   ------------   -----------   --------
    20        5409075        5436456       +0.5%
    40        7174080        7903845      +10.2%
    60        6749707        7009784       +3.9%
    80        7071334        7353806       +4.0%

This doesn't recover all the lost performance, but is close to half. Given
the fact that reader optimistic spinning does benefit some workloads, this
is a good compromise.

Using the rwsem locking microbenchmark with very short critical section,
this patch also helps performance at high contention level as shown
by the locking rates (kops/s) below with equal numbers of readers and
writers before and after this patch:

   # of Threads  Pre-patch    Post-patch
   ------------  ---------    ----------
        2          4,472        4,839
        4          4,623        4,143
        8          4,764        4,126
       16          4,678        3,873
       32          2,847        3,263
       64          2,478        3,121
       80          2,222        3,104

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  9 ++---
 kernel/locking/rwsem.c            | 55 +++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index f3550aa5866a..b0eeb77070dd 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -56,10 +56,11 @@ LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
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
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index bb75584d99e3..d50bc7b0315f 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -59,6 +59,34 @@
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
+ * acquire the write lock. This is to discourage reader optmistic spinning
+ * on that particular rwsem and make writers more preferred. This adaptive
+ * disabling of reader optimistic spinning will alleviate the negative
+ * side effect of this feature.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
 #define RWSEM_RD_NONSPINNABLE	(1UL << 1)
@@ -1063,6 +1091,15 @@ rwsem_down_read_failed_killable(struct rw_semaphore *sem, long cnt)
 	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE, cnt);
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
@@ -1075,12 +1112,20 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 	const long wlock = RWSEM_WRITER_LOCKED;
+	bool disable_rspin;
 
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem, true) &&
 	    rwsem_optimistic_spin(sem, wlock))
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
@@ -1182,6 +1227,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
+	rwsem_disable_reader_optspin(sem, disable_rspin);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
 
@@ -1318,7 +1364,8 @@ static inline void __down_write(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
 						 RWSEM_WRITER_LOCKED)))
 		rwsem_down_write_failed(sem);
-	rwsem_set_owner(sem);
+	else
+		rwsem_set_owner(sem);
 #ifdef RWSEM_MERGE_OWNER_TO_COUNT
 	DEBUG_RWSEMS_WARN_ON(sem->owner != rwsem_get_owner(sem), sem);
 #endif
@@ -1327,10 +1374,12 @@ static inline void __down_write(struct rw_semaphore *sem)
 static inline int __down_write_killable(struct rw_semaphore *sem)
 {
 	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
-						 RWSEM_WRITER_LOCKED)))
+						 RWSEM_WRITER_LOCKED))) {
 		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
 			return -EINTR;
-	rwsem_set_owner(sem);
+	} else {
+		rwsem_set_owner(sem);
+	}
 	return 0;
 }
 
-- 
2.18.1


Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55326C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A8A20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YaMoOdnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfDPQB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47652 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfDPQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QtVOPp9XpMjn95ZD00G+bQ5IUpR0FEhnQTx4/Nr+hTo=; b=YaMoOdnxJ6Q6o9/SSeBzYK5XG
        to9JdTAU3hSRJa9F4p5GxIL4cmonUeGswTX5+yQtObIVzTAGRWC7FoXefWjN9rTlXQItuyJ6HOdcB
        HjSlBUPddVbBKQdKknIFL98qv1N+zXilh71ROxQWTRwh0XSshPz1HeQk3lsZwNeQLyQePc6XxpQil
        YVoorGVKTzldpc47fxClZ+xDbfYE+opVHubv9DYWcpeMOyRSBJHBi870tj9Z73DJ8l5qNCLif6mjn
        mKXOPQMzwRy+byJh+1HTIsIb3dbcUDSi8fPV+gaieLYdFZrv8nm/OhOR0bbTfTscxFbt0QXXjak2a
        HSkJHg38A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGQWI-0003yH-PU; Tue, 16 Apr 2019 16:01:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A36F29AC164D; Tue, 16 Apr 2019 18:01:13 +0200 (CEST)
Date:   Tue, 16 Apr 2019 18:01:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 06/16] locking/rwsem: Code cleanup after files merging
Message-ID: <20190416160113.GM12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-7-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


More cleanups..

---
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -303,7 +303,7 @@ static void __rwsem_mark_wake(struct rw_
 		list_del(&waiter->list);
 		/*
 		 * Ensure calling get_task_struct() before setting the reader
-		 * waiter to nil such that rwsem_down_read_failed() cannot
+		 * waiter to nil such that rwsem_down_read_slow() cannot
 		 * race with do_exit() by always holding a reference count
 		 * to the task to wakeup.
 		 */
@@ -500,7 +500,7 @@ static bool rwsem_optimistic_spin(struct
  * Wait for the read lock to be granted
  */
 static inline struct rw_semaphore __sched *
-__rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
+rwsem_down_read_slow(struct rw_semaphore *sem, int state)
 {
 	long count, adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
@@ -572,23 +572,11 @@ __rwsem_down_read_failed_common(struct r
 	return ERR_PTR(-EINTR);
 }
 
-static inline struct rw_semaphore * __sched
-rwsem_down_read_failed(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
-}
-
-static inline struct rw_semaphore * __sched
-rwsem_down_read_failed_killable(struct rw_semaphore *sem)
-{
-	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
-}
-
 /*
  * Wait until we successfully acquire the write lock
  */
 static inline struct rw_semaphore *
-__rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
+rwsem_down_write_slow(struct rw_semaphore *sem, int state)
 {
 	long count;
 	bool waiting = true; /* any queued threads before us */
@@ -689,18 +677,6 @@ __rwsem_down_write_failed_common(struct
 	return ERR_PTR(-EINTR);
 }
 
-static inline struct rw_semaphore * __sched
-rwsem_down_write_failed(struct rw_semaphore *sem)
-{
-	return __rwsem_down_write_failed_common(sem, TASK_UNINTERRUPTIBLE);
-}
-
-static inline struct rw_semaphore * __sched
-rwsem_down_write_failed_killable(struct rw_semaphore *sem)
-{
-	return __rwsem_down_write_failed_common(sem, TASK_KILLABLE);
-}
-
 /*
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
@@ -749,7 +725,7 @@ inline void __down_read(struct rw_semaph
 {
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		rwsem_down_read_failed(sem);
+		rwsem_down_read_slow(sem, TASK_UNINTERRUPTIBLE);
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
 					RWSEM_READER_OWNED), sem);
 	} else {
@@ -761,7 +737,7 @@ static inline int __down_read_killable(s
 {
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
+		if (IS_ERR(rwsem_down_read_slow(sem, TASK_KILLABLE)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
 					RWSEM_READER_OWNED), sem);
@@ -794,34 +770,38 @@ static inline int __down_read_trylock(st
  */
 static inline void __down_write(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
-						 RWSEM_WRITER_LOCKED)))
-		rwsem_down_write_failed(sem);
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (unlikely(atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+						     RWSEM_WRITER_LOCKED)))
+		rwsem_down_write_slow(sem, TASK_UNINTERRUPTIBLE);
 	rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
-						 RWSEM_WRITER_LOCKED)))
-		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (unlikely(atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+						     RWSEM_WRITER_LOCKED))) {
+		if (IS_ERR(rwsem_down_write_slow(sem, TASK_KILLABLE)))
 			return -EINTR;
+	}
 	rwsem_set_owner(sem);
 	return 0;
 }
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
+	long tmp = RWSEM_UNLOCKED_VALUE;
 
 	lockevent_inc(rwsem_wtrylock);
-	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
-					  RWSEM_WRITER_LOCKED);
-	if (tmp == RWSEM_UNLOCKED_VALUE) {
-		rwsem_set_owner(sem);
-		return true;
-	}
-	return false;
+	if (!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+					     RWSEM_WRITER_LOCKED))
+		return false;
+
+	rwsem_set_owner(sem);
+	return true;
 }
 
 /*
@@ -831,12 +811,11 @@ inline void __up_read(struct rw_semaphor
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
-	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
-			== RWSEM_FLAG_WAITERS))
+	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
+		     RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 
@@ -848,7 +827,7 @@ static inline void __up_write(struct rw_
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
 	if (unlikely(atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED,
-			&sem->count) & RWSEM_FLAG_WAITERS))
+						   &sem->count) & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
 

Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534EC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3559721738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfDETWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:22:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731922AbfDETWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:22:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECA083087BA1;
        Fri,  5 Apr 2019 19:22:20 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A175561367;
        Fri,  5 Apr 2019 19:22:19 +0000 (UTC)
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
Subject: [PATCH-tip v2 09/12] locking/rwsem: Add more rwsem owner access helpers
Date:   Fri,  5 Apr 2019 15:21:12 -0400
Message-Id: <20190405192115.17416-10-longman@redhat.com>
In-Reply-To: <20190405192115.17416-1-longman@redhat.com>
References: <20190405192115.17416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 05 Apr 2019 19:22:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before combining owner and count, we are adding two new helpers for
accessing the owner value in the rwsem.

 1) struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
 2) bool is_rwsem_reader_owned(struct rw_semaphore *sem)

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 15 ++++++++++-----
 kernel/locking/rwsem.c      |  3 +--
 kernel/locking/rwsem.h      | 32 ++++++++++++++++++++++++++------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index bc3fd14cf354..a9756e3e3a73 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -312,7 +312,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	preempt_disable();
 	rcu_read_lock();
-	owner = READ_ONCE(sem->owner);
+	owner = rwsem_get_owner(sem);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
 		     (is_rwsem_owner_reader(owner) || owner_on_cpu(owner));
@@ -344,15 +344,21 @@ enum owner_state {
 
 static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
-	struct task_struct *owner = READ_ONCE(sem->owner);
+	struct task_struct *owner = rwsem_get_owner(sem);
 	long count;
 
 	if (!is_rwsem_owner_spinnable(owner))
 		return OWNER_NONSPINNABLE;
 
 	rcu_read_lock();
-	while (owner && !is_rwsem_owner_reader(owner)
-		     && (READ_ONCE(sem->owner) == owner)) {
+	while (owner && !is_rwsem_owner_reader(owner)) {
+		struct task_struct *new_owner = rwsem_get_owner(sem);
+
+		if (new_owner != owner) {
+			owner = new_owner;
+			break;	/* The owner has changed */
+		}
+
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -379,7 +385,6 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	 * spinning except when here is no active locks and the handoff bit
 	 * is set. In this case, we have to stop spinning.
 	 */
-	owner = READ_ONCE(sem->owner);
 	if (!is_rwsem_owner_spinnable(owner))
 		return OWNER_NONSPINNABLE;
 	if (owner && !is_rwsem_owner_reader(owner))
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ccbf18f560ff..38d24676e01c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -198,8 +198,7 @@ EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	__up_read(sem);
 }
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 1398799b7547..bbb8a266dd50 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -92,6 +92,11 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 	WRITE_ONCE(sem->owner, NULL);
 }
 
+static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
+{
+	return READ_ONCE(sem->owner);
+}
+
 /*
  * The task_struct pointer of the last owning reader will be left in
  * the owner field.
@@ -136,6 +141,23 @@ static inline bool is_rwsem_spinnable(struct rw_semaphore *sem)
 	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
 }
 
+/*
+ * Return true if the rwsem is owned by a reader.
+ */
+static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
+{
+#ifdef CONFIG_DEBUG_RWSEMS
+	/*
+	 * Check the count to see if it is write-locked.
+	 */
+	long count = atomic_long_read(&sem->count);
+
+	if (count & RWSEM_WRITER_MASK)
+		return false;
+#endif
+	return (unsigned long)sem->owner & RWSEM_READER_OWNED;
+}
+
 /*
  * Return true if rwsem is owned by an anonymous writer or readers.
  */
@@ -156,6 +178,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
 						   | RWSEM_ANONYMOUSLY_OWNED;
+
 	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
 				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
@@ -218,8 +241,7 @@ static inline void __down_read(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_failed(sem);
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -231,8 +253,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -299,8 +320,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
-- 
2.18.1


Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C6C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0283D2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfDMRYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbfDMRYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A2B81FE32B;
        Sat, 13 Apr 2019 17:24:02 +0000 (UTC)
Received: from llong.com (ovpn-120-133.rdu2.redhat.com [10.10.120.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BBCC5D9CD;
        Sat, 13 Apr 2019 17:24:01 +0000 (UTC)
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
Subject: [PATCH v4 13/16] locking/rwsem: Add more rwsem owner access helpers
Date:   Sat, 13 Apr 2019 13:22:56 -0400
Message-Id: <20190413172259.2740-14-longman@redhat.com>
In-Reply-To: <20190413172259.2740-1-longman@redhat.com>
References: <20190413172259.2740-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 13 Apr 2019 17:24:02 +0000 (UTC)
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
 kernel/locking/rwsem.c | 50 +++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 8b23009e6b2c..ab26aba65371 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -130,6 +130,11 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
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
@@ -174,6 +179,23 @@ static inline bool is_rwsem_spinnable(struct rw_semaphore *sem)
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
@@ -193,6 +215,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
 						   | RWSEM_ANONYMOUSLY_OWNED;
+
 	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
 				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
@@ -530,7 +553,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	preempt_disable();
 	rcu_read_lock();
-	owner = READ_ONCE(sem->owner);
+	owner = rwsem_get_owner(sem);
 	if (owner) {
 		ret = is_rwsem_owner_spinnable(owner) &&
 		     (is_rwsem_owner_reader(owner) || owner_on_cpu(owner));
@@ -562,15 +585,21 @@ enum owner_state {
 
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
@@ -597,7 +626,6 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	 * spinning except when here is no active locks and the handoff bit
 	 * is set. In this case, we have to stop spinning.
 	 */
-	owner = READ_ONCE(sem->owner);
 	if (!is_rwsem_owner_spinnable(owner))
 		return OWNER_NONSPINNABLE;
 	if (owner && !is_rwsem_owner_reader(owner))
@@ -1093,8 +1121,7 @@ inline void __down_read(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_failed(sem);
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -1106,8 +1133,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -1174,8 +1200,7 @@ inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS))
@@ -1382,8 +1407,7 @@ EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
-				sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	__up_read(sem);
 }
 EXPORT_SYMBOL(up_read_non_owner);
-- 
2.18.1


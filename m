Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C1C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52AC2067D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfD1P7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfD1P7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BF5F30B4A09;
        Sun, 28 Apr 2019 15:59:15 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C1D2620DF;
        Sun, 28 Apr 2019 15:59:12 +0000 (UTC)
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
Subject: [PATCH-tip v6 16/20] locking/rwsem: Add more rwsem owner access helpers
Date:   Sun, 28 Apr 2019 11:57:51 -0400
Message-Id: <20190428155755.14267-17-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 28 Apr 2019 15:59:15 +0000 (UTC)
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
 kernel/locking/rwsem.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 04156b62d1d7..eadd375c89a3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -165,6 +165,11 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
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
@@ -218,6 +223,23 @@ static inline struct task_struct *owner_without_flags(struct task_struct *owner)
 	return (struct task_struct *)((long)owner & ~RWSEM_OWNER_FLAGS_MASK);
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
 #ifdef CONFIG_DEBUG_RWSEMS
 /*
  * With CONFIG_DEBUG_RWSEMS configured, it will make sure that if there
@@ -230,7 +252,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 	unsigned long owner = (unsigned long)READ_ONCE(sem->owner);
 
 	if ((owner & ~RWSEM_OWNER_FLAGS_MASK) == (unsigned long)current)
-		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
+		cmpxchg_relaxed((unsigned long *)&sem->owner, owner,
 				owner & RWSEM_OWNER_FLAGS_MASK);
 }
 #else
@@ -613,7 +635,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem, bool wr)
 	preempt_disable();
 	rcu_read_lock();
 
-	owner = READ_ONCE(sem->owner);
+	owner = rwsem_get_owner(sem);
 	if (!is_rwsem_owner_spinnable(owner, wr))
 		ret = false;
 	else if ((unsigned long)owner & RWSEM_READER_OWNED)
@@ -663,7 +685,7 @@ static inline enum owner_state rwsem_owner_state(unsigned long owner, bool wr)
 static noinline enum owner_state
 rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 {
-	struct task_struct *tmp, *owner = READ_ONCE(sem->owner);
+	struct task_struct *tmp, *owner = rwsem_get_owner(sem);
 	enum owner_state state = rwsem_owner_state((unsigned long)owner, wr);
 
 	if (state != OWNER_WRITER)
@@ -676,7 +698,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, bool wr)
 			break;
 		}
 
-		tmp = READ_ONCE(sem->owner);
+		tmp = rwsem_get_owner(sem);
 		if (tmp != owner) {
 			state = rwsem_owner_state((unsigned long)tmp, wr);
 			break;
@@ -1275,8 +1297,7 @@ inline void __down_read(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -1288,8 +1309,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
 			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED), sem);
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -1360,7 +1380,7 @@ inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED), sem);
+	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
@@ -1574,8 +1594,7 @@ EXPORT_SYMBOL(down_write_killable_nested);
 
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


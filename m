Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE289C4321B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B3220881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfD1P6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:58:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfD1P6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:58:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8811C30BC73C;
        Sun, 28 Apr 2019 15:58:31 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1870A63B90;
        Sun, 28 Apr 2019 15:58:30 +0000 (UTC)
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
Subject: [PATCH-tip v6 02/20] locking/rwsem: Make owner available even if !CONFIG_RWSEM_SPIN_ON_OWNER
Date:   Sun, 28 Apr 2019 11:57:37 -0400
Message-Id: <20190428155755.14267-3-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 28 Apr 2019 15:58:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The owner field in the rw_semaphore structure is used primarily for
optimistic spinning. However, identifying the rwsem owner can also be
helpful in debugging as well as tracing locking related issues when
analyzing crash dump. The owner field may also store state information
that can be important to the operation of the rwsem.

So the owner field is now made a permanent member of the rw_semaphore
structure irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h       |  9 +++++----
 kernel/locking/rwsem-xadd.c |  2 +-
 kernel/locking/rwsem.h      | 23 -----------------------
 lib/Kconfig.debug           |  8 ++++----
 4 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 2ea18a3def04..148983e21d47 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -34,12 +34,12 @@
  */
 struct rw_semaphore {
 	atomic_long_t count;
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	/*
-	 * Write owner. Used as a speculative check to see
-	 * if the owner is running on the cpu.
+	 * Write owner or one of the read owners. Can be used as a
+	 * speculative check to see if the owner is running on the cpu.
 	 */
 	struct task_struct *owner;
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* spinner MCS lock */
 #endif
 	raw_spinlock_t wait_lock;
@@ -73,13 +73,14 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 #endif
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-#define __RWSEM_OPT_INIT(lockname) , .osq = OSQ_LOCK_UNLOCKED, .owner = NULL
+#define __RWSEM_OPT_INIT(lockname) , .osq = OSQ_LOCK_UNLOCKED
 #else
 #define __RWSEM_OPT_INIT(lockname)
 #endif
 
 #define __RWSEM_INITIALIZER(name)				\
 	{ __RWSEM_INIT_COUNT(name),				\
+	  .owner = NULL,					\
 	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
 	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock)	\
 	  __RWSEM_OPT_INIT(name)				\
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index cab5b1f6b2de..b4df2ce7262f 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -86,8 +86,8 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	raw_spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	sem->owner = NULL;
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	osq_lock_init(&sem->osq);
 #endif
 }
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 64877f5294e3..eb9c8534299b 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -61,7 +61,6 @@
 #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
 
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
  * store tearing can't happen as optimistic spinners may read and use
@@ -126,7 +125,6 @@ static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
  * real owner or one of the real owners. The only exception is when the
  * unlock is done by up_read_non_owner().
  */
-#define rwsem_clear_reader_owned rwsem_clear_reader_owned
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
@@ -135,28 +133,7 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
 				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
 }
-#endif
-
 #else
-static inline void rwsem_set_owner(struct rw_semaphore *sem)
-{
-}
-
-static inline void rwsem_clear_owner(struct rw_semaphore *sem)
-{
-}
-
-static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
-					   struct task_struct *owner)
-{
-}
-
-static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
-{
-}
-#endif
-
-#ifndef rwsem_clear_reader_owned
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..2047f3884540 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1067,7 +1067,7 @@ config PROVE_LOCKING
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_RWSEMS if RWSEM_SPIN_ON_OWNER
+	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
 	select TRACE_IRQFLAGS
@@ -1171,10 +1171,10 @@ config DEBUG_WW_MUTEX_SLOWPATH
 
 config DEBUG_RWSEMS
 	bool "RW Semaphore debugging: basic checks"
-	depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
+	depends on DEBUG_KERNEL
 	help
-	  This debugging feature allows mismatched rw semaphore locks and unlocks
-	  to be detected and reported.
+	  This debugging feature allows mismatched rw semaphore locks
+	  and unlocks to be detected and reported.
 
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
-- 
2.18.1


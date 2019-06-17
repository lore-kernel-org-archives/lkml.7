Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB7C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5F52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b2JlNq+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfFQOYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:24:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFQOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:24:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HENZ7g3453944
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:23:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HENZ7g3453944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781416;
        bh=DNz9ty4/+N8ctU2rQhJYbF/lEQkP6p7nDft/oug9e2w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b2JlNq+2n3d7jjgsbKgswayyL4fWGTJYj43AyMMis/qGQ6ICBGXovMxtEP58Wtozo
         e7d+lVUVmE/Eh1AIH6agyF6mf+RaynRQV5H9ofz9TpYJ4Bm66iO78bQwBeUMCjQBSQ
         AgS9TX6nV5lm697PMC69TXQJ9XulBd0ZdL7Ge+1wD1Q99aXdMpmGuji6XZuYkLR+IV
         /u2s2yJi9RBJXv1SrOLKpcRH3+Dxsydg9FgjoKbokADb8J9plQUBD4O5mhy2UOiou3
         EjOoeUsDihHp3brogz/oy/hGFJ3j8VS31cOx5/FJoAycxuAtDauVW2jmCgnxfZt/+b
         6TgbbYl8g+N3A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HENZlV3453941;
        Mon, 17 Jun 2019 07:23:35 -0700
Date:   Mon, 17 Jun 2019 07:23:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-c71fd893f614f205dbc050d60299cc5496491c19@git.kernel.org>
Cc:     dave@stgolabs.net, longman@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
        bp@alien8.de, torvalds@linux-foundation.org,
        huang.ying.caritas@gmail.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, will.deacon@arm.com
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          dave@stgolabs.net, mingo@kernel.org, tglx@linutronix.de,
          will.deacon@arm.com, hpa@zytor.com, bp@alien8.de,
          tim.c.chen@linux.intel.com, longman@redhat.com,
          huang.ying.caritas@gmail.com, peterz@infradead.org
In-Reply-To: <20190520205918.22251-2-longman@redhat.com>
References: <20190520205918.22251-2-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Git-Commit-ID: c71fd893f614f205dbc050d60299cc5496491c19
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

Commit-ID:  c71fd893f614f205dbc050d60299cc5496491c19
Gitweb:     https://git.kernel.org/tip/c71fd893f614f205dbc050d60299cc5496491c19
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:00 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:27:54 +0200

locking/rwsem: Make owner available even if !CONFIG_RWSEM_SPIN_ON_OWNER

The owner field in the rw_semaphore structure is used primarily for
optimistic spinning. However, identifying the rwsem owner can also be
helpful in debugging as well as tracing locking related issues when
analyzing crash dump. The owner field may also store state information
that can be important to the operation of the rwsem.

So the owner field is now made a permanent member of the rw_semaphore
structure irrespective of CONFIG_RWSEM_SPIN_ON_OWNER.

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
Link: https://lkml.kernel.org/r/20190520205918.22251-2-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index 0b1f77957240..c0500679fd2f 100644
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
index cbdfae379896..417bdd9e80fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1095,7 +1095,7 @@ config PROVE_LOCKING
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_RWSEMS if RWSEM_SPIN_ON_OWNER
+	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
 	select TRACE_IRQFLAGS
@@ -1199,10 +1199,10 @@ config DEBUG_WW_MUTEX_SLOWPATH
 
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

Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D778C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BC3214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WDUuOoFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfHFNF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:05:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbfHFNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:05:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x76D55T42187379
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 06:05:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x76D55T42187379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565096706;
        bh=jwysfKJpBfuuAv79uT+h0gRc9vi8QNkGFJjSmW9eNa4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WDUuOoFzrCIeWWJBIe/LaLhEeA/YtFWeXf99d+VFu634E3m36DK2NjmoTEm/9z9p6
         K9HoQh9mhHyF/hGJ0Zzb1S/D72EYPTsxcdFAJd5xB6Zdb3IVUAk9bwqFlEfml/HFWr
         jkN5BfJqwE54ZK762zjONkRKNWR96ST+uBBZMjH1wYmG6vO+lEVV5lGHw5/Z6SMwBZ
         +I2pu8miJ/yIxdlLBCr312zqvNzBUKWO20yPU6QXTgPjSMrAgKlarcn9VPRnN6Vvb+
         SciQYupDN9VtHOPrn2UWGPE+tm+P3nQ7PrQa0oxEViWvEo/tsA/Y2Esa22F+NxFGy+
         SmHazPU+Lq7eQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x76D55T02187374;
        Tue, 6 Aug 2019 06:05:05 -0700
Date:   Tue, 6 Aug 2019 06:05:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-fce45cd41101f1a9620267146b21f09b3454d8db@git.kernel.org>
Cc:     hpa@zytor.com, dave@stgolabs.net, linux-kernel@vger.kernel.org,
        mingo@kernel.org, longman@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, dbueso@suse.de
Reply-To: tglx@linutronix.de, dbueso@suse.de, peterz@infradead.org,
          hpa@zytor.com, dave@stgolabs.net, linux-kernel@vger.kernel.org,
          longman@redhat.com, mingo@kernel.org
In-Reply-To: <20190729044735.9632-1-dave@stgolabs.net>
References: <20190729044735.9632-1-dave@stgolabs.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Check for operations on an
 uninitialized rwsem
Git-Commit-ID: fce45cd41101f1a9620267146b21f09b3454d8db
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

Commit-ID:  fce45cd41101f1a9620267146b21f09b3454d8db
Gitweb:     https://git.kernel.org/tip/fce45cd41101f1a9620267146b21f09b3454d8db
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Sun, 28 Jul 2019 21:47:35 -0700
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 6 Aug 2019 12:49:15 +0200

locking/rwsem: Check for operations on an uninitialized rwsem

Currently rwsems is the only locking primitive that lacks this
debug feature. Add it under CONFIG_DEBUG_RWSEMS and do the magic
checking in the locking fastpath (trylock) operation such that
we cover all cases. The unlocking part is pretty straightforward.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: mingo@kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lkml.kernel.org/r/20190729044735.9632-1-dave@stgolabs.net
---
 include/linux/rwsem.h  | 10 ++++++++++
 kernel/locking/rwsem.c | 22 ++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 9d9c663987d8..00d6054687dd 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -45,6 +45,9 @@ struct rw_semaphore {
 #endif
 	raw_spinlock_t wait_lock;
 	struct list_head wait_list;
+#ifdef CONFIG_DEBUG_RWSEMS
+	void *magic;
+#endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -73,6 +76,12 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 # define __RWSEM_DEP_MAP_INIT(lockname)
 #endif
 
+#ifdef CONFIG_DEBUG_RWSEMS
+# define __DEBUG_RWSEM_INITIALIZER(lockname) , .magic = &lockname
+#else
+# define __DEBUG_RWSEM_INITIALIZER(lockname)
+#endif
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #define __RWSEM_OPT_INIT(lockname) , .osq = OSQ_LOCK_UNLOCKED
 #else
@@ -85,6 +94,7 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
 	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock)	\
 	  __RWSEM_OPT_INIT(name)				\
+	  __DEBUG_RWSEM_INITIALIZER(name)			\
 	  __RWSEM_DEP_MAP_INIT(name) }
 
 #define DECLARE_RWSEM(name) \
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 354238a08b7a..eef04551eae7 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -105,8 +105,9 @@
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
 	if (!debug_locks_silent &&				\
-	    WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
+	    WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, magic = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
 		#c, atomic_long_read(&(sem)->count),		\
+		(unsigned long) sem->magic,			\
 		atomic_long_read(&(sem)->owner), (long)current,	\
 		list_empty(&(sem)->wait_list) ? "" : "not "))	\
 			debug_locks_off();			\
@@ -329,6 +330,9 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 	 */
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
+#ifdef CONFIG_DEBUG_RWSEMS
+	sem->magic = sem;
 #endif
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	raw_spin_lock_init(&sem->wait_lock);
@@ -1358,11 +1362,14 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
+	long tmp;
+
+	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
+
 	/*
 	 * Optimize for the case when the rwsem is not locked at all.
 	 */
-	long tmp = RWSEM_UNLOCKED_VALUE;
-
+	tmp = RWSEM_UNLOCKED_VALUE;
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 					tmp + RWSEM_READER_BIAS)) {
@@ -1403,8 +1410,11 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
-	long tmp = RWSEM_UNLOCKED_VALUE;
+	long tmp;
 
+	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
+
+	tmp  = RWSEM_UNLOCKED_VALUE;
 	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 					    RWSEM_WRITER_LOCKED)) {
 		rwsem_set_owner(sem);
@@ -1420,7 +1430,9 @@ inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
+
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
@@ -1438,12 +1450,14 @@ static inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 	/*
 	 * sem->owner may differ from current if the ownership is transferred
 	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
 	 */
 	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
 			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
+
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))

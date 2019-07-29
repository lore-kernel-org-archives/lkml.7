Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1B21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfG2Erq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:47:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:57338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfG2Erp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:47:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3B2BAC2E;
        Mon, 29 Jul 2019 04:47:43 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     longman@redhat.com, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -tip] locking/rwsem: Check for operations on an uninitialized rwsem
Date:   Sun, 28 Jul 2019 21:47:35 -0700
Message-Id: <20190729044735.9632-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rwsems is the only locking primitive that lacks this
debug feature. Add it under CONFIG_DEBUG_RWSEMS and do the magic
checking in the locking fastpath (trylock) operation such that
we cover all cases. The unlocking part is pretty straightforward.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
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
index 37524a47f002..ab392ec51252 100644
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
@@ -1322,11 +1326,14 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 
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
@@ -1367,8 +1374,11 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
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
@@ -1384,7 +1394,9 @@ inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
+
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
 	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
@@ -1402,12 +1414,14 @@ static inline void __up_write(struct rw_semaphore *sem)
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
-- 
2.16.4


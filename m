Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43541C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1128520857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfDPKEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:04:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55659 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfDPKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:04:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA1nlE3397546
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:01:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA1mvX3397542;
        Tue, 16 Apr 2019 03:01:48 -0700
Date:   Tue, 16 Apr 2019 03:01:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-c7580c1e84435c9ccc6c612d9fee8e71811f7be6@git.kernel.org>
Cc:     longman@redhat.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, paulmck@linux.vnet.ibm.com, dave@stgolabs.net,
        peterz@infradead.org, torvalds@linux-foundation.org,
        dbueso@suse.de, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        tim.c.chen@linux.intel.com, a.p.zijlstra@chello.nl,
        tglx@linutronix.de, mingo@kernel.org, akpm@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, will.deacon@arm.com,
          paulmck@linux.vnet.ibm.com, longman@redhat.com,
          peterz@infradead.org, dave@stgolabs.net, dbueso@suse.de,
          torvalds@linux-foundation.org, tim.c.chen@linux.intel.com,
          a.p.zijlstra@chello.nl, hpa@zytor.com, bp@alien8.de,
          arnd@arndb.de, mingo@kernel.org, akpm@linux-foundation.org,
          tglx@linutronix.de
In-Reply-To: <20190404174320.22416-3-longman@redhat.com>
References: <20190404174320.22416-3-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Move owner setting code from
 rwsem.c to rwsem.h
Git-Commit-ID: c7580c1e84435c9ccc6c612d9fee8e71811f7be6
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

Commit-ID:  c7580c1e84435c9ccc6c612d9fee8e71811f7be6
Gitweb:     https://git.kernel.org/tip/c7580c1e84435c9ccc6c612d9fee8e71811f7be6
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:11 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:55:59 +0200

locking/rwsem: Move owner setting code from rwsem.c to rwsem.h

Move all the owner setting code closer to the rwsem-xadd fast paths
directly within rwsem.h file as well as in the slowpaths where owner
setting is done after acquring the lock. This will enable us to add
DEBUG_RWSEMS check in a later patch to make sure that read lock is
really acquired when rwsem_down_read_failed() returns, for instance.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20190404174320.22416-3-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem-xadd.c |  6 +++---
 kernel/locking/rwsem.c      | 19 ++-----------------
 kernel/locking/rwsem.h      | 17 +++++++++++++++--
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 0d518b52ade4..c213869e1aa7 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -176,9 +176,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 			goto try_reader_grant;
 		}
 		/*
-		 * It is not really necessary to set it to reader-owned here,
-		 * but it gives the spinners an early indication that the
-		 * readers now have the lock.
+		 * Set it to reader-owned to give spinners an early
+		 * indication that readers now have the lock.
 		 */
 		__rwsem_set_reader_owned(sem, waiter->task);
 	}
@@ -441,6 +440,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 		 */
 		if (atomic_long_read(&sem->count) >= 0) {
 			raw_spin_unlock_irq(&sem->wait_lock);
+			rwsem_set_reader_owned(sem);
 			return sem;
 		}
 		adjustment += RWSEM_WAITING_BIAS;
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e586f0d03ad3..59e584895532 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -24,7 +24,6 @@ void __sched down_read(struct rw_semaphore *sem)
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
-	rwsem_set_reader_owned(sem);
 }
 
 EXPORT_SYMBOL(down_read);
@@ -39,7 +38,6 @@ int __sched down_read_killable(struct rw_semaphore *sem)
 		return -EINTR;
 	}
 
-	rwsem_set_reader_owned(sem);
 	return 0;
 }
 
@@ -52,10 +50,8 @@ int down_read_trylock(struct rw_semaphore *sem)
 {
 	int ret = __down_read_trylock(sem);
 
-	if (ret == 1) {
+	if (ret == 1)
 		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
-		rwsem_set_reader_owned(sem);
-	}
 	return ret;
 }
 
@@ -70,7 +66,6 @@ void __sched down_write(struct rw_semaphore *sem)
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
-	rwsem_set_owner(sem);
 }
 
 EXPORT_SYMBOL(down_write);
@@ -88,7 +83,6 @@ int __sched down_write_killable(struct rw_semaphore *sem)
 		return -EINTR;
 	}
 
-	rwsem_set_owner(sem);
 	return 0;
 }
 
@@ -101,10 +95,8 @@ int down_write_trylock(struct rw_semaphore *sem)
 {
 	int ret = __down_write_trylock(sem);
 
-	if (ret == 1) {
+	if (ret == 1)
 		rwsem_acquire(&sem->dep_map, 0, 1, _RET_IP_);
-		rwsem_set_owner(sem);
-	}
 
 	return ret;
 }
@@ -119,7 +111,6 @@ void up_read(struct rw_semaphore *sem)
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 
-	rwsem_clear_reader_owned(sem);
 	__up_read(sem);
 }
 
@@ -133,7 +124,6 @@ void up_write(struct rw_semaphore *sem)
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
-	rwsem_clear_owner(sem);
 	__up_write(sem);
 }
 
@@ -147,7 +137,6 @@ void downgrade_write(struct rw_semaphore *sem)
 	lock_downgrade(&sem->dep_map, _RET_IP_);
 	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
-	rwsem_set_reader_owned(sem);
 	__downgrade_write(sem);
 }
 
@@ -161,7 +150,6 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
-	rwsem_set_reader_owned(sem);
 }
 
 EXPORT_SYMBOL(down_read_nested);
@@ -172,7 +160,6 @@ void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 	rwsem_acquire_nest(&sem->dep_map, 0, 0, nest, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
-	rwsem_set_owner(sem);
 }
 
 EXPORT_SYMBOL(_down_write_nest_lock);
@@ -193,7 +180,6 @@ void down_write_nested(struct rw_semaphore *sem, int subclass)
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
 
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
-	rwsem_set_owner(sem);
 }
 
 EXPORT_SYMBOL(down_write_nested);
@@ -208,7 +194,6 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 		return -EINTR;
 	}
 
-	rwsem_set_owner(sem);
 	return 0;
 }
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 1f5775aa6a1d..ee24c4f257a5 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -160,6 +160,8 @@ static inline void __down_read(struct rw_semaphore *sem)
 {
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
 		rwsem_down_read_failed(sem);
+	else
+		rwsem_set_reader_owned(sem);
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
@@ -167,8 +169,9 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
+	} else {
+		rwsem_set_reader_owned(sem);
 	}
-
 	return 0;
 }
 
@@ -182,6 +185,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 					tmp + RWSEM_ACTIVE_READ_BIAS)) {
+			rwsem_set_reader_owned(sem);
 			return 1;
 		}
 	} while (tmp >= 0);
@@ -199,6 +203,7 @@ static inline void __down_write(struct rw_semaphore *sem)
 					     &sem->count);
 	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
 		rwsem_down_write_failed(sem);
+	rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
@@ -210,6 +215,7 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
 		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
 			return -EINTR;
+	rwsem_set_owner(sem);
 	return 0;
 }
 
@@ -219,7 +225,11 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 
 	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
 		      RWSEM_ACTIVE_WRITE_BIAS);
-	return tmp == RWSEM_UNLOCKED_VALUE;
+	if (tmp == RWSEM_UNLOCKED_VALUE) {
+		rwsem_set_owner(sem);
+		return true;
+	}
+	return false;
 }
 
 /*
@@ -229,6 +239,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_dec_return_release(&sem->count);
 	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
 		rwsem_wake(sem);
@@ -239,6 +250,7 @@ static inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	rwsem_clear_owner(sem);
 	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
 						    &sem->count) < 0))
 		rwsem_wake(sem);
@@ -259,6 +271,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * write side. As such, rely on RELEASE semantics.
 	 */
 	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
+	rwsem_set_reader_owned(sem);
 	if (tmp < 0)
 		rwsem_downgrade_wake(sem);
 }

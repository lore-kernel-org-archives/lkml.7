Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57F1206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfDPKJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:09:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41047 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfDPKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:09:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA7UwN3401060
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:07:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA7U8F3401057;
        Tue, 16 Apr 2019 03:07:30 -0700
Date:   Tue, 16 Apr 2019 03:07:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-a8654596f0371c2604c4d475422c48f4fc6a56c9@git.kernel.org>
Cc:     tglx@linutronix.de, will.deacon@arm.com, a.p.zijlstra@chello.nl,
        peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, dbueso@suse.de, dave@stgolabs.net,
        bp@alien8.de, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, longman@redhat.com, arnd@arndb.de
Reply-To: dave@stgolabs.net, bp@alien8.de, dbueso@suse.de,
          torvalds@linux-foundation.org, tim.c.chen@linux.intel.com,
          hpa@zytor.com, longman@redhat.com, paulmck@linux.vnet.ibm.com,
          arnd@arndb.de, will.deacon@arm.com, tglx@linutronix.de,
          a.p.zijlstra@chello.nl, peterz@infradead.org,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          mingo@kernel.org
In-Reply-To: <20190404174320.22416-11-longman@redhat.com>
References: <20190404174320.22416-11-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Enable lock event counting
Git-Commit-ID: a8654596f0371c2604c4d475422c48f4fc6a56c9
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

Commit-ID:  a8654596f0371c2604c4d475422c48f4fc6a56c9
Gitweb:     https://git.kernel.org/tip/a8654596f0371c2604c4d475422c48f4fc6a56c9
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:19 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:56:06 +0200

locking/rwsem: Enable lock event counting

Add lock event counting calls so that we can track the number of lock
events happening in the rwsem code.

With CONFIG_LOCK_EVENT_COUNTS on and booting a 4-socket 112-thread x86-64
system, the rwsem counts after system bootup were as follows:

  rwsem_opt_fail=261
  rwsem_opt_wlock=50636
  rwsem_rlock=445
  rwsem_rlock_fail=0
  rwsem_rlock_fast=22
  rwsem_rtrylock=810144
  rwsem_sleep_reader=441
  rwsem_sleep_writer=310
  rwsem_wake_reader=355
  rwsem_wake_writer=2335
  rwsem_wlock=261
  rwsem_wlock_fail=0
  rwsem_wtrylock=20583

It can be seen that most of the lock acquisitions in the slowpath were
write-locks in the optimistic spinning code path with no sleeping at
all. For this system, over 97% of the locks are acquired via optimistic
spinning. It illustrates the importance of optimistic spinning in
improving the performance of rwsem.

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
Link: http://lkml.kernel.org/r/20190404174320.22416-11-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig                      |  1 -
 kernel/locking/lock_events_list.h | 17 +++++++++++++++++
 kernel/locking/rwsem-xadd.c       | 11 +++++++++++
 kernel/locking/rwsem.h            |  4 ++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 28c0f1ad80d7..02cb4e6a3e38 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -904,7 +904,6 @@ config ARCH_USE_MEMREMAP_PROT
 config LOCK_EVENT_COUNTS
 	bool "Locking event counts collection"
 	depends on DEBUG_FS
-	depends on QUEUED_SPINLOCKS
 	---help---
 	  Enable light-weight counting of various locking related events
 	  in the system with minimal performance impact. This reduces
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 8b4d2e180475..ad7668cfc9da 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -48,3 +48,20 @@ LOCK_EVENT(lock_use_node3)	/* # of locking ops that use 3rd percpu node */
 LOCK_EVENT(lock_use_node4)	/* # of locking ops that use 4th percpu node */
 LOCK_EVENT(lock_no_node)	/* # of locking ops w/o using percpu node    */
 #endif /* CONFIG_QUEUED_SPINLOCKS */
+
+/*
+ * Locking events for rwsem
+ */
+LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
+LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
+LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
+LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
+LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
+LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
+LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
+LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
+LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
+LOCK_EVENT(rwsem_rtrylock)	/* # of read trylock calls		*/
+LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
+LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
+LOCK_EVENT(rwsem_wtrylock)	/* # of write trylock calls		*/
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index f6198e1a58f6..6b3ee9948bf1 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -147,6 +147,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 			 * will notice the queued writer.
 			 */
 			wake_q_add(wake_q, waiter->task);
+			lockevent_inc(rwsem_wake_writer);
 		}
 
 		return;
@@ -214,6 +215,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
+	lockevent_cond_inc(rwsem_wake_reader, woken);
 	if (list_empty(&sem->wait_list)) {
 		/* hit end of list above */
 		adjustment -= RWSEM_WAITING_BIAS;
@@ -265,6 +267,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count + RWSEM_ACTIVE_WRITE_BIAS)) {
 			rwsem_set_owner(sem);
+			lockevent_inc(rwsem_opt_wlock);
 			return true;
 		}
 	}
@@ -389,6 +392,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	osq_unlock(&sem->osq);
 done:
 	preempt_enable();
+	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
 
@@ -436,6 +440,7 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 		if (atomic_long_read(&sem->count) >= 0) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
+			lockevent_inc(rwsem_rlock_fast);
 			return sem;
 		}
 		adjustment += RWSEM_WAITING_BIAS;
@@ -472,9 +477,11 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 			break;
 		}
 		schedule();
+		lockevent_inc(rwsem_sleep_reader);
 	}
 
 	__set_current_state(TASK_RUNNING);
+	lockevent_inc(rwsem_rlock);
 	return sem;
 out_nolock:
 	list_del(&waiter.list);
@@ -482,6 +489,7 @@ out_nolock:
 		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
+	lockevent_inc(rwsem_rlock_fail);
 	return ERR_PTR(-EINTR);
 }
 
@@ -575,6 +583,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 				goto out_nolock;
 
 			schedule();
+			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
 		} while ((count = atomic_long_read(&sem->count)) & RWSEM_ACTIVE_MASK);
 
@@ -583,6 +592,7 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
+	lockevent_inc(rwsem_wlock);
 
 	return ret;
 
@@ -596,6 +606,7 @@ out_nolock:
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
+	lockevent_inc(rwsem_wlock_fail);
 
 	return ERR_PTR(-EINTR);
 }
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 3059a2dc39f8..37db17890e36 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -23,6 +23,8 @@
  * is involved. Ideally we would like to track all the readers that own
  * a rwsem, but the overhead is simply too big.
  */
+#include "lock_events.h"
+
 #define RWSEM_READER_OWNED	(1UL << 0)
 #define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
 
@@ -200,6 +202,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	 */
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
+	lockevent_inc(rwsem_rtrylock);
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 					tmp + RWSEM_ACTIVE_READ_BIAS)) {
@@ -241,6 +244,7 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	lockevent_inc(rwsem_wtrylock);
 	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
 		      RWSEM_ACTIVE_WRITE_BIAS);
 	if (tmp == RWSEM_UNLOCKED_VALUE) {

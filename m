Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E754C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12547206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfDPKGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:06:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56559 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfDPKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:06:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA4f0G3400483
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:04:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA4fai3400480;
        Tue, 16 Apr 2019 03:04:41 -0700
Date:   Tue, 16 Apr 2019 03:04:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-3b4ba6643d26a95e08067fca9a5da1828f9afabf@git.kernel.org>
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        dbueso@suse.de, paulmck@linux.vnet.ibm.com, dave@stgolabs.net,
        hpa@zytor.com, a.p.zijlstra@chello.nl, bp@alien8.de,
        tim.c.chen@linux.intel.com, tglx@linutronix.de,
        will.deacon@arm.com, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, longman@redhat.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, arnd@arndb.de, longman@redhat.com,
          mingo@kernel.org, akpm@linux-foundation.org, bp@alien8.de,
          a.p.zijlstra@chello.nl, will.deacon@arm.com,
          tim.c.chen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
          paulmck@linux.vnet.ibm.com, dave@stgolabs.net, dbueso@suse.de,
          torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20190404174320.22416-7-longman@redhat.com>
References: <20190404174320.22416-7-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON()
 macro
Git-Commit-ID: 3b4ba6643d26a95e08067fca9a5da1828f9afabf
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

Commit-ID:  3b4ba6643d26a95e08067fca9a5da1828f9afabf
Gitweb:     https://git.kernel.org/tip/3b4ba6643d26a95e08067fca9a5da1828f9afabf
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:15 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:56:03 +0200

locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro

Currently, the DEBUG_RWSEMS_WARN_ON() macro just dumps a stack trace
when the rwsem isn't in the right state. It does not show the actual
states of the rwsem. This may not be that helpful in the debugging
process.

Enhance the DEBUG_RWSEMS_WARN_ON() macro to also show the current
content of the rwsem count and owner fields to give more information
about what is wrong with the rwsem. The debug_locks_off() function is
called as is done inside DEBUG_LOCKS_WARN_ON().

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
Link: http://lkml.kernel.org/r/20190404174320.22416-7-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c |  3 ++-
 kernel/locking/rwsem.h | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 90de5f1780ba..ccbf18f560ff 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -198,7 +198,8 @@ EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
+				sem);
 	__up_read(sem);
 }
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 1d8f722a6761..3059a2dc39f8 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -27,9 +27,15 @@
 #define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
 
 #ifdef CONFIG_DEBUG_RWSEMS
-# define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
+# define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
+	if (WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
+		#c, atomic_long_read(&(sem)->count),		\
+		(long)((sem)->owner), (long)current,		\
+		list_empty(&(sem)->wait_list) ? "" : "not "))	\
+			debug_locks_off();			\
+	} while (0)
 #else
-# define DEBUG_RWSEMS_WARN_ON(c)
+# define DEBUG_RWSEMS_WARN_ON(c, sem)
 #endif
 
 /*
@@ -168,7 +174,7 @@ static inline void __down_read(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		rwsem_down_read_failed(sem);
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED));
+					RWSEM_READER_OWNED), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -180,7 +186,7 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
-					RWSEM_READER_OWNED));
+					RWSEM_READER_OWNED), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -251,7 +257,8 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED),
+				sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_dec_return_release(&sem->count);
 	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
@@ -263,7 +270,7 @@ static inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	rwsem_clear_owner(sem);
 	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
 						    &sem->count) < 0))
@@ -284,7 +291,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
 	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
 	if (tmp < 0)

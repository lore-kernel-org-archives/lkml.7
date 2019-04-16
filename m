Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D084C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4830206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfDPKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:06:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfDPKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:06:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA3wX83398890
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:03:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA3wOh3398885;
        Tue, 16 Apr 2019 03:03:58 -0700
Date:   Tue, 16 Apr 2019 03:03:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-a68e2c4c637918da47b3aa270051545cff7d8245@git.kernel.org>
Cc:     will.deacon@arm.com, paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        a.p.zijlstra@chello.nl, bp@alien8.de,
        torvalds@linux-foundation.org, dbueso@suse.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, arnd@arndb.de,
        tim.c.chen@linux.intel.com, dave@stgolabs.net,
        akpm@linux-foundation.org, tglx@linutronix.de, longman@redhat.com,
        peterz@infradead.org
Reply-To: dave@stgolabs.net, tim.c.chen@linux.intel.com, arnd@arndb.de,
          hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de,
          peterz@infradead.org, longman@redhat.com, mingo@kernel.org,
          a.p.zijlstra@chello.nl, paulmck@linux.vnet.ibm.com,
          will.deacon@arm.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, dbueso@suse.de, bp@alien8.de
In-Reply-To: <20190404174320.22416-6-longman@redhat.com>
References: <20190404174320.22416-6-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Add debug check for
 __down_read*()
Git-Commit-ID: a68e2c4c637918da47b3aa270051545cff7d8245
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

Commit-ID:  a68e2c4c637918da47b3aa270051545cff7d8245
Gitweb:     https://git.kernel.org/tip/a68e2c4c637918da47b3aa270051545cff7d8245
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:14 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:56:02 +0200

locking/rwsem: Add debug check for __down_read*()

When rwsem_down_read_failed*() return, the read lock is acquired
indirectly by others. So debug checks are added in __down_read() and
__down_read_killable() to make sure the rwsem is really reader-owned.

The other debug check calls in kernel/locking/rwsem.c except the
one in up_read_non_owner() are also moved over to rwsem-xadd.h.

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
Link: http://lkml.kernel.org/r/20190404174320.22416-6-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c |  3 ---
 kernel/locking/rwsem.h | 12 ++++++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 59e584895532..90de5f1780ba 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -109,7 +109,6 @@ EXPORT_SYMBOL(down_write_trylock);
 void up_read(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 
 	__up_read(sem);
 }
@@ -122,7 +121,6 @@ EXPORT_SYMBOL(up_read);
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	__up_write(sem);
 }
@@ -135,7 +133,6 @@ EXPORT_SYMBOL(up_write);
 void downgrade_write(struct rw_semaphore *sem)
 {
 	lock_downgrade(&sem->dep_map, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	__downgrade_write(sem);
 }
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 19997c82270b..1d8f722a6761 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -165,10 +165,13 @@ extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
+	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		rwsem_down_read_failed(sem);
-	else
+		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
+					RWSEM_READER_OWNED));
+	} else {
 		rwsem_set_reader_owned(sem);
+	}
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
@@ -176,6 +179,8 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
+		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
+					RWSEM_READER_OWNED));
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -246,6 +251,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_dec_return_release(&sem->count);
 	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
@@ -257,6 +263,7 @@ static inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 	rwsem_clear_owner(sem);
 	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
 						    &sem->count) < 0))
@@ -277,6 +284,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
 	if (tmp < 0)

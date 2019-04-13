Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D5EC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F243121721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDMRZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:25:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfDMRXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:23:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04DAC308A107;
        Sat, 13 Apr 2019 17:23:51 +0000 (UTC)
Received: from llong.com (ovpn-120-133.rdu2.redhat.com [10.10.120.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA1865D9C6;
        Sat, 13 Apr 2019 17:23:49 +0000 (UTC)
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
Subject: [PATCH v4 06/16] locking/rwsem: Code cleanup after files merging
Date:   Sat, 13 Apr 2019 13:22:49 -0400
Message-Id: <20190413172259.2740-7-longman@redhat.com>
In-Reply-To: <20190413172259.2740-1-longman@redhat.com>
References: <20190413172259.2740-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sat, 13 Apr 2019 17:23:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merging all the relevant rwsem code into one single file, there
are a number of optimizations and cleanups that can be done:

 1) Remove all the EXPORT_SYMBOL() calls for functions that are not
    accessed elsewhere.
 2) Remove all the __visible tags as none of the functions will be
    called from assembly code anymore.
 3) Make all the internal functions static.
 4) Remove some unneeded blank lines.

That enables the compiler to do better optimization and reduce code
size. The text+data size of rwsem.o on an x86-64 machine was reduced
from 8945 bytes to 4651 bytes with this change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 50 +++++++++---------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 5f06b0601eb6..c1a089ab19fd 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -207,7 +207,6 @@ void __init_rwsem(struct rw_semaphore *sem, const char *name,
 	osq_lock_init(&sem->osq);
 #endif
 }
-
 EXPORT_SYMBOL(__init_rwsem);
 
 enum rwsem_waiter_type {
@@ -575,19 +574,17 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
 	return ERR_PTR(-EINTR);
 }
 
-__visible struct rw_semaphore * __sched
+static inline struct rw_semaphore * __sched
 rwsem_down_read_failed(struct rw_semaphore *sem)
 {
 	return __rwsem_down_read_failed_common(sem, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(rwsem_down_read_failed);
 
-__visible struct rw_semaphore * __sched
+static inline struct rw_semaphore * __sched
 rwsem_down_read_failed_killable(struct rw_semaphore *sem)
 {
 	return __rwsem_down_read_failed_common(sem, TASK_KILLABLE);
 }
-EXPORT_SYMBOL(rwsem_down_read_failed_killable);
 
 /*
  * Wait until we successfully acquire the write lock
@@ -694,26 +691,23 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
 	return ERR_PTR(-EINTR);
 }
 
-__visible struct rw_semaphore * __sched
+static inline struct rw_semaphore * __sched
 rwsem_down_write_failed(struct rw_semaphore *sem)
 {
 	return __rwsem_down_write_failed_common(sem, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(rwsem_down_write_failed);
 
-__visible struct rw_semaphore * __sched
+static inline struct rw_semaphore * __sched
 rwsem_down_write_failed_killable(struct rw_semaphore *sem)
 {
 	return __rwsem_down_write_failed_common(sem, TASK_KILLABLE);
 }
-EXPORT_SYMBOL(rwsem_down_write_failed_killable);
 
 /*
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
  */
-__visible
-struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -728,15 +722,13 @@ struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 
 	return sem;
 }
-EXPORT_SYMBOL(rwsem_wake);
 
 /*
  * downgrade a write lock into a read lock
  * - caller incremented waiting part of count and discovered it still negative
  * - just wake up any readers at the front of the queue
  */
-__visible
-struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
+static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -751,7 +743,6 @@ struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 
 	return sem;
 }
-EXPORT_SYMBOL(rwsem_downgrade_wake);
 
 /*
  * lock for reading
@@ -895,7 +886,6 @@ void __sched down_read(struct rw_semaphore *sem)
 
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
 }
-
 EXPORT_SYMBOL(down_read);
 
 int __sched down_read_killable(struct rw_semaphore *sem)
@@ -910,7 +900,6 @@ int __sched down_read_killable(struct rw_semaphore *sem)
 
 	return 0;
 }
-
 EXPORT_SYMBOL(down_read_killable);
 
 /*
@@ -924,7 +913,6 @@ int down_read_trylock(struct rw_semaphore *sem)
 		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
 	return ret;
 }
-
 EXPORT_SYMBOL(down_read_trylock);
 
 /*
@@ -934,10 +922,8 @@ void __sched down_write(struct rw_semaphore *sem)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
 }
-
 EXPORT_SYMBOL(down_write);
 
 /*
@@ -948,14 +934,14 @@ int __sched down_write_killable(struct rw_semaphore *sem)
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock, __down_write_killable)) {
+	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock,
+				  __down_write_killable)) {
 		rwsem_release(&sem->dep_map, 1, _RET_IP_);
 		return -EINTR;
 	}
 
 	return 0;
 }
-
 EXPORT_SYMBOL(down_write_killable);
 
 /*
@@ -970,7 +956,6 @@ int down_write_trylock(struct rw_semaphore *sem)
 
 	return ret;
 }
-
 EXPORT_SYMBOL(down_write_trylock);
 
 /*
@@ -979,10 +964,8 @@ EXPORT_SYMBOL(down_write_trylock);
 void up_read(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-
 	__up_read(sem);
 }
-
 EXPORT_SYMBOL(up_read);
 
 /*
@@ -991,10 +974,8 @@ EXPORT_SYMBOL(up_read);
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-
 	__up_write(sem);
 }
-
 EXPORT_SYMBOL(up_write);
 
 /*
@@ -1003,10 +984,8 @@ EXPORT_SYMBOL(up_write);
 void downgrade_write(struct rw_semaphore *sem)
 {
 	lock_downgrade(&sem->dep_map, _RET_IP_);
-
 	__downgrade_write(sem);
 }
-
 EXPORT_SYMBOL(downgrade_write);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1015,40 +994,32 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_read_trylock, __down_read);
 }
-
 EXPORT_SYMBOL(down_read_nested);
 
 void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 {
 	might_sleep();
 	rwsem_acquire_nest(&sem->dep_map, 0, 0, nest, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
 }
-
 EXPORT_SYMBOL(_down_write_nest_lock);
 
 void down_read_non_owner(struct rw_semaphore *sem)
 {
 	might_sleep();
-
 	__down_read(sem);
 	__rwsem_set_reader_owned(sem, NULL);
 }
-
 EXPORT_SYMBOL(down_read_non_owner);
 
 void down_write_nested(struct rw_semaphore *sem, int subclass)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
-
 	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
 }
-
 EXPORT_SYMBOL(down_write_nested);
 
 int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
@@ -1056,14 +1027,14 @@ int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclass)
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
 
-	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock, __down_write_killable)) {
+	if (LOCK_CONTENDED_RETURN(sem, __down_write_trylock,
+				  __down_write_killable)) {
 		rwsem_release(&sem->dep_map, 1, _RET_IP_);
 		return -EINTR;
 	}
 
 	return 0;
 }
-
 EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
@@ -1072,7 +1043,6 @@ void up_read_non_owner(struct rw_semaphore *sem)
 				sem);
 	__up_read(sem);
 }
-
 EXPORT_SYMBOL(up_read_non_owner);
 
 #endif
-- 
2.18.1


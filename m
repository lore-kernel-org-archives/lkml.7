Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205DDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F224720820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfDDRnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbfDDRns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB55180495;
        Thu,  4 Apr 2019 17:43:47 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 964899800;
        Thu,  4 Apr 2019 17:43:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v4 06/11] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
Date:   Thu,  4 Apr 2019 13:43:15 -0400
Message-Id: <20190404174320.22416-7-longman@redhat.com>
In-Reply-To: <20190404174320.22416-1-longman@redhat.com>
References: <20190404174320.22416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 04 Apr 2019 17:43:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DEBUG_RWSEMS_WARN_ON() macro just dumps a stack trace
when the rwsem isn't in the right state. It does not show the actual
states of the rwsem. This may not be that helpful in the debugging
process.

Enhance the DEBUG_RWSEMS_WARN_ON() macro to also show the current
content of the rwsem count and owner fields to give more information
about what is wrong with the rwsem. The debug_locks_off() function is
called as is done inside DEBUG_LOCKS_WARN_ON().

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
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
-- 
2.18.1


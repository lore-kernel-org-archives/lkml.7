Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8989C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987BC2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfC1SMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfC1SMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:12:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 861CA3DE11;
        Thu, 28 Mar 2019 18:12:02 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8E15D71A;
        Thu, 28 Mar 2019 18:12:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 04/12] locking/rwsem: Make rwsem_spin_on_owner() return owner state
Date:   Thu, 28 Mar 2019 14:10:58 -0400
Message-Id: <20190328181106.22887-5-longman@redhat.com>
In-Reply-To: <20190328181106.22887-1-longman@redhat.com>
References: <20190328181106.22887-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 28 Mar 2019 18:12:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies rwsem_spin_on_owner() to return four possible
values to better reflect the state of lock holder which enables us to
make a better decision of what to do next.

In the special case that there is no active lock and the handoff bit
is set, optimistic spinning has to be stopped.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 40 ++++++++++++++++++++++++++++++-------
 kernel/locking/rwsem.h      |  5 +++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 4f036bda9063..35891c53338b 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -281,14 +281,30 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 }
 
 /*
- * Return true only if we can still spin on the owner field of the rwsem.
+ * Return the folowing 4 values depending on the lock owner state.
+ *   OWNER_NULL  : owner is currently NULL
+ *   OWNER_WRITER: when owner changes and is a writer
+ *   OWNER_READER: when owner changes and the new owner may be a reader.
+ *   OWNER_NONSPINNABLE:
+ *		   when optimistic spinning has to stop because either the
+ *		   owner stops running, is unknown, or its timeslice has
+ *		   been used up.
  */
-static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
+enum owner_state {
+	OWNER_NULL		= 1 << 0,
+	OWNER_WRITER		= 1 << 1,
+	OWNER_READER		= 1 << 2,
+	OWNER_NONSPINNABLE	= 1 << 3,
+};
+#define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
+
+static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner = READ_ONCE(sem->owner);
+	long count;
 
 	if (!is_rwsem_owner_spinnable(owner))
-		return false;
+		return OWNER_NONSPINNABLE;
 
 	rcu_read_lock();
 	while (owner && (READ_ONCE(sem->owner) == owner)) {
@@ -306,7 +322,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		if (need_resched() || !owner_on_cpu(owner)) {
 			rcu_read_unlock();
-			return false;
+			return OWNER_NONSPINNABLE;
 		}
 
 		cpu_relax();
@@ -315,9 +331,19 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 	/*
 	 * If there is a new owner or the owner is not set, we continue
-	 * spinning.
+	 * spinning except when here is no active locks and the handoff bit
+	 * is set. In this case, we have to stop spinning.
 	 */
-	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
+	owner = READ_ONCE(sem->owner);
+	if (!is_rwsem_owner_spinnable(owner))
+		return OWNER_NONSPINNABLE;
+	if (owner && !is_rwsem_owner_reader(owner))
+		return OWNER_WRITER;
+
+	count = atomic_long_read(&sem->count);
+	if (RWSEM_COUNT_HANDOFF(count) && !RWSEM_COUNT_LOCKED(count))
+		return OWNER_NONSPINNABLE;
+	return !owner ? OWNER_NULL : OWNER_READER;
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
@@ -340,7 +366,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
-	while (rwsem_spin_on_owner(sem)) {
+	while (rwsem_spin_on_owner(sem) & OWNER_SPINNABLE) {
 		/*
 		 * Try to acquire the lock
 		 */
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 736466237c1d..4278222daaec 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -117,6 +117,11 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
 }
 
+static inline bool is_rwsem_owner_reader(struct task_struct *owner)
+{
+	return (unsigned long)owner & RWSEM_READER_OWNED;
+}
+
 /*
  * Return true if rwsem is owned by an anonymous writer or readers.
  */
-- 
2.18.1


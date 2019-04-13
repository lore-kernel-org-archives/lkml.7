Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C4C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69C1206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfDMRX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:23:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfDMRXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:23:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAEF8C05681F;
        Sat, 13 Apr 2019 17:23:53 +0000 (UTC)
Received: from llong.com (ovpn-120-133.rdu2.redhat.com [10.10.120.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1FC5D9C6;
        Sat, 13 Apr 2019 17:23:52 +0000 (UTC)
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
Subject: [PATCH v4 08/16] locking/rwsem: Make rwsem_spin_on_owner() return owner state
Date:   Sat, 13 Apr 2019 13:22:51 -0400
Message-Id: <20190413172259.2740-9-longman@redhat.com>
In-Reply-To: <20190413172259.2740-1-longman@redhat.com>
References: <20190413172259.2740-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 13 Apr 2019 17:23:53 +0000 (UTC)
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
 kernel/locking/rwsem.c | 45 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index aaab546a890d..2d6850c3e77b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -156,6 +156,11 @@ static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
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
@@ -466,14 +471,30 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
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
@@ -491,7 +512,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		if (need_resched() || !owner_on_cpu(owner)) {
 			rcu_read_unlock();
-			return false;
+			return OWNER_NONSPINNABLE;
 		}
 
 		cpu_relax();
@@ -500,9 +521,19 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 
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
@@ -525,7 +556,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
-	while (rwsem_spin_on_owner(sem)) {
+	while (rwsem_spin_on_owner(sem) & OWNER_SPINNABLE) {
 		/*
 		 * Try to acquire the lock
 		 */
-- 
2.18.1


Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC7DC4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C49206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfD1P6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfD1P6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:58:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADC8630821A5;
        Sun, 28 Apr 2019 15:58:39 +0000 (UTC)
Received: from llong.com (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB19620DF;
        Sun, 28 Apr 2019 15:58:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v6 07/20] locking/rwsem: Make rwsem_spin_on_owner() return owner state
Date:   Sun, 28 Apr 2019 11:57:42 -0400
Message-Id: <20190428155755.14267-8-longman@redhat.com>
In-Reply-To: <20190428155755.14267-1-longman@redhat.com>
References: <20190428155755.14267-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 28 Apr 2019 15:58:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies rwsem_spin_on_owner() to return four possible
values to better reflect the state of lock holder which enables us to
make a better decision of what to do next.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 65 ++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 23e3aed2173a..979770be9529 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -415,17 +415,54 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 }
 
 /*
- * Return true only if we can still spin on the owner field of the rwsem.
+ * The rwsem_spin_on_owner() function returns the folowing 4 values
+ * depending on the lock owner state.
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
+static inline enum owner_state rwsem_owner_state(unsigned long owner)
 {
-	struct task_struct *owner = READ_ONCE(sem->owner);
+	if (!owner)
+		return OWNER_NULL;
 
-	if (!is_rwsem_owner_spinnable(owner))
-		return false;
+	if (owner & RWSEM_ANONYMOUSLY_OWNED)
+		return OWNER_NONSPINNABLE;
+
+	if (owner & RWSEM_READER_OWNED)
+		return OWNER_READER;
+
+	return OWNER_WRITER;
+}
+
+static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
+{
+	struct task_struct *tmp, *owner = READ_ONCE(sem->owner);
+	enum owner_state state = rwsem_owner_state((unsigned long)owner);
+
+	if (state != OWNER_WRITER)
+		return state;
 
 	rcu_read_lock();
-	while (owner && (READ_ONCE(sem->owner) == owner)) {
+	for (;;) {
+		tmp = READ_ONCE(sem->owner);
+		if (tmp != owner) {
+			state = rwsem_owner_state((unsigned long)tmp);
+			break;
+		}
+
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -434,24 +471,16 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 */
 		barrier();
 
-		/*
-		 * abort spinning when need_resched or owner is not running or
-		 * owner's cpu is preempted.
-		 */
 		if (need_resched() || !owner_on_cpu(owner)) {
-			rcu_read_unlock();
-			return false;
+			state = OWNER_NONSPINNABLE;
+			break;
 		}
 
 		cpu_relax();
 	}
 	rcu_read_unlock();
 
-	/*
-	 * If there is a new owner or the owner is not set, we continue
-	 * spinning.
-	 */
-	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
+	return state;
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
@@ -474,7 +503,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
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


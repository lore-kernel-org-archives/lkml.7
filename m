Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB96C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8F72086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AMDNfnxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfFQOdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:33:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfFQOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:33:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEUaAE3457199
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:30:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEUaAE3457199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781837;
        bh=a9S2CuzLd4kYKu7CFHR/CjGCiqejAErFwevCNYz/wo8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AMDNfnxL1U//1YRMAtMTtPAeDlT3jJJ3ewrf3Vn5Lm2azvwtsgDmvB9otdShvY1Rm
         j2KFeT+/oCThvuSokG7npNEBh65BJno07+Ri2isX2VjLz0EjM0vvLDEsJoJSa69e5X
         3Tw9Cxrp3lmN0npb5175125FCN/e6kFQG8zUJj6i49XmW26RptuJN0ptSa66dJhpvV
         BKlqtEs7uG+2Cadm0J+Ed+D+EaBb/mIdlIex0VeTH209LobkbQZA5KTH8sHMcfYwVn
         lw4N2ipSZ5qaFrBEC7Sav/r9+hR646E/8XXC84h3WQTmyhLQMFWsJenGtO3TIx/6NT
         k+IghpejThvbA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEUatR3457196;
        Mon, 17 Jun 2019 07:30:36 -0700
Date:   Mon, 17 Jun 2019 07:30:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-02f1082b003a0cd48f48f12533d969cdbf1c2b63@git.kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        huang.ying.caritas@gmail.com, will.deacon@arm.com,
        tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, dave@stgolabs.net
Reply-To: peterz@infradead.org, tglx@linutronix.de, will.deacon@arm.com,
          huang.ying.caritas@gmail.com, mingo@kernel.org, bp@alien8.de,
          torvalds@linux-foundation.org, dave@stgolabs.net,
          longman@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tim.c.chen@linux.intel.com
In-Reply-To: <20190520205918.22251-12-longman@redhat.com>
References: <20190520205918.22251-12-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Clarify usage of owner's
 nonspinaable bit
Git-Commit-ID: 02f1082b003a0cd48f48f12533d969cdbf1c2b63
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

Commit-ID:  02f1082b003a0cd48f48f12533d969cdbf1c2b63
Gitweb:     https://git.kernel.org/tip/02f1082b003a0cd48f48f12533d969cdbf1c2b63
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:10 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:28:03 +0200

locking/rwsem: Clarify usage of owner's nonspinaable bit

Bit 1 of sem->owner (RWSEM_ANONYMOUSLY_OWNED) is used to designate an
anonymous owner - readers or an anonymous writer. The setting of this
anonymous bit is used as an indicator that optimistic spinning cannot
be done on this rwsem.

With the upcoming reader optimistic spinning patches, a reader-owned
rwsem can be spinned on for a limit period of time. We still need
this bit to indicate a rwsem is nonspinnable, but not setting this
bit loses its meaning that the owner is known. So rename the bit
to RWSEM_NONSPINNABLE to clarify its meaning.

This patch also fixes a DEBUG_RWSEMS_WARN_ON() bug in __up_write().

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Link: https://lkml.kernel.org/r/20190520205918.22251-12-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/rwsem.h  |  2 +-
 kernel/locking/rwsem.c | 43 +++++++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 148983e21d47..bb76e82398b2 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -50,7 +50,7 @@ struct rw_semaphore {
 };
 
 /*
- * Setting bit 1 of the owner field but not bit 0 will indicate
+ * Setting all bits of the owner field except bit 0 will indicate
  * that the rwsem is writer-owned with an unknown owner.
  */
 #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index ded96023f4dc..180455b6b0d4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -33,17 +33,18 @@
 /*
  * The least significant 2 bits of the owner value has the following
  * meanings when set.
- *  - RWSEM_READER_OWNED (bit 0): The rwsem is owned by readers
- *  - RWSEM_ANONYMOUSLY_OWNED (bit 1): The rwsem is anonymously owned,
- *    i.e. the owner(s) cannot be readily determined. It can be reader
- *    owned or the owning writer is indeterminate.
+ *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
+ *  - Bit 1: RWSEM_NONSPINNABLE - Waiters cannot spin on the rwsem
+ *    The rwsem is anonymously owned, i.e. the owner(s) cannot be
+ *    readily determined. It can be reader owned or the owning writer
+ *    is indeterminate.
  *
  * When a writer acquires a rwsem, it puts its task_struct pointer
  * into the owner field. It is cleared after an unlock.
  *
  * When a reader acquires a rwsem, it will also puts its task_struct
  * pointer into the owner field with both the RWSEM_READER_OWNED and
- * RWSEM_ANONYMOUSLY_OWNED bits set. On unlock, the owner field will
+ * RWSEM_NONSPINNABLE bits set. On unlock, the owner field will
  * largely be left untouched. So for a free or reader-owned rwsem,
  * the owner value may contain information about the last reader that
  * acquires the rwsem. The anonymous bit is set because that particular
@@ -55,7 +56,8 @@
  * a rwsem, but the overhead is simply too big.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
-#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
+#define RWSEM_NONSPINNABLE	(1UL << 1)
+#define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
@@ -132,7 +134,7 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
-						 | RWSEM_ANONYMOUSLY_OWNED;
+						 | RWSEM_NONSPINNABLE;
 
 	WRITE_ONCE(sem->owner, (struct task_struct *)val);
 }
@@ -144,20 +146,12 @@ static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 
 /*
  * Return true if the a rwsem waiter can spin on the rwsem's owner
- * and steal the lock, i.e. the lock is not anonymously owned.
+ * and steal the lock.
  * N.B. !owner is considered spinnable.
  */
 static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 {
-	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
-}
-
-/*
- * Return true if rwsem is owned by an anonymous writer or readers.
- */
-static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
-{
-	return (unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED;
+	return !((unsigned long)owner & RWSEM_NONSPINNABLE);
 }
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -170,10 +164,10 @@ static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 {
 	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
-						   | RWSEM_ANONYMOUSLY_OWNED;
+						   | RWSEM_NONSPINNABLE;
 	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
 		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
-				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
+				RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
 }
 #else
 static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
@@ -495,7 +489,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	struct task_struct *owner;
 	bool ret = true;
 
-	BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN));
+	BUILD_BUG_ON(is_rwsem_owner_spinnable(RWSEM_OWNER_UNKNOWN));
 
 	if (need_resched())
 		return false;
@@ -534,7 +528,7 @@ static inline enum owner_state rwsem_owner_state(unsigned long owner)
 	if (!owner)
 		return OWNER_NULL;
 
-	if (owner & RWSEM_ANONYMOUSLY_OWNED)
+	if (owner & RWSEM_NONSPINNABLE)
 		return OWNER_NONSPINNABLE;
 
 	if (owner & RWSEM_READER_OWNED)
@@ -1043,7 +1037,12 @@ static inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
+	/*
+	 * sem->owner may differ from current if the ownership is transferred
+	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
+	 */
+	DEBUG_RWSEMS_WARN_ON((sem->owner != current) &&
+			    !((long)sem->owner & RWSEM_NONSPINNABLE), sem);
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))

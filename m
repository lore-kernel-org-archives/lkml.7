Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC3BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155C82082C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vJiH3P3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfFQO1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:27:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:27:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HER4qe3456503
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:27:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HER4qe3456503
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781625;
        bh=vDrl5gKuBHMf3ieDrnxzb+Tdz29YnAkZO9JJqgUAcpc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vJiH3P3oAeeipfK8JIno40D87mGq16LMpS/aITrBho/t2ONB1sIX6SlSkGSgU7o+7
         pcZWdEhd28RT0r26JD/cXZ1OKggjjYDy38EvuNXK4SvBU9Fjuxos+39jRcX1Ek1nl1
         bLpBByQYq7zHS7a6pPh0XQEYOVMl522WZdor7c87UO+PtFpaop9r25cEEi415ER4WK
         m/jfjfwQrUQremCXBe9IO6Okf515ANEQAEVAHcGNHDuMCFGX++Tr6EHzANkAAxuopf
         pTrhknLM73b+/yqSx04vq63m+KVU0q0k1EqcYO1o21ApBCrSfphy0ESCxdZ0VlioZa
         AMtj461eE+4QA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HER4nx3456496;
        Mon, 17 Jun 2019 07:27:04 -0700
Date:   Mon, 17 Jun 2019 07:27:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-3f6d517a3ece6e6ced7abcbe798ff332ac5ca586@git.kernel.org>
Cc:     dave@stgolabs.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bp@alien8.de, mingo@kernel.org, torvalds@linux-foundation.org,
        tim.c.chen@linux.intel.com, will.deacon@arm.com,
        tglx@linutronix.de, huang.ying.caritas@gmail.com,
        longman@redhat.com, peterz@infradead.org
Reply-To: peterz@infradead.org, mingo@kernel.org,
          torvalds@linux-foundation.org, dave@stgolabs.net,
          tim.c.chen@linux.intel.com, will.deacon@arm.com, hpa@zytor.com,
          tglx@linutronix.de, longman@redhat.com,
          huang.ying.caritas@gmail.com, bp@alien8.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190520205918.22251-7-longman@redhat.com>
References: <20190520205918.22251-7-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Make rwsem_spin_on_owner() return
 owner state
Git-Commit-ID: 3f6d517a3ece6e6ced7abcbe798ff332ac5ca586
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

Commit-ID:  3f6d517a3ece6e6ced7abcbe798ff332ac5ca586
Gitweb:     https://git.kernel.org/tip/3f6d517a3ece6e6ced7abcbe798ff332ac5ca586
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 16:59:05 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:27:59 +0200

locking/rwsem: Make rwsem_spin_on_owner() return owner state

This patch modifies rwsem_spin_on_owner() to return four possible
values to better reflect the state of lock holder which enables us to
make a better decision of what to do next.

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
Link: https://lkml.kernel.org/r/20190520205918.22251-7-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.c | 65 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f56329240ef1..8d0f2acfe13d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -414,17 +414,54 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
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
@@ -433,24 +470,16 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
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
@@ -473,7 +502,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	 *  2) readers own the lock as we can't determine if they are
 	 *     actively running or not.
 	 */
-	while (rwsem_spin_on_owner(sem)) {
+	while (rwsem_spin_on_owner(sem) & OWNER_SPINNABLE) {
 		/*
 		 * Try to acquire the lock
 		 */

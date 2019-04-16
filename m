Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7157C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3919206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfDPKIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:08:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfDPKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:08:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA8Cbn3401100
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:08:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA8CCo3401097;
        Tue, 16 Apr 2019 03:08:12 -0700
Date:   Tue, 16 Apr 2019 03:08:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-364f784f048c984721986db90c95ca8350213c91@git.kernel.org>
Cc:     akpm@linux-foundation.org, mingo@kernel.org, dave@stgolabs.net,
        paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, arnd@arndb.de,
        longman@redhat.com, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, bp@alien8.de, torvalds@linux-foundation.org,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com
Reply-To: will.deacon@arm.com, tim.c.chen@linux.intel.com,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          torvalds@linux-foundation.org, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de, arnd@arndb.de,
          longman@redhat.com, a.p.zijlstra@chello.nl, dave@stgolabs.net,
          paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
          mingo@kernel.org
In-Reply-To: <20190404174320.22416-12-longman@redhat.com>
References: <20190404174320.22416-12-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Optimize rwsem structure for
 uncontended lock acquisition
Git-Commit-ID: 364f784f048c984721986db90c95ca8350213c91
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

Commit-ID:  364f784f048c984721986db90c95ca8350213c91
Gitweb:     https://git.kernel.org/tip/364f784f048c984721986db90c95ca8350213c91
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:20 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:56:06 +0200

locking/rwsem: Optimize rwsem structure for uncontended lock acquisition

For an uncontended rwsem, count and owner are the only fields a task
needs to touch when acquiring the rwsem. So they are put next to each
other to increase the chance that they will share the same cacheline.

On a ThunderX2 99xx (arm64) system with 32K L1 cache and 256K L2
cache, a rwsem locking microbenchmark with one locking thread was
run to write-lock and write-unlock an array of rwsems separated 2
cachelines apart in a 1M byte memory block. The locking rates (kops/s)
of the microbenchmark when the rwsems are at various "long" (8-byte)
offsets from beginning of the cacheline before and after the patch were
as follows:

  Cacheline Offset   Pre-patch    Post-patch
  ----------------   ---------    ----------
        0             17,449        16,588
        1             17,450        16,465
	2             17,450        16,460
	3             17,453        16,462
	4             14,867        16,471
	5             14,867        16,470
	6             14,853        16,464
	7             14,867        13,172

Before the patch, the count and owner are 4 "long"s apart. After the
patch, they are only 1 "long" apart.

The rwsem data have to be loaded from the L3 cache for each access. It
can be seen that the locking rates are more consistent after the patch
than before. Note that for this particular system, the performance
drop happens whenever the count and owner are at an odd multiples of
"long"s apart. No performance drop was observed when only a single rwsem
was used (hot cache). So the drop is likely just an idiosyncrasy of the
cache architecture of this chip than an inherent problem with the patch.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20190404174320.22416-12-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/rwsem.h | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index b44e533235c7..2ea18a3def04 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -20,21 +20,30 @@
 #include <linux/osq_lock.h>
 #endif
 
-struct rw_semaphore;
-
-/* All arch specific implementations share the same struct */
+/*
+ * For an uncontended rwsem, count and owner are the only fields a task
+ * needs to touch when acquiring the rwsem. So they are put next to each
+ * other to increase the chance that they will share the same cacheline.
+ *
+ * In a contended rwsem, the owner is likely the most frequently accessed
+ * field in the structure as the optimistic waiter that holds the osq lock
+ * will spin on owner. For an embedded rwsem, other hot fields in the
+ * containing structure should be moved further away from the rwsem to
+ * reduce the chance that they will share the same cacheline causing
+ * cacheline bouncing problem.
+ */
 struct rw_semaphore {
 	atomic_long_t count;
-	struct list_head wait_list;
-	raw_spinlock_t wait_lock;
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	struct optimistic_spin_queue osq; /* spinner MCS lock */
 	/*
 	 * Write owner. Used as a speculative check to see
 	 * if the owner is running on the cpu.
 	 */
 	struct task_struct *owner;
+	struct optimistic_spin_queue osq; /* spinner MCS lock */
 #endif
+	raw_spinlock_t wait_lock;
+	struct list_head wait_list;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif

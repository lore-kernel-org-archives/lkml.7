Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D89206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfDDRoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfDDRn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C207281E1E;
        Thu,  4 Apr 2019 17:43:57 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C43A7FA00;
        Thu,  4 Apr 2019 17:43:54 +0000 (UTC)
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
Subject: [PATCH-tip v4 11/11] locking/rwsem: Optimize rwsem structure for uncontended lock acquisition
Date:   Thu,  4 Apr 2019 13:43:20 -0400
Message-Id: <20190404174320.22416-12-longman@redhat.com>
In-Reply-To: <20190404174320.22416-1-longman@redhat.com>
References: <20190404174320.22416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 04 Apr 2019 17:43:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
-- 
2.18.1


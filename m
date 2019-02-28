Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3293C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C6221850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfB1HHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:07:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34833 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:07:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S77IV52938721
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:07:18 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S77H8S2938715;
        Wed, 27 Feb 2019 23:07:17 -0800
Date:   Wed, 27 Feb 2019 23:07:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-956f3563a8387beb7758f2e8ee483639ef91afc6@git.kernel.org>
Cc:     will.deacon@arm.com, torvalds@linux-foundation.org,
        bvanassche@acm.org, paulmck@linux.vnet.ibm.com,
        akpm@linux-foundation.org, longman@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, johannes@sipsolutions.net, hpa@zytor.com
Reply-To: hpa@zytor.com, johannes@sipsolutions.net, peterz@infradead.org,
          mingo@kernel.org, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          longman@redhat.com, linux-kernel@vger.kernel.org,
          bvanassche@acm.org, paulmck@linux.vnet.ibm.com,
          will.deacon@arm.com
In-Reply-To: <20190214230058.196511-9-bvanassche@acm.org>
References: <20190214230058.196511-9-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Split lockdep_free_key_range()
 and lockdep_reset_lock()
Git-Commit-ID: 956f3563a8387beb7758f2e8ee483639ef91afc6
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

Commit-ID:  956f3563a8387beb7758f2e8ee483639ef91afc6
Gitweb:     https://git.kernel.org/tip/956f3563a8387beb7758f2e8ee483639ef91afc6
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:43 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:42 +0100

locking/lockdep: Split lockdep_free_key_range() and lockdep_reset_lock()

This patch does not change the behavior of these functions but makes the
patch that frees unused lock classes easier to read.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20190214230058.196511-9-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 72 ++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d1a6daf1f51f..2d4c21a02546 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4160,6 +4160,24 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
+static void __lockdep_free_key_range(void *start, unsigned long size)
+{
+	struct lock_class *class;
+	struct hlist_head *head;
+	int i;
+
+	/* Unhash all classes that were created by a module. */
+	for (i = 0; i < CLASSHASH_SIZE; i++) {
+		head = classhash_table + i;
+		hlist_for_each_entry_rcu(class, head, hash_entry) {
+			if (!within(class->key, start, size) &&
+			    !within(class->name, start, size))
+				continue;
+			zap_class(class);
+		}
+	}
+}
+
 /*
  * Used in module.c to remove lock classes from memory that is going to be
  * freed; and possibly re-used by other modules.
@@ -4170,30 +4188,14 @@ static inline int within(const void *addr, void *start, unsigned long size)
  */
 void lockdep_free_key_range(void *start, unsigned long size)
 {
-	struct lock_class *class;
-	struct hlist_head *head;
 	unsigned long flags;
-	int i;
 	int locked;
 
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
-
-	/*
-	 * Unhash all classes that were created by this module:
-	 */
-	for (i = 0; i < CLASSHASH_SIZE; i++) {
-		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			if (within(class->key, start, size))
-				zap_class(class);
-			else if (within(class->name, start, size))
-				zap_class(class);
-		}
-	}
-
+	__lockdep_free_key_range(start, size);
 	if (locked)
 		graph_unlock();
 	raw_local_irq_restore(flags);
@@ -4235,16 +4237,11 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 	return false;
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/* The caller must hold the graph lock. Does not sleep. */
+static void __lockdep_reset_lock(struct lockdep_map *lock)
 {
 	struct lock_class *class;
-	unsigned long flags;
-	int j, locked;
-
-	init_data_structures_once();
-
-	raw_local_irq_save(flags);
-	locked = graph_lock();
+	int j;
 
 	/*
 	 * Remove all classes this lock might have:
@@ -4261,19 +4258,22 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	 * Debug check: in the end all mapped classes should
 	 * be gone.
 	 */
-	if (unlikely(lock_class_cache_is_registered(lock))) {
-		if (debug_locks_off_graph_unlock()) {
-			/*
-			 * We all just reset everything, how did it match?
-			 */
-			WARN_ON(1);
-		}
-		goto out_restore;
-	}
+	if (WARN_ON_ONCE(lock_class_cache_is_registered(lock)))
+		debug_locks_off();
+}
+
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	unsigned long flags;
+	int locked;
+
+	init_data_structures_once();
+
+	raw_local_irq_save(flags);
+	locked = graph_lock();
+	__lockdep_reset_lock(lock);
 	if (locked)
 		graph_unlock();
-
-out_restore:
 	raw_local_irq_restore(flags);
 }
 

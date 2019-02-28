Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D6E21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfB1HK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:10:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfB1HKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:10:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S79twQ2939244
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:09:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S79tI22939241;
        Wed, 27 Feb 2019 23:09:55 -0800
Date:   Wed, 27 Feb 2019 23:09:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-ace35a7ac493d4284a57ad807579011bebba891c@git.kernel.org>
Cc:     will.deacon@arm.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, peterz@infradead.org,
        johannes@sipsolutions.net, mingo@kernel.org, bvanassche@acm.org,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
          bvanassche@acm.org, mingo@kernel.org, johannes@sipsolutions.net,
          peterz@infradead.org, longman@redhat.com,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, will.deacon@arm.com
In-Reply-To: <20190214230058.196511-13-bvanassche@acm.org>
References: <20190214230058.196511-13-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Reuse list entries that are no
 longer in use
Git-Commit-ID: ace35a7ac493d4284a57ad807579011bebba891c
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

Commit-ID:  ace35a7ac493d4284a57ad807579011bebba891c
Gitweb:     https://git.kernel.org/tip/ace35a7ac493d4284a57ad807579011bebba891c
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:47 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:44 +0100

locking/lockdep: Reuse list entries that are no longer in use

Instead of abandoning elements of list_entries[] that are no longer in
use, make alloc_list_entry() reuse array elements that have been freed.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-13-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8ecf355dd163..2c6d0b67e7b6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -45,6 +45,7 @@
 #include <linux/hash.h>
 #include <linux/ftrace.h>
 #include <linux/stringify.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/gfp.h>
 #include <linux/random.h>
@@ -132,6 +133,7 @@ static inline int debug_locks_off_graph_unlock(void)
 
 unsigned long nr_list_entries;
 static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
+static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
 
 /*
  * All data structures here are protected by the global debug_lock.
@@ -907,7 +909,10 @@ out_set_class_cache:
  */
 static struct lock_list *alloc_list_entry(void)
 {
-	if (nr_list_entries >= MAX_LOCKDEP_ENTRIES) {
+	int idx = find_first_zero_bit(list_entries_in_use,
+				      ARRAY_SIZE(list_entries));
+
+	if (idx >= ARRAY_SIZE(list_entries)) {
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
@@ -915,7 +920,9 @@ static struct lock_list *alloc_list_entry(void)
 		dump_stack();
 		return NULL;
 	}
-	return list_entries + nr_list_entries++;
+	nr_list_entries++;
+	__set_bit(idx, list_entries_in_use);
+	return list_entries + idx;
 }
 
 /*
@@ -1019,7 +1026,7 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	lock->parent = parent;
 	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
@@ -1029,7 +1036,7 @@ static inline unsigned long lock_accessed(struct lock_list *lock)
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
 }
 
@@ -4276,13 +4283,13 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
+		entry = list_entries + i;
 		if (entry->class != class && entry->links_to != class)
 			continue;
+		__clear_bit(i, list_entries_in_use);
+		nr_list_entries--;
 		list_del_rcu(&entry->entry);
-		/* Clear .class and .links_to to avoid double removal. */
-		WRITE_ONCE(entry->class, NULL);
-		WRITE_ONCE(entry->links_to, NULL);
 	}
 	if (list_empty(&class->locks_after) &&
 	    list_empty(&class->locks_before)) {
@@ -4596,6 +4603,7 @@ void __init lockdep_init(void)
 	       (sizeof(lock_classes) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
+		sizeof(list_entries_in_use) +
 		sizeof(chainhash_table) +
 		sizeof(delayed_free)
 #ifdef CONFIG_PROVE_LOCKING

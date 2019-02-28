Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E64C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E9C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfB1HHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:07:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:07:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S76dlo2938656
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:06:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S76ceu2938653;
        Wed, 27 Feb 2019 23:06:38 -0800
Date:   Wed, 27 Feb 2019 23:06:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-feb0a3865ed2f7d66a1f2686f7ad784422c249ad@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        bvanassche@acm.org, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, johannes@sipsolutions.net,
        tglx@linutronix.de, longman@redhat.com, peterz@infradead.org
Reply-To: longman@redhat.com, bvanassche@acm.org, mingo@kernel.org,
          peterz@infradead.org, will.deacon@arm.com, hpa@zytor.com,
          johannes@sipsolutions.net, paulmck@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20190214230058.196511-8-bvanassche@acm.org>
References: <20190214230058.196511-8-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Initialize the locks_before and
 locks_after lists earlier
Git-Commit-ID: feb0a3865ed2f7d66a1f2686f7ad784422c249ad
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

Commit-ID:  feb0a3865ed2f7d66a1f2686f7ad784422c249ad
Gitweb:     https://git.kernel.org/tip/feb0a3865ed2f7d66a1f2686f7ad784422c249ad
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:42 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:41 +0100

locking/lockdep: Initialize the locks_before and locks_after lists earlier

This patch does not change any functionality. A later patch will reuse
lock classes that have been freed. In combination with that patch this
patch wil have the effect of initializing lock class order lists once
instead of every time a lock class structure is reinitialized.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-8-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 28fbeb2a10cc..d1a6daf1f51f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -735,6 +735,25 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+/*
+ * Initialize the lock_classes[] array elements.
+ */
+static void init_data_structures_once(void)
+{
+	static bool initialization_happened;
+	int i;
+
+	if (likely(initialization_happened))
+		return;
+
+	initialization_happened = true;
+
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		INIT_LIST_HEAD(&lock_classes[i].locks_after);
+		INIT_LIST_HEAD(&lock_classes[i].locks_before);
+	}
+}
+
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -775,6 +794,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			goto out_unlock_set;
 	}
 
+	init_data_structures_once();
+
 	/*
 	 * Allocate a new key from the static array, and add it to
 	 * the hash:
@@ -793,8 +814,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
-	INIT_LIST_HEAD(&class->locks_before);
-	INIT_LIST_HEAD(&class->locks_after);
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	class->name_version = count_matching_names(class);
 	/*
 	 * We use RCU's safe list-add method to make
@@ -4155,6 +4176,8 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	int i;
 	int locked;
 
+	init_data_structures_once();
+
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 
@@ -4218,6 +4241,8 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	unsigned long flags;
 	int j, locked;
 
+	init_data_structures_once();
+
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 

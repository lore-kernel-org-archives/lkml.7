Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5149C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988EA26907
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZQaR6WML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfFCNQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:16:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:16:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DFps2606105
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:15:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DFps2606105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567752;
        bh=N3GCtG4qp2uKDPSsWJs9UNW4xxGQ68oAJubnT5rBU1k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZQaR6WMLWFQ40j3DCxflUQF+zLpWSp9+kwjxfRLLWF4MkjnmX6cHAjH4jNwyq8GFA
         oCm/aNJzDhJjWBAWC+DMQpaERMXxoBjPz+IQAd7vPzA9Pp4RT4bN6R4s1KIBHC5LFB
         BIejbm+vpSJeMjvMvh0m++3FWhkeVhxm+TAsCgyNTZ1LDZaG+3ZzgEl7meeAWe2xu6
         rOaf/sFvIK+OUcWBS95ufAbPIBO8r/PM0mRkCjmLLz/hOMPRD5GQuy8jmSCgU3OZAN
         n5JMlYVZLXJ+GEHhwuwaFbLeRwPM243poJHJPDBARqNhYUxPIbNh1QnjTMH6nIjBEn
         ps123GpLRyJPQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DFoeF606102;
        Mon, 3 Jun 2019 06:15:50 -0700
Date:   Mon, 3 Jun 2019 06:15:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-77a806922cfdebcf3ae89d31a8b592a7f7fbe537@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, duyuyang@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, duyuyang@gmail.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190506081939.74287-15-duyuyang@gmail.com>
References: <20190506081939.74287-15-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Avoid constant checks in __bfs
 by using offset reference
Git-Commit-ID: 77a806922cfdebcf3ae89d31a8b592a7f7fbe537
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

Commit-ID:  77a806922cfdebcf3ae89d31a8b592a7f7fbe537
Gitweb:     https://git.kernel.org/tip/77a806922cfdebcf3ae89d31a8b592a7f7fbe537
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:30 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:46 +0200

locking/lockdep: Avoid constant checks in __bfs by using offset reference

In search of a dependency in the lock graph, there is contant checks for
forward or backward search. Directly reference the field offset of the
struct that differentiates the type of search to avoid those checks.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-15-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d23dcb47389e..2e8ef6082f72 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1367,11 +1367,25 @@ static inline int get_lock_depth(struct lock_list *child)
 	return depth;
 }
 
+/*
+ * Return the forward or backward dependency list.
+ *
+ * @lock:   the lock_list to get its class's dependency list
+ * @offset: the offset to struct lock_class to determine whether it is
+ *          locks_after or locks_before
+ */
+static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
+{
+	void *lock_class = lock->class;
+
+	return lock_class + offset;
+}
+
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
 		 struct lock_list **target_entry,
-		 int forward)
+		 int offset)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1385,11 +1399,7 @@ static int __bfs(struct lock_list *source_entry,
 		goto exit;
 	}
 
-	if (forward)
-		head = &source_entry->class->locks_after;
-	else
-		head = &source_entry->class->locks_before;
-
+	head = get_dep_list(source_entry, offset);
 	if (list_empty(head))
 		goto exit;
 
@@ -1403,10 +1413,7 @@ static int __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
-		if (forward)
-			head = &lock->class->locks_after;
-		else
-			head = &lock->class->locks_before;
+		head = get_dep_list(lock, offset);
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1439,7 +1446,8 @@ static inline int __bfs_forwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 1);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_after));
 
 }
 
@@ -1448,7 +1456,8 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 0);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_before));
 
 }
 

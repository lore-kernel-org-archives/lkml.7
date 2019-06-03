Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA2FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B996D25162
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B/eKJjOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfFCNTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:19:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:19:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DJVkS606616
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:19:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DJVkS606616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567972;
        bh=TpY62ICH8jM9eaq2iM4vob/3Z6ujynBthhT7qU+jhTI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=B/eKJjOrO1ajppnP0uCKVjqR4slQXEEUJbAkIdR5PNDG9BejuwwCzcVO4COO3mIOk
         0J16gIZzkFrbVW2LLCtm7Lt1W3WuPgBdCgOzsLWVWemE5hOzaetVojHwxX+yUv/zgr
         S1fhiKwnVLr2fkUE5HBNMYBCPKmF5WrZ4mZi9JHaPVc1eRTlAzmDatTns3I3YeX+EE
         NoL/qDopzlOyv+434hjtK57T7gFIr+Vha4XxHC5Cz0+y03dU06YMGI+dqWs/1UnsL4
         EAqbgCJcMRccZcPvNgpwHG2aryu1f8aob+CW23Vdi5NoIqf1OlUOVInA06OLRKEmQB
         +JfMT6A5pwOOg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DJVew606613;
        Mon, 3 Jun 2019 06:19:31 -0700
Date:   Mon, 3 Jun 2019 06:19:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-8c2c2b449aa50463ba4cc1f33cdfc98750ed03ab@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        duyuyang@gmail.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org, torvalds@linux-foundation.org,
          duyuyang@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190506081939.74287-20-duyuyang@gmail.com>
References: <20190506081939.74287-20-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Refactorize check_noncircular
 and check_redundant
Git-Commit-ID: 8c2c2b449aa50463ba4cc1f33cdfc98750ed03ab
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

Commit-ID:  8c2c2b449aa50463ba4cc1f33cdfc98750ed03ab
Gitweb:     https://git.kernel.org/tip/8c2c2b449aa50463ba4cc1f33cdfc98750ed03ab
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:35 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:50 +0200

locking/lockdep: Refactorize check_noncircular and check_redundant

These two functions now handle different check results themselves. A new
check_path function is added to check whether there is a path in the
dependency graph. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-20-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 118 +++++++++++++++++++++++++++++------------------
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8169706df767..30a1c0e32573 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1683,33 +1683,90 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 }
 
 /*
- * Prove that the dependency graph starting at <entry> can not
- * lead to <target>. Print an error and return 0 if it does.
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. Print an error and return 0 if it does.
  */
 static noinline int
-check_noncircular(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+check_path(struct lock_class *target, struct lock_list *src_entry,
+	   struct lock_list **target_entry)
 {
-	int result;
+	int ret;
+
+	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
+			     target_entry);
+
+	if (unlikely(ret < 0))
+		print_bfs_bug(ret);
+
+	return ret;
+}
+
+/*
+ * Prove that the dependency graph starting at <src> can not
+ * lead to <target>. If it can, there is a circle when adding
+ * <target> -> <src> dependency.
+ *
+ * Print an error and return 0 if it does.
+ */
+static noinline int
+check_noncircular(struct held_lock *src, struct held_lock *target,
+		  struct lock_trace *trace)
+{
+	int ret;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list src_entry = {
+		.class = hlock_class(src),
+		.parent = NULL,
+	};
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	return result;
+	if (unlikely(!ret)) {
+		if (!trace->nr_entries) {
+			/*
+			 * If save_trace fails here, the printing might
+			 * trigger a WARN but because of the !nr_entries it
+			 * should not do bad things.
+			 */
+			save_trace(trace);
+		}
+
+		print_circular_bug(&src_entry, target_entry, src, target);
+	}
+
+	return ret;
 }
 
+/*
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. If it can, <src> -> <target> dependency is already
+ * in the graph.
+ *
+ * Print an error and return 2 if it does or 1 if it does not.
+ */
 static noinline int
-check_redundant(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+check_redundant(struct held_lock *src, struct held_lock *target)
 {
-	int result;
+	int ret;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list src_entry = {
+		.class = hlock_class(src),
+		.parent = NULL,
+	};
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	return result;
+	if (!ret) {
+		debug_atomic_inc(nr_redundant);
+		ret = 2;
+	} else if (ret < 0)
+		ret = 0;
+
+	return ret;
 }
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -2307,9 +2364,7 @@ static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct held_lock *next, int distance, struct lock_trace *trace)
 {
-	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
-	struct lock_list this;
 	int ret;
 
 	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
@@ -2340,25 +2395,9 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	this.class = hlock_class(next);
-	this.parent = NULL;
-	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
-	if (unlikely(!ret)) {
-		if (!trace->nr_entries) {
-			/*
-			 * If save_trace fails here, the printing might
-			 * trigger a WARN but because of the !nr_entries it
-			 * should not do bad things.
-			 */
-			save_trace(trace);
-		}
-		print_circular_bug(&this, target_entry, next, prev);
+	ret = check_noncircular(next, prev, trace);
+	if (unlikely(ret <= 0))
 		return 0;
-	}
-	else if (unlikely(ret < 0)) {
-		print_bfs_bug(ret);
-		return 0;
-	}
 
 	if (!check_irq_usage(curr, prev, next))
 		return 0;
@@ -2392,18 +2431,9 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
-	this.class = hlock_class(prev);
-	this.parent = NULL;
-	ret = check_redundant(&this, hlock_class(next), &target_entry);
-	if (!ret) {
-		debug_atomic_inc(nr_redundant);
-		return 2;
-	}
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-
+	ret = check_redundant(prev, next);
+	if (ret != 1)
+		return ret;
 
 	if (!trace->nr_entries && !save_trace(trace))
 		return 0;

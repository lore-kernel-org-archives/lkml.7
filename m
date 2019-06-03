Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EF8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D309023C12
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xcV+VXni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfFCNNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:13:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:13:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DCuvG605643
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:12:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DCuvG605643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567576;
        bh=X3CeSwglCJdpcqZkfI7Qmats+Sg31lEAXKC7hfCu3bA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xcV+VXniNpJrr/VOvkmLTCFjT/hZ7Sz4mbnaO686btCbTeMpO254tC0oLNnEY6wXr
         xjyRG4+EnqquJsufIdA1a9+22w9M3xDKcux/4xmnZqD+VpxKxTflIJFFFvDYUey5ex
         TYKB6axNZkzvgcxn/JLt4i5jJR6jis0BrqTJgS05QJyCU8zkPQjPCb982hBL6qkhi9
         xCau1MLIiidHFUBLqnSOx0X8AAdvBVqhKHqEaeKcmMYxfcJxhQGBVvXLSAvEniRYL3
         yIXXUuI/W9JyCedJ8j6jUS5sRuvMAcF0m1PudUMNadGhO5zlnjJhmuGskA6GcP+DIH
         eGDLIG3OD4NUA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DCte2605639;
        Mon, 3 Jun 2019 06:12:55 -0700
Date:   Mon, 3 Jun 2019 06:12:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-0b9fc8ecfa30000c8900da7adbbef23438de9ec0@git.kernel.org>
Cc:     hpa@zytor.com, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, duyuyang@gmail.com,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: bvanassche@acm.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org, duyuyang@gmail.com,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <20190506081939.74287-11-duyuyang@gmail.com>
References: <20190506081939.74287-11-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Remove unused argument in
 validate_chain() and check_deadlock()
Git-Commit-ID: 0b9fc8ecfa30000c8900da7adbbef23438de9ec0
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

Commit-ID:  0b9fc8ecfa30000c8900da7adbbef23438de9ec0
Gitweb:     https://git.kernel.org/tip/0b9fc8ecfa30000c8900da7adbbef23438de9ec0
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:26 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:44 +0200

locking/lockdep: Remove unused argument in validate_chain() and check_deadlock()

The lockdep_map argument in them is not used, remove it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-11-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3eecae315885..6cf14c84eb6d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2230,8 +2230,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next,
-	       struct lockdep_map *next_instance, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2789,8 +2788,9 @@ cache_hit:
 	return 1;
 }
 
-static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
-		struct held_lock *hlock, int chain_head, u64 chain_key)
+static int validate_chain(struct task_struct *curr,
+			  struct held_lock *hlock,
+			  int chain_head, u64 chain_key)
 {
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
@@ -2816,7 +2816,7 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 		 * any of these scenarios could lead to a deadlock. If
 		 * All validations
 		 */
-		int ret = check_deadlock(curr, hlock, lock, hlock->read);
+		int ret = check_deadlock(curr, hlock, hlock->read);
 
 		if (!ret)
 			return 0;
@@ -2847,8 +2847,8 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 }
 #else
 static inline int validate_chain(struct task_struct *curr,
-	       	struct lockdep_map *lock, struct held_lock *hlock,
-		int chain_head, u64 chain_key)
+				 struct held_lock *hlock,
+				 int chain_head, u64 chain_key)
 {
 	return 1;
 }
@@ -3826,7 +3826,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_head, chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;

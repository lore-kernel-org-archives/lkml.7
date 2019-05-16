Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41032C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F345B2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psB3DRd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfEPIBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36755 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so1426651pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKhpbwI8d6YDPjQg+MyibgmVy1E/YKIRMPT4l50TKdM=;
        b=psB3DRd5xC0VkqiVhHf4/b/PGQNZJgQnQ2LmSo+6mOofI6NHHZrD+W3X/B+wgwgmXY
         +TxyHqLz3bG2ND7uWVLL/1QpUTChQcwQTfEisHy5K0S+2B2NvGYmUkQlzMh0kCwBc8ou
         25sMy0QEBtHV0CgCwW+eEBNDcO6wOOzamf2IHwPDotEkVEDls+/7VUoQT+Nbowq/hmr1
         vjKvygqvkaGHiC0++3i/f4hZEDGku6NLOQLg8NvuixFPUOcUmJZ9iyAGDc8NfGbprfpu
         ZEklUEIBWx8wdUtYcZ6LWLX3Rtq63uktwLaZ/g9CKptNgxDfjbNKbPmwGhZNmfq/gQRL
         SM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKhpbwI8d6YDPjQg+MyibgmVy1E/YKIRMPT4l50TKdM=;
        b=WzOKVrRrczsRQZFCv6OhrbXKmLomXw//oDNcwXKSva0qDwLfCeGzWoe6UOStJ3oRLo
         TpzYpNHmtvoeNCy+Pk4I9+k9FL4JiTQsM1afRCLGw/uWgVJf1lHxqu3ztB4vo1j9Oj46
         ohqWGQG+WttaLrCjwfVFkKW0k9D4rwnZ4Jb0cAskvTf9gC248c3S+ehv3etD4DvTHtyd
         JyOASbURepW/iTOTkzIZV2teDucZlzDZdmpqYR8YLfAg7JzxFiikfVp/bgHTyCqHYj45
         Swsbul8T6CF0DYWNNa5GNDSptYUHwBbfEJmVggpB8Pi8G13SZFhUQAp67NwBS+yu0IuV
         FSkA==
X-Gm-Message-State: APjAAAUylk9ec9MJE6ldIF0osjbtcNk5xadFQZpMonLVoJMtsDowP1hU
        y90JytRlgHl1ETH44wJswBA=
X-Google-Smtp-Source: APXvYqzWfETNWPcb16glxojjM3/RK09bX8ZGT6izNwerDMPZF2SyLN8HvoqFV4qTSqGEbcZArTuFwA==
X-Received: by 2002:a62:116:: with SMTP id 22mr14030054pfb.119.1557993673424;
        Thu, 16 May 2019 01:01:13 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:01:12 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 14/17] locking/lockdep: Support recursive read locks
Date:   Thu, 16 May 2019 16:00:12 +0800
Message-Id: <20190516080015.16033-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we are good to finally support recursive read locks.

This is done simply by adding the dependency that has recursive locks to the
graph, which previously is skipped.

The reason is plainly simple:

  (a). Recursive read lock differs from read lock only inside a task.
  (b). check_deadlock_current() already handles recursive-read lock pretty
       well.

Now that the bulk of the implementation of the read-write lock deadlock
detection algorithm is done, the lockdep internal performance statistics can
be collected (the workload used as usual is: make clean; reboot; make vmlinux -j8):

Before
------
 direct dependencies:                  8980 [max: 32768]
 indirect dependencies:               41065
 all direct dependencies:            211016
 dependency chains:                   11592 [max: 65536]
 dependency chain hlocks:             42869 [max: 327680]
 in-hardirq chains:                      85
 in-softirq chains:                     385
 in-process chains:                   10250
 stack-trace entries:                123121 [max: 524288]
 combined max dependencies:       340292196
 max bfs queue depth:                   244
 chain lookup misses:                 12703
 chain lookup hits:               666620822
 cyclic checks:                       11392
 redundant checks:                        0

After
-----

 direct dependencies:                  9624 [max: 32768]
 indirect dependencies:               43759
 all direct dependencies:            216024
 dependency chains:                   12119 [max: 65536]
 dependency chain hlocks:             44654 [max: 327680]
 in-hardirq chains:                      88
 in-softirq chains:                     383
 in-process chains:                   10544
 stack-trace entries:                132362 [max: 524288]
 combined max dependencies:       360385920
 max bfs queue depth:                   250
 chain lookup misses:                 13528
 chain lookup hits:               664721852
 cyclic checks:                       12053
 redundant checks:                        0

Most noticeably, we have slightly more dependencies, chains, and chain
lookup misses, but none of them raises concerns.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d8e484d..cd1d515 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1809,6 +1809,9 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 		.parent = NULL,
 	};
 
+	if (DEBUG_LOCKS_WARN_ON(hlock_class(src) == hlock_class(target)))
+		return 0;
+
 	debug_atomic_inc(nr_cyclic_checks);
 
 	while (true) {
@@ -1865,9 +1868,17 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 					break;
 
 				/*
+				 * This previous lock has the same class as
+				 * the src (the next lock to acquire); this
+				 * must be a recursive read case. Skip.
+				 */
+				if (hlock_class(prev) == hlock_class(src))
+					continue;
+
+				/*
 				 * Since the src lock (the next lock to
-				 * acquire) is neither recursive nor nested
-				 * lock, so this prev class cannot be src
+				 * acquire) is not nested lock, so up to
+				 * now this prev class cannot be the src
 				 * class, then does the path have this
 				 * previous lock?
 				 *
@@ -2613,6 +2624,17 @@ static inline void inc_chains(void)
 	}
 
 	/*
+	 * Filter out the direct dependency with the same lock class, which
+	 * is legitimate only if the next lock is the recursive-read type,
+	 * otherwise we should not have been here in the first place.
+	 */
+	if (hlock_class(prev) == hlock_class(next)) {
+		WARN_ON_ONCE(next->read != LOCK_TYPE_RECURSIVE);
+		WARN_ON_ONCE(prev->read == LOCK_TYPE_WRITE);
+		return 2;
+	}
+
+	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
@@ -2630,16 +2652,6 @@ static inline void inc_chains(void)
 		return 0;
 
 	/*
-	 * For recursive read-locks we do all the dependency checks,
-	 * but we dont store read-triggered dependencies (only
-	 * write-triggered dependencies). This ensures that only the
-	 * write-side dependencies matter, and that if for example a
-	 * write-lock never takes any other locks, then the reads are
-	 * equivalent to a NOP.
-	 */
-	if (next->read == LOCK_TYPE_RECURSIVE || prev->read == LOCK_TYPE_RECURSIVE)
-		return 1;
-	/*
 	 * Is the <prev> -> <next> dependency already present?
 	 *
 	 * (this may occur even though this is a new chain: consider
@@ -2738,11 +2750,7 @@ static inline void inc_chains(void)
 		int distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
-		/*
-		 * Only non-recursive-read entries get new dependencies
-		 * added:
-		 */
-		if (hlock->read != LOCK_TYPE_RECURSIVE && hlock->check) {
+		if (hlock->check) {
 			int ret = check_prev_add(curr, hlock, next, distance,
 						 &trace);
 			if (!ret)
@@ -3135,10 +3143,9 @@ static int validate_chain(struct task_struct *curr,
 
 		/*
 		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
+		 * of the chain, and if it's not a nest lock:
 		 */
-		if (!chain_head && ret != LOCK_TYPE_RECURSIVE &&
-		    ret != LOCK_TYPE_NEST) {
+		if (!chain_head && ret != LOCK_TYPE_NEST) {
 			if (!check_prevs_add(curr, hlock))
 				return 0;
 		}
-- 
1.8.3.1


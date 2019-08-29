Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A922073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGVA/mB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfH2Ici (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39138 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfH2Icg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id az1so262953plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpsBZTZRUVY2uylsAfm/hNjVugFrx/5UtLnMUhAiadg=;
        b=UGVA/mB3X5dDNeVWi2/A7kT1bE/a5Irx5WFnXRyZvwhUAPMTPO0NLjLscktaKsRE8u
         ACRa/easZeVEwLdtGwqE+TC13Pxpc6cKUxB1XqCYNnOQBhd6JDXhUIVo/kTsEpfZ+/p1
         qonJxOPTcYS4JiAQGblPlJIT5vEvgaMxp3lG9o+fq6B/puan9BMRiCM8Sg6wupsZcqBW
         c8yIGSuyWgMoH03oW4ZugrWdkJFAFJpPhjLiffJIKr5WZMvB/Fo3fHxN3RgfsCdNp5ke
         kp8zNeaoyFfYUAJ46UuN6ZmEIJj6qwpjklRqOUhw1YBd6qEPa09q7bSAioE+VwPSuYcB
         9Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpsBZTZRUVY2uylsAfm/hNjVugFrx/5UtLnMUhAiadg=;
        b=ssC9amUHCHJ2wk3P9+ODM+ZzUS+5YlV+WsM8j4ZBy/4mVrkufBZbgYtMqLWpJ/nxnj
         2v7FB1dIjzDJ6qXYjeUlyoRHZqCXQXadIY/SOFL92jq0FPDQ2mRdqBWefz9bBrB63Yse
         S0I8krx+N/moA4LL+9Xl2EYad2eXyjrPIsvVcKQsS/0xKQ7RlgQrANv8ZywWTfEgj8UW
         5admq+yiOVvfrXavar7InJGx4tXktBi/S03gHs9eqC4IuceWtrlCgvLDCc1tmga0Vq64
         ZLfDOVN1wtMs/xB3BE9vRZaZwFXN6HpQ5qzNdTXfAUfd/l1O3hEL0RsgYwxAZfY3NKmv
         fz8w==
X-Gm-Message-State: APjAAAVfcQtVfegEk+kSHEdvF6epP3zv5/ukmU711/CMy+H0wfSJr+0y
        4nAyx71K5HwBQ8smVhFVHVA=
X-Google-Smtp-Source: APXvYqyBuCY3vAodm+rXLAXZGgp5e854EXDHek/BxigMuNRkb1L3dsPLjmp7Y3dd3tm1umRC5FfqqA==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr9015953plp.194.1567067555286;
        Thu, 29 Aug 2019 01:32:35 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:34 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 13/30] locking/lockdep: Treat every lock dependency as in a new lock chain
Date:   Thu, 29 Aug 2019 16:31:15 +0800
Message-Id: <20190829083132.22394-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a lock chain that has a lock (i.e., next) on top of a trylock or a
multiple of consecutive trylocks, if they are in the same context, we check
each prev trylock -> next and the first prev non-trylock -> next lock
dependency, illustrated as:

    (The top is the latest lock.)

    Lock1
    Try Lock2
    Try Lock3
    Lock4
    ...

If the prev lock is not the direct previous lock to next (e.g., Lock3 or
Lock4), this does not attempt to create a new lock chain. This patch treats
each such case as if it is from a new lock chain. And if the chain already
exists, then this is a chain cache hit and the check is not needed. As a
result, compare this:

Previous lock chains:

(1) ... -> Lock4 -> Lock3 -> Lock2 -> Lock1

Lock chains after this patch:

(1) ... -> Lock4 -> Lock3 -> Lock2 -> Lock1
(2) ... -> Lock4 -> Lock3 -> Lock1

After this, it is guarantteed that each dependency has at least a lock
chain associated with it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 223 +++++++++++++++++++++++------------------------
 1 file changed, 108 insertions(+), 115 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 569d3c1..21d9e99 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1275,6 +1275,11 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 }
 
 #ifdef CONFIG_PROVE_LOCKING
+static inline struct
+lock_chain *lookup_chain_cache_add(struct task_struct *curr,
+				   struct held_lock *hlock,
+				   u64 chain_key, int depth);
+
 /*
  * Allocate a lockdep entry. (assumes the graph_lock held, returns
  * with NULL on failure)
@@ -2505,87 +2510,6 @@ static inline void inc_chains(void)
 	return 2;
 }
 
-/*
- * Add the dependency to all directly-previous locks that are 'relevant'.
- * The ones that are relevant are (in increasing distance from curr):
- * all consecutive trylock entries and the final non-trylock entry - or
- * the end of this context's lock-chain - whichever comes first.
- */
-static int
-check_prevs_add(struct task_struct *curr, struct held_lock *next,
-		struct lock_chain *chain)
-{
-	struct lock_trace *trace = NULL;
-	int depth = curr->lockdep_depth;
-	struct held_lock *hlock;
-
-	/*
-	 * Debugging checks.
-	 *
-	 * Depth must not be zero for a non-head lock:
-	 */
-	if (!depth)
-		goto out_bug;
-	/*
-	 * At least two relevant locks must exist for this
-	 * to be a head:
-	 */
-	if (curr->held_locks[depth].irq_context !=
-			curr->held_locks[depth-1].irq_context)
-		goto out_bug;
-
-	for (;;) {
-		int distance = curr->lockdep_depth - depth + 1;
-		hlock = curr->held_locks + depth - 1;
-
-		/*
-		 * Only non-recursive-read entries get new dependencies
-		 * added:
-		 */
-		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance,
-						 &trace, chain);
-			if (!ret)
-				return 0;
-
-			/*
-			 * Stop after the first non-trylock entry,
-			 * as non-trylock entries have added their
-			 * own direct dependencies already, so this
-			 * lock is connected to them indirectly:
-			 */
-			if (!hlock->trylock)
-				break;
-		}
-
-		depth--;
-		/*
-		 * End of lock-stack?
-		 */
-		if (!depth)
-			break;
-		/*
-		 * Stop the search if we cross into another context:
-		 */
-		if (curr->held_locks[depth].irq_context !=
-				curr->held_locks[depth-1].irq_context)
-			break;
-	}
-	return 1;
-out_bug:
-	if (!debug_locks_off_graph_unlock())
-		return 0;
-
-	/*
-	 * Clearly we all shouldn't be here, but since we made it we
-	 * can reliable say we messed up our state. See the above two
-	 * gotos for reasons why we could possibly end up here.
-	 */
-	WARN_ON(1);
-
-	return 0;
-}
-
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
@@ -2883,66 +2807,135 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 	return add_chain_cache(curr, hlock, chain_key, depth);
 }
 
-static int validate_chain(struct task_struct *curr, struct held_lock *hlock,
+/*
+ * Check whether last held lock:
+ *
+ * - is irq-safe, if this lock is irq-unsafe
+ * - is softirq-safe, if this lock is hardirq-unsafe
+ *
+ * And check whether the new lock's dependency graph could lead back to the
+ * previous lock:
+ *
+ * - within the current held-lock stack or
+ * - across our accumulated lock dependency graph
+ *
+ * any of these scenarios could lead to a deadlock.
+ */
+static int validate_chain(struct task_struct *curr, struct held_lock *next,
 			  u64 chain_key)
 {
 	struct lock_chain *chain;
+	struct lock_trace *trace = NULL;
+	struct held_lock *hlock;
+	int depth = curr->lockdep_depth;
+
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
-	 * does not add new dependencies, because trylock can be done
-	 * in any order.
-	 *
+	 * does not add new dependencies unless it is taken, because
+	 * attempting to acquire a trylock does not block.
+	 */
+	if (next->trylock || !next->check)
+		return 1;
+
+	/*
+	 * Add the dependency to all previous locks that are 'relevant'. The
+	 * ones that are relevant are (in increasing distance from next lock
+	 * to acquire): all consecutive trylock entries and the final
+	 * non-trylock entry - or the end of this context's lock-chain
+	 * - whichever comes first.
+	 */
+chain_again:
+	hlock = curr->held_locks + depth - 1;
+
+	/*
 	 * We look up the chain_key and do the O(N^2) check and update of
-	 * the dependencies only if this is a new dependency chain.
-	 * (If lookup_chain_cache_add() return with 1 it acquires
-	 * graph_lock for us)
+	 * the dependencies only if this is a new dependency chain. (If
+	 * lookup_chain_cache_add() return with 1 it acquires graph_lock for
+	 * us.)
 	 */
-	if (!hlock->trylock && hlock->check &&
-	    (chain = lookup_chain_cache_add(curr, hlock, chain_key,
-					    curr->lockdep_depth))) {
-		/*
-		 * Check whether last held lock:
-		 *
-		 * - is irq-safe, if this lock is irq-unsafe
-		 * - is softirq-safe, if this lock is hardirq-unsafe
-		 *
-		 * And check whether the new lock's dependency graph
-		 * could lead back to the previous lock:
-		 *
-		 * - within the current held-lock stack
-		 * - across our accumulated lock dependency records
-		 *
-		 * any of these scenarios could lead to a deadlock.
-		 */
+	chain = lookup_chain_cache_add(curr, next, chain_key, depth);
+	if (depth == curr->lockdep_depth) {
+		int ret;
+
+		if (!chain)
+			return 1;
 		/*
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock_current(curr, hlock);
+		ret = check_deadlock_current(curr, next);
 
 		if (!ret)
 			return 0;
 		/*
-		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
+		 * Add dependency only if this lock is not the head of the
+		 * chain, and if it's not a second recursive-read lock. If
+		 * not, there is no need to check further.
 		 */
-		if (chain->depth > 1 && ret != 2) {
-			if (!check_prevs_add(curr, hlock, chain))
+		if (!(chain->depth > 1 && ret != 2))
+			goto out_unlock;
+	}
+
+	/*
+	 * Only non-recursive-read entries get new dependencies
+	 * added:
+	 */
+	if (chain) {
+		if (hlock->read != 2 && hlock->check) {
+			int distance = curr->lockdep_depth - depth + 1;
+
+			if (!check_prev_add(curr, hlock, next, distance,
+					    &trace, chain))
 				return 0;
 		}
 
 		graph_unlock();
-	} else {
-		/* after lookup_chain_cache_add(): */
-		if (unlikely(!debug_locks))
-			return 0;
 	}
 
+	/*
+	 * Stop after the first non-trylock entry, as non-trylock entries
+	 * have added their own direct dependencies already, so this lock is
+	 * connected to them indirectly:
+	 */
+	if (!hlock->trylock)
+		goto out;
+
+	depth--;
+	/*
+	 * End of lock-stack?
+	 */
+	if (!depth)
+		goto out;
+	/*
+	 * Stop the search if we cross into another context:
+	 */
+	if (curr->held_locks[depth].irq_context !=
+			curr->held_locks[depth-1].irq_context)
+		goto out;
+
+	/*
+	 * This is another direct dependency with a further previous lock
+	 * that is separated by a trylock. We compose a lock chain out of
+	 * this, then calculate the chain key, and look it up in the
+	 * lock_chains. If it exists the check is actually not needed.
+	 */
+	chain_key = iterate_chain_key(hlock->prev_chain_key,
+				      hlock_class(next) - lock_classes);
+
+	goto chain_again;
+
+out_unlock:
+	graph_unlock();
+out:
+	/* after lookup_chain_cache_add(): */
+	if (unlikely(!debug_locks))
+		return 0;
+
 	return 1;
 }
 #else
 static inline int validate_chain(struct task_struct *curr,
-				 struct held_lock *hlock,
+				 struct held_lock *next,
 				 u64 chain_key)
 {
 	return 1;
-- 
1.8.3.1


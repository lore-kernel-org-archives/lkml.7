Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C699C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B2F2802A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nbBgFkd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfFCNLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:11:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:11:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DBRCf605320
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:11:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DBRCf605320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567488;
        bh=s34d0VTabWlRAkjesyhOO60Mw419kjVSeWCby5yulP8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nbBgFkd5QVru+VjsdIaaSNR6HTvaswSqRxu7Tff4o6KPMgQVsMvPW8UgOrhrX5Ak6
         Pu8Hrrpi7zO/qtMTIiVzcr5r6ZZ9TtfjuhBu+ka0F8zFA2CcNv6ABXu7DfYkn+K1QA
         XO0IA0WcgQLWsSpaMVw1OOlqAdIUth1yWXUqGKE1E1zJ10dm7dF+fQfvPArIRmOv1h
         f5sbcQDSK4Jfb5i885gLxTR4ezOEfQsPz82PUUA//t6kXN8B5zmkD/ZY2kW1nZpnuB
         m0V6r/na0gZN+7i0ZiF6ooCSjlQElZ91k4S2TpXTv66382J5txw5AFo/gWqZfggPlD
         yWckU+Ni9nbug==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DBQlb605317;
        Mon, 3 Jun 2019 06:11:26 -0700
Date:   Mon, 3 Jun 2019 06:11:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-f6ec8829ac9d59b637366c13038f15d6f6156fe1@git.kernel.org>
Cc:     peterz@infradead.org, duyuyang@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          duyuyang@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190506081939.74287-9-duyuyang@gmail.com>
References: <20190506081939.74287-9-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Define INITIAL_CHAIN_KEY for
 chain keys to start with
Git-Commit-ID: f6ec8829ac9d59b637366c13038f15d6f6156fe1
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

Commit-ID:  f6ec8829ac9d59b637366c13038f15d6f6156fe1
Gitweb:     https://git.kernel.org/tip/f6ec8829ac9d59b637366c13038f15d6f6156fe1
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:24 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:43 +0200

locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with

Chain keys are computed using Jenkins hash function, which needs an initial
hash to start with. Dedicate a macro to make this clear and configurable. A
later patch changes this initial chain key.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-9-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  |  1 +
 init/init_task.c         |  2 +-
 kernel/locking/lockdep.c | 18 +++++++++---------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 5d05b8149f19..d4e69595dbd4 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -229,6 +229,7 @@ struct lock_chain {
  * bitfield and hitting the BUG in hlock_class().
  */
 #define MAX_LOCKDEP_KEYS		((1UL << MAX_LOCKDEP_KEYS_BITS) - 1)
+#define INITIAL_CHAIN_KEY		0
 
 struct held_lock {
 	/*
diff --git a/init/init_task.c b/init/init_task.c
index 1b15cb90d64f..afa6ad795355 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -167,7 +167,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_LOCKDEP
 	.lockdep_depth = 0, /* no locks held yet */
-	.curr_chain_key = 0,
+	.curr_chain_key = INITIAL_CHAIN_KEY,
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b7d9c28ecf3b..9edf6f12b711 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -362,7 +362,7 @@ static inline u64 iterate_chain_key(u64 key, u32 idx)
 void lockdep_init_task(struct task_struct *task)
 {
 	task->lockdep_depth = 0; /* no locks held yet */
-	task->curr_chain_key = 0;
+	task->curr_chain_key = INITIAL_CHAIN_KEY;
 	task->lockdep_recursion = 0;
 }
 
@@ -857,7 +857,7 @@ static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 static bool check_lock_chain_key(struct lock_chain *chain)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
@@ -2524,7 +2524,7 @@ static void
 print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
 {
 	struct held_lock *hlock;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int depth = curr->lockdep_depth;
 	int i = get_first_held_lock(curr, hlock_next);
 
@@ -2544,7 +2544,7 @@ print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_ne
 static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int class_id;
 
 	printk("depth: %u\n", chain->depth);
@@ -2848,7 +2848,7 @@ static void check_chain_key(struct task_struct *curr)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	struct held_lock *hlock, *prev_hlock = NULL;
 	unsigned int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
@@ -2872,7 +2872,7 @@ static void check_chain_key(struct task_struct *curr)
 
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
-			chain_key = 0;
+			chain_key = INITIAL_CHAIN_KEY;
 		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
 		prev_hlock = hlock;
 	}
@@ -3787,14 +3787,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		/*
 		 * How can we have a chain hash when we ain't got no keys?!
 		 */
-		if (DEBUG_LOCKS_WARN_ON(chain_key != 0))
+		if (DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY))
 			return 0;
 		chain_head = 1;
 	}
 
 	hlock->prev_chain_key = chain_key;
 	if (separate_irq_context(curr, hlock)) {
-		chain_key = 0;
+		chain_key = INITIAL_CHAIN_KEY;
 		chain_head = 1;
 	}
 	chain_key = iterate_chain_key(chain_key, class_idx);
@@ -4636,7 +4636,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 recalc:
-	chain_key = 0;
+	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
 		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
 	if (chain->depth && chain->chain_key == chain_key)

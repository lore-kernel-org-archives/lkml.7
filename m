Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72766C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0AF22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr75ywDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfLLWgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:36:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27353 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731186AbfLLWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576190149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MLDm4OmqlP7RV5qwQotAZE19ZRZQdk7ypBqMn8UcI4w=;
        b=Yr75ywDoK9Fd901zNBnQfqNt34FFg+OnSla2dPwtH2R5zTmUoILlDkT2dBNfFVQBXZ3J2k
        yogaGzNzYxtpPumcdAOz/W11qAbr0xyqFsbpAZiUi5gw6OWw/tkibL4A7O2I81fiHXsWCP
        H7atgty6Lz5GuEVoSLQ7tQOIh6K47Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-VL6Oi2tXPZuuIhVgxat44w-1; Thu, 12 Dec 2019 17:35:46 -0500
X-MC-Unique: VL6Oi2tXPZuuIhVgxat44w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B0CD800D41;
        Thu, 12 Dec 2019 22:35:45 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7495760BF3;
        Thu, 12 Dec 2019 22:35:44 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
Date:   Thu, 12 Dec 2019 17:35:24 -0500
Message-Id: <20191212223525.1652-5-longman@redhat.com>
In-Reply-To: <20191212223525.1652-1-longman@redhat.com>
References: <20191212223525.1652-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once a lock class is zapped, all the lock chains that include the zapped
class are essentially useless. The lock_chain structure itself can be
reused, but not the corresponding chain_hlocks[] entries. Over time,
we will run out of chain_hlocks entries while there are still plenty
of other lockdep array entries available.

To fix this imbalance, we have to make chain_hlocks entries reusable
just like the others. As the freed chain_hlocks entries are in blocks of
various lengths. A simple bitmap like the one used in the other reusable
lockdep arrays isn't applicable. Instead a new chain_hlocks_block
structure is used to list the location and the length of each free block.
These chain_hlocks_block structures are then put into an array of hashed
lists for easier lookup by the size of the blocks.

By reusing the chain_hlocks entries, we are able to handle workloads
that add and zap a lot of lock classes as long as the total number of
outstanding lock classes at any time remain within a reasonable limit.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 130 ++++++++++++++++++++++++++---
 kernel/locking/lockdep_internals.h |  10 ++-
 kernel/locking/lockdep_proc.c      |   2 +
 3 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b543bcc5ff50..97c17ba85d29 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2628,6 +2628,88 @@ static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 unsigned long nr_zapped_lock_chains;
 unsigned int nr_chain_hlocks;
 unsigned int nr_leaked_chain_hlocks;
+unsigned int nr_free_chain_hlocks;
+
+#ifdef CONFIG_PROVE_LOCKING
+static struct chain_hlocks_block chain_hlocks_blocks[MAX_CHAIN_HLOCKS_BLOCKS];
+static struct chain_hlocks_block *chain_hlocks_block_hash[CHAIN_HLOCKS_HASH];
+static struct chain_hlocks_block *free_chain_hlocks_blocks;
+
+/*
+ * Graph lock must be held before calling the chain_hlocks_block functions.
+ * Chain hlocks of depth 1-(CHAIN_HLOCKS_HASH-1) is mapped directly to
+ * chain_hlocks_block_hash[1-(CHAIN_HLOCKS_HASH-1)]. All other sizes
+ * are mapped to chain_hlocks_block_hash[0].
+ */
+static inline struct chain_hlocks_block *alloc_chain_hlocks_block(void)
+{
+	struct chain_hlocks_block *block = free_chain_hlocks_blocks;
+
+	WARN_ONCE(!debug_locks_silent && !block,
+		  "Running out of chain_hlocks_block\n");
+	free_chain_hlocks_blocks = block ? block->next : NULL;
+	return block;
+}
+
+static inline void free_chain_hlocks_block(struct chain_hlocks_block *block)
+{
+	block->next = free_chain_hlocks_blocks;
+	free_chain_hlocks_blocks = block;
+}
+
+static inline void push_chain_hlocks_block(struct chain_hlocks_block *block)
+{
+	int hash, depth = block->depth;
+
+	hash = (depth >= CHAIN_HLOCKS_HASH) ? 0 : depth;
+	block->next = chain_hlocks_block_hash[hash];
+	chain_hlocks_block_hash[hash] = block;
+	nr_free_chain_hlocks += depth;
+}
+
+static inline struct chain_hlocks_block *pop_chain_hlocks_block(int depth)
+{
+	struct chain_hlocks_block *curr, **pprev;
+
+	if (!nr_free_chain_hlocks)
+		return NULL;
+
+	if (depth < CHAIN_HLOCKS_HASH) {
+		curr = chain_hlocks_block_hash[depth];
+		if (curr) {
+			chain_hlocks_block_hash[depth] = curr->next;
+			nr_free_chain_hlocks -= depth;
+		}
+		return curr;
+	}
+
+	/*
+	 * For depth >= CHAIN_HLOCKS_HASH, it is not really a pop operation.
+	 * Instead, the first entry with the right size is returned.
+	 */
+	curr  = chain_hlocks_block_hash[0];
+	pprev = chain_hlocks_block_hash;
+
+	while (curr) {
+		if (curr->depth == depth)
+			break;
+		pprev = &(curr->next);
+		curr = curr->next;
+	}
+
+	if (curr) {
+		*pprev = curr->next;
+		nr_free_chain_hlocks -= depth;
+	}
+	return curr;
+}
+#else
+static inline void free_chain_hlocks_block(struct chain_hlocks_block *block) { }
+static inline struct chain_hlocks_block *pop_chain_hlocks_block(int depth)
+{
+	return NULL;
+}
+#endif /* CONFIG_PROVE_LOCKING */
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2800,7 +2882,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 	struct lock_class *class = hlock_class(hlock);
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
-	int i, j;
+	struct chain_hlocks_block *chblock;
+	int i, j, lock_id;
 
 	/*
 	 * The caller must hold the graph lock, ensure we've got IRQs
@@ -2827,14 +2910,12 @@ static inline int add_chain_cache(struct task_struct *curr,
 	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
 	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(curr->held_locks));
 	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <= ARRAY_SIZE(lock_classes));
-
-	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
+	chblock = pop_chain_hlocks_block(chain->depth);
+	if (chblock) {
+		chain->base = chblock->base;
+		free_chain_hlocks_block(chblock);
+	} else if (nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS) {
 		chain->base = nr_chain_hlocks;
-		for (j = 0; j < chain->depth - 1; j++, i++) {
-			int lock_id = curr->held_locks[i].class_idx;
-			chain_hlocks[chain->base + j] = lock_id;
-		}
-		chain_hlocks[chain->base + j] = class - lock_classes;
 		nr_chain_hlocks += chain->depth;
 	} else {
 		if (!debug_locks_off_graph_unlock())
@@ -2845,6 +2926,11 @@ static inline int add_chain_cache(struct task_struct *curr,
 		return 0;
 	}
 
+	for (j = 0; j < chain->depth - 1; j++, i++) {
+		lock_id = curr->held_locks[i].class_idx;
+		chain_hlocks[chain->base + j] = lock_id;
+	}
+	chain_hlocks[chain->base + j] = class - lock_classes;
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
 	inc_chains();
@@ -4773,12 +4859,24 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 {
 #ifdef CONFIG_PROVE_LOCKING
 	int i;
+	struct chain_hlocks_block *chblock;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++) {
 		if (chain_hlocks[i] != class - lock_classes)
 			continue;
-		/* Account for leaked chain_hlock[] entries. */
-		nr_leaked_chain_hlocks += chain->depth;
+		/*
+		 * Try to save the free chain_hlock[] entries in a
+		 * chain_hlocks_block. If no free chain_hlocks_block is
+		 * available, count the entries in nr_leaked_chain_hlocks.
+		 */
+		chblock = alloc_chain_hlocks_block();
+		if (chblock) {
+			chblock->base  = chain->base;
+			chblock->depth = chain->depth;
+			push_chain_hlocks_block(chblock);
+		} else {
+			nr_leaked_chain_hlocks += chain->depth;
+		}
 
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
@@ -5217,6 +5315,18 @@ void __init lockdep_init(void)
 
 	printk(" per task-struct memory footprint: %zu bytes\n",
 	       sizeof(((struct task_struct *)NULL)->held_locks));
+
+#ifdef CONFIG_PROVE_LOCKING
+	{
+		int i;
+
+		/* Put all chain hlock blocks into the free list */
+		free_chain_hlocks_blocks = chain_hlocks_blocks;
+		for (i = 0; i < MAX_CHAIN_HLOCKS_BLOCKS - 1; i++)
+			chain_hlocks_blocks[i].next = &chain_hlocks_blocks[i+1];
+		chain_hlocks_blocks[i].next = NULL;
+	}
+#endif
 }
 
 static void
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 4c23ab7d27c2..999cd714e0d1 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -107,8 +107,15 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #endif
 
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
-
 #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
+#define MAX_CHAIN_HLOCKS_BLOCKS	1024
+#define CHAIN_HLOCKS_HASH	8
+
+struct chain_hlocks_block {
+	unsigned int		   depth: 8,
+				   base :24;
+	struct chain_hlocks_block *next;
+};
 
 extern struct list_head all_lock_classes;
 extern struct lock_chain lock_chains[];
@@ -136,6 +143,7 @@ extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
 extern unsigned int nr_chain_hlocks;
 extern unsigned int nr_leaked_chain_hlocks;
+extern unsigned int nr_free_chain_hlocks;
 
 extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 65a1b96238ef..126e6869412f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -349,6 +349,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 			nr_zapped_lock_chains);
 	seq_printf(m, " leaked chain hlocks:           %11u\n",
 			nr_leaked_chain_hlocks);
+	seq_printf(m, " free chain hlocks:             %11u\n",
+			nr_free_chain_hlocks);
 	return 0;
 }
 
-- 
2.18.1


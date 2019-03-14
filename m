Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C63C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3D42184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCNFGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:06:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbfCNFGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:06:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0332BADED;
        Thu, 14 Mar 2019 05:06:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu, 14 Mar 2019 16:05:28 +1100
Subject: [PATCH 2/3] rhashtable: don't hold lock on first table throughout
 insertion.
Cc:     netdev@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Message-ID: <155253992829.5022.17977838545670077984.stgit@noble.brown>
In-Reply-To: <155253979234.5022.1840929790507376038.stgit@noble.brown>
References: <155253979234.5022.1840929790507376038.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_try_insert() currently holds a lock on the bucket in
the first table, while also locking buckets in subsequent tables.
This is unnecessary and looks like a hold-over from some earlier
version of the implementation.

As insert and remove always lock a bucket in each table in turn, and
as insert only inserts in the final table, there cannot be any races
that are not covered by simply locking a bucket in each table in turn.

When an insert call reaches that last table it can be sure that there
is no matchinf entry in any other table as it has searched them all, and
insertion never happens anywhere but in the last table.  The fact that
code tests for the existence of future_tbl while holding a lock on
the relevant bucket ensures that two threads inserting the same key
will make compatible decisions about which is the "last" table.

This simplifies the code and allows the ->rehash field to be
discarded.

We still need a way to ensure that a dead bucket_table is never
re-linked by rhashtable_walk_stop().  This can be achieved by calling
call_rcu() inside the locked region, and checking with
rcu_head_after_call_rcu() in rhashtable_walk_stop() to see if the
bucket table is empty and dead.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   13 -----------
 lib/rhashtable.c           |   50 +++++++++++++-------------------------------
 2 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ae9c0f71f311..3864193d5e2e 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -63,7 +63,6 @@
 struct bucket_table {
 	unsigned int		size;
 	unsigned int		nest;
-	unsigned int		rehash;
 	u32			hash_rnd;
 	unsigned int		locks_mask;
 	spinlock_t		*locks;
@@ -776,12 +775,6 @@ static inline int rhltable_insert(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
- * Locks down the bucket chain in both the old and new table if a resize
- * is in progress to ensure that writers can't remove from the old table
- * and can't insert to the new table during the atomic operation of search
- * and insertion. Searches for duplicates in both the old and new table if
- * a resize is in progress.
- *
  * This lookup function may only be used for fixed key hash table (key_len
  * parameter set). It will BUG() if used inappropriately.
  *
@@ -837,12 +830,6 @@ static inline void *rhashtable_lookup_get_insert_fast(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
- * Locks down the bucket chain in both the old and new table if a resize
- * is in progress to ensure that writers can't remove from the old table
- * and can't insert to the new table during the atomic operation of search
- * and insertion. Searches for duplicates in both the old and new table if
- * a resize is in progress.
- *
  * Lookups may occur in parallel with hashtable mutations and resizing.
  *
  * Will trigger an automatic deferred table resizing if residency in the
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c983c0ee15d5..03ba449c6d38 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -199,6 +199,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 		return NULL;
 	}
 
+	rcu_head_init(&tbl->rcu);
 	INIT_LIST_HEAD(&tbl->walkers);
 
 	tbl->hash_rnd = get_random_u32();
@@ -282,10 +283,9 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 	while (!(err = rhashtable_rehash_one(ht, old_hash)))
 		;
 
-	if (err == -ENOENT) {
-		old_tbl->rehash++;
+	if (err == -ENOENT)
 		err = 0;
-	}
+
 	spin_unlock_bh(old_bucket_lock);
 
 	return err;
@@ -332,13 +332,16 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 	spin_lock(&ht->lock);
 	list_for_each_entry(walker, &old_tbl->walkers, list)
 		walker->tbl = NULL;
-	spin_unlock(&ht->lock);
 
 	/* Wait for readers. All new readers will see the new
 	 * table, and thus no references to the old table will
 	 * remain.
+	 * We do this inside the locked region so that
+	 * rhashtable_walk_stop() can use rcu_head_after_call_rcu()
+	 * to check if it should not re-link the table.
 	 */
 	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
+	spin_unlock(&ht->lock);
 
 	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
 }
@@ -580,36 +583,14 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
 	unsigned int hash;
-	spinlock_t *lock;
 	void *data;
 
-	tbl = rcu_dereference(ht->tbl);
-
-	/* All insertions must grab the oldest table containing
-	 * the hashed bucket that is yet to be rehashed.
-	 */
-	for (;;) {
-		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
-		lock = rht_bucket_lock(tbl, hash);
-		spin_lock_bh(lock);
-
-		if (tbl->rehash <= hash)
-			break;
-
-		spin_unlock_bh(lock);
-		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
-	}
-
-	data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
-	new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
-	if (PTR_ERR(new_tbl) != -EEXIST)
-		data = ERR_CAST(new_tbl);
+	new_tbl = rcu_dereference(ht->tbl);
 
-	while (!IS_ERR_OR_NULL(new_tbl)) {
+	do {
 		tbl = new_tbl;
 		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
-		spin_lock_nested(rht_bucket_lock(tbl, hash),
-				 SINGLE_DEPTH_NESTING);
+		spin_lock(rht_bucket_lock(tbl, hash));
 
 		data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
 		new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
@@ -617,9 +598,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			data = ERR_CAST(new_tbl);
 
 		spin_unlock(rht_bucket_lock(tbl, hash));
-	}
-
-	spin_unlock_bh(lock);
+	} while (!IS_ERR_OR_NULL(new_tbl));
 
 	if (PTR_ERR(data) == -EAGAIN)
 		data = ERR_PTR(rhashtable_insert_rehash(ht, tbl) ?:
@@ -941,10 +920,11 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
 	ht = iter->ht;
 
 	spin_lock(&ht->lock);
-	if (tbl->rehash < tbl->size)
-		list_add(&iter->walker.list, &tbl->walkers);
-	else
+	if (rcu_head_after_call_rcu(&tbl->rcu, bucket_table_free_rcu))
+		/* This bucket table is being freed, don't re-link it. */
 		iter->walker.tbl = NULL;
+	else
+		list_add(&iter->walker.list, &tbl->walkers);
 	spin_unlock(&ht->lock);
 
 out:



Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C641320880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfDAXIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:08:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfDAXIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:08:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55EB9AFF9;
        Mon,  1 Apr 2019 23:08:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue, 02 Apr 2019 10:07:45 +1100
Subject: [PATCH 4/4] rhashtable: add lockdep tracking to bucket
 bit-spin-locks.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155416006526.9540.4026790790099071023.stgit@noble.brown>
In-Reply-To: <155416000985.9540.14182958463813560577.stgit@noble.brown>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Native bit_spin_locks are not tracked by lockdep.

The bit_spin_locks used for rhashtable buckets are local
to the rhashtable implementation, so there is little opportunity
for the sort of misuse that lockdep might detect.
However locks are held while a hash function or compare
function is called, and if one of these took a lock,
a misbehaviour is possible.

As it is quite easy to add lockdep support this unlikely
possibility seems to be enough justification.

So create a lockdep class for bucket bit_spin_lock and attach
through a lockdep_map in each bucket_table.

Without the 'nested' annotation in rhashtable_rehash_one(), lockdep
correctly reports a possible problem as this lock is taken
while another bucket lock (in another table) is held.  This
confirms that the added support works.
With the correct nested annotation in place, lockdep reports
no problems.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   51 +++++++++++++++++++++++++++++---------------
 lib/rhashtable.c           |   15 ++++++++-----
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ccbbafdf5547..460c0eaf6b96 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -82,6 +82,8 @@ struct bucket_table {
 
 	struct bucket_table __rcu *future_tbl;
 
+	struct lockdep_map	dep_map;
+
 	struct rhash_lock_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
@@ -102,23 +104,38 @@ struct bucket_table {
  * this is safe.
  */
 
-static inline void rht_lock(struct rhash_lock_head **bkt)
+static inline void rht_lock(struct bucket_table *tbl,
+			    struct rhash_lock_head **bkt)
 {
 	local_bh_disable();
 	bit_spin_lock(1, (unsigned long *)bkt);
+	lock_map_acquire(&tbl->dep_map);
+}
+
+static inline void rht_lock_nested(struct bucket_table *tbl,
+				   struct rhash_lock_head **bucket,
+				   unsigned int subclass)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
 }
 
-static inline void rht_unlock(struct rhash_lock_head **bkt)
+static inline void rht_unlock(struct bucket_table *tbl,
+			      struct rhash_lock_head **bkt)
 {
+	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(1, (unsigned long *)bkt);
 	local_bh_enable();
 }
 
-static inline void rht_assign_unlock(struct rhash_lock_head **bkt,
+static inline void rht_assign_unlock(struct bucket_table *tbl,
+				     struct rhash_lock_head **bkt,
 				     struct rhash_head *obj)
 {
 	struct rhash_head **p = (struct rhash_head **)bkt;
 
+	lock_map_release(&tbl->dep_map);
 	rcu_assign_pointer(*p, obj);
 	preempt_enable();
 	__release(bitlock);
@@ -672,11 +689,11 @@ static inline void *__rhashtable_insert_fast(
 	if (!bkt)
 		goto out;
 	pprev = NULL;
-	rht_lock(bkt);
+	rht_lock(tbl, bkt);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		rht_unlock(bkt);
+		rht_unlock(tbl, bkt);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
@@ -708,9 +725,9 @@ static inline void *__rhashtable_insert_fast(
 		RCU_INIT_POINTER(list->rhead.next, head);
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj);
-			rht_unlock(bkt);
+			rht_unlock(tbl, bkt);
 		} else
-			rht_assign_unlock(bkt, obj);
+			rht_assign_unlock(tbl, bkt, obj);
 		data = NULL;
 		goto out;
 	}
@@ -737,7 +754,7 @@ static inline void *__rhashtable_insert_fast(
 	}
 
 	atomic_inc(&ht->nelems);
-	rht_assign_unlock(bkt, obj);
+	rht_assign_unlock(tbl, bkt, obj);
 
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
@@ -749,7 +766,7 @@ static inline void *__rhashtable_insert_fast(
 	return data;
 
 out_unlock:
-	rht_unlock(bkt);
+	rht_unlock(tbl, bkt);
 	goto out;
 }
 
@@ -951,7 +968,7 @@ static inline int __rhashtable_remove_fast_one(
 	if (!bkt)
 		return -ENOENT;
 	pprev = NULL;
-	rht_lock(bkt);
+	rht_lock(tbl, bkt);
 
 	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
 		struct rhlist_head *list;
@@ -995,14 +1012,14 @@ static inline int __rhashtable_remove_fast_one(
 
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj);
-			rht_unlock(bkt);
+			rht_unlock(tbl, bkt);
 		} else {
-			rht_assign_unlock(bkt, obj);
+			rht_assign_unlock(tbl, bkt, obj);
 		}
 		goto unlocked;
 	}
 
-	rht_unlock(bkt);
+	rht_unlock(tbl, bkt);
 unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
@@ -1110,7 +1127,7 @@ static inline int __rhashtable_replace_fast(
 		return -ENOENT;
 
 	pprev = NULL;
-	rht_lock(bkt);
+	rht_lock(tbl, bkt);
 
 	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
 		if (he != obj_old) {
@@ -1121,15 +1138,15 @@ static inline int __rhashtable_replace_fast(
 		rcu_assign_pointer(obj_new->next, obj_old->next);
 		if (pprev) {
 			rcu_assign_pointer(*pprev, obj_new);
-			rht_unlock(bkt);
+			rht_unlock(tbl, bkt);
 		} else {
-			rht_assign_unlock(bkt, obj_new);
+			rht_assign_unlock(tbl, bkt, obj_new);
 		}
 		err = 0;
 		goto unlocked;
 	}
 
-	rht_unlock(bkt);
+	rht_unlock(tbl, bkt);
 
 unlocked:
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c5d0974467ee..a8583af43b59 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -173,6 +173,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	struct bucket_table *tbl = NULL;
 	size_t size;
 	int i;
+	static struct lock_class_key __key;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
 	tbl = kvzalloc(size, gfp);
@@ -187,6 +188,8 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	if (tbl == NULL)
 		return NULL;
 
+	lockdep_init_map(&tbl->dep_map, "rhashtable_bucket", &__key, 0);
+
 	tbl->size = size;
 
 	rcu_head_init(&tbl->rcu);
@@ -244,14 +247,14 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	new_hash = head_hashfn(ht, new_tbl, entry);
 
-	rht_lock(&new_tbl->buckets[new_hash]);
+	rht_lock_nested(new_tbl, &new_tbl->buckets[new_hash], SINGLE_DEPTH_NESTING);
 
 	head = rht_ptr(rht_dereference_bucket(new_tbl->buckets[new_hash],
 					      new_tbl, new_hash));
 
 	RCU_INIT_POINTER(entry->next, head);
 
-	rht_assign_unlock(&new_tbl->buckets[new_hash], entry);
+	rht_assign_unlock(new_tbl, &new_tbl->buckets[new_hash], entry);
 
 	if (pprev)
 		rcu_assign_pointer(*pprev, next);
@@ -272,14 +275,14 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 
 	if (!bkt)
 		return 0;
-	rht_lock(bkt);
+	rht_lock(old_tbl, bkt);
 
 	while (!(err = rhashtable_rehash_one(ht, bkt, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-	rht_unlock(bkt);
+	rht_unlock(old_tbl, bkt);
 
 	return err;
 }
@@ -600,7 +603,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
-			rht_lock(bkt);
+			rht_lock(tbl, bkt);
 			data = rhashtable_lookup_one(ht, bkt, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
@@ -608,7 +611,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
-			rht_unlock(bkt);
+			rht_unlock(tbl, bkt);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 



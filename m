Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D76C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC74320880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfDAXIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfDAXId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:08:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B63A0AFF9;
        Mon,  1 Apr 2019 23:08:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue, 02 Apr 2019 10:07:45 +1100
Subject: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155416006521.9540.5662092375167065834.stgit@noble.brown>
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

This patch changes rhashtables to use a bit_spin_lock on BIT(1) of the
bucket pointer to lock the hash chain for that bucket.

The benefits of a bit spin_lock are:
 - no need to allocate a separate array of locks.
 - no need to have a configuration option to guide the
   choice of the size of this array
 - locking cost is often a single test-and-set in a cache line
   that will have to be loaded anyway.  When inserting at, or removing
   from, the head of the chain, the unlock is free - writing the new
   address in the bucket head implicitly clears the lock bit.
   For __rhashtable_insert_fast() we ensure this always happens
   when adding a new key.
 - even when lockings costs 2 updates (lock and unlock), they are
   in a cacheline that needs to be read anyway.

The cost of using a bit spin_lock is a little bit of code complexity,
which I think is quite manageable.

Bit spin_locks are sometimes inappropriate because they are not fair -
if multiple CPUs repeatedly contend of the same lock, one CPU can
easily be starved.  This is not a credible situation with rhashtable.
Multiple CPUs may want to repeatedly add or remove objects, but they
will typically do so at different buckets, so they will attempt to
acquire different locks.

As we have more bit-locks than we previously had spinlocks (by at
least a factor of two) we can expect slightly less contention to
go with the slightly better cache behavior and reduced memory
consumption.

To enhance type checking, a new struct is introduced to represent the
  pointer plus lock-bit
that is stored in the bucket-table.  This is "struct rhash_lock_head"
and is empty.  A pointer to this needs to be cast to either an
unsigned lock, or a "struct rhash_head *" to be useful.
Variables of this type are most often called "bkt".

Previously "pprev" would sometimes point to a bucket, and sometimes a
->next pointer in an rhash_head.  As these are now different types,
pprev is NULL when it would have pointed to the bucket. In that case,
'blk' is used, together with correct locking protocol.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable-types.h |    2 
 include/linux/rhashtable.h       |  261 ++++++++++++++++++++++++--------------
 ipc/util.c                       |    1 
 lib/rhashtable.c                 |  141 ++++++++++-----------
 lib/test_rhashtable.c            |    2 
 net/bridge/br_fdb.c              |    1 
 net/bridge/br_multicast.c        |    1 
 net/bridge/br_vlan.c             |    1 
 net/bridge/br_vlan_tunnel.c      |    1 
 net/ipv4/ipmr.c                  |    1 
 net/ipv6/ip6mr.c                 |    1 
 net/netfilter/nf_tables_api.c    |    1 
 12 files changed, 236 insertions(+), 178 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index 763d613ce2c2..57467cbf4c5b 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -48,7 +48,6 @@ typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
  * @head_offset: Offset of rhash_head in struct to be hashed
  * @max_size: Maximum size while expanding
  * @min_size: Minimum size while shrinking
- * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
  * @automatic_shrinking: Enable automatic shrinking of tables
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
@@ -62,7 +61,6 @@ struct rhashtable_params {
 	unsigned int		max_size;
 	u16			min_size;
 	bool			automatic_shrinking;
-	u8			locks_mul;
 	rht_hashfn_t		hashfn;
 	rht_obj_hashfn_t	obj_hashfn;
 	rht_obj_cmpfn_t		obj_cmpfn;
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 0c9175aeab8a..ccbbafdf5547 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -24,12 +24,27 @@
 #include <linux/list_nulls.h>
 #include <linux/workqueue.h>
 #include <linux/rculist.h>
+#include <linux/bit_spinlock.h>
 
 #include <linux/rhashtable-types.h>
 /*
+ * Objects in an rhashtable have an embedded struct rhash_head
+ * which is linked into as hash chain from the hash table - or one
+ * of two or more hash tables when the rhashtable is being resized.
  * The end of the chain is marked with a special nulls marks which has
- * the least significant bit set.
+ * the least significant bit set but otherwise stores the address of
+ * the hash bucket.  This allows us to be be sure we've found the end
+ * of the right list.
+ * The value stored in the hash bucket has BIT(2) used as a lock bit.
+ * This bit must be atomically set before any changes are made to
+ * the chain.  To avoid dereferencing this pointer without clearing
+ * the bit first, we use an opaque 'struct rhash_lock_head *' for the
+ * pointer stored in the bucket.  This struct needs to be defined so
+ * that rcu_derefernce() works on it, but it has no content so a
+ * cast is needed for it to be useful.  This ensures it isn't
+ * used by mistake with clearing the lock bit first.
  */
+struct rhash_lock_head {};
 
 /* Maximum chain length before rehash
  *
@@ -52,8 +67,6 @@
  * @nest: Number of bits of first-level nested table.
  * @rehash: Current bucket being rehashed
  * @hash_rnd: Random seed to fold into hash
- * @locks_mask: Mask to apply before accessing locks[]
- * @locks: Array of spinlocks protecting individual buckets
  * @walkers: List of active walkers
  * @rcu: RCU structure for freeing the table
  * @future_tbl: Table under construction during rehashing
@@ -64,16 +77,70 @@ struct bucket_table {
 	unsigned int		size;
 	unsigned int		nest;
 	u32			hash_rnd;
-	unsigned int		locks_mask;
-	spinlock_t		*locks;
 	struct list_head	walkers;
 	struct rcu_head		rcu;
 
 	struct bucket_table __rcu *future_tbl;
 
-	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
+	struct rhash_lock_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
+/*
+ * We lock a bucket by setting BIT(1) in the pointer - this is always
+ * zero in real pointers and in the nulls marker.
+ * bit_spin_locks do not handle contention well, but the whole point
+ * of the hashtable design is to achieve minimum per-bucket contention.
+ * A nested hash table might not have a bucket pointer.  In that case
+ * we cannot get a lock.  For remove and replace the bucket cannot be
+ * interesting and doesn't need locking.
+ * For insert we allocate the bucket if this is the last bucket_table,
+ * and then take the lock.
+ * Sometimes we unlock a bucket by writing a new pointer there.  In that
+ * case we don't need to unlock, but we do need to reset state such as
+ * local_bh. For that we have rht_assign_unlock().  As rcu_assign_pointer()
+ * provides the same release semantics that bit_spin_unlock() provides,
+ * this is safe.
+ */
+
+static inline void rht_lock(struct rhash_lock_head **bkt)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bkt);
+}
+
+static inline void rht_unlock(struct rhash_lock_head **bkt)
+{
+	bit_spin_unlock(1, (unsigned long *)bkt);
+	local_bh_enable();
+}
+
+static inline void rht_assign_unlock(struct rhash_lock_head **bkt,
+				     struct rhash_head *obj)
+{
+	struct rhash_head **p = (struct rhash_head **)bkt;
+
+	rcu_assign_pointer(*p, obj);
+	preempt_enable();
+	__release(bitlock);
+	local_bh_enable();
+}
+
+/*
+ * If 'p' is a bucket head and might be locked:
+ *   rht_ptr() returns the address without the lock bit.
+ *   rht_ptr_locked() returns the address WITH the lock bit.
+ */
+static inline struct rhash_head __rcu *rht_ptr(const struct rhash_lock_head *p)
+{
+	return (void *)(((unsigned long)p) & ~BIT(1));
+}
+
+static inline struct rhash_lock_head __rcu *rht_ptr_locked(const
+							   struct rhash_head *p)
+{
+	return (void *)(((unsigned long)p) | BIT(1));
+}
+
 /*
  * NULLS_MARKER() expects a hash value with the low
  * bits mostly likely to be significant, and it discards
@@ -206,25 +273,6 @@ static inline bool rht_grow_above_max(const struct rhashtable *ht,
 	return atomic_read(&ht->nelems) >= ht->max_elems;
 }
 
-/* The bucket lock is selected based on the hash and protects mutations
- * on a group of hash buckets.
- *
- * A maximum of tbl->size/2 bucket locks is allocated. This ensures that
- * a single lock always covers both buckets which may both contains
- * entries which link to the same bucket of the old table during resizing.
- * This allows to simplify the locking as locking the bucket in both
- * tables during resize always guarantee protection.
- *
- * IMPORTANT: When holding the bucket lock of both the old and new table
- * during expansions and shrinking, the old bucket lock must always be
- * acquired first.
- */
-static inline spinlock_t *rht_bucket_lock(const struct bucket_table *tbl,
-					  unsigned int hash)
-{
-	return &tbl->locks[hash & tbl->locks_mask];
-}
-
 #ifdef CONFIG_PROVE_LOCKING
 int lockdep_rht_mutex_is_held(struct rhashtable *ht);
 int lockdep_rht_bucket_is_held(const struct bucket_table *tbl, u32 hash);
@@ -263,13 +311,13 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
 				 void *arg);
 void rhashtable_destroy(struct rhashtable *ht);
 
-struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
-					    unsigned int hash);
-struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
-					      unsigned int hash);
-struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
-						   struct bucket_table *tbl,
+struct rhash_lock_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
+						 unsigned int hash);
+struct rhash_lock_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
 						   unsigned int hash);
+struct rhash_lock_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
+							struct bucket_table *tbl,
+							unsigned int hash);
 
 #define rht_dereference(p, ht) \
 	rcu_dereference_protected(p, lockdep_rht_mutex_is_held(ht))
@@ -286,21 +334,21 @@ struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 #define rht_entry(tpos, pos, member) \
 	({ tpos = container_of(pos, typeof(*tpos), member); 1; })
 
-static inline struct rhash_head __rcu *const *rht_bucket(
+static inline struct rhash_lock_head __rcu *const *rht_bucket(
 	const struct bucket_table *tbl, unsigned int hash)
 {
 	return unlikely(tbl->nest) ? rht_bucket_nested(tbl, hash) :
 				     &tbl->buckets[hash];
 }
 
-static inline struct rhash_head __rcu **rht_bucket_var(
+static inline struct rhash_lock_head __rcu **rht_bucket_var(
 	struct bucket_table *tbl, unsigned int hash)
 {
 	return unlikely(tbl->nest) ? __rht_bucket_nested(tbl, hash) :
 				     &tbl->buckets[hash];
 }
 
-static inline struct rhash_head __rcu **rht_bucket_insert(
+static inline struct rhash_lock_head __rcu **rht_bucket_insert(
 	struct rhashtable *ht, struct bucket_table *tbl, unsigned int hash)
 {
 	return unlikely(tbl->nest) ? rht_bucket_nested_insert(ht, tbl, hash) :
@@ -326,7 +374,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each(pos, tbl, hash) \
-	rht_for_each_from(pos, *rht_bucket(tbl, hash), tbl, hash)
+	rht_for_each_from(pos, rht_ptr(*rht_bucket(tbl, hash)), tbl, hash)
 
 /**
  * rht_for_each_entry_from - iterate over hash chain from given head
@@ -351,7 +399,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry(tpos, pos, tbl, hash, member)		\
-	rht_for_each_entry_from(tpos, pos, *rht_bucket(tbl, hash),	\
+	rht_for_each_entry_from(tpos, pos, rht_ptr(*rht_bucket(tbl, hash)), \
 				    tbl, hash, member)
 
 /**
@@ -367,7 +415,8 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * remove the loop cursor from the list.
  */
 #define rht_for_each_entry_safe(tpos, pos, next, tbl, hash, member)	      \
-	for (pos = rht_dereference_bucket(*rht_bucket(tbl, hash), tbl, hash), \
+	for (pos = rht_dereference_bucket(rht_ptr(*rht_bucket(tbl, hash)),    \
+					  tbl, hash),			      \
 	     next = !rht_is_a_nulls(pos) ?				      \
 		       rht_dereference_bucket(pos->next, tbl, hash) : NULL;   \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	      \
@@ -402,8 +451,12 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * the _rcu mutation primitives such as rhashtable_insert() as long as the
  * traversal is guarded by rcu_read_lock().
  */
-#define rht_for_each_rcu(pos, tbl, hash)				\
-	rht_for_each_rcu_from(pos, *rht_bucket(tbl, hash), tbl, hash)
+#define rht_for_each_rcu(pos, tbl, hash)			\
+	for (({barrier(); }),						\
+	     pos = rht_ptr(rht_dereference_bucket_rcu(			\
+				   *rht_bucket(tbl, hash), tbl, hash));	\
+	     !rht_is_a_nulls(pos);					\
+	     pos = rcu_dereference_raw(pos->next))
 
 /**
  * rht_for_each_entry_rcu_from - iterated over rcu hash chain from given head
@@ -437,7 +490,8 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		   \
-	rht_for_each_entry_rcu_from(tpos, pos, *rht_bucket(tbl, hash), \
+	rht_for_each_entry_rcu_from(tpos, pos,				   \
+					rht_ptr(*rht_bucket(tbl, hash)),   \
 					tbl, hash, member)
 
 /**
@@ -483,7 +537,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 		.ht = ht,
 		.key = key,
 	};
-	struct rhash_head __rcu * const *head;
+	struct rhash_lock_head __rcu * const *bkt;
 	struct bucket_table *tbl;
 	struct rhash_head *he;
 	unsigned int hash;
@@ -491,9 +545,10 @@ static inline struct rhash_head *__rhashtable_lookup(
 	tbl = rht_dereference_rcu(ht->tbl, ht);
 restart:
 	hash = rht_key_hashfn(ht, tbl, key, params);
-	head = rht_bucket(tbl, hash);
+	bkt = rht_bucket(tbl, hash);
 	do {
-		rht_for_each_rcu_from(he, *head, tbl, hash) {
+		he = rht_ptr(rht_dereference_bucket_rcu(*bkt, tbl, hash));
+		rht_for_each_rcu_from(he, he, tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 			    rhashtable_compare(&arg, rht_obj(ht, he)))
@@ -503,7 +558,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 		/* An object might have been moved to a different hash chain,
 		 * while we walk along it - better check and retry.
 		 */
-	} while (he != RHT_NULLS_MARKER(head));
+	} while (he != RHT_NULLS_MARKER(bkt));
 
 	/* Ensure we see any new tables. */
 	smp_rmb();
@@ -599,10 +654,10 @@ static inline void *__rhashtable_insert_fast(
 		.ht = ht,
 		.key = key,
 	};
+	struct rhash_lock_head __rcu **bkt;
 	struct rhash_head __rcu **pprev;
 	struct bucket_table *tbl;
 	struct rhash_head *head;
-	spinlock_t *lock;
 	unsigned int hash;
 	int elasticity;
 	void *data;
@@ -611,23 +666,22 @@ static inline void *__rhashtable_insert_fast(
 
 	tbl = rht_dereference_rcu(ht->tbl, ht);
 	hash = rht_head_hashfn(ht, tbl, obj, params);
-	lock = rht_bucket_lock(tbl, hash);
-	spin_lock_bh(lock);
+	elasticity = RHT_ELASTICITY;
+	bkt = rht_bucket_insert(ht, tbl, hash);
+	data = ERR_PTR(-ENOMEM);
+	if (!bkt)
+		goto out;
+	pprev = NULL;
+	rht_lock(bkt);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		spin_unlock_bh(lock);
+		rht_unlock(bkt);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
 
-	elasticity = RHT_ELASTICITY;
-	pprev = rht_bucket_insert(ht, tbl, hash);
-	data = ERR_PTR(-ENOMEM);
-	if (!pprev)
-		goto out;
-
-	rht_for_each_from(head, *pprev, tbl, hash) {
+	rht_for_each_from(head, rht_ptr(*bkt), tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
 
@@ -643,7 +697,7 @@ static inline void *__rhashtable_insert_fast(
 		data = rht_obj(ht, head);
 
 		if (!rhlist)
-			goto out;
+			goto out_unlock;
 
 
 		list = container_of(obj, struct rhlist_head, rhead);
@@ -652,9 +706,13 @@ static inline void *__rhashtable_insert_fast(
 		RCU_INIT_POINTER(list->next, plist);
 		head = rht_dereference_bucket(head->next, tbl, hash);
 		RCU_INIT_POINTER(list->rhead.next, head);
-		rcu_assign_pointer(*pprev, obj);
-
-		goto good;
+		if (pprev) {
+			rcu_assign_pointer(*pprev, obj);
+			rht_unlock(bkt);
+		} else
+			rht_assign_unlock(bkt, obj);
+		data = NULL;
+		goto out;
 	}
 
 	if (elasticity <= 0)
@@ -662,12 +720,13 @@ static inline void *__rhashtable_insert_fast(
 
 	data = ERR_PTR(-E2BIG);
 	if (unlikely(rht_grow_above_max(ht, tbl)))
-		goto out;
+		goto out_unlock;
 
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		goto slow_path;
 
-	head = rht_dereference_bucket(*pprev, tbl, hash);
+	/* Inserting at head of list makes unlocking free. */
+	head = rht_ptr(rht_dereference_bucket(*bkt, tbl, hash));
 
 	RCU_INIT_POINTER(obj->next, head);
 	if (rhlist) {
@@ -677,20 +736,21 @@ static inline void *__rhashtable_insert_fast(
 		RCU_INIT_POINTER(list->next, NULL);
 	}
 
-	rcu_assign_pointer(*pprev, obj);
-
 	atomic_inc(&ht->nelems);
+	rht_assign_unlock(bkt, obj);
+
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
 
-good:
 	data = NULL;
-
 out:
-	spin_unlock_bh(lock);
 	rcu_read_unlock();
 
 	return data;
+
+out_unlock:
+	rht_unlock(bkt);
+	goto out;
 }
 
 /**
@@ -699,9 +759,9 @@ static inline void *__rhashtable_insert_fast(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
- * Will take a per bucket spinlock to protect against mutual mutations
+ * Will take the per bucket bitlock to protect against mutual mutations
  * on the same bucket. Multiple insertions may occur in parallel unless
- * they map to the same bucket lock.
+ * they map to the same bucket.
  *
  * It is safe to call this function from atomic context.
  *
@@ -728,9 +788,9 @@ static inline int rhashtable_insert_fast(
  * @list:	pointer to hash list head inside object
  * @params:	hash table parameters
  *
- * Will take a per bucket spinlock to protect against mutual mutations
+ * Will take the per bucket bitlock to protect against mutual mutations
  * on the same bucket. Multiple insertions may occur in parallel unless
- * they map to the same bucket lock.
+ * they map to the same bucket.
  *
  * It is safe to call this function from atomic context.
  *
@@ -751,9 +811,9 @@ static inline int rhltable_insert_key(
  * @list:	pointer to hash list head inside object
  * @params:	hash table parameters
  *
- * Will take a per bucket spinlock to protect against mutual mutations
+ * Will take the per bucket bitlock to protect against mutual mutations
  * on the same bucket. Multiple insertions may occur in parallel unless
- * they map to the same bucket lock.
+ * they map to the same bucket.
  *
  * It is safe to call this function from atomic context.
  *
@@ -880,21 +940,20 @@ static inline int __rhashtable_remove_fast_one(
 	struct rhash_head *obj, const struct rhashtable_params params,
 	bool rhlist)
 {
+	struct rhash_lock_head __rcu **bkt;
 	struct rhash_head __rcu **pprev;
 	struct rhash_head *he;
-	spinlock_t * lock;
 	unsigned int hash;
 	int err = -ENOENT;
 
 	hash = rht_head_hashfn(ht, tbl, obj, params);
-	lock = rht_bucket_lock(tbl, hash);
+	bkt = rht_bucket_var(tbl, hash);
+	if (!bkt)
+		return -ENOENT;
+	pprev = NULL;
+	rht_lock(bkt);
 
-	spin_lock_bh(lock);
-
-	pprev = rht_bucket_var(tbl, hash);
-	if (!pprev)
-		goto out;
-	rht_for_each_from(he, *pprev, tbl, hash) {
+	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
 		struct rhlist_head *list;
 
 		list = container_of(he, struct rhlist_head, rhead);
@@ -934,13 +993,17 @@ static inline int __rhashtable_remove_fast_one(
 			}
 		}
 
-		rcu_assign_pointer(*pprev, obj);
-		break;
+		if (pprev) {
+			rcu_assign_pointer(*pprev, obj);
+			rht_unlock(bkt);
+		} else {
+			rht_assign_unlock(bkt, obj);
+		}
+		goto unlocked;
 	}
 
-out:
-	spin_unlock_bh(lock);
-
+	rht_unlock(bkt);
+unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
@@ -1029,9 +1092,9 @@ static inline int __rhashtable_replace_fast(
 	struct rhash_head *obj_old, struct rhash_head *obj_new,
 	const struct rhashtable_params params)
 {
+	struct rhash_lock_head __rcu **bkt;
 	struct rhash_head __rcu **pprev;
 	struct rhash_head *he;
-	spinlock_t *lock;
 	unsigned int hash;
 	int err = -ENOENT;
 
@@ -1042,27 +1105,33 @@ static inline int __rhashtable_replace_fast(
 	if (hash != rht_head_hashfn(ht, tbl, obj_new, params))
 		return -EINVAL;
 
-	lock = rht_bucket_lock(tbl, hash);
+	bkt = rht_bucket_var(tbl, hash);
+	if (!bkt)
+		return -ENOENT;
 
-	spin_lock_bh(lock);
+	pprev = NULL;
+	rht_lock(bkt);
 
-	pprev = rht_bucket_var(tbl, hash);
-	if (!pprev)
-		goto out;
-	rht_for_each_from(he, *pprev, tbl, hash) {
+	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
 			continue;
 		}
 
 		rcu_assign_pointer(obj_new->next, obj_old->next);
-		rcu_assign_pointer(*pprev, obj_new);
+		if (pprev) {
+			rcu_assign_pointer(*pprev, obj_new);
+			rht_unlock(bkt);
+		} else {
+			rht_assign_unlock(bkt, obj_new);
+		}
 		err = 0;
-		break;
+		goto unlocked;
 	}
-out:
-	spin_unlock_bh(lock);
 
+	rht_unlock(bkt);
+
+unlocked:
 	return err;
 }
 
diff --git a/ipc/util.c b/ipc/util.c
index 0af05752969f..095274a871f8 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -101,7 +101,6 @@ static const struct rhashtable_params ipc_kht_params = {
 	.head_offset		= offsetof(struct kern_ipc_perm, khtnode),
 	.key_offset		= offsetof(struct kern_ipc_perm, key),
 	.key_len		= FIELD_SIZEOF(struct kern_ipc_perm, key),
-	.locks_mul		= 1,
 	.automatic_shrinking	= true,
 };
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index b28fdd560ea9..c5d0974467ee 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -31,11 +31,10 @@
 
 #define HASH_DEFAULT_SIZE	64UL
 #define HASH_MIN_SIZE		4U
-#define BUCKET_LOCKS_PER_CPU	32UL
 
 union nested_table {
 	union nested_table __rcu *table;
-	struct rhash_head __rcu *bucket;
+	struct rhash_lock_head __rcu *bucket;
 };
 
 static u32 head_hashfn(struct rhashtable *ht,
@@ -56,9 +55,11 @@ EXPORT_SYMBOL_GPL(lockdep_rht_mutex_is_held);
 
 int lockdep_rht_bucket_is_held(const struct bucket_table *tbl, u32 hash)
 {
-	spinlock_t *lock = rht_bucket_lock(tbl, hash);
-
-	return (debug_locks) ? lockdep_is_held(lock) : 1;
+	if (!debug_locks)
+		return 1;
+	if (unlikely(tbl->nest))
+		return 1;
+	return bit_spin_is_locked(1, (unsigned long *)&tbl->buckets[hash]);
 }
 EXPORT_SYMBOL_GPL(lockdep_rht_bucket_is_held);
 #else
@@ -104,7 +105,6 @@ static void bucket_table_free(const struct bucket_table *tbl)
 	if (tbl->nest)
 		nested_bucket_table_free(tbl);
 
-	free_bucket_spinlocks(tbl->locks);
 	kvfree(tbl);
 }
 
@@ -171,7 +171,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 					       gfp_t gfp)
 {
 	struct bucket_table *tbl = NULL;
-	size_t size, max_locks;
+	size_t size;
 	int i;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
@@ -189,16 +189,6 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 
 	tbl->size = size;
 
-	max_locks = size >> 1;
-	if (tbl->nest)
-		max_locks = min_t(size_t, max_locks, 1U << tbl->nest);
-
-	if (alloc_bucket_spinlocks(&tbl->locks, &tbl->locks_mask, max_locks,
-				   ht->p.locks_mul, gfp) < 0) {
-		bucket_table_free(tbl);
-		return NULL;
-	}
-
 	rcu_head_init(&tbl->rcu);
 	INIT_LIST_HEAD(&tbl->walkers);
 
@@ -223,24 +213,23 @@ static struct bucket_table *rhashtable_last_table(struct rhashtable *ht,
 	return new_tbl;
 }
 
-static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
+static int rhashtable_rehash_one(struct rhashtable *ht,
+				 struct rhash_lock_head __rcu **bkt,
+				 unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	struct bucket_table *new_tbl = rhashtable_last_table(ht, old_tbl);
-	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
 	int err = -EAGAIN;
 	struct rhash_head *head, *next, *entry;
-	spinlock_t *new_bucket_lock;
+	struct rhash_head **pprev = NULL;
 	unsigned int new_hash;
 
 	if (new_tbl->nest)
 		goto out;
 
 	err = -ENOENT;
-	if (!pprev)
-		goto out;
 
-	rht_for_each_from(entry, *pprev, old_tbl, old_hash) {
+	rht_for_each_from(entry, rht_ptr(*bkt), old_tbl, old_hash) {
 		err = 0;
 		next = rht_dereference_bucket(entry->next, old_tbl, old_hash);
 
@@ -255,18 +244,20 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 
 	new_hash = head_hashfn(ht, new_tbl, entry);
 
-	new_bucket_lock = rht_bucket_lock(new_tbl, new_hash);
+	rht_lock(&new_tbl->buckets[new_hash]);
 
-	spin_lock_nested(new_bucket_lock, SINGLE_DEPTH_NESTING);
-	head = rht_dereference_bucket(new_tbl->buckets[new_hash],
-				      new_tbl, new_hash);
+	head = rht_ptr(rht_dereference_bucket(new_tbl->buckets[new_hash],
+					      new_tbl, new_hash));
 
 	RCU_INIT_POINTER(entry->next, head);
 
-	rcu_assign_pointer(new_tbl->buckets[new_hash], entry);
-	spin_unlock(new_bucket_lock);
+	rht_assign_unlock(&new_tbl->buckets[new_hash], entry);
 
-	rcu_assign_pointer(*pprev, next);
+	if (pprev)
+		rcu_assign_pointer(*pprev, next);
+	else
+		/* Need to preserved the bit lock. */
+		rcu_assign_pointer(*bkt, rht_ptr_locked(next));
 
 out:
 	return err;
@@ -276,19 +267,19 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 				    unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
-	spinlock_t *old_bucket_lock;
+	struct rhash_lock_head __rcu **bkt = rht_bucket_var(old_tbl, old_hash);
 	int err;
 
-	old_bucket_lock = rht_bucket_lock(old_tbl, old_hash);
+	if (!bkt)
+		return 0;
+	rht_lock(bkt);
 
-	spin_lock_bh(old_bucket_lock);
-	while (!(err = rhashtable_rehash_one(ht, old_hash)))
+	while (!(err = rhashtable_rehash_one(ht, bkt, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-
-	spin_unlock_bh(old_bucket_lock);
+	rht_unlock(bkt);
 
 	return err;
 }
@@ -485,6 +476,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 }
 
 static void *rhashtable_lookup_one(struct rhashtable *ht,
+				   struct rhash_lock_head __rcu **bkt,
 				   struct bucket_table *tbl, unsigned int hash,
 				   const void *key, struct rhash_head *obj)
 {
@@ -492,15 +484,12 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		.ht = ht,
 		.key = key,
 	};
-	struct rhash_head __rcu **pprev;
+	struct rhash_head **pprev = NULL;
 	struct rhash_head *head;
 	int elasticity;
 
 	elasticity = RHT_ELASTICITY;
-	pprev = rht_bucket_var(tbl, hash);
-	if (!pprev)
-		return ERR_PTR(-ENOENT);
-	rht_for_each_from(head, *pprev, tbl, hash) {
+	rht_for_each_from(head, rht_ptr(*bkt), tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
 
@@ -522,7 +511,11 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		RCU_INIT_POINTER(list->next, plist);
 		head = rht_dereference_bucket(head->next, tbl, hash);
 		RCU_INIT_POINTER(list->rhead.next, head);
-		rcu_assign_pointer(*pprev, obj);
+		if (pprev)
+			rcu_assign_pointer(*pprev, obj);
+		else
+			/* Need to preserve the bit lock */
+			rcu_assign_pointer(*bkt, rht_ptr_locked(obj));
 
 		return NULL;
 	}
@@ -534,12 +527,12 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 }
 
 static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
+						  struct rhash_lock_head __rcu **bkt,
 						  struct bucket_table *tbl,
 						  unsigned int hash,
 						  struct rhash_head *obj,
 						  void *data)
 {
-	struct rhash_head __rcu **pprev;
 	struct bucket_table *new_tbl;
 	struct rhash_head *head;
 
@@ -562,11 +555,7 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		return ERR_PTR(-EAGAIN);
 
-	pprev = rht_bucket_insert(ht, tbl, hash);
-	if (!pprev)
-		return ERR_PTR(-ENOMEM);
-
-	head = rht_dereference_bucket(*pprev, tbl, hash);
+	head = rht_ptr(rht_dereference_bucket(*bkt, tbl, hash));
 
 	RCU_INIT_POINTER(obj->next, head);
 	if (ht->rhlist) {
@@ -576,7 +565,10 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 		RCU_INIT_POINTER(list->next, NULL);
 	}
 
-	rcu_assign_pointer(*pprev, obj);
+	/* bkt is always the head of the list, so it holds
+	 * the lock, which we need to preserve
+	 */
+	rcu_assign_pointer(*bkt, rht_ptr_locked(obj));
 
 	atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))
@@ -590,6 +582,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 {
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
+	struct rhash_lock_head __rcu **bkt;
 	unsigned int hash;
 	void *data;
 
@@ -598,14 +591,25 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 	do {
 		tbl = new_tbl;
 		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
-		spin_lock_bh(rht_bucket_lock(tbl, hash));
-
-		data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
-		new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
-		if (PTR_ERR(new_tbl) != -EEXIST)
-			data = ERR_CAST(new_tbl);
-
-		spin_unlock_bh(rht_bucket_lock(tbl, hash));
+		if (rcu_access_pointer(tbl->future_tbl))
+			/* Failure is OK */
+			bkt = rht_bucket_var(tbl, hash);
+		else
+			bkt = rht_bucket_insert(ht, tbl, hash);
+		if (bkt == NULL) {
+			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
+			data = ERR_PTR(-EAGAIN);
+		} else {
+			rht_lock(bkt);
+			data = rhashtable_lookup_one(ht, bkt, tbl,
+						     hash, key, obj);
+			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
+							hash, obj, data);
+			if (PTR_ERR(new_tbl) != -EEXIST)
+				data = ERR_CAST(new_tbl);
+
+			rht_unlock(bkt);
+		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 
 	if (PTR_ERR(data) == -EAGAIN)
@@ -1032,11 +1036,6 @@ int rhashtable_init(struct rhashtable *ht,
 
 	size = rounded_hashtable_size(&ht->p);
 
-	if (params->locks_mul)
-		ht->p.locks_mul = roundup_pow_of_two(params->locks_mul);
-	else
-		ht->p.locks_mul = BUCKET_LOCKS_PER_CPU;
-
 	ht->key_len = ht->p.key_len;
 	if (!params->hashfn) {
 		ht->p.hashfn = jhash;
@@ -1138,7 +1137,7 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
 			struct rhash_head *pos, *next;
 
 			cond_resched();
-			for (pos = rht_dereference(*rht_bucket(tbl, i), ht),
+			for (pos = rht_ptr(rht_dereference(*rht_bucket(tbl, i), ht)),
 			     next = !rht_is_a_nulls(pos) ?
 					rht_dereference(pos->next, ht) : NULL;
 			     !rht_is_a_nulls(pos);
@@ -1165,8 +1164,8 @@ void rhashtable_destroy(struct rhashtable *ht)
 }
 EXPORT_SYMBOL_GPL(rhashtable_destroy);
 
-struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
-					      unsigned int hash)
+struct rhash_lock_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
+						   unsigned int hash)
 {
 	const unsigned int shift = PAGE_SHIFT - ilog2(sizeof(void *));
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
@@ -1194,10 +1193,10 @@ struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
 }
 EXPORT_SYMBOL_GPL(__rht_bucket_nested);
 
-struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
-					    unsigned int hash)
+struct rhash_lock_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
+						 unsigned int hash)
 {
-	static struct rhash_head __rcu *rhnull;
+	static struct rhash_lock_head __rcu *rhnull;
 
 	if (!rhnull)
 		INIT_RHT_NULLS_HEAD(rhnull);
@@ -1205,9 +1204,9 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 }
 EXPORT_SYMBOL_GPL(rht_bucket_nested);
 
-struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
-						   struct bucket_table *tbl,
-						   unsigned int hash)
+struct rhash_lock_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
+							struct bucket_table *tbl,
+							unsigned int hash)
 {
 	const unsigned int shift = PAGE_SHIFT - ilog2(sizeof(void *));
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 3bd2e91bfc29..02592c2a249c 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -500,7 +500,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 		struct rhash_head *pos, *next;
 		struct test_obj_rhl *p;
 
-		pos = rht_dereference(tbl->buckets[i], ht);
+		pos = rht_ptr(rht_dereference(tbl->buckets[i], ht));
 		next = !rht_is_a_nulls(pos) ? rht_dereference(pos->next, ht) : NULL;
 
 		if (!rht_is_a_nulls(pos)) {
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 00573cc46c98..b1c91f66d79c 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -33,7 +33,6 @@ static const struct rhashtable_params br_fdb_rht_params = {
 	.key_offset = offsetof(struct net_bridge_fdb_entry, key),
 	.key_len = sizeof(struct net_bridge_fdb_key),
 	.automatic_shrinking = true,
-	.locks_mul = 1,
 };
 
 static struct kmem_cache *br_fdb_cache __read_mostly;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f5343dfac282..4b77e17df73b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -44,7 +44,6 @@ static const struct rhashtable_params br_mdb_rht_params = {
 	.key_offset = offsetof(struct net_bridge_mdb_entry, addr),
 	.key_len = sizeof(struct br_ip),
 	.automatic_shrinking = true,
-	.locks_mul = 1,
 };
 
 static void br_multicast_start_querier(struct net_bridge *br,
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 96abf8feb9dc..0a02822b5667 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -21,7 +21,6 @@ static const struct rhashtable_params br_vlan_rht_params = {
 	.key_offset = offsetof(struct net_bridge_vlan, vid),
 	.key_len = sizeof(u16),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.max_size = VLAN_N_VID,
 	.obj_cmpfn = br_vlan_cmp,
 	.automatic_shrinking = true,
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 6d2c4eed2dc8..758151863669 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -34,7 +34,6 @@ static const struct rhashtable_params br_vlan_tunnel_rht_params = {
 	.key_offset = offsetof(struct net_bridge_vlan, tinfo.tunnel_id),
 	.key_len = sizeof(__be64),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.obj_cmpfn = br_vlan_tunid_cmp,
 	.automatic_shrinking = true,
 };
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 2c931120c494..9a3f13edc98e 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -373,7 +373,6 @@ static const struct rhashtable_params ipmr_rht_params = {
 	.key_offset = offsetof(struct mfc_cache, cmparg),
 	.key_len = sizeof(struct mfc_cache_cmp_arg),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.obj_cmpfn = ipmr_hash_cmp,
 	.automatic_shrinking = true,
 };
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e4dd57976737..4e69847ed5be 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -355,7 +355,6 @@ static const struct rhashtable_params ip6mr_rht_params = {
 	.key_offset = offsetof(struct mfc6_cache, cmparg),
 	.key_len = sizeof(struct mfc6_cache_cmp_arg),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.obj_cmpfn = ip6mr_hash_cmp,
 	.automatic_shrinking = true,
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ef7772e976cc..90e6b09ef2af 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -53,7 +53,6 @@ static const struct rhashtable_params nft_chain_ht_params = {
 	.hashfn			= nft_chain_hash,
 	.obj_hashfn		= nft_chain_hash_obj,
 	.obj_cmpfn		= nft_chain_hash_cmp,
-	.locks_mul		= 1,
 	.automatic_shrinking	= true,
 };
 



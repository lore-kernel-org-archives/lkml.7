Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B14C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D399A20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfCYFG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:06:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:42602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCYFG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:06:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37E24AC85;
        Mon, 25 Mar 2019 05:06:24 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 25 Mar 2019 16:05:39 +1100
Subject: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155349033961.1111.18247269615646768227.stgit@noble.brown>
In-Reply-To: <155349021177.1111.15681654355431465791.stgit@noble.brown>
References: <155349021177.1111.15681654355431465791.stgit@noble.brown>
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

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable-types.h |    2 
 include/linux/rhashtable.h       |  191 ++++++++++++++++++++++++--------------
 ipc/util.c                       |    1 
 lib/rhashtable.c                 |  113 +++++++++++-----------
 net/bridge/br_fdb.c              |    1 
 net/bridge/br_multicast.c        |    1 
 net/bridge/br_vlan.c             |    1 
 net/bridge/br_vlan_tunnel.c      |    1 
 net/ipv4/ipmr.c                  |    1 
 net/ipv6/ip6mr.c                 |    1 
 net/netfilter/nf_tables_api.c    |    1 
 11 files changed, 179 insertions(+), 135 deletions(-)

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
index 0c9175aeab8a..14bac26cc92c 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -24,6 +24,7 @@
 #include <linux/list_nulls.h>
 #include <linux/workqueue.h>
 #include <linux/rculist.h>
+#include <linux/bit_spinlock.h>
 
 #include <linux/rhashtable-types.h>
 /*
@@ -52,8 +53,6 @@
  * @nest: Number of bits of first-level nested table.
  * @rehash: Current bucket being rehashed
  * @hash_rnd: Random seed to fold into hash
- * @locks_mask: Mask to apply before accessing locks[]
- * @locks: Array of spinlocks protecting individual buckets
  * @walkers: List of active walkers
  * @rcu: RCU structure for freeing the table
  * @future_tbl: Table under construction during rehashing
@@ -64,8 +63,6 @@ struct bucket_table {
 	unsigned int		size;
 	unsigned int		nest;
 	u32			hash_rnd;
-	unsigned int		locks_mask;
-	spinlock_t		*locks;
 	struct list_head	walkers;
 	struct rcu_head		rcu;
 
@@ -74,6 +71,63 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
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
+ * local_bh. For that we have rht_unlocked().  This doesn't include
+ * the memory barrier that bit_spin_unlock() provides, but rcu_assign_pointer()
+ * will have provided that.
+ */
+
+static inline void rht_lock(struct rhash_head **bucket)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bucket);
+}
+
+static inline void rht_unlock(struct rhash_head **bucket)
+{
+	bit_spin_unlock(1, (unsigned long *)bucket);
+	local_bh_enable();
+}
+
+static inline void rht_unlocked(void)
+{
+	preempt_enable();
+	__release(bitlock);
+	local_bh_enable();
+}
+
+/*
+ * If 'p' is a bucket head and might be locked:
+ *   rht_ptr() returns the address without the lock bit.
+ *   rht_ptr_locked() returns the address WITH the lock bit.
+ *   rht_is_locked() tests if the lock bit is set.
+ */
+static inline struct rhash_head __rcu *rht_ptr(const struct rhash_head *p)
+{
+	return (void *)(((unsigned long)p) & ~2UL);
+}
+
+static inline struct rhash_head __rcu *rht_ptr_locked(const struct rhash_head *p)
+{
+	return (void *)(((unsigned long)p) | 2UL);
+}
+
+static inline bool rht_is_locked(const struct rhash_head *p)
+{
+	return rht_ptr_locked(p) == p;
+}
+
 /*
  * NULLS_MARKER() expects a hash value with the low
  * bits mostly likely to be significant, and it discards
@@ -206,25 +260,6 @@ static inline bool rht_grow_above_max(const struct rhashtable *ht,
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
@@ -326,7 +361,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each(pos, tbl, hash) \
-	rht_for_each_from(pos, *rht_bucket(tbl, hash), tbl, hash)
+	rht_for_each_from(pos, rht_ptr(*rht_bucket(tbl, hash)), tbl, hash)
 
 /**
  * rht_for_each_entry_from - iterate over hash chain from given head
@@ -351,7 +386,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry(tpos, pos, tbl, hash, member)		\
-	rht_for_each_entry_from(tpos, pos, *rht_bucket(tbl, hash),	\
+	rht_for_each_entry_from(tpos, pos, rht_ptr(*rht_bucket(tbl, hash)), \
 				    tbl, hash, member)
 
 /**
@@ -367,7 +402,8 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * remove the loop cursor from the list.
  */
 #define rht_for_each_entry_safe(tpos, pos, next, tbl, hash, member)	      \
-	for (pos = rht_dereference_bucket(*rht_bucket(tbl, hash), tbl, hash), \
+	for (pos = rht_dereference_bucket(rht_ptr(*rht_bucket(tbl, hash)),    \
+					  tbl, hash),			      \
 	     next = !rht_is_a_nulls(pos) ?				      \
 		       rht_dereference_bucket(pos->next, tbl, hash) : NULL;   \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	      \
@@ -388,7 +424,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  */
 #define rht_for_each_rcu_from(pos, head, tbl, hash)			\
 	for (({barrier(); }),						\
-	     pos = rht_dereference_bucket_rcu(head, tbl, hash);		\
+		pos = rht_ptr(rht_dereference_bucket_rcu(head, tbl, hash)); \
 	     !rht_is_a_nulls(pos);					\
 	     pos = rcu_dereference_raw(pos->next))
 
@@ -437,7 +473,8 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		   \
-	rht_for_each_entry_rcu_from(tpos, pos, *rht_bucket(tbl, hash), \
+	rht_for_each_entry_rcu_from(tpos, pos,			   \
+					rht_ptr(*rht_bucket(tbl, hash)),   \
 					tbl, hash, member)
 
 /**
@@ -600,9 +637,9 @@ static inline void *__rhashtable_insert_fast(
 		.key = key,
 	};
 	struct rhash_head __rcu **pprev;
+	struct rhash_head __rcu **lock;
 	struct bucket_table *tbl;
 	struct rhash_head *head;
-	spinlock_t *lock;
 	unsigned int hash;
 	int elasticity;
 	void *data;
@@ -611,23 +648,22 @@ static inline void *__rhashtable_insert_fast(
 
 	tbl = rht_dereference_rcu(ht->tbl, ht);
 	hash = rht_head_hashfn(ht, tbl, obj, params);
-	lock = rht_bucket_lock(tbl, hash);
-	spin_lock_bh(lock);
+	elasticity = RHT_ELASTICITY;
+	pprev = rht_bucket_insert(ht, tbl, hash);
+	data = ERR_PTR(-ENOMEM);
+	if (!pprev)
+		goto out;
+	lock = pprev;
+	rht_lock(lock);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		spin_unlock_bh(lock);
+		rht_unlock(lock);
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
+	rht_for_each_from(head, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
 
@@ -643,7 +679,7 @@ static inline void *__rhashtable_insert_fast(
 		data = rht_obj(ht, head);
 
 		if (!rhlist)
-			goto out;
+			goto out_unlock;
 
 
 		list = container_of(obj, struct rhlist_head, rhead);
@@ -662,14 +698,16 @@ static inline void *__rhashtable_insert_fast(
 
 	data = ERR_PTR(-E2BIG);
 	if (unlikely(rht_grow_above_max(ht, tbl)))
-		goto out;
+		goto out_unlock;
 
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		goto slow_path;
 
+	/* Inserting at head of list make unlocking free. */
+	pprev = lock;
 	head = rht_dereference_bucket(*pprev, tbl, hash);
 
-	RCU_INIT_POINTER(obj->next, head);
+	RCU_INIT_POINTER(obj->next, rht_ptr(head));
 	if (rhlist) {
 		struct rhlist_head *list;
 
@@ -686,8 +724,16 @@ static inline void *__rhashtable_insert_fast(
 good:
 	data = NULL;
 
+	if (pprev == lock) {
+		/* Assigning to *headp unlocked the chain, so we
+		 * mustn't do it again.
+		 */
+		rht_unlocked();
+	} else {
+out_unlock:
+		rht_unlock(lock);
+	}
 out:
-	spin_unlock_bh(lock);
 	rcu_read_unlock();
 
 	return data;
@@ -699,9 +745,9 @@ static inline void *__rhashtable_insert_fast(
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
@@ -728,9 +774,9 @@ static inline int rhashtable_insert_fast(
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
@@ -751,9 +797,9 @@ static inline int rhltable_insert_key(
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
@@ -881,20 +927,19 @@ static inline int __rhashtable_remove_fast_one(
 	bool rhlist)
 {
 	struct rhash_head __rcu **pprev;
+	struct rhash_head __rcu **lock;
 	struct rhash_head *he;
-	spinlock_t * lock;
 	unsigned int hash;
 	int err = -ENOENT;
 
 	hash = rht_head_hashfn(ht, tbl, obj, params);
-	lock = rht_bucket_lock(tbl, hash);
-
-	spin_lock_bh(lock);
-
 	pprev = rht_bucket_var(tbl, hash);
 	if (!pprev)
-		goto out;
-	rht_for_each_from(he, *pprev, tbl, hash) {
+		return -ENOENT;
+	lock = pprev;
+	rht_lock(lock);
+
+	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
 
 		list = container_of(he, struct rhlist_head, rhead);
@@ -935,12 +980,16 @@ static inline int __rhashtable_remove_fast_one(
 		}
 
 		rcu_assign_pointer(*pprev, obj);
+		if (lock == pprev) {
+			/* That rcu_assign_pointer() unlocked the chain */
+			rht_unlocked();
+			goto unlocked;
+		}
 		break;
 	}
 
-out:
-	spin_unlock_bh(lock);
-
+	rht_unlock(lock);
+unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
@@ -1030,8 +1079,8 @@ static inline int __rhashtable_replace_fast(
 	const struct rhashtable_params params)
 {
 	struct rhash_head __rcu **pprev;
+	struct rhash_head __rcu **lock;
 	struct rhash_head *he;
-	spinlock_t *lock;
 	unsigned int hash;
 	int err = -ENOENT;
 
@@ -1042,14 +1091,14 @@ static inline int __rhashtable_replace_fast(
 	if (hash != rht_head_hashfn(ht, tbl, obj_new, params))
 		return -EINVAL;
 
-	lock = rht_bucket_lock(tbl, hash);
-
-	spin_lock_bh(lock);
-
 	pprev = rht_bucket_var(tbl, hash);
 	if (!pprev)
-		goto out;
-	rht_for_each_from(he, *pprev, tbl, hash) {
+		return -ENOENT;
+
+	lock = pprev;
+	rht_lock(lock);
+
+	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
 			continue;
@@ -1058,11 +1107,17 @@ static inline int __rhashtable_replace_fast(
 		rcu_assign_pointer(obj_new->next, obj_old->next);
 		rcu_assign_pointer(*pprev, obj_new);
 		err = 0;
+		if (pprev == lock) {
+			/* We just unlocked the chain by assigning to *pprev */
+			rht_unlocked();
+			goto unlocked;
+		}
 		break;
 	}
-out:
-	spin_unlock_bh(lock);
 
+	rht_unlock(lock);
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
index e3b726bf2dd3..beb942aa1e50 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -31,7 +31,6 @@
 
 #define HASH_DEFAULT_SIZE	64UL
 #define HASH_MIN_SIZE		4U
-#define BUCKET_LOCKS_PER_CPU	32UL
 
 union nested_table {
 	union nested_table __rcu *table;
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
 
@@ -223,24 +213,22 @@ static struct bucket_table *rhashtable_last_table(struct rhashtable *ht,
 	return new_tbl;
 }
 
-static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
+static int rhashtable_rehash_one(struct rhashtable *ht,
+				 struct rhash_head __rcu **pprev,
+				 unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	struct bucket_table *new_tbl = rhashtable_last_table(ht, old_tbl);
-	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
 	int err = -EAGAIN;
 	struct rhash_head *head, *next, *entry;
-	spinlock_t *new_bucket_lock;
 	unsigned int new_hash;
 
 	if (new_tbl->nest)
 		goto out;
 
 	err = -ENOENT;
-	if (!pprev)
-		goto out;
 
-	rht_for_each_from(entry, *pprev, old_tbl, old_hash) {
+	rht_for_each_from(entry, rht_ptr(*pprev), old_tbl, old_hash) {
 		err = 0;
 		next = rht_dereference_bucket(entry->next, old_tbl, old_hash);
 
@@ -255,16 +243,19 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 
 	new_hash = head_hashfn(ht, new_tbl, entry);
 
-	new_bucket_lock = rht_bucket_lock(new_tbl, new_hash);
+	rht_lock(&new_tbl->buckets[new_hash]);
 
-	spin_lock_nested(new_bucket_lock, SINGLE_DEPTH_NESTING);
-	head = rht_dereference_bucket(new_tbl->buckets[new_hash],
-				      new_tbl, new_hash);
+	head = rht_ptr(rht_dereference_bucket(new_tbl->buckets[new_hash],
+					      new_tbl, new_hash));
 
 	RCU_INIT_POINTER(entry->next, head);
 
 	rcu_assign_pointer(new_tbl->buckets[new_hash], entry);
-	spin_unlock(new_bucket_lock);
+	rht_unlocked();
+
+	/* Need to preserved the bit lock. */
+	if (rht_is_locked(*pprev))
+		next = rht_ptr_locked(next);
 
 	rcu_assign_pointer(*pprev, next);
 
@@ -276,19 +267,19 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 				    unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
-	spinlock_t *old_bucket_lock;
+	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
 	int err;
 
-	old_bucket_lock = rht_bucket_lock(old_tbl, old_hash);
+	if (!pprev)
+		return 0;
+	rht_lock(pprev);
 
-	spin_lock_bh(old_bucket_lock);
-	while (!(err = rhashtable_rehash_one(ht, old_hash)))
+	while (!(err = rhashtable_rehash_one(ht, pprev, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-
-	spin_unlock_bh(old_bucket_lock);
+	rht_unlock(pprev);
 
 	return err;
 }
@@ -481,6 +472,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 }
 
 static void *rhashtable_lookup_one(struct rhashtable *ht,
+				   struct rhash_head __rcu **pprev,
 				   struct bucket_table *tbl, unsigned int hash,
 				   const void *key, struct rhash_head *obj)
 {
@@ -488,15 +480,12 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		.ht = ht,
 		.key = key,
 	};
-	struct rhash_head __rcu **pprev;
+	struct rhash_head **lock = pprev;
 	struct rhash_head *head;
 	int elasticity;
 
 	elasticity = RHT_ELASTICITY;
-	pprev = rht_bucket_var(tbl, hash);
-	if (!pprev)
-		return ERR_PTR(-ENOENT);
-	rht_for_each_from(head, *pprev, tbl, hash) {
+	rht_for_each_from(head, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
 
@@ -518,6 +507,9 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		RCU_INIT_POINTER(list->next, plist);
 		head = rht_dereference_bucket(head->next, tbl, hash);
 		RCU_INIT_POINTER(list->rhead.next, head);
+		if (pprev == lock)
+			/* Need to preserve the bit lock */
+			obj = rht_ptr_locked(obj);
 		rcu_assign_pointer(*pprev, obj);
 
 		return NULL;
@@ -530,12 +522,12 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 }
 
 static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
+						  struct rhash_head __rcu **pprev,
 						  struct bucket_table *tbl,
 						  unsigned int hash,
 						  struct rhash_head *obj,
 						  void *data)
 {
-	struct rhash_head __rcu **pprev;
 	struct bucket_table *new_tbl;
 	struct rhash_head *head;
 
@@ -558,11 +550,7 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		return ERR_PTR(-EAGAIN);
 
-	pprev = rht_bucket_insert(ht, tbl, hash);
-	if (!pprev)
-		return ERR_PTR(-ENOMEM);
-
-	head = rht_dereference_bucket(*pprev, tbl, hash);
+	head = rht_ptr(rht_dereference_bucket(*pprev, tbl, hash));
 
 	RCU_INIT_POINTER(obj->next, head);
 	if (ht->rhlist) {
@@ -572,6 +560,10 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 		RCU_INIT_POINTER(list->next, NULL);
 	}
 
+	/* pprev is always the head of the list, so it holds
+	 * the lock, which we need to preserve
+	 */
+	obj = rht_ptr_locked(obj);
 	rcu_assign_pointer(*pprev, obj);
 
 	atomic_inc(&ht->nelems);
@@ -586,6 +578,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 {
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
+	struct rhash_head __rcu **pprev;
 	unsigned int hash;
 	void *data;
 
@@ -594,14 +587,25 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
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
+			pprev = rht_bucket_var(tbl, hash);
+		else
+			pprev = rht_bucket_insert(ht, tbl, hash);
+		if (pprev == NULL) {
+			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
+			data = ERR_PTR(-EAGAIN);
+		} else {
+			rht_lock(pprev);
+			data = rhashtable_lookup_one(ht, pprev, tbl,
+						     hash, key, obj);
+			new_tbl = rhashtable_insert_one(ht, pprev, tbl,
+							hash, obj, data);
+			if (PTR_ERR(new_tbl) != -EEXIST)
+				data = ERR_CAST(new_tbl);
+
+			rht_unlock(pprev);
+		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 
 	if (PTR_ERR(data) == -EAGAIN)
@@ -1028,11 +1032,6 @@ int rhashtable_init(struct rhashtable *ht,
 
 	size = rounded_hashtable_size(&ht->p);
 
-	if (params->locks_mul)
-		ht->p.locks_mul = roundup_pow_of_two(params->locks_mul);
-	else
-		ht->p.locks_mul = BUCKET_LOCKS_PER_CPU;
-
 	ht->key_len = ht->p.key_len;
 	if (!params->hashfn) {
 		ht->p.hashfn = jhash;
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
index b257342c0860..2e162943a141 100644
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
index 513f93118604..40253eb38176 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -53,7 +53,6 @@ static const struct rhashtable_params nft_chain_ht_params = {
 	.hashfn			= nft_chain_hash,
 	.obj_hashfn		= nft_chain_hash_obj,
 	.obj_cmpfn		= nft_chain_hash_cmp,
-	.locks_mul		= 1,
 	.automatic_shrinking	= true,
 };
 



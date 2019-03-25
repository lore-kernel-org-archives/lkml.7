Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2B32087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfCYFGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:06:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCYFGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:06:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5382AC85;
        Mon, 25 Mar 2019 05:06:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 25 Mar 2019 16:05:39 +1100
Subject: [PATCH 4/4] rhashtable: add lockdep tracking to bucket
 bit-spin-locks.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155349033965.1111.7839703310849724597.stgit@noble.brown>
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
 include/linux/rhashtable.h |   40 +++++++++++++++++++++++++++-------------
 lib/rhashtable.c           |   15 +++++++++------
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 14bac26cc92c..e954d2ff5463 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -68,6 +68,8 @@ struct bucket_table {
 
 	struct bucket_table __rcu *future_tbl;
 
+	struct lockdep_map	dep_map;
+
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
@@ -88,20 +90,32 @@ struct bucket_table {
  * will have provided that.
  */
 
-static inline void rht_lock(struct rhash_head **bucket)
+static inline void rht_lock(struct bucket_table *tbl, struct rhash_head **bucket)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_map_acquire(&tbl->dep_map);
+}
+
+static inline void rht_lock_nested(struct bucket_table *tbl,
+				   struct rhash_head **bucket,
+				   unsigned int subclass)
 {
 	local_bh_disable();
 	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
 }
 
-static inline void rht_unlock(struct rhash_head **bucket)
+static inline void rht_unlock(struct bucket_table *tbl, struct rhash_head **bucket)
 {
+	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(1, (unsigned long *)bucket);
 	local_bh_enable();
 }
 
-static inline void rht_unlocked(void)
+static inline void rht_unlocked(struct bucket_table *tbl)
 {
+	lock_map_release(&tbl->dep_map);
 	preempt_enable();
 	__release(bitlock);
 	local_bh_enable();
@@ -654,11 +668,11 @@ static inline void *__rhashtable_insert_fast(
 	if (!pprev)
 		goto out;
 	lock = pprev;
-	rht_lock(lock);
+	rht_lock(tbl, lock);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		rht_unlock(lock);
+		rht_unlock(tbl, lock);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
@@ -728,10 +742,10 @@ static inline void *__rhashtable_insert_fast(
 		/* Assigning to *headp unlocked the chain, so we
 		 * mustn't do it again.
 		 */
-		rht_unlocked();
+		rht_unlocked(tbl);
 	} else {
 out_unlock:
-		rht_unlock(lock);
+		rht_unlock(tbl, lock);
 	}
 out:
 	rcu_read_unlock();
@@ -937,7 +951,7 @@ static inline int __rhashtable_remove_fast_one(
 	if (!pprev)
 		return -ENOENT;
 	lock = pprev;
-	rht_lock(lock);
+	rht_lock(tbl, lock);
 
 	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
@@ -982,13 +996,13 @@ static inline int __rhashtable_remove_fast_one(
 		rcu_assign_pointer(*pprev, obj);
 		if (lock == pprev) {
 			/* That rcu_assign_pointer() unlocked the chain */
-			rht_unlocked();
+			rht_unlocked(tbl);
 			goto unlocked;
 		}
 		break;
 	}
 
-	rht_unlock(lock);
+	rht_unlock(tbl, lock);
 unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
@@ -1096,7 +1110,7 @@ static inline int __rhashtable_replace_fast(
 		return -ENOENT;
 
 	lock = pprev;
-	rht_lock(lock);
+	rht_lock(tbl, lock);
 
 	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		if (he != obj_old) {
@@ -1109,13 +1123,13 @@ static inline int __rhashtable_replace_fast(
 		err = 0;
 		if (pprev == lock) {
 			/* We just unlocked the chain by assigning to *pprev */
-			rht_unlocked();
+			rht_unlocked(tbl);
 			goto unlocked;
 		}
 		break;
 	}
 
-	rht_unlock(lock);
+	rht_unlock(tbl, lock);
 
 unlocked:
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index beb942aa1e50..db66562fc17c 100644
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
@@ -243,7 +246,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	new_hash = head_hashfn(ht, new_tbl, entry);
 
-	rht_lock(&new_tbl->buckets[new_hash]);
+	rht_lock_nested(new_tbl, &new_tbl->buckets[new_hash], SINGLE_DEPTH_NESTING);
 
 	head = rht_ptr(rht_dereference_bucket(new_tbl->buckets[new_hash],
 					      new_tbl, new_hash));
@@ -251,7 +254,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 	RCU_INIT_POINTER(entry->next, head);
 
 	rcu_assign_pointer(new_tbl->buckets[new_hash], entry);
-	rht_unlocked();
+	rht_unlocked(new_tbl);
 
 	/* Need to preserved the bit lock. */
 	if (rht_is_locked(*pprev))
@@ -272,14 +275,14 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 
 	if (!pprev)
 		return 0;
-	rht_lock(pprev);
+	rht_lock(old_tbl, pprev);
 
 	while (!(err = rhashtable_rehash_one(ht, pprev, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-	rht_unlock(pprev);
+	rht_unlock(old_tbl, pprev);
 
 	return err;
 }
@@ -596,7 +599,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
-			rht_lock(pprev);
+			rht_lock(tbl, pprev);
 			data = rhashtable_lookup_one(ht, pprev, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, pprev, tbl,
@@ -604,7 +607,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
-			rht_unlock(pprev);
+			rht_unlock(tbl, pprev);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 



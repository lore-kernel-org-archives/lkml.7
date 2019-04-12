Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D736C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BCF20674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDLBwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:52:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfDLBwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:52:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2A2FAD04;
        Fri, 12 Apr 2019 01:52:45 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 12 Apr 2019 11:52:08 +1000
Subject: [PATCH 3/5] rhashtable: move dereference inside rht_ptr()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-ID: <155503392800.17793.5151899239660458641.stgit@noble.brown>
In-Reply-To: <155503371949.17793.8266195008003399968.stgit@noble.brown>
References: <155503371949.17793.8266195008003399968.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than dereferencing a pointer to a bucket and then passing the
result to rht_ptr(), we now pass in the pointer and do the dereference
in rht_ptr().

This requires that we pass in the tbl and hash as well to support RCU
checks, and means that the various rht_for_each functions can expect a
pointer that can be dereferenced without further care.

There are two places where we dereference a bucket pointer
where there is no testable protection - in each case we know
that we much have exclusive access without having taken a lock.
The previous code used rht_dereference() to pretend that holding
the mutex provided protects, but holding the mutex never provides
protection for accessing buckets.

So instead introduce rht_ptr_exclusive() that can be used when
there is known to be exclusive access without holding any locks.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   69 +++++++++++++++++++++++++++-----------------
 lib/rhashtable.c           |   12 ++++----
 lib/test_rhashtable.c      |    2 +
 3 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index c504cd820736..b54e6436547e 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -344,12 +344,28 @@ static inline void rht_unlock(struct bucket_table *tbl,
 }
 
 /*
- * If 'p' is a bucket head and might be locked:
- *   rht_ptr() returns the address without the lock bit.
- *   rht_ptr_locked() returns the address WITH the lock bit.
+ * Where 'bkt' is a bucket and might be locked:
+ *   rht_ptr() dereferences that pointer and clears the lock bit.
+ *   rht_ptr_exclusive() dereferences in a context where exclusive
+ *            access is guaranteed, such as when destroying the table.
  */
-static inline struct rhash_head __rcu *rht_ptr(const struct rhash_lock_head *p)
+static inline struct rhash_head *rht_ptr(
+	struct rhash_lock_head __rcu * const *bkt,
+	struct bucket_table *tbl,
+	unsigned int hash)
 {
+	const struct rhash_lock_head *p =
+		rht_dereference_bucket_rcu(*bkt, tbl, hash);
+
+	return (void *)(((unsigned long)p) & ~BIT(1));
+}
+
+static inline struct rhash_head *rht_ptr_exclusive(
+	struct rhash_lock_head __rcu * const *bkt)
+{
+	const struct rhash_lock_head *p =
+		rcu_dereference_protected(*bkt, 1);
+
 	return (void *)(((unsigned long)p) & ~BIT(1));
 }
 
@@ -380,8 +396,8 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each_from(pos, head, tbl, hash) \
-	for (pos = rht_dereference_bucket(head, tbl, hash); \
-	     !rht_is_a_nulls(pos); \
+	for (pos = head;			\
+	     !rht_is_a_nulls(pos);		\
 	     pos = rht_dereference_bucket((pos)->next, tbl, hash))
 
 /**
@@ -391,7 +407,8 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each(pos, tbl, hash) \
-	rht_for_each_from(pos, rht_ptr(*rht_bucket(tbl, hash)), tbl, hash)
+	rht_for_each_from(pos, rht_ptr(rht_bucket(tbl, hash), tbl, hash),  \
+			  tbl, hash)
 
 /**
  * rht_for_each_entry_from - iterate over hash chain from given head
@@ -403,7 +420,7 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry_from(tpos, pos, head, tbl, hash, member)	\
-	for (pos = rht_dereference_bucket(head, tbl, hash);		\
+	for (pos = head;						\
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	\
 	     pos = rht_dereference_bucket((pos)->next, tbl, hash))
 
@@ -416,8 +433,9 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry(tpos, pos, tbl, hash, member)		\
-	rht_for_each_entry_from(tpos, pos, rht_ptr(*rht_bucket(tbl, hash)), \
-				    tbl, hash, member)
+	rht_for_each_entry_from(tpos, pos,				\
+				rht_ptr(rht_bucket(tbl, hash), tbl, hash), \
+				tbl, hash, member)
 
 /**
  * rht_for_each_entry_safe - safely iterate over hash chain of given type
@@ -432,8 +450,7 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  * remove the loop cursor from the list.
  */
 #define rht_for_each_entry_safe(tpos, pos, next, tbl, hash, member)	      \
-	for (pos = rht_dereference_bucket(rht_ptr(*rht_bucket(tbl, hash)),    \
-					  tbl, hash),			      \
+	for (pos = rht_ptr(rht_bucket(tbl, hash), tbl, hash),		      \
 	     next = !rht_is_a_nulls(pos) ?				      \
 		       rht_dereference_bucket(pos->next, tbl, hash) : NULL;   \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	      \
@@ -454,7 +471,7 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  */
 #define rht_for_each_rcu_from(pos, head, tbl, hash)			\
 	for (({barrier(); }),						\
-	     pos = rht_dereference_bucket_rcu(head, tbl, hash);		\
+	     pos = head;						\
 	     !rht_is_a_nulls(pos);					\
 	     pos = rcu_dereference_raw(pos->next))
 
@@ -469,10 +486,9 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_rcu(pos, tbl, hash)			\
-	for (({barrier(); }),						\
-	     pos = rht_ptr(rht_dereference_bucket_rcu(			\
-				   *rht_bucket(tbl, hash), tbl, hash));	\
-	     !rht_is_a_nulls(pos);					\
+	for (({barrier(); }),					\
+	     pos = rht_ptr(rht_bucket(tbl, hash), tbl, hash);	\
+	     !rht_is_a_nulls(pos);				\
 	     pos = rcu_dereference_raw(pos->next))
 
 /**
@@ -490,7 +506,7 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  */
 #define rht_for_each_entry_rcu_from(tpos, pos, head, tbl, hash, member) \
 	for (({barrier(); }),						    \
-	     pos = rht_dereference_bucket_rcu(head, tbl, hash);		    \
+	     pos = head;						    \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	    \
 	     pos = rht_dereference_bucket_rcu(pos->next, tbl, hash))
 
@@ -508,8 +524,9 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
  */
 #define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		   \
 	rht_for_each_entry_rcu_from(tpos, pos,				   \
-					rht_ptr(*rht_bucket(tbl, hash)),   \
-					tbl, hash, member)
+				    rht_ptr(rht_bucket(tbl, hash),	   \
+					    tbl, hash),			   \
+				    tbl, hash, member)
 
 /**
  * rhl_for_each_rcu - iterate over rcu hash table list
@@ -556,7 +573,6 @@ static inline struct rhash_head *__rhashtable_lookup(
 	};
 	struct rhash_lock_head __rcu * const *bkt;
 	struct bucket_table *tbl;
-	struct rhash_head __rcu *head;
 	struct rhash_head *he;
 	unsigned int hash;
 
@@ -565,8 +581,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 	hash = rht_key_hashfn(ht, tbl, key, params);
 	bkt = rht_bucket(tbl, hash);
 	do {
-		head = rht_ptr(rht_dereference_bucket_rcu(*bkt, tbl, hash));
-		rht_for_each_rcu_from(he, head, tbl, hash) {
+		rht_for_each_rcu_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 			    rhashtable_compare(&arg, rht_obj(ht, he)))
@@ -699,7 +714,7 @@ static inline void *__rhashtable_insert_fast(
 		return rhashtable_insert_slow(ht, key, obj);
 	}
 
-	rht_for_each_from(head, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(head, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
 
@@ -744,7 +759,7 @@ static inline void *__rhashtable_insert_fast(
 		goto slow_path;
 
 	/* Inserting at head of list makes unlocking free. */
-	head = rht_ptr(rht_dereference_bucket(*bkt, tbl, hash));
+	head = rht_ptr(bkt, tbl, hash);
 
 	RCU_INIT_POINTER(obj->next, head);
 	if (rhlist) {
@@ -971,7 +986,7 @@ static inline int __rhashtable_remove_fast_one(
 	pprev = NULL;
 	rht_lock(tbl, bkt);
 
-	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *list;
 
 		list = container_of(he, struct rhlist_head, rhead);
@@ -1130,7 +1145,7 @@ static inline int __rhashtable_replace_fast(
 	pprev = NULL;
 	rht_lock(tbl, bkt);
 
-	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
 			continue;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index ec485962de5f..1f38f550ba76 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -232,7 +232,8 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	err = -ENOENT;
 
-	rht_for_each_from(entry, rht_ptr(*bkt), old_tbl, old_hash) {
+	rht_for_each_from(entry, rht_ptr(bkt, old_tbl, old_hash),
+			  old_tbl, old_hash) {
 		err = 0;
 		next = rht_dereference_bucket(entry->next, old_tbl, old_hash);
 
@@ -249,8 +250,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	rht_lock_nested(new_tbl, &new_tbl->buckets[new_hash], SINGLE_DEPTH_NESTING);
 
-	head = rht_ptr(rht_dereference_bucket(new_tbl->buckets[new_hash],
-					      new_tbl, new_hash));
+	head = rht_ptr(new_tbl->buckets + new_hash, new_tbl, new_hash);
 
 	RCU_INIT_POINTER(entry->next, head);
 
@@ -492,7 +492,7 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 	int elasticity;
 
 	elasticity = RHT_ELASTICITY;
-	rht_for_each_from(head, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(head, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
 
@@ -558,7 +558,7 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		return ERR_PTR(-EAGAIN);
 
-	head = rht_ptr(rht_dereference_bucket(*bkt, tbl, hash));
+	head = rht_ptr(bkt, tbl, hash);
 
 	RCU_INIT_POINTER(obj->next, head);
 	if (ht->rhlist) {
@@ -1140,7 +1140,7 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
 			struct rhash_head *pos, *next;
 
 			cond_resched();
-			for (pos = rht_ptr(rht_dereference(*rht_bucket(tbl, i), ht)),
+			for (pos = rht_ptr_exclusive(rht_bucket(tbl, i)),
 			     next = !rht_is_a_nulls(pos) ?
 					rht_dereference(pos->next, ht) : NULL;
 			     !rht_is_a_nulls(pos);
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 02592c2a249c..084fe5a6ac57 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -500,7 +500,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 		struct rhash_head *pos, *next;
 		struct test_obj_rhl *p;
 
-		pos = rht_ptr(rht_dereference(tbl->buckets[i], ht));
+		pos = rht_ptr_exclusive(tbl->buckets + i);
 		next = !rht_is_a_nulls(pos) ? rht_dereference(pos->next, ht) : NULL;
 
 		if (!rht_is_a_nulls(pos)) {



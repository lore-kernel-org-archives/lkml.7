Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C664C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89E42184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDKGNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:13:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:36414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbfDKGNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC946B138;
        Thu, 11 Apr 2019 06:13:28 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Guenter Roeck <linux@roeck-us.net>
Date:   Thu, 11 Apr 2019 16:13:20 +1000
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
In-Reply-To: <87r2a9xt79.fsf@notabene.neil.brown.name>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown> <155416006521.9540.5662092375167065834.stgit@noble.brown> <20190410193418.GA32402@roeck-us.net> <87r2a9xt79.fsf@notabene.neil.brown.name>
Message-ID: <87lg0hxe67.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11 2019, NeilBrown wrote:

> On Wed, Apr 10 2019, Guenter Roeck wrote:
>
>> Hi,
>>
.....
>>
>> This patch causes my qemu q800 boot test to crash reliably.
>>
....
>> Code: 4a89 6604 4280 60ea 2c2b 000c 2748 000c <2869> 000c 082c 0003 0002=
 6728 4878 0014 7620 4873 3800 486e ffec 4eb9 002e 5b88
>
> Thanks for testing and for the report.
.....
>
> .... and after googling a bit I see that 68000 require 2-byte alignment,
> but not 4-byte.  Oh..
>
> That means there aren't two spare bits in an address, so I cannot use
> one for the NULLS and one for a lock bit.  Bother.
>
> I might be able to find a different way forward, but for now I think we
> need to drop this series.

I have found a way forward that I like.  It only requires one bit per
address to be over-loaded.

The following patch implements it and works for me.
Could you please confirm that it fixes your problem on m68k ??

I'll break it up into a few reviewable patches and post them separately.

Thanks again,
NeilBrown


diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 01253d809687..214487aaf3eb 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -40,7 +40,7 @@
  * the chain.  To avoid dereferencing this pointer without clearing
  * the bit first, we use an opaque 'struct rhash_lock_head *' for the
  * pointer stored in the bucket.  This struct needs to be defined so
=2D * that rcu_derefernce() works on it, but it has no content so a
+ * that rcu_dereference() works on it, but it has no content so a
  * cast is needed for it to be useful.  This ensures it isn't
  * used by mistake with clearing the lock bit first.
  */
@@ -85,70 +85,6 @@ struct bucket_table {
 	struct rhash_lock_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
=20
=2D/*
=2D * We lock a bucket by setting BIT(0) in the pointer - this is always
=2D * zero in real pointers and in the nulls marker.
=2D * bit_spin_locks do not handle contention well, but the whole point
=2D * of the hashtable design is to achieve minimum per-bucket contention.
=2D * A nested hash table might not have a bucket pointer.  In that case
=2D * we cannot get a lock.  For remove and replace the bucket cannot be
=2D * interesting and doesn't need locking.
=2D * For insert we allocate the bucket if this is the last bucket_table,
=2D * and then take the lock.
=2D * Sometimes we unlock a bucket by writing a new pointer there.  In that
=2D * case we don't need to unlock, but we do need to reset state such as
=2D * local_bh. For that we have rht_assign_unlock().  As rcu_assign_pointe=
r()
=2D * provides the same release semantics that bit_spin_unlock() provides,
=2D * this is safe.
=2D */
=2D
=2Dstatic inline void rht_lock(struct rhash_lock_head **bkt)
=2D{
=2D	local_bh_disable();
=2D	bit_spin_lock(0, (unsigned long *)bkt);
=2D}
=2D
=2Dstatic inline void rht_unlock(struct rhash_lock_head **bkt)
=2D{
=2D	bit_spin_unlock(0, (unsigned long *)bkt);
=2D	local_bh_enable();
=2D}
=2D
=2Dstatic inline void rht_assign_unlock(struct rhash_lock_head **bkt,
=2D				     struct rhash_head *obj)
=2D{
=2D	struct rhash_head **p =3D (struct rhash_head **)bkt;
=2D
=2D	if (obj =3D=3D RHT_NULLS_MARKER(bkt))
=2D		obj =3D NULL;
=2D	rcu_assign_pointer(*p, obj);
=2D	preempt_enable();
=2D	__release(bitlock);
=2D	local_bh_enable();
=2D}
=2D
=2D/*
=2D * If 'p' is a bucket head and might be locked:
=2D *   rht_ptr() returns the address without the lock bit.
=2D *   rht_ptr_locked() returns the address WITH the lock bit.
=2D */
=2Dstatic inline struct rhash_head __rcu *rht_ptr(const struct rhash_lock_h=
ead **bkt,
=2D					       struct bucket_table *tbl,
=2D					       unsigned int hash)
=2D{
=2D	const struct rhash_lock_head *p =3D
=2D		rht_dereference_bucket(*bkt, tbl, hash);
=2D	if (!p)
=2D		return RHT_NULLS_MARKER(bkt);
=2D	return (void *)(((unsigned long)p) & ~BIT(0));
=2D}
=2D
=2Dstatic inline struct rhash_lock_head __rcu *rht_ptr_locked(const
=2D							   struct rhash_head *p)
=2D{
=2D	return (void *)(((unsigned long)p) | BIT(0));
=2D}
=2D
 /*
  * NULLS_MARKER() expects a hash value with the low
  * bits mostly likely to be significant, and it discards
@@ -367,6 +303,93 @@ static inline struct rhash_lock_head __rcu **rht_bucke=
t_insert(
 				     &tbl->buckets[hash];
 }
=20
+/*
+ * We lock a bucket by setting BIT(0) in the pointer - this is always
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
+	bit_spin_lock(0, (unsigned long *)bkt);
+}
+
+static inline void rht_unlock(struct rhash_lock_head **bkt)
+{
+	bit_spin_unlock(0, (unsigned long *)bkt);
+	local_bh_enable();
+}
+
+/*
+ * If 'p' is a bucket head and might be locked:
+ *   rht_ptr() returns the address without the lock bit.
+ *   rht_ptr_locked() returns the address WITH the lock bit.
+ */
+static inline struct rhash_head __rcu *rht_ptr(struct rhash_lock_head __rc=
u * const *bkt,
+					       struct bucket_table *tbl,
+					       unsigned int hash)
+{
+	const struct rhash_lock_head *p =3D
+		rht_dereference_bucket_rcu(*bkt, tbl, hash);
+	if ((((unsigned long)p) & ~BIT(0)) =3D=3D 0)
+		return RHT_NULLS_MARKER(bkt);
+	return (void *)(((unsigned long)p) & ~BIT(0));
+}
+
+/*
+ * This can be called when access is known to be exclusive,
+ * such as when destorying an rhashtable
+ */
+static inline struct rhash_head __rcu *rht_ptr_unprotected(
+	struct rhash_lock_head __rcu * const *bkt)
+{
+	const struct rhash_lock_head *p =3D rcu_dereference_protected(*bkt, true);
+	if (!p)
+		return RHT_NULLS_MARKER(bkt);
+	return (void *)(((unsigned long)p) & ~BIT(0));
+}
+
+static inline struct rhash_lock_head __rcu *rht_ptr_locked(const
+							   struct rhash_head *p)
+{
+	return (void *)(((unsigned long)p) | BIT(0));
+}
+
+static inline void rht_assign_locked(struct rhash_lock_head __rcu **bkt,
+				     struct rhash_head *obj)
+{
+	struct rhash_head __rcu **p =3D (struct rhash_head __rcu **)bkt;
+
+	if (rht_is_a_nulls(obj))
+		obj =3D NULL;
+	rcu_assign_pointer(*p, rht_ptr_locked(obj));
+}
+
+static inline void rht_assign_unlock(struct rhash_lock_head __rcu **bkt,
+				     struct rhash_head *obj)
+{
+	struct rhash_head __rcu **p =3D (struct rhash_head __rcu **)bkt;
+
+	if (rht_is_a_nulls(obj))
+		obj =3D NULL;
+	rcu_assign_pointer(*p, obj);
+	preempt_enable();
+	__release(bitlock);
+	local_bh_enable();
+}
+
 /**
  * rht_for_each_from - iterate over hash chain from given head
  * @pos:	the &struct rhash_head to use as a loop cursor.
@@ -375,7 +398,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket=
_insert(
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each_from(pos, head, tbl, hash) \
=2D	for (pos =3D rht_dereference_bucket(head, tbl, hash); \
+	for (pos =3D head; \
 	     !rht_is_a_nulls(pos); \
 	     pos =3D rht_dereference_bucket((pos)->next, tbl, hash))
=20
@@ -386,7 +409,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket=
_insert(
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each(pos, tbl, hash) \
=2D	rht_for_each_from(pos, rht_ptr(*rht_bucket(tbl, hash)), tbl, hash)
+	rht_for_each_from(pos, rht_ptr(rht_bucket(tbl, hash), tbl, hash))
=20
 /**
  * rht_for_each_entry_from - iterate over hash chain from given head
@@ -398,7 +421,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket=
_insert(
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry_from(tpos, pos, head, tbl, hash, member)	\
=2D	for (pos =3D rht_dereference_bucket(head, tbl, hash);		\
+	for (pos =3D head;						\
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	\
 	     pos =3D rht_dereference_bucket((pos)->next, tbl, hash))
=20
@@ -411,8 +434,8 @@ static inline struct rhash_lock_head __rcu **rht_bucket=
_insert(
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry(tpos, pos, tbl, hash, member)		\
=2D	rht_for_each_entry_from(tpos, pos, rht_ptr(*rht_bucket(tbl, hash)), \
=2D				    tbl, hash, member)
+	rht_for_each_entry_from(tpos, pos, rht_ptr(rht_bucket(tbl, hash), \
+						   tbl, hash, member))
=20
 /**
  * rht_for_each_entry_safe - safely iterate over hash chain of given type
@@ -427,8 +450,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket=
_insert(
  * remove the loop cursor from the list.
  */
 #define rht_for_each_entry_safe(tpos, pos, next, tbl, hash, member)	      \
=2D	for (pos =3D rht_dereference_bucket(rht_ptr(*rht_bucket(tbl, hash)),   =
 \
=2D					  tbl, hash),			      \
+	for (pos =3D rht_ptr(rht_bucket(tbl, hash), tbl, hash)),		      \
 	     next =3D !rht_is_a_nulls(pos) ?				      \
 		       rht_dereference_bucket(pos->next, tbl, hash) : NULL;   \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	      \
@@ -449,7 +471,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket=
_insert(
  */
 #define rht_for_each_rcu_from(pos, head, tbl, hash)			\
 	for (({barrier(); }),						\
=2D	     pos =3D rht_dereference_bucket_rcu(head, tbl, hash);		\
+	     pos =3D head;						\
 	     !rht_is_a_nulls(pos);					\
 	     pos =3D rcu_dereference_raw(pos->next))
=20
@@ -464,10 +486,9 @@ static inline struct rhash_lock_head __rcu **rht_bucke=
t_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_rcu(pos, tbl, hash)			\
=2D	for (({barrier(); }),						\
=2D	     pos =3D rht_ptr(rht_dereference_bucket_rcu(			\
=2D				   *rht_bucket(tbl, hash), tbl, hash));	\
=2D	     !rht_is_a_nulls(pos);					\
+	for (({barrier(); }),					\
+	     pos =3D rht_ptr(rht_bucket(tbl, hash), tbl, hash);	\
+	     !rht_is_a_nulls(pos);				\
 	     pos =3D rcu_dereference_raw(pos->next))
=20
 /**
@@ -485,7 +506,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket=
_insert(
  */
 #define rht_for_each_entry_rcu_from(tpos, pos, head, tbl, hash, member) \
 	for (({barrier(); }),						    \
=2D	     pos =3D rht_dereference_bucket_rcu(head, tbl, hash);		    \
+	     pos =3D head;						    \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	    \
 	     pos =3D rht_dereference_bucket_rcu(pos->next, tbl, hash))
=20
@@ -501,10 +522,10 @@ static inline struct rhash_lock_head __rcu **rht_buck=
et_insert(
  * the _rcu mutation primitives such as rhashtable_insert() as long as the
  * traversal is guarded by rcu_read_lock().
  */
=2D#define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		   \
=2D	rht_for_each_entry_rcu_from(tpos, pos,				   \
=2D					rht_ptr(*rht_bucket(tbl, hash)),   \
=2D					tbl, hash, member)
+#define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		\
+	rht_for_each_entry_rcu_from(tpos, pos,				\
+				    rht_ptr(rht_bucket(tbl, hash),	\
+					    tbl, hash, member))
=20
 /**
  * rhl_for_each_rcu - iterate over rcu hash table list
@@ -559,8 +580,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 	hash =3D rht_key_hashfn(ht, tbl, key, params);
 	bkt =3D rht_bucket(tbl, hash);
 	do {
=2D		he =3D rht_ptr(rht_dereference_bucket_rcu(*bkt, tbl, hash));
=2D		rht_for_each_rcu_from(he, he, tbl, hash) {
+		rht_for_each_rcu_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 			    rhashtable_compare(&arg, rht_obj(ht, he)))
@@ -693,7 +713,7 @@ static inline void *__rhashtable_insert_fast(
 		return rhashtable_insert_slow(ht, key, obj);
 	}
=20
=2D	rht_for_each_from(head, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(head, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
=20
@@ -738,7 +758,7 @@ static inline void *__rhashtable_insert_fast(
 		goto slow_path;
=20
 	/* Inserting at head of list makes unlocking free. */
=2D	head =3D rht_ptr(rht_dereference_bucket(*bkt, tbl, hash));
+	head =3D rht_ptr(bkt, tbl, hash);
=20
 	RCU_INIT_POINTER(obj->next, head);
 	if (rhlist) {
@@ -965,7 +985,7 @@ static inline int __rhashtable_remove_fast_one(
 	pprev =3D NULL;
 	rht_lock(bkt);
=20
=2D	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *list;
=20
 		list =3D container_of(he, struct rhlist_head, rhead);
@@ -1124,7 +1144,7 @@ static inline int __rhashtable_replace_fast(
 	pprev =3D NULL;
 	rht_lock(bkt);
=20
=2D	rht_for_each_from(he, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(he, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		if (he !=3D obj_old) {
 			pprev =3D &he->next;
 			continue;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c5d0974467ee..2eafc8463349 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -59,7 +59,7 @@ int lockdep_rht_bucket_is_held(const struct bucket_table =
*tbl, u32 hash)
 		return 1;
 	if (unlikely(tbl->nest))
 		return 1;
=2D	return bit_spin_is_locked(1, (unsigned long *)&tbl->buckets[hash]);
+	return bit_spin_is_locked(0, (unsigned long *)&tbl->buckets[hash]);
 }
 EXPORT_SYMBOL_GPL(lockdep_rht_bucket_is_held);
 #else
@@ -221,7 +221,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 	struct bucket_table *new_tbl =3D rhashtable_last_table(ht, old_tbl);
 	int err =3D -EAGAIN;
 	struct rhash_head *head, *next, *entry;
=2D	struct rhash_head **pprev =3D NULL;
+	struct rhash_head __rcu **pprev =3D NULL;
 	unsigned int new_hash;
=20
 	if (new_tbl->nest)
@@ -229,7 +229,8 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
=20
 	err =3D -ENOENT;
=20
=2D	rht_for_each_from(entry, rht_ptr(*bkt), old_tbl, old_hash) {
+	rht_for_each_from(entry, rht_ptr(bkt, old_tbl, old_hash),
+			  old_tbl, old_hash) {
 		err =3D 0;
 		next =3D rht_dereference_bucket(entry->next, old_tbl, old_hash);
=20
@@ -246,8 +247,8 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
=20
 	rht_lock(&new_tbl->buckets[new_hash]);
=20
=2D	head =3D rht_ptr(rht_dereference_bucket(new_tbl->buckets[new_hash],
=2D					      new_tbl, new_hash));
+	head =3D rht_ptr(new_tbl->buckets + new_hash,
+		       new_tbl, new_hash);
=20
 	RCU_INIT_POINTER(entry->next, head);
=20
@@ -257,7 +258,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 		rcu_assign_pointer(*pprev, next);
 	else
 		/* Need to preserved the bit lock. */
=2D		rcu_assign_pointer(*bkt, rht_ptr_locked(next));
+		rht_assign_locked(bkt, next);
=20
 out:
 	return err;
@@ -484,12 +485,12 @@ static void *rhashtable_lookup_one(struct rhashtable =
*ht,
 		.ht =3D ht,
 		.key =3D key,
 	};
=2D	struct rhash_head **pprev =3D NULL;
+	struct rhash_head __rcu **pprev =3D NULL;
 	struct rhash_head *head;
 	int elasticity;
=20
 	elasticity =3D RHT_ELASTICITY;
=2D	rht_for_each_from(head, rht_ptr(*bkt), tbl, hash) {
+	rht_for_each_from(head, rht_ptr(bkt, tbl, hash), tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
=20
@@ -515,7 +516,7 @@ static void *rhashtable_lookup_one(struct rhashtable *h=
t,
 			rcu_assign_pointer(*pprev, obj);
 		else
 			/* Need to preserve the bit lock */
=2D			rcu_assign_pointer(*bkt, rht_ptr_locked(obj));
+			rht_assign_locked(bkt, obj);
=20
 		return NULL;
 	}
@@ -555,7 +556,7 @@ static struct bucket_table *rhashtable_insert_one(struc=
t rhashtable *ht,
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		return ERR_PTR(-EAGAIN);
=20
=2D	head =3D rht_ptr(rht_dereference_bucket(*bkt, tbl, hash));
+	head =3D rht_ptr(bkt, tbl, hash);
=20
 	RCU_INIT_POINTER(obj->next, head);
 	if (ht->rhlist) {
@@ -568,7 +569,7 @@ static struct bucket_table *rhashtable_insert_one(struc=
t rhashtable *ht,
 	/* bkt is always the head of the list, so it holds
 	 * the lock, which we need to preserve
 	 */
=2D	rcu_assign_pointer(*bkt, rht_ptr_locked(obj));
+	rht_assign_locked(bkt, obj);
=20
 	atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))
@@ -1137,7 +1138,7 @@ void rhashtable_free_and_destroy(struct rhashtable *h=
t,
 			struct rhash_head *pos, *next;
=20
 			cond_resched();
=2D			for (pos =3D rht_ptr(rht_dereference(*rht_bucket(tbl, i), ht)),
+			for (pos =3D rht_ptr_unprotected(rht_bucket(tbl, i)),
 			     next =3D !rht_is_a_nulls(pos) ?
 					rht_dereference(pos->next, ht) : NULL;
 			     !rht_is_a_nulls(pos);
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 02592c2a249c..7b93cfefe195 100644
=2D-- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -500,7 +500,7 @@ static unsigned int __init print_ht(struct rhltable *rh=
lt)
 		struct rhash_head *pos, *next;
 		struct test_obj_rhl *p;
=20
=2D		pos =3D rht_ptr(rht_dereference(tbl->buckets[i], ht));
+		pos =3D rht_ptr_unprotected(tbl->buckets + i);
 		next =3D !rht_is_a_nulls(pos) ? rht_dereference(pos->next, ht) : NULL;
=20
 		if (!rht_is_a_nulls(pos)) {

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyu2wEACgkQOeye3VZi
gbl3MA/+IhzOGfcO7VPkvX4PuPyr2IuI5eSVhQaZAlEhKzn07NXbFeE+nA9dOqDX
Hc8bCr96xrE/RKROEfNlE3Eovh8QyVH8iIhiGkn571+ix3TqCb9KYoQm7Pl9hUxK
Q0aM5t/iOeAoEN3BDcpXkth1K3yL4M119jQmj7/iWCw6VPpYTKTFwptBAA/1HpBa
VN5+WzHMLucHJmooug19UTfangQ0JV9uDyVRNWe/+cmfeC5GkRqfbeL0Rj/GDnoo
mLkKydKmf+DBtugLfJBJ7ifCSlKUmUz1UibOAFLuipYtvJI82r5NK3918N9nKTM7
twSX/0Lb0jN/M7XQSN/9yL0WyQL8ocbi4ZPGx6/tMFnUeUstulLSxlVp1fCHC2qQ
EJNyniDd5PRQBH1pnOvJo/wCyLafLSkL9+MBzknCFDo2hDu7Nd4nXOz9haubAxML
9mV1q+VL5TNy6ofOSOlF4JnIcjwaavGiUATO6i/TQHfQSxd22DSgG2fs7KVkLzgi
+nYyIkEpCJ4LO7MWPyBfQOs5Yt1+6jhw/hKX7SfZJiL+r1kDciwOWDlNN1ZTKjh4
ksgHjLNzKtazl/kaV2BIrtdF954umqdMpqqKiov0X+1Yq3o12xG1ozs7rIhNoPWH
HcpdknklESQqVhUHXWPsXDlnsIs/txXUUCnn3ZjF+onAJodw+1o=
=CcOM
-----END PGP SIGNATURE-----
--=-=-=--

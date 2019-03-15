Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDA1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6768221871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfCOGqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:46:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727486AbfCOGqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:46:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27D40ACEC;
        Fri, 15 Mar 2019 06:46:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 15 Mar 2019 17:46:37 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20190315054709.mlcctcv3qy57wini@gondor.apana.org.au>
References: <155253979234.5022.1840929790507376038.stgit@noble.brown> <155253992829.5022.17977838545670077984.stgit@noble.brown> <20190315054709.mlcctcv3qy57wini@gondor.apana.org.au>
Message-ID: <87o96cocs2.fsf@notabene.neil.brown.name>
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

On Fri, Mar 15 2019, Herbert Xu wrote:

> On Thu, Mar 14, 2019 at 04:05:28PM +1100, NeilBrown wrote:
>> rhashtable_try_insert() currently holds a lock on the bucket in
>> the first table, while also locking buckets in subsequent tables.
>> This is unnecessary and looks like a hold-over from some earlier
>> version of the implementation.
>>=20
>> As insert and remove always lock a bucket in each table in turn, and
>> as insert only inserts in the final table, there cannot be any races
>> that are not covered by simply locking a bucket in each table in turn.
>>=20
>> When an insert call reaches that last table it can be sure that there
>> is no matchinf entry in any other table as it has searched them all, and
>> insertion never happens anywhere but in the last table.  The fact that
>> code tests for the existence of future_tbl while holding a lock on
>> the relevant bucket ensures that two threads inserting the same key
>> will make compatible decisions about which is the "last" table.
>>=20
>> This simplifies the code and allows the ->rehash field to be
>> discarded.
>>=20
>> We still need a way to ensure that a dead bucket_table is never
>> re-linked by rhashtable_walk_stop().  This can be achieved by calling
>> call_rcu() inside the locked region, and checking with
>> rcu_head_after_call_rcu() in rhashtable_walk_stop() to see if the
>> bucket table is empty and dead.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  include/linux/rhashtable.h |   13 -----------
>>  lib/rhashtable.c           |   50 +++++++++++++------------------------=
-------
>>  2 files changed, 15 insertions(+), 48 deletions(-)
>
> Thanks! This looks very nice.
>
>> @@ -580,36 +583,14 @@ static void *rhashtable_try_insert(struct rhashtab=
le *ht, const void *key,
>>  	struct bucket_table *new_tbl;
>>  	struct bucket_table *tbl;
>>  	unsigned int hash;
>> -	spinlock_t *lock;
>>  	void *data;
>>=20=20
>> -	tbl =3D rcu_dereference(ht->tbl);
>> -
>> -	/* All insertions must grab the oldest table containing
>> -	 * the hashed bucket that is yet to be rehashed.
>> -	 */
>> -	for (;;) {
>> -		hash =3D rht_head_hashfn(ht, tbl, obj, ht->p);
>> -		lock =3D rht_bucket_lock(tbl, hash);
>> -		spin_lock_bh(lock);
>> -
>> -		if (tbl->rehash <=3D hash)
>> -			break;
>> -
>> -		spin_unlock_bh(lock);
>> -		tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);
>> -	}
>> -
>> -	data =3D rhashtable_lookup_one(ht, tbl, hash, key, obj);
>> -	new_tbl =3D rhashtable_insert_one(ht, tbl, hash, obj, data);
>> -	if (PTR_ERR(new_tbl) !=3D -EEXIST)
>> -		data =3D ERR_CAST(new_tbl);
>> +	new_tbl =3D rcu_dereference(ht->tbl);
>>=20=20
>> -	while (!IS_ERR_OR_NULL(new_tbl)) {
>> +	do {
>>  		tbl =3D new_tbl;
>>  		hash =3D rht_head_hashfn(ht, tbl, obj, ht->p);
>> -		spin_lock_nested(rht_bucket_lock(tbl, hash),
>> -				 SINGLE_DEPTH_NESTING);
>> +		spin_lock(rht_bucket_lock(tbl, hash));
>
> One small problem.  I think this needs to be spin_lock_bh.

Yes, thanks for the catching that - and the match spin_unlock needs
fixing too.  See below.

Thanks,
NeilBrown

From: NeilBrown <neilb@suse.com>
Date: Mon, 25 Jun 2018 08:09:19 +1000
Subject: [PATCH] rhashtable: don't hold lock on first table throughout
 insertion.

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
=2D--
 include/linux/rhashtable.h | 13 ------------
 lib/rhashtable.c           | 52 ++++++++++++++----------------------------=
----
 2 files changed, 16 insertions(+), 49 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index ae9c0f71f311..3864193d5e2e 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -63,7 +63,6 @@
 struct bucket_table {
 	unsigned int		size;
 	unsigned int		nest;
=2D	unsigned int		rehash;
 	u32			hash_rnd;
 	unsigned int		locks_mask;
 	spinlock_t		*locks;
@@ -776,12 +775,6 @@ static inline int rhltable_insert(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
=2D * Locks down the bucket chain in both the old and new table if a resize
=2D * is in progress to ensure that writers can't remove from the old table
=2D * and can't insert to the new table during the atomic operation of sear=
ch
=2D * and insertion. Searches for duplicates in both the old and new table =
if
=2D * a resize is in progress.
=2D *
  * This lookup function may only be used for fixed key hash table (key_len
  * parameter set). It will BUG() if used inappropriately.
  *
@@ -837,12 +830,6 @@ static inline void *rhashtable_lookup_get_insert_fast(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
=2D * Locks down the bucket chain in both the old and new table if a resize
=2D * is in progress to ensure that writers can't remove from the old table
=2D * and can't insert to the new table during the atomic operation of sear=
ch
=2D * and insertion. Searches for duplicates in both the old and new table =
if
=2D * a resize is in progress.
=2D *
  * Lookups may occur in parallel with hashtable mutations and resizing.
  *
  * Will trigger an automatic deferred table resizing if residency in the
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c983c0ee15d5..8711c694e359 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -199,6 +199,7 @@ static struct bucket_table *bucket_table_alloc(struct r=
hashtable *ht,
 		return NULL;
 	}
=20
+	rcu_head_init(&tbl->rcu);
 	INIT_LIST_HEAD(&tbl->walkers);
=20
 	tbl->hash_rnd =3D get_random_u32();
@@ -282,10 +283,9 @@ static int rhashtable_rehash_chain(struct rhashtable *=
ht,
 	while (!(err =3D rhashtable_rehash_one(ht, old_hash)))
 		;
=20
=2D	if (err =3D=3D -ENOENT) {
=2D		old_tbl->rehash++;
+	if (err =3D=3D -ENOENT)
 		err =3D 0;
=2D	}
+
 	spin_unlock_bh(old_bucket_lock);
=20
 	return err;
@@ -332,13 +332,16 @@ static int rhashtable_rehash_table(struct rhashtable =
*ht)
 	spin_lock(&ht->lock);
 	list_for_each_entry(walker, &old_tbl->walkers, list)
 		walker->tbl =3D NULL;
=2D	spin_unlock(&ht->lock);
=20
 	/* Wait for readers. All new readers will see the new
 	 * table, and thus no references to the old table will
 	 * remain.
+	 * We do this inside the locked region so that
+	 * rhashtable_walk_stop() can use rcu_head_after_call_rcu()
+	 * to check if it should not re-link the table.
 	 */
 	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
+	spin_unlock(&ht->lock);
=20
 	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
 }
@@ -580,46 +583,22 @@ static void *rhashtable_try_insert(struct rhashtable =
*ht, const void *key,
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
 	unsigned int hash;
=2D	spinlock_t *lock;
 	void *data;
=20
=2D	tbl =3D rcu_dereference(ht->tbl);
=2D
=2D	/* All insertions must grab the oldest table containing
=2D	 * the hashed bucket that is yet to be rehashed.
=2D	 */
=2D	for (;;) {
=2D		hash =3D rht_head_hashfn(ht, tbl, obj, ht->p);
=2D		lock =3D rht_bucket_lock(tbl, hash);
=2D		spin_lock_bh(lock);
=2D
=2D		if (tbl->rehash <=3D hash)
=2D			break;
=2D
=2D		spin_unlock_bh(lock);
=2D		tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);
=2D	}
=2D
=2D	data =3D rhashtable_lookup_one(ht, tbl, hash, key, obj);
=2D	new_tbl =3D rhashtable_insert_one(ht, tbl, hash, obj, data);
=2D	if (PTR_ERR(new_tbl) !=3D -EEXIST)
=2D		data =3D ERR_CAST(new_tbl);
+	new_tbl =3D rcu_dereference(ht->tbl);
=20
=2D	while (!IS_ERR_OR_NULL(new_tbl)) {
+	do {
 		tbl =3D new_tbl;
 		hash =3D rht_head_hashfn(ht, tbl, obj, ht->p);
=2D		spin_lock_nested(rht_bucket_lock(tbl, hash),
=2D				 SINGLE_DEPTH_NESTING);
+		spin_lock_bh(rht_bucket_lock(tbl, hash));
=20
 		data =3D rhashtable_lookup_one(ht, tbl, hash, key, obj);
 		new_tbl =3D rhashtable_insert_one(ht, tbl, hash, obj, data);
 		if (PTR_ERR(new_tbl) !=3D -EEXIST)
 			data =3D ERR_CAST(new_tbl);
=20
=2D		spin_unlock(rht_bucket_lock(tbl, hash));
=2D	}
=2D
=2D	spin_unlock_bh(lock);
+		spin_unlock_bh(rht_bucket_lock(tbl, hash));
+	} while (!IS_ERR_OR_NULL(new_tbl));
=20
 	if (PTR_ERR(data) =3D=3D -EAGAIN)
 		data =3D ERR_PTR(rhashtable_insert_rehash(ht, tbl) ?:
@@ -941,10 +920,11 @@ void rhashtable_walk_stop(struct rhashtable_iter *ite=
r)
 	ht =3D iter->ht;
=20
 	spin_lock(&ht->lock);
=2D	if (tbl->rehash < tbl->size)
=2D		list_add(&iter->walker.list, &tbl->walkers);
=2D	else
+	if (rcu_head_after_call_rcu(&tbl->rcu, bucket_table_free_rcu))
+		/* This bucket table is being freed, don't re-link it. */
 		iter->walker.tbl =3D NULL;
+	else
+		list_add(&iter->walker.list, &tbl->walkers);
 	spin_unlock(&ht->lock);
=20
 out:
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyLSk0ACgkQOeye3VZi
gbnDQA/9HzS/fYUiKA41r9xCP53qos6b4uQEMNUh887ird4NNirOYb90EU2AqoF2
m3oi6ZPCIf8cHxXgznS7X2Y4p4dJBl2zwmZKxiVPUdJTZ6H8fHzKQqoHow4lVYwq
j03pyE6TmUGin5fq9C3YfUcgxxmP+fvg4ioADlDxFO1eQOqLjZoD3rXBArcqFUMQ
hf2NoDouJ57Ie9JzKZrWKfRe1FeI5t2EAd1aamJjXw2E4qA6YAumGJzNBIMMLKhX
OsscLdwBS/urRPivNuaNsY1AyZJmmmncyDH6VJUdEebFtGF2sy/5Jjh3+SNirK3U
u3NpSz78hz9ht7NLnPzaNKSzobP3HNy2Ak1lVQ4RCWhgPoTSXYJXGUenUCiR16Ag
9adiofUxOMCfL0DuJFbVZ55CqIOEjLOE27UytIpAlz17I49n18+Oq9cdyx9KMUWp
ejNc6s3v+tHAaAgpia40QSCz/yS8d3oyLY6atVZPPpkImkZucfF3w0Rgy2aHK7u9
1h6S6vm8YJm8lxJrGitA6B6kEs7IFTxh0KgLtqEeFpeKiSkBsuEcJUMUrTLYPMwK
oCcFIOw9B1SGOz9voCB8xUfT5HF7P5B6ebBfWH9OQwokefCrJK8TPuzu44Ilc9Fn
J1PosLiivhgF3ekyJOurLbrwEscJJ2eivT7nfDJFiaoTBqIIW84=
=RNuW
-----END PGP SIGNATURE-----
--=-=-=--

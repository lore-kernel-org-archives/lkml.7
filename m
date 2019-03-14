Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704B020811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfCNO5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:57:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfCNO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:57:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EEoxfa117985
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:57:40 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7qh3p32e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:57:40 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Mar 2019 14:57:38 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 14:57:35 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EEvYRd9044104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 14:57:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36D2FB206C;
        Thu, 14 Mar 2019 14:57:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0982EB2066;
        Thu, 14 Mar 2019 14:57:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 14:57:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 91A3C16C32B8; Thu, 14 Mar 2019 07:58:19 -0700 (PDT)
Date:   Thu, 14 Mar 2019 07:58:19 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rhashtable: don't hold lock on first table
 throughout insertion.
Reply-To: paulmck@linux.ibm.com
References: <155253979234.5022.1840929790507376038.stgit@noble.brown>
 <155253992829.5022.17977838545670077984.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155253992829.5022.17977838545670077984.stgit@noble.brown>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031414-0064-0000-0000-000003BA25FE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010757; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01174281; UDB=6.00614030; IPR=6.00954946;
 MB=3.00025978; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-14 14:57:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031414-0065-0000-0000-00003CB8228A
Message-Id: <20190314145819.GC4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 04:05:28PM +1100, NeilBrown wrote:
> rhashtable_try_insert() currently holds a lock on the bucket in
> the first table, while also locking buckets in subsequent tables.
> This is unnecessary and looks like a hold-over from some earlier
> version of the implementation.
> 
> As insert and remove always lock a bucket in each table in turn, and
> as insert only inserts in the final table, there cannot be any races
> that are not covered by simply locking a bucket in each table in turn.
> 
> When an insert call reaches that last table it can be sure that there
> is no matchinf entry in any other table as it has searched them all, and
> insertion never happens anywhere but in the last table.  The fact that
> code tests for the existence of future_tbl while holding a lock on
> the relevant bucket ensures that two threads inserting the same key
> will make compatible decisions about which is the "last" table.
> 
> This simplifies the code and allows the ->rehash field to be
> discarded.
> 
> We still need a way to ensure that a dead bucket_table is never
> re-linked by rhashtable_walk_stop().  This can be achieved by calling
> call_rcu() inside the locked region, and checking with
> rcu_head_after_call_rcu() in rhashtable_walk_stop() to see if the
> bucket table is empty and dead.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

This looks good to me.  From an rcu_head_init() and
rcu_head_after_call_rcu() viewpoint, and assuming that the value in
rhashtable_walk_stop()'s tbl pointer was fetched using rcu_dereference()
or similar within the same RCU read-side critical section in effect
during the call to rhashtable_walk_stop():

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

Some commentary below outlining my reasoning in more detail.

> ---
>  include/linux/rhashtable.h |   13 -----------
>  lib/rhashtable.c           |   50 +++++++++++++-------------------------------
>  2 files changed, 15 insertions(+), 48 deletions(-)
> 
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ae9c0f71f311..3864193d5e2e 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -63,7 +63,6 @@
>  struct bucket_table {
>  	unsigned int		size;
>  	unsigned int		nest;
> -	unsigned int		rehash;
>  	u32			hash_rnd;
>  	unsigned int		locks_mask;
>  	spinlock_t		*locks;
> @@ -776,12 +775,6 @@ static inline int rhltable_insert(
>   * @obj:	pointer to hash head inside object
>   * @params:	hash table parameters
>   *
> - * Locks down the bucket chain in both the old and new table if a resize
> - * is in progress to ensure that writers can't remove from the old table
> - * and can't insert to the new table during the atomic operation of search
> - * and insertion. Searches for duplicates in both the old and new table if
> - * a resize is in progress.
> - *
>   * This lookup function may only be used for fixed key hash table (key_len
>   * parameter set). It will BUG() if used inappropriately.
>   *
> @@ -837,12 +830,6 @@ static inline void *rhashtable_lookup_get_insert_fast(
>   * @obj:	pointer to hash head inside object
>   * @params:	hash table parameters
>   *
> - * Locks down the bucket chain in both the old and new table if a resize
> - * is in progress to ensure that writers can't remove from the old table
> - * and can't insert to the new table during the atomic operation of search
> - * and insertion. Searches for duplicates in both the old and new table if
> - * a resize is in progress.
> - *
>   * Lookups may occur in parallel with hashtable mutations and resizing.
>   *
>   * Will trigger an automatic deferred table resizing if residency in the
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index c983c0ee15d5..03ba449c6d38 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -199,6 +199,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
>  		return NULL;
>  	}
> 
> +	rcu_head_init(&tbl->rcu);

Good, you initialize this while allocating.  Presumably there are not any
other sneak allocations.  ;-)

>  	INIT_LIST_HEAD(&tbl->walkers);
> 
>  	tbl->hash_rnd = get_random_u32();
> @@ -282,10 +283,9 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
>  	while (!(err = rhashtable_rehash_one(ht, old_hash)))
>  		;
> 
> -	if (err == -ENOENT) {
> -		old_tbl->rehash++;
> +	if (err == -ENOENT)
>  		err = 0;
> -	}
> +
>  	spin_unlock_bh(old_bucket_lock);
> 
>  	return err;
> @@ -332,13 +332,16 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
>  	spin_lock(&ht->lock);
>  	list_for_each_entry(walker, &old_tbl->walkers, list)
>  		walker->tbl = NULL;
> -	spin_unlock(&ht->lock);
> 
>  	/* Wait for readers. All new readers will see the new
>  	 * table, and thus no references to the old table will
>  	 * remain.
> +	 * We do this inside the locked region so that
> +	 * rhashtable_walk_stop() can use rcu_head_after_call_rcu()
> +	 * to check if it should not re-link the table.
>  	 */
>  	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
> +	spin_unlock(&ht->lock);

My first thought was that moving this spin_unlock() was unnecessary,
but that was due to my focusing solely on avoiding the splat that
rcu_head_after_call_rcu() can generate.  Thinking a bit harder about
it, it looks like the purpose of moving the lock is to make sure
that rhashtable_walk_stop()'s check doesn't happen between the above
list_for_each_entry() and the above call_rcu(), which would result in
rcu_head_after_call_rcu() saying "Nope, no call_rcu() yet!".  And then
rhashtable_walk_stop() would add the about-to-be-call_rcu()ed element
back into the table, which would void all manner of warranties.

So, yes, I finally see why it is absolutely necessary to move this
spin_unlock().  ;-)

>  	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
>  }
> @@ -580,36 +583,14 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>  	struct bucket_table *new_tbl;
>  	struct bucket_table *tbl;
>  	unsigned int hash;
> -	spinlock_t *lock;
>  	void *data;
> 
> -	tbl = rcu_dereference(ht->tbl);
> -
> -	/* All insertions must grab the oldest table containing
> -	 * the hashed bucket that is yet to be rehashed.
> -	 */
> -	for (;;) {
> -		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
> -		lock = rht_bucket_lock(tbl, hash);
> -		spin_lock_bh(lock);
> -
> -		if (tbl->rehash <= hash)
> -			break;
> -
> -		spin_unlock_bh(lock);
> -		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
> -	}
> -
> -	data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
> -	new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
> -	if (PTR_ERR(new_tbl) != -EEXIST)
> -		data = ERR_CAST(new_tbl);
> +	new_tbl = rcu_dereference(ht->tbl);
> 
> -	while (!IS_ERR_OR_NULL(new_tbl)) {
> +	do {
>  		tbl = new_tbl;
>  		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
> -		spin_lock_nested(rht_bucket_lock(tbl, hash),
> -				 SINGLE_DEPTH_NESTING);
> +		spin_lock(rht_bucket_lock(tbl, hash));
> 
>  		data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
>  		new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
> @@ -617,9 +598,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>  			data = ERR_CAST(new_tbl);
> 
>  		spin_unlock(rht_bucket_lock(tbl, hash));
> -	}
> -
> -	spin_unlock_bh(lock);
> +	} while (!IS_ERR_OR_NULL(new_tbl));
> 
>  	if (PTR_ERR(data) == -EAGAIN)
>  		data = ERR_PTR(rhashtable_insert_rehash(ht, tbl) ?:
> @@ -941,10 +920,11 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
>  	ht = iter->ht;
> 
>  	spin_lock(&ht->lock);
> -	if (tbl->rehash < tbl->size)
> -		list_add(&iter->walker.list, &tbl->walkers);
> -	else
> +	if (rcu_head_after_call_rcu(&tbl->rcu, bucket_table_free_rcu))

And in v5.0, this is within an RCU read-side critical section, as is
necessary.  (Otherwise, the grace period might end and the thing
pointed to by tbl might be reallocated as something else, in which
case with high probability rcu_head_after_call_rcu() would complain
bitterly.)

This assumes that tbl was also fetched with rcu_dereference() within
this same RCU read-side critical section.  A quick glance at the
rhashtable_walk_start_check() leads me to believe that this is
the case, but I must confess that I did not check all the calls to
rhashtable_walk_stop() and rhashtable_walk_start().  Yes, lazy this
morning, what can I say?

> +		/* This bucket table is being freed, don't re-link it. */
>  		iter->walker.tbl = NULL;
> +	else
> +		list_add(&iter->walker.list, &tbl->walkers);
>  	spin_unlock(&ht->lock);
> 
>  out:
> 
> 


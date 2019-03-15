Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022C9218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfCOFrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:47:24 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51834 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfCOFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 01:47:24 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h4fgb-0006o9-2K; Fri, 15 Mar 2019 13:47:17 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h4fgT-0000WW-Rz; Fri, 15 Mar 2019 13:47:09 +0800
Date:   Fri, 15 Mar 2019 13:47:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rhashtable: don't hold lock on first table
 throughout insertion.
Message-ID: <20190315054709.mlcctcv3qy57wini@gondor.apana.org.au>
References: <155253979234.5022.1840929790507376038.stgit@noble.brown>
 <155253992829.5022.17977838545670077984.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155253992829.5022.17977838545670077984.stgit@noble.brown>
User-Agent: NeoMutt/20170113 (1.7.2)
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
> ---
>  include/linux/rhashtable.h |   13 -----------
>  lib/rhashtable.c           |   50 +++++++++++++-------------------------------
>  2 files changed, 15 insertions(+), 48 deletions(-)

Thanks! This looks very nice.

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

One small problem.  I think this needs to be spin_lock_bh.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

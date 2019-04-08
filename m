Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E9D20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDHCeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:34:24 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:33202 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:34:24 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hDK72-0005fI-7W; Mon, 08 Apr 2019 10:34:20 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hDK6y-0003Bm-Sj; Mon, 08 Apr 2019 10:34:16 +0800
Date:   Mon, 8 Apr 2019 10:34:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Message-ID: <20190408023416.kauuomnkwouyfdfg@gondor.apana.org.au>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
 <155416006521.9540.5662092375167065834.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155416006521.9540.5662092375167065834.stgit@noble.brown>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil:

On Tue, Apr 02, 2019 at 10:07:45AM +1100, NeilBrown wrote:
>
> @@ -263,13 +311,13 @@ void rhashtable_free_and_destroy(struct rhashtable *ht,
>  				 void *arg);
>  void rhashtable_destroy(struct rhashtable *ht);
>  
> -struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
> -					    unsigned int hash);
> -struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
> -					      unsigned int hash);
> -struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
> -						   struct bucket_table *tbl,
> +struct rhash_lock_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
> +						 unsigned int hash);

I don't think this opaque type should be marked as __rcu.  Because
you can't directly dereference it and once you put it through rht_ptr
then that's the pointer that should carry the __rcu marker.

If you add the __rcu here then you generate a lot of extra noise
in the code that isn't needed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

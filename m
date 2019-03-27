Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AD9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8E8205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712868;
	bh=TE4JuFnVZu2VK7ygOrOsl0YzYGMMsv1/pqEL2aJyCbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rV/B47kPQWaEKjyRc2fZG7zMA7GvNzugS0ynFS4YNcYC1fMuYos+S5LlTWLZTRGkK
	 QfFJS5F08htlleD7e2YnLoHH5aTnN6y6dWvdY+2PzS0L+e/FLp1w7UbN3na4o7IW8E
	 0W9jCGpWzeiu/x34QCj2lIknLaL7hh5ibL1aAiAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390353AbfC0Sy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:54:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390170AbfC0SRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:17:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9ED1AAD73;
        Wed, 27 Mar 2019 18:17:02 +0000 (UTC)
Date:   Wed, 27 Mar 2019 19:17:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, cl@linux.com,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190327181700.GO11927@dhcp22.suse.cz>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <20190327172955.GB17247@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327172955.GB17247@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-03-19 17:29:57, Catalin Marinas wrote:
[...]
> Quick attempt below and it needs some more testing (pretty random pick
> of the EMERGENCY_POOL_SIZE value). Also, with __GFP_NOFAIL removed, are
> the other flags safe or we should trim them further?

I would be still careful about __GFP_NORETRY. I pressume that the
primary purpose is to prevent from the OOM killer but this makes the
allocation failure much more likely. So if anything __GFP_RETRY_MAYFAIL
would suite better for that purpose. But I am not really sure that this
is worth bothering.

> ---------------8<-------------------------------
> >From dc4194539f8191bb754901cea74c86e7960886f8 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Wed, 27 Mar 2019 17:20:57 +0000
> Subject: [PATCH] mm: kmemleak: Add an emergency allocation pool for kmemleak
>  objects
> 
> This patch adds an emergency pool for struct kmemleak_object in case the
> normal kmem_cache_alloc() fails under the gfp constraints passed by the
> slab allocation caller. The patch also removes __GFP_NOFAIL which does
> not play well with other gfp flags (introduced by commit d9570ee3bd1d,
> "kmemleak: allow to coexist with fault injection").

Thank you! This is definitely a step into the right direction. Maybe the
pool allocation logic will need some tuning - e.g. does it make sense to
allocate into the pool from sleepable allocations - or is it sufficient
to refill on free. Something for the real workloads to tell, I guess.

> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  mm/kmemleak.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 6c318f5ac234..366a680cff7c 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -127,7 +127,7 @@
>  /* GFP bitmask for kmemleak internal allocations */
>  #define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
>  				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
> -				 __GFP_NOWARN | __GFP_NOFAIL)
> +				 __GFP_NOWARN)
>  
>  /* scanning area inside a memory block */
>  struct kmemleak_scan_area {
> @@ -191,11 +191,16 @@ struct kmemleak_object {
>  #define HEX_ASCII		1
>  /* max number of lines to be printed */
>  #define HEX_MAX_LINES		2
> +/* minimum emergency pool size */
> +#define EMERGENCY_POOL_SIZE	(NR_CPUS * 4)
>  
>  /* the list of all allocated objects */
>  static LIST_HEAD(object_list);
>  /* the list of gray-colored objects (see color_gray comment below) */
>  static LIST_HEAD(gray_list);
> +/* emergency pool allocation */
> +static LIST_HEAD(emergency_list);
> +static int emergency_pool_size;
>  /* search tree for object boundaries */
>  static struct rb_root object_tree_root = RB_ROOT;
>  /* rw_lock protecting the access to object_list and object_tree_root */
> @@ -467,6 +472,43 @@ static int get_object(struct kmemleak_object *object)
>  	return atomic_inc_not_zero(&object->use_count);
>  }
>  
> +/*
> + * Emergency pool allocation and freeing. kmemleak_lock must not be held.
> + */
> +static struct kmemleak_object *emergency_alloc(void)
> +{
> +	unsigned long flags;
> +	struct kmemleak_object *object;
> +
> +	write_lock_irqsave(&kmemleak_lock, flags);
> +	object = list_first_entry_or_null(&emergency_list, typeof(*object), object_list);
> +	if (object) {
> +		list_del(&object->object_list);
> +		emergency_pool_size--;
> +	}
> +	write_unlock_irqrestore(&kmemleak_lock, flags);
> +
> +	return object;
> +}
> +
> +/*
> + * Return true if object added to the emergency pool, false otherwise.
> + */
> +static bool emergency_free(struct kmemleak_object *object)
> +{
> +	unsigned long flags;
> +
> +	if (emergency_pool_size >= EMERGENCY_POOL_SIZE)
> +		return false;
> +
> +	write_lock_irqsave(&kmemleak_lock, flags);
> +	list_add(&object->object_list, &emergency_list);
> +	emergency_pool_size++;
> +	write_unlock_irqrestore(&kmemleak_lock, flags);
> +
> +	return true;
> +}
> +
>  /*
>   * RCU callback to free a kmemleak_object.
>   */
> @@ -485,7 +527,8 @@ static void free_object_rcu(struct rcu_head *rcu)
>  		hlist_del(&area->node);
>  		kmem_cache_free(scan_area_cache, area);
>  	}
> -	kmem_cache_free(object_cache, object);
> +	if (!emergency_free(object))
> +		kmem_cache_free(object_cache, object);
>  }
>  
>  /*
> @@ -577,6 +620,8 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  	unsigned long untagged_ptr;
>  
>  	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> +	if (!object)
> +		object = emergency_alloc();
>  	if (!object) {
>  		pr_warn("Cannot allocate a kmemleak_object structure\n");
>  		kmemleak_disable();
> @@ -2127,6 +2172,16 @@ void __init kmemleak_init(void)
>  			kmemleak_warning = 0;
>  		}
>  	}
> +
> +	/* populate the emergency allocation pool */
> +	while (emergency_pool_size < EMERGENCY_POOL_SIZE) {
> +		struct kmemleak_object *object;
> +
> +		object = kmem_cache_alloc(object_cache, GFP_KERNEL);
> +		if (!object)
> +			break;
> +		emergency_free(object);
> +	}
>  }
>  
>  /*

-- 
Michal Hocko
SUSE Labs

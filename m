Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D485BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16802173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553860962;
	bh=MHBmpYgp+3WIEkA4rcpdh1tRiZyCoj9TYKceYJrZ5ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dbwrr4QQUYPSj1kCpIfhSR04Iaj0UMoLOpv+O0g1ZVf71JQrmkY8laHjFSmZswXqB
	 0rHBrDbP1Gni2wdCqU00MpHcLNyvGC+KiYB41bfPx1XmHhnd+Kl0zsao7vJlADYbd5
	 6Qi8BFhGUt4ha7ObtGT6SRbS01o1uqIXLL49KoRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfC2MCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:02:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:43264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729434AbfC2MCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:02:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79B2DACE8;
        Fri, 29 Mar 2019 12:02:39 +0000 (UTC)
Date:   Fri, 29 Mar 2019 13:02:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190329120237.GB17624@dhcp22.suse.cz>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <20190327172955.GB17247@arrakis.emea.arm.com>
 <20190327182158.GS10344@bombadil.infradead.org>
 <20190328145917.GC10283@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328145917.GC10283@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-03-19 14:59:17, Catalin Marinas wrote:
[...]
> >From 09eba8f0235eb16409931e6aad77a45a12bedc82 Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Thu, 28 Mar 2019 13:26:07 +0000
> Subject: [PATCH] mm: kmemleak: Use mempool allocations for kmemleak objects
> 
> This patch adds mempool allocations for struct kmemleak_object and
> kmemleak_scan_area as slightly more resilient than kmem_cache_alloc()
> under memory pressure. The patch also masks out all the gfp flags passed
> to kmemleak other than GFP_KERNEL|GFP_ATOMIC.

Using mempool allocator is better than inventing its own implementation
but there is one thing to be slightly careful/worried about.

This allocator expects that somebody will refill the pool in a finit
time. Most users are OK with that because objects in flight are going
to return in the pool in a relatively short time (think of an IO) but
kmemleak is not guaranteed to comply with that AFAIU. Sure ephemeral
allocations are happening all the time so there should be some churn
in the pool all the time but if we go to an extreme where there is a
serious memory leak then I suspect we might get stuck here without any
way forward. Page/slab allocator would eventually back off even though
small allocations never fail because a user context would get killed
sooner or later but there is no fatal_signal_pending backoff in the
mempool alloc path.

Anyway, I believe this is a step in the right direction and should the
above ever materializes as a relevant problem we can tune the mempool
to backoff for _some_ callers or do something similar.

Btw. there is kmemleak_update_trace call in mempool_alloc, is this ok
for the kmemleak allocation path?

> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  mm/kmemleak.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 6c318f5ac234..9755678e83b9 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -82,6 +82,7 @@
>  #include <linux/kthread.h>
>  #include <linux/rbtree.h>
>  #include <linux/fs.h>
> +#include <linux/mempool.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/cpumask.h>
> @@ -125,9 +126,7 @@
>  #define BYTES_PER_POINTER	sizeof(void *)
>  
>  /* GFP bitmask for kmemleak internal allocations */
> -#define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
> -				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
> -				 __GFP_NOWARN | __GFP_NOFAIL)
> +#define gfp_kmemleak_mask(gfp)	((gfp) & (GFP_KERNEL | GFP_ATOMIC))
>  
>  /* scanning area inside a memory block */
>  struct kmemleak_scan_area {
> @@ -191,6 +190,9 @@ struct kmemleak_object {
>  #define HEX_ASCII		1
>  /* max number of lines to be printed */
>  #define HEX_MAX_LINES		2
> +/* minimum memory pool sizes */
> +#define MIN_OBJECT_POOL		(NR_CPUS * 4)
> +#define MIN_SCAN_AREA_POOL	(NR_CPUS * 1)
>  
>  /* the list of all allocated objects */
>  static LIST_HEAD(object_list);
> @@ -203,7 +205,9 @@ static DEFINE_RWLOCK(kmemleak_lock);
>  
>  /* allocation caches for kmemleak internal data */
>  static struct kmem_cache *object_cache;
> +static mempool_t *object_mempool;
>  static struct kmem_cache *scan_area_cache;
> +static mempool_t *scan_area_mempool;
>  
>  /* set if tracing memory operations is enabled */
>  static int kmemleak_enabled;
> @@ -483,9 +487,9 @@ static void free_object_rcu(struct rcu_head *rcu)
>  	 */
>  	hlist_for_each_entry_safe(area, tmp, &object->area_list, node) {
>  		hlist_del(&area->node);
> -		kmem_cache_free(scan_area_cache, area);
> +		mempool_free(area, scan_area_mempool);
>  	}
> -	kmem_cache_free(object_cache, object);
> +	mempool_free(object, object_mempool);
>  }
>  
>  /*
> @@ -576,7 +580,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  	struct rb_node **link, *rb_parent;
>  	unsigned long untagged_ptr;
>  
> -	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> +	object = mempool_alloc(object_mempool, gfp_kmemleak_mask(gfp));
>  	if (!object) {
>  		pr_warn("Cannot allocate a kmemleak_object structure\n");
>  		kmemleak_disable();
> @@ -640,7 +644,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  			 * be freed while the kmemleak_lock is held.
>  			 */
>  			dump_object_info(parent);
> -			kmem_cache_free(object_cache, object);
> +			mempool_free(object, object_mempool);
>  			object = NULL;
>  			goto out;
>  		}
> @@ -798,7 +802,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
>  		return;
>  	}
>  
> -	area = kmem_cache_alloc(scan_area_cache, gfp_kmemleak_mask(gfp));
> +	area = mempool_alloc(scan_area_mempool, gfp_kmemleak_mask(gfp));
>  	if (!area) {
>  		pr_warn("Cannot allocate a scan area\n");
>  		goto out;
> @@ -810,7 +814,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
>  	} else if (ptr + size > object->pointer + object->size) {
>  		kmemleak_warn("Scan area larger than object 0x%08lx\n", ptr);
>  		dump_object_info(object);
> -		kmem_cache_free(scan_area_cache, area);
> +		mempool_free(area, scan_area_mempool);
>  		goto out_unlock;
>  	}
>  
> @@ -2049,6 +2053,18 @@ void __init kmemleak_init(void)
>  
>  	object_cache = KMEM_CACHE(kmemleak_object, SLAB_NOLEAKTRACE);
>  	scan_area_cache = KMEM_CACHE(kmemleak_scan_area, SLAB_NOLEAKTRACE);
> +	if (!object_cache || !scan_area_cache) {
> +		kmemleak_disable();
> +		return;
> +	}
> +	object_mempool = mempool_create_slab_pool(MIN_OBJECT_POOL,
> +						  object_cache);
> +	scan_area_mempool = mempool_create_slab_pool(MIN_SCAN_AREA_POOL,
> +						     scan_area_cache);
> +	if (!object_mempool || !scan_area_mempool) {
> +		kmemleak_disable();
> +		return;
> +	}
>  
>  	if (crt_early_log > ARRAY_SIZE(early_log))
>  		pr_warn("Early log buffer exceeded (%d), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE\n",

-- 
Michal Hocko
SUSE Labs

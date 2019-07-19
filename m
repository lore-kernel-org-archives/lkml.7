Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CCAC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879112077C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563519933;
	bh=ZBwfyCZGbgcAO1CIemBCgGaTdxdzVdAmbdjbgIC2C2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jtX7D4lohNirfjTM44DVdZft5UNOm/UajsFb/78zD/BjCZiHkKNjSrYKgTzcUjXMh
	 fp74FR6nZoncsshFJW5AaG6RrJhZGhie8N3Lg2Fv0WPvr9bgbbB9N8XMS72HJKMzP0
	 xVXWkT0PGuVACt6WxwhDN/tSpTQVCDnvH8OQhA4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfGSHFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:05:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfGSHFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:05:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1EAEBAF4E;
        Fri, 19 Jul 2019 07:05:30 +0000 (UTC)
Date:   Fri, 19 Jul 2019 09:05:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm, slab: Move memcg_cache_params structure to mm/slab.h
Message-ID: <20190719070528.GN30461@dhcp22.suse.cz>
References: <20190718180827.18758-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718180827.18758-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-07-19 14:08:27, Waiman Long wrote:
> The memcg_cache_params structure is only embedded into the kmem_cache
> of slab and slub allocators as defined in slab_def.h and slub_def.h
> and used internally by mm code. There is no needed to expose it in
> a public header. So move it from include/linux/slab.h to mm/slab.h.
> It is just a refactoring patch with no code change.

No objection from me. As long as this survives all weird config
combinations and implicit header files dependencies...

> In fact both the slub_def.h and slab_def.h should be moved into the mm
> directory as well, but that will probably cause many merge conflicts.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/slab.h | 62 -------------------------------------------
>  mm/slab.h            | 63 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 62 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 56c9c7eed34e..ab2b98ad76e1 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -595,68 +595,6 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
>  	return __kmalloc_node(size, flags, node);
>  }
>  
> -struct memcg_cache_array {
> -	struct rcu_head rcu;
> -	struct kmem_cache *entries[0];
> -};
> -
> -/*
> - * This is the main placeholder for memcg-related information in kmem caches.
> - * Both the root cache and the child caches will have it. For the root cache,
> - * this will hold a dynamically allocated array large enough to hold
> - * information about the currently limited memcgs in the system. To allow the
> - * array to be accessed without taking any locks, on relocation we free the old
> - * version only after a grace period.
> - *
> - * Root and child caches hold different metadata.
> - *
> - * @root_cache:	Common to root and child caches.  NULL for root, pointer to
> - *		the root cache for children.
> - *
> - * The following fields are specific to root caches.
> - *
> - * @memcg_caches: kmemcg ID indexed table of child caches.  This table is
> - *		used to index child cachces during allocation and cleared
> - *		early during shutdown.
> - *
> - * @root_caches_node: List node for slab_root_caches list.
> - *
> - * @children:	List of all child caches.  While the child caches are also
> - *		reachable through @memcg_caches, a child cache remains on
> - *		this list until it is actually destroyed.
> - *
> - * The following fields are specific to child caches.
> - *
> - * @memcg:	Pointer to the memcg this cache belongs to.
> - *
> - * @children_node: List node for @root_cache->children list.
> - *
> - * @kmem_caches_node: List node for @memcg->kmem_caches list.
> - */
> -struct memcg_cache_params {
> -	struct kmem_cache *root_cache;
> -	union {
> -		struct {
> -			struct memcg_cache_array __rcu *memcg_caches;
> -			struct list_head __root_caches_node;
> -			struct list_head children;
> -			bool dying;
> -		};
> -		struct {
> -			struct mem_cgroup *memcg;
> -			struct list_head children_node;
> -			struct list_head kmem_caches_node;
> -			struct percpu_ref refcnt;
> -
> -			void (*work_fn)(struct kmem_cache *);
> -			union {
> -				struct rcu_head rcu_head;
> -				struct work_struct work;
> -			};
> -		};
> -	};
> -};
> -
>  int memcg_update_all_caches(int num_memcgs);
>  
>  /**
> diff --git a/mm/slab.h b/mm/slab.h
> index 5bf615cb3f99..68e455f2b698 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -30,6 +30,69 @@ struct kmem_cache {
>  	struct list_head list;	/* List of all slab caches on the system */
>  };
>  
> +#else /* !CONFIG_SLOB */
> +
> +struct memcg_cache_array {
> +	struct rcu_head rcu;
> +	struct kmem_cache *entries[0];
> +};
> +
> +/*
> + * This is the main placeholder for memcg-related information in kmem caches.
> + * Both the root cache and the child caches will have it. For the root cache,
> + * this will hold a dynamically allocated array large enough to hold
> + * information about the currently limited memcgs in the system. To allow the
> + * array to be accessed without taking any locks, on relocation we free the old
> + * version only after a grace period.
> + *
> + * Root and child caches hold different metadata.
> + *
> + * @root_cache:	Common to root and child caches.  NULL for root, pointer to
> + *		the root cache for children.
> + *
> + * The following fields are specific to root caches.
> + *
> + * @memcg_caches: kmemcg ID indexed table of child caches.  This table is
> + *		used to index child cachces during allocation and cleared
> + *		early during shutdown.
> + *
> + * @root_caches_node: List node for slab_root_caches list.
> + *
> + * @children:	List of all child caches.  While the child caches are also
> + *		reachable through @memcg_caches, a child cache remains on
> + *		this list until it is actually destroyed.
> + *
> + * The following fields are specific to child caches.
> + *
> + * @memcg:	Pointer to the memcg this cache belongs to.
> + *
> + * @children_node: List node for @root_cache->children list.
> + *
> + * @kmem_caches_node: List node for @memcg->kmem_caches list.
> + */
> +struct memcg_cache_params {
> +	struct kmem_cache *root_cache;
> +	union {
> +		struct {
> +			struct memcg_cache_array __rcu *memcg_caches;
> +			struct list_head __root_caches_node;
> +			struct list_head children;
> +			bool dying;
> +		};
> +		struct {
> +			struct mem_cgroup *memcg;
> +			struct list_head children_node;
> +			struct list_head kmem_caches_node;
> +			struct percpu_ref refcnt;
> +
> +			void (*work_fn)(struct kmem_cache *);
> +			union {
> +				struct rcu_head rcu_head;
> +				struct work_struct work;
> +			};
> +		};
> +	};
> +};
>  #endif /* CONFIG_SLOB */
>  
>  #ifdef CONFIG_SLAB
> -- 
> 2.18.1

-- 
Michal Hocko
SUSE Labs

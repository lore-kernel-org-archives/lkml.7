Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5452C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAF621850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563517257;
	bh=tKNmhCXir7BMYQTFAEzn0aVjlDHd3zhgOrSFbib2k54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xLYoaDM51GCkItr+12DUCNdvFh8TpzwaaLMyvF5MHo0x02ZTAcvQx3Typhb/2uK8D
	 pSJ4edsIXmg5D22Fk29eMLm+IaO/HM/fhyZ54yyS5YfDYmHBcE4UArbW0Twh2gFAIC
	 jW2cH8DB+W2vvXMLbuIIWu9tpyA+8osQDYyelBsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGSGU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:20:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:33242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfGSGUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:20:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0133AEAE;
        Fri, 19 Jul 2019 06:20:53 +0000 (UTC)
Date:   Fri, 19 Jul 2019 08:20:52 +0200
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
Subject: Re: [PATCH v2 1/2] mm, slab: Extend slab/shrink to shrink all memcg
 caches
Message-ID: <20190719062052.GK30461@dhcp22.suse.cz>
References: <20190717202413.13237-1-longman@redhat.com>
 <20190717202413.13237-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717202413.13237-2-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-07-19 16:24:12, Waiman Long wrote:
> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> file to shrink the slab by flushing out all the per-cpu slabs and free
> slabs in partial lists. This can be useful to squeeze out a bit more memory
> under extreme condition as well as making the active object counts in
> /proc/slabinfo more accurate.
> 
> This usually applies only to the root caches, as the SLUB_MEMCG_SYSFS_ON
> option is usually not enabled and "slub_memcg_sysfs=1" not set. Even
> if memcg sysfs is turned on, it is too cumbersome and impractical to
> manage all those per-memcg sysfs files in a real production system.
> 
> So there is no practical way to shrink memcg caches.  Fix this by
> enabling a proper write to the shrink sysfs file of the root cache
> to scan all the available memcg caches and shrink them as well. For a
> non-root memcg cache (when SLUB_MEMCG_SYSFS_ON or slub_memcg_sysfs is
> on), only that cache will be shrunk when written.

I would mention that memcg unawareness was an overlook more than
anything else. The interface is intended to shrink all pcp data of the
cache. The fact that we are using per-memcg internal caches is an
implementation detail.

> On a 2-socket 64-core 256-thread arm64 system with 64k page after
> a parallel kernel build, the the amount of memory occupied by slabs
> before shrinking slabs were:
> 
>  # grep task_struct /proc/slabinfo
>  task_struct        53137  53192   4288   61    4 : tunables    0    0
>  0 : slabdata    872    872      0
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            3936832 kB
>  SReclaimable:     399104 kB
>  SUnreclaim:      3537728 kB
> 
> After shrinking slabs:
> 
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            1356288 kB
>  SReclaimable:     263296 kB
>  SUnreclaim:      1092992 kB
>  # grep task_struct /proc/slabinfo
>  task_struct         2764   6832   4288   61    4 : tunables    0    0
>  0 : slabdata    112    112      0

Now that you are touching the documentation I would just add a note that
shrinking might be expensive and block other slab operations so it
should be used with some care.

> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Roman Gushchin <guro@fb.com>

The patch looks good to me. I do not feel qualified to give my ack but
it is definitely a change in the good direction.

Let's just be careful recommending people to use this as a workaround to
over caching and resulting tilted stats. That needs to be addressed
separately.

Thanks!

> ---
>  Documentation/ABI/testing/sysfs-kernel-slab | 12 ++++---
>  mm/slab.h                                   |  1 +
>  mm/slab_common.c                            | 37 +++++++++++++++++++++
>  mm/slub.c                                   |  2 +-
>  4 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
> index 29601d93a1c2..94ffd47fc8d7 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-slab
> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> @@ -429,10 +429,14 @@ KernelVersion:	2.6.22
>  Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
>  		Christoph Lameter <cl@linux-foundation.org>
>  Description:
> -		The shrink file is written when memory should be reclaimed from
> -		a cache.  Empty partial slabs are freed and the partial list is
> -		sorted so the slabs with the fewest available objects are used
> -		first.
> +		The shrink file is used to enable some unused slab cache
> +		memory to be reclaimed from a cache.  Empty per-cpu
> +		or partial slabs are freed and the partial list is
> +		sorted so the slabs with the fewest available objects
> +		are used first.  It only accepts a value of "1" on
> +		write for shrinking the cache. Other input values are
> +		considered invalid.  If it is a root cache, all the
> +		child memcg caches will also be shrunk, if available.
>  
>  What:		/sys/kernel/slab/cache/slab_size
>  Date:		May 2007
> diff --git a/mm/slab.h b/mm/slab.h
> index 9057b8056b07..5bf615cb3f99 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -174,6 +174,7 @@ int __kmem_cache_shrink(struct kmem_cache *);
>  void __kmemcg_cache_deactivate(struct kmem_cache *s);
>  void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
>  void slab_kmem_cache_release(struct kmem_cache *);
> +void kmem_cache_shrink_all(struct kmem_cache *s);
>  
>  struct seq_file;
>  struct file;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 807490fe217a..6491c3a41805 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -981,6 +981,43 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
>  }
>  EXPORT_SYMBOL(kmem_cache_shrink);
>  
> +/**
> + * kmem_cache_shrink_all - shrink a cache and all memcg caches for root cache
> + * @s: The cache pointer
> + */
> +void kmem_cache_shrink_all(struct kmem_cache *s)
> +{
> +	struct kmem_cache *c;
> +
> +	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || !is_root_cache(s)) {
> +		kmem_cache_shrink(s);
> +		return;
> +	}
> +
> +	get_online_cpus();
> +	get_online_mems();
> +	kasan_cache_shrink(s);
> +	__kmem_cache_shrink(s);
> +
> +	/*
> +	 * We have to take the slab_mutex to protect from the memcg list
> +	 * modification.
> +	 */
> +	mutex_lock(&slab_mutex);
> +	for_each_memcg_cache(c, s) {
> +		/*
> +		 * Don't need to shrink deactivated memcg caches.
> +		 */
> +		if (s->flags & SLAB_DEACTIVATED)
> +			continue;
> +		kasan_cache_shrink(c);
> +		__kmem_cache_shrink(c);
> +	}
> +	mutex_unlock(&slab_mutex);
> +	put_online_mems();
> +	put_online_cpus();
> +}
> +
>  bool slab_is_available(void)
>  {
>  	return slab_state >= UP;
> diff --git a/mm/slub.c b/mm/slub.c
> index e6c030e47364..9736eb10dcb8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5294,7 +5294,7 @@ static ssize_t shrink_store(struct kmem_cache *s,
>  			const char *buf, size_t length)
>  {
>  	if (buf[0] == '1')
> -		kmem_cache_shrink(s);
> +		kmem_cache_shrink_all(s);
>  	else
>  		return -EINVAL;
>  	return length;
> -- 
> 2.18.1

-- 
Michal Hocko
SUSE Labs

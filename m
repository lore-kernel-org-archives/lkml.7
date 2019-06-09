Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A41BC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC49020840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqucCPXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfFIObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 10:31:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42814 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfFIObi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 10:31:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so4842908lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YgVgjJRZpCz9nTLBwfFgFqqvq2EsxYLpfjzYfKQFnJ4=;
        b=EqucCPXTtVHpMwCdI7LAxvowLp5hWcDsEi0LmmDP0/Tg5JdSC+jX2b4qg5fGYOpeAa
         TlMjuC9nzjAn4g2NvmPQ6mhM56YfhtgQFd31zrd2+7j9KF8ZKAhgW2fox9lKi+t75hmn
         d52jseicKOibzH2X/U5xUybKuWrB4xCw+Negyd7DtUDuT5jyQMNI1ZvjQ3YueTzzcZ6P
         mUKlDMtLzaRvpi7gI3b+0qM2o4a7BJl0sCPGJd1tQVJwTff2XIy/+O888vvCe/7uZiJF
         6GJbyqfV47jYV3e6t1Xkl0b9+88NHJbily2qMgf4xQav9vtriI1GwOmj75h7cZYiPobs
         Rpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YgVgjJRZpCz9nTLBwfFgFqqvq2EsxYLpfjzYfKQFnJ4=;
        b=iFDeAn3/q8hqSeRiTnLL7jNWQEwYHdlQDcBronVgdOdhc2Az75ILAOGbRT8oqV+Qrv
         OCBdFCRDfhctWAYrsTFnFRvYEEaaUeVPyaql7/pFPwntw8W81ATr3sbTWz8FUjc7dFnv
         x+vkTJW6nn1dZnFjFvhtRdzPZZcSEji2f8VcNH34B67z4zFVcRlgKrL8NKy8pdlf9MIs
         kQxGY+kyWVDpdBsPo4E5/aMF7AFHtxYJ5I1jRl20CeLtIUn44IlBS3kFCCsdvp0H5Dff
         2g3v4rMKYU3IhcJ0ibIIdzpjyzWXy5rP6E11g+ywxZNAdTXP3BLUQNrUiEch0/ZFPloI
         Rdug==
X-Gm-Message-State: APjAAAXmHpoMaulpoiOW2wtCG4acvBt817gmlO5Ccb1tOcofEhJzT7Dy
        YBbFoulBE/Q+acFEDQ8cuSae1dcmegs=
X-Google-Smtp-Source: APXvYqyDJ0YYG87q+UXcO9Am1kPS6on/zrzIe7zNYQwBx1bx6kaIYrPPGTw8xhaSY2e3rT2oZh7HlQ==
X-Received: by 2002:ac2:558a:: with SMTP id v10mr33038430lfg.41.1560090695584;
        Sun, 09 Jun 2019 07:31:35 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id i188sm1388832lji.4.2019.06.09.07.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 07:31:34 -0700 (PDT)
Date:   Sun, 9 Jun 2019 17:31:32 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 07/10] mm: synchronize access to kmem_cache dying flag
 using a spinlock
Message-ID: <20190609143132.cv7b4w5caghuhi53@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-8-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-8-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:51PM -0700, Roman Gushchin wrote:
> Currently the memcg_params.dying flag and the corresponding
> workqueue used for the asynchronous deactivation of kmem_caches
> is synchronized using the slab_mutex.
> 
> It makes impossible to check this flag from the irq context,
> which will be required in order to implement asynchronous release
> of kmem_caches.
> 
> So let's switch over to the irq-save flavor of the spinlock-based
> synchronization.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/slab_common.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 09b26673b63f..2914a8f0aa85 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -130,6 +130,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
>  #ifdef CONFIG_MEMCG_KMEM
>  
>  LIST_HEAD(slab_root_caches);
> +static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
>  
>  void slab_init_memcg_params(struct kmem_cache *s)
>  {
> @@ -629,6 +630,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
>  	struct memcg_cache_array *arr;
>  	struct kmem_cache *s = NULL;
>  	char *cache_name;
> +	bool dying;
>  	int idx;
>  
>  	get_online_cpus();
> @@ -640,7 +642,13 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
>  	 * The memory cgroup could have been offlined while the cache
>  	 * creation work was pending.
>  	 */
> -	if (memcg->kmem_state != KMEM_ONLINE || root_cache->memcg_params.dying)
> +	if (memcg->kmem_state != KMEM_ONLINE)
> +		goto out_unlock;
> +
> +	spin_lock_irq(&memcg_kmem_wq_lock);
> +	dying = root_cache->memcg_params.dying;
> +	spin_unlock_irq(&memcg_kmem_wq_lock);
> +	if (dying)
>  		goto out_unlock;

I do understand why we need to sync setting dying flag for a kmem cache
about to be destroyed in flush_memcg_workqueue vs checking the flag in
kmemcg_cache_deactivate: this is needed so that we don't schedule a new
deactivation work after we flush RCU/workqueue. However, I don't think
it's necessary to check the dying flag here, in memcg_create_kmem_cache:
we can't schedule a new cache creation work after kmem_cache_destroy has
started, because one mustn't allocate from a dead kmem cache; since we
flush the queue before getting to actual destruction, no cache creation
work can be pending. Yeah, it might happen that a cache creation work
starts execution while flush_memcg_workqueue is in progress, but I don't
see any point in optimizing this case - after all, cache destruction is
a very cold path. Since checking the flag in memcg_create_kmem_cache
raises question, I suggest to simply drop this check.

Anyway, it would be nice to see some comment in the code explaining why
we check dying flag under a spin lock in kmemcg_cache_deactivate.

>  
>  	idx = memcg_cache_id(memcg);
> @@ -735,14 +743,17 @@ static void kmemcg_cache_deactivate(struct kmem_cache *s)
>  
>  	__kmemcg_cache_deactivate(s);
>  
> +	spin_lock_irq(&memcg_kmem_wq_lock);
>  	if (s->memcg_params.root_cache->memcg_params.dying)
> -		return;
> +		goto unlock;
>  
>  	/* pin memcg so that @s doesn't get destroyed in the middle */
>  	css_get(&s->memcg_params.memcg->css);
>  
>  	s->memcg_params.work_fn = __kmemcg_cache_deactivate_after_rcu;
>  	call_rcu(&s->memcg_params.rcu_head, kmemcg_rcufn);
> +unlock:
> +	spin_unlock_irq(&memcg_kmem_wq_lock);
>  }
>  
>  void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
> @@ -852,9 +863,9 @@ static int shutdown_memcg_caches(struct kmem_cache *s)
>  
>  static void flush_memcg_workqueue(struct kmem_cache *s)
>  {
> -	mutex_lock(&slab_mutex);
> +	spin_lock_irq(&memcg_kmem_wq_lock);
>  	s->memcg_params.dying = true;
> -	mutex_unlock(&slab_mutex);
> +	spin_unlock_irq(&memcg_kmem_wq_lock);
>  
>  	/*
>  	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make

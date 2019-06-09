Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88987C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D872067C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD6vUOey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfFIRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:18:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33109 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbfFIRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:18:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id v29so5858687ljv.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ACJ30A/Mvxipzw9s6ZSrzImQxdOVyc9S1cfXlCbiESk=;
        b=nD6vUOeyAeSqCFxG3FLOQ9sFcOVhkFlKok1Jbq9mtVpnkNftXLLZC4JimBJFEnBCBi
         dtN3r5gTyxfQ7zSuT4H26gAZkPn6N2UmG6/qQy134Tuqy+jc2cI1wHSB0K79P+GHsLP/
         MeIEquWhKYto4c5dDtF8Wduuzob3Nugv9F31IxmDUn9zfZCsNp6I/mG7ZaUWbQG5DZpk
         yN4ECnumY7bmL6uNLh1eVBW6NAujJQd38azs2LUaFypv30RvmTTkZutdQvBEhcM0GEM/
         C4O9z64oiUcm6ve/3WoqLC+cCd4Sbya5dfeqHKSPe/uZcdQXEO3uUB+slMCvagy4r3Bp
         UwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ACJ30A/Mvxipzw9s6ZSrzImQxdOVyc9S1cfXlCbiESk=;
        b=nc7o5npXOltpiT374+bUtPLLw9lNNvn2kHaQzN/FXGFznDHwOMzSi4bik7pc7TIEkI
         0OXIgtb5Xv35dG0IbtVS5uNlhLzQq+L945z8jTU2Tbl/r/OcbNHhcRA+eTWkxxi8a031
         +/rCqRNYX00HTH982vTsxAY2gZ0Dbqhax5GvWrqbI5BzeSp/EwlK8I3O6KaKCL0MlmOb
         qSzEHuF/SyZR3mMyb8myVrYm7z136K2eX3QVzkqjTi2iXrw0CKShMGj47ZrgJPjF3lYe
         8fqBtcHAtseiKnuCRyZcOT/HrcdT7h7htNLuhfLES9XszuVfAbSJV/Hg6/cqKJ+TaRAe
         w46w==
X-Gm-Message-State: APjAAAUAEHYH/K0dujKCUSoOJfAFExXkcT4z5QYvgI6olG0r3GmwXsZh
        I/AGiKyswT02WJQX0evrS70=
X-Google-Smtp-Source: APXvYqwHJgO8n/Blo45Dnzb9QlBUFOUwnxND/C+LAJb8RiNCNuRGyssMmUxAvrOkQSc4+GXV8eXY7A==
X-Received: by 2002:a2e:9654:: with SMTP id z20mr7213303ljh.52.1560100714163;
        Sun, 09 Jun 2019 10:18:34 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id c8sm1473675ljk.77.2019.06.09.10.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 10:18:33 -0700 (PDT)
Date:   Sun, 9 Jun 2019 20:18:31 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 10/10] mm: reparent slab memory on cgroup removal
Message-ID: <20190609171831.er3wdlmnkhwptqzr@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-11-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-11-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:54PM -0700, Roman Gushchin wrote:
> Let's reparent memcg slab memory on memcg offlining. This allows us
> to release the memory cgroup without waiting for the last outstanding
> kernel object (e.g. dentry used by another application).
> 
> So instead of reparenting all accounted slab pages, let's do reparent
> a relatively small amount of kmem_caches. Reparenting is performed as
> a part of the deactivation process.
> 
> Since the parent cgroup is already charged, everything we need to do
> is to splice the list of kmem_caches to the parent's kmem_caches list,
> swap the memcg pointer and drop the css refcounter for each kmem_cache
> and adjust the parent's css refcounter. Quite simple.
> 
> Please, note that kmem_cache->memcg_params.memcg isn't a stable
> pointer anymore. It's safe to read it under rcu_read_lock() or
> with slab_mutex held.
> 
> We can race with the slab allocation and deallocation paths. It's not
> a big problem: parent's charge and slab global stats are always
> correct, and we don't care anymore about the child usage and global
> stats. The child cgroup is already offline, so we don't use or show it
> anywhere.
> 
> Local slab stats (NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE)
> aren't used anywhere except count_shadow_nodes(). But even there it
> won't break anything: after reparenting "nodes" will be 0 on child
> level (because we're already reparenting shrinker lists), and on
> parent level page stats always were 0, and this patch won't change
> anything.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/slab.h |  4 ++--
>  mm/list_lru.c        |  8 +++++++-
>  mm/memcontrol.c      | 14 ++++++++------
>  mm/slab.h            | 23 +++++++++++++++++------
>  mm/slab_common.c     | 22 +++++++++++++++++++---
>  5 files changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 1b54e5f83342..109cab2ad9b4 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -152,7 +152,7 @@ void kmem_cache_destroy(struct kmem_cache *);
>  int kmem_cache_shrink(struct kmem_cache *);
>  
>  void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
> -void memcg_deactivate_kmem_caches(struct mem_cgroup *);
> +void memcg_deactivate_kmem_caches(struct mem_cgroup *, struct mem_cgroup *);
>  
>  /*
>   * Please use this macro to create slab caches. Simply specify the
> @@ -638,7 +638,7 @@ struct memcg_cache_params {
>  			bool dying;
>  		};
>  		struct {
> -			struct mem_cgroup *memcg;
> +			struct mem_cgroup __rcu *memcg;
>  			struct list_head children_node;
>  			struct list_head kmem_caches_node;
>  			struct percpu_ref refcnt;
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0f1f6b06b7f3..0b2319897e86 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -77,11 +77,15 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
>  	if (!nlru->memcg_lrus)
>  		goto out;
>  
> +	rcu_read_lock();
>  	memcg = mem_cgroup_from_kmem(ptr);
> -	if (!memcg)
> +	if (!memcg) {
> +		rcu_read_unlock();
>  		goto out;
> +	}
>  
>  	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
> +	rcu_read_unlock();
>  out:
>  	if (memcg_ptr)
>  		*memcg_ptr = memcg;
> @@ -131,12 +135,14 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
>  
>  	spin_lock(&nlru->lock);
>  	if (list_empty(item)) {
> +		rcu_read_lock();
>  		l = list_lru_from_kmem(nlru, item, &memcg);
>  		list_add_tail(item, &l->list);
>  		/* Set shrinker bit if the first element was added */
>  		if (!l->nr_items++)
>  			memcg_set_shrinker_bit(memcg, nid,
>  					       lru_shrinker_id(lru));
> +		rcu_read_unlock();

AFAICS we don't need rcu_read_lock here, because holding nlru->lock
guarantees that the cgroup doesn't get freed. If that's correct,
I think we better remove __rcu mark and use READ_ONCE for accessing
memcg_params.memcg, thus making it the caller's responsibility to
ensure the cgroup lifetime.

>  		nlru->nr_items++;
>  		spin_unlock(&nlru->lock);
>  		return true;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c097b1fc74ec..0f64a2c06803 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3209,15 +3209,15 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  	 */
>  	memcg->kmem_state = KMEM_ALLOCATED;
>  
> -	memcg_deactivate_kmem_caches(memcg);
> -
> -	kmemcg_id = memcg->kmemcg_id;
> -	BUG_ON(kmemcg_id < 0);
> -
>  	parent = parent_mem_cgroup(memcg);
>  	if (!parent)
>  		parent = root_mem_cgroup;
>  
> +	memcg_deactivate_kmem_caches(memcg, parent);
> +
> +	kmemcg_id = memcg->kmemcg_id;
> +	BUG_ON(kmemcg_id < 0);
> +
>  	/*
>  	 * Change kmemcg_id of this cgroup and all its descendants to the
>  	 * parent's id, and then move all entries from this cgroup's list_lrus
> @@ -3250,7 +3250,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
>  	if (memcg->kmem_state == KMEM_ALLOCATED) {
>  		WARN_ON(!list_empty(&memcg->kmem_caches));
>  		static_branch_dec(&memcg_kmem_enabled_key);
> -		WARN_ON(page_counter_read(&memcg->kmem));
>  	}
>  }
>  #else
> @@ -4675,6 +4674,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  
>  	/* The following stuff does not apply to the root */
>  	if (!parent) {
> +#ifdef CONFIG_MEMCG_KMEM
> +		INIT_LIST_HEAD(&memcg->kmem_caches);
> +#endif
>  		root_mem_cgroup = memcg;
>  		return &memcg->css;
>  	}
> diff --git a/mm/slab.h b/mm/slab.h
> index 7ead47cb9338..34bf92382ecd 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -268,7 +268,7 @@ static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
>  
>  	s = READ_ONCE(page->slab_cache);
>  	if (s && !is_root_cache(s))
> -		return s->memcg_params.memcg;
> +		return rcu_dereference(s->memcg_params.memcg);

I guess it's worth updating the comment with a few words re cgroup
lifetime.

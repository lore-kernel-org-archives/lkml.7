Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD599CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852ED20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="W6mDXNKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfJaOX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:23:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46439 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:23:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so8725382qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLOU6ePFccXyEuBHG4PNLtLJtKn8AMkpv4HM9M+LfdU=;
        b=W6mDXNKJBqe2HOzcfaHy9ooL991M5CXkZB/TIKvQWAPEYTUcXStO5Q4gm3cQJT85rq
         MCCtNkPWdSfHflqRQBRzJKQEkmLYYZ8uKUAZXBlYiOjcqNmaqrjW+J7EFaorkQkU+X5n
         MV/6z+elkXCveAHRHBHj1XC39/tj/ceum0ijhQU+wFu27bNpBUNNUVZtm6seO+5BrFW1
         tATEol+YxtLlokwz6LmJa6SueAavL27f3EVdajcvHrPUB8eAdAXHU5yCAo/AF+8sNVIY
         bkw2IorrUDSQcA0troIrIX/sgzm9nXnpIvYg8wsCO8GLWMf/pvL4ZQ3O9oldk/h0slzm
         ZWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLOU6ePFccXyEuBHG4PNLtLJtKn8AMkpv4HM9M+LfdU=;
        b=IF57MkUfTf0w89bOow0Ff5GrUrFmw3JLeKnWZTc/RaW7VlbBOcJjYBcwMy0BF7zpOC
         2aKKjBJ4/hQRkNv1cxkEY6pO/Pku1yNaYfMCw3a38/CLHpYbTylYZtLug0vJ/Ei6yI56
         g5X+F9PYTgBcEqEoNq4NrEl335cLk7E3p2cp2sEgZrQ+RW4QrFgW/FxjQ5eT7udolrjd
         /gzQILcRf6+txl4iVzDNVkXZaOkajKCMtoJds6EiMkkw3zc1PbTfAfdOz7YjzjZ5Afe2
         SeOc0xtEGXefA9HQ2I/DyX63Fa9qrVsHZKEjEvs0QzSfU+fyhKsm4nODAcDHGbQS1FPA
         K1Dg==
X-Gm-Message-State: APjAAAUQqSdUHD/vRsz+SeoiNHe0vacQuxRSwe5T5GhVAy7Sj3uIlrRz
        AIHMXu1WHs0LLyf03CzAfQ4meQ==
X-Google-Smtp-Source: APXvYqz8FZBzf3vZYdhMcQST/0nMcqCCkqweYS4Ks+EKZS5WyOlLjagms1uxjmMug/3FqHNO5bkGgg==
X-Received: by 2002:ac8:5445:: with SMTP id d5mr963193qtq.19.1572531805547;
        Thu, 31 Oct 2019 07:23:25 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id q204sm2282295qke.39.2019.10.31.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 07:23:24 -0700 (PDT)
Date:   Thu, 31 Oct 2019 10:23:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 09/16] mm: memcg/slab: charge individual slab objects
 instead of pages
Message-ID: <20191031142323.GA1168@cmpxchg.org>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com>
 <20191025194118.GA393641@cmpxchg.org>
 <20191031015238.GA21323@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031015238.GA21323@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:52:44AM +0000, Roman Gushchin wrote:
> On Fri, Oct 25, 2019 at 03:41:18PM -0400, Johannes Weiner wrote:
> > On Thu, Oct 17, 2019 at 05:28:13PM -0700, Roman Gushchin wrote:
> > > +static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> > > +						struct mem_cgroup **memcgp,
> > > +						size_t size, gfp_t flags)
> > > +{
> > > +	struct kmem_cache *cachep;
> > > +
> > > +	cachep = memcg_kmem_get_cache(s, memcgp);
> > > +	if (is_root_cache(cachep))
> > > +		return s;
> > > +
> > > +	if (__memcg_kmem_charge_subpage(*memcgp, size * s->size, flags)) {
> > > +		mem_cgroup_put(*memcgp);
> > > +		memcg_kmem_put_cache(cachep);
> > > +		cachep = NULL;
> > > +	}
> > > +
> > > +	return cachep;
> > > +}
> > > +
> > >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > >  					      struct mem_cgroup *memcg,
> > >  					      size_t size, void **p)
> > >  {
> > >  	struct mem_cgroup_ptr *memcg_ptr;
> > > +	struct lruvec *lruvec;
> > >  	struct page *page;
> > >  	unsigned long off;
> > >  	size_t i;
> > > @@ -439,6 +393,11 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > >  			off = obj_to_index(s, page, p[i]);
> > >  			mem_cgroup_ptr_get(memcg_ptr);
> > >  			page->mem_cgroup_vec[off] = memcg_ptr;
> > > +			lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> > > +			mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s),
> > > +					       s->size);
> > > +		} else {
> > > +			__memcg_kmem_uncharge_subpage(memcg, s->size);
> > >  		}
> > >  	}
> > >  	mem_cgroup_ptr_put(memcg_ptr);
> > 
> > The memcg_ptr as a collection vessel for object references makes a lot
> > of sense. But this code showcases that it should be a first-class
> > memory tracking API that the allocator interacts with, rather than
> > having to deal with a combination of memcg_ptr and memcg.
> > 
> > In the two hunks here, on one hand we charge bytes to the memcg
> > object, and then handle all the refcounting through a different
> > bucketing object. To support that in the first place, we have to
> > overload the memcg API all the way down to try_charge() to support
> > bytes and pages. This is difficult to follow throughout all layers.
> > 
> > What would be better is for this to be an abstraction layer for a
> > subpage object tracker that sits on top of the memcg page tracker -
> > not unlike the page allocator and the slab allocators themselves.
> > 
> > And then the slab allocator would only interact with the subpage
> > object tracker, and the object tracker would deal with the memcg page
> > tracker under the hood.
> 
> Hello, Johannes!
> 
> After some thoughts and coding I don't think it's a right direction to go.
> Under direction I mean building the new subpage/obj_cgroup API on top
> of the intact existing memcg API.
> Let me illustrate my point on the code you provided (please, look below).
> 
> > 
> > Something like the below, just a rough sketch to convey the idea:
> > 
> > On allocation, we look up an obj_cgroup from the current task, charge
> > it with obj_cgroup_charge() and bump its refcount by the number of
> > objects we allocated. obj_cgroup_charge() in turn uses the memcg layer
> > to charge pages, and then doles them out as bytes using
> > objcg->nr_stocked_bytes and the byte per-cpu stock.
> > 
> > On freeing, we call obj_cgroup_uncharge() and drop the references. In
> > turn, this first refills the byte per-cpu stock and drains the
> > overflow to the memcg layer (which in turn refills its own page stock
> > and drains to the page_counter).
> > 
> > On cgroup deletion, we reassign the obj_cgroup to the parent, and all
> > remaining live objects will free their pages to the updated parental
> > obj_cgroup->memcg, as per usual.
> > 
> > ---
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f36203cf75f8..efc3398aaf02 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -200,15 +200,15 @@ struct memcg_cgwb_frn {
> >  };
> >  
> >  /*
> > - * A pointer to a memory cgroup with a built-in reference counter.
> > - * For a use as an intermediate object to simplify reparenting of
> > - * objects charged to the cgroup. The memcg pointer can be switched
> > - * to the parent cgroup without a need to modify all objects
> > - * which hold the reference to the cgroup.
> > + * Bucket for arbitrarily byte-sized objects charged to a memory
> > + * cgroup. The bucket can be reparented in one piece when the cgroup
> > + * is destroyed, without having to round up the individual references
> > + * of all live memory objects in the wild.
> >   */
> > -struct mem_cgroup_ptr {
> > -	struct percpu_ref refcnt;
> > +struct obj_cgroup {
> > +	struct percpu_ref count;
> >  	struct mem_cgroup *memcg;
> > +	unsigned long nr_stocked_bytes;
> >  	union {
> >  		struct list_head list;
> >  		struct rcu_head rcu;
> > @@ -230,7 +230,6 @@ struct mem_cgroup {
> >  	/* Accounted resources */
> >  	struct page_counter memory;
> >  	struct page_counter swap;
> > -	atomic_t nr_stocked_bytes;
> >  
> >  	/* Legacy consumer-oriented counters */
> >  	struct page_counter memsw;
> > @@ -327,8 +326,8 @@ struct mem_cgroup {
> >          /* Index in the kmem_cache->memcg_params.memcg_caches array */
> >  	int kmemcg_id;
> >  	enum memcg_kmem_state kmem_state;
> > -	struct mem_cgroup_ptr __rcu *kmem_memcg_ptr;
> > -	struct list_head kmem_memcg_ptr_list;
> > +	struct obj_cgroup __rcu *slab_objs;
> > +	struct list_head slab_objs_list;
> >  #endif
> >  
> >  	int last_scanned_node;
> > @@ -474,21 +473,6 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
> >  	return css ? container_of(css, struct mem_cgroup, css) : NULL;
> >  }
> >  
> > -static inline bool mem_cgroup_ptr_tryget(struct mem_cgroup_ptr *ptr)
> > -{
> > -	return percpu_ref_tryget(&ptr->refcnt);
> > -}
> > -
> > -static inline void mem_cgroup_ptr_get(struct mem_cgroup_ptr *ptr)
> > -{
> > -	percpu_ref_get(&ptr->refcnt);
> > -}
> > -
> > -static inline void mem_cgroup_ptr_put(struct mem_cgroup_ptr *ptr)
> > -{
> > -	percpu_ref_put(&ptr->refcnt);
> > -}
> > -
> >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> >  {
> >  	if (memcg)
> > @@ -1444,9 +1428,9 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
> >  			      struct mem_cgroup *memcg);
> >  void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
> >  				 unsigned int nr_pages);
> > -int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
> > +int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size,
> >  				gfp_t gfp);
> > -void __memcg_kmem_uncharge_subpage(struct mem_cgroup *memcg, size_t size);
> > +void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
> >  
> >  extern struct static_key_false memcg_kmem_enabled_key;
> >  extern struct workqueue_struct *memcg_kmem_cache_wq;
> > @@ -1513,20 +1497,20 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
> >  	return memcg ? memcg->kmemcg_id : -1;
> >  }
> >  
> > -static inline struct mem_cgroup_ptr *
> > -mem_cgroup_get_kmem_ptr(struct mem_cgroup *memcg)
> > +static inline struct obj_cgroup *
> > +mem_cgroup_get_slab_objs(struct mem_cgroup *memcg)
> >  {
> > -	struct mem_cgroup_ptr *memcg_ptr;
> > +	struct obj_cgroup *objcg;
> >  
> >  	rcu_read_lock();
> >  	do {
> > -		memcg_ptr = rcu_dereference(memcg->kmem_memcg_ptr);
> > -		if (memcg_ptr && mem_cgroup_ptr_tryget(memcg_ptr))
> > +		objcg = rcu_dereference(memcg->slab_objs);
> > +		if (objcg && percpu_ref_tryget(&objcg->count))
> >  			break;
> >  	} while ((memcg = parent_mem_cgroup(memcg)));
> >  	rcu_read_unlock();
> >  
> > -	return memcg_ptr;
> > +	return objcg;
> >  }
> >  
> >  #else
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 4d99ee5a9c53..7f663fd53c17 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -200,7 +200,7 @@ struct page {
> >  #ifdef CONFIG_MEMCG
> >  	union {
> >  		struct mem_cgroup *mem_cgroup;
> > -		struct mem_cgroup_ptr **mem_cgroup_vec;
> > +		struct obj_cgroup **obj_cgroups;
> >  	};
> >  #endif
> >  
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index b0d0c833150c..47110f4f0f4c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -260,52 +260,51 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
> >  #ifdef CONFIG_MEMCG_KMEM
> >  extern spinlock_t css_set_lock;
> >  
> > -static void memcg_ptr_release(struct percpu_ref *ref)
> > +static void obj_cgroup_release(struct percpu_ref *ref)
> >  {
> > -	struct mem_cgroup_ptr *ptr = container_of(ref, struct mem_cgroup_ptr,
> > -						  refcnt);
> > +	struct obj_cgroup *objcg;
> >  	unsigned long flags;
> >  
> > +	objcg = container_of(ref, struct obj_cgroup, count);
> > +
> >  	spin_lock_irqsave(&css_set_lock, flags);
> > -	list_del(&ptr->list);
> > +	list_del(&objcg->list);
> >  	spin_unlock_irqrestore(&css_set_lock, flags);
> >  
> > -	mem_cgroup_put(ptr->memcg);
> > +	mem_cgroup_put(objcg->memcg);
> >  	percpu_ref_exit(ref);
> > -	kfree_rcu(ptr, rcu);
> > +	kfree_rcu(objcg, rcu);
> >  }
> 
> Btw, the part below is looking good, thanks for the idea!
> 
> >  
> > -static int memcg_init_kmem_memcg_ptr(struct mem_cgroup *memcg)
> > +static int obj_cgroup_alloc(struct mem_cgroup *memcg)
> >  {
> > -	struct mem_cgroup_ptr *kmem_memcg_ptr;
> > +	struct obj_cgroup *objcg;
> >  	int ret;
> >  
> > -	kmem_memcg_ptr = kmalloc(sizeof(struct mem_cgroup_ptr), GFP_KERNEL);
> > -	if (!kmem_memcg_ptr)
> > +	objcg = kmalloc(sizeof(struct obj_cgroup), GFP_KERNEL);
> > +	if (!objcg)
> >  		return -ENOMEM;
> >  
> > -	ret = percpu_ref_init(&kmem_memcg_ptr->refcnt, memcg_ptr_release,
> > +	ret = percpu_ref_init(&objcg->count, obj_cgroup_release,
> >  			      0, GFP_KERNEL);
> >  	if (ret) {
> > -		kfree(kmem_memcg_ptr);
> > +		kfree(objcg);
> >  		return ret;
> >  	}
> >  
> > -	kmem_memcg_ptr->memcg = memcg;
> > -	INIT_LIST_HEAD(&kmem_memcg_ptr->list);
> > -	rcu_assign_pointer(memcg->kmem_memcg_ptr, kmem_memcg_ptr);
> > -	list_add(&kmem_memcg_ptr->list, &memcg->kmem_memcg_ptr_list);
> > +	INIT_LIST_HEAD(&objcg->list);
> > +	objcg->memcg = memcg;
> >  	return 0;
> >  }
> >  
> 
> < cut >
> 
> > @@ -3117,15 +3095,24 @@ void __memcg_kmem_uncharge(struct page *page, int order)
> >  	css_put_many(&memcg->css, nr_pages);
> >  }
> >  
> > -int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
> > -				gfp_t gfp)
> > +int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size, gfp_t gfp)
> >  {
> > -	return try_charge(memcg, gfp, size, true);
> > +	int ret;
> > +
> > +	if (consume_obj_stock(objcg, nr_bytes))
> > +		return 0;
> > +
> > +	ret = try_charge(objcg->memcg, gfp, 1);
> > +	if (ret)
> > +		return ret;
> 
> So, the first problem is here: try_charge() will bump the memcg reference.
> It works for generic pages, where we set the mem_cgroup pointer, so that
> the reference corresponds to the actual physical page.
> But in this case, the actual page is shared between multiple cgroups.
> Memcg will be basically referenced once for each stock cache miss.
> I struggle to understand what does it mean and how to balance it
> with unreferencing on the free path.

The charge functions make refcounting assumptions they shouldn't
make. That's a sign that we need to fix the refcounting, not work
around it in the upper layers.

We need the following patch for the new slab controller. It's an
overdue cleanup, too.

---
From 10bfa8e3111c65a2fdd2156547fe645c23847fa6 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 31 Oct 2019 07:04:23 -0400
Subject: [PATCH] mm: memcontrol: decouple reference counting from page
 accounting

The reference counting of a memcg is currently coupled directly to how
many 4k pages are charged to it. This doesn't work well with Roman's
new slab controller, which maintains pools of objects and doesn't want
to keep an extra balance sheet for the pages backing those objects.

This unusual refcounting design (reference counts usually track
pointers to an object) is only for historical reasons: memcg used to
not take any css references and simply stalled offlining until all
charges had been reparented and the page counters had dropped to
zero. When we got rid of the reparenting requirement, the simple
mechanical translation was to take a reference for every charge.

More historical context can be found in e8ea14cc6ead ("mm: memcontrol:
take a css reference for each charged page"), 64f219938941 ("mm:
memcontrol: remove obsolete kmemcg pinning tricks") and b2052564e66d
("mm: memcontrol: continue cache reclaim from offlined groups").

The new slab controller exposes the limitations in this scheme, so
let's switch it to a more idiomatic reference counting model based on
actual kernel pointers to the memcg:

- The per-cpu stock holds a reference to the memcg its caching

- User pages hold a reference for their page->mem_cgroup. Transparent
  huge pages will no longer acquire tail references in advance, we'll
  get them if needed during the split.

- Kernel pages hold a reference for their page->mem_cgroup

- mem_cgroup_try_charge(), if successful, will return one reference to
  be consumed by page->mem_cgroup during commit, or put during cancel

- Pages allocated in the root cgroup will acquire and release css
  references for simplicity. css_get() and css_put() optimize that.

- The current memcg_charge_slab() already hacked around the per-charge
  references; this change gets rid of that as well.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 45 ++++++++++++++++++++++++++-------------------
 mm/slab.h       |  2 --
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c7e3e758c165..b88c273d6dc0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2190,13 +2190,17 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 {
 	struct mem_cgroup *old = stock->cached;
 
+	if (!old)
+		return;
+
 	if (stock->nr_pages) {
 		page_counter_uncharge(&old->memory, stock->nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&old->memsw, stock->nr_pages);
-		css_put_many(&old->css, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
+
+	css_put(&old->css);
 	stock->cached = NULL;
 }
 
@@ -2232,6 +2236,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
+		css_get(&memcg->css);
 		stock->cached = memcg;
 	}
 	stock->nr_pages += nr_pages;
@@ -2635,12 +2640,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
-	css_get_many(&memcg->css, nr_pages);
 
 	return 0;
 
 done_restock:
-	css_get_many(&memcg->css, batch);
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
 
@@ -2677,8 +2680,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	page_counter_uncharge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
-
-	css_put_many(&memcg->css, nr_pages);
 }
 
 static void lock_page_lru(struct page *page, int *isolated)
@@ -2989,6 +2990,7 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 		if (!ret) {
 			page->mem_cgroup = memcg;
 			__SetPageKmemcg(page);
+			return 0;
 		}
 	}
 	css_put(&memcg->css);
@@ -3026,12 +3028,11 @@ void __memcg_kmem_uncharge(struct page *page, int order)
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge_memcg(memcg, nr_pages);
 	page->mem_cgroup = NULL;
+	css_put(&memcg->css);
 
 	/* slab pages do not have PageKmemcg flag set */
 	if (PageKmemcg(page))
 		__ClearPageKmemcg(page);
-
-	css_put_many(&memcg->css, nr_pages);
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
@@ -3043,15 +3044,18 @@ void __memcg_kmem_uncharge(struct page *page, int order)
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
+	struct mem_cgroup *memcg = head->mem_cgroup;
 	int i;
 
 	if (mem_cgroup_disabled())
 		return;
 
-	for (i = 1; i < HPAGE_PMD_NR; i++)
-		head[i].mem_cgroup = head->mem_cgroup;
+	for (i = 1; i < HPAGE_PMD_NR; i++) {
+		css_get(&memcg->css);
+		head[i].mem_cgroup = memcg;
+	}
 
-	__mod_memcg_state(head->mem_cgroup, MEMCG_RSS_HUGE, -HPAGE_PMD_NR);
+	__mod_memcg_state(memcg, MEMCG_RSS_HUGE, -HPAGE_PMD_NR);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -5485,7 +5489,9 @@ static int mem_cgroup_move_account(struct page *page,
 	 * uncharging, charging, migration, or LRU putback.
 	 */
 
-	/* caller should have done css_get */
+	css_get(&to->css);
+	css_put(&from->css);
+
 	page->mem_cgroup = to;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -6514,8 +6520,10 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
-
-	css_put(&memcg->css);
+	if (ret) {
+		css_put(&memcg->css);
+		memcg = NULL;
+	}
 out:
 	*memcgp = memcg;
 	return ret;
@@ -6611,6 +6619,8 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 		return;
 
 	cancel_charge(memcg, nr_pages);
+
+	css_put(&memcg->css);
 }
 
 struct uncharge_gather {
@@ -6652,9 +6662,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, nr_pages);
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
-
-	if (!mem_cgroup_is_root(ug->memcg))
-		css_put_many(&ug->memcg->css, nr_pages);
 }
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
@@ -6702,6 +6709,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 
 	ug->dummy_page = page;
 	page->mem_cgroup = NULL;
+	css_put(&ug->memcg->css);
 }
 
 static void uncharge_list(struct list_head *page_list)
@@ -6810,8 +6818,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
-	css_get_many(&memcg->css, nr_pages);
 
+	css_get(&memcg->css);
 	commit_charge(newpage, memcg, false);
 
 	local_irq_save(flags);
@@ -7059,8 +7067,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 				     -nr_entries);
 	memcg_check_events(memcg, page);
 
-	if (!mem_cgroup_is_root(memcg))
-		css_put_many(&memcg->css, nr_entries);
+	css_put(&memcg->css);
 }
 
 /**
diff --git a/mm/slab.h b/mm/slab.h
index 2bbecf28688d..9f84298db2d7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -372,9 +372,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
 	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 	mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
 
-	/* transer try_charge() page references to kmem_cache */
 	percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
-	css_put_many(&memcg->css, 1 << order);
 out:
 	css_put(&memcg->css);
 	return ret;
-- 
2.23.0

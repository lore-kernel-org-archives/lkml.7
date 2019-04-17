Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966C2C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE8C218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHp5w1Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfDQXlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:41:15 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46800 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732737AbfDQXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:41:14 -0400
Received: by mail-yw1-f68.google.com with SMTP id v127so126400ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJPmzxmoWhS3EDXGF7dIsedfeSHmmTux1VzuWlnaIWI=;
        b=NHp5w1XbRMVVNridXcbf1o3lFAIXDaZ71/OZu96793CLg0Ttxgi3ojuuum8XF6kZC8
         r4IzGfxzbxrSwSOtPEEfmSqz+rx5wgLmzUJ4qh8N9JRRXsWWjjGaA9PzdxmKVmFvSSN8
         OaI0O/bsXShj9pczchwG+EtQhUt7hHr4ZjIyZdAW2uXaPwsLeQbPKm3d9vGHT0OdqUdW
         PswIdAA02nTYso4bD8zd9KnzZ3YmuNm/ADTtr7glvsoDhz6pJXWJablyrNNzeCAtWi82
         fWV3Qq3HdgVuOuceY4bwB920CX+r8CHM/e9Z9HOw2qQx7DXLdJ4ucx5EJOhnSqFBuL3K
         NE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJPmzxmoWhS3EDXGF7dIsedfeSHmmTux1VzuWlnaIWI=;
        b=l7NRS8iDBaCfnoCQNgjxgxZKOVDxdlo8LsT1A5I5rpdch/6WvEa50f5ZZn+dSZrAP5
         /ie0seIwclY7HA6d341Ukqx3HYo3Ej3s1Ox7RFRdBcDXjQIicSxgkieY15W4XHrXI4Ju
         IQtTGzhRKhOMCIw2q+Oso5O5+MiDyMh5+FQihybmuvwRJmrQOgFhHD1m9iKyXfgjarU5
         +QQo7FdM450BgFvJytyii5U8wXCHb40emxmJpTWSdyC4GNaGYz6Vo6wrqQhxAeH88DIF
         x+unX8Ew73XFqp+qNqOwuG4gcnSmtq9737YaBGfEbqfzJmBHFe5fT8hZ8arhwqvw8Bjp
         uGKA==
X-Gm-Message-State: APjAAAVtZuZDSUNaptF+gIhdnTeTaWVulFBRPpvH+XSMyOiHPsK+r+ia
        lrnOSJ52gPlYEXueTUXmCyAW/xxsPxJN2iE02RjyBQ==
X-Google-Smtp-Source: APXvYqz1ujsFDB6PqY0nLZsnR3+anBFD5rEIK/njuNGRa5yY37dUeNTDMCloR37xl+Z1omJvcoGFvylPYrUhXNKuRrk=
X-Received: by 2002:a81:78c6:: with SMTP id t189mr71276104ywc.27.1555544473056;
 Wed, 17 Apr 2019 16:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190417215434.25897-1-guro@fb.com> <20190417215434.25897-5-guro@fb.com>
In-Reply-To: <20190417215434.25897-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 17 Apr 2019 16:41:01 -0700
Message-ID: <CALvZod5K8SM2EQFH1WM9bbwWBtyXWb_PvzJGvF5dg1Z=bdR7zg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: rework non-root kmem_cache lifecycle management
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, david@fromorbit.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:55 PM Roman Gushchin <guroan@gmail.com> wrote:
>
> This commit makes several important changes in the lifecycle
> of a non-root kmem_cache, which also affect the lifecycle
> of a memory cgroup.
>
> Currently each charged slab page has a page->mem_cgroup pointer
> to the memory cgroup and holds a reference to it.
> Kmem_caches are held by the cgroup. On offlining empty kmem_caches
> are freed, all other are freed on cgroup release.

No, they are not freed (i.e. destroyed) on offlining, only
deactivated. All memcg kmem_caches are freed/destroyed on memcg's
css_free.

>
> So the current scheme can be illustrated as:
> page->mem_cgroup->kmem_cache.
>
> To implement the slab memory reparenting we need to invert the scheme
> into: page->kmem_cache->mem_cgroup.
>
> Let's make every page to hold a reference to the kmem_cache (we
> already have a stable pointer), and make kmem_caches to hold a single
> reference to the memory cgroup.

What about memcg_kmem_get_cache()? That function assumes that by
taking reference on memcg, it's kmem_caches will stay. I think you
need to get reference on the kmem_cache in memcg_kmem_get_cache()
within the rcu lock where you get the memcg through css_tryget_online.

>
> To make this possible we need to introduce a new refcounter
> for non-root kmem_caches. It's atomic for now, but can be easily
> converted to a percpu counter, had we any performance penalty*.
> The initial value is set to 1, and it's decremented on deactivation,
> so we never shutdown an active cache.
>
> To shutdown non-active empty kmem_caches, let's reuse the
> infrastructure of the RCU-delayed work queue, used previously for
> the deactivation. After the generalization, it's perfectly suited
> for our needs.
>
> Since now we can release a kmem_cache at any moment after the
> deactivation, let's call sysfs_slab_remove() only from the shutdown
> path. It makes deactivation path simpler.
>
> Because we don't set the page->mem_cgroup pointer, we need to change
> the way how memcg-level stats is working for slab pages. We can't use
> mod_lruvec_page_state() helpers anymore, so switch over to
> mod_lruvec_state().
>
> * I used the following simple approach to test the performance
> (stolen from another patchset by T. Harding):
>
>     time find / -name fname-no-exist
>     echo 2 > /proc/sys/vm/drop_caches
>     repeat several times
>
> Results (I've chosen best results in several runs):
>
>         orig       patched
>
> real    0m0.712s   0m0.690s
> user    0m0.104s   0m0.101s
> sys     0m0.346s   0m0.340s
>
> real    0m0.728s   0m0.723s
> user    0m0.114s   0m0.115s
> sys     0m0.342s   0m0.338s
>
> real    0m0.685s   0m0.767s
> user    0m0.118s   0m0.114s
> sys     0m0.343s   0m0.336s
>
> So it looks like the difference is not noticeable in this test.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/slab.h |  2 +-
>  mm/memcontrol.c      |  9 ++++----
>  mm/slab.c            | 15 +-----------
>  mm/slab.h            | 54 +++++++++++++++++++++++++++++++++++++++++---
>  mm/slab_common.c     | 51 +++++++++++++++++------------------------
>  mm/slub.c            | 22 +-----------------
>  6 files changed, 79 insertions(+), 74 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 47923c173f30..4daaade76c63 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -152,7 +152,6 @@ int kmem_cache_shrink(struct kmem_cache *);
>
>  void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
>  void memcg_deactivate_kmem_caches(struct mem_cgroup *);
> -void memcg_destroy_kmem_caches(struct mem_cgroup *);
>
>  /*
>   * Please use this macro to create slab caches. Simply specify the
> @@ -641,6 +640,7 @@ struct memcg_cache_params {
>                         struct mem_cgroup *memcg;
>                         struct list_head children_node;
>                         struct list_head kmem_caches_node;
> +                       atomic_long_t refcnt;
>
>                         void (*work_fn)(struct kmem_cache *);
>                         union {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b2c39f187cbb..87c06e342e05 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2719,9 +2719,6 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
>                 cancel_charge(memcg, nr_pages);
>                 return -ENOMEM;
>         }
> -
> -       page->mem_cgroup = memcg;
> -
>         return 0;
>  }
>
> @@ -2744,8 +2741,10 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
>         memcg = get_mem_cgroup_from_current();
>         if (!mem_cgroup_is_root(memcg)) {
>                 ret = __memcg_kmem_charge_memcg(page, gfp, order, memcg);
> -               if (!ret)
> +               if (!ret) {
> +                       page->mem_cgroup = memcg;
>                         __SetPageKmemcg(page);
> +               }
>         }
>         css_put(&memcg->css);
>         return ret;
> @@ -3238,7 +3237,7 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
>                 memcg_offline_kmem(memcg);
>
>         if (memcg->kmem_state == KMEM_ALLOCATED) {
> -               memcg_destroy_kmem_caches(memcg);
> +               WARN_ON(!list_empty(&memcg->kmem_caches));
>                 static_branch_dec(&memcg_kmem_enabled_key);
>                 WARN_ON(page_counter_read(&memcg->kmem));
>         }
> diff --git a/mm/slab.c b/mm/slab.c
> index 14466a73d057..171b21ca617f 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1389,7 +1389,6 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>                                                                 int nodeid)
>  {
>         struct page *page;
> -       int nr_pages;
>
>         flags |= cachep->allocflags;
>
> @@ -1404,12 +1403,6 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>                 return NULL;
>         }
>
> -       nr_pages = (1 << cachep->gfporder);
> -       if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
> -               mod_lruvec_page_state(page, NR_SLAB_RECLAIMABLE, nr_pages);
> -       else
> -               mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE, nr_pages);
> -
>         __SetPageSlab(page);
>         /* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
>         if (sk_memalloc_socks() && page_is_pfmemalloc(page))
> @@ -1424,12 +1417,6 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
>  {
>         int order = cachep->gfporder;
> -       unsigned long nr_freed = (1 << order);
> -
> -       if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
> -               mod_lruvec_page_state(page, NR_SLAB_RECLAIMABLE, -nr_freed);
> -       else
> -               mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE, -nr_freed);
>
>         BUG_ON(!PageSlab(page));
>         __ClearPageSlabPfmemalloc(page);
> @@ -1438,7 +1425,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
>         page->mapping = NULL;
>
>         if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab += nr_freed;
> +               current->reclaim_state->reclaimed_slab += 1 << order;
>         memcg_uncharge_slab(page, order, cachep);
>         __free_pages(page, order);
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index 4a261c97c138..1f49945f5c1d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -173,7 +173,9 @@ void __kmem_cache_release(struct kmem_cache *);
>  int __kmem_cache_shrink(struct kmem_cache *);
>  void __kmemcg_cache_deactivate(struct kmem_cache *s);
>  void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
> +void kmemcg_cache_shutdown(struct kmem_cache *s);
>  void slab_kmem_cache_release(struct kmem_cache *);
> +void kmemcg_queue_cache_shutdown(struct kmem_cache *s);
>
>  struct seq_file;
>  struct file;
> @@ -274,19 +276,65 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
>         return s->memcg_params.root_cache;
>  }
>
> +static __always_inline void kmemcg_cache_get_many(struct kmem_cache *s, long n)
> +{
> +       atomic_long_add(n, &s->memcg_params.refcnt);
> +}
> +
> +static __always_inline void kmemcg_cache_put_many(struct kmem_cache *s, long n)
> +{
> +       if (atomic_long_sub_and_test(n, &s->memcg_params.refcnt))
> +               kmemcg_queue_cache_shutdown(s);
> +}
> +
>  static __always_inline int memcg_charge_slab(struct page *page,
>                                              gfp_t gfp, int order,
>                                              struct kmem_cache *s)
>  {
> -       if (is_root_cache(s))
> +       int idx = (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> +               NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> +       struct mem_cgroup *memcg;
> +       struct lruvec *lruvec;
> +       int ret;
> +
> +       if (is_root_cache(s)) {
> +               mod_node_page_state(page_pgdat(page), idx, 1 << order);
>                 return 0;
> -       return memcg_kmem_charge_memcg(page, gfp, order, s->memcg_params.memcg);
> +       }
> +
> +       memcg = s->memcg_params.memcg;
> +       ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
> +       if (!ret) {
> +               lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +               mod_lruvec_state(lruvec, idx, 1 << order);
> +
> +               /* transer try_charge() page references to kmem_cache */
> +               kmemcg_cache_get_many(s, 1 << order);
> +               css_put_many(&memcg->css, 1 << order);
> +       }
> +
> +       return 0;
>  }
>
>  static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>                                                 struct kmem_cache *s)
>  {
> -       memcg_kmem_uncharge(page, order);
> +       int idx = (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> +               NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE;
> +       struct mem_cgroup *memcg;
> +       struct lruvec *lruvec;
> +
> +       if (is_root_cache(s)) {
> +               mod_node_page_state(page_pgdat(page), idx, -(1 << order));
> +               return;
> +       }
> +
> +       memcg = s->memcg_params.memcg;
> +       lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +       mod_lruvec_state(lruvec, idx, -(1 << order));
> +       memcg_kmem_uncharge_memcg(page, order, memcg);
> +
> +       kmemcg_cache_put_many(s, 1 << order);
>  }
>
>  extern void slab_init_memcg_params(struct kmem_cache *);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 4e5b4292a763..3fdd02979a1c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -148,6 +148,7 @@ static int init_memcg_params(struct kmem_cache *s,
>                 s->memcg_params.root_cache = root_cache;
>                 INIT_LIST_HEAD(&s->memcg_params.children_node);
>                 INIT_LIST_HEAD(&s->memcg_params.kmem_caches_node);
> +               atomic_long_set(&s->memcg_params.refcnt, 1);
>                 return 0;
>         }
>
> @@ -225,6 +226,7 @@ void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg)
>         if (is_root_cache(s)) {
>                 list_add(&s->root_caches_node, &slab_root_caches);
>         } else {
> +               css_get(&memcg->css);
>                 s->memcg_params.memcg = memcg;
>                 list_add(&s->memcg_params.children_node,
>                          &s->memcg_params.root_cache->memcg_params.children);
> @@ -240,6 +242,7 @@ static void memcg_unlink_cache(struct kmem_cache *s)
>         } else {
>                 list_del(&s->memcg_params.children_node);
>                 list_del(&s->memcg_params.kmem_caches_node);
> +               css_put(&s->memcg_params.memcg->css);
>         }
>  }
>  #else
> @@ -703,21 +706,19 @@ static void kmemcg_after_rcu_workfn(struct work_struct *work)
>
>         s->memcg_params.work_fn(s);
>         s->memcg_params.work_fn = NULL;
> +       kmemcg_cache_put_many(s, 1);
>
>         mutex_unlock(&slab_mutex);
>
>         put_online_mems();
>         put_online_cpus();
> -
> -       /* done, put the ref from slab_deactivate_memcg_cache_rcu_sched() */
> -       css_put(&s->memcg_params.memcg->css);
>  }
>
>  /*
>   * We need to grab blocking locks.  Bounce to ->work.  The
>   * work item shares the space with the RCU head and can't be
> - * initialized eariler.
> -*/
> + * initialized earlier.
> + */
>  static void kmemcg_schedule_work_after_rcu(struct rcu_head *head)
>  {
>         struct kmem_cache *s = container_of(head, struct kmem_cache,
> @@ -727,6 +728,21 @@ static void kmemcg_schedule_work_after_rcu(struct rcu_head *head)
>         queue_work(memcg_kmem_cache_wq, &s->memcg_params.work);
>  }
>
> +static void kmemcg_cache_shutdown_after_rcu(struct kmem_cache *s)
> +{
> +       WARN_ON(shutdown_cache(s));
> +}
> +
> +void kmemcg_queue_cache_shutdown(struct kmem_cache *s)
> +{
> +       if (s->memcg_params.root_cache->memcg_params.dying)
> +               return;
> +
> +       WARN_ON(s->memcg_params.work_fn);
> +       s->memcg_params.work_fn = kmemcg_cache_shutdown_after_rcu;
> +       call_rcu(&s->memcg_params.rcu_head, kmemcg_schedule_work_after_rcu);
> +}
> +
>  static void kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
>  {
>         __kmemcg_cache_deactivate_after_rcu(s);
> @@ -739,9 +755,6 @@ static void kmemcg_cache_deactivate(struct kmem_cache *s)
>         if (s->memcg_params.root_cache->memcg_params.dying)
>                 return;
>
> -       /* pin memcg so that @s doesn't get destroyed in the middle */
> -       css_get(&s->memcg_params.memcg->css);
> -
>         WARN_ON_ONCE(s->memcg_params.work_fn);
>         s->memcg_params.work_fn = kmemcg_cache_deactivate_after_rcu;
>         call_rcu(&s->memcg_params.rcu_head, kmemcg_schedule_work_after_rcu);
> @@ -775,28 +788,6 @@ void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
>         put_online_cpus();
>  }
>
> -void memcg_destroy_kmem_caches(struct mem_cgroup *memcg)
> -{
> -       struct kmem_cache *s, *s2;
> -
> -       get_online_cpus();
> -       get_online_mems();
> -
> -       mutex_lock(&slab_mutex);
> -       list_for_each_entry_safe(s, s2, &memcg->kmem_caches,
> -                                memcg_params.kmem_caches_node) {
> -               /*
> -                * The cgroup is about to be freed and therefore has no charges
> -                * left. Hence, all its caches must be empty by now.
> -                */
> -               BUG_ON(shutdown_cache(s));
> -       }
> -       mutex_unlock(&slab_mutex);
> -
> -       put_online_mems();
> -       put_online_cpus();
> -}
> -
>  static int shutdown_memcg_caches(struct kmem_cache *s)
>  {
>         struct memcg_cache_array *arr;
> diff --git a/mm/slub.c b/mm/slub.c
> index 195f61785c7d..a28b3b3abf29 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1692,11 +1692,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>         if (!page)
>                 return NULL;
>
> -       mod_lruvec_page_state(page,
> -               (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> -               NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
> -               1 << oo_order(oo));
> -
>         inc_slabs_node(s, page_to_nid(page), page->objects);
>
>         return page;
> @@ -1730,11 +1725,6 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
>                         check_object(s, page, p, SLUB_RED_INACTIVE);
>         }
>
> -       mod_lruvec_page_state(page,
> -               (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> -               NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
> -               -pages);
> -
>         __ClearPageSlabPfmemalloc(page);
>         __ClearPageSlab(page);
>
> @@ -4037,18 +4027,8 @@ void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
>  {
>         /*
>          * Called with all the locks held after a sched RCU grace period.
> -        * Even if @s becomes empty after shrinking, we can't know that @s
> -        * doesn't have allocations already in-flight and thus can't
> -        * destroy @s until the associated memcg is released.
> -        *
> -        * However, let's remove the sysfs files for empty caches here.
> -        * Each cache has a lot of interface files which aren't
> -        * particularly useful for empty draining caches; otherwise, we can
> -        * easily end up with millions of unnecessary sysfs files on
> -        * systems which have a lot of memory and transient cgroups.
>          */
> -       if (!__kmem_cache_shrink(s))
> -               sysfs_slab_remove(s);
> +       __kmem_cache_shrink(s);
>  }
>
>  void __kmemcg_cache_deactivate(struct kmem_cache *s)
> --
> 2.20.1
>

Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EFE21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iL5SHmE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfJYTlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:41:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45714 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfJYTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:41:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so2169199pgj.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d49Pya+hQjafCpSTeS6zXZ+gN0JCbYhltoWS0iFlyGA=;
        b=iL5SHmE0sBPKzZHUzXIR+JVbn1jRcf43TbzfaQsIhyo9vOhKDXJysq7x8sNIP92bTD
         mQPF5C0dkliAbUnNNiaIOihqUYH4daynmwuPXE5p4u1/a/BnLWWCqF+DWMAKE5aSOpcY
         12MuDYf86zQ/0FyxGXMTW9QYAnt4ZXONMTVOgAZ2V+8HvbdDbnL7Ij9lUu9wBWgbSXlA
         JnbonDybyLSQWhlh0h8cpuXSPPF7pj3fItW3nUFHqFMwxsNHATvl3c8EEK5WsGfnfFIk
         +E6261U3M8Rsq0EZXVxkhoOiSFGVqJZ4sDoYZMf4LOuLhZVeXMyhpEFrsRt2nG9dhr0Y
         aVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d49Pya+hQjafCpSTeS6zXZ+gN0JCbYhltoWS0iFlyGA=;
        b=MR4XWScmDvy5n2IWZ/3ogJL0GR/+yl0CJoVTWi60VR6dz5knuGUO/1q6IGwAV8/V0U
         aE7c8nLQwJ4NSr8P0j9asD91zAtaBJm6W/qWCC9kkl62y+latvOFYFAIcAit9s1NEFlE
         kmKVWS9iIT7/U/ZFxSiqinyglpzS9NtusBo01weLHls0FCG4x0iJT4zc+HNIQZonqwUp
         8JLLFioSOIP6/0RHwRjPgYRlvG4Phn7o5xsTBdFoQiN5YQtnLauQWhd28SL7H60vSmzJ
         7zpdpU0Rsi06QeQNPREeM4t947J4/P661y3Xos4BezhUKLkOijethApDRnU/Wl6xKjSD
         fh1g==
X-Gm-Message-State: APjAAAVoul8h3GCvsUk2JuiutCPXWs4ABfeGgsTFHMMnPX3qxUY76OvE
        5PmjhAlyimFIutewmW+Uoj8X2Q==
X-Google-Smtp-Source: APXvYqyzEYXPplMXthuF0EiKlfh6Pp3Zw6MMiDBW/pk7/9qt9S+ZuRLL2Za2PDZnHwZ10RwBixYKQw==
X-Received: by 2002:a17:90a:fe12:: with SMTP id ck18mr6088629pjb.83.1572032481161;
        Fri, 25 Oct 2019 12:41:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::553e])
        by smtp.gmail.com with ESMTPSA id r28sm3363610pfg.62.2019.10.25.12.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:41:20 -0700 (PDT)
Date:   Fri, 25 Oct 2019 15:41:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 09/16] mm: memcg/slab: charge individual slab objects
 instead of pages
Message-ID: <20191025194118.GA393641@cmpxchg.org>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018002820.307763-10-guro@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:28:13PM -0700, Roman Gushchin wrote:
> +static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> +						struct mem_cgroup **memcgp,
> +						size_t size, gfp_t flags)
> +{
> +	struct kmem_cache *cachep;
> +
> +	cachep = memcg_kmem_get_cache(s, memcgp);
> +	if (is_root_cache(cachep))
> +		return s;
> +
> +	if (__memcg_kmem_charge_subpage(*memcgp, size * s->size, flags)) {
> +		mem_cgroup_put(*memcgp);
> +		memcg_kmem_put_cache(cachep);
> +		cachep = NULL;
> +	}
> +
> +	return cachep;
> +}
> +
>  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  					      struct mem_cgroup *memcg,
>  					      size_t size, void **p)
>  {
>  	struct mem_cgroup_ptr *memcg_ptr;
> +	struct lruvec *lruvec;
>  	struct page *page;
>  	unsigned long off;
>  	size_t i;
> @@ -439,6 +393,11 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  			off = obj_to_index(s, page, p[i]);
>  			mem_cgroup_ptr_get(memcg_ptr);
>  			page->mem_cgroup_vec[off] = memcg_ptr;
> +			lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +			mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s),
> +					       s->size);
> +		} else {
> +			__memcg_kmem_uncharge_subpage(memcg, s->size);
>  		}
>  	}
>  	mem_cgroup_ptr_put(memcg_ptr);

The memcg_ptr as a collection vessel for object references makes a lot
of sense. But this code showcases that it should be a first-class
memory tracking API that the allocator interacts with, rather than
having to deal with a combination of memcg_ptr and memcg.

In the two hunks here, on one hand we charge bytes to the memcg
object, and then handle all the refcounting through a different
bucketing object. To support that in the first place, we have to
overload the memcg API all the way down to try_charge() to support
bytes and pages. This is difficult to follow throughout all layers.

What would be better is for this to be an abstraction layer for a
subpage object tracker that sits on top of the memcg page tracker -
not unlike the page allocator and the slab allocators themselves.

And then the slab allocator would only interact with the subpage
object tracker, and the object tracker would deal with the memcg page
tracker under the hood.

Something like the below, just a rough sketch to convey the idea:

On allocation, we look up an obj_cgroup from the current task, charge
it with obj_cgroup_charge() and bump its refcount by the number of
objects we allocated. obj_cgroup_charge() in turn uses the memcg layer
to charge pages, and then doles them out as bytes using
objcg->nr_stocked_bytes and the byte per-cpu stock.

On freeing, we call obj_cgroup_uncharge() and drop the references. In
turn, this first refills the byte per-cpu stock and drains the
overflow to the memcg layer (which in turn refills its own page stock
and drains to the page_counter).

On cgroup deletion, we reassign the obj_cgroup to the parent, and all
remaining live objects will free their pages to the updated parental
obj_cgroup->memcg, as per usual.

---

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f36203cf75f8..efc3398aaf02 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -200,15 +200,15 @@ struct memcg_cgwb_frn {
 };
 
 /*
- * A pointer to a memory cgroup with a built-in reference counter.
- * For a use as an intermediate object to simplify reparenting of
- * objects charged to the cgroup. The memcg pointer can be switched
- * to the parent cgroup without a need to modify all objects
- * which hold the reference to the cgroup.
+ * Bucket for arbitrarily byte-sized objects charged to a memory
+ * cgroup. The bucket can be reparented in one piece when the cgroup
+ * is destroyed, without having to round up the individual references
+ * of all live memory objects in the wild.
  */
-struct mem_cgroup_ptr {
-	struct percpu_ref refcnt;
+struct obj_cgroup {
+	struct percpu_ref count;
 	struct mem_cgroup *memcg;
+	unsigned long nr_stocked_bytes;
 	union {
 		struct list_head list;
 		struct rcu_head rcu;
@@ -230,7 +230,6 @@ struct mem_cgroup {
 	/* Accounted resources */
 	struct page_counter memory;
 	struct page_counter swap;
-	atomic_t nr_stocked_bytes;
 
 	/* Legacy consumer-oriented counters */
 	struct page_counter memsw;
@@ -327,8 +326,8 @@ struct mem_cgroup {
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
-	struct mem_cgroup_ptr __rcu *kmem_memcg_ptr;
-	struct list_head kmem_memcg_ptr_list;
+	struct obj_cgroup __rcu *slab_objs;
+	struct list_head slab_objs_list;
 #endif
 
 	int last_scanned_node;
@@ -474,21 +473,6 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
-static inline bool mem_cgroup_ptr_tryget(struct mem_cgroup_ptr *ptr)
-{
-	return percpu_ref_tryget(&ptr->refcnt);
-}
-
-static inline void mem_cgroup_ptr_get(struct mem_cgroup_ptr *ptr)
-{
-	percpu_ref_get(&ptr->refcnt);
-}
-
-static inline void mem_cgroup_ptr_put(struct mem_cgroup_ptr *ptr)
-{
-	percpu_ref_put(&ptr->refcnt);
-}
-
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
@@ -1444,9 +1428,9 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 			      struct mem_cgroup *memcg);
 void __memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
 				 unsigned int nr_pages);
-int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
+int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size,
 				gfp_t gfp);
-void __memcg_kmem_uncharge_subpage(struct mem_cgroup *memcg, size_t size);
+void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
@@ -1513,20 +1497,20 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
-static inline struct mem_cgroup_ptr *
-mem_cgroup_get_kmem_ptr(struct mem_cgroup *memcg)
+static inline struct obj_cgroup *
+mem_cgroup_get_slab_objs(struct mem_cgroup *memcg)
 {
-	struct mem_cgroup_ptr *memcg_ptr;
+	struct obj_cgroup *objcg;
 
 	rcu_read_lock();
 	do {
-		memcg_ptr = rcu_dereference(memcg->kmem_memcg_ptr);
-		if (memcg_ptr && mem_cgroup_ptr_tryget(memcg_ptr))
+		objcg = rcu_dereference(memcg->slab_objs);
+		if (objcg && percpu_ref_tryget(&objcg->count))
 			break;
 	} while ((memcg = parent_mem_cgroup(memcg)));
 	rcu_read_unlock();
 
-	return memcg_ptr;
+	return objcg;
 }
 
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4d99ee5a9c53..7f663fd53c17 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -200,7 +200,7 @@ struct page {
 #ifdef CONFIG_MEMCG
 	union {
 		struct mem_cgroup *mem_cgroup;
-		struct mem_cgroup_ptr **mem_cgroup_vec;
+		struct obj_cgroup **obj_cgroups;
 	};
 #endif
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b0d0c833150c..47110f4f0f4c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -260,52 +260,51 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
 
-static void memcg_ptr_release(struct percpu_ref *ref)
+static void obj_cgroup_release(struct percpu_ref *ref)
 {
-	struct mem_cgroup_ptr *ptr = container_of(ref, struct mem_cgroup_ptr,
-						  refcnt);
+	struct obj_cgroup *objcg;
 	unsigned long flags;
 
+	objcg = container_of(ref, struct obj_cgroup, count);
+
 	spin_lock_irqsave(&css_set_lock, flags);
-	list_del(&ptr->list);
+	list_del(&objcg->list);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 
-	mem_cgroup_put(ptr->memcg);
+	mem_cgroup_put(objcg->memcg);
 	percpu_ref_exit(ref);
-	kfree_rcu(ptr, rcu);
+	kfree_rcu(objcg, rcu);
 }
 
-static int memcg_init_kmem_memcg_ptr(struct mem_cgroup *memcg)
+static int obj_cgroup_alloc(struct mem_cgroup *memcg)
 {
-	struct mem_cgroup_ptr *kmem_memcg_ptr;
+	struct obj_cgroup *objcg;
 	int ret;
 
-	kmem_memcg_ptr = kmalloc(sizeof(struct mem_cgroup_ptr), GFP_KERNEL);
-	if (!kmem_memcg_ptr)
+	objcg = kmalloc(sizeof(struct obj_cgroup), GFP_KERNEL);
+	if (!objcg)
 		return -ENOMEM;
 
-	ret = percpu_ref_init(&kmem_memcg_ptr->refcnt, memcg_ptr_release,
+	ret = percpu_ref_init(&objcg->count, obj_cgroup_release,
 			      0, GFP_KERNEL);
 	if (ret) {
-		kfree(kmem_memcg_ptr);
+		kfree(objcg);
 		return ret;
 	}
 
-	kmem_memcg_ptr->memcg = memcg;
-	INIT_LIST_HEAD(&kmem_memcg_ptr->list);
-	rcu_assign_pointer(memcg->kmem_memcg_ptr, kmem_memcg_ptr);
-	list_add(&kmem_memcg_ptr->list, &memcg->kmem_memcg_ptr_list);
+	INIT_LIST_HEAD(&objcg->list);
+	objcg->memcg = memcg;
 	return 0;
 }
 
-static void memcg_reparent_kmem_memcg_ptr(struct mem_cgroup *memcg,
-					  struct mem_cgroup *parent)
+static void slab_objs_reparent(struct mem_cgroup *memcg,
+			       struct mem_cgroup *parent)
 {
+	struct obj_cgroup *objcg = NULL;
 	unsigned int nr_reparented = 0;
-	struct mem_cgroup_ptr *memcg_ptr = NULL;
 
-	rcu_swap_protected(memcg->kmem_memcg_ptr, memcg_ptr, true);
-	percpu_ref_kill(&memcg_ptr->refcnt);
+	rcu_swap_protected(memcg->slab_objs, objcg, true);
+	percpu_ref_kill(&objcg->count);
 
 	/*
 	 * kmem_memcg_ptr is initialized before css refcounter, so until now
@@ -314,13 +313,13 @@ static void memcg_reparent_kmem_memcg_ptr(struct mem_cgroup *memcg,
 	css_get(&memcg->css);
 
 	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(memcg_ptr, &memcg->kmem_memcg_ptr_list, list) {
-		xchg(&memcg_ptr->memcg, parent);
+	list_for_each_entry(objcg, &memcg->slab_objs_list, list) {
+		xchg(&objcg->memcg, parent);
 		nr_reparented++;
 	}
 	if (nr_reparented)
-		list_splice(&memcg->kmem_memcg_ptr_list,
-			    &parent->kmem_memcg_ptr_list);
+		list_splice(&memcg->slab_objs_list,
+			    &parent->slab_objs_list);
 	spin_unlock_irq(&css_set_lock);
 
 	if (nr_reparented) {
@@ -2217,7 +2216,7 @@ struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
-	struct mem_cgroup *subpage_cached;
+	struct obj_cgroup *obj_cached;
 	unsigned int nr_bytes;
 
 	struct work_struct work;
@@ -2260,29 +2259,6 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	return ret;
 }
 
-static bool consume_subpage_stock(struct mem_cgroup *memcg,
-				  unsigned int nr_bytes)
-{
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
-	bool ret = false;
-
-	if (nr_bytes > (MEMCG_CHARGE_BATCH << PAGE_SHIFT))
-		return ret;
-
-	local_irq_save(flags);
-
-	stock = this_cpu_ptr(&memcg_stock);
-	if (memcg == stock->subpage_cached && stock->nr_bytes >= nr_bytes) {
-		stock->nr_bytes -= nr_bytes;
-		ret = true;
-	}
-
-	local_irq_restore(flags);
-
-	return ret;
-}
-
 /*
  * Returns stocks cached in percpu and reset cached information.
  */
@@ -2300,59 +2276,73 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 	stock->cached = NULL;
 }
 
-static void drain_subpage_stock(struct memcg_stock_pcp *stock)
+/*
+ * Cache charges(val) to local per_cpu area.
+ * This will be consumed by consume_stock() function, later.
+ */
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct mem_cgroup *old = stock->subpage_cached;
-
-	if (stock->nr_bytes) {
-		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
-		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
+	struct memcg_stock_pcp *stock;
+	unsigned long flags;
 
-		page_counter_uncharge(&old->memory, nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, nr_pages);
+	local_irq_save(flags);
 
-		atomic_add(nr_bytes, &old->nr_stocked_bytes);
-		stock->nr_bytes = 0;
-	}
-	if (stock->subpage_cached) {
-		/*
-		 * Unlike generic percpu stock, where ->cached pointer is
-		 * protected by css references of held pages, pages held
-		 * by subpage stocks are not holding a css reference, so
-		 * we need to protect ->subpage_cached pointer explicitly.
-		 *
-		 * css_put() is paired with css_get() in refill_subpage_stock()
-		 */
-		css_put(&old->css);
-		stock->subpage_cached = NULL;
+	stock = this_cpu_ptr(&memcg_stock);
+	if (stock->cached != memcg) { /* reset if necessary */
+		drain_stock(stock);
+		stock->cached = memcg;
 	}
+	stock->nr_pages += nr_pages;
+
+	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
+		drain_stock(stock);
+
+	local_irq_restore(flags);
 }
 
-static void drain_local_stock(struct work_struct *dummy)
+static bool consume_obj_stock(struct obj_cgroup *objcg,
+				  unsigned int nr_bytes)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
+	bool ret = false;
+
+	if (nr_bytes > (MEMCG_CHARGE_BATCH << PAGE_SHIFT))
+		return ret;
 
-	/*
-	 * The only protection from memory hotplug vs. drain_stock races is
-	 * that we always operate on local CPU stock here with IRQ disabled
-	 */
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	drain_stock(stock);
-	drain_subpage_stock(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	if (objcg == stock->obj_cached && stock->nr_bytes >= nr_bytes) {
+		stock->nr_bytes -= nr_bytes;
+		ret = true;
+	}
 
 	local_irq_restore(flags);
+
+	return ret;
 }
 
-/*
- * Cache charges(val) to local per_cpu area.
- * This will be consumed by consume_stock() function, later.
- */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void drain_obj_stock(struct memcg_stock_pcp *stock)
+{
+	struct obj_cgroup *old = stock->obj_cached;
+
+	if (stock->nr_bytes) {
+		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
+		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
+
+		refill_stock(old->memcg, nr_pages);
+		atomic_add(nr_bytes, &old->nr_stocked_bytes);
+		stock->nr_bytes = 0;
+	}
+	if (stock->subpage_cached) {
+		percpu_ref_put(&objcg->refcount);
+		stock->obj_cached = NULL;
+	}
+}
+
+static void refill_obj_stock(struct obj_cgroup *objcg,
+				 unsigned int nr_bytes)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
@@ -2360,37 +2350,35 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (stock->cached != memcg) { /* reset if necessary */
-		drain_stock(stock);
-		stock->cached = memcg;
+	if (stock->obj_cached != objcg) { /* reset if necessary */
+		drain_obj_stock(stock);
+		percpu_ref_get(&objcg->refcount);
+		stock->obj_cached = objcg;
+		stock->nr_bytes = atomic_xchg(&objcg->nr_stocked_bytes, 0);
 	}
-	stock->nr_pages += nr_pages;
+	stock->nr_bytes += nr_bytes;
 
-	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
-		drain_stock(stock);
+	if (stock->nr_bytes > (MEMCG_CHARGE_BATCH << PAGE_SHIFT))
+		drain_obj_stock(stock);
 
 	local_irq_restore(flags);
 }
 
-static void refill_subpage_stock(struct mem_cgroup *memcg,
-				 unsigned int nr_bytes)
+static void drain_local_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
+	/*
+	 * The only protection from memory hotplug vs. drain_stock races is
+	 * that we always operate on local CPU stock here with IRQ disabled
+	 */
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (stock->subpage_cached != memcg) { /* reset if necessary */
-		drain_subpage_stock(stock);
-		css_get(&memcg->css);
-		stock->subpage_cached = memcg;
-		stock->nr_bytes = atomic_xchg(&memcg->nr_stocked_bytes, 0);
-	}
-	stock->nr_bytes += nr_bytes;
-
-	if (stock->nr_bytes > (MEMCG_CHARGE_BATCH << PAGE_SHIFT))
-		drain_subpage_stock(stock);
+	drain_obj_stock(stock);
+	drain_stock(stock);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
 	local_irq_restore(flags);
 }
@@ -2658,9 +2646,8 @@ void mem_cgroup_handle_over_high(void)
  */
 
 static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
-		      unsigned int amount, bool subpage)
+		      unsigned int nr_pages)
 {
-	unsigned int nr_pages = subpage ? ((amount >> PAGE_SHIFT) + 1) : amount;
 	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
@@ -2673,9 +2660,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (mem_cgroup_is_root(memcg))
 		return 0;
 retry:
-	if (subpage && consume_subpage_stock(memcg, amount))
-		return 0;
-	else if (!subpage && consume_stock(memcg, nr_pages))
+	if (consume_stock(memcg, nr_pages))
 		return 0;
 
 	if (!do_memsw_account() ||
@@ -2794,21 +2779,14 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (do_memsw_account())
 		page_counter_charge(&memcg->memsw, nr_pages);
 
-	if (subpage)
-		refill_subpage_stock(memcg, (nr_pages << PAGE_SHIFT) - amount);
-	else
-		css_get_many(&memcg->css, nr_pages);
+	css_get_many(&memcg->css, nr_pages);
 
 	return 0;
 
 done_restock:
-	if (subpage && (batch << PAGE_SHIFT) > amount) {
-		refill_subpage_stock(memcg, (batch << PAGE_SHIFT) - amount);
-	} else if (!subpage) {
-		css_get_many(&memcg->css, batch);
-		if (batch > nr_pages)
-			refill_stock(memcg, batch - nr_pages);
-	}
+	css_get_many(&memcg->css, batch);
+	if (batch > nr_pages)
+		refill_stock(memcg, batch - nr_pages);
 
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -3117,15 +3095,24 @@ void __memcg_kmem_uncharge(struct page *page, int order)
 	css_put_many(&memcg->css, nr_pages);
 }
 
-int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
-				gfp_t gfp)
+int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size, gfp_t gfp)
 {
-	return try_charge(memcg, gfp, size, true);
+	int ret;
+
+	if (consume_obj_stock(objcg, nr_bytes))
+		return 0;
+
+	ret = try_charge(objcg->memcg, gfp, 1);
+	if (ret)
+		return ret;
+
+	refill_obj_stock(objcg, PAGE_SIZE - size);
+	return 0;
 }
 
-void __memcg_kmem_uncharge_subpage(struct mem_cgroup *memcg, size_t size)
+void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 {
-	refill_subpage_stock(memcg, size);
+	refill_obj_stock(objcg, size);
 }
 
 #endif /* CONFIG_MEMCG_KMEM */
@@ -3562,6 +3549,7 @@ static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
+	struct obj_cgroup *objcg;
 	int memcg_id, ret;
 
 	if (cgroup_memory_nokmem)
@@ -3574,11 +3562,13 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (memcg_id < 0)
 		return memcg_id;
 
-	ret = memcg_init_kmem_memcg_ptr(memcg);
+	objcg = obj_cgroup_alloc(memcg);
 	if (ret) {
 		memcg_free_cache_id(memcg_id);
 		return ret;
 	}
+	rcu_assign_pointer(memcg->slab_objs, objcg);
+	list_add(&objcg->list, &memcg->slab_objs_list);
 
 	static_branch_inc(&memcg_kmem_enabled_key);
 	/*
@@ -3613,7 +3603,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	 * precise values at the parent and all ancestor levels. It's required
 	 * to keep slab stats accurate after the reparenting of kmem_caches.
 	 */
-	memcg_reparent_kmem_memcg_ptr(memcg, parent);
+	obj_cgroup_reparent(memcg, parent);
 	memcg_flush_percpu_vmstats(memcg, true);
 
 	kmemcg_id = memcg->kmemcg_id;
@@ -5164,7 +5154,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->kmem_memcg_ptr_list);
+	INIT_LIST_HEAD(&memcg->obj_cgroup_list);
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
diff --git a/mm/slab.c b/mm/slab.c
index 0914d7cd869f..d452e0e7aab1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3212,10 +3212,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
 	unsigned long save_flags;
 	void *ptr;
 	int slab_node = numa_mem_id();
-	struct mem_cgroup *memcg = NULL;
+	struct obj_cgroup *objcg = NULL;
 
 	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, &memcg, 1, flags);
+	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
 
@@ -3251,7 +3251,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
 	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
 		memset(ptr, 0, cachep->object_size);
 
-	slab_post_alloc_hook(cachep, memcg, flags, 1, &ptr);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr);
 	return ptr;
 }
 
@@ -3292,10 +3292,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
 {
 	unsigned long save_flags;
 	void *objp;
-	struct mem_cgroup *memcg = NULL;
+	struct obj_cgroup *objcg = NULL;
 
 	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, &memcg, 1, flags);
+	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
 
@@ -3309,7 +3309,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
 	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
 		memset(objp, 0, cachep->object_size);
 
-	slab_post_alloc_hook(cachep, memcg, flags, 1, &objp);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp);
 	return objp;
 }
 
@@ -3497,9 +3497,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			  void **p)
 {
 	size_t i;
-	struct mem_cgroup *memcg = NULL;
+	struct obj_cgroup *objcg = NULL;
 
-	s = slab_pre_alloc_hook(s, &memcg, size, flags);
+	s = slab_pre_alloc_hook(s, &objcg, size, flags);
 	if (!s)
 		return 0;
 
@@ -3522,13 +3522,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 		for (i = 0; i < size; i++)
 			memset(p[i], 0, s->object_size);
 
-	slab_post_alloc_hook(s, memcg, flags, size, p);
+	slab_post_alloc_hook(s, objcg, flags, size, p);
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
 	return size;
 error:
 	local_irq_enable();
 	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
-	slab_post_alloc_hook(s, memcg, flags, i, p);
+	slab_post_alloc_hook(s, objcg, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
diff --git a/mm/slab.h b/mm/slab.h
index 035c2969a2ca..9dc082c8140d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -301,29 +301,30 @@ static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 	return memcg_ptr->memcg;
 }
 
-static inline int memcg_alloc_page_memcg_vec(struct page *page, gfp_t gfp,
+static inline int memcg_alloc_page_object_cgroups(struct page *page, gfp_t gfp,
 					     unsigned int objects)
 {
-	page->mem_cgroup_vec = kmalloc(sizeof(struct mem_cgroup_ptr *) *
+	page->obj_cgroups = kmalloc(sizeof(struct mem_cgroup_ptr *) *
 				       objects, gfp | __GFP_ZERO);
-	if (!page->mem_cgroup_vec)
+	if (!page->obj_cgroups)
 		return -ENOMEM;
 
 	return 0;
 }
 
-static inline void memcg_free_page_memcg_vec(struct page *page)
+static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
-	kfree(page->mem_cgroup_vec);
-	page->mem_cgroup_vec = NULL;
+	kfree(page->obj_cgroups);
+	page->obj_cgroups = NULL;
 }
 
 static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-						struct mem_cgroup **memcgp,
+						struct obj_cgroup **objcgp,
 						size_t size, gfp_t flags)
 {
 	struct kmem_cache *cachep;
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
 	if (memcg_kmem_bypass())
 		return s;
@@ -338,48 +339,51 @@ static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 		return s;
 	}
 
-	if (__memcg_kmem_charge_subpage(memcg, size * s->size, flags)) {
+	objcg = mem_cgroup_get_slab_objs(memcg);
+	if (obj_cgroup_charge(objcg, s->size, size, flags)) {
+		percpu_ref_put(&objcg->count);
 		mem_cgroup_put(memcg);
 		return NULL;
 	}
-
-	*memcgp = memcg;
+	*objcgp = objcg;
 	return cachep;
 }
 
-static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					      struct mem_cgroup *memcg,
-					      size_t size, void **p)
+static inline void cgroup_slab_post_alloc_hook(struct kmem_cache *s,
+					       struct obj_cgroup *objcg,
+					       size_t size, void **p)
 {
-	struct mem_cgroup_ptr *memcg_ptr;
+	struct obj_cgroup *objcg;
 	struct lruvec *lruvec;
 	struct page *page;
 	unsigned long off;
 	size_t i;
 
-	memcg_ptr = mem_cgroup_get_kmem_ptr(memcg);
 	for (i = 0; i < size; i++) {
 		if (likely(p[i])) {
 			page = virt_to_head_page(p[i]);
 			off = obj_to_index(s, page, p[i]);
-			mem_cgroup_ptr_get(memcg_ptr);
-			page->mem_cgroup_vec[off] = memcg_ptr;
-			lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
+			page->obj_cgroups[off] = objcg;
+			lruvec = mem_cgroup_lruvec(page_pgdat(page),
+						   objcg->memcg);
 			mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s),
 					       s->size);
 		} else {
-			__memcg_kmem_uncharge_subpage(memcg, s->size);
+			object_cgroup_uncharge(objcg, s->size);
+			percpu_ref_put(&objcg->count);
 		}
 	}
-	mem_cgroup_ptr_put(memcg_ptr);
+
+	/* pre_hook references */
+	percpu_ref_put(&objcg->count);
 	mem_cgroup_put(memcg);
 }
 
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
 					void *p)
 {
-	struct mem_cgroup_ptr *memcg_ptr;
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	struct lruvec *lruvec;
 	unsigned int off;
 
@@ -387,17 +391,16 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
 		return;
 
 	off = obj_to_index(s, page, p);
-	memcg_ptr = page->mem_cgroup_vec[off];
-	page->mem_cgroup_vec[off] = NULL;
+	objcg = page->obj_cgroup[off];
+	page->obj_cgroups[off] = NULL;
+
 	rcu_read_lock();
-	memcg = memcg_ptr->memcg;
-	if (likely(!mem_cgroup_is_root(memcg))) {
-		__memcg_kmem_uncharge_subpage(memcg, s->size);
-		lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
-		mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s), -s->size);
-	}
+	lruvec = mem_cgroup_lruvec(page_pgdat(pgdat), objcg->memcg);
+	mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s), -s->size);
 	rcu_read_unlock();
-	mem_cgroup_ptr_put(memcg_ptr);
+
+	obj_cgroup_uncharge(objcg, s->size);
+	percpu_ref_put(&objcg->count);
 }
 
 extern void slab_init_memcg_params(struct kmem_cache *);
@@ -451,14 +454,14 @@ static inline void memcg_free_page_memcg_vec(struct page *page)
 }
 
 static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
-						struct mem_cgroup **memcgp,
+						struct obj_cgroup **objcgp,
 						size_t size, gfp_t flags)
 {
 	return NULL;
 }
 
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
-					      struct mem_cgroup *memcg,
+					      struct obj_cgroup *objcg,
 					      size_t size, void **p)
 {
 }
@@ -570,7 +573,7 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 }
 
 static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
-						     struct mem_cgroup **memcgp,
+						     struct obj_cgroup **objcg,
 						     size_t size, gfp_t flags)
 {
 	flags &= gfp_allowed_mask;
@@ -585,13 +588,13 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
 	if (memcg_kmem_enabled() &&
 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
-		return memcg_slab_pre_alloc_hook(s, memcgp, size, flags);
+		return memcg_slab_pre_alloc_hook(s, objcg, size, flags);
 
 	return s;
 }
 
 static inline void slab_post_alloc_hook(struct kmem_cache *s,
-					struct mem_cgroup *memcg,
+					struct obj_cgroup *objcg,
 					gfp_t flags, size_t size, void **p)
 {
 	size_t i;
@@ -605,7 +608,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	}
 
 	if (!is_root_cache(s))
-		memcg_slab_post_alloc_hook(s, memcg, size, p);
+		memcg_slab_post_alloc_hook(s, objcg, size, p);
 }
 
 #ifndef CONFIG_SLOB
diff --git a/mm/slub.c b/mm/slub.c
index 53abbf0831b6..8f7f035d49a3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3162,10 +3162,10 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 {
 	struct kmem_cache_cpu *c;
 	int i;
-	struct mem_cgroup *memcg = NULL;
+	struct obj_cgroup *objcg = NULL;
 
 	/* memcg and kmem_cache debug support */
-	s = slab_pre_alloc_hook(s, &memcg, size, flags);
+	s = slab_pre_alloc_hook(s, &objcg, size, flags);
 	if (unlikely(!s))
 		return false;
 	/*
@@ -3210,11 +3210,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 
 	/* memcg and kmem_cache debug support */
-	slab_post_alloc_hook(s, memcg, flags, size, p);
+	slab_post_alloc_hook(s, objcg, flags, size, p);
 	return i;
 error:
 	local_irq_enable();
-	slab_post_alloc_hook(s, memcg, flags, i, p);
+	slab_post_alloc_hook(s, objcg, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }

Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE0C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FF52054F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzTAITx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFRcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:32:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37287 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLFRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:32:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so8510143lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i/QmWVEp5u71jRLoJFEe66MhYXylnknKFGBSZjbxrQY=;
        b=rzTAITx7m5Tn+yg91r3aWCVBc7XoUqboHQa5IfU8iek7TS3sqEUdsJLCJ4wQYL812s
         76wB2W8tDoChnIQxt4Sm0jDVcFt6AFc40xKtnxm+H0DySuCXOhTLbOk2XxB3RteQyeb2
         lgzkj5I1Nyq/fEJBYDOPO8jrtAtgOwij2Pp8okt2MpeKwAZQri2s65kqZqQWzhncGm9i
         5P3zumlEl0wlZUGTE4hZ3n3LFocKdQccG3nVERWh0kXN0Av2Z7bEI0J2x+tWSt9hkYep
         9EXVJLgf+eZ6ieN17wKU6ocpfirRYUhQIAnTy/oYX9As0FA//6kfCETsndvAQ0FpoFWf
         s4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i/QmWVEp5u71jRLoJFEe66MhYXylnknKFGBSZjbxrQY=;
        b=IK08XTtKYiau1RiOsgigOEOEj1iQVFPW+vxcSIUur9jsc7GOBkaJ3wu35tS3UysWxb
         vegaQxv9QFF+h5Vwzeam06f19Kql56nKFvZ9rY6e1oF0BlaFny4Xs+sXLEI2vijY8o0v
         TO4p0L/KWUdJ0J7PVxw/H07ed/5Q+YihdJ182H+BXORgHCBZoDQCmqFSnDiCaT4TEarp
         8Ts8CWOoyL+UQxVXnirRuIo1t0S/FAjHUo8TCC8G/28jREGXEja8fGNq9YJSgLQ93jFi
         D/SYomPt1j53QTO5aXgZRpdaWf0xFktdresfE8kAZXoKGw5RhVzLN9vbgMBk//No5Vfv
         1CJg==
X-Gm-Message-State: APjAAAXcP1QCzpZ39RnSYlLhJxKSB+I9XKuyGvib9YlsFB9lzLAk+ewM
        8GxaZFUdiLNO+d02kimBQ8w=
X-Google-Smtp-Source: APXvYqyS++//z7llKkCu3XOPBXJANAKaGUuoNWGSVXc2U7/faDWR4TitghHpZVwRq2uGe9mdLHgZtg==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr8198073ljo.180.1575653549568;
        Fri, 06 Dec 2019 09:32:29 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id e14sm7958952ljj.36.2019.12.06.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:32:28 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 6 Dec 2019 18:32:21 +0100
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Daniel Axtens <dja@axtens.net>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kasan: fix crashes on access to memory mapped by
 vm_map_ram()
Message-ID: <20191206173221.GA9500@pc636>
References: <20191204224037.GA12896@pc636>
 <20191205095942.1761-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205095942.1761-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 12:59:42PM +0300, Andrey Ryabinin wrote:
> With CONFIG_KASAN_VMALLOC=y any use of memory obtained via vm_map_ram()
> will crash because there is no shadow backing that memory.
> 
> Instead of sprinkling additional kasan_populate_vmalloc() calls all over
> the vmalloc code, move it into alloc_vmap_area(). This will fix
> vm_map_ram() and simplify the code a bit.
> 
> Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
> 
>  Changes since v1:
>   - Fix error path in alloc_vmap_area.
>   - Remove wrong Reported-by: syzbot (The issue reported by bot is a different one)
> 
>  include/linux/kasan.h | 15 +++++---
>  mm/kasan/common.c     | 27 +++++++++-----
>  mm/vmalloc.c          | 85 ++++++++++++++++++++-----------------------
>  3 files changed, 67 insertions(+), 60 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 4f404c565db1..e18fe54969e9 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -205,20 +205,23 @@ static inline void *kasan_reset_tag(const void *addr)
>  #endif /* CONFIG_KASAN_SW_TAGS */
>  
>  #ifdef CONFIG_KASAN_VMALLOC
> -int kasan_populate_vmalloc(unsigned long requested_size,
> -			   struct vm_struct *area);
> -void kasan_poison_vmalloc(void *start, unsigned long size);
> +int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> +void kasan_poison_vmalloc(const void *start, unsigned long size);
> +void kasan_unpoison_vmalloc(const void *start, unsigned long size);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
>  			   unsigned long free_region_end);
>  #else
> -static inline int kasan_populate_vmalloc(unsigned long requested_size,
> -					 struct vm_struct *area)
> +static inline int kasan_populate_vmalloc(unsigned long start,
> +					unsigned long size)
>  {
>  	return 0;
>  }
>  
> -static inline void kasan_poison_vmalloc(void *start, unsigned long size) {}
> +static inline void kasan_poison_vmalloc(const void *start, unsigned long size)
> +{ }
> +static inline void kasan_unpoison_vmalloc(const void *start, unsigned long size)
> +{ }
>  static inline void kasan_release_vmalloc(unsigned long start,
>  					 unsigned long end,
>  					 unsigned long free_region_start,
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index df3371d5c572..a1e6273be8c3 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -777,15 +777,17 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  	return 0;
>  }
>  
> -int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
> +int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>  {
>  	unsigned long shadow_start, shadow_end;
>  	int ret;
>  
> -	shadow_start = (unsigned long)kasan_mem_to_shadow(area->addr);
> +	if (!is_vmalloc_or_module_addr((void *)addr))
> +		return 0;
> +
> +	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
>  	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> -	shadow_end = (unsigned long)kasan_mem_to_shadow(area->addr +
> -							area->size);
> +	shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
>  	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
>  
>  	ret = apply_to_page_range(&init_mm, shadow_start,
> @@ -796,10 +798,6 @@ int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
>  
>  	flush_cache_vmap(shadow_start, shadow_end);
>  
> -	kasan_unpoison_shadow(area->addr, requested_size);
> -
> -	area->flags |= VM_KASAN;
> -
>  	/*
>  	 * We need to be careful about inter-cpu effects here. Consider:
>  	 *
> @@ -842,12 +840,23 @@ int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
>   * Poison the shadow for a vmalloc region. Called as part of the
>   * freeing process at the time the region is freed.
>   */
> -void kasan_poison_vmalloc(void *start, unsigned long size)
> +void kasan_poison_vmalloc(const void *start, unsigned long size)
>  {
> +	if (!is_vmalloc_or_module_addr(start))
> +		return;
> +
>  	size = round_up(size, KASAN_SHADOW_SCALE_SIZE);
>  	kasan_poison_shadow(start, size, KASAN_VMALLOC_INVALID);
>  }
>  
> +void kasan_unpoison_vmalloc(const void *start, unsigned long size)
> +{
> +	if (!is_vmalloc_or_module_addr(start))
> +		return;
> +
> +	kasan_unpoison_shadow(start, size);
> +}
> +
>  static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  					void *unused)
>  {
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4d3b3d60d893..6e865cea846c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1061,6 +1061,26 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
>  	return nva_start_addr;
>  }
>  
> +/*
> + * Free a region of KVA allocated by alloc_vmap_area
> + */
> +static void free_vmap_area(struct vmap_area *va)
> +{
> +	/*
> +	 * Remove from the busy tree/list.
> +	 */
> +	spin_lock(&vmap_area_lock);
> +	unlink_va(va, &vmap_area_root);
> +	spin_unlock(&vmap_area_lock);
> +
> +	/*
> +	 * Insert/Merge it back to the free tree/list.
> +	 */
> +	spin_lock(&free_vmap_area_lock);
> +	merge_or_add_vmap_area(va, &free_vmap_area_root, &free_vmap_area_list);
> +	spin_unlock(&free_vmap_area_lock);
> +}
> +
>  /*
>   * Allocate a region of KVA of the specified size and alignment, within the
>   * vstart and vend.
> @@ -1073,6 +1093,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	struct vmap_area *va, *pva;
>  	unsigned long addr;
>  	int purged = 0;
> +	int ret;
>  
>  	BUG_ON(!size);
>  	BUG_ON(offset_in_page(size));
> @@ -1139,6 +1160,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->va_end = addr + size;
>  	va->vm = NULL;
>  
> +
>  	spin_lock(&vmap_area_lock);
>  	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
>  	spin_unlock(&vmap_area_lock);
> @@ -1147,6 +1169,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	BUG_ON(va->va_start < vstart);
>  	BUG_ON(va->va_end > vend);
>  
> +	ret = kasan_populate_vmalloc(addr, size);
> +	if (ret) {
> +		free_vmap_area(va);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return va;
>  
>  overflow:
> @@ -1185,26 +1213,6 @@ int unregister_vmap_purge_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
>  
> -/*
> - * Free a region of KVA allocated by alloc_vmap_area
> - */
> -static void free_vmap_area(struct vmap_area *va)
> -{
> -	/*
> -	 * Remove from the busy tree/list.
> -	 */
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> -
> -	/*
> -	 * Insert/Merge it back to the free tree/list.
> -	 */
> -	spin_lock(&free_vmap_area_lock);
> -	merge_or_add_vmap_area(va, &free_vmap_area_root, &free_vmap_area_list);
> -	spin_unlock(&free_vmap_area_lock);
> -}
> -
>  /*
>   * Clear the pagetable entries of a given vmap_area
>   */
> @@ -1771,6 +1779,8 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	BUG_ON(addr > VMALLOC_END);
>  	BUG_ON(!PAGE_ALIGNED(addr));
>  
> +	kasan_poison_vmalloc(mem, size);
> +
>  	if (likely(count <= VMAP_MAX_ALLOC)) {
>  		debug_check_no_locks_freed(mem, size);
>  		vb_free(mem, size);
> @@ -1821,6 +1831,9 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
>  		addr = va->va_start;
>  		mem = (void *)addr;
>  	}
> +
> +	kasan_unpoison_vmalloc(mem, size);
> +
>  	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
>  		vm_unmap_ram(mem, count);
>  		return NULL;
> @@ -2075,6 +2088,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  {
>  	struct vmap_area *va;
>  	struct vm_struct *area;
> +	unsigned long requested_size = size;
>  
>  	BUG_ON(in_interrupt());
>  	size = PAGE_ALIGN(size);
> @@ -2098,23 +2112,9 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  		return NULL;
>  	}
>  
> -	setup_vmalloc_vm(area, va, flags, caller);
> +	kasan_unpoison_vmalloc((void *)va->va_start, requested_size);
>  
> -	/*
> -	 * For KASAN, if we are in vmalloc space, we need to cover the shadow
> -	 * area with real memory. If we come here through VM_ALLOC, this is
> -	 * done by a higher level function that has access to the true size,
> -	 * which might not be a full page.
> -	 *
> -	 * We assume module space comes via VM_ALLOC path.
> -	 */
> -	if (is_vmalloc_addr(area->addr) && !(area->flags & VM_ALLOC)) {
> -		if (kasan_populate_vmalloc(area->size, area)) {
> -			unmap_vmap_area(va);
> -			kfree(area);
> -			return NULL;
> -		}
> -	}
> +	setup_vmalloc_vm(area, va, flags, caller);
>  
>  	return area;
>  }
> @@ -2293,8 +2293,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
>  	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
>  
> -	if (area->flags & VM_KASAN)
> -		kasan_poison_vmalloc(area->addr, area->size);
> +	kasan_poison_vmalloc(area->addr, area->size);
>  
>  	vm_remove_mappings(area, deallocate_pages);
>  
> @@ -2539,7 +2538,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
>  		goto fail;
>  
> -	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
> +	area = __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZED |
>  				vm_flags, start, end, node, gfp_mask, caller);
>  	if (!area)
>  		goto fail;
> @@ -2548,11 +2547,6 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	if (!addr)
>  		return NULL;
>  
> -	if (is_vmalloc_or_module_addr(area->addr)) {
> -		if (kasan_populate_vmalloc(real_size, area))
> -			return NULL;
> -	}
> -
>  	/*
>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
>  	 * flag. It means that vm_struct is not fully initialized.
> @@ -3437,7 +3431,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  	/* populate the shadow space outside of the lock */
>  	for (area = 0; area < nr_vms; area++) {
>  		/* assume success here */
> -		kasan_populate_vmalloc(sizes[area], vms[area]);
> +		kasan_populate_vmalloc(vas[area]->va_start, sizes[area]);
> +		kasan_unpoison_vmalloc((void *)vms[area]->addr, sizes[area]);
>  	}
>  
>  	kfree(vas);
> -- 
> 2.23.0
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
> 

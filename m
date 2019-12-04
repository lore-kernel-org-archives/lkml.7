Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5880B2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="o226C2dU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfLDMBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:01:08 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35009 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:01:07 -0500
Received: by mail-pj1-f65.google.com with SMTP id w23so1843025pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 04:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rxuqclm9QwY2ereJARQY1d6ZkLRCh/xjgCtTC93zfPo=;
        b=o226C2dULfmUDr0BQEdkSMrxbKZlF0YsReHlmWpu0HD1jCMAuRmq8WvVsuQEdsdGUq
         iYbof4d1IwosFjuLWbPl5Gj7UuXXt3hmkiFAEG8NrImPOFIKaDbVpHDQjaF+8NF1xQul
         +00MaeYlFYj1olJiEnSNyu9J++ZTWHpWwzoQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rxuqclm9QwY2ereJARQY1d6ZkLRCh/xjgCtTC93zfPo=;
        b=psaKV2un6dy6riJ4+rietCtvz2eIb083U6hivSu2QZXxdEqA4AqPnpmRKTS7LhKgjD
         HUz+KaEtvynkNwCIJthNLvRY/LcVT/uy05OmDRec81kamEY3b09q83RMiFVqCEX0GEFj
         aaSkdNj1aA8CMazF/MocfOVpEHh7zVx+n4p6cclf/eA25S84JjvkqcGrpZB7xGkQ4U5g
         LSgK/Z7WfTujX8pI6TaksWyeH6FvdqGlyRxVOBExAEiEUSpi8cbtOmvziKdKc3SB9iRb
         BEe1DOvNx1tu9v5wCCZuRLzZn2jjo2fwsw+ojaCc0JKFarvm555CCOf3OOvHgGoq6Rx8
         0FtQ==
X-Gm-Message-State: APjAAAWW64Mn3eFOFqiZz+E6eUkCvIozAm9JZQjGfndvQMuZLNFsIxzO
        CuvsebY0ejwP5UM5GuM6qyZ15A==
X-Google-Smtp-Source: APXvYqyiU64pxVtfwk19lTp6OAlAwooc2uydvO+Tn53C5HmVtdHu3CyDzSs9eFN6bLk3EPcRccKYvQ==
X-Received: by 2002:a17:902:bf08:: with SMTP id bi8mr2861953plb.75.1575460866914;
        Wed, 04 Dec 2019 04:01:06 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-7daa-d2ea-7edb-cfe8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:7daa:d2ea:7edb:cfe8])
        by smtp.gmail.com with ESMTPSA id u7sm7598987pfh.84.2019.12.04.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 04:01:06 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] kasan: support vmalloc backing of vm_map_ram()
In-Reply-To: <20191129154519.30964-1-dja@axtens.net>
References: <20191129154519.30964-1-dja@axtens.net>
Date:   Wed, 04 Dec 2019 23:01:02 +1100
Message-ID: <87h82ge1vl.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've realised this throws a few compile warnings, I'll respin it.

Daniel Axtens <dja@axtens.net> writes:

> This fixes some crashes in xfs, binder and the i915 mock_selftests,
> with kasan vmalloc, where no shadow space was being allocated when
> vm_map_ram was called.
>
> vm_map_ram has two paths, a path that uses vmap_block and a path
> that uses alloc_vmap_area. The alloc_vmap_area path is straight-forward,
> we handle it like most other allocations.
>
> For the vmap_block case, we map a shadow for the entire vmap_block
> when the block is allocated, and unpoison it piecewise in vm_map_ram().
> It already gets cleaned up when the block is released in the lazy vmap
> area freeing path.
>
> For both cases, we need to tweak the interface to allow for vmalloc
> addresses that don't have an attached vm_struct.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Qian Cai <cai@lca.pw>
> Thanks-to: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  include/linux/kasan.h |  6 ++++++
>  mm/kasan/common.c     | 37 +++++++++++++++++++++++--------------
>  mm/vmalloc.c          | 24 ++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 4f404c565db1..0b50b59a8ff5 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -207,6 +207,7 @@ static inline void *kasan_reset_tag(const void *addr)
>  #ifdef CONFIG_KASAN_VMALLOC
>  int kasan_populate_vmalloc(unsigned long requested_size,
>  			   struct vm_struct *area);
> +int kasan_populate_vmalloc_area(unsigned long size, void *addr);
>  void kasan_poison_vmalloc(void *start, unsigned long size);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
> @@ -218,6 +219,11 @@ static inline int kasan_populate_vmalloc(unsigned long requested_size,
>  	return 0;
>  }
>  
> +static inline int kasan_populate_vmalloc_area(unsigned long size, void *addr)
> +{
> +	return 0;
> +}
> +
>  static inline void kasan_poison_vmalloc(void *start, unsigned long size) {}
>  static inline void kasan_release_vmalloc(unsigned long start,
>  					 unsigned long end,
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index df3371d5c572..27d8522ffaad 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -779,27 +779,15 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  
>  int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
>  {
> -	unsigned long shadow_start, shadow_end;
>  	int ret;
> -
> -	shadow_start = (unsigned long)kasan_mem_to_shadow(area->addr);
> -	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> -	shadow_end = (unsigned long)kasan_mem_to_shadow(area->addr +
> -							area->size);
> -	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> -
> -	ret = apply_to_page_range(&init_mm, shadow_start,
> -				  shadow_end - shadow_start,
> -				  kasan_populate_vmalloc_pte, NULL);
> +	ret = kasan_populate_vmalloc_area(area->size, area->addr);
>  	if (ret)
>  		return ret;
>  
> -	flush_cache_vmap(shadow_start, shadow_end);
> +	area->flags |= VM_KASAN;
>  
>  	kasan_unpoison_shadow(area->addr, requested_size);
>  
> -	area->flags |= VM_KASAN;
> -
>  	/*
>  	 * We need to be careful about inter-cpu effects here. Consider:
>  	 *
> @@ -838,6 +826,27 @@ int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
>  	return 0;
>  }
>  
> +int kasan_populate_vmalloc_area(unsigned long size, void *addr)
> +{
> +	unsigned long shadow_start, shadow_end;
> +	int ret;
> +
> +	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
> +	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> +	shadow_end = (unsigned long)kasan_mem_to_shadow(addr + size);
> +	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> +
> +	ret = apply_to_page_range(&init_mm, shadow_start,
> +				  shadow_end - shadow_start,
> +				  kasan_populate_vmalloc_pte, NULL);
> +	if (ret)
> +		return ret;
> +
> +	flush_cache_vmap(shadow_start, shadow_end);
> +
> +	return 0;
> +}
> +
>  /*
>   * Poison the shadow for a vmalloc region. Called as part of the
>   * freeing process at the time the region is freed.
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index bf030516258c..2896189e351f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1509,6 +1509,13 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		return ERR_CAST(va);
>  	}
>  
> +	err = kasan_populate_vmalloc_area(VMAP_BLOCK_SIZE, va->va_start);
> +	if (unlikely(err)) {
> +		kfree(vb);
> +		free_vmap_area(va);
> +		return ERR_PTR(err);
> +	}
> +
>  	err = radix_tree_preload(gfp_mask);
>  	if (unlikely(err)) {
>  		kfree(vb);
> @@ -1554,6 +1561,7 @@ static void free_vmap_block(struct vmap_block *vb)
>  	spin_unlock(&vmap_block_tree_lock);
>  	BUG_ON(tmp != vb);
>  
> +	/* free_vmap_area will take care of freeing the shadow */
>  	free_vmap_area_noflush(vb->va);
>  	kfree_rcu(vb, rcu_head);
>  }
> @@ -1780,6 +1788,8 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	if (likely(count <= VMAP_MAX_ALLOC)) {
>  		debug_check_no_locks_freed(mem, size);
>  		vb_free(mem, size);
> +		kasan_poison_vmalloc(mem, size);
> +
>  		return;
>  	}
>  
> @@ -1787,6 +1797,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	BUG_ON(!va);
>  	debug_check_no_locks_freed((void *)va->va_start,
>  				    (va->va_end - va->va_start));
> +	/* vmap area purging will clean up the KASAN shadow later */
>  	free_unmap_vmap_area(va);
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);
> @@ -1817,6 +1828,11 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
>  		if (IS_ERR(mem))
>  			return NULL;
>  		addr = (unsigned long)mem;
> +
> +		/*
> +		 * We don't need to call kasan_populate_vmalloc_area here, as
> +		 * it's done at block allocation time.
> +		 */
>  	} else {
>  		struct vmap_area *va;
>  		va = alloc_vmap_area(size, PAGE_SIZE,
> @@ -1826,7 +1842,15 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
>  
>  		addr = va->va_start;
>  		mem = (void *)addr;
> +
> +		if (kasan_populate_vmalloc_area(size, mem)) {
> +			vm_unmap_ram(mem, count);
> +			return NULL;
> +		}
>  	}
> +
> +	kasan_unpoison_shadow(mem, size);
> +
>  	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
>  		vm_unmap_ram(mem, count);
>  		return NULL;
> -- 
> 2.20.1

Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9046CC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8AB20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551473508;
	bh=IaK8UvDCL46OVaP7yNeSx0tKacHKQ4TE+DqwpWLWcAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ubEdj8OwHTHhndMm7goywtCyM+Db5ciHlqmHZiT4V1EicyuZJG/kbd/eU0S1F6tMn
	 tVhuGThuj+1tRLu726D6OUH/s3LKCCMLdWAT71GDN9hLuhCl7XujueHVF4qd+Y8Rdr
	 rpUGr5nRw3Y6yJZ/8FgpIGVJFdu3G73lSGp+v+ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfCAUvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:51:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAUvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:51:46 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E8EAD719;
        Fri,  1 Mar 2019 20:51:45 +0000 (UTC)
Date:   Fri, 1 Mar 2019 12:51:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mhocko@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Arun KS <arunks@codeaurora.org>
Subject: Re: [PATCH v2] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
Message-Id: <20190301125144.1f4ce76a8e7bcd2688181f48@linux-foundation.org>
In-Reply-To: <20190301201950.96637-1-cai@lca.pw>
References: <20190301201950.96637-1-cai@lca.pw>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Mar 2019 15:19:50 -0500 Qian Cai <cai@lca.pw> wrote:

> When onlining a memory block with DEBUG_PAGEALLOC, it unmaps the pages
> in the block from kernel, However, it does not map those pages while
> offlining at the beginning. As the result, it triggers a panic below
> while onlining on ppc64le as it checks if the pages are mapped before
> unmapping. However, the imbalance exists for all arches where
> double-unmappings could happen. Therefore, let kernel map those pages in
> generic_online_page() before they have being freed into the page
> allocator for the first time where it will set the page count to one.
> 
> On the other hand, it works fine during the boot, because at least for
> IBM POWER8, it does,
> 
> early_setup
>   early_init_mmu
>     harsh__early_init_mmu
>       htab_initialize [1]
>         htab_bolt_mapping [2]
> 
> where it effectively map all memblock regions just like
> kernel_map_linear_page(), so later mem_init() -> memblock_free_all()
> will unmap them just fine without any imbalance. On other arches without
> this imbalance checking, it still unmap them once at the most.
> 
> [1]
> for_each_memblock(memory, reg) {
>         base = (unsigned long)__va(reg->base);
>         size = reg->size;
> 
>         DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
>                 base, size, prot);
> 
>         BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
>                 prot, mmu_linear_psize, mmu_kernel_ssize));
>         }
> 
> [2] linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;
> 
> kernel BUG at arch/powerpc/mm/hash_utils_64.c:1815!
>
> ...
>
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -660,6 +660,7 @@ static void generic_online_page(struct page *page)
>  {
>  	__online_page_set_limits(page);
>  	__online_page_increment_counters(page);
> +	kernel_map_pages(page, 1, 1);
>  	__online_page_free(page);
>  }

This code was changed a lot by Arun's "mm/page_alloc.c: memory hotplug:
free pages as higher order".

I don't think hotplug+DEBUG_PAGEALLOC is important enough to disrupt
memory_hotplug-free-pages-as-higher-order.patch, which took a long time
to sort out.  So could you please take a look at linux-next, determine
whether the problem is still there and propose a suitable patch?

Thanks.

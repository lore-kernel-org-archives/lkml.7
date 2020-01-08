Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A76C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AEF2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578487364;
	bh=lKLP2YPmu9sdL3Qd/2SvT9YisTqhtX5Fet6f6uoRdD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wvczk5PRpr6yZ6OYULqp4u6PGpEl7kI2X043uxldcIw6JgJ8/mWwgHq1coFKQDRgB
	 tKRnRZ6KAUO/c6M54bzzEb4JtQVao1qnK1EFkh/loME2mfehCPLF8RY6yzTPlTYQnx
	 5C5IiOLphjM9dA3qXTMdZ8yG9FomLa3r8aMpM2q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgAHMmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:42:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34831 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:42:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2369312wmb.0;
        Wed, 08 Jan 2020 04:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oL7AiyezFSaPUSQINsQX9lIy1KtBrah03q1c+vdGl70=;
        b=F/rBzDHwJpWDhQRb5i9IbsWTdOG2XsVxH+f6i93PbVO1mbqgwI64ACIUpQDCkbiRkE
         Xpc3nl/YUteTxYHPSYVMjRbT5PCieuPCSCREN4zXvS4u4s3zlI9N+sqVmYNcZeg67rW8
         SDpCkywtTYz3DLVm0cCkPuZt5hZOizfGucBVF2+mbSiE+HDIViucCO/PHMavSEktc5hU
         dBVkS2+pQo061+XWskpAa1SaODP7d97Z206S035CaMek+eOMaEf/jhkXTdhNLEdg8GIM
         XC2wL7f8Yo0cR2oIW7nOX/Ny4luAcE/ST/7KYemjS0Pu+6hRjgD3HRS/S4ws9phHwsQw
         giaw==
X-Gm-Message-State: APjAAAWkOjzlImaxKv9mxN3N1zBVWFV72NFOTt+1TFJqpnnYtlaGmAqr
        v86NeEXbvpguyTaPEQQ9Tl8=
X-Google-Smtp-Source: APXvYqwKFA4+cgBJREYNaAxy2zZsIKi5z4WvcBbaIX9+DBXR03grpLlZ4iuekK3XvVeBMtqSIy9dvg==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr3768023wmd.115.1578487359562;
        Wed, 08 Jan 2020 04:42:39 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id o7sm3546994wmh.11.2020.01.08.04.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 04:42:38 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:42:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Subject: Re: [PATCH v2 7/8] mm/memory_hotplug: Add pgprot_t to mhp_modifiers
Message-ID: <20200108124238.GS32178@dhcp22.suse.cz>
References: <20200107205959.7575-1-logang@deltatee.com>
 <20200107205959.7575-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107205959.7575-8-logang@deltatee.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-01-20 13:59:58, Logan Gunthorpe wrote:
> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
> struct page mappings for IO memory. At present, these mappings are created
> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, on
> x86, an mtrr register will typically override this and force the cache
> type to be UC-. In the case firmware doesn't set this register it is
> effectively WB and will typically result in a machine check exception
> when it's accessed.
> 
> Other arches are not currently likely to function correctly seeing they
> don't have any MTRR registers to fall back on.
> 
> To solve this, add an argument to arch_add_memory() to explicitly
> set the pgprot value to a specific value.
> 
> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
> simple change to pass the pgprot_t down to their respective functions
> which set up the page tables. For x86_32, set the page tables explicitly
> using _set_memory_prot() (seeing they are already mapped). For sh, reject
> anything but PAGE_KERNEL settings -- this should be fine, for now, seeing
> sh doesn't support ZONE_DEVICE anyway.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

OK, this is less code churn than I expected. Having pgprot as an implcit
parameter de-facto is a bit fragile though. Should we add a WARN_ON_ONCE
(e.g. into the add_pages to catch all arches) for value 0?

Other than that
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arm64/mm/mmu.c            | 3 ++-
>  arch/ia64/mm/init.c            | 4 ++++
>  arch/powerpc/mm/mem.c          | 3 ++-
>  arch/s390/mm/init.c            | 2 +-
>  arch/sh/mm/init.c              | 3 +++
>  arch/x86/mm/init_32.c          | 5 +++++
>  arch/x86/mm/init_64.c          | 2 +-
>  include/linux/memory_hotplug.h | 2 ++
>  mm/memory_hotplug.c            | 2 +-
>  mm/memremap.c                  | 6 +++---
>  10 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3320406579c3..9b214b0d268f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1058,7 +1058,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -			     size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
> +			     size, modifiers->pgprot, __pgd_pgtable_alloc,
> +			     flags);
>  
>  	memblock_clear_nomap(start, size);
>  
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index daf438e08b96..5fd6ae4929c9 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -677,6 +677,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	int ret;
>  
>  	ret = __add_pages(nid, start_pfn, nr_pages, modifiers);
> +	if (modifiers->pgprot != PAGE_KERNEL)
> +		return -EINVAL;
> +
> +	ret = __add_pages(nid, start_pfn, nr_pages, restrictions);
>  	if (ret)
>  		printk("%s: Problem encountered in __add_pages() as ret=%d\n",
>  		       __func__,  ret);
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 631ee684721f..fddeaee53198 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -137,7 +137,8 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>  	resize_hpt_for_hotplug(memblock_phys_mem_size());
>  
>  	start = (unsigned long)__va(start);
> -	rc = create_section_mapping(start, start + size, nid, PAGE_KERNEL);
> +	rc = create_section_mapping(start, start + size, nid,
> +				    modifiers->pgprot);
>  	if (rc) {
>  		pr_warn("Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
>  			start, start + size, rc);
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index ef19522ddad2..c65fb33f6a89 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -277,7 +277,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (WARN_ON_ONCE(modifiers->altmap))
>  		return -EINVAL;
>  
> -	rc = vmem_add_mapping(start, size, PAGE_KERNEL);
> +	rc = vmem_add_mapping(start, size, modifiers->pgprot);
>  	if (rc)
>  		return rc;
>  
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 7e64f42fb570..7071dc5bd2e4 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,6 +412,9 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  	int ret;
>  
> +	if (modifiers->pgprot != PAGE_KERNEL)
> +		return -EINVAL;
> +
>  	/* We only have ZONE_NORMAL, so this is easy.. */
>  	ret = __add_pages(nid, start_pfn, nr_pages, modifiers);
>  	if (unlikely(ret))
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index 630d8a36fcd7..737da0dbc0d5 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -857,6 +857,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	int ret;
> +
> +	ret = _set_memory_prot(start, nr_pages, modifiers->pgprot);
> +	if (ret)
> +		return ret;
>  
>  	return __add_pages(nid, start_pfn, nr_pages, modifiers);
>  }
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 17ea0bfc0b83..cc9eb45ad120 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -868,7 +868,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  
> -	init_memory_mapping(start, start + size, PAGE_KERNEL);
> +	init_memory_mapping(start, start + size, modifiers->pgprot);
>  
>  	return add_pages(nid, start_pfn, nr_pages, modifiers);
>  }
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 2152efae2f4b..00dfb2016737 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -56,9 +56,11 @@ enum {
>  /*
>   * Restrictions for the memory hotplug:
>   * altmap: alternative allocator for memmap array
> + * pgprot: page protection flags to apply to newly added page tables
>   */
>  struct mhp_modifiers {
>  	struct vmem_altmap *altmap;
> +	pgprot_t pgprot;
>  };
>  
>  /*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1bb3f92e087d..0888f821af06 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1027,7 +1027,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>   */
>  int __ref add_memory_resource(int nid, struct resource *res)
>  {
> -	struct mhp_modifiers modifiers = {};
> +	struct mhp_modifiers modifiers = {.pgprot = PAGE_KERNEL};
>  	u64 start, size;
>  	bool new_node = false;
>  	int ret;
> diff --git a/mm/memremap.c b/mm/memremap.c
> index e30be8ba706b..45ab4ef0643d 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -163,8 +163,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  		 * We do not want any optional features only our own memmap
>  		 */
>  		.altmap = pgmap_altmap(pgmap),
> +		.pgprot = PAGE_KERNEL,
>  	};
> -	pgprot_t pgprot = PAGE_KERNEL;
>  	int error, is_ram;
>  	bool need_devmap_managed = true;
>  
> @@ -252,8 +252,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>  	if (nid < 0)
>  		nid = numa_mem_id();
>  
> -	error = track_pfn_remap(NULL, &pgprot, PHYS_PFN(res->start), 0,
> -			resource_size(res));
> +	error = track_pfn_remap(NULL, &modifiers.pgprot, PHYS_PFN(res->start),
> +				0, resource_size(res));
>  	if (error)
>  		goto err_pfn_remap;
>  
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs

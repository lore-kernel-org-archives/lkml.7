Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FAC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E342190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817770;
	bh=dpuT6DAOEvg4WPEHSOsY4+pS2JlF9VtnrxTopY/3FOw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=zCetaIUT5Tmp6m4YZNyzTN1supSJpuvGx6waCE+nec6/QPW2YeVnF0YBCmcYuS80C
	 5vHoqvOwSPtTQyy+xnq1CEdJtQ++EiDuYmWNx51MyFkB2iTc6nsnsVeeIwego9TlIW
	 4BX7b5lsnCna/xXTLoPeF92exHyEmaXEvmPf9Lpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfGVRt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfGVRt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:49:28 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C949121901;
        Mon, 22 Jul 2019 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817768;
        bh=dpuT6DAOEvg4WPEHSOsY4+pS2JlF9VtnrxTopY/3FOw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bmU7+lHFMC6G9n30drUObfx5tIH8zoeLGSUgniKCI29RDnLHESnRNeOVwqq04qpR6
         07uREYjtp1saf0PEnSkBJ9CoHlSjdAo8Kzb7mV1/Fzi/N08kGDxcheCDEwKvdrkG1V
         QJiySjx1XtkLhsmi5W6iXjBRpE5l3gxAi4+PbcCI=
Date:   Mon, 22 Jul 2019 10:49:27 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] xen: avoid link error on ARM
In-Reply-To: <20190722074705.2082153-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1907221041420.31177@sstabellini-ThinkPad-T480s>
References: <20190722074705.2082153-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Arnd Bergmann wrote:
> Building the privcmd code as a loadable module on ARM, we get
> a link error due to the private cache management functions:
> 
> ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> 
> Move the code into a new that is always built in when Xen is enabled,
> as suggested by Juergen Gross and Boris Ostrovsky.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rename mm.o to xen-builtin.o, make it unconditional
> v3: move new code into xlate_mmu as suggested by Boris Ostrovsky.
>     sorry for the long delay since v2, I lost track of this.
> ---
>  drivers/xen/privcmd.c   | 35 +++++------------------------------
>  drivers/xen/xlate_mmu.c | 32 ++++++++++++++++++++++++++++++++
>  include/xen/xen-ops.h   |  3 +++
>  3 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 2f5ce7230a43..c6070e70dd73 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -724,25 +724,6 @@ static long privcmd_ioctl_restrict(struct file *file, void __user *udata)
>  	return 0;
>  }
>  
> -struct remap_pfn {
> -	struct mm_struct *mm;
> -	struct page **pages;
> -	pgprot_t prot;
> -	unsigned long i;
> -};
> -
> -static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
> -{
> -	struct remap_pfn *r = data;
> -	struct page *page = r->pages[r->i];
> -	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
> -
> -	set_pte_at(r->mm, addr, ptep, pte);
> -	r->i++;
> -
> -	return 0;
> -}
> -
>  static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
>  {
>  	struct privcmd_data *data = file->private_data;
> @@ -774,7 +755,8 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
>  		goto out;
>  	}
>  
> -	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> +	if (IS_ENABLED(CONFIG_XEN_AUTO_XLATE) &&
> +	    xen_feature(XENFEAT_auto_translated_physmap)) {

The patch looks good. I tested it and works as intended. Instead of
adding the additional IS_ENABLED check, I would have gone with providing
an empty implementation of xen_remap_vma_range as a static inline
function, if CONFIG_XEN_AUTO_XLATE is not enabled.

Either way:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


>  		unsigned int nr = DIV_ROUND_UP(kdata.num, XEN_PFN_PER_PAGE);
>  		struct page **pages;
>  		unsigned int i;
> @@ -808,16 +790,9 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
>  	if (rc)
>  		goto out;
>  
> -	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> -		struct remap_pfn r = {
> -			.mm = vma->vm_mm,
> -			.pages = vma->vm_private_data,
> -			.prot = vma->vm_page_prot,
> -		};
> -
> -		rc = apply_to_page_range(r.mm, kdata.addr,
> -					 kdata.num << PAGE_SHIFT,
> -					 remap_pfn_fn, &r);
> +	if (IS_ENABLED(CONFIG_XEN_AUTO_XLATE) &&
> +	    xen_feature(XENFEAT_auto_translated_physmap)) {
> +		rc = xen_remap_vma_range(vma, kdata.addr, kdata.num << PAGE_SHIFT);
>  	} else {
>  		unsigned int domid =
>  			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
> diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> index ba883a80b3c0..7b1077f0abcb 100644
> --- a/drivers/xen/xlate_mmu.c
> +++ b/drivers/xen/xlate_mmu.c
> @@ -262,3 +262,35 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t **gfns, void **virt,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(xen_xlate_map_ballooned_pages);
> +
> +struct remap_pfn {
> +	struct mm_struct *mm;
> +	struct page **pages;
> +	pgprot_t prot;
> +	unsigned long i;
> +};
> +
> +static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	struct remap_pfn *r = data;
> +	struct page *page = r->pages[r->i];
> +	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
> +
> +	set_pte_at(r->mm, addr, ptep, pte);
> +	r->i++;
> +
> +	return 0;
> +}
> +
> +/* Used by the privcmd module, but has to be built-in on ARM */
> +int xen_remap_vma_range(struct vm_area_struct *vma, unsigned long addr, unsigned long len)
> +{
> +	struct remap_pfn r = {
> +		.mm = vma->vm_mm,
> +		.pages = vma->vm_private_data,
> +		.prot = vma->vm_page_prot,
> +	};
> +
> +	return apply_to_page_range(vma->vm_mm, addr, len, remap_pfn_fn, &r);
> +}
> +EXPORT_SYMBOL_GPL(xen_remap_vma_range);
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index 4969817124a8..98b30c1613b2 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -109,6 +109,9 @@ static inline int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +int xen_remap_vma_range(struct vm_area_struct *vma, unsigned long addr,
> +			unsigned long len);
> +
>  /*
>   * xen_remap_domain_gfn_array() - map an array of foreign frames by gfn
>   * @vma:     VMA to map the pages into
> -- 
> 2.20.0
> 

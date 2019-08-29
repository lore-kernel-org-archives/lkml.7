Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEBD22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118830;
	bh=sm/nKdM9UsIhUb6FhRZ+kQtsA7U5a/JALl6VUJ4+q2Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=1c929uP3bIeKytVeAm1hCGl0E50yJO8aUGFHLWd0Oje/jGVq6QO02EByJJr9DYAfu
	 urYMMugIX5YgwIbTQnfTUsPqfwjdIbDIeXsy9kPSk5sX+dRfGkbuhN2GsDLtw+ZreF
	 9CLi15ij4z30iMUjLweB5+dpv3Ph0Cz632cfXevc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfH2WrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfH2WrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:47:08 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A34F22CEA;
        Thu, 29 Aug 2019 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118827;
        bh=sm/nKdM9UsIhUb6FhRZ+kQtsA7U5a/JALl6VUJ4+q2Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CVS10g5rx/XTa3zAqZYWqPzwDeS4hTCFiG0WkGUDDDvXuwqoTWMRvCZy+4vIOeCa2
         EitnmAkmPhgz8IptegpIpXy8m7xG5dzQc1bFjFWw2Ct4h9eHOTj1kDXw4/JUM1rcEQ
         U7l6bmF3dACn+UY4Le2fqo/wliNCIcEHTnE8qZXE=
Date:   Thu, 29 Aug 2019 15:47:06 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] swiotlb-xen: use the same foreign page check
 everywhere
In-Reply-To: <20190826121944.515-8-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281506430.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-8-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> xen_dma_map_page uses a different and more complicated check for foreign
> pages than the other three cache maintainance helpers.  Switch it to the
> simpler pfn_valid method a well, and document the scheme with a single
> improved comment in xen_dma_map_page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  include/xen/arm/page-coherent.h | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
> index 0e244f4fec1a..07c104dbc21f 100644
> --- a/include/xen/arm/page-coherent.h
> +++ b/include/xen/arm/page-coherent.h
> @@ -41,23 +41,17 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
>  	     dma_addr_t dev_addr, unsigned long offset, size_t size,
>  	     enum dma_data_direction dir, unsigned long attrs)
>  {
> -	unsigned long page_pfn = page_to_xen_pfn(page);
> -	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> -	unsigned long compound_pages =
> -		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> -	bool local = (page_pfn <= dev_pfn) &&
> -		(dev_pfn - page_pfn < compound_pages);
> +	unsigned long pfn = PFN_DOWN(dev_addr);
>  
>  	/*
> -	 * Dom0 is mapped 1:1, while the Linux page can span across
> -	 * multiple Xen pages, it's not possible for it to contain a
> -	 * mix of local and foreign Xen pages. So if the first xen_pfn
> -	 * == mfn the page is local otherwise it's a foreign page
> -	 * grant-mapped in dom0. If the page is local we can safely
> -	 * call the native dma_ops function, otherwise we call the xen
> -	 * specific function.
> +	 * Dom0 is mapped 1:1, and while the Linux page can span across multiple
> +	 * Xen pages, it is not possible for it to contain a mix of local and
> +	 * foreign Xen pages.  Calling pfn_valid on a foreign mfn will always
> +	 * return false, so if pfn_valid returns true the pages is local and we
> +	 * can use the native dma-direct functions, otherwise we call the Xen
> +	 * specific version.
>  	 */
> -	if (local)
> +	if (pfn_valid(pfn))
>  		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
>  	else
>  		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> @@ -67,14 +61,7 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	unsigned long pfn = PFN_DOWN(handle);
> -	/*
> -	 * Dom0 is mapped 1:1, while the Linux page can be spanned accross
> -	 * multiple Xen page, it's not possible to have a mix of local and
> -	 * foreign Xen page. Dom0 is mapped 1:1, so calling pfn_valid on a
> -	 * foreign mfn will always return false. If the page is local we can
> -	 * safely call the native dma_ops function, otherwise we call the xen
> -	 * specific function.
> -	 */
> +
>  	if (pfn_valid(pfn))
>  		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
>  	else
> -- 
> 2.20.1
> 

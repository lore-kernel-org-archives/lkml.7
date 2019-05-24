Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D35C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F82320675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbfEXQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:15:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:45431 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390532AbfEXQPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:15:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 09:15:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,507,1549958400"; 
   d="scan'208";a="177765957"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 24 May 2019 09:15:23 -0700
Date:   Fri, 24 May 2019 09:16:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: Re: [PATCH v3 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
Message-ID: <20190524161618.GB23100@iweiny-DESK2.sc.intel.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
 <20190524040633.16854-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524040633.16854-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:06:33PM -0700, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to always allocate one single page from CMA area.
> Since the CMA area has a limited predefined size of space, it may
> run out of space in heavy use cases, where there might be quite a
> lot CMA pages being allocated for single pages.
> 
> However, there is also a concern that a device might care where a
> page comes from -- it might expect the page from CMA area and act
> differently if the page doesn't.

How does a device know, after this call, if a CMA area was used?  From the
patches I figured a device should not care.

> 
> This patch tries to use the fallback alloc_pages path, instead of
> one-page size allocations from the global CMA area in case that a
> device does not have its own CMA area. This'd save resources from
> the CMA global area for more CMA allocations, and also reduce CMA
> fragmentations resulted from trivial allocations.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  kernel/dma/contiguous.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 21f39a6cb04f..6914b92d5c88 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -223,14 +223,23 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>   * This function allocates contiguous memory buffer for specified device. It
>   * first tries to use device specific contiguous memory area if available or
>   * the default global one, then tries a fallback allocation of normal pages.
> + *
> + * Note that it byapss one-page size of allocations from the global area as
> + * the addresses within one page are always contiguous, so there is no need
> + * to waste CMA pages for that kind; it also helps reduce fragmentations.
>   */
>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  {
>  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
>  	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	size_t align = get_order(PAGE_ALIGN(size));
> -	struct cma *cma = dev_get_cma_area(dev);
>  	struct page *page = NULL;
> +	struct cma *cma = NULL;
> +
> +	if (dev && dev->cma_area)
> +		cma = dev->cma_area;
> +	else if (count > 1)
> +		cma = dma_contiguous_default_area;

Doesn't dev_get_dma_area() already do this?

Ira

>  
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (cma && gfpflags_allow_blocking(gfp)) {
> -- 
> 2.17.1
> 

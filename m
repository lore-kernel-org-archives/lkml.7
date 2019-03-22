Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D20221900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfCVK5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:57:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41762 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfCVK5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:57:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F220374;
        Fri, 22 Mar 2019 03:57:18 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D8C3F575;
        Fri, 22 Mar 2019 03:57:15 -0700 (PDT)
Date:   Fri, 22 Mar 2019 10:57:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Message-ID: <20190322105712.GB13384@arrakis.emea.arm.com>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
 <20190321233248.GA6941@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321233248.GA6941@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Thu, Mar 21, 2019 at 04:32:49PM -0700, Nicolin Chen wrote:
> On Tue, Mar 19, 2019 at 02:43:01PM +0000, Catalin Marinas wrote:
> > On Tue, Mar 05, 2019 at 10:32:02AM -0800, Nicolin Chen wrote:
> > > The addresses within a single page are always contiguous, so it's
> > > not so necessary to always allocate one single page from CMA area.
> > > Since the CMA area has a limited predefined size of space, it may
> > > run out of space in heavy use cases, where there might be quite a
> > > lot CMA pages being allocated for single pages.
> > > 
> > > However, there is also a concern that a device might care where a
> > > page comes from -- it might expect the page from CMA area and act
> > > differently if the page doesn't.
> > > 
> > > This patch tries to get normal pages for single-page allocations
> > > unless the device has its own CMA area. This would save resources
> > > from the CMA area for more CMA allocations. And it'd also reduce
> > > CMA fragmentations resulted from trivial allocations.
> > 
> > This is not sufficient. Some architectures/platforms declare limits on
> > the CMA range so that DMA is possible with all expected devices. For
> > example, on arm64 we keep the CMA in the lower 4GB of the address range,
> > though with this patch you only covered the iommu ops allocation.
> 
> I will follow the way of v1 by adding alloc_page()/free_page()
> function to those callers who don't have fallback allocations.
> In this way, archs may use different callbacks to alloc pages.
> 
> > Do you have any numbers to back this up? You don't seem to address
> > dma_direct_alloc() either but, as I said above, it's not trivial since
> > some platforms expect certain physical range for DMA allocations.
> 
> What's the dma_direct_alloc() here about? Mind elaborating?

I just did a grep for dma_alloc_from_contiguous() in the 5.1-rc1 kernel
and came up with __dma_direct_alloc_pages(). Should your patch cover
this as well?

-- 
Catalin

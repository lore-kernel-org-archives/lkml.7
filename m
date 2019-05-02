Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724062075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEBN03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:26:29 -0400
Received: from verein.lst.de ([213.95.11.211]:59294 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfEBN02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:26:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ABBCA68AA6; Thu,  2 May 2019 15:26:10 +0200 (CEST)
Date:   Thu, 2 May 2019 15:26:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>, robin.murphy@arm.com,
        vdumpa@nvidia.com, linux@armlinux.org.uk, will.deacon@arm.com,
        joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Message-ID: <20190502132610.GA3107@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com> <20190326230131.16275-2-nicoleotsuka@gmail.com> <20190424150638.GA22191@lst.de> <20190424183310.GA6168@Asurada-Nvidia.nvidia.com> <20190424192652.GA29032@lst.de> <20190430152421.GE29799@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430152421.GE29799@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:24:21PM +0100, Catalin Marinas wrote:
> My reading of the arm32 __dma_alloc() is that if the conditions are
> right for the CMA allocator (allows blocking) and there is a default CMA
> area or a per-device one, the call ends up in cma_alloc() without any
> fallback if such allocation fails. Whether this is on purpose, I'm not
> entirely sure. There are a couple of arm32 SoCs which call
> dma_declare_contiguous() or dma_contiguous_reserve_area() and a few DT
> files describing a specific CMA range (e.g. arch/arm/boot/dts/sun5i.dtsi
> with a comment that address must be kept in the lower 256MB).
> 
> If ZONE_DMA is set up correctly so that cma_alloc() is (or can be made)
> interchangeable with alloc_pages(GFP_DMA) from a device DMA capability
> perspective , I think it should be fine to have such fallback.

Indeed.  I missed arm32 being different from everyone else, but we
already addresses that in another thread.  Sorry for misleading
everyone.

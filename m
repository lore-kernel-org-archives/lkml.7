Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A885C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2CD20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfCYMOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:14:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfCYMOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:14:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C12680D;
        Mon, 25 Mar 2019 05:14:42 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58333F575;
        Mon, 25 Mar 2019 05:14:39 -0700 (PDT)
Date:   Mon, 25 Mar 2019 12:14:37 +0000
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
Message-ID: <20190325121436.hwmzgqkaggxvnfqx@mbp>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
 <20190321233248.GA6941@Asurada-Nvidia>
 <20190322105712.GB13384@arrakis.emea.arm.com>
 <20190322200925.GA22219@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322200925.GA22219@Asurada-Nvidia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:09:26PM -0700, Nicolin Chen wrote:
> On Fri, Mar 22, 2019 at 10:57:13AM +0000, Catalin Marinas wrote:
> > > > Do you have any numbers to back this up? You don't seem to address
> > > > dma_direct_alloc() either but, as I said above, it's not trivial since
> > > > some platforms expect certain physical range for DMA allocations.
> > > 
> > > What's the dma_direct_alloc() here about? Mind elaborating?
> > 
> > I just did a grep for dma_alloc_from_contiguous() in the 5.1-rc1 kernel
> > and came up with __dma_direct_alloc_pages(). Should your patch cover
> > this as well?
> 
> I don't get the meaning of "cover this" here. What missing part
> do you refer to?

What I meant, do you need this hunk as well in your patch?

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fcdb23e8d2fc..8955ba6f52fc 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -111,8 +111,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 again:
 	/* CMA can be used only in the context which permits sleeping */
 	if (gfpflags_allow_blocking(gfp)) {
-		page = dma_alloc_from_contiguous(dev, count, page_order,
-						 gfp & __GFP_NOWARN);
+		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 			dma_release_from_contiguous(dev, page, count);
 			page = NULL;

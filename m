Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F16C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C0420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJIGur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:50:47 -0400
Received: from verein.lst.de ([213.95.11.211]:50518 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIGur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:50:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0914168B05; Wed,  9 Oct 2019 08:50:44 +0200 (CEST)
Date:   Wed, 9 Oct 2019 08:50:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191009065043.GA30157@lst.de>
References: <20191007175528.GA21857@lst.de> <20191007175630.GA28861@infradead.org> <20191007175856.GA42018@rani.riverdale.lan> <20191007183206.GA13589@rani.riverdale.lan> <20191007184754.GB31345@lst.de> <20191007221054.GA409402@rani.riverdale.lan> <20191007235401.GA608824@rani.riverdale.lan> <20191008073210.GB9452@lst.de> <20191008115103.GA463127@rani.riverdale.lan> <20191008154731.GA616259@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008154731.GA616259@rani.riverdale.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:47:31AM -0400, Arvind Sankar wrote:
> Ok, I see that almost nothing actually uses dma_get_required_mask. So if
> something did need >4Gb space, the IOMMU would allocate it anyway
> regardless of dma_get_required_mask.

Yes.  And with the direct mapping it also isn't an issue.

> I'm thinking this means that we actually only needed to change
> dma_get_required_mask to dma_direct_get_required_mask in
> iommu_need_mapping, and the rest of the change is unnecessary?
> 
> Below is list of stuff calling dma_get_required_mask currently:

I guess that would actually work ok, but I prefer the more verbose
version as it explain what is going on, and will lead people to do
the right thing if we split the iommu vs passthrough case into
different ops (we already had a patch for that out on the list).

> For the drivers that do currently use dma_get_required_mask, I believe
> we will need to replace most of them with dma_direct_get_required_mask
> as well to maintain passthrough functionality -- the fusion, scsi, and
> infinband drivers all seem to be using this call to determine whether to
> expose the device's 64-bit DMA capability or not. With the change they
> will think they only need 32-bit DMA, which in turn will disable
> passthrough on them.

At least for some of the legacy SCSI drivers that is intentional, and
the reason why dma_get_required_mask was originally added.  On actual
PCI (and PCI-X, but not PCIe which everyone uses now) the 64-bit
addressing even if supported is not very efficient as it needs two
bus cycles.  So we prefer to just use the iommu.

> The etnaviv driver is doing something funky that I'm not sure about, but
> I *think* that one might want the real physical range as well. The mmc
> driver I think might be ok with the 32-bit range.

etnaviv is never used on systems with the intel iommu anyway.

> The vmd controller one not sure about.

That just passes through the dma ops to work around really stupid
intel chipsets.

> In dma-mapping.h, the function is used in dma_addressing_limited, which
> in turn is used in a couple of amd drm drivers, again not sure about
> these.
---end quoted text---

Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC3AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0977D2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKUHlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:41:04 -0500
Received: from verein.lst.de ([213.95.11.211]:44505 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKUHlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:41:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E48C268B05; Thu, 21 Nov 2019 08:41:00 +0100 (CET)
Date:   Thu, 21 Nov 2019 08:41:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Miller <davem@davemloft.net>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, robin.murphy@arm.com,
        joro@8bytes.org, ruxandra.radulescu@nxp.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, ioana.ciornei@nxp.com, leoyang.li@nxp.com,
        diana.craciun@nxp.com, madalin.bucur@nxp.com, camelia.groza@nxp.com
Subject: Re: [PATCH v3 0/4] dma-mapping: introduce new dma unmap and sync
 variants
Message-ID: <20191121074100.GD24024@lst.de>
References: <20191113122407.1171-1-laurentiu.tudor@nxp.com> <20191113.121132.1658930697082028145.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113.121132.1658930697082028145.davem@davemloft.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:11:32PM -0800, David Miller wrote:
> > This series introduces a few new dma unmap and sync api variants that,
> > on top of what the originals do, return the virtual address
> > corresponding to the input dma address. In order to do that a new dma
> > map op is added, .get_virt_addr that takes the input dma address and
> > returns the virtual address backing it up.
> > The second patch adds an implementation for this new dma map op in the
> > generic iommu dma glue code and wires it in.
> > The third patch updates the dpaa2-eth driver to use the new apis.
> 
> The driver should store the mapping in it's private software state if
> it needs this kind of conversion.

I think the problem for this driver (and a few others) is that they
somehow manage to split I/O completions at a different boundary
than submissions.  For me with my block I/O background this seems
weird, but I'll need networking folks to double check the theory.

> This is huge precendence for this, and there is therefore no need to
> add even more complication and methods and burdon to architecture code
> for the sake of this.

Unfortunately there are various drivers that abuse iommu_iova_to_phys
to get a struct page to unmap.  Two of theose are network drivers
that went in through you (dpaa2 and thunder), additonally the 
caam crypto driver (which I think is the same SOC family as dpaa,
but I'm not sure) and the AMD GPU driver.

We also have drivers that just don't unmap and this don't work with
iommus or dma-debug (IBM EMAC another net driver).

That being said I hate these new API, but I still think they are less
bad than these IOMMU API abuses people do now.  If experienced
networking folks know a way to get rid of both I'm all for it.

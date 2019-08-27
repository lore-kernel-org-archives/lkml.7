Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47560C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F4B206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfH0Hu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:50:27 -0400
Received: from verein.lst.de ([213.95.11.211]:54480 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbfH0Hu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:50:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4577B68B05; Tue, 27 Aug 2019 09:50:21 +0200 (CEST)
Date:   Tue, 27 Aug 2019 09:50:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, vdumpa@nvidia.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thierry Reding <treding@nvidia.com>,
        Kees Cook <keescook@chromium.org>, iamjoonsoo.kim@lge.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
Message-ID: <20190827075021.GA953@lst.de>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com> <20190506223334.1834-3-nicoleotsuka@gmail.com> <CAK7LNARacEorb38mVBw_V-Zvz-znWgBma1AP1-z_5B_xZU4ogg@mail.gmail.com> <CAK7LNAQfYBCoChMV=MOwcUyVoqRkrPWs7DaWdzDqjBe18gGiAQ@mail.gmail.com> <20190825011025.GA23410@lst.de> <CAK7LNAQb1ZHr=DiHLNeNRaQExMuXdDOV4sFghoGbco_Q=Qzb8g@mail.gmail.com> <20190826073320.GA11712@lst.de> <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATYOLEboUTO4qPx2z7cqwDrHBO1HFHG8VzZEJ15STv+nw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:45:20PM +0900, Masahiro Yamada wrote:
> On Mon, Aug 26, 2019 at 4:33 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Aug 26, 2019 at 11:05:00AM +0900, Masahiro Yamada wrote:
> > > This is included in v5.3-rc6
> > > so I tested it.
> >
> > So there is no allocation failure, but you get I/O errors later?
> 
> Right.
> 
> >
> > Does the device use a device-private CMA area?
> 
> Not sure.
> My driver is drivers/mmc/host/sdhci-cadence.c
> It reuses routines in drivers/mmc/host/sdhci.c
> 
> 
> 
> >  Does it work with Linux
> > 5.2 if CONFIG_DMA_CMA is disabled?
> 
> No.
> 5.2 + disable CONFIG_DMA_CMA
> failed in the same way.

So it seems like the device wants CMA memory.   I guess the patch
below will fix it, but that isn't the solution.  Can you try it
to confirm?  In the end it probably assumes a dma mask it doesn't
set that the CMA memory satisfies or something similar.

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..bd2f24aa7f19 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -236,7 +236,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 
 	if (dev && dev->cma_area)
 		cma = dev->cma_area;
-	else if (count > 1)
+	else
 		cma = dma_contiguous_default_area;
 
 	/* CMA can be used only in the context which permits sleeping */

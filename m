Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C54C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BCB206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCLTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:19:06 -0500
Received: from foss.arm.com ([217.140.110.172]:40604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCLTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:19:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D9430E;
        Tue,  3 Dec 2019 03:19:04 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916673F68E;
        Tue,  3 Dec 2019 03:19:02 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:19:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>, wahrenst@gmx.net,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Nicolas Dechense <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
Message-ID: <20191203111900.GA23522@arrakis.emea.arm.com>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
 <20190911182546.17094-4-nsaenzjulienne@suse.de>
 <CALAqxLVVcsmFrDKLRGRq7GewcW405yTOxG=KR3csVzQ6bXutkA@mail.gmail.com>
 <CALAqxLUkPNf9JYyt+_VOrxq=Zq03veb1y-7aDx+_Vw+fF9i82A@mail.gmail.com>
 <CALAqxLW7RTif_NPxFXnxfTm2_ST+6aNmE6X=3v4XsuojKH2mtg@mail.gmail.com>
 <20191203101249.GC6815@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203101249.GC6815@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:12:50AM +0000, Will Deacon wrote:
> On Mon, Dec 02, 2019 at 10:03:17PM -0800, John Stultz wrote:
> > Ok, narrowing it down further, it seems its the following bit from the
> > patch:
> > 
> > > @@ -201,13 +212,18 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > >         struct memblock_region *reg;
> > >         unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
> > >         unsigned long max_dma32 = min;
> > > +       unsigned long max_dma = min;
> > >
> > >         memset(zone_size, 0, sizeof(zone_size));
> > >
> > > -       /* 4GB maximum for 32-bit only capable devices */
> > > +#ifdef CONFIG_ZONE_DMA
> > > +       max_dma = PFN_DOWN(arm64_dma_phys_limit);
> > > +       zone_size[ZONE_DMA] = max_dma - min;
> > > +       max_dma32 = max_dma;
> > > +#endif
> > >  #ifdef CONFIG_ZONE_DMA32
> > >         max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
> > > -       zone_size[ZONE_DMA32] = max_dma32 - min;
> > > +       zone_size[ZONE_DMA32] = max_dma32 - max_dma;
> > >  #endif
> > >         zone_size[ZONE_NORMAL] = max - max_dma32;
> > >
> > > @@ -219,11 +235,17 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> > >
> > >                 if (start >= max)
> > >                         continue;
> > > -
> > > +#ifdef CONFIG_ZONE_DMA
> > > +               if (start < max_dma) {
> > > +                       unsigned long dma_end = min_not_zero(end, max_dma);
> > > +                       zhole_size[ZONE_DMA] -= dma_end - start;
> > > +               }
> > > +#endif
> > >  #ifdef CONFIG_ZONE_DMA32
> > >                 if (start < max_dma32) {
> > > -                       unsigned long dma_end = min(end, max_dma32);
> > > -                       zhole_size[ZONE_DMA32] -= dma_end - start;
> > > +                       unsigned long dma32_end = min(end, max_dma32);
> > > +                       unsigned long dma32_start = max(start, max_dma);
> > > +                       zhole_size[ZONE_DMA32] -= dma32_end - dma32_start;
> > >                 }
> > >  #endif
> > >                 if (end > max_dma32) {
> > 
> > The zhole_sizes end up being:
> > zhole_size: DMA: 67671, DMA32: 1145664 NORMAL: 0
> > 
> > This seems to be due to dma32_start being calculated as 786432 each
> > time - I'm guessing that's the max_dma value.
> > Where dma32_end is around 548800, but changes each iteration (so we
> > end up subtracting a negative value each pass, growing the size).
[...]
> Anyway, I've had a go at fixing it below but it's 100% untested. I think
> the issue is that your SoC has memblocks contained entirely within the
> ZONE_DMA region and we don't cater for that at all when processing the
> ZONE_DMA32 region.

This seems to be issue, the SoC memory contained withing ZONE_DMA. I
managed to reproduce it under KVM/Qemu by reducing the amount of memory
given to the guest. You'd also need NUMA disabled to hit this code path.

Your proposed change fixes it but I'll send a tested-by on the full
patch when it hits the list.

-- 
Catalin

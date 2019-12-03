Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3003C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0666206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575367985;
	bh=wI49/3MX3A5K4KXoKvz8MjUjQ7lmXO+cIlGX8yR3wXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AG0zbvX7WE4IBwrtsmeuid+mExjy0Mk8HJvc7m1+c17wfSbqVUO4cVMsgATflz2uQ
	 DG5sxp/DTyCwCNKI2eRmaPcFQfe5F0pXReU3lESjWbC/0CS3p9Zv6A80fB6NFCCxD7
	 juLGBF1vA6TsirrXxGHM76/YXrtyb5wGrGHZpvBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCKNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCKNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:13:02 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E5C206DF;
        Tue,  3 Dec 2019 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575367981;
        bh=wI49/3MX3A5K4KXoKvz8MjUjQ7lmXO+cIlGX8yR3wXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sc86W9/tccQOqQmYT3saFdznHpCbiKhhZ0lfmhYEUbg7DqCajtQ8cwkT4HGMqsFQg
         bWcuPJo8EhusJxRV2NfJEIpb5L7QcVt2PMZ3cow5j4BzFTQNSoTVMCEM7NkLJ/834F
         JUbhMmgAFoB883XHKUkBCUhzsbpQZstw1bHbNfuM=
Date:   Tue, 3 Dec 2019 10:12:50 +0000
From:   Will Deacon <will@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <20191203101249.GC6815@willie-the-truck>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
 <20190911182546.17094-4-nsaenzjulienne@suse.de>
 <CALAqxLVVcsmFrDKLRGRq7GewcW405yTOxG=KR3csVzQ6bXutkA@mail.gmail.com>
 <CALAqxLUkPNf9JYyt+_VOrxq=Zq03veb1y-7aDx+_Vw+fF9i82A@mail.gmail.com>
 <CALAqxLW7RTif_NPxFXnxfTm2_ST+6aNmE6X=3v4XsuojKH2mtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLW7RTif_NPxFXnxfTm2_ST+6aNmE6X=3v4XsuojKH2mtg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Dec 02, 2019 at 10:03:17PM -0800, John Stultz wrote:
> Ok, narrowing it down further, it seems its the following bit from the
> patch:
> 
> > @@ -201,13 +212,18 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> >         struct memblock_region *reg;
> >         unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
> >         unsigned long max_dma32 = min;
> > +       unsigned long max_dma = min;
> >
> >         memset(zone_size, 0, sizeof(zone_size));
> >
> > -       /* 4GB maximum for 32-bit only capable devices */
> > +#ifdef CONFIG_ZONE_DMA
> > +       max_dma = PFN_DOWN(arm64_dma_phys_limit);
> > +       zone_size[ZONE_DMA] = max_dma - min;
> > +       max_dma32 = max_dma;
> > +#endif
> >  #ifdef CONFIG_ZONE_DMA32
> >         max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
> > -       zone_size[ZONE_DMA32] = max_dma32 - min;
> > +       zone_size[ZONE_DMA32] = max_dma32 - max_dma;
> >  #endif
> >         zone_size[ZONE_NORMAL] = max - max_dma32;
> >
> > @@ -219,11 +235,17 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> >
> >                 if (start >= max)
> >                         continue;
> > -
> > +#ifdef CONFIG_ZONE_DMA
> > +               if (start < max_dma) {
> > +                       unsigned long dma_end = min_not_zero(end, max_dma);
> > +                       zhole_size[ZONE_DMA] -= dma_end - start;
> > +               }
> > +#endif
> >  #ifdef CONFIG_ZONE_DMA32
> >                 if (start < max_dma32) {
> > -                       unsigned long dma_end = min(end, max_dma32);
> > -                       zhole_size[ZONE_DMA32] -= dma_end - start;
> > +                       unsigned long dma32_end = min(end, max_dma32);
> > +                       unsigned long dma32_start = max(start, max_dma);
> > +                       zhole_size[ZONE_DMA32] -= dma32_end - dma32_start;
> >                 }
> >  #endif
> >                 if (end > max_dma32) {
> 
> The zhole_sizes end up being:
> zhole_size: DMA: 67671, DMA32: 1145664 NORMAL: 0
> 
> This seems to be due to dma32_start being calculated as 786432 each
> time - I'm guessing that's the max_dma value.
> Where dma32_end is around 548800, but changes each iteration (so we
> end up subtracting a negative value each pass, growing the size).

Yeah, this logic looks utterly buggered to me so I'm surprised that nobody
else has seen the problem. In particlar, kernelci is reporting success
on the same SoC :/

https://kernelci.org/boot/sdm845-db845c/

The logs also don't seem to match up with the trees either. For example,
looking at the boot logs for:

https://kernelci.org/boot/id/5de5fc60b1ed6e2d46960f08/

It claims that the kernel is "next-2019-12-30" but the dmesg says:

[    0.000000] Linux version 5.4.0 (KernelCI@b19b74fe311d) (gcc version
8.3.0 (Debian 8.3.0-2)) #1 SMP PREEMPT Tue Dec 3 03:14:07 UTC 2019

Which isn't great.

Anyway, I've had a go at fixing it below but it's 100% untested. I think
the issue is that your SoC has memblocks contained entirely within the
ZONE_DMA region and we don't cater for that at all when processing the
ZONE_DMA32 region.

Will

--->8

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index be9481cdf3b9..af365ce59ed6 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -242,19 +242,19 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 		if (start < max_dma) {
 			unsigned long dma_end = min_not_zero(end, max_dma);
 			zhole_size[ZONE_DMA] -= dma_end - start;
+			start = dma_end;
 		}
 #endif
 #ifdef CONFIG_ZONE_DMA32
-		if (start < max_dma32) {
+		if (start >= max_dma && start < max_dma32) {
 			unsigned long dma32_end = min(end, max_dma32);
-			unsigned long dma32_start = max(start, max_dma);
-			zhole_size[ZONE_DMA32] -= dma32_end - dma32_start;
+			zhole_size[ZONE_DMA32] -= dma32_end - start;
+			start = dma32_end;
 		}
 #endif
-		if (end > max_dma32) {
+		if (start >= max_dma32) {
 			unsigned long normal_end = min(end, max);
-			unsigned long normal_start = max(start, max_dma32);
-			zhole_size[ZONE_NORMAL] -= normal_end - normal_start;
+			zhole_size[ZONE_NORMAL] -= normal_end - start;
 		}
 	}
 

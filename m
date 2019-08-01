Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035D7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DB320838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfHAOE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:04:58 -0400
Received: from verein.lst.de ([213.95.11.211]:43759 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbfHAOE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:04:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5620168AFE; Thu,  1 Aug 2019 16:04:52 +0200 (CEST)
Date:   Thu, 1 Aug 2019 16:04:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, eric@anholt.net,
        mbrugger@suse.com, akpm@linux-foundation.org,
        frowand.list@gmail.com, linux-rpi-kernel@lists.infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/8] dma-direct: turn ARCH_ZONE_DMA_BITS into a variable
Message-ID: <20190801140452.GB23435@lst.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de> <20190731154752.16557-7-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731154752.16557-7-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few nitpicks, otherwise this looks great:

> @@ -201,7 +202,7 @@ static int __init mark_nonram_nosave(void)
>   * everything else. GFP_DMA32 page allocations automatically fall back to
>   * ZONE_DMA.
>   *
> - * By using 31-bit unconditionally, we can exploit ARCH_ZONE_DMA_BITS to
> + * By using 31-bit unconditionally, we can exploit arch_zone_dma_bits to
>   * inform the generic DMA mapping code.  32-bit only devices (if not handled
>   * by an IOMMU anyway) will take a first dip into ZONE_NORMAL and get
>   * otherwise served by ZONE_DMA.
> @@ -237,9 +238,18 @@ void __init paging_init(void)
>  	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>  	       (long int)((top_of_ram - total_ram) >> 20));
>  
> +	/*
> +	 * Allow 30-bit DMA for very limited Broadcom wifi chips on many
> +	 * powerbooks.
> +	 */
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		arch_zone_dma_bits = 30;
> +	else
> +		arch_zone_dma_bits = 31;
> +

So the above unconditionally comment obviously isn't true any more, and
Ben also said for the recent ppc32 hack he'd prefer dynamic detection.

Maybe Ben and or other ppc folks can chime in an add a patch to the series
to sort this out now that we have a dynamic ZONE_DMA threshold?

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 59bdceea3737..40dfc9b4ee4c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -19,9 +19,7 @@
>   * Most architectures use ZONE_DMA for the first 16 Megabytes, but
>   * some use it for entirely different regions:
>   */
> -#ifndef ARCH_ZONE_DMA_BITS
> -#define ARCH_ZONE_DMA_BITS 24
> -#endif
> +unsigned int arch_zone_dma_bits __ro_after_init = 24;

I'd prefer to drop the arch_ prefix and just calls this zone_dma_bits.
In the long run we really need to find a way to just automatically set
this from the meminit code, but that is out of scope for this series.
For now can you please just update the comment above to say something
like:

/*
 * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
 * it for entirely different regions.  In that case the arch code needs to
 * override the variable below for dma-direct to work properly.
 */

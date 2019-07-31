Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADECC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E188B206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfGaRHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:07:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbfGaRHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:07:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2AF6337;
        Wed, 31 Jul 2019 10:07:46 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72C133F71F;
        Wed, 31 Jul 2019 10:07:44 -0700 (PDT)
Date:   Wed, 31 Jul 2019 18:07:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>, phill@raspberryi.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, eric@anholt.net, mbrugger@suse.com,
        akpm@linux-foundation.org, frowand.list@gmail.com,
        m.szyprowski@samsung.com, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 5/8] arm64: use ZONE_DMA on DMA addressing limited devices
Message-ID: <20190731170742.GC17773@arrakis.emea.arm.com>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
 <20190731154752.16557-6-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731154752.16557-6-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:47:48PM +0200, Nicolas Saenz Julienne wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1c4ffabbe1cb..f5279ef85756 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -50,6 +50,13 @@
>  s64 memstart_addr __ro_after_init = -1;
>  EXPORT_SYMBOL(memstart_addr);
>  
> +/*
> + * We might create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA is needed if there
> + * are periferals unable to address the first naturally aligned 4GB of ram.
> + * ZONE_DMA32 will be expanded to cover the rest of that memory. If such
> + * limitations doesn't exist only ZONE_DMA32 is created.
> + */

Shouldn't we instead only create ZONE_DMA to cover the whole 32-bit
range and leave ZONE_DMA32 empty? Can__GFP_DMA allocations fall back
onto ZONE_DMA32?

-- 
Catalin

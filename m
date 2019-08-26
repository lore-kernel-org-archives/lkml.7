Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5722C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71CA2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfHZHGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:06:37 -0400
Received: from verein.lst.de ([213.95.11.211]:46343 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbfHZHGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:06:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF05868B02; Mon, 26 Aug 2019 09:06:33 +0200 (CEST)
Date:   Mon, 26 Aug 2019 09:06:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, phill@raspberryi.org,
        f.fainelli@gmail.com, will@kernel.org, eric@anholt.net,
        mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
        akpm@linux-foundation.org, frowand.list@gmail.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune
 dma-direct min mask
Message-ID: <20190826070633.GB11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-11-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820145821.27214-11-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 04:58:18PM +0200, Nicolas Saenz Julienne wrote:
> -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
>  		arm64_dma_phys_limit = max_zone_dma_phys();
> +		zone_dma_bits = ilog2((arm64_dma_phys_limit - 1) & GENMASK_ULL(31, 0)) + 1;

This adds a way too long line.  I also find the use of GENMASK_ULL
horribly obsfucating, but I know that opinion is't shared by everyone.

Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF18FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8025D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfEPNVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:21:40 -0400
Received: from foss.arm.com ([217.140.101.70]:45460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfEPNVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:21:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2C4F1715;
        Thu, 16 May 2019 06:21:39 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 625313F703;
        Thu, 16 May 2019 06:21:37 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <rob.e.herring@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190512174608.10083-1-peron.clem@gmail.com>
 <20190513151405.GW17751@phenom.ffwll.local>
 <de50a9da-669f-ab25-2ef2-5ffb90f8ee03@baylibre.com>
 <CAJiuCccuEw0BK6MwROR+XUDvu8AJTmZ5tu=pYwZbGAuvO31pgg@mail.gmail.com>
 <CAJiuCccWa5UTML68JDQq6q8SyNZzVWwQWTOL=+84Bh4EMHGC3A@mail.gmail.com>
 <3c2c9094-69d4-bace-d5ee-c02b7f56ac82@arm.com>
 <CAJiuCcd=gCQJ4mxn3wNhHXveOhFLnYSEs+cnOMHcALPvd7bQZw@mail.gmail.com>
 <CAC=3edbn1yXih5vP0SwsDkqRB0j5q0c4FL0jhCq9DQ9Wt2-hAA@mail.gmail.com>
 <e8618889-9b22-7f9f-7451-3c08a80a0f9b@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <fa434575-5576-aff5-8705-1f93eefa209c@arm.com>
Date:   Thu, 16 May 2019 14:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e8618889-9b22-7f9f-7451-3c08a80a0f9b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 12:19, Robin Murphy wrote:
[...]
> I was expecting to see a similar behaviour to my T620 (which I now
> assume was down to 64-bit job descriptors sort-of-but-not-quite working)
> but this does look a bit more fundamental - the fact that it's a level 1
> fault with VA == head == tail suggests to me that the MMU can't see the
> page tables at all to translate anything. I really hope that the H6 GPU
> integration doesn't suffer from the same DMA offset as the Allwinner
> display pipeline stuff, because that would be a real pain to support in
> io-pgtable.

Assuming you mean the case where the physical address (as seen by the
CPU) is different from the dma address (as seen by the GPU), then I
highly doubt it because mali_kbase doesn't support it:

[from kbase_mem_pool_alloc_page() in mali_kbase_mem_pool.c]:

	dma_addr = dma_map_page(dev, p, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
	if (dma_mapping_error(dev, dma_addr)) {
		__free_page(p);
		return NULL;
	}

	WARN_ON(dma_addr != page_to_phys(p));


That being said it's quite possible there could be something in the bus
which needs configuring to make this work - in which case your best bet
is to look at the vendor kernel and see if anything extra is poked when
the Mali driver is loaded.

Steve

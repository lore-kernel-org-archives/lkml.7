Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF80BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989122186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfDEM5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:57:31 -0400
Received: from foss.arm.com ([217.140.101.70]:48226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDEM5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:57:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9ECE1688;
        Fri,  5 Apr 2019 05:57:30 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57923F557;
        Fri,  5 Apr 2019 05:57:27 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
 <CAL_JsqKbqNDMx26Tkyrem-NXF_0iApcWaaEDphtfy6kX050Upg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d7e21f40-a639-c3e5-c259-3b05562a5446@arm.com>
Date:   Fri, 5 Apr 2019 13:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKbqNDMx26Tkyrem-NXF_0iApcWaaEDphtfy6kX050Upg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 05:57, Rob Herring wrote:
[...]
>>> +static int panfrost_clk_init(struct panfrost_device *pfdev)
>>> +{
>>> +     int err;
>>> +     unsigned long rate;
>>> +
>>> +     pfdev->clock = devm_clk_get(pfdev->dev, NULL);
>>> +     if (IS_ERR(pfdev->clock)) {
>>
>> The DT binding says clocks are optional, but this doesn't treat them as
>> such.
> 
> Hum, I would think effectively clocks are always there and necessary
> for thermal reasons.

Should the binding be updated to move clocks from "optional" to 
"required" then? Juno does actually have a GPU clock for DVFS, but the 
clk-scmi driver didn't seem to want to play nicely with either 
mali_kbase or panfrost DRM, so I've just been leaving it out of my DT 
for now (and mali_kbase was perfectly happy without).

>>> +     spin_lock_init(&pfdev->mm_lock);
>>> +
>>> +     /* 4G enough for now. can be 48-bit */
>>> +     drm_mm_init(&pfdev->mm, SZ_32M >> PAGE_SHIFT, SZ_4G);
>>
>> You probably want a dma_set_mask_and_coherent() call for your 'real'
>> output address size somewhere - the default 32-bit mask works out OK for
>> RK3399, but on systems with RAM above 4GB io-pgtable will get very
>> unhappy about DMA bounce-buffering.
> 
> Yes, I have a todo for figuring out the # of physaddr bits in the mmu
> setup (as this call is just relevant to the input address side).
> Though maybe just calling dma_set_mask_and_coherent() is enough and I
> don't need to know the exact number of output bits for the io-pgtable
> setup?

True, io-pgtable itself only really depends on the input size, but in 
order for non-coherent pagtables to work correctly in general, the DMA 
mask does need to be set appropriately, at which point it may as well 
also be propagated into OAS for completeness (as we do in arm-smmu*).

FWIW I'm just gonna leave this quote here...

	gpu_props->mmu.va_bits = KBASE_UBFX32(raw->mmu_features, 0U, 8);
	gpu_props->mmu.pa_bits = KBASE_UBFX32(raw->mmu_features, 8U, 8);


Robin.

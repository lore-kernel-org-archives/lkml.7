Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64676C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C61221773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfEXRZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:25:35 -0400
Received: from foss.arm.com ([217.140.101.70]:47202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbfEXRZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:25:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D0AE80D;
        Fri, 24 May 2019 10:25:34 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB1173F703;
        Fri, 24 May 2019 10:25:31 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] Allwinner H6 Mali GPU support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20190521161102.29620-1-peron.clem@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <61088426-43cd-338b-ca77-50c00fcb7c5e@arm.com>
Date:   Fri, 24 May 2019 18:25:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 17:10, Clément Péron wrote:
> Hi,
> 
> The Allwinner H6 has a Mali-T720 MP2 which should be supported by
> the new panfrost driver. This series fix two issues and introduce the
> dt-bindings but a simple benchmark show that it's still NOT WORKING.
> 
> I'm pushing it in case someone want to continue the work.
> 
> This has been tested with Mesa3D 19.1.0-RC2 and a GPU bitness patch[1].
> 
> One patch is from Icenowy Zheng where I changed the order as required
> by Rob Herring[2].
> 
> Thanks,
> Clement
> 
> [1] https://gitlab.freedesktop.org/kszaq/mesa/tree/panfrost_64_32
> [2] https://patchwork.kernel.org/patch/10699829/
> 
> 
> [  345.204813] panfrost 1800000.gpu: mmu irq status=1
> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000002400400
> [  345.209617] Reason: TODO
> [  345.209617] raw fault status: 0x800002C1
> [  345.209617] decoded fault status: SLAVE FAULT
> [  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> [  345.209617] access type 0x2: READ
> [  345.209617] source id 0x8000
> [  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=0,
> status=0x8, head=0x2400400, tail=0x2400400, sched_job=000000009e204de9
> [  346.055876] panfrost 1800000.gpu: mmu irq status=1
> [  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000002C00A00
> [  346.060680] Reason: TODO
> [  346.060680] raw fault status: 0x810002C1
> [  346.060680] decoded fault status: SLAVE FAULT
> [  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
> [  346.060680] access type 0x2: READ
> [  346.060680] source id 0x8100
> [  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=1,
> status=0x8, head=0x2c00a00, tail=0x2c00a00, sched_job=00000000b55a9a85
> [  346.573913] panfrost 1800000.gpu: mmu irq status=1
> [  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
> 0x0000000002C00B80

FWIW I seem to have reproduced the same behaviour on a different T720 
setup, so this may well be more about the GPU than the platform. There 
doesn't look to be anything obviously wrong with the pagetables, but if 
I can find some more free time I may have a bit more of a poke around.

Robin.

> 
> Change in v5:
>   - Remove fix indent
> 
> Changes in v4:
>   - Add bus_clock probe
>   - Fix sanity check in io-pgtable
>   - Add vramp-delay
>   - Merge all boards into one patch
>   - Remove upstreamed Neil A. patch
> 
> Change in v3 (Thanks to Maxime Ripard):
>   - Reauthor Icenowy for her path
> 
> Changes in v2 (Thanks to Maxime Ripard):
>   - Drop GPU OPP Table
>   - Add clocks and clock-names in required
> 
> Clément Péron (5):
>    drm: panfrost: add optional bus_clock
>    iommu: io-pgtable: fix sanity check for non 48-bit mali iommu
>    dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
>    arm64: dts: allwinner: Add ARM Mali GPU node for H6
>    arm64: dts: allwinner: Add mali GPU supply for H6 boards
> 
> Icenowy Zheng (1):
>    dt-bindings: gpu: add bus clock for Mali Midgard GPUs
> 
>   .../bindings/gpu/arm,mali-midgard.txt         | 15 ++++++++++++-
>   .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  6 +++++
>   .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  6 +++++
>   .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  6 +++++
>   .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  6 +++++
>   arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++++
>   drivers/gpu/drm/panfrost/panfrost_device.c    | 22 +++++++++++++++++++
>   drivers/gpu/drm/panfrost/panfrost_device.h    |  1 +
>   drivers/iommu/io-pgtable-arm.c                |  2 +-
>   9 files changed, 76 insertions(+), 2 deletions(-)
> 

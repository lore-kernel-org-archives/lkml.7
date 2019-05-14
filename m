Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D903C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568DB20873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfENV5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:57:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfENV5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:57:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4213374;
        Tue, 14 May 2019 14:57:00 -0700 (PDT)
Received: from [192.168.1.124] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C9803F703;
        Tue, 14 May 2019 14:56:57 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190512174608.10083-1-peron.clem@gmail.com>
 <20190513151405.GW17751@phenom.ffwll.local>
 <de50a9da-669f-ab25-2ef2-5ffb90f8ee03@baylibre.com>
 <CAJiuCccuEw0BK6MwROR+XUDvu8AJTmZ5tu=pYwZbGAuvO31pgg@mail.gmail.com>
 <CAJiuCccWa5UTML68JDQq6q8SyNZzVWwQWTOL=+84Bh4EMHGC3A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c2c9094-69d4-bace-d5ee-c02b7f56ac82@arm.com>
Date:   Tue, 14 May 2019 22:56:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJiuCccWa5UTML68JDQq6q8SyNZzVWwQWTOL=+84Bh4EMHGC3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-14 10:22 pm, Clément Péron wrote:
> Hi,
> 
> On Tue, 14 May 2019 at 17:17, Clément Péron <peron.clem@gmail.com> wrote:
>>
>> Hi,
>>
>> On Tue, 14 May 2019 at 12:29, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>> Hi,
>>>
>>> On 13/05/2019 17:14, Daniel Vetter wrote:
>>>> On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com wrote:
>>>>> From: Clément Péron <peron.clem@gmail.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> The Allwinner H6 has a Mali-T720 MP2. The drivers are
>>>>> out-of-tree so this series only introduce the dt-bindings.
>>>>
>>>> We do have an in-tree midgard driver now (since 5.2). Does this stuff work
>>>> together with your dt changes here?
>>>
>>> No, but it should be easy to add.
>> I will give it a try and let you know.
> Added the bus_clock and a ramp delay to the gpu_vdd but the driver
> fail at probe.
> 
> [    3.052919] panfrost 1800000.gpu: clock rate = 432000000
> [    3.058278] panfrost 1800000.gpu: bus_clock rate = 100000000
> [    3.179772] panfrost 1800000.gpu: mali-t720 id 0x720 major 0x1
> minor 0x1 status 0x0
> [    3.187432] panfrost 1800000.gpu: features: 00000000,10309e40,
> issues: 00000000,21054400
> [    3.195531] panfrost 1800000.gpu: Features: L2:0x07110206
> Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002821 AS:0xf
> JS:0x7
> [    3.207178] panfrost 1800000.gpu: shader_present=0x3 l2_present=0x1
> [    3.238257] panfrost 1800000.gpu: Fatal error during GPU init
> [    3.244165] panfrost: probe of 1800000.gpu failed with error -12
> 
> The ENOMEM is coming from "panfrost_mmu_init"
> alloc_io_pgtable_ops(ARM_MALI_LPAE, &pfdev->mmu->pgtbl_cfg,
>                                           pfdev);
> 
> Which is due to a check in the pgtable alloc "cfg->ias != 48"
> arm-lpae io-pgtable: arm_mali_lpae_alloc_pgtable cfg->ias 33 cfg->oas 40
> 
> DRI stack is totally new for me, could you give me a little clue about
> this issue ?

Heh, this is probably the one bit which doesn't really count as "DRI stack".

That's merely a somewhat-conservative sanity check - I'm pretty sure it 
*should* be fine to change the test to "cfg->ias > 48" (io-pgtable 
itself ought to cope). You'll just get to be the first to actually test 
a non-48-bit configuration here :)

Robin.

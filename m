Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A90C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FAC206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfEPLTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:19:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42250 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfEPLTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:19:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF4F19BF;
        Thu, 16 May 2019 04:19:09 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91A6F3F71E;
        Thu, 16 May 2019 04:19:07 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Allwinner H6 Mali GPU support
To:     Rob Herring <rob.e.herring@gmail.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
 <3c2c9094-69d4-bace-d5ee-c02b7f56ac82@arm.com>
 <CAJiuCcd=gCQJ4mxn3wNhHXveOhFLnYSEs+cnOMHcALPvd7bQZw@mail.gmail.com>
 <CAC=3edbn1yXih5vP0SwsDkqRB0j5q0c4FL0jhCq9DQ9Wt2-hAA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8618889-9b22-7f9f-7451-3c08a80a0f9b@arm.com>
Date:   Thu, 16 May 2019 12:19:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAC=3edbn1yXih5vP0SwsDkqRB0j5q0c4FL0jhCq9DQ9Wt2-hAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 00:22, Rob Herring wrote:
> On Wed, May 15, 2019 at 5:06 PM Clément Péron <peron.clem@gmail.com> wrote:
>>
>> Hi Robin,
>>
>> On Tue, 14 May 2019 at 23:57, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 2019-05-14 10:22 pm, Clément Péron wrote:
>>>> Hi,
>>>>
>>>> On Tue, 14 May 2019 at 17:17, Clément Péron <peron.clem@gmail.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Tue, 14 May 2019 at 12:29, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 13/05/2019 17:14, Daniel Vetter wrote:
>>>>>>> On Sun, May 12, 2019 at 07:46:00PM +0200, peron.clem@gmail.com wrote:
>>>>>>>> From: Clément Péron <peron.clem@gmail.com>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> The Allwinner H6 has a Mali-T720 MP2. The drivers are
>>>>>>>> out-of-tree so this series only introduce the dt-bindings.
>>>>>>>
>>>>>>> We do have an in-tree midgard driver now (since 5.2). Does this stuff work
>>>>>>> together with your dt changes here?
>>>>>>
>>>>>> No, but it should be easy to add.
>>>>> I will give it a try and let you know.
>>>> Added the bus_clock and a ramp delay to the gpu_vdd but the driver
>>>> fail at probe.
>>>>
>>>> [    3.052919] panfrost 1800000.gpu: clock rate = 432000000
>>>> [    3.058278] panfrost 1800000.gpu: bus_clock rate = 100000000
>>>> [    3.179772] panfrost 1800000.gpu: mali-t720 id 0x720 major 0x1
>>>> minor 0x1 status 0x0
>>>> [    3.187432] panfrost 1800000.gpu: features: 00000000,10309e40,
>>>> issues: 00000000,21054400
>>>> [    3.195531] panfrost 1800000.gpu: Features: L2:0x07110206
>>>> Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002821 AS:0xf
>>>> JS:0x7
>>>> [    3.207178] panfrost 1800000.gpu: shader_present=0x3 l2_present=0x1
>>>> [    3.238257] panfrost 1800000.gpu: Fatal error during GPU init
>>>> [    3.244165] panfrost: probe of 1800000.gpu failed with error -12
>>>>
>>>> The ENOMEM is coming from "panfrost_mmu_init"
>>>> alloc_io_pgtable_ops(ARM_MALI_LPAE, &pfdev->mmu->pgtbl_cfg,
>>>>                                            pfdev);
>>>>
>>>> Which is due to a check in the pgtable alloc "cfg->ias != 48"
>>>> arm-lpae io-pgtable: arm_mali_lpae_alloc_pgtable cfg->ias 33 cfg->oas 40
>>>>
>>>> DRI stack is totally new for me, could you give me a little clue about
>>>> this issue ?
>>>
>>> Heh, this is probably the one bit which doesn't really count as "DRI stack".
>>>
>>> That's merely a somewhat-conservative sanity check - I'm pretty sure it
>>> *should* be fine to change the test to "cfg->ias > 48" (io-pgtable
>>> itself ought to cope). You'll just get to be the first to actually test
>>> a non-48-bit configuration here :)
>>
>> Thanks a lot, the probe seems fine now :)
>>
>> I try to run glmark2 :
>> # glmark2-es2-drm
>> =======================================================
>>      glmark2 2017.07
>> =======================================================
>>      OpenGL Information
>>      GL_VENDOR:     panfrost
>>      GL_RENDERER:   panfrost
>>      GL_VERSION:    OpenGL ES 2.0 Mesa 19.1.0-rc2
>> =======================================================
>> [build] use-vbo=false:
>>
>> But it seems that H6 is not so easy to add :(.
>>
>> [  345.204813] panfrost 1800000.gpu: mmu irq status=1
>> [  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
>> 0x0000000002400400
>> [  345.209617] Reason: TODO
>> [  345.209617] raw fault status: 0x800002C1
>> [  345.209617] decoded fault status: SLAVE FAULT
>> [  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
>> [  345.209617] access type 0x2: READ
>> [  345.209617] source id 0x8000
>> [  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=0,
>> status=0x8, head=0x2400400, tail=0x2400400, sched_job=000000009e204de9
>> [  346.055876] panfrost 1800000.gpu: mmu irq status=1
>> [  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
>> 0x0000000002C00A00
>> [  346.060680] Reason: TODO
>> [  346.060680] raw fault status: 0x810002C1
>> [  346.060680] decoded fault status: SLAVE FAULT
>> [  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
>> [  346.060680] access type 0x2: READ
>> [  346.060680] source id 0x8100
>> [  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=1,
>> status=0x8, head=0x2c00a00, tail=0x2c00a00, sched_job=00000000b55a9a85
>> [  346.573913] panfrost 1800000.gpu: mmu irq status=1
>> [  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
>> 0x0000000002C00B80
>> [  346.578707] Reason: TODO
>> [  346.578707] raw fault status: 0x800002C1
>> [  346.578707] decoded fault status: SLAVE FAULT
>> [  346.578707] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
>> [  346.578707] access type 0x2: READ
>> [  346.578707] source id 0x8000
>> [  347.073947] panfrost 1800000.gpu: gpu sched timeout, js=0,
>> status=0x8, head=0x2c00b80, tail=0x2c00b80, sched_job=00000000cf6af8e8
>> [  347.104125] panfrost 1800000.gpu: mmu irq status=1
>> [  347.108930] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
>> 0x0000000002800900
>> [  347.108930] Reason: TODO
>> [  347.108930] raw fault status: 0x810002C1
>> [  347.108930] decoded faultn thi status: SLAVE FAULT
>> [  347.108930] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
>> [  347.108930] access type 0x2: READ
>> [  347.108930] source id 0x8100
>> [  347.617950] panfrost 1800000.gpu: gpu sched timeout, js=1,
>> status=0x8, head=0x2800900, tail=0x2800900, sched_job=000000009325fdb7
>> [  347.629902] panfrost 1800000.gpu: mmu irq status=1
>> [  347.634696] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
>> 0x0000000002800A80
> 
> Is this 32 or 64 bit userspace? I think 64-bit does not work with
> T7xx. You might need this[1].

[ Oooh... that makes T620 actually do stuff without falling over 
dereferencing VA 0 somewhere halfway through the job chain :D

I shall continue to play... ]

> You may also be the first to try T720,
> so it could be something else.

I was expecting to see a similar behaviour to my T620 (which I now 
assume was down to 64-bit job descriptors sort-of-but-not-quite working) 
but this does look a bit more fundamental - the fact that it's a level 1 
fault with VA == head == tail suggests to me that the MMU can't see the 
page tables at all to translate anything. I really hope that the H6 GPU 
integration doesn't suffer from the same DMA offset as the Allwinner 
display pipeline stuff, because that would be a real pain to support in 
io-pgtable.

Robin.

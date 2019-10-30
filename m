Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E93CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022CF2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJ3Dty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:49:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726871AbfJ3Dtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:49:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B046FB39F;
        Wed, 30 Oct 2019 03:49:50 +0000 (UTC)
Subject: Re: [PATCH 3/3] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
To:     Rob Herring <robh@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191021021035.7032-1-afaerber@suse.de>
 <20191021021035.7032-4-afaerber@suse.de> <20191029154129.GA24908@bogus>
 <6e6087af-6a62-f0ff-07af-48e4836c38e6@suse.de>
 <CAL_Jsq+QgAyR7vUJRBRrO56uKJXi4=meW2qnPpZUCAqBBP7PMA@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <63c3b9b5-e409-7f43-cd03-9b4b2ee57056@suse.de>
Date:   Wed, 30 Oct 2019 04:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+QgAyR7vUJRBRrO56uKJXi4=meW2qnPpZUCAqBBP7PMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 29.10.19 um 21:40 schrieb Rob Herring:
> On Tue, Oct 29, 2019 at 10:52 AM Andreas Färber <afaerber@suse.de> wrote:
>> Am 29.10.19 um 16:41 schrieb Rob Herring:
>>> On Mon, Oct 21, 2019 at 04:10:35AM +0200, Andreas Färber wrote:
>>>> Add Device Trees for Realtek RTD1195 SoC and MeLE X1000 TV box.
>>>>
>>>> Reuse the existing RTD1295 watchdog compatible for now.
>>>>
>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>> ---
>>>>  arch/arm/boot/dts/Makefile               |   2 +
>>>>  arch/arm/boot/dts/rtd1195-mele-x1000.dts |  30 ++++++++
>>>>  arch/arm/boot/dts/rtd1195.dtsi           | 128 +++++++++++++++++++++++++++++++
>>>>  3 files changed, 160 insertions(+)
>>>>  create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
>>>>  create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
>>>>
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>> index 73d33611c372..89a951485da8 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -858,6 +858,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>>>  dtb-$(CONFIG_ARCH_RDA) += \
>>>>      rda8810pl-orangepi-2g-iot.dtb \
>>>>      rda8810pl-orangepi-i96.dtb
>>>> +dtb-$(CONFIG_ARCH_REALTEK) += \
>>>> +    rtd1195-mele-x1000.dtb
>>>>  dtb-$(CONFIG_ARCH_REALVIEW) += \
>>>>      arm-realview-pb1176.dtb \
>>>>      arm-realview-pb11mp.dtb \
>>>> diff --git a/arch/arm/boot/dts/rtd1195-mele-x1000.dts b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
>>>> new file mode 100644
>>>> index 000000000000..ce9a255950d3
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
>>>> @@ -0,0 +1,30 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>>> +/*
>>>> + * Copyright (c) 2017 Andreas Färber
>>>
>>> 2019?
>>
>> Nope, I am flushing out old queues, and updating SPDX line does not
>> really warrant a copyright bump IMO. The changes below would though.

Updated here, but not yet for the .dtsi.

>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "rtd1195.dtsi"
>>>> +
>>>> +/ {
>>>> +    compatible = "mele,x1000", "realtek,rtd1195";
>>>> +    model = "MeLE X1000";
>>>> +
>>>> +    aliases {
>>>> +            serial0 = &uart0;
>>>> +    };
>>>> +
>>>> +    chosen {
>>>> +            stdout-path = "serial0:115200n8";
>>>> +    };
>>>> +
>>>> +    memory {
>>>
>>> memory@0
>>
>> Will test.

Fixed. (No duplicate node from U-Boot.)

>>>> +            device_type = "memory";
>>>> +            reg = <0x0 0x40000000>;
>>>> +    };
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +    status = "okay";
>>>> +};
>>>> diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
>>>> new file mode 100644
>>>> index 000000000000..475740c67d26
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/rtd1195.dtsi
>>>> @@ -0,0 +1,128 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>>> +/*
>>>> + * Copyright (c) 2017 Andreas Färber
>>>> + */
>>>> +
>>>> +/memreserve/ 0x00000000 0x0000c000; /* boot code */
>>>> +/memreserve/ 0x0000c000 0x000f4000;
>>>> +/memreserve/ 0x01b00000 0x00400000; /* audio */
>>>> +/memreserve/ 0x01ffe000 0x00004000; /* rpc ringbuf */
>>>> +/memreserve/ 0x10000000 0x00100000; /* secure */
>>>> +/memreserve/ 0x17fff000 0x00001000;
>>>> +/memreserve/ 0x18000000 0x00100000; /* rbus */
>>>> +/memreserve/ 0x18100000 0x01000000; /* nor */
>>>
>>> You shouldn't have the same entries here and in /reserved-memory. There
>>> was a time before /reserved-memory was fully supported, but we should be
>>> well past that now.
>>
>> I am dealing with a v2012.07 based downstream U-Boot that I do not have
>> sources for, so I wouldn't be so sure there... It will only respect
>> memreserve I think, whereas reserved-memory below is for the kernel, no?
> 
> Sigh... Well, that may be too old. :(
> 
> I could be wrong too and no one ever added /reserved-memory support
> for u-boot. The intent was never that one was for u-boot and the other
> for the kernel. The kernel handles both. reserved-memory was to
> overcome the limitations of memreserve.

What I meant was that some versions of U-Boot process and print
memreserve regions _before_ booting into the kernel, i.e. we don't want
U-Boot's bootX commands to write data into the reserved regions.
/reserved-memory allows the kernel/bootloader to associate memory
regions with drivers via memory-region node references and to steer
whether or not the reserved memory remains mapped.

>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +
>>>> +/ {
>>>> +    compatible = "realtek,rtd1195";
>>>> +    interrupt-parent = <&gic>;
>>>> +    #address-cells = <1>;
>>>> +    #size-cells = <1>;
>>>> +
>>>> +    cpus {
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +
>>>> +            cpu0: cpu@0 {
>>>> +                    device_type = "cpu";
>>>> +                    compatible = "arm,cortex-a7";
>>>> +                    reg = <0x0>;
>>>> +                    clock-frequency = <1000000000>;
>>>> +            };
>>>> +
>>>> +            cpu1: cpu@1 {
>>>> +                    device_type = "cpu";
>>>> +                    compatible = "arm,cortex-a7";
>>>> +                    reg = <0x1>;
>>>> +                    clock-frequency = <1000000000>;
>>>> +            };
>>>> +    };
>>>> +
>>>> +    reserved-memory {
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <1>;
>>>> +            ranges;
>>>> +
>>>> +            secure@10000000 {
>>>> +                    reg = <0x10000000 0x100000>;
>>>> +                    no-map;
>>>> +            };
>>>> +
>>>> +            rbus@18000000 {
>>>> +                    reg = <0x18000000 0x100000>;
>>>> +                    no-map;
>>>
>>> This doesn't look right as it overlaps the register space.
>>
>> Will try dropping it. James?

My testing (with irqchip patches) shows that leaving the memreserve in
place and dropping this node leads to the following error:

[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm/mm/ioremap.c:304
__arm_ioremap_pfn_caller+0x1e4/0x208
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.4.0-rc5-next-20191029+ #152
[    0.000000] Hardware name: Generic DT based system
[    0.000000] [<c022f468>] (unwind_backtrace) from [<c022bca0>]
(show_stack+0x10/0x14)
[    0.000000] [<c022bca0>] (show_stack) from [<c08ab7c0>]
(dump_stack+0x78/0x8c)
[    0.000000] [<c08ab7c0>] (dump_stack) from [<c023e344>]
(__warn+0xbc/0xd8)
[    0.000000] [<c023e344>] (__warn) from [<c023e3c4>]
(warn_slowpath_fmt+0x64/0xc4)
[    0.000000] [<c023e3c4>] (warn_slowpath_fmt) from [<c02359c8>]
(__arm_ioremap_pfn_caller+0x1e4/0x208)
[    0.000000] [<c02359c8>] (__arm_ioremap_pfn_caller) from [<c0235a88>]
(ioremap+0x20/0x28)
[    0.000000] [<c0235a88>] (ioremap) from [<c0739318>] (of_iomap+0x40/0x64)
[    0.000000] [<c0739318>] (of_iomap) from [<c0e199c8>]
(rtd119x_irq_mux_init+0x3c/0x134)
[    0.000000] [<c0e199c8>] (rtd119x_irq_mux_init) from [<c0e21e48>]
(of_irq_init+0x194/0x2b4)
[    0.000000] [<c0e21e48>] (of_irq_init) from [<c0e029f4>]
(init_IRQ+0x24/0x78)
[    0.000000] [<c0e029f4>] (init_IRQ) from [<c0e00c00>]
(start_kernel+0x29c/0x488)
[    0.000000] [<c0e00c00>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] random: get_random_bytes called from
print_oops_end_marker+0x24/0x4c with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] 8<--- cut here ---
[    0.000000] Unable to handle kernel NULL pointer dereference at
virtual address 00000040
[    0.000000] pgd = (ptrval)
[    0.000000] [00000040] *pgd=80000000104003, *pmd=00000000
[    0.000000] Internal error: Oops: a06 [#1] PREEMPT SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
 5.4.0-rc5-next-20191029+ #152
[    0.000000] Hardware name: Generic DT based system
[    0.000000] PC is at rtd119x_irq_mux_init+0x94/0x134
[    0.000000] LR is at 0x0
[    0.000000] pc : [<c0e19a20>]    lr : [<00000000>]    psr: a00000d3
[    0.000000] sp : c1001f38  ip : eb001d80  fp : c0bdb7d0
[    0.000000] r10: 00000100  r9 : 00000122  r8 : 00000000
[    0.000000] r7 : c0a4dd8c  r6 : ef5f8fbc  r5 : eb001d40  r4 : 00000040
[    0.000000] r3 : 00000004  r2 : 00000000  r1 : 00000000  r0 : 00000040
[    0.000000] Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment user
[    0.000000] Control: 30c5387d  Table: 00103000  DAC: fffffffd
[    0.000000] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
[    0.000000] Stack: (0xc1001f38 to 0xc1002000)
[    0.000000] 1f20:
   00000122 00000100
[    0.000000] 1f40: eb001cc0 ef5f9a20 c1001f64 c1001f6c eb001d00
c0e21e48 c105b2ec c0284348
[    0.000000] 1f60: 00000000 eb001d00 eb001d00 c1001f6c c1001f6c
c1003e50 00000001 c0e32a30
[    0.000000] 1f80: c1003e40 c10617dc c1035d80 ffffffff cccccccd
00000001 c0e32a40 c0e029f4
[    0.000000] 1fa0: cccccccd c0e00c00 ffffffff ffffffff 00000000
c0e00584 00000000 ef5f7e00
[    0.000000] 1fc0: 00000000 c0e32a40 00000000 c1003e50 00000000
c0e00330 00000000 30c0387d
[    0.000000] 1fe0: 0000138a 01ff2000 410fc075 30c5387d 00000000
00000000 00000000 00000000
[    0.000000] [<c0e19a20>] (rtd119x_irq_mux_init) from [<c0e21e48>]
(of_irq_init+0x194/0x2b4)
[    0.000000] [<c0e21e48>] (of_irq_init) from [<c0e029f4>]
(init_IRQ+0x24/0x78)
[    0.000000] [<c0e029f4>] (init_IRQ) from [<c0e00c00>]
(start_kernel+0x29c/0x488)
[    0.000000] [<c0e00c00>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] Code: e5853004 e5970008 e0844000 e5854008 (e5848000)
[    0.000000] ---[ end trace f68728a0d3053b52 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

This appears to be in part a bug in my error handling of of_iomap - it
returns NULL, not PTR_ERR(). But even with that fixed I get fatal errors
at some point.

The workaround I have is a custom mach-realtek machine_desc with .map_io
assigning explicit .virtual addresses and MT_DEVICE for these ranges. I
also experimented with .reserve removing three memblocks, so we have a
puzzle of four places messing with the same memory regions and some
combinations working in the end, unclear why exactly.

>>>> +            };
>>>> +
>>>> +            nor@18100000 {
>>>> +                    reg = <0x18100000 0x1000000>;
>>>> +                    no-map;
>>>> +            };
>>
>> Same issue here, I guess?
> 
> Yes.

I fear the only conclusion right now would be to defer RTD1195 to v5.6
so that at least RTD129x parts can progress for v5.5? Unless we can
agree on a subset to at least showcase initial earlycon output and allow
us to add nodes, such as reset controllers, as we add/enable drivers.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92283C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6647520730
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 17:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfKQRIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 12:08:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:48554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfKQRIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 12:08:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA5C3AC11;
        Sun, 17 Nov 2019 17:08:11 +0000 (UTC)
Subject: Re: [PATCH v3 8/8] ARM: realtek: Enable RTD1195 arch timer
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        James Tai <james.tai@realtek.com>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-9-afaerber@suse.de> <20191117110214.6b160b2e@why>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <7015e4c4-f999-d2e8-fd1f-e15e74a0d092@suse.de>
Date:   Sun, 17 Nov 2019 18:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191117110214.6b160b2e@why>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.11.19 um 12:02 schrieb Marc Zyngier:
> On Sun, 17 Nov 2019 08:21:09 +0100
> Andreas Färber <afaerber@suse.de> wrote:
> 
>> Without this magic write the timer doesn't work and boot gets stuck.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  What is the name of the register 0xff018000?
>>  Is 0x1 a BIT(0) write, or how are the register bits defined?
>>  Is this a reset or a clock gate? How should we model it in DT?

    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

>>  
>>  v2 -> v3: Unchanged
>>  
>>  v2: New
>>  
>>  arch/arm/mach-realtek/rtd1195.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/mach-realtek/rtd1195.c b/arch/arm/mach-realtek/rtd1195.c
>> index b31a4066be87..0532379c74f5 100644
>> --- a/arch/arm/mach-realtek/rtd1195.c
>> +++ b/arch/arm/mach-realtek/rtd1195.c
>> @@ -5,6 +5,9 @@
>>   * Copyright (c) 2017-2019 Andreas Färber
>>   */
>>  
>> +#include <linux/clk-provider.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/io.h>
>>  #include <linux/memblock.h>
>>  #include <asm/mach/arch.h>
>>  
>> @@ -24,6 +27,18 @@ static void __init rtd1195_reserve(void)
>>  	rtd1195_memblock_remove(0x18100000, 0x01000000);
>>  }
>>  
>> +static void __init rtd1195_init_time(void)
>> +{
>> +	void __iomem *base;
>> +
>> +	base = ioremap(0xff018000, 4);
>> +	writel(0x1, base);
>> +	iounmap(base);
>> +
>> +	of_clk_init(NULL);
>> +	timer_probe();
>> +}
> 
> Gawd... Why isn't this set from the bootloader? By the time the kernel
> starts, everything should be up and running. What is it going to do
> when you kexec? Shouldn't this be a read/modify/write sequence?

Again, I can't comment on why their BSP bootloaders don't do things the
expected way. The list of issues is long, and the newest U-Boot I've
seen for RTD1395 was v2015.07 based, still downstream and pre-EBBR.
And before we get a .dts merged into the kernel with all needed nodes
(network, eMMC, etc.), there is zero chance of a mainline U-Boot anyway.

v2 did not get any review from Realtek, so for this v3 I explicitly
spelled out my register questions above, in case the term "magic" was
not enough to prompt an actual explanation of what this is doing...

Only change that I can apply right now will be to turn this writel()
into a writel_relaxed(). Tested OK.

Original one-line BSP code:
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm/mach-rtd119x/rtd119x.c#L105

In my testing, all I can tell is that on both X1000 and Horseradish the
register value is 0x0 before above BSP-inspired write of 0x1.
So BIT(0) might be a clock gate enable or a reset deassert, or it might
be a larger field meaning something else.

For now, my small Busybox initrd is not capable of testing kexec, but I
don't foresee a problem here, given the observed register values.
(Unlike RTD1295, RTD1195 does not have native AHCI support for rootfs.)

Given the odd location of this register right after GICV rather than on
their r-bus, can you rule out that this is some standard Arm register?

Note that this patch is intentionally separate and last in this series,
precisely due to this expected contentious discussion. :) But as there
seems no realistic chance of anyone implementing a new U-Boot anytime
soon, we'll have to live with some such ugly solution to unblock boot.


Slightly related to this .init_time hook, I am facing an issue for SMP
where my ioremap() fails in .smp_init_cpus if I don't implement a
.map_io hook here, providing an old-style fixed mapping for r-bus. Later
ioremap()s in actual drivers in that same r-bus space do succeed.

And for the record, RTD1295 and RTD1395 still don't have SMP in mainline
either because they're not implementing it via PSCI; RTD1619 appears to
be the first to do that in BL31. No public BL31 code [1] that we might
fix, nor any public documentation on how we might experimentally replace
BL31 with one written from scratch, so I'm carrying non-upstreamable
patches (marked "HACK:") hacking up arm64 spin-table to use different
addresses and widths to bring them up. :/

Regards,
Andreas

[1] https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

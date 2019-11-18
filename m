Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88412C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7EC2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574069226;
	bh=VxT1OH3J1ZyG3/IslKgKDNPh9e6QJ7OGFhCnc6abxVs=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=qrPSKvHO8v3U7d9meUNAOG9pGGmOhhyNBBuWpxr1D4Ob25Ogx9oxHycuucw1RlahL
	 aX5MB93jd9atHIenCnPKTZssFnLN0B96u5+UCJ+0/UGYRNqTwpEwNRanE6lR8udxej
	 aMMMAR5yI6NRlnWY51u3jeLNBGBOqesnkXQJiDgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfKRJ1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:27:05 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:54829 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbfKRJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:27:04 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iWdJF-0005vm-TH; Mon, 18 Nov 2019 10:27:01 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 8/8] ARM: realtek: Enable RTD1195 arch timer
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 18 Nov 2019 09:27:01 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        James Tai <james.tai@realtek.com>
In-Reply-To: <7015e4c4-f999-d2e8-fd1f-e15e74a0d092@suse.de>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-9-afaerber@suse.de> <20191117110214.6b160b2e@why>
 <7015e4c4-f999-d2e8-fd1f-e15e74a0d092@suse.de>
Message-ID: <e99e40d8c95147861ab600c5d5287f8f@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: afaerber@suse.de, linux-realtek-soc@lists.infradead.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.tai@realtek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-17 17:08, Andreas Färber wrote:
> Am 17.11.19 um 12:02 schrieb Marc Zyngier:
>> On Sun, 17 Nov 2019 08:21:09 +0100
>> Andreas Färber <afaerber@suse.de> wrote:
>>
>>> Without this magic write the timer doesn't work and boot gets 
>>> stuck.
>>>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> ---
>>>  What is the name of the register 0xff018000?
>>>  Is 0x1 a BIT(0) write, or how are the register bits defined?
>>>  Is this a reset or a clock gate? How should we model it in DT?
>
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Sorry? Do you expect me to come up with answer to these questions?

>>>
>>>  v2 -> v3: Unchanged
>>>
>>>  v2: New
>>>
>>>  arch/arm/mach-realtek/rtd1195.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-realtek/rtd1195.c 
>>> b/arch/arm/mach-realtek/rtd1195.c
>>> index b31a4066be87..0532379c74f5 100644
>>> --- a/arch/arm/mach-realtek/rtd1195.c
>>> +++ b/arch/arm/mach-realtek/rtd1195.c
>>> @@ -5,6 +5,9 @@
>>>   * Copyright (c) 2017-2019 Andreas Färber
>>>   */
>>>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/clocksource.h>
>>> +#include <linux/io.h>
>>>  #include <linux/memblock.h>
>>>  #include <asm/mach/arch.h>
>>>
>>> @@ -24,6 +27,18 @@ static void __init rtd1195_reserve(void)
>>>  	rtd1195_memblock_remove(0x18100000, 0x01000000);
>>>  }
>>>
>>> +static void __init rtd1195_init_time(void)
>>> +{
>>> +	void __iomem *base;
>>> +
>>> +	base = ioremap(0xff018000, 4);
>>> +	writel(0x1, base);
>>> +	iounmap(base);
>>> +
>>> +	of_clk_init(NULL);
>>> +	timer_probe();
>>> +}
>>
>> Gawd... Why isn't this set from the bootloader? By the time the 
>> kernel
>> starts, everything should be up and running. What is it going to do
>> when you kexec? Shouldn't this be a read/modify/write sequence?
>
> Again, I can't comment on why their BSP bootloaders don't do things 
> the
> expected way. The list of issues is long, and the newest U-Boot I've
> seen for RTD1395 was v2015.07 based, still downstream and pre-EBBR.
> And before we get a .dts merged into the kernel with all needed nodes
> (network, eMMC, etc.), there is zero chance of a mainline U-Boot 
> anyway.

[...]

I certainly dispute that. If you're able to support all of this in the
kernel, you're most probably able to do it in u-boot, and that's the 
right
place to do it (and that can be a pretty simple u-boot if you use the
original one as a first-stage loader).

I'm not trying to undermine your effort in supporting these platforms
in mainline. This is certainly commendable. But you're unfortunately
pushing in a direction that we've tried hard to move away from for
a good 8 years.

Look at what we did on the Allwinner front: we got a terrible piece of
crap, and turned it into one of the best supported platform, because
we've put the effort where it mattered. I personally wrote PSCI support
and HYP enablement in u-boot, addressing in one go most of the issues 
you
mention here. It didn't take that much time, and it is now there for 
you
to make use of.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD900C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15922080D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfDURZA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:25:00 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42367 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDURZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:25:00 -0400
X-Originating-IP: 93.23.249.69
Received: from localhost (69.249.23.93.rev.sfr.net [93.23.249.69])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BF8EC240008;
        Sun, 21 Apr 2019 17:24:57 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "andrew\@lunn.ch" <andrew@lunn.ch>,
        "jason\@lakedaemon.net" <jason@lakedaemon.net>
Cc:     "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: mvebu: kirkwood: remove error message when retrieving mac address
In-Reply-To: <ed2e24ed25504979aef666b6f677f34e@svr-chch-ex1.atlnz.lc>
References: <20190218024645.29059-1-chris.packham@alliedtelesis.co.nz> <877edv3jmw.fsf@FE-laptop> <ed2e24ed25504979aef666b6f677f34e@svr-chch-ex1.atlnz.lc>
Date:   Sun, 21 Apr 2019 19:24:57 +0200
Message-ID: <8736mb8e52.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> On 20/02/19 4:14 AM, Gregory CLEMENT wrote:
>> Hi Chris,
>>   
>>   On lun., févr. 18 2019, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
>> 
>>> Kirkwood has always had the ability to retrieve the local-mac-address
>>> from the hardware (usually this was configured by the bootloader). This
>>> is particularly useful when dealing with a legacy non-DT aware
>>> bootloader.
>>>
>>> The "error" message just indicated that the board used an old bootloader
>>> and in many cases users can't do anything about this. The message
>>> probably should have been pr_info() to inform the user that the kernel
>>> has been helpful but rather than than let's remove it entirely to make
>>> the kernel less noisy.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> 
>> I'm OK with this patch, however as it is not a fix, it's too late for
>> 5.1. I will apply it on mvebu/arm for 5.2 once 5.1-rc1 will be released.
>> 
>
> No problem with that. We have a local fork I'll cherry pick it into once 
> it hits linux-mvebu.
>

Applied on mvebu/arm

Thanks,

Gregory


>> Thanks,
>> 
>> gregory
>> 
>>> ---
>>>   arch/arm/mach-mvebu/kirkwood.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
>>> index 0aa88105d46e..bf3ff0f580c2 100644
>>> --- a/arch/arm/mach-mvebu/kirkwood.c
>>> +++ b/arch/arm/mach-mvebu/kirkwood.c
>>> @@ -107,8 +107,6 @@ static void __init kirkwood_dt_eth_fixup(void)
>>>   		clk_prepare_enable(clk);
>>>   
>>>   		/* store MAC address register contents in local-mac-address */
>>> -		pr_err(FW_INFO "%pOF: local-mac-address is not set\n", np);
>>> -
>>>   		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
>>>   		if (!pmac)
>>>   			goto eth_fixup_no_mem;
>>> -- 
>>> 2.20.1
>>>
>> 
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

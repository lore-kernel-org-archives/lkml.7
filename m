Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAD62070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574260368;
	bh=G31VeWrQF8NZXVZmBlQH2MMEbbjijNrXifJgKOgU4Go=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=QRa8G9zS5z6sf9imNCoFBW78bLX6ue3JF03Ge73LOcXFLfm3tdxXJGUPQeU8EQrCo
	 IwvON9cUe2JH/T31zXpNEVs4QnDsLuiaEYKNb3YTftn+ZDihDOSfMJfT/1A2XvtDnq
	 4joluShVUOXrbspZOtoM7cs/ftcmjOBrOSFSJzrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfKTOcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:32:47 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:44250 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729591AbfKTOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:32:47 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iXR2B-0005H9-UN; Wed, 20 Nov 2019 15:32:43 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Nov 2019 14:32:43 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <18c09fc4-fe7b-7ba0-7cd3-ae0c650ca4a8@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
 <20191119021917.15917-3-afaerber@suse.de>
 <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
 <e98364c5-a859-7981-8ccf-f8e5b5069379@suse.de> <20191119222956.23665e5d@why>
 <d7416bdb-e20a-42e1-daff-c61369f359fa@suse.de>
 <e4d30ff2485c3f9ffd2b934f1f757d19@www.loen.fr>
 <18c09fc4-fe7b-7ba0-7cd3-ae0c650ca4a8@suse.de>
Message-ID: <5d834a7c4b6195bb09675ffb96f509de@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: afaerber@suse.de, linux-realtek-soc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernelrocks@gmail.com, james.tai@realtek.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-20 13:34, Andreas Färber wrote:
> Am 20.11.19 um 11:20 schrieb Marc Zyngier:
>> On 2019-11-19 23:33, Andreas Färber wrote:
>>> Am 19.11.19 um 23:29 schrieb Marc Zyngier:
>>>> On Tue, 19 Nov 2019 21:56:48 +0100
>>>> Andreas Färber <afaerber@suse.de> wrote:
>>>>> Am 19.11.19 um 13:01 schrieb Marc Zyngier:
>>>>>> On 2019-11-19 02:19, Andreas Färber wrote:
>>>>>>> +static void rtd1195_mux_enable_irq(struct irq_data *data)
>>>>>>> +{
>>>>>>> +    struct rtd1195_irq_mux_data *mux_data =
>>>>>>> irq_data_get_irq_chip_data(data);
>>>>>>> +    unsigned long flags;
>>>>>>> +    u32 mask;
>>>>>>> +
>>>>>>> +    mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
>>>>>>> +    if (!mask)
>>>>>>> +        return;
>>>>>>
>>>>>> How can this happen? You've mapped the interrupt, so it exists.
>>>>>> I can't see how you can decide to fail such enable.
>>>>>
>>>>> The [UMSK_]ISR bits and the SCPU_INT_EN bits are not (all) the 
>>>>> same.
>>>>>
>>>>> My ..._isr_to_scpu_int_en[] arrays have 32 entries for O(1) 
>>>>> lookup, but
>>>>> are sparsely populated. So there are circumstances such as 
>>>>> WDOG_NMI as
>>>>> well as reserved bits that we cannot enable.
>>>>
>>>> But the you should have failed the map. The moment you allow the
>>>> mapping to occur, you have accepted the contract that this 
>>>> interrupt is
>>>> usable.
>>>>
>>>>> This check should be
>>>>> identical to v3; the equivalent mask check inside the interrupt 
>>>>> handler
>>>>> was extended with "mask &&" to do the same in this v4.
>>>>
>>>> Spurious interrupts are a different matter. What I'm objecting to 
>>>> here
>>>> is a simple question of logic, whether or not you are allowed to 
>>>> fail
>>>> enabling an interrupt that you've otherwise allowed to be 
>>>> populated.
>>>
>>> Then what are you suggesting instead? I don't see how my array map
>>> lookup could fail other than returning a zero value, given its 
>>> static
>>> initialization. Check for a zero mask in 
>>> rtd1195_mux_irq_domain_map()?
>>> Then we wouldn't be able to use the mentioned WDOG_NMI. Add another
>>> per-mux info field for which interrupts are valid to map?
>>
>> I'm suggesting that you fail the map if you're unable to allow the
>> interrupt to be enabled.
>
> The NMI will always be enabled, it just can't be disabled.

If I really cared, I'd cry. This HW is useless.

> I have added a check to suppress a zero hwirq. Suppressing reserved 
> IRQ
> bits will take some more effort to distinguish from NMIs. In 
> particular
> if we flag this in the ..._isr_to_scpu_int_en array by some magic 
> mask
> value like 0xffffffff then all users need to check for two rather 
> than
> one value - but if we reduce the users, it shouldn't matter too much.

1) you can't suppress a level interrupt that cannot be disabled. It 
will
fire back at you.
2) given that you have to demux things using MMIO accesses, performance
is the least of anybody's worry.

>
> With contract I assume you're referring to these callbacks having a 
> void
> return type, unable to return an error to the caller, and there being 
> no
> is_enabled/is_masked callbacks for anyone to discover this.
>
> Unfortunately NMI handling appears to be only used in GICv3 and is 
> not
> very intuitive for me: Apparently I can only flag the whole irq_chip 
> as
> being NMI but not individual IRQs? Would that mean that this driver
> would need to instantiate a second irq_chip for that one IRQ? How 
> would
> that work for mapping from DT? Given that this mux relies on a 
> maskable
> GICv2 IRQ, it's not a "true" NMI in the Linux sense anyway, other 
> than
> the .irq_mask callback not being applicable. While I don't need that 
> NMI
> immediately, I would prefer not to merge a driver that by design 
> can't
> cope with it later.

You are missing the point of the pseudo-NMI infrastructure. To be 
useful,
it *must* be the root interrupt controller. Otherwise, you cannot 
distinguish
it from the other interrupts it is muxed with. Your 'NMI' is absolutely
unusable, and whoever designed this HW should be actively prevented
from ever designing another interrupt controller again.

> I'll try to post a v5 with rsv and nmi blocked in map for further
> discussion tonight.

I don't plan to review any of this until after the merge window, so 
please
take as long as you want.

         M.
-- 
Jazz is not dead. It just smells funny...

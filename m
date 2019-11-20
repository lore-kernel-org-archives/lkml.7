Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE35C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA482246E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574252634;
	bh=TCYTPfYof0Cx0AXpB59eDNWC2QJQ3RY0wCvauyjA8kQ=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=YDkKBN4slfl0rwg87hhr1HbUBhbZfc3PbKj9jAypRbz4CAns29IOyGcXO7BMMj5/K
	 T1bjSHz04sw0e0eIJSP/xpGCOOe2TrM0lg5TRkPkNBwnZGVgP4SVQZNoaA5J86b481
	 4Q5R2t8lQxzDSMQr34kwOu+xtgg3kHZg++cOR9Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfKTMXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:23:53 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:60894 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729026AbfKTMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:23:52 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iXP1R-0002tb-PO; Wed, 20 Nov 2019 13:23:49 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Nov 2019 12:23:49 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <37b3b5d3-b3c8-b513-f8b5-9054f32a4b53@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
 <20191119021917.15917-3-afaerber@suse.de>
 <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
 <0bff78c1-a1d0-9631-fbf4-e0d1ef1264ea@suse.de>
 <8137861d0a89dd246b3334ac596da8be@www.loen.fr>
 <37b3b5d3-b3c8-b513-f8b5-9054f32a4b53@suse.de>
Message-ID: <3d74bc591552a22b06f6f77190cbfec5@www.loen.fr>
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

On 2019-11-20 12:12, Andreas Färber wrote:
> Am 20.11.19 um 11:18 schrieb Marc Zyngier:
>> On 2019-11-19 23:25, Andreas Färber wrote:
>>> Am 19.11.19 um 13:01 schrieb Marc Zyngier:
>>>> On 2019-11-19 02:19, Andreas Färber wrote:
>>>>> diff --git a/drivers/irqchip/irq-rtd1195-mux.c
>>>>> b/drivers/irqchip/irq-rtd1195-mux.c
>>>>> new file mode 100644
>>>>> index 000000000000..e6b08438b23c
>>>>> --- /dev/null
>>>>> +++ b/drivers/irqchip/irq-rtd1195-mux.c
>>> [...]
>>>>> +static void rtd1195_mux_irq_handle(struct irq_desc *desc)
>>>>> +{
>>>>> +    struct rtd1195_irq_mux_data *data =
>>>>> irq_desc_get_handler_data(desc);
>>>>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>>>>> +    u32 isr, mask;
>>>>> +    int i;
>>>>> +
>>>>> +    chained_irq_enter(chip, desc);
>>>>> +
>>>>> +    isr = readl_relaxed(data->reg_isr);
>>>>> +
>>>>> +    while (isr) {
>>>>> +        i = __ffs(isr);
>>>>> +        isr &= ~BIT(i);
>>>>> +
>>>>> +        mask = data->info->isr_to_int_en_mask[i];
>>>>> +        if (mask && !(data->scpu_int_en & mask))
>>>>> +            continue;
>>>>> +
>>>>> +        if (!generic_handle_irq(irq_find_mapping(data->domain, 
>>>>> i)))
>>>>> +            writel_relaxed(BIT(i), data->reg_isr);
>>>>
>>>> What does this write do exactly? It is the same thing as a 'mask',
>>>> which is pretty odd. So either:
>>>>
>>>> - this is not doing anything and your 'mask' callback is bogus
>>>>   (otherwise you'd never have more than a single interrupt)
>>>>
>>>> - or this is an ACK operation, and this should be described as
>>>>   such (and then fix the mask/unmask/enable/disable mess that
>>>>   results from it).
>>>
>>> This is supposed to be an ACK, i.e. clear-1-bits operation.
>>
>> If it is an ACK, model it as such, and do not open-code it.
>
> I have found an .irq_ack callback - moving this there appears to 
> work.
>
> Alternatively there is an irq_eoi callback and an 
> IRQCHIP_EOI_IF_HANDLED
> flag.
>
> It would really help me if you spelled out explicitly where you think 
> I
> should be moving code, as the documentation in irq.h is not all that
> helpful in terms of when are they called and what should be done 
> there.
> In case not obvious, this is my first irqchip driver.

Implementing one callback or the other really depends on how the HW
behaves. The irq framework gives you a wide range of flows that allow
you to plug your driver in the stack, but the prerequisite is that you
know *exactly* how the HW behaves. Ack and EOI have very different
meanings, are called from different flows, and correspond to different
states in the interrupt life cycle.

Use the wrong one, and you will lose interrupts. If you don't know how
the HW behaves, then the chances of something bad happening are pretty
high (you'll end-up in deadlock land at some point). I'm afraid I 
cannot
help you with that, short of being given access to some documentation
that doesn't seem to exist.

         M.
-- 
Jazz is not dead. It just smells funny...

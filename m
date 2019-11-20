Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3830FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB1D206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574245142;
	bh=ZcJZgDgu7diR6lvmOj3GTb5WMMoYE4M7b61T8x8eWMc=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=hIYf5M5Tke3R6eluWAb45oo7ZZ0dQA6MnKcB4QJsu9VuYULF6sPjMdFhzvkryM89p
	 xqUuF3zF5VU1HAFh/1sWz2SDM13aQdnJIR4TWPanvb0rWbEr9NN3TgcoUKCnmeihwX
	 GA90+7wtQt26uD3tTYgDBcG0qXUwb7ZLI3gEQooU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfKTKTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:19:01 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:48643 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728355AbfKTKTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:19:00 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iXN4b-0001G1-Pc; Wed, 20 Nov 2019 11:18:57 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Nov 2019 10:18:57 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <0bff78c1-a1d0-9631-fbf4-e0d1ef1264ea@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
 <20191119021917.15917-3-afaerber@suse.de>
 <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
 <0bff78c1-a1d0-9631-fbf4-e0d1ef1264ea@suse.de>
Message-ID: <8137861d0a89dd246b3334ac596da8be@www.loen.fr>
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

On 2019-11-19 23:25, Andreas Färber wrote:
> Am 19.11.19 um 13:01 schrieb Marc Zyngier:
>> On 2019-11-19 02:19, Andreas Färber wrote:
>>> diff --git a/drivers/irqchip/irq-rtd1195-mux.c
>>> b/drivers/irqchip/irq-rtd1195-mux.c
>>> new file mode 100644
>>> index 000000000000..e6b08438b23c
>>> --- /dev/null
>>> +++ b/drivers/irqchip/irq-rtd1195-mux.c
> [...]
>>> +static void rtd1195_mux_irq_handle(struct irq_desc *desc)
>>> +{
>>> +    struct rtd1195_irq_mux_data *data = 
>>> irq_desc_get_handler_data(desc);
>>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +    u32 isr, mask;
>>> +    int i;
>>> +
>>> +    chained_irq_enter(chip, desc);
>>> +
>>> +    isr = readl_relaxed(data->reg_isr);
>>> +
>>> +    while (isr) {
>>> +        i = __ffs(isr);
>>> +        isr &= ~BIT(i);
>>> +
>>> +        mask = data->info->isr_to_int_en_mask[i];
>>> +        if (mask && !(data->scpu_int_en & mask))
>>> +            continue;
>>> +
>>> +        if (!generic_handle_irq(irq_find_mapping(data->domain, 
>>> i)))
>>> +            writel_relaxed(BIT(i), data->reg_isr);
>>
>> What does this write do exactly? It is the same thing as a 'mask',
>> which is pretty odd. So either:
>>
>> - this is not doing anything and your 'mask' callback is bogus
>>   (otherwise you'd never have more than a single interrupt)
>>
>> - or this is an ACK operation, and this should be described as
>>   such (and then fix the mask/unmask/enable/disable mess that
>>   results from it).
>
> This is supposed to be an ACK, i.e. clear-1-bits operation.

If it is an ACK, model it as such, and do not open-code it.

>
> The BSP had extended various drivers, such as 8250 UART, to do this 
> ack
> in their interrupt handler through an additional DT reg region. I 
> tried
> to clean that up by handling it centrally here in the irqchip driver.
>
>>
>> as I can't see how the same register can be used for both purposes.
>> You should be able to verify this experimentally, even without
>> documentation.
>
> There are three registers here:
>
> MIS_UMSK_ISR    - MISC unmasked interrupt status register
> MIS_ISR         - MISC   masked interrupt status register
> MIS_SCPU_INT_EN - MISC SCPU interrupt enable register
>
> The latter is a regular R/W register; the former two have a 
> write_data
> field as BIT(0), with 1 indicating a write vs. 0 indicating clear, 
> RAZ.
>
> By enabling/disabling in _SCPU_INT_EN we mask/unmask them in _ISR but
> not in _UMSK_ISR.
>
> Does that shed any more light?

None whatsoever. Your mask callback doesn't make any sense, since it
actually acks the interrupt. My gut feeling is that your enable/disable
should really be mask/unmask.

>
> So given that we're iterating over reg_isr above, we could probably 
> drop
> the mask check here...
>
> In addition there are MIS_[UMSK_]ISR_SWC and MIS_SETTING_SWC 
> registers
> for Secure World, and MIS_FAST_INT_EN_* and MIS_FAST_ISR as well as
> various GPIO interrupt registers.

This doesn't seem relevant to the discussion here.

         M.
-- 
Jazz is not dead. It just smells funny...

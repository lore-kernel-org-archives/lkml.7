Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D66BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6422445
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKSXZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:25:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:33424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbfKSXZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:25:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9B13ACC0;
        Tue, 19 Nov 2019 23:25:26 +0000 (UTC)
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20191119021917.15917-1-afaerber@suse.de>
 <20191119021917.15917-3-afaerber@suse.de>
 <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <0bff78c1-a1d0-9631-fbf4-e0d1ef1264ea@suse.de>
Date:   Wed, 20 Nov 2019 00:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.11.19 um 13:01 schrieb Marc Zyngier:
> On 2019-11-19 02:19, Andreas Färber wrote:
>> diff --git a/drivers/irqchip/irq-rtd1195-mux.c
>> b/drivers/irqchip/irq-rtd1195-mux.c
>> new file mode 100644
>> index 000000000000..e6b08438b23c
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-rtd1195-mux.c
[...]
>> +static void rtd1195_mux_irq_handle(struct irq_desc *desc)
>> +{
>> +    struct rtd1195_irq_mux_data *data = irq_desc_get_handler_data(desc);
>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>> +    u32 isr, mask;
>> +    int i;
>> +
>> +    chained_irq_enter(chip, desc);
>> +
>> +    isr = readl_relaxed(data->reg_isr);
>> +
>> +    while (isr) {
>> +        i = __ffs(isr);
>> +        isr &= ~BIT(i);
>> +
>> +        mask = data->info->isr_to_int_en_mask[i];
>> +        if (mask && !(data->scpu_int_en & mask))
>> +            continue;
>> +
>> +        if (!generic_handle_irq(irq_find_mapping(data->domain, i)))
>> +            writel_relaxed(BIT(i), data->reg_isr);
> 
> What does this write do exactly? It is the same thing as a 'mask',
> which is pretty odd. So either:
> 
> - this is not doing anything and your 'mask' callback is bogus
>   (otherwise you'd never have more than a single interrupt)
> 
> - or this is an ACK operation, and this should be described as
>   such (and then fix the mask/unmask/enable/disable mess that
>   results from it).

This is supposed to be an ACK, i.e. clear-1-bits operation.

The BSP had extended various drivers, such as 8250 UART, to do this ack
in their interrupt handler through an additional DT reg region. I tried
to clean that up by handling it centrally here in the irqchip driver.

> 
> as I can't see how the same register can be used for both purposes.
> You should be able to verify this experimentally, even without
> documentation.

There are three registers here:

MIS_UMSK_ISR    - MISC unmasked interrupt status register
MIS_ISR         - MISC   masked interrupt status register
MIS_SCPU_INT_EN - MISC SCPU interrupt enable register

The latter is a regular R/W register; the former two have a write_data
field as BIT(0), with 1 indicating a write vs. 0 indicating clear, RAZ.

By enabling/disabling in _SCPU_INT_EN we mask/unmask them in _ISR but
not in _UMSK_ISR.

Does that shed any more light?

So given that we're iterating over reg_isr above, we could probably drop
the mask check here...

In addition there are MIS_[UMSK_]ISR_SWC and MIS_SETTING_SWC registers
for Secure World, and MIS_FAST_INT_EN_* and MIS_FAST_ISR as well as
various GPIO interrupt registers.

Regards,
Andreas

>> +    }
>> +
>> +    chained_irq_exit(chip, desc);
>> +}
>> +
>> +static void rtd1195_mux_mask_irq(struct irq_data *data)
>> +{
>> +    struct rtd1195_irq_mux_data *mux_data =
>> irq_data_get_irq_chip_data(data);
>> +
>> +    writel_relaxed(BIT(data->hwirq), mux_data->reg_isr);
>> +}
>> +
>> +static void rtd1195_mux_unmask_irq(struct irq_data *data)
>> +{
>> +    struct rtd1195_irq_mux_data *mux_data =
>> irq_data_get_irq_chip_data(data);
>> +
>> +    writel_relaxed(BIT(data->hwirq), mux_data->reg_umsk_isr);
>> +}
>> +
>> +static void rtd1195_mux_enable_irq(struct irq_data *data)
>> +{
>> +    struct rtd1195_irq_mux_data *mux_data =
>> irq_data_get_irq_chip_data(data);
>> +    unsigned long flags;
>> +    u32 mask;
>> +
>> +    mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
>> +    if (!mask)
>> +        return;
> 
> How can this happen? You've mapped the interrupt, so it exists.
> I can't see how you can decide to fail such enable.
> 
>> +
>> +    raw_spin_lock_irqsave(&mux_data->lock, flags);
>> +
>> +    mux_data->scpu_int_en |= mask;
>> +    writel_relaxed(mux_data->scpu_int_en, mux_data->reg_scpu_int_en);
>> +
>> +    raw_spin_unlock_irqrestore(&mux_data->lock, flags);
>> +}
>> +
>> +static void rtd1195_mux_disable_irq(struct irq_data *data)
>> +{
>> +    struct rtd1195_irq_mux_data *mux_data =
>> irq_data_get_irq_chip_data(data);
>> +    unsigned long flags;
>> +    u32 mask;
>> +
>> +    mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
>> +    if (!mask)
>> +        return;
>> +
>> +    raw_spin_lock_irqsave(&mux_data->lock, flags);
>> +
>> +    mux_data->scpu_int_en &= ~mask;
>> +    writel_relaxed(mux_data->scpu_int_en, mux_data->reg_scpu_int_en);
>> +
>> +    raw_spin_unlock_irqrestore(&mux_data->lock, flags);
>> +}
>> +
>> +static struct irq_chip rtd1195_mux_irq_chip = {
>> +    .name        = "rtd1195-mux",
>> +    .irq_mask    = rtd1195_mux_mask_irq,
>> +    .irq_unmask    = rtd1195_mux_unmask_irq,
>> +    .irq_enable    = rtd1195_mux_enable_irq,
>> +    .irq_disable    = rtd1195_mux_disable_irq,
>> +};
> 
> [...]
> 
> Although the code is pretty clean, the way you drive the HW looks
> suspicious, and requires clarification.
> 
> Thanks,
> 
>         M.


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

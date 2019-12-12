Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BC1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99372077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576158524;
	bh=JOyBpBl9Ph7XMLyCKxHbeTrjUzbMw1WTgoc59K9fOss=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=GvRs5HDn0ry4hxJ4HYtCBDZJ697/WwmXFqgKNPULdcMnuwbVZdDX2O9OkZq5oQ/q/
	 a5mGyAPQonYcXRSyLtga5tTrFhK8+ka6F3sd+DVYUztGL+7WjRtZqxp9erPptcx1wJ
	 1IPUpPDosrX6quSGDIuQhJuZd+EiExbQCycd8rL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfLLNsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:48:43 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:48589 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729405AbfLLNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:48:43 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ifOpd-0002Ct-8N; Thu, 12 Dec 2019 14:48:41 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v5 3/9] irqchip: rtd1195-mux: Implement  =?UTF-8?Q?irq=5Fget=5Firqchip=5Fstate?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 12 Dec 2019 13:48:41 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <20191121050208.11324-4-afaerber@suse.de>
References: <20191121050208.11324-1-afaerber@suse.de>
 <20191121050208.11324-4-afaerber@suse.de>
Message-ID: <f756e3ccde3b928ccc75f41f2012895a@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: afaerber@suse.de, linux-realtek-soc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-21 05:02, Andreas Färber wrote:
> Implement the .irq_get_irqchip_state callback to retrieve pending,
> active and masked interrupt status.
>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v5: New
>
>  drivers/irqchip/irq-rtd1195-mux.c | 36 
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/irqchip/irq-rtd1195-mux.c
> b/drivers/irqchip/irq-rtd1195-mux.c
> index 0e86973aafca..2f1bcfd9d5d6 100644
> --- a/drivers/irqchip/irq-rtd1195-mux.c
> +++ b/drivers/irqchip/irq-rtd1195-mux.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/bitops.h>
>  #include <linux/io.h>
> +#include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> @@ -96,10 +97,45 @@ static void rtd1195_mux_unmask_irq(struct 
> irq_data *data)
>  	raw_spin_unlock_irqrestore(&mux->lock, flags);
>  }
>
> +static int rtd1195_mux_get_irqchip_state(struct irq_data *data,
> +	enum irqchip_irq_state which, bool *state)
> +{
> +	struct rtd1195_irq_mux_data *mux = 
> irq_data_get_irq_chip_data(data);
> +	u32 val;
> +
> +	switch (which) {
> +	case IRQCHIP_STATE_PENDING:
> +		/*
> +		 * UMSK_ISR provides the unmasked pending interrupts,
> +		 * except UART and I2C.
> +		 */
> +		val = readl_relaxed(mux->reg_umsk_isr);
> +		*state = !!(val & BIT(data->hwirq));
> +		break;
> +	case IRQCHIP_STATE_ACTIVE:
> +		/*
> +		 * ISR provides the masked pending interrupts,
> +		 * including UART and I2C.
> +		 */
> +		val = readl_relaxed(mux->reg_isr);
> +		*state = !!(val & BIT(data->hwirq));
> +		break;

ACTIVE has a very specific meaning: it indicates that the interrupt is
being handled right now. What this tells you is whether the interrupt
is pending and unmasked, which is an entirely different thing.

This will lead to irq_disable() misbehaving (it will assume that
the interrupt is active while it is only pending).

Given what the HW exposes (or rather, what this driver exposes of the 
HW),
I don't think you can implement this state.

> +	case IRQCHIP_STATE_MASKED:
> +		val = mux->info->isr_to_int_en_mask[data->hwirq];
> +		*state = !(mux->scpu_int_en & val);

Shouldn't you take the corresponding spinlock given that you can
have a pending update in parallel?

         M.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct irq_chip rtd1195_mux_irq_chip = {
>  	.irq_ack		= rtd1195_mux_ack_irq,
>  	.irq_mask		= rtd1195_mux_mask_irq,
>  	.irq_unmask		= rtd1195_mux_unmask_irq,
> +	.irq_get_irqchip_state	= rtd1195_mux_get_irqchip_state,
>  };
>
>  static int rtd1195_mux_irq_domain_map(struct irq_domain *d,

-- 
Jazz is not dead. It just smells funny...

Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F388AC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB92A21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570020051;
	bh=+H9Ec1mNKYee9LhDa3fPlEl+5r7JH1fOVojQDyWshVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wp95+B8zhPApAD8HjTSF7mY1pwXdw1hJ/1B3GMtEgIkVDxJGTqPxCJwVZmA/sDJvf
	 n6rWCS8aROICjPElujUvvcZ5EE54vH947u90MnHzY5ZSaeQGUhWRNLDnCbk+/hBD0S
	 0BhkBhehZiiNeDMYfS4+Aq7k9Jbqxn0tdYA1vN9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfJBMkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:40:51 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:51493 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbfJBMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:40:51 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFdvv-0007Rb-6t; Wed, 02 Oct 2019 14:40:43 +0200
Date:   Wed, 2 Oct 2019 13:40:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: Re: [PATCH 5/7] irqchip/irq-bcm2836: Add support for the 7211
 interrupt controller
Message-ID: <20191002134041.5a181d96@why>
In-Reply-To: <20191001224842.9382-6-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
        <20191001224842.9382-6-f.fainelli@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, eric@anholt.net, wahrenst@gmx.net, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Oct 2019 15:48:40 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> The root interrupt controller on 7211 is about identical to the one
> existing on BCM2836, except that the SMP cross call are done through the
> standard ARM GIC-400 interrupt controller. This interrupt controller is
> used for side band wake-up signals though.

I don't fully grasp how this thing works.

If the 7211 interrupt controller is root and the GIC is used for SGIs,
this means that the GIC outputs (IRQ/FIQ/VIRQ/VFIQ, times eight) are
connected to individual inputs to the 7211 controller. Seems totally
braindead, and unexpectedly so.

If the GIC is root and the 7211 outputs into the GIC all of its
interrupts as a secondary irqchip, it would at least match an existing
(and pretty bad) pattern.

So which one of the two is it?

> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/irqchip/irq-bcm2836.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> index 2038693f074c..77fa395c8f6b 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -112,6 +112,8 @@ static int bcm2836_map(struct irq_domain *d, unsigned int irq,
>  		return -EINVAL;
>  	}
>  
> +	chip->flags |= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
> +
>  	irq_set_percpu_devid(irq);
>  	irq_domain_set_info(d, irq, hw, chip, d->host_data,
>  			    handle_percpu_devid_irq, NULL, NULL);
> @@ -216,8 +218,9 @@ static void bcm2835_init_local_timer_frequency(void)
>  	writel(0x80000000, intc.base + LOCAL_PRESCALER);
>  }
>  
> -static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
> -						      struct device_node *parent)
> +static int __init arm_irqchip_l1_intc_of_init_smp(struct device_node *node,
> +						  struct device_node *parent,
> +						  bool smp_init)
>  {
>  	intc.base = of_iomap(node, 0);
>  	if (!intc.base) {
> @@ -232,11 +235,27 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
>  	if (!intc.domain)
>  		panic("%pOF: unable to create IRQ domain\n", node);
>  
> -	bcm2836_arm_irqchip_smp_init();
> +	if (smp_init)
> +		bcm2836_arm_irqchip_smp_init();

Instead of the additional parameter and this check, why don't you just
move the smp_init() call to bcm2836_arm_irqchip_l1_intc_of_init()
instead?

>  
>  	set_handle_irq(bcm2836_arm_irqchip_handle_irq);
> +
>  	return 0;
>  }
>  
> +static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
> +						      struct device_node *parent)
> +{
> +	return arm_irqchip_l1_intc_of_init_smp(node, parent, true);
> +}
> +
> +static int __init bcm7211_arm_irqchip_l1_intc_of_init(struct device_node *node,
> +						      struct device_node *parent)
> +{
> +	return arm_irqchip_l1_intc_of_init_smp(node, parent, false);
> +}
> +
>  IRQCHIP_DECLARE(bcm2836_arm_irqchip_l1_intc, "brcm,bcm2836-l1-intc",
>  		bcm2836_arm_irqchip_l1_intc_of_init);
> +IRQCHIP_DECLARE(bcm7211_arm_irqchip_l1_intc, "brcm,bcm7211-l1-intc",
> +		bcm7211_arm_irqchip_l1_intc_of_init);


Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

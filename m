Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C5DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F348721850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574164899;
	bh=ffNGLXkbW3mcKW74/EXH75Yti1N+eJErtq28gP5l22A=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=fUMtQ1vZmVlgsVJOmRegBaCXKH0UMjSa91aLnfN6K+henSlvo0zNyDE0G4f8Mp0yJ
	 QFrCl2jon1rDJJMLuevkXYlKVkpXNU+XUqXff3T5TctkLn7tIYBorL06vcU3EDuYbc
	 OPGAJM9IojURxQlYCVqbIdb86d14t6d3IV0oxYpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKSMBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:01:37 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:59053 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbfKSMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:01:37 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iX2CM-00036B-9b; Tue, 19 Nov 2019 13:01:34 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 19 Nov 2019 12:01:33 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <20191119021917.15917-3-afaerber@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
 <20191119021917.15917-3-afaerber@suse.de>
Message-ID: <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
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

On 2019-11-19 02:19, Andreas Färber wrote:
> This irq mux driver implements the RTD1295 SoC's non-linear mapping
> between status and enable bits.
>
> Based in part on QNAP's arch/arm/mach-rtk119x/rtk_irq_mux.c and
> Synology's drivers/irqchip/irq-rtk.c code.
>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Cc: Aleix Roca Nonell <kernelrocks@gmail.com>
> Signed-off-by: James Tai <james.tai@realtek.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v3 -> v4:
>  * Drop no-op .irq_set_affinity callback (Thomas)
>  * Clear all interrupts (James)
>  * Updated SPDX-License-identifier
>  * Use tabular formatting (Thomas)
>  * Adopt different braces style (Thomas)
>  * Use raw_spinlock_t (Thomas)
>  * Shortened callback from isr_to_scpu_int_en_mask to
> isr_to_int_en_mask (Thomas)
>  * Fixed of_iomap() error handling to not use IS_ERR()
>  * Don't mask unmapped NMIs by checking for a non-zero mask
>  * Cache SCPU_INT_EN to avoid superfluous reads (Thomas)
>  * Renamed functions and variables from rtd119x to rtd1195
>
>  v2 -> v3:
>  * Adopted spin_lock_irq{save,restore}() (Marc)
>  * Adopted single-write masking (Marc)
>  * Adopted misc compatible string
>  * Introduced explicit bit mapping
>  * Adopted looped processing of pending interrupts (Marc)
>  * Replaced unmask implementation with UMSK_ISR write
>  * Introduced enable/disable ops and dropped no longer needed UART0 
> quirk
>
>  v1 -> v2:
>  * Renamed struct fields to avoid ambiguity (Marc)
>  * Refactored offset lookup to avoid per-compatible init functions
>  * Inserted white lines to clarify balanced locking (Marc)
>  * Dropped forwarding of set_affinity to GIC (Marc)
>  * Added spinlocks for consistency (Marc)
>  * Limited initialization quirk to iso mux
>  * Fixed spinlock initialization (Andrew)
>
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-rtd1195-mux.c | 283
> ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 284 insertions(+)
>  create mode 100644 drivers/irqchip/irq-rtd1195-mux.c
>
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e806dda690ea..d678881eebc8 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -104,3 +104,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>  obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>  obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
> +obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd1195-mux.o
> diff --git a/drivers/irqchip/irq-rtd1195-mux.c
> b/drivers/irqchip/irq-rtd1195-mux.c
> new file mode 100644
> index 000000000000..e6b08438b23c
> --- /dev/null
> +++ b/drivers/irqchip/irq-rtd1195-mux.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Realtek RTD1295 IRQ mux
> + *
> + * Copyright (c) 2017-2019 Andreas Färber
> + */
> +
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +
> +struct rtd1195_irq_mux_info {
> +	unsigned int	isr_offset;
> +	unsigned int	umsk_isr_offset;
> +	unsigned int	scpu_int_en_offset;
> +	const u32	*isr_to_int_en_mask;
> +};
> +
> +struct rtd1195_irq_mux_data {
> +	void __iomem				*reg_isr;
> +	void __iomem				*reg_umsk_isr;
> +	void __iomem				*reg_scpu_int_en;
> +	const struct rtd1195_irq_mux_info	*info;
> +	int					irq;
> +	u32					scpu_int_en;
> +	struct irq_domain			*domain;
> +	raw_spinlock_t				lock;
> +};
> +
> +static void rtd1195_mux_irq_handle(struct irq_desc *desc)
> +{
> +	struct rtd1195_irq_mux_data *data = 
> irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	u32 isr, mask;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	isr = readl_relaxed(data->reg_isr);
> +
> +	while (isr) {
> +		i = __ffs(isr);
> +		isr &= ~BIT(i);
> +
> +		mask = data->info->isr_to_int_en_mask[i];
> +		if (mask && !(data->scpu_int_en & mask))
> +			continue;
> +
> +		if (!generic_handle_irq(irq_find_mapping(data->domain, i)))
> +			writel_relaxed(BIT(i), data->reg_isr);

What does this write do exactly? It is the same thing as a 'mask',
which is pretty odd. So either:

- this is not doing anything and your 'mask' callback is bogus
   (otherwise you'd never have more than a single interrupt)

- or this is an ACK operation, and this should be described as
   such (and then fix the mask/unmask/enable/disable mess that
   results from it).

as I can't see how the same register can be used for both purposes.
You should be able to verify this experimentally, even without
documentation.

> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void rtd1195_mux_mask_irq(struct irq_data *data)
> +{
> +	struct rtd1195_irq_mux_data *mux_data = 
> irq_data_get_irq_chip_data(data);
> +
> +	writel_relaxed(BIT(data->hwirq), mux_data->reg_isr);
> +}
> +
> +static void rtd1195_mux_unmask_irq(struct irq_data *data)
> +{
> +	struct rtd1195_irq_mux_data *mux_data = 
> irq_data_get_irq_chip_data(data);
> +
> +	writel_relaxed(BIT(data->hwirq), mux_data->reg_umsk_isr);
> +}
> +
> +static void rtd1195_mux_enable_irq(struct irq_data *data)
> +{
> +	struct rtd1195_irq_mux_data *mux_data = 
> irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +
> +	mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
> +	if (!mask)
> +		return;

How can this happen? You've mapped the interrupt, so it exists.
I can't see how you can decide to fail such enable.

> +
> +	raw_spin_lock_irqsave(&mux_data->lock, flags);
> +
> +	mux_data->scpu_int_en |= mask;
> +	writel_relaxed(mux_data->scpu_int_en, mux_data->reg_scpu_int_en);
> +
> +	raw_spin_unlock_irqrestore(&mux_data->lock, flags);
> +}
> +
> +static void rtd1195_mux_disable_irq(struct irq_data *data)
> +{
> +	struct rtd1195_irq_mux_data *mux_data = 
> irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +
> +	mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
> +	if (!mask)
> +		return;
> +
> +	raw_spin_lock_irqsave(&mux_data->lock, flags);
> +
> +	mux_data->scpu_int_en &= ~mask;
> +	writel_relaxed(mux_data->scpu_int_en, mux_data->reg_scpu_int_en);
> +
> +	raw_spin_unlock_irqrestore(&mux_data->lock, flags);
> +}
> +
> +static struct irq_chip rtd1195_mux_irq_chip = {
> +	.name		= "rtd1195-mux",
> +	.irq_mask	= rtd1195_mux_mask_irq,
> +	.irq_unmask	= rtd1195_mux_unmask_irq,
> +	.irq_enable	= rtd1195_mux_enable_irq,
> +	.irq_disable	= rtd1195_mux_disable_irq,
> +};

[...]

Although the code is pretty clean, the way you drive the HW looks
suspicious, and requires clarification.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

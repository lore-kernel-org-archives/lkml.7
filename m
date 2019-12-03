Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD94C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0390D206ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mxMEGJzM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TyTYzBCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfLCBrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:47:31 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60373 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfLCBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:47:31 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B8CFB21FF1;
        Mon,  2 Dec 2019 20:47:29 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 02 Dec 2019 20:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=IHGr/2BLOU7cV4peRZ4d0rFJNkvQzoo
        KoZ+eB0IL/RU=; b=mxMEGJzMEEI/sC9g/aiksF+pPa+h10QnP4YNGvYeuAA638L
        McuJ+NnT9FhzSWt80xUeKdHd4PdRO+awfe/kRB6+o9RO7HUctYo5URSl+/ldkQQ3
        MrQhKY0YuuzNAhoruKLY9DfID4bF/mb8Y0jBQlm2BAZpCDCYIyaXESkeUk/iHxty
        ppnnE/yGf02XIqxSv0SK2NJeNedpZh6y1T0MyERp5Dso4FkzcNYuLGqUUZhRdJxy
        EKiQ6zgPu28F2OKyqqpj+S460FW7JwgAILtZrqc2Br6RmpFihLohV1+MAW3D3C8W
        syuQnDKBd79eziUFZ4UnHBpRcf2sNFUIgxpt7yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IHGr/2
        BLOU7cV4peRZ4d0rFJNkvQzooKoZ+eB0IL/RU=; b=TyTYzBCOD7yr5+hThshzrb
        XVBePF1pSkPdmYAzPw3Wr2HhdQ0sy+a8QgdOvHtkHZRSaA4/+C2FBjy6+lBNMMUe
        wFV+pe0P6esB3s8CCIBUUXW/HbPQ8DUhZqTlM9ed9gYrrFLmy5Kvq1Z1aBwx9ncw
        tJ5RcjEgUoYHSw4Rk+4jbs5zpiGsu4ZudT8b2dTw5p6vwjGap8Y0kpAsro+WTGeV
        byn9+p3p3FeknZ2im9gpp4qrmMcgnvj77+IWm4VX13XYKisCu5pj58eszpUfx8k5
        WEZ/zYA1MjuX5XbOgejTvJnGx+wBbxcU/wk331Lh+75vBX7Dh4dNW8dbGirXs9uw
        ==
X-ME-Sender: <xms:sL7lXclCiCQ3Nu6pSpK8scdCncKEJqzP0rmexNk7LcLXA9sqrYIziQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:sL7lXTlII7QDy8NaC_DgBwbg7ld_ydSbKnfFc9wcc06fzuZ4B6bcXw>
    <xmx:sL7lXfpliL-tA1-4oKEa3fktmYiM4deaUeutI8fDVdIaBwRpmW8eGA>
    <xmx:sL7lXQnC_uiT_I0C-0JYP_2gC7gUyC0--B_GSz5FUxLg6nMd2zWBkQ>
    <xmx:sb7lXY-H3I1aNtrlulqqNrNxq6PQgve3yfvMOPG23qQuna_yy_jxXg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 335EBE00A2; Mon,  2 Dec 2019 20:47:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-611-g2f3e951-fmstable-20191202v1
Mime-Version: 1.0
Message-Id: <0ddad614-0f1c-4ca1-bfc5-127ed3c61dc4@www.fastmail.com>
In-Reply-To: <1569617929-29055-3-git-send-email-eajames@linux.ibm.com>
References: <1569617929-29055-1-git-send-email-eajames@linux.ibm.com>
 <1569617929-29055-3-git-send-email-eajames@linux.ibm.com>
Date:   Tue, 03 Dec 2019 12:19:02 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        "Joel Stanley" <joel@jms.id.au>, mark.rutland@arm.com,
        "Rob Herring" <robh+dt@kernel.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Jason Cooper" <jason@lakedaemon.net>, tglx@linutronix.de
Subject: Re: [PATCH v2 2/4] irqchip: Add Aspeed SCU interrupt controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Sep 2019, at 06:28, Eddie James wrote:
> The Aspeed SOCs provide some interrupts through the System Control
> Unit registers. Add an interrupt controller that provides these
> interrupts to the system.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - add a spinlock to protect read-modify-write operation for irq masking
>  - use readl/writel relaxed versions

What's your motivation? I might have missed some comments on v1. The
descriptions make me slightly nervous (not guaranteed to be ordered wrt
spinlocks).

>  - add a comment explaining the irq status/enable register
>  - provide affinity callback that returns -EINVAL
> 
>  MAINTAINERS                         |   1 +
>  drivers/irqchip/Makefile            |   2 +-
>  drivers/irqchip/irq-aspeed-scu-ic.c | 233 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7e028c..b6db122 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2656,6 +2656,7 @@ M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Maintained
>  
> F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
> +F:	drivers/irqchip/irq-aspeed-scu-ic.c
>  F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
>  
>  ASPEED VIDEO ENGINE DRIVER
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index cc7c439..fce6b1d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -86,7 +86,7 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>  obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
> -obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> +obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o 
> irq-aspeed-scu-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c 
> b/drivers/irqchip/irq-aspeed-scu-ic.c
> new file mode 100644
> index 0000000..64c3ac4
> --- /dev/null
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
> + * Copyright 2019 IBM Corporation
> + *
> + * Eddie James <eajames@linux.ibm.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +
> +#define ASPEED_SCU_IC_SHIFT		0
> +#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
> +#define ASPEED_SCU_IC_NUM_IRQS		7
> +#define ASPEED_SCU_IC_STATUS_SHIFT	16
> +
> +#define ASPEED_AST2600_SCU_IC0_SHIFT	0
> +#define ASPEED_AST2600_SCU_IC0_ENABLE	\
> +	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
> +#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
> +
> +#define ASPEED_AST2600_SCU_IC1_SHIFT	4
> +#define ASPEED_AST2600_SCU_IC1_ENABLE	\
> +	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
> +#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
> +
> +struct aspeed_scu_ic {
> +	unsigned long irq_enable;
> +	unsigned long irq_shift;

> +	unsigned int num_irqs;
> +	void __iomem *reg;
> +	struct irq_domain *irq_domain;
> +	spinlock_t lock;
> +};
> +
> +static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
> +{
> +	unsigned int irq;
> +	unsigned long bit;
> +	unsigned long enabled;
> +	unsigned long max;
> +	unsigned long status;
> +	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	chained_irq_enter(chip, desc);
> +
> +	/*
> +	 * The SCU IC has just one register to control its operation and read
> +	 * status. The interrupt enable bits occupy the lower 16 bits of the
> +	 * register, while the interrupt status bits occupy the upper 16 bits.
> +	 * The status bit for a given interrupt is always 16 bits shifted from
> +	 * the enable bit for the same interrupt.
> +	 * Therefore, perform the IRQ operations in the enable bit space by
> +	 * shifting the status down to get the mapping and then back up to
> +	 * clear the bit.
> +	 */
> +	status = readl_relaxed(scu_ic->reg);
> +	enabled = status & scu_ic->irq_enable;
> +	status = (status >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> +
> +	bit = scu_ic->irq_shift;
> +	max = scu_ic->num_irqs + bit;
> +
> +	for_each_set_bit_from(bit, &status, max) {
> +		irq = irq_find_mapping(scu_ic->irq_domain,
> +				       bit - scu_ic->irq_shift);
> +		generic_handle_irq(irq);
> +
> +		writel_relaxed(enabled | BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT),
> +			       scu_ic->reg);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void aspeed_scu_ic_irq_mask(struct irq_data *data)
> +{
> +	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
> +	unsigned long bit = BIT(data->hwirq + scu_ic->irq_shift);
> +	unsigned long flags;
> +	unsigned long reg;
> +
> +	spin_lock_irqsave(&scu_ic->lock, flags);

The SCU is represented by a syscon in the devicetree, which has a regmap,
which does it's own locking internally. You could use regmap_update_bits()
to do an atomic read/modify/write and this will provide consistency for
other SCU drivers that might be accessing shared registers. Nothing else
should _currently_ be touching the SCU IRQ status/enable register, but
using the regmap would give us a consistent approach across all SCU
drivers.

Andrew

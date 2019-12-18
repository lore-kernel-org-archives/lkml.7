Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E50C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825324650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576661879;
	bh=nCXCKDDoSamGpgoq3jT6RNA6dS1EovruR1AiTxY8nFM=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=BMSetPZopCu/3IftvFYpHJrC4RMOjWkFxrnDNXNDqwoqzlgjcdgMSxvyzydjij/Lq
	 F0Gs+lV1lun6wYhzQfWOb+/Wm73THCj5ifYKXw5EhHKD+QGCXfCQMhy8KT7j0/Jqfu
	 RsZWWyCihJubyJfFrlRl73MS5Av+kkgw3IrMlNhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLRJh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:37:58 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:35075 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbfLRJh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:37:57 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihVm7-0004Bw-I2; Wed, 18 Dec 2019 10:37:47 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 2/3] drivers/irqchip: add NXP INTMUX interrupt  multiplexer support
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 09:37:47 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <shengjiu.wang@nxp.com>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <fugang.duan@nxp.com>,
        <aisheng.dong@nxp.com>
In-Reply-To: <1576653615-27954-3-git-send-email-qiangqing.zhang@nxp.com>
References: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576653615-27954-3-git-send-email-qiangqing.zhang@nxp.com>
Message-ID: <b0288de8faab127a096d1e78113ec4cb@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, shengjiu.wang@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fugang.duan@nxp.com, aisheng.dong@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 07:20, Joakim Zhang wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The intmux module is used to output internal interrupt in subsystem
> to system with 32-to-8 configuration. It has several multiplex
> channels depends on system.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/irqchip/irq-imx-intmux.c | 220 
> +++++++++++++++++++++++++++++++
>  1 file changed, 220 insertions(+)
>  create mode 100644 drivers/irqchip/irq-imx-intmux.c
>
> diff --git a/drivers/irqchip/irq-imx-intmux.c
> b/drivers/irqchip/irq-imx-intmux.c
> new file mode 100644
> index 000000000000..fa24b968f30b
> --- /dev/null
> +++ b/drivers/irqchip/irq-imx-intmux.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2017 NXP
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/spinlock.h>
> +
> +#define CHANCSR(n)	(0x0 + 0x40 * n)
> +#define CHANVEC(n)	(0x4 + 0x40 * n)

These two macros are unused.

> +#define CHANIER(n)	(0x10 + (0x40 * n))
> +#define CHANIPR(n)	(0x20 + (0x40 * n))
> +
> +struct intmux_irqchip_data {
> +	int chanidx;
> +	int irq;
> +	struct irq_domain *domain;
> +	unsigned int irqstat;

It would make things a bit readable if you aligned the various fields:

struct intmux_irqchip_data {
         int                  chanidx;
         int                  irq;
         struct irq_domain    *domain;
[...]
};

> +};
> +
> +struct intmux_data {
> +	spinlock_t lock;
> +	struct platform_device *pdev;
> +	void __iomem *regs;
> +	struct clk *ipg_clk;
> +	int channum;
> +	struct intmux_irqchip_data irqchip_data[];
> +};
> +
> +static void imx_intmux_irq_mask(struct irq_data *d)
> +{
> +	struct intmux_irqchip_data *irqchip_data = d->chip_data;
> +	u32 idx = irqchip_data->chanidx;
> +	struct intmux_data *intmux_data = container_of(irqchip_data,
> +				struct intmux_data, irqchip_data[idx]);
> +	void __iomem *reg;
> +	u32 val;
> +
> +	spin_lock(&intmux_data->lock);

This is racy. you could take an interrupt while executing 
disable_irq(),
which calls this. In turn, the interrupt handler will try to acquire 
this
lock -> deadlock.

Please turn this into its _irqsave version.

> +	reg = intmux_data->regs + CHANIER(idx);
> +	val = readl_relaxed(reg);
> +	/* disable the interrupt source of this channel */
> +	val &= ~(1 << d->hwirq);

         val &= ~BIT(d->hwirq);

> +	writel_relaxed(val, reg);
> +	spin_unlock(&intmux_data->lock);
> +}
> +
> +static void imx_intmux_irq_unmask(struct irq_data *d)
> +{
> +	struct intmux_irqchip_data *irqchip_data = d->chip_data;
> +	u32 idx = irqchip_data->chanidx;
> +	struct intmux_data *intmux_data = container_of(irqchip_data,
> +				struct intmux_data, irqchip_data[idx]);
> +	void __iomem *reg;
> +	u32 val;
> +
> +	spin_lock(&intmux_data->lock);
> +	reg = intmux_data->regs + CHANIER(idx);
> +	val = readl_relaxed(reg);
> +	/* enable the interrupt source of this channel */
> +	val |= 1 << d->hwirq;
> +	writel_relaxed(val, reg);
> +	spin_unlock(&intmux_data->lock);
> +}
> +
> +static struct irq_chip imx_intmux_irq_chip = {
> +	.name		= "intmux",
> +	.irq_mask	= imx_intmux_irq_mask,
> +	.irq_unmask	= imx_intmux_irq_unmask,
> +};
> +
> +static int imx_intmux_irq_map(struct irq_domain *h, unsigned int 
> irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +	irq_set_chip_data(irq, h->host_data);
> +	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, 
> handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops imx_intmux_domain_ops = {
> +	.map		= imx_intmux_irq_map,
> +	.xlate		= irq_domain_xlate_onecell,
> +};
> +
> +static void imx_intmux_update_irqstat(struct intmux_irqchip_data
> *irqchip_data)
> +{
> +	int i = irqchip_data->chanidx;
> +	struct intmux_data *intmux_data = container_of(irqchip_data,
> +				struct intmux_data, irqchip_data[i]);
> +
> +	/* read the interrupt source pending status of this channel */
> +	irqchip_data->irqstat = readl_relaxed(intmux_data->regs + 
> CHANIPR(i));

Why does it need to be stored into the data structure, instead of
sinply being returned by the function?

> +}
> +
> +static void imx_intmux_irq_handler(struct irq_desc *desc)
> +{
> +	struct intmux_irqchip_data *irqchip_data = 
> irq_desc_get_handler_data(desc);
> +	int pos, virq;
> +
> +	chained_irq_enter(irq_desc_get_chip(desc), desc);
> +
> +	imx_intmux_update_irqstat(irqchip_data);
> +
> +	for_each_set_bit(pos, (unsigned long *)&irqchip_data->irqstat, 32) 
> {

This is broken on big-endian. Never cast a smaller type into unsigned 
long
if you're going to use any of the bit iterators.

> +		virq = irq_find_mapping(irqchip_data->domain, pos);
> +		if (virq)
> +			generic_handle_irq(virq);
> +	}
> +
> +	chained_irq_exit(irq_desc_get_chip(desc), desc);
> +}
> +
> +static int imx_intmux_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct intmux_data *intmux_data;
> +	int channum;
> +	int i, ret;
> +
> +	ret = of_property_read_u32(np, "fsl,intmux_chans", &channum);
> +	if (ret)
> +		channum = 1;
> +
> +	intmux_data = devm_kzalloc(&pdev->dev, sizeof(*intmux_data) +
> +				   channum * sizeof(intmux_data->irqchip_data[0]),
> +				   GFP_KERNEL);
> +	if (!intmux_data)
> +		return -ENOMEM;
> +
> +	intmux_data->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(intmux_data->regs)) {
> +		dev_err(&pdev->dev, "failed to initialize reg\n");
> +		return PTR_ERR(intmux_data->regs);
> +	}
> +
> +	intmux_data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(intmux_data->ipg_clk)) {
> +		ret = PTR_ERR(intmux_data->ipg_clk);
> +		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	intmux_data->channum = channum;
> +	intmux_data->pdev = pdev;

What is the point of keeping track of this? The only instance where you
go from MUX to device is just below, and you already have the device
at hand.

> +	spin_lock_init(&intmux_data->lock);
> +
> +	ret = clk_prepare_enable(intmux_data->ipg_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < channum; i++) {
> +		intmux_data->irqchip_data[i].chanidx = i;
> +		intmux_data->irqchip_data[i].irq = platform_get_irq(pdev, i);
> +		if (intmux_data->irqchip_data[i].irq <= 0) {
> +			dev_err(&pdev->dev, "failed to get irq\n");
> +			return -ENODEV;
> +		}
> +
> +		intmux_data->irqchip_data[i].domain = irq_domain_add_linear(
> +						np,
> +						32,
> +						&imx_intmux_domain_ops,
> +						&intmux_data->irqchip_data[i]);

Please indent this in a readable manner. If you need an intermediate 
variable,
so be it. Or have a long line if you want, but don't write things like 
this.

> +		if (!intmux_data->irqchip_data[i].domain) {
> +			dev_err(&intmux_data->pdev->dev,
> +				"failed to create IRQ domain\n");
> +			return -ENOMEM;
> +		}
> +
> +		irq_set_chained_handler_and_data(intmux_data->irqchip_data[i].irq,
> +						 imx_intmux_irq_handler,
> +						 &intmux_data->irqchip_data[i]);

Shouldn't you initialize the HW to some sane state here? Like having
having all interrupts masked?

> +	}
> +
> +	platform_set_drvdata(pdev, intmux_data);
> +
> +	return 0;
> +}
> +
> +static int imx_intmux_remove(struct platform_device *pdev)
> +{
> +	struct intmux_data *intmux_data = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < intmux_data->channum; i++) {
> +		irq_set_chained_handler_and_data(intmux_data->irqchip_data[i].irq,
> +						 NULL, NULL);

Same thing here. Shouldn't you make sure that no interrupt can fire 
anymore?

> +
> +		irq_domain_remove(intmux_data->irqchip_data[i].domain);
> +	}
> +
> +	platform_set_drvdata(pdev, NULL);
> +	clk_disable_unprepare(intmux_data->ipg_clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_intmux_id[] = {
> +	{ .compatible = "fsl,imx-intmux", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver imx_intmux_driver = {
> +	.driver = {
> +		.name = "imx-intmux",
> +		.of_match_table = imx_intmux_id,
> +	},
> +	.probe = imx_intmux_probe,
> +	.remove = imx_intmux_remove,
> +};
> +builtin_platform_driver(imx_intmux_driver);

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

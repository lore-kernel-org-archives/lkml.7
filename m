Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0701920661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgAIQKT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:10:19 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:39659 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbgAIQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:10:17 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3A6C620017;
        Thu,  9 Jan 2020 16:10:15 +0000 (UTC)
Date:   Thu, 9 Jan 2020 17:10:14 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] mtd: rawnand: brcmnand: Add support for flash-edu
 for dma transfers
Message-ID: <20200109171014.527e6d5d@xps13>
In-Reply-To: <20191120182153.29732-3-kdasu.kdev@gmail.com>
References: <20191120182153.29732-1-kdasu.kdev@gmail.com>
        <20191120182153.29732-3-kdasu.kdev@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Wed, 20 Nov 2019 13:20:59
-0500:

> Legacy mips soc platforms that have controller v5.0 and 6.0 use
> flash-edu block for dma transfers. This change adds support for
> nand dma transfers using the EDU block.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

I don't have the patch 2/3 in my mailbox :-/ Can you please resend with
the right numbering or Cc myself on the 2nd?

Otherwise, minor comments below :)

> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 269 ++++++++++++++++++++++-
>  1 file changed, 263 insertions(+), 6 deletions(-)

[...]

> +/* edu irq */
> +static irqreturn_t brcmnand_edu_irq(int irq, void *data)
> +{
> +	struct brcmnand_controller *ctrl = data;
> +
> +	if (ctrl->edu_count) {
> +		ctrl->edu_count--;
> +		while (!edu_readl(ctrl, EDU_DONE))
> +			udelay(1);
> +		edu_writel(ctrl, EDU_DONE, 0);
> +		(void)edu_readl(ctrl, EDU_DONE);

Why this cast? (and all the others)

> +	}
> +
> +	if (ctrl->edu_count) {
> +		ctrl->edu_dram_addr += FC_BYTES;
> +		ctrl->edu_ext_addr += FC_BYTES;
> +
> +		edu_writel(ctrl, EDU_DRAM_ADDR, (u32)ctrl->edu_dram_addr);
> +		(void)edu_readl(ctrl, EDU_DRAM_ADDR);
> +		edu_writel(ctrl, EDU_EXT_ADDR, ctrl->edu_ext_addr);
> +		(void)edu_readl(ctrl, EDU_EXT_ADDR);

[...]

>  
> @@ -2561,6 +2767,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
>  
>  	init_completion(&ctrl->done);
>  	init_completion(&ctrl->dma_done);
> +	init_completion(&ctrl->edu_done);
>  	nand_controller_init(&ctrl->controller);
>  	ctrl->controller.ops = &brcmnand_controller_ops;
>  	INIT_LIST_HEAD(&ctrl->host_list);
> @@ -2650,6 +2857,56 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
>  		dev_info(dev, "enabling FLASH_DMA\n");
>  	}
>  
> +	/* use EDU DMA only no FLASH_DMA present */
> +	if (has_flash_dma(ctrl))
> +		res = 0;
> +	else
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "flash-edu");

Can we simplify this block?

> +
> +	if (res) {

What about a dedicated helper to do the EDU configuration only?

> +		ctrl->edu_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(ctrl->edu_base))
> +			return PTR_ERR(ctrl->edu_base);
> +
> +		ctrl->edu_offsets = edu_regs;
> +
> +		edu_writel(ctrl, EDU_CONFIG, EDU_CONFIG_MODE_NAND |
> +			   EDU_CONFIG_SWAP_CFG);
> +		(void)edu_readl(ctrl, EDU_CONFIG);
> +
> +		/* initialize edu */
> +		edu_writel(ctrl, EDU_ERR_STATUS, 0);
> +		edu_writel(ctrl, EDU_DONE, 0);
> +		(void)edu_readl(ctrl, EDU_DONE);
> +
> +		ctrl->edu_irq = platform_get_irq(pdev, 1);
> +		if ((int)ctrl->edu_irq < 0) {
> +			dev_warn(dev,
> +				 "FLASH EDU enabled, using ctlrdy irq\n");
> +		} else {
> +			ret = devm_request_irq(dev, ctrl->edu_irq,
> +					       brcmnand_edu_irq, 0,
> +					       "brcmnand-edu", ctrl);
> +			if (ret < 0) {
> +				dev_err(dev, "can't allocate IRQ %d: error %d\n",
> +					ctrl->edu_irq, ret);
> +				return ret;
> +			}
> +
> +			dev_info(dev, "FLASH EDU enabled using irq %u\n",
> +				 ctrl->edu_irq);
> +		}
> +	}
> +
> +	/* set the appropriate dma transfer function to call */
> +	if (has_flash_dma(ctrl))
> +		ctrl->dma_trans = brcmnand_dma_trans;
> +	else if (has_edu(ctrl))
> +		ctrl->dma_trans = brcmnand_edu_trans;
> +	else
> +		ctrl->dma_trans = NULL;
> +
>  	/* Disable automatic device ID config, direct addressing */
>  	brcmnand_rmw_reg(ctrl, BRCMNAND_CS_SELECT,
>  			 CS_SELECT_AUTO_DEVICE_ID_CFG | 0xff, 0, 0);

Thanks,
Miquèl

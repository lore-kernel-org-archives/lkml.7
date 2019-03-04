Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA922C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9040F20449
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCDKeR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:34:17 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:53751 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDKeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:34:16 -0500
Received: from xps13 (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 29E4224000C;
        Mon,  4 Mar 2019 10:34:12 +0000 (UTC)
Date:   Mon, 4 Mar 2019 11:34:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] mtd: rawnand: ingenic: Add support for the
 JZ4740
Message-ID: <20190304113412.24b64e3d@xps13>
In-Reply-To: <20190209192305.4434-7-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-7-paul@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Sat,  9 Feb 2019 16:23:03
-0300:

> Add support for probing the ingenic-nand driver on the JZ4740 SoC from
> Ingenic, and the jz4740-ecc driver to support the JZ4740-specific
> ECC hardware.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: New patch
> 
> v3: Also add support for the hardware ECC of the JZ4740 in this patch
> 
> v4: - Fix formatting issues
>     - Add MODULE_* macros
> 
>  drivers/mtd/nand/raw/ingenic/Kconfig        |  10 ++
>  drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
>  drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 +++++--
>  drivers/mtd/nand/raw/ingenic/jz4740_ecc.c   | 196 ++++++++++++++++++++++++++++
>  4 files changed, 244 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c
> 

[...]

>  	switch (chip->ecc.mode) {
>  	case NAND_ECC_HW:
> @@ -270,8 +279,8 @@ static int ingenic_nand_init_chip(struct platform_device *pdev,
>  		return -ENOMEM;
>  	mtd->dev.parent = dev;
>  
> -	chip->legacy.IO_ADDR_R = cs->base + OFFSET_DATA;
> -	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
> +	chip->legacy.IO_ADDR_R = cs->base + nfc->soc_info->data_offset;
> +	chip->legacy.IO_ADDR_W = cs->base + nfc->soc_info->data_offset;
>  	chip->legacy.chip_delay = RB_DELAY_US;
>  	chip->options = NAND_NO_SUBPAGE_WRITE;
>  	chip->legacy.select_chip = ingenic_nand_select_chip;

I think Boris already asked for it, but it would be really great that
you update this driver to not use any legacy interface anymore.

> diff --git a/drivers/mtd/nand/raw/ingenic/jz4740_ecc.c b/drivers/mtd/nand/raw/ingenic/jz4740_ecc.c
> new file mode 100644
> index 000000000000..83b42881720e
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/ingenic/jz4740_ecc.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ4740 ECC controller driver
> + *
> + * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
> + *
> + * based on jz4740-nand.c
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include "ingenic_ecc.h"
> +
> +#define JZ_REG_NAND_ECC_CTRL	0x00
> +#define JZ_REG_NAND_DATA	0x04
> +#define JZ_REG_NAND_PAR0	0x08
> +#define JZ_REG_NAND_PAR1	0x0C
> +#define JZ_REG_NAND_PAR2	0x10
> +#define JZ_REG_NAND_IRQ_STAT	0x14
> +#define JZ_REG_NAND_IRQ_CTRL	0x18
> +#define JZ_REG_NAND_ERR(x)	(0x1C + ((x) << 2))
> +
> +#define JZ_NAND_ECC_CTRL_PAR_READY	BIT(4)
> +#define JZ_NAND_ECC_CTRL_ENCODING	BIT(3)
> +#define JZ_NAND_ECC_CTRL_RS		BIT(2)
> +#define JZ_NAND_ECC_CTRL_RESET		BIT(1)
> +#define JZ_NAND_ECC_CTRL_ENABLE		BIT(0)
> +
> +#define JZ_NAND_STATUS_ERR_COUNT	(BIT(31) | BIT(30) | BIT(29))
> +#define JZ_NAND_STATUS_PAD_FINISH	BIT(4)
> +#define JZ_NAND_STATUS_DEC_FINISH	BIT(3)
> +#define JZ_NAND_STATUS_ENC_FINISH	BIT(2)
> +#define JZ_NAND_STATUS_UNCOR_ERROR	BIT(1)
> +#define JZ_NAND_STATUS_ERROR		BIT(0)
> +
> +static const uint8_t empty_block_ecc[] = {
> +	0xcd, 0x9d, 0x90, 0x58, 0xf4, 0x8b, 0xff, 0xb7, 0x6f
> +};
> +
> +static void jz4740_ecc_init(struct ingenic_ecc *ecc, bool encode)
> +{
> +	uint32_t reg;
> +
> +	/* Clear interrupt status */
> +	writel(0, ecc->base + JZ_REG_NAND_IRQ_STAT);
> +
> +	/* Initialize and enable ECC hardware */
> +	reg = readl(ecc->base + JZ_REG_NAND_ECC_CTRL);
> +	reg |= JZ_NAND_ECC_CTRL_RESET;
> +	reg |= JZ_NAND_ECC_CTRL_ENABLE;
> +	reg |= JZ_NAND_ECC_CTRL_RS;
> +	if (encode)
> +		reg |= JZ_NAND_ECC_CTRL_ENCODING;
> +	else
> +		reg &= ~JZ_NAND_ECC_CTRL_ENCODING;
> +
> +	writel(reg, ecc->base + JZ_REG_NAND_ECC_CTRL);
> +}
> +
> +static int jz4740_ecc_calculate(struct ingenic_ecc *ecc,
> +				struct ingenic_ecc_params *params,
> +				const u8 *buf, u8 *ecc_code)
> +{
> +	uint32_t reg, status;
> +	unsigned int timeout = 1000;
> +	int i;
> +
> +	jz4740_ecc_init(ecc, true);
> +
> +	do {
> +		status = readl(ecc->base + JZ_REG_NAND_IRQ_STAT);
> +	} while (!(status & JZ_NAND_STATUS_ENC_FINISH) && --timeout);
> +
> +	if (timeout == 0)
> +		return -ETIMEDOUT;
> +
> +	reg = readl(ecc->base + JZ_REG_NAND_ECC_CTRL);
> +	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
> +	writel(reg, ecc->base + JZ_REG_NAND_ECC_CTRL);
> +
> +	for (i = 0; i < params->bytes; ++i)
> +		ecc_code[i] = readb(ecc->base + JZ_REG_NAND_PAR0 + i);
> +
> +	/* If the written data is completely 0xff, we also want to write 0xff as
> +	 * ecc, otherwise we will get in trouble when doing subpage writes.
> +	 */

Comment formatting

s/ecc/ECC/ in plain English

> +	if (memcmp(ecc_code, empty_block_ecc, ARRAY_SIZE(empty_block_ecc)) == 0)
> +		memset(ecc_code, 0xff, ARRAY_SIZE(empty_block_ecc));
> +
> +	return 0;
> +}
> +


Thanks,
Miquèl

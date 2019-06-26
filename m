Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AD2C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30174208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQwZlAxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFZG5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:57:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:57:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1283079wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IxGs5yGJ9HizqrPA2032h/5wS+iu4MhBjX9vNS7G3KM=;
        b=WQwZlAxSrBxBL3/OqDgQQAgzAjWbzjPXmwVBU7CLlyjHpBq3xr42iB3OfDJFQtvaEu
         NSVmczcGawRnnmRmrQZ/UqDewae3A87hJcUqGDWgn+cEs+oy+mIGNb/Xd/8L19a0oDtQ
         W7BqNstQ3jHodQ1vRIx9Ch7H3z76jWdW/eOK7M+GEP+dA0nhJq753DNwSmkHOLVSdh1/
         gA70c1BTkHyMdiKgcRvlOOiw+EHMhEDvftvC+9UWhDSeww2Bicd2hXA0/yDSYkYTOFwh
         C3+h7K96EWsZpDO125vA81xgDLI6571B0g9JA/z8gJ3oocpdaQhU43DnNLO3oVaLdsoe
         g2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IxGs5yGJ9HizqrPA2032h/5wS+iu4MhBjX9vNS7G3KM=;
        b=CenO+3kyI5/uHaDjQS39sWVKJyjsLMiIx1FGWxIteWujDHVAA4dsJN9zTViD0Kspho
         7T1vKe/TNiTHiXYT+QuHbHP+UAStff9QDKqB4SiETHJin3NK/FN4xWx65nFKnYfBxaTw
         fuPmWe1X8hLiZFpLAvxBiNMnf30L28y52G+aCxTpFY6T873eWLmfAdZyi2tYuLp+prpz
         HIpH0QQIx+L/rnV/wMdhJpf4bILwcMCkkEc/SUQ6ocGbRlSX4ovu1tCn8Kd7Io+HH2MT
         CsQxQBcqyQmosFk1HBMoVuAKy5LC0ScyCcT64aF/S3zyQ+pFSQI6CwJ59Y5SqFgDc01I
         6F8A==
X-Gm-Message-State: APjAAAX2rZgVrnr5yr6+YPML9uKRak+wcYaMmPiFA36JwWJAQ9pes2hD
        voedEetp+I+PHK4qoe9zovCknw==
X-Google-Smtp-Source: APXvYqxbeCPmtMknH2QUwUXiSLBWPLOkl8lBx6LnFDey6e2LRzuFw70IbI0FT5gOU5bMj1QYqKCy7w==
X-Received: by 2002:adf:e2cb:: with SMTP id d11mr2152341wrj.66.1561532221199;
        Tue, 25 Jun 2019 23:57:01 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id x11sm1033587wmg.23.2019.06.25.23.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 23:56:59 -0700 (PDT)
Date:   Wed, 26 Jun 2019 07:56:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 2/4] mfd: Add initial MFD driver for ATC260x PMICs
Message-ID: <20190626065657.GK21119@dell>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617155011.15376-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Manivannan Sadhasivam wrote:

> Add initial MFD driver for Actions Semi ATC260x PMICs. ATC260x series
> PMICs integrates Audio Codec, Power management, Clock generation, and GPIO
> controller blocks. This driver only supports Regulator functionality on
> ATC2609A PMIC variant for now.

Until you supply other functionality, this is not an MFD.

Please add additional support for more child devices.

> Since the PMICs can be accessed using both I2C and SPI busses, following
> driver structure has been adapted:
> 
>            ----->atc260x-core.c (Implements core funtionalities)
>           /
> ATC260x--------->atc260x-i2c.c (Implements I2C interface)
>           \
>            ----->atc2609a-helpers.c (Implements ATC2609A specific helpers)
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/mfd/Kconfig                       |  22 +++
>  drivers/mfd/Makefile                      |   7 +
>  drivers/mfd/atc2609a-helpers.c            |  91 +++++++++
>  drivers/mfd/atc260x-core.c                |  85 ++++++++
>  drivers/mfd/atc260x-i2c.c                 |  98 ++++++++++

Taking this set on it's own merits alone, I don't see a good reason to
split these up.  Please either supply the SPI interface within this
patch-set or amalgamate them into a single file.

>  drivers/mfd/atc260x.h                     |  22 +++
>  include/linux/mfd/atc260x/atc2609a_regs.h | 228 ++++++++++++++++++++++
>  include/linux/mfd/atc260x/core.h          |  64 ++++++
>  8 files changed, 617 insertions(+)
>  create mode 100644 drivers/mfd/atc2609a-helpers.c
>  create mode 100644 drivers/mfd/atc260x-core.c
>  create mode 100644 drivers/mfd/atc260x-i2c.c
>  create mode 100644 drivers/mfd/atc260x.h
>  create mode 100644 include/linux/mfd/atc260x/atc2609a_regs.h
>  create mode 100644 include/linux/mfd/atc260x/core.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index a17d275bf1d4..eb388505357b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1945,6 +1945,28 @@ config MFD_STMFX
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_ATC260X
> +	tristate "Actions Semi ATC260x PMICs"
> +	select MFD_CORE
> +	select REGMAP
> +	select REGMAP_IRQ
> +	help
> +	  Support for the Actions Semi ATC260x PMICs.
> +
> +config MFD_ATC260X_I2C
> +	tristate "Actions Semi ATC260x PMICs with I2C"
> +	depends on MFD_ATC260X
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Support for the Actions Semi ATC260x PMICs controlled via I2C.
> +
> +config MFD_ATC2609A
> +	bool "Actions Semi ATC2609A PMIC"
> +	depends on MFD_ATC260X
> +	help
> +	  Support for Actions Semi ATC2609A PMIC
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 52b1a90ff515..a87e7ed55a02 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -249,3 +249,10 @@ obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
>  obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> +
> +atc260x-objs			:= atc260x-core.o
> +ifeq ($(CONFIG_MFD_ATC2609A),y)
> +atc260x-objs			+= atc2609a-helpers.o
> +endif
> +obj-$(CONFIG_MFD_ATC260X)	+= atc260x.o
> +obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> diff --git a/drivers/mfd/atc2609a-helpers.c b/drivers/mfd/atc2609a-helpers.c
> new file mode 100644
> index 000000000000..6d304ea61552
> --- /dev/null
> +++ b/drivers/mfd/atc2609a-helpers.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Helper functions for ATC2609A PMIC
> + *
> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/mfd/atc260x/core.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "atc260x.h"
> +
> +const struct regmap_config atc2609a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = ATC2609A_SADDR,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +const struct regmap_irq atc2609a_irqs[] = {
> +	[ATC2609A_IRQ_AUDIO] = {
> +		.reg_offset = 0,
> +		.mask = BIT(0),
> +	},
> +	[ATC2609A_IRQ_OV] = {
> +		.reg_offset = 0,
> +		.mask = BIT(1),
> +	},
> +	[ATC2609A_IRQ_OC] = {
> +		.reg_offset = 0,
> +		.mask = BIT(2),
> +	},
> +	[ATC2609A_IRQ_OT] = {
> +		.reg_offset = 0,
> +		.mask = BIT(3),
> +	},
> +	[ATC2609A_IRQ_UV] = {
> +		.reg_offset = 0,
> +		.mask = BIT(4),
> +	},
> +	[ATC2609A_IRQ_ALARM] = {
> +		.reg_offset = 0,
> +		.mask = BIT(5),
> +	},
> +	[ATC2609A_IRQ_ONOFF] = {
> +		.reg_offset = 0,
> +		.mask = BIT(6),
> +	},
> +	[ATC2609A_IRQ_WKUP] = {
> +		.reg_offset = 0,
> +		.mask = BIT(7),
> +	},
> +	[ATC2609A_IRQ_IR] = {
> +		.reg_offset = 0,
> +		.mask = BIT(8),
> +	},
> +	[ATC2609A_IRQ_REMCON] = {
> +		.reg_offset = 0,
> +		.mask = BIT(9),
> +	},
> +	[ATC2609A_IRQ_POWER_IN] = {
> +		.reg_offset = 0,
> +		.mask = BIT(10),
> +	},
> +};

Please use REGMAP_IRQ_REG()

> +const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
> +	.name = "atc2609a",
> +	.irqs = atc2609a_irqs,
> +	.num_irqs = ARRAY_SIZE(atc2609a_irqs),
> +	.num_regs = 1,
> +	.status_base = ATC2609A_INTS_PD,
> +	.mask_base = ATC2609A_INTS_MSK,
> +	.mask_invert = true,
> +};
> +
> +int atc2609a_dev_init(struct atc260x *atc260x)
> +{
> +	/* Initialize interrupt block */
> +	atc260x_cmu_reset(atc260x, ATC2609A_CMU_DEVRST, ATC260X_CMU_INTS,
> +			  ATC260X_CMU_INTS);
> +
> +	/* Disable all interrupt sources */
> +	regmap_write(atc260x->regmap, ATC2609A_INTS_MSK, 0);
> +
> +	/* Enable EXTIRQ pad */
> +	return regmap_update_bits(atc260x->regmap, ATC2609A_PAD_EN,
> +				  BIT(0), BIT(0));
> +}

No need for this to be in a separate file.  We can support multiple
chips from a single source file.  Only split them out when the level
of complexity makes it difficult to read/maintain.

> diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
> new file mode 100644
> index 000000000000..e65f1cb2648b
> --- /dev/null
> +++ b/drivers/mfd/atc260x-core.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Core MFD support for ATC260x PMICs
> + *
> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/atc260x/core.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "atc260x.h"
> +
> +void atc260x_cmu_reset(struct atc260x *atc260x, u32 reg, u8 mask, u32 bit)
> +{
> +	/* Assert reset */
> +	regmap_update_bits(atc260x->regmap, reg, mask, ~bit);
> +
> +	/* De-assert reset */
> +	regmap_update_bits(atc260x->regmap, reg, mask, bit);
> +}

I only see one call-site.  Are you planning on reusing this?

> +int atc260x_core_init(struct atc260x *atc260x)
> +{
> +	struct device *dev = atc260x->dev;
> +	unsigned int chip_rev;
> +	int ret;
> +
> +	if (!atc260x->irq) {
> +		dev_err(dev, "No interrupt support\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize the hardware */
> +	atc260x->dev_init(atc260x);

I don't think we need to mess around with pointers to functions in
this simple driver.

> +	ret = regmap_read(atc260x->regmap, atc260x->rev_reg, &chip_rev);
> +	if (ret) {
> +		dev_err(dev, "Failed to read revision register\n");

End users don't care about registers.

"Failed to obtain chip revision"

> +		return ret;
> +	}
> +
> +	if (chip_rev < 0 || chip_rev > 31) {

Do you really support 32 revisions?

> +		dev_err(dev, "Unknown chip revision: %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	chip_rev = __ffs(chip_rev + 1U);

1 bit per revision?  That is highly inefficient.

> +	dev_info(dev, "%s chip revision: %d\n", atc260x->type_name, chip_rev);
> +
> +	ret = regmap_add_irq_chip(atc260x->regmap, atc260x->irq,
> +				  IRQF_ONESHOT, -1,
> +				  atc260x->regmap_irq_chip, &atc260x->irq_data);
> +	if (ret) {
> +		dev_err(dev, "Failed to add irq_chip %d\n", ret);

"Failed to add IRQ Chip"

> +		return ret;
> +	}
> +
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   atc260x->cells, atc260x->nr_cells, NULL, 0,
> +				   regmap_irq_get_domain(atc260x->irq_data));
> +	if (ret) {
> +		dev_err(dev, "Failed to add MFD devices %d\n", ret);

"Failed to add child devices"

> +		goto err_irq;
> +	}
> +
> +	return 0;
> +
> +err_irq:
> +	regmap_del_irq_chip(atc260x->irq, atc260x->irq_data);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(atc260x_core_init);
> +
> +int atc260x_core_exit(struct atc260x *atc260x)
> +{
> +	regmap_del_irq_chip(atc260x->irq, atc260x->irq_data);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(atc260x_core_exit);
> diff --git a/drivers/mfd/atc260x-i2c.c b/drivers/mfd/atc260x-i2c.c
> new file mode 100644
> index 000000000000..3b7e8c1f5ac5
> --- /dev/null
> +++ b/drivers/mfd/atc260x-i2c.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * I2C bus interface for ATC260x PMICs
> + *
> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mfd/atc260x/core.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include "atc260x.h"
> +
> +const struct mfd_cell atc2609a_mfd_cells[] = {
> +	{ .name = "atc260x-regulator", },
> +};

What other child devices are there?

Please add more, or this is not an MFD.

> +static int atc260x_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct atc260x *atc260x;
> +	const void *of_data;
> +	unsigned long atc260x_type;
> +
> +	atc260x = devm_kzalloc(&client->dev, sizeof(*atc260x), GFP_KERNEL);
> +	if (!atc260x)
> +		return -ENOMEM;
> +
> +	of_data = of_device_get_match_data(&client->dev);
> +	if (!of_data)
> +		return -ENODEV;
> +
> +	atc260x_type = (unsigned long)of_data;
> +
> +	switch (atc260x_type) {
> +	case ATC2609A:

How many more models are you expecting to support?

> +		atc260x->regmap_cfg = &atc2609a_regmap_config;
> +		atc260x->regmap_irq_chip = &atc2609a_regmap_irq_chip;
> +		atc260x->cells = atc2609a_mfd_cells;
> +		atc260x->nr_cells = ARRAY_SIZE(atc2609a_mfd_cells);
> +		atc260x->type_name = "atc2609a";
> +		atc260x->rev_reg = ATC2609A_CHIP_VER;
> +		atc260x->dev_init = atc2609a_dev_init;
> +		break;
> +	default:
> +		dev_err(&client->dev,
> +			"Unsupported ATC260x I2C device type %ld\n",
> +			atc260x_type);
> +		return -EINVAL;
> +	}

I'd assume you'd have to replicate all of this for SPI too.  That does
not sound like a good idea.  Please find a better, more succinct way
to handle this i.e. in the core driver.

> +	atc260x->regmap = devm_regmap_init_i2c(client, atc260x->regmap_cfg);
> +	if (IS_ERR(atc260x->regmap)) {
> +		dev_err(&client->dev, "regmap initialization failed\n");
> +		return PTR_ERR(atc260x->regmap);
> +	}
> +
> +	i2c_set_clientdata(client, atc260x);
> +	atc260x->type = atc260x_type;

> +	atc260x->dev = &client->dev;
> +	atc260x->irq = client->irq;

You already have 'dev' and 'irq' stored in 'client', which you need in
order retrieve them back anyway.  So why store them again?

> +	return atc260x_core_init(atc260x);
> +}
> +
> +static int atc260x_i2c_remove(struct i2c_client *client)
> +{
> +	struct atc260x *atc260x = dev_get_drvdata(&client->dev);
> +
> +	atc260x_core_exit(atc260x);
> +
> +	return 0;
> +}
> +
> +const struct of_device_id atc260x_of_match[] = {
> +	{ .compatible = "actions,atc2609a", .data = (void *)ATC2609A },

Is there no way to dynamically request chip ID from the H/W?

> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, atc260x_of_match);
> +
> +static struct i2c_driver atc260x_i2c_driver = {
> +	.driver = {
> +		.name	= "atc260x",
> +		.of_match_table	= of_match_ptr(atc260x_of_match),
> +	},
> +	.probe		= atc260x_i2c_probe,
> +	.remove		= atc260x_i2c_remove,
> +};
> +
> +module_i2c_driver(atc260x_i2c_driver);
> +
> +MODULE_DESCRIPTION("ATC260x PMICs I2C bus interface");
> +MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mfd/atc260x.h b/drivers/mfd/atc260x.h
> new file mode 100644
> index 000000000000..30fc66dfba04
> --- /dev/null
> +++ b/drivers/mfd/atc260x.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MFD internals for ATC260x PMICs
> + *
> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#ifndef ATC260X_MFD_H
> +#define ATC260X_MFD_H
> +
> +extern const struct of_device_id atc260x_of_match[];
> +int atc260x_core_init(struct atc260x *atc260x);
> +int atc260x_core_exit(struct atc260x *atc260x);
> +void atc260x_cmu_reset(struct atc260x *atc260x, u32 reg, u8 mask, u32 bit);
> +
> +extern const struct regmap_config atc2609a_regmap_config;
> +extern const struct mfd_cell atc2609a_mfd_cells[];
> +extern const struct regmap_irq_chip atc2609a_regmap_irq_chip;
> +extern const struct regmap_irq atc2609a_irqs[];

Yuck!  Please don't do this.  Please put this stuff in one file.

> +int atc2609a_dev_init(struct atc260x *atc260x);
> +
> +#endif /* ATC260X_MFD_H */
> diff --git a/include/linux/mfd/atc260x/atc2609a_regs.h b/include/linux/mfd/atc260x/atc2609a_regs.h
> new file mode 100644
> index 000000000000..851fb3dadd4f
> --- /dev/null
> +++ b/include/linux/mfd/atc260x/atc2609a_regs.h
> @@ -0,0 +1,228 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * ATC2609A PMIC register definitions
> + *
> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#ifndef __ATC2609A_REGS_H__
> +#define __ATC2609A_REGS_H__
> +
> +enum atc2609a_irq_def {
> +	ATC2609A_IRQ_AUDIO = 0,
> +	ATC2609A_IRQ_OV = 1,
> +	ATC2609A_IRQ_OC = 2,
> +	ATC2609A_IRQ_OT = 3,
> +	ATC2609A_IRQ_UV = 4,
> +	ATC2609A_IRQ_ALARM = 5,
> +	ATC2609A_IRQ_ONOFF = 6,
> +	ATC2609A_IRQ_WKUP = 7,
> +	ATC2609A_IRQ_IR = 8,
> +	ATC2609A_IRQ_REMCON = 9,
> +	ATC2609A_IRQ_POWER_IN = 10,
> +};
> +
> +/* PMU Register */
> +#define ATC2609A_PMU_SYS_CTL0			0x00
> +#define ATC2609A_PMU_SYS_CTL1			0x01
> +#define ATC2609A_PMU_SYS_CTL2			0x02
> +#define ATC2609A_PMU_SYS_CTL3			0x03
> +#define ATC2609A_PMU_SYS_CTL4			0x04
> +#define ATC2609A_PMU_SYS_CTL5			0x05
> +#define ATC2609A_PMU_SYS_CTL6			0x06
> +#define ATC2609A_PMU_SYS_CTL7			0x07
> +#define ATC2609A_PMU_SYS_CTL8			0x08
> +#define ATC2609A_PMU_SYS_CTL9			0x09
> +#define ATC2609A_PMU_BAT_CTL0			0x0A
> +#define ATC2609A_PMU_BAT_CTL1			0x0B
> +#define ATC2609A_PMU_VBUS_CTL0			0x0C
> +#define ATC2609A_PMU_VBUS_CTL1			0x0D
> +#define ATC2609A_PMU_WALL_CTL0			0x0E
> +#define ATC2609A_PMU_WALL_CTL1			0x0F
> +#define ATC2609A_PMU_SYS_PENDING		0x10
> +#define ATC2609A_PMU_APDS_CTL0			0x11
> +#define ATC2609A_PMU_APDS_CTL1			0x12
> +#define ATC2609A_PMU_APDS_CTL2			0x13
> +#define ATC2609A_PMU_CHARGER_CTL		0x14
> +#define ATC2609A_PMU_BAKCHARGER_CTL		0x15
> +#define ATC2609A_PMU_SWCHG_CTL0			0x16
> +#define ATC2609A_PMU_SWCHG_CTL1			0x17
> +#define ATC2609A_PMU_SWCHG_CTL2			0x18
> +#define ATC2609A_PMU_SWCHG_CTL3			0x19
> +#define ATC2609A_PMU_SWCHG_CTL4			0x1A
> +#define ATC2609A_PMU_DC_OSC			0x1B
> +#define ATC2609A_PMU_DC0_CTL0			0x1C
> +#define ATC2609A_PMU_DC0_CTL1			0x1D
> +#define ATC2609A_PMU_DC0_CTL2			0x1E
> +#define ATC2609A_PMU_DC0_CTL3			0x1F
> +#define ATC2609A_PMU_DC0_CTL4			0x20
> +#define ATC2609A_PMU_DC0_CTL5			0x21
> +#define ATC2609A_PMU_DC0_CTL6			0x22
> +#define ATC2609A_PMU_DC1_CTL0			0x23
> +#define ATC2609A_PMU_DC1_CTL1			0x24
> +#define ATC2609A_PMU_DC1_CTL2			0x25
> +#define ATC2609A_PMU_DC1_CTL3			0x26
> +#define ATC2609A_PMU_DC1_CTL4			0x27
> +#define ATC2609A_PMU_DC1_CTL5			0x28
> +#define ATC2609A_PMU_DC1_CTL6			0x29
> +#define ATC2609A_PMU_DC2_CTL0			0x2A
> +#define ATC2609A_PMU_DC2_CTL1			0x2B
> +#define ATC2609A_PMU_DC2_CTL2			0x2C
> +#define ATC2609A_PMU_DC2_CTL3			0x2D
> +#define ATC2609A_PMU_DC2_CTL4			0x2E
> +#define ATC2609A_PMU_DC2_CTL5			0x2F
> +#define ATC2609A_PMU_DC2_CTL6			0x30
> +#define ATC2609A_PMU_DC3_CTL0			0x31
> +#define ATC2609A_PMU_DC3_CTL1			0x32
> +#define ATC2609A_PMU_DC3_CTL2			0x33
> +#define ATC2609A_PMU_DC3_CTL3			0x34
> +#define ATC2609A_PMU_DC3_CTL4			0x35
> +#define ATC2609A_PMU_DC3_CTL5			0x36
> +#define ATC2609A_PMU_DC3_CTL6			0x37
> +#define ATC2609A_PMU_DC_ZR			0x38
> +#define ATC2609A_PMU_LDO0_CTL0			0x39
> +#define ATC2609A_PMU_LDO0_CTL1			0x3A
> +#define ATC2609A_PMU_LDO1_CTL0			0x3B
> +#define ATC2609A_PMU_LDO1_CTL1			0x3C
> +#define ATC2609A_PMU_LDO2_CTL0			0x3D
> +#define ATC2609A_PMU_LDO2_CTL1			0x3E
> +#define ATC2609A_PMU_LDO3_CTL0			0x3F
> +#define ATC2609A_PMU_LDO3_CTL1			0x40
> +#define ATC2609A_PMU_LDO4_CTL0			0x41
> +#define ATC2609A_PMU_LDO4_CTL1			0x42
> +#define ATC2609A_PMU_LDO5_CTL0			0x43
> +#define ATC2609A_PMU_LDO5_CTL1			0x44
> +#define ATC2609A_PMU_LDO6_CTL0			0x45
> +#define ATC2609A_PMU_LDO6_CTL1			0x46
> +#define ATC2609A_PMU_LDO7_CTL0			0x47
> +#define ATC2609A_PMU_LDO7_CTL1			0x48
> +#define ATC2609A_PMU_LDO8_CTL0			0x49
> +#define ATC2609A_PMU_LDO8_CTL1			0x4A
> +#define ATC2609A_PMU_LDO9_CTL			0x4B
> +#define ATC2609A_PMU_OV_INT_EN			0x4C
> +#define ATC2609A_PMU_OV_STATUS			0x4D
> +#define ATC2609A_PMU_UV_INT_EN			0x4E
> +#define ATC2609A_PMU_UV_STATUS			0x4F
> +#define ATC2609A_PMU_OC_INT_EN			0x50
> +#define ATC2609A_PMU_OC_STATUS			0x51
> +#define ATC2609A_PMU_OT_CTL			0x52
> +#define ATC2609A_PMU_CM_CTL0			0x53
> +#define ATC2609A_PMU_FW_USE0			0x54
> +#define ATC2609A_PMU_FW_USE1			0x55
> +#define ATC2609A_PMU_ADC12B_I			0x56
> +#define ATC2609A_PMU_ADC12B_V			0x57
> +#define ATC2609A_PMU_ADC12B_DUMMY		0x58
> +#define ATC2609A_PMU_AUXADC_CTL0		0x59
> +#define ATC2609A_PMU_AUXADC_CTL1		0x5A
> +#define ATC2609A_PMU_BATVADC			0x5B
> +#define ATC2609A_PMU_BATIADC			0x5C
> +#define ATC2609A_PMU_WALLVADC			0x5D
> +#define ATC2609A_PMU_WALLIADC			0x5E
> +#define ATC2609A_PMU_VBUSVADC			0x5F
> +#define ATC2609A_PMU_VBUSIADC			0x60
> +#define ATC2609A_PMU_SYSPWRADC			0x61
> +#define ATC2609A_PMU_REMCONADC			0x62
> +#define ATC2609A_PMU_SVCCADC			0x63
> +#define ATC2609A_PMU_CHGIADC			0x64
> +#define ATC2609A_PMU_IREFADC			0x65
> +#define ATC2609A_PMU_BAKBATADC			0x66
> +#define ATC2609A_PMU_ICTEMPADC			0x67
> +#define ATC2609A_PMU_AUXADC0			0x68
> +#define ATC2609A_PMU_AUXADC1			0x69
> +#define ATC2609A_PMU_AUXADC2			0x6A
> +#define ATC2609A_PMU_AUXADC3			0x6B
> +#define ATC2609A_PMU_ICTEMPADC_ADJ		0x6C
> +#define ATC2609A_PMU_BDG_CTL			0x6D
> +#define ATC2609A_RTC_CTL			0x6E
> +#define ATC2609A_RTC_MSALM			0x6F
> +#define ATC2609A_RTC_HALM			0x70
> +#define ATC2609A_RTC_YMDALM			0x71
> +#define ATC2609A_RTC_MS				0x72
> +#define ATC2609A_RTC_H				0x73
> +#define ATC2609A_RTC_DC				0x74
> +#define ATC2609A_RTC_YMD			0x75
> +#define ATC2609A_EFUSE_DAT			0x76
> +#define ATC2609A_EFUSECRTL1			0x77
> +#define ATC2609A_EFUSECRTL2			0x78
> +#define ATC2609A_PMU_DC4_CTL0			0x79
> +#define ATC2609A_PMU_DC4_CTL1			0x7A
> +#define ATC2609A_PMU_DC4_CTL2			0x7B
> +#define ATC2609A_PMU_DC4_CTL3			0x7C
> +#define ATC2609A_PMU_DC4_CTL4			0x7D
> +#define ATC2609A_PMU_DC4_CTL5			0x7E
> +#define ATC2609A_PMU_DC4_CTL6			0x7F
> +#define ATC2609A_PMU_PWR_STATUS			0x80
> +#define ATC2609A_PMU_S2_PWR			0x81
> +#define ATC2609A_CLMT_CTL0			0x82
> +#define ATC2609A_CLMT_DATA0			0x83
> +#define ATC2609A_CLMT_DATA1			0x84
> +#define ATC2609A_CLMT_DATA2			0x85
> +#define ATC2609A_CLMT_DATA3			0x86
> +#define ATC2609A_CLMT_ADD0			0x87
> +#define ATC2609A_CLMT_ADD1			0x88
> +#define ATC2609A_CLMT_OCV_TABLE			0x89
> +#define ATC2609A_CLMT_R_TABLE			0x8A
> +#define ATC2609A_PMU_PWRON_CTL0			0x8D
> +#define ATC2609A_PMU_PWRON_CTL1			0x8E
> +#define ATC2609A_PMU_PWRON_CTL2			0x8F
> +#define ATC2609A_IRC_CTL			0x90
> +#define ATC2609A_IRC_STAT			0x91
> +#define ATC2609A_IRC_CC				0x92
> +#define ATC2609A_IRC_KDC			0x93
> +#define ATC2609A_IRC_WK				0x94
> +#define ATC2609A_IRC_RCC			0x95
> +
> +/* AUDIO_OUT Register */
> +#define ATC2609A_AUDIOINOUT_CTL			0xA0
> +#define ATC2609A_AUDIO_DEBUGOUTCTL		0xA1
> +#define ATC2609A_DAC_DIGITALCTL			0xA2
> +#define ATC2609A_DAC_VOLUMECTL0			0xA3
> +#define ATC2609A_DAC_ANALOG0			0xA4
> +#define ATC2609A_DAC_ANALOG1			0xA5
> +#define ATC2609A_DAC_ANALOG2			0xA6
> +#define ATC2609A_DAC_ANALOG3			0xA7
> +
> +/* AUDIO_IN Register */
> +#define ATC2609A_ADC_DIGITALCTL			0xA8
> +#define ATC2609A_ADC_HPFCTL			0xA9
> +#define ATC2609A_ADC_CTL			0xAA
> +#define ATC2609A_AGC_CTL0			0xAB
> +#define ATC2609A_AGC_CTL1			0xAC
> +#define ATC2609A_AGC_CTL2			0xAD
> +#define ATC2609A_ADC_ANALOG0			0xAE
> +#define ATC2609A_ADC_ANALOG1			0xAF
> +
> +/* PCM_IF Register */
> +#define ATC2609A_PCM0_CTL			0xB0
> +#define ATC2609A_PCM1_CTL			0xB1
> +#define ATC2609A_PCM2_CTL			0xB2
> +#define ATC2609A_PCMIF_CTL			0xB3
> +
> +/* CMU_CONTROL Register */
> +#define ATC2609A_CMU_DEVRST			0xC1
> +
> +/* INTS Register */
> +#define ATC2609A_INTS_PD			0xC8
> +#define ATC2609A_INTS_MSK			0xC9
> +
> +/* MFP Register */
> +#define ATC2609A_MFP_CTL			0xD0
> +#define ATC2609A_PAD_VSEL			0xD1
> +#define ATC2609A_GPIO_OUTEN			0xD2
> +#define ATC2609A_GPIO_INEN			0xD3
> +#define ATC2609A_GPIO_DAT			0xD4
> +#define ATC2609A_PAD_DRV			0xD5
> +#define ATC2609A_PAD_EN				0xD6
> +#define ATC2609A_DEBUG_SEL			0xD7
> +#define ATC2609A_DEBUG_IE			0xD8
> +#define ATC2609A_DEBUG_OE			0xD9
> +#define ATC2609A_CHIP_VER			0xDC
> +
> +/* PWSI Register */
> +#define ATC2609A_PWSI_CTL			0xF0
> +#define ATC2609A_PWSI_STATUS			0xF1
> +
> +/* TWSI Register */
> +#define ATC2609A_SADDR				0xFF
> +
> +#endif /* __ATC2609A_REGS_H__ */
> diff --git a/include/linux/mfd/atc260x/core.h b/include/linux/mfd/atc260x/core.h
> new file mode 100644
> index 000000000000..9d75eca731d4
> --- /dev/null
> +++ b/include/linux/mfd/atc260x/core.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Core MFD defines for ATC260x PMICs
> + *
> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#ifndef __ATC260X_CORE_H__
> +#define __ATC260X_CORE_H__
> +
> +#include <linux/mfd/atc260x/atc2609a_regs.h>
> +
> +enum atc260x_type {
> +	ATC2603A = 0,
> +	ATC2603C = 1,
> +	ATC2609A = 2,

Why don't you let the enum enumerate these numbers for you?

> +};
> +
> +enum atc260x_reg {
> +	ATC2609A_ID_DCDC0,
> +	ATC2609A_ID_DCDC1,
> +	ATC2609A_ID_DCDC2,
> +	ATC2609A_ID_DCDC3,
> +	ATC2609A_ID_DCDC4,
> +	ATC2609A_ID_LDO0,
> +	ATC2609A_ID_LDO1,
> +	ATC2609A_ID_LDO2,
> +	ATC2609A_ID_LDO3,
> +	ATC2609A_ID_LDO4,
> +	ATC2609A_ID_LDO5,
> +	ATC2609A_ID_LDO6,
> +	ATC2609A_ID_LDO7,
> +	ATC2609A_ID_LDO8,
> +	ATC2609A_ID_LDO9,
> +	ATC2609A_ID_MAX,
> +};
> +
> +enum atc260x_cmu_bits {
> +	ATC260X_CMU_TP = 0,
> +	ATC260X_CMU_MFP = 1,
> +	ATC260X_CMU_INTS = 2,
> +	ATC260X_CMU_ETHPHY = 3,
> +	ATC260X_CMU_AUDIO = 4,
> +	ATC260X_CMU_PWSI = 5,
> +};

Why don't you let the enum enumerate these numbers for you?

> +struct atc260x {
> +	struct device *dev;
> +	struct regmap_irq_chip_data *irq_data;
> +	struct regmap *regmap;
> +	const struct regmap_config *regmap_cfg;
> +	const struct regmap_irq_chip *regmap_irq_chip;
> +	const struct mfd_cell *cells;
> +	int nr_cells;
> +	int irq;
> +
> +	enum atc260x_type type;
> +	const char *type_name;
> +	unsigned int rev_reg;
> +
> +	int (*dev_init)(struct atc260x *atc260x);
> +};

If you do this right, you could probably remove this struct
completely.

> +#endif /* __ATC260X_CORE_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

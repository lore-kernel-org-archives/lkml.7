Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CFDC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114182085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIyEA2mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfHLJxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:53:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40308 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfHLJxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:53:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so4913137wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QVjgkFb/UoYL4lyfH0oonDO4eNphs4OMqX0F+thZKmE=;
        b=tIyEA2mQLaQZemhwReFsYvFsT/0407PHswf9itCl7deO1g5hSbadDH9yDn04LRHAMJ
         Fg+XVU6/+QihIZPdPx+fsgA7lQwKRn2XrPFgdB3ZUxnURXqYsL9gu/vEmgUETixjkJ4x
         JdVzwv0HV8Sij6CKmvJ0w+mRGr7ai5FCzgiVAWAcW0sxUFiHVF5r611WiwBnlFAuLjEB
         SN4emEBGkSe0tLA0H+lfHLRpkmeZ0xQXL48jJ7UeYKpNkJq05lvZf7ts/WJwSeVNlIbU
         iQU+7wxnoTGLeBoD8pHHm541b35PEZRSxymPJL6Jht5yn4ONKq+ZbsabVpS/pLi9JRh8
         b+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QVjgkFb/UoYL4lyfH0oonDO4eNphs4OMqX0F+thZKmE=;
        b=OvmlLKyOoxqKyR4qFb6//O1jHZqPcbBY1rVgIH8JaM60rQz5kbiVmaIoor8W1akw7b
         NKbGek4bxxiE9TWXMSe5kg2ANP9OTK682TVSGMaMrLokMNvhmUtVdfwoHGuYwB2i5+l+
         N7YXu8cYfWovugE2BFVfER/kfMWxPmz0PRN4W02+Bp+XzE2tKyYcrLwP+/otvuT8sZrC
         P5eaHklHtYOA90HHyX7g3xCL+9rzFIv8EYMQA/yGL6d3LaYuRm/GFretFMOZQpP7LeXt
         Sq27UqNgpO+VegydQxDMvqQO0pGvhX3Qk9tSrK7FBYVeJcC+xI5asW1TfPxNJEwK/FvX
         T77A==
X-Gm-Message-State: APjAAAXq/Bz7vsZkt3OfGvste6mOZwUDFP8i4vjwZFzy5uObX2f2pfTm
        UTtjYroE62/J+croNm8JQ5g6fgKyQew=
X-Google-Smtp-Source: APXvYqyrplOccsSerZZAdy6HPvacPhcgCNgPW7L0cDDP5mI83ySYjHA72OOjFWw/MmJjvElYTQRfBg==
X-Received: by 2002:adf:e2cb:: with SMTP id d11mr33697229wrj.66.1565603620373;
        Mon, 12 Aug 2019 02:53:40 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id e11sm13017480wrc.4.2019.08.12.02.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 02:53:39 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:53:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190812095338.GD26727@dell>
References: <20190801190335.37726-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801190335.37726-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Aug 2019, Andy Shevchenko wrote:

> Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> 
> Firmware on the platforms which are using Basin Cove PMIC is "smarter"
> than on the rest supported by vanilla kernel. It handles first level
> of interrupt itself, while others do it on OS level.
> 
> The driver is done in the same way as the rest of Intel PMIC MFD drivers
> in the kernel to support the initial design. The design allows to use
> one driver among few PMICs without knowing implementation details of
> the each hardware version or generation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v4: elaborate in the commit message the design choice
>  drivers/mfd/Kconfig                      |  11 ++
>  drivers/mfd/Makefile                     |   1 +
>  drivers/mfd/intel_soc_pmic_mrfld.c       | 157 +++++++++++++++++++++++
>  include/linux/mfd/intel_soc_pmic_mrfld.h |  81 ++++++++++++
>  4 files changed, 250 insertions(+)
>  create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
>  create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f129f9678940..adf178ad5e7b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -597,6 +597,17 @@ config INTEL_SOC_PMIC_CHTDC_TI
>  	  Select this option for supporting Dollar Cove (TI version) PMIC
>  	  device that is found on some Intel Cherry Trail systems.
>  
> +config INTEL_SOC_PMIC_MRFLD
> +	tristate "Support for Intel Merrifield Basin Cove PMIC"
> +	depends on GPIOLIB
> +	depends on ACPI
> +	depends on INTEL_SCU_IPC
> +	select MFD_CORE
> +	select REGMAP_IRQ
> +	help
> +	  Select this option for supporting Basin Cove PMIC device
> +	  that is found on Intel Merrifield systems.
> +
>  config MFD_INTEL_LPSS
>  	tristate
>  	select COMMON_CLK
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f026ada68f6a..637ecf6b12de 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -241,6 +241,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> +obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> diff --git a/drivers/mfd/intel_soc_pmic_mrfld.c b/drivers/mfd/intel_soc_pmic_mrfld.c
> new file mode 100644
> index 000000000000..26a1551c5faf
> --- /dev/null
> +++ b/drivers/mfd/intel_soc_pmic_mrfld.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device access for Basin Cove PMIC
> + *
> + * Copyright (c) 2019, Intel Corporation.
> + * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/mfd/intel_soc_pmic_mrfld.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <asm/intel_scu_ipc.h>
> +
> +/*
> + * Level 2 IRQs
> + *
> + * Firmware on the systems with Basin Cove PMIC services Level 1 IRQs
> + * without an assistance. Thus, each of the Level 1 IRQ is represented
> + * as a separate RTE in IOAPIC.
> + */
> +static struct resource irq_level2_resources[] = {
> +	DEFINE_RES_IRQ(0), /* power button */
> +	DEFINE_RES_IRQ(0), /* TMU */
> +	DEFINE_RES_IRQ(0), /* thermal */
> +	DEFINE_RES_IRQ(0), /* BCU */
> +	DEFINE_RES_IRQ(0), /* ADC */
> +	DEFINE_RES_IRQ(0), /* charger */
> +	DEFINE_RES_IRQ(0), /* GPIO */
> +};
> +
> +static const struct mfd_cell bcove_dev[] = {
> +	{
> +		.name = "mrfld_bcove_pwrbtn",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[0],
> +	}, {
> +		.name = "mrfld_bcove_tmu",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[1],
> +	}, {
> +		.name = "mrfld_bcove_thermal",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[2],
> +	}, {
> +		.name = "mrfld_bcove_bcu",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[3],
> +	}, {
> +		.name = "mrfld_bcove_adc",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[4],
> +	}, {
> +		.name = "mrfld_bcove_charger",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[5],
> +	}, {
> +		.name = "mrfld_bcove_pwrsrc",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[5],
> +	}, {
> +		.name = "mrfld_bcove_gpio",
> +		.num_resources = 1,
> +		.resources = &irq_level2_resources[6],
> +	},
> +	{	.name = "mrfld_bcove_region", },
> +};
> +
> +static int bcove_ipc_byte_reg_read(void *context, unsigned int reg,
> +				    unsigned int *val)
> +{
> +	u8 ipc_out;
> +	int ret;
> +
> +	ret = intel_scu_ipc_ioread8(reg, &ipc_out);
> +	if (ret)
> +		return ret;
> +
> +	*val = ipc_out;
> +	return 0;
> +}
> +
> +static int bcove_ipc_byte_reg_write(void *context, unsigned int reg,
> +				     unsigned int val)
> +{
> +	u8 ipc_in = val;
> +	int ret;
> +
> +	ret = intel_scu_ipc_iowrite8(reg, ipc_in);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Is intel_scu_ipc_iowrite8() going to be used with Regmap again?  If
so, it's probably best to have these as part of the API.  Probably
supplied as an inline function.

> +static const struct regmap_config bcove_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.max_register = 0xff,
> +	.reg_write = bcove_ipc_byte_reg_write,
> +	.reg_read = bcove_ipc_byte_reg_read,
> +};
> +
> +static int bcove_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_soc_pmic *pmic;
> +	unsigned int i;
> +	int ret;
> +
> +	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pmic);
> +	pmic->dev = &pdev->dev;
> +
> +	pmic->regmap = devm_regmap_init(dev, NULL, pmic, &bcove_regmap_config);
> +	if (IS_ERR(pmic->regmap))
> +		return PTR_ERR(pmic->regmap);
> +
> +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> +		ret = platform_get_irq(pdev, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		irq_level2_resources[i].start = ret;
> +		irq_level2_resources[i].end = ret;
> +	}

I still get the same feeling that this is a waste of a driver!

ACPI hackery, if you will. :(

It's just a shame that I can't think of a better way to do it.

> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				    bcove_dev, ARRAY_SIZE(bcove_dev),
> +				    NULL, 0, NULL);
> +}
> +
> +static const struct acpi_device_id bcove_acpi_ids[] = {
> +	{ "INTC100E" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, bcove_acpi_ids);
> +
> +static struct platform_driver bcove_driver = {
> +	.driver = {
> +		.name = "intel_soc_pmic_mrfld",
> +		.acpi_match_table = bcove_acpi_ids,
> +	},
> +	.probe = bcove_probe,
> +};
> +module_platform_driver(bcove_driver);
> +
> +MODULE_DESCRIPTION("IPC driver for Intel SoC Basin Cove PMIC");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/intel_soc_pmic_mrfld.h b/include/linux/mfd/intel_soc_pmic_mrfld.h
> new file mode 100644
> index 000000000000..4daecd682275
> --- /dev/null
> +++ b/include/linux/mfd/intel_soc_pmic_mrfld.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Intel Merrifield Basin Cove PMIC
> + *
> + * Copyright (C) 2019 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef __INTEL_SOC_PMIC_MRFLD_H__
> +#define __INTEL_SOC_PMIC_MRFLD_H__
> +
> +#include <linux/bits.h>
> +
> +#define BCOVE_ID		0x00
> +
> +#define BCOVE_ID_MINREV0	GENMASK(2, 0)
> +#define BCOVE_ID_MAJREV0	GENMASK(5, 3)
> +#define BCOVE_ID_VENDID0	GENMASK(7, 6)
> +
> +#define BCOVE_MINOR(x)		(unsigned int)(((x) & BCOVE_ID_MINREV0) >> 0)
> +#define BCOVE_MAJOR(x)		(unsigned int)(((x) & BCOVE_ID_MAJREV0) >> 3)
> +#define BCOVE_VENDOR(x)		(unsigned int)(((x) & BCOVE_ID_VENDID0) >> 6)
> +
> +#define BCOVE_IRQLVL1		0x01
> +
> +#define BCOVE_PBIRQ		0x02
> +#define BCOVE_TMUIRQ		0x03
> +#define BCOVE_THRMIRQ		0x04
> +#define BCOVE_BCUIRQ		0x05
> +#define BCOVE_ADCIRQ		0x06
> +#define BCOVE_CHGRIRQ0		0x07
> +#define BCOVE_CHGRIRQ1		0x08
> +#define BCOVE_GPIOIRQ		0x09
> +#define BCOVE_CRITIRQ		0x0B
> +
> +#define BCOVE_MIRQLVL1		0x0C
> +
> +#define BCOVE_MPBIRQ		0x0D
> +#define BCOVE_MTMUIRQ		0x0E
> +#define BCOVE_MTHRMIRQ		0x0F
> +#define BCOVE_MBCUIRQ		0x10
> +#define BCOVE_MADCIRQ		0x11
> +#define BCOVE_MCHGRIRQ0		0x12
> +#define BCOVE_MCHGRIRQ1		0x13
> +#define BCOVE_MGPIOIRQ		0x14
> +#define BCOVE_MCRITIRQ		0x16
> +
> +#define BCOVE_SCHGRIRQ0		0x4E
> +#define BCOVE_SCHGRIRQ1		0x4F
> +
> +/* Level 1 IRQs */
> +#define BCOVE_LVL1_PWRBTN	BIT(0)	/* power button */
> +#define BCOVE_LVL1_TMU		BIT(1)	/* time management unit */
> +#define BCOVE_LVL1_THRM		BIT(2)	/* thermal */
> +#define BCOVE_LVL1_BCU		BIT(3)	/* burst control unit */
> +#define BCOVE_LVL1_ADC		BIT(4)	/* ADC */
> +#define BCOVE_LVL1_CHGR		BIT(5)	/* charger */
> +#define BCOVE_LVL1_GPIO		BIT(6)	/* GPIO */
> +#define BCOVE_LVL1_CRIT		BIT(7)	/* critical event */
> +
> +/* Level 2 IRQs: power button */
> +#define BCOVE_PBIRQ_PBTN	BIT(0)
> +#define BCOVE_PBIRQ_UBTN	BIT(1)
> +
> +/* Level 2 IRQs: ADC */
> +#define BCOVE_ADCIRQ_BATTEMP	BIT(2)
> +#define BCOVE_ADCIRQ_SYSTEMP	BIT(3)
> +#define BCOVE_ADCIRQ_BATTID	BIT(4)
> +#define BCOVE_ADCIRQ_VIBATT	BIT(5)
> +#define BCOVE_ADCIRQ_CCTICK	BIT(7)
> +
> +/* Level 2 IRQs: charger */
> +#define BCOVE_CHGRIRQ_BAT0ALRT	BIT(4)
> +#define BCOVE_CHGRIRQ_BAT1ALRT	BIT(5)
> +#define BCOVE_CHGRIRQ_BATCRIT	BIT(6)
> +
> +#define BCOVE_CHGRIRQ_VBUSDET	BIT(0)
> +#define BCOVE_CHGRIRQ_DCDET	BIT(1)
> +#define BCOVE_CHGRIRQ_BATTDET	BIT(2)
> +#define BCOVE_CHGRIRQ_USBIDDET	BIT(3)
> +
> +#endif	/* __INTEL_SOC_PMIC_MRFLD_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

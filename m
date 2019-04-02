Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF26A20651
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1PhPEy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfDBFMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:12:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfDBFMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:12:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so5911245pgu.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1tWoHTd+gXiMpTYKvrf8N4dgAq00hsHrlsKiFyYTJ2M=;
        b=b1PhPEy66eJcwxPwTCTxl8VC1wBnF3YC0IMEt2e9dpJeHitxb90+Plm4kIq7Q20neU
         yT87N46q2ipnjCyIeZ2/tDuHXMU08KzX3FdqarMNUILRui2F8Dgnudw7E00n+Kb9ZUAr
         rYO+E8m6Xo+8xIwGfSPV1NnlhWjmqmpflq8uq+g+rB/6jrNC0ni4npwkGGrExW+Nz2WM
         yfwDcEaUk6gEU8XrW4B4w2lLfrTkxYRlgzlGVXxTI2KeLi1QzAzDMcxfQkW24VEWvvMU
         JXuMroCUhgZiZRIsgKDqzo5vV8vZe344iSPw96ZlEkVm5EsY+hoQFAmkBTR2JbfhTeui
         7VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1tWoHTd+gXiMpTYKvrf8N4dgAq00hsHrlsKiFyYTJ2M=;
        b=dGwf1smln5U1iwDpzF6Y8OJuJ9wvdBca0MRI4JYa2mMaCJkVIHQUlguwlvmhtNNH6+
         jOer9Mdpn/7LqtzgNk3Z4z0JbJ7qRmnwSCrPhbbL6RH92YBmpU71+M8iUXK895Hv0ss7
         gjtAXG0ABp1ngeN/OhXf6L/ktXYeLClEwrkO728/GDLQIzxUnmfK86Fbv8RvhAXQXthe
         kJaMXXxqK3NzU+BGg5mFt1Iir14Kqg7Q738+CzmVivg90lAmSHxy+sxD0LckKW6p9cPe
         ZjWjs6BIN+GyZ0iCt9gd52D7yhtZY2q1RDc+jXFnIKJdbIw2dsBwjIiiekRwi06QZjdb
         +++g==
X-Gm-Message-State: APjAAAVV+HWwxVbQJTdkEYjmH1CFfI/4IdryugdC5/qG5WRwrah7OqlS
        hXDQ3fkq5mnUsZd8CLQduuFGGB+gp3m6dg==
X-Google-Smtp-Source: APXvYqyY2Oh/1vzdkzRdhEGAtLnTtpHkxzPm/P+aJ8KlsnxD+gIh2JFLUpXLFGF7K+eEonhn3lCAsg==
X-Received: by 2002:a63:d304:: with SMTP id b4mr51550438pgg.300.1554181936638;
        Mon, 01 Apr 2019 22:12:16 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id l184sm20308692pfc.98.2019.04.01.22.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 22:12:15 -0700 (PDT)
Date:   Tue, 2 Apr 2019 06:12:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190402051211.GR4187@dell>
References: <20190318095316.69278-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318095316.69278-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Andy Shevchenko wrote:

> Add an mfd driver for Intel Merrifield Basin Cove PMIC.

Nit: s/mfd/MFD/

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/Kconfig                      |  11 ++
>  drivers/mfd/Makefile                     |   1 +
>  drivers/mfd/intel_soc_pmic_mrfld.c       | 157 +++++++++++++++++++++++
>  include/linux/mfd/intel_soc_pmic_mrfld.h |  81 ++++++++++++
>  4 files changed, 250 insertions(+)
>  create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
>  create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0ce2d8dfc5f1..2adf9d393029 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -572,6 +572,17 @@ config INTEL_SOC_PMIC_CHTDC_TI
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
> index b4569ed7f3f3..1b746bd01ac5 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -234,6 +234,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> +obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
>  
>  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> diff --git a/drivers/mfd/intel_soc_pmic_mrfld.c b/drivers/mfd/intel_soc_pmic_mrfld.c
> new file mode 100644
> index 000000000000..bbee89c0c25b
> --- /dev/null
> +++ b/drivers/mfd/intel_soc_pmic_mrfld.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device access for Basin Cove PMIC
> + *
> + * Copyright (c) 2018, Intel Corporation.
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
> +		.name = "mrfld_bcove_extcon",
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
> +static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,

Prefixing these with regmap is pretty confusing, since this it not
part of the Regmap API.  Better to provide them with local names
instead.

  bcove_ipc_byte_reg_read()

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
> +static int regmap_ipc_byte_reg_write(void *context, unsigned int reg,
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
> +
> +static const struct regmap_config bcove_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.max_register = 0xff,
> +	.reg_write = regmap_ipc_byte_reg_write,
> +	.reg_read = regmap_ipc_byte_reg_read,
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

Although succinct, dragging values from one platform device into
another doesn't sound that neat.  Also, since the ordering of the
devices is critical in this implementation, it also comes across as
fragile.

Any reason why ACPI can't register all of the child devices, or for
the child devices to obtain their IRQ directly from the tables?

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
> index 000000000000..00feed7c2787
> --- /dev/null
> +++ b/include/linux/mfd/intel_soc_pmic_mrfld.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Intel Merrifield Basin Cove PMIC
> + *
> + * Copyright (C) 2018 Intel Corporation. All rights reserved.
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

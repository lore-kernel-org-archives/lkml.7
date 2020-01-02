Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC9AC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF27020866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCROBod9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgABIql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:46:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgABIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:46:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so38428706wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J4BV4xVxmbRJ/r05rBs0QYCjejbH9ewz1c2yLbanQBw=;
        b=BCROBod9j1yy6ajGa+uGcRO+X7a2oqm4ydiMzZwtcBr9thqmJoeDeB8vBmZ8hG0bas
         pRPAAfyxHm4lV8LwRhEx8jE7sUssEq5x7jyXSEWyaeVjbx6ftoR15mx1tVsz9zBJPr7c
         XKAtOPTAmr9rL8LaoS6MAbOmkxPCkurDhm33TvQuGx+C4zXTRjiHvzEgka/uTyIuQRQZ
         4okHxCZsuUbIzRcY+45HcNOTYwAZ9GKO2r45tzSpjwejmSI5KqXeACQ7w61v6Pvkr5HN
         sAcbzQvhK41LfV8r0fmaOsCu/wE88cGOus0huQH7AwGLIQ5s63Vl1ClDEY5SRBvILAPv
         CzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J4BV4xVxmbRJ/r05rBs0QYCjejbH9ewz1c2yLbanQBw=;
        b=b/2uJVVszw6Kq0TAeRgOmP0pidpgRsTXcwSAPbyaL5KxTthHXck9WFUJr2aqPGglNV
         bvEp38Jcw0ybk1E1TwaKb47YpbLmn8V0WwKh6FJjhf59ThAUVz9Y6hgmqhC4I8EGaEJ1
         gqsFNKacUPJlJbhAnCtZyDVWeMu16CpSoKOJX86uq0y4P5hbB/iSXeMlI2UyLXrfAx55
         NnqZShW3+guloinqzu6uViEW3f/AbRKnMep5bbPBKgWh0oZmtnhuGEfmMppET8G139+M
         sg4IWq2igyHR1n4JGNZEV8h/Xk/Ft+Cz5GwHbAZNjSuxuip+Ph0VhNRb/peWNALeOv+Z
         Pgwg==
X-Gm-Message-State: APjAAAW/9FcGWn4fro1ISi02MPd+yKhaqMBB1JZs3kReTPn7nGG/ubC/
        /UApEmxInwSDBEBC76YI3huLGw==
X-Google-Smtp-Source: APXvYqwSDKoiB5ra6drQsoyYVfGcpU9ytlL7NbMzlMJbbOVavFr5G0msLQo7wTmzibB98v+znbhMpQ==
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr83053200wrw.193.1577954798497;
        Thu, 02 Jan 2020 00:46:38 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id g2sm54686011wrw.76.2020.01.02.00.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 00:46:37 -0800 (PST)
Date:   Thu, 2 Jan 2020 08:46:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v6] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20200102084650.GA22390@dell>
References: <20191225014148.19082-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191225014148.19082-1-gene.chen.richtek@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Dec 2019, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Add mfd driver for mt6360 pmic chip include
> Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com
> ---
>  drivers/mfd/Kconfig                |  12 +
>  drivers/mfd/Makefile               |   1 +
>  drivers/mfd/mt6360-core.c          | 426 +++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360-private.h | 217 +++++++++++++++
>  include/linux/mfd/mt6360.h         |  32 +++
>  5 files changed, 688 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c
>  create mode 100644 include/linux/mfd/mt6360-private.h
>  create mode 100644 include/linux/mfd/mt6360.h
> 
> changelogs between v1 & v2
> - include missing header file
> 
> changelogs between v2 & v3
> - add changelogs
> 
> changelogs between v3 & v4
> - fix Kconfig description
> - replace mt6360_pmu_info with mt6360_pmu_data
> - replace probe with probe_new
> - remove unnecessary irq_chip variable
> - remove annotation
> - replace MT6360_MFD_CELL with OF_MFD_CELL
> 
> changelogs between v4 & v5
> - remove unnecessary parse dt function
> - use devm_i2c_new_dummy_device
> - add base-commit message
> 
> changelogs between v5 & v6
> - review return value
> - remove i2c id_table
> - use GPL license v2
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 420900852166..e6df91d55405 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -856,6 +856,18 @@ config MFD_MAX8998
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_MT6360
> +	tristate "Mediatek MT6360 SubPMIC"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C
> +	help
> +	  Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> +	  PMU part includes Charger, Flashlight, RGB LED
> +	  PMIC part includes 2-channel BUCKs and 2-channel LDOs
> +	  LDO part includes 4-channel LDOs
> +
>  config MFD_MT6397
>  	tristate "MediaTek MT6397 PMIC Support"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index aed99f08739f..f5f80d75ee53 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -237,6 +237,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> +obj-$(CONFIG_MFD_MT6360)	+= mt6360-core.o
>  mt6397-objs	:= mt6397-core.o mt6397-irq.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> new file mode 100644
> index 000000000000..f6d43b6dad4e
> --- /dev/null
> +++ b/drivers/mfd/mt6360-core.c
> @@ -0,0 +1,426 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.

No author?

> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/version.h>
> +
> +#include <linux/mfd/mt6360.h>
> +#include <linux/mfd/mt6360-private.h>

[...]

> +#define MT6360_REGMAP_IRQ_REG(_irq_evt)		\
> +	REGMAP_IRQ_REG(_irq_evt, (_irq_evt) / 8, BIT((_irq_evt) % 8))

No need to roll your own macros for this.  I think
REGMAP_IRQ_REG_LINE() is what you're looking for.

> +static const struct regmap_irq mt6360_pmu_irqs[] =  {

	REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),

... etc.

> +	MT6360_REGMAP_IRQ_REG(MT6360_CHG_TREG_EVT),
> +	MT6360_REGMAP_IRQ_REG(MT6360_CHG_AICR_EVT),

[...]

> +	MT6360_REGMAP_IRQ_REG(MT6360_LDO7_PGB_EVT),
> +};

[...]

> diff --git a/include/linux/mfd/mt6360-private.h b/include/linux/mfd/mt6360-private.h
> new file mode 100644
> index 000000000000..d542652f4de0
> --- /dev/null
> +++ b/include/linux/mfd/mt6360-private.h

As there are only appropriately namespaced macros in here, I would
move them to the normal header file and dispose of this one.

> @@ -0,0 +1,217 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#ifndef __MT6360_PRIVATE_H__
> +#define __MT6360_PRIVATE_H__
> +
> +/* PMU register defininition */
> +#define MT6360_PMU_DEV_INFO			(0x00)
> +#define MT6360_PMU_CORE_CTRL1			(0x01)

[...]

> +#define MT6360_PMU_LDO_MASK2			(0xFF)
> +#define MT6360_PMU_MAXREG			(MT6360_PMU_LDO_MASK2)
> +
> +/* MT6360_PMU_IRQ_SET */
> +#define MT6360_PMU_IRQ_REGNUM	(MT6360_PMU_LDO_IRQ2 - MT6360_PMU_CHG_IRQ1 + 1)
> +#define MT6360_IRQ_RETRIG	BIT(2)
> +
> +#define CHIP_VEN_MASK				(0xF0)
> +#define CHIP_VEN_MT6360				(0x50)
> +#define CHIP_REV_MASK				(0x0F)
> +
> +#endif /* __MT6360_PRIVATE_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

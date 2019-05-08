Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4609CC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0641621479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjCs3Hs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEHIga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:36:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42085 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEHIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:36:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so26032510wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ejPFMkOH4nB71JZvtpUtWYEnESDbhR46KwiTRhKlpYY=;
        b=UjCs3Hs1A1TJz4DrCCO/HqxUmNOfQ6FSRZ6sFMN9YJDCePqd/HmwzWjhu7RpcoJwz+
         /JrIpB2YpWQew4DEl2ZtyDTQjS8b/+zlowtBmkd+OIAOQ3YcIle1pp7r2vJu3NmKNc0j
         hVlTGg1hIBxDH6ycl5Hk/z3g0ZOC2iW/6nMd7KkivdoOe+9V0ZxuREZtObMxQE46caxV
         k4SmJQGioYFNyG/icUmOgrVLKM6fCbZq62FFRVi7YLE9GyK7MF2HL0nYaTMrbVyL8epH
         3IUgVewddBCo5bPUl6gEqxyJDSBF1f1gO38Cqgao1xyAVsrS+ReMQk36AoEMtQFXKd3N
         daPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ejPFMkOH4nB71JZvtpUtWYEnESDbhR46KwiTRhKlpYY=;
        b=D30oyXdZkuEmq+ht2nUM610nQT0F97ctpAF0u3wpGUISNXNRgo8D7j+KNz5/zKw59E
         NAfyoyiC3u9NhG9v0cDIto0NnFkNZYeGH9dOkGY+Jaj1diFe2+JDvMITiDsf85mNA628
         Y9FbGU7aR1Ahx30DNpVVZoH5vFPPSg0eL85r1eHGG/B4Mvai4fLROTbJ9kNYs+BuVBbP
         xPAVRNaECxmvsmipuQAmhnpkiQFr3WT3y2dO0L4ge5yI1aLP62S1s6GRQMn5WTc936af
         lMnJX0AWSQyEUWP+GHyFU9jOyfDz89XXgo+RPEsFCZU0Kh8IkHO8/MH74IZZ2+H7GrFC
         PT4g==
X-Gm-Message-State: APjAAAXFRy94Al8WBTEigSIubqjEFGuQ8L9BHECaC/iSAD5eAxXP0EVM
        GptO1IXlDo7eVzSW7yin0mmSog==
X-Google-Smtp-Source: APXvYqwlWje+MSQTBFRqBzBoroHEdoXKAKxsvLDPUcZCTX9f2N+4cHc99gR6xe83PLsRey3KS/pjTw==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr19904084wrn.39.1557304585426;
        Wed, 08 May 2019 01:36:25 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id r9sm7673925wrj.57.2019.05.08.01.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:36:24 -0700 (PDT)
Date:   Wed, 8 May 2019 09:36:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 2/9] mfd: Add ST Multi-Function eXpander (STMFX) core
 driver
Message-ID: <20190508083622.GE3995@dell>
References: <1554794651-6874-1-git-send-email-amelie.delaunay@st.com>
 <1554794651-6874-3-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554794651-6874-3-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Apr 2019, Amelie Delaunay wrote:

> STMicroelectronics Multi-Function eXpander (STMFX) is a slave controller
> using I2C for communication with the main MCU. Main features are:
> - 16 fast GPIOs individually configurable in input/output
> - 8 alternate GPIOs individually configurable in input/output when other
> STMFX functions are not used
> - Main MCU IDD measurement
> - Resistive touchscreen controller
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/mfd/Kconfig       |  13 ++
>  drivers/mfd/Makefile      |   2 +-
>  drivers/mfd/stmfx.c       | 566 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stmfx.h | 123 ++++++++++
>  4 files changed, 703 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mfd/stmfx.c
>  create mode 100644 include/linux/mfd/stmfx.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3443f1a..9783e18 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1907,6 +1907,19 @@ config MFD_STPMIC1
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stpmic1.
>  
> +config MFD_STMFX
> +	tristate "Support for STMicroelectronics Multi-Function eXpander (STMFX)"
> +	depends on I2C
> +	depends on OF || COMPILE_TEST
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Support for the STMicroelectronics Multi-Function eXpander.
> +
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b4569ed7..614eea8 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -246,4 +246,4 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>  obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
>  obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
> -
> +obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
> new file mode 100644
> index 0000000..59f0a03
> --- /dev/null
> +++ b/drivers/mfd/stmfx.c
> @@ -0,0 +1,566 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for STMicroelectronics Multi-Function eXpander (STMFX) core
> + *
> + * Copyright (C) 2019 STMicroelectronics
> + * Author(s): Amelie Delaunay <amelie.delaunay@st.com>.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/stmfx.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>

[...]

> +static int stmfx_chip_init(struct i2c_client *client)
> +{
> +	struct stmfx *stmfx = i2c_get_clientdata(client);
> +	u32 id;
> +	u8 version[2];
> +	int ret;
> +
> +	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (IS_ERR(stmfx->vdd)) {
> +		ret = PTR_ERR(stmfx->vdd);
> +		if (ret != -ENODEV) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&client->dev,
> +					"Can't get VDD regulator:%d\n", ret);
> +			return ret;
> +		}

Any reason you've decided to stick with this 3-layer nested if instead
of going with my suggestion?

> +	} else {
> +		ret = regulator_enable(stmfx->vdd);
> +		if (ret) {
> +			dev_err(&client->dev, "VDD enable failed: %d\n", ret);
> +			return ret;
> +		}
> +	}

[...]

> +#ifdef CONFIG_PM_SLEEP
> +static int stmfx_backup_regs(struct stmfx *stmfx)
> +{
> +	int ret;
> +
> +	ret = regmap_raw_read(stmfx->map, STMFX_REG_SYS_CTRL,
> +			      &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_raw_read(stmfx->map, STMFX_REG_IRQ_OUT_PIN,
> +			      &stmfx->bkp_irqoutpin,
> +			      sizeof(stmfx->bkp_irqoutpin));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int stmfx_restore_regs(struct stmfx *stmfx)
> +{
> +	int ret;
> +
> +	ret = regmap_raw_write(stmfx->map, STMFX_REG_SYS_CTRL,
> +			       &stmfx->bkp_sysctrl, sizeof(stmfx->bkp_sysctrl));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_raw_write(stmfx->map, STMFX_REG_IRQ_OUT_PIN,
> +			       &stmfx->bkp_irqoutpin,
> +			       sizeof(stmfx->bkp_irqoutpin));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_raw_write(stmfx->map, STMFX_REG_IRQ_SRC_EN,
> +			       &stmfx->irq_src, sizeof(stmfx->irq_src));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int stmfx_suspend(struct device *dev)
> +{
> +	struct stmfx *stmfx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = stmfx_backup_regs(stmfx);
> +	if (ret) {
> +		dev_err(stmfx->dev, "Registers backup failure\n");
> +		return ret;
> +	}

This doesn't need to be an extra function.  You're just adding more
lines of code for no real gain in reusability/readability.

> +	if (!IS_ERR(stmfx->vdd)) {
> +		ret = regulator_disable(stmfx->vdd);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stmfx_resume(struct device *dev)
> +{
> +	struct stmfx *stmfx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!IS_ERR(stmfx->vdd)) {
> +		ret = regulator_enable(stmfx->vdd);
> +		if (ret) {
> +			dev_err(stmfx->dev,
> +				"VDD enable failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = stmfx_restore_regs(stmfx);
> +	if (ret) {
> +		dev_err(stmfx->dev, "Registers restoration failure\n");
> +		return ret;
> +	}

This doesn't need to be an extra function.  You're just adding more
lines of code for no real gain in reusability/readability.

> +	return 0;
> +}
> +#endif

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

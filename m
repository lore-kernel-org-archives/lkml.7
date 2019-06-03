Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FE5C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0013B27C95
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3ANaayN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfFCNtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:49:12 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39962 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfFCNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:49:12 -0400
Received: by mail-vs1-f66.google.com with SMTP id c24so11264004vsp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OxSjciJIeWf3o+SF5GIESfQJ9u3Ak5QaiWnoP/UDfw=;
        b=D3ANaayNBuhH/wBYNSILUyMur/W3csqCrpCjuxizfljbqS6mDc16ow8wnPQ1EDiuF4
         cO+TBIsOA9W7/Rh38lUvFso6QrLILL0C/geBpdADlPTF05tiZl2vZyQJUNnyWehVTxWa
         udC0JK7xJOdnHKrqAf5W2XpsyZE/eVoVDafHtgcYOVQZeCJ+gFY0NplwRlt1e5cm21WO
         8dvDCOli++VvBU0hx3ODIw7/jM5eYvRpMvO4g2FdwO6b/sb6N3oNiXE3sJUXNnCjNOnJ
         DVEJFB/sNS+YJ/zFWUeVDgE42eD8WqzPdk5EksmJoPTChQlz4VJlYA1L/YAip4cWZppU
         9jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OxSjciJIeWf3o+SF5GIESfQJ9u3Ak5QaiWnoP/UDfw=;
        b=ENLHM8f3eT4mrpPIOesnsVuuxN4i8QAzlscAM6JryKCBK5viZlLAXDhPT+qRpL/3r1
         LRe8Ivtlfn9oFcJePiEutecWrquDc9vHrLBH8NKE9zAdISElJ0jVoQt00rDX10PFx36Y
         gUdBFE09leERAvRZdrzXo5q/ay/htpEZiVKfqbjQ1xOYwZ08hicDZrs0NgImMkAMqJz5
         M5KLaCU0MAUc0JF6g+BeqyhuE+HNuUW8dfY79baPqevqbhGc17tcYgjlJ2Q/wLXxqG3B
         TyjLz8bW4lBl9O3N/FkvUeRQ7w95kNW/kIfh7JOvELiz0ttyMdgdsPWXLuyjH3WcqmrJ
         wPqw==
X-Gm-Message-State: APjAAAUPi95J7d2uP+bvlwFz1jim3CDXxq6s7WFR0dmZ3H8+vUUjc31b
        0Dv+opKQWjAVdTNmLGT/knLsC0qoH/pINK2Ogi2anQ==
X-Google-Smtp-Source: APXvYqzF5IbIrF28m7F6tBtkO/YRqjksFN0caxOVOMKgPSZT7bPA8JVGtjYyAckcMGz6wF94DBhUck9ocrKWjZw/OdM=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr12829986vsp.35.1559569750880;
 Mon, 03 Jun 2019 06:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <1559208158-468-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1559208158-468-1-git-send-email-orito.takao@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Jun 2019 15:48:34 +0200
Message-ID: <CAPDyKFqeTxqv6W=t_SRgnBnqzjLEpbyW1LR_UkoGC2YfoKJs1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-milbeaut: add Milbeaut SD controller driver
To:     Takao Orito <orito.takao@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com,
        kanematsu.shinji@socionext.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Adrian

On Thu, 30 May 2019 at 11:20, Takao Orito <orito.takao@socionext.com> wrote:
>
> SD Host controller on Milbeaut consists of two controller parts.
> One is core controller F_SDH30, this is similar to sdhci-fujitsu
> controller.
> Another is bridge controller.
> This bridge controller is not compatible with sdhci-fujitsu controller.
> This is special for Milbeaut series. This has some functions.
> For example, reset control, clock enable/select for SDR50/25/12, set
> property of SD physical pins, retuning control, set capabilityies.
>
> This bridge controller requires special procedures at reset or clock
> enablement or change for further tuning of clock.
>
> Signed-off-by: Takao Orito <orito.takao@socionext.com>

This looks good to me, however I have looped in Adrian who maintains
SDHCI drivers, to allow him to provide some input.

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig          |  11 ++
>  drivers/mmc/host/Makefile         |   1 +
>  drivers/mmc/host/sdhci-milbeaut.c | 362 ++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci_f_sdh30.c  |  26 +--
>  drivers/mmc/host/sdhci_f_sdh30.h  |  32 ++++
>  5 files changed, 407 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-milbeaut.c
>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 28fcd8f..9b39111 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -353,6 +353,17 @@ config MMC_SDHCI_F_SDH30
>
>           If unsure, say N.
>
> +config MMC_SDHCI_MILBEAUT
> +       tristate "SDHCI support for Socionext Milbeaut Serieas using F_SDH30"
> +       depends on MMC_SDHCI_PLTFM
> +       depends on OF
> +       help
> +         This selects the Secure Digital Host Controller Interface (SDHCI)
> +         Needed by Milbeaut SoC for MMC / SD / SDIO support.
> +         If you have a controller with this interface, say Y or M here.
> +
> +         If unsure, say N.
> +
>  config MMC_SDHCI_IPROC
>         tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
>         depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 7357871..db98e8a 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_MMC_SDHCI_PXAV2) += sdhci-pxav2.o
>  obj-$(CONFIG_MMC_SDHCI_S3C)    += sdhci-s3c.o
>  obj-$(CONFIG_MMC_SDHCI_SIRF)           += sdhci-sirf.o
>  obj-$(CONFIG_MMC_SDHCI_F_SDH30)        += sdhci_f_sdh30.o
> +obj-$(CONFIG_MMC_SDHCI_MILBEAUT)       += sdhci-milbeaut.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)  += sdhci-spear.o
>  obj-$(CONFIG_MMC_SDHCI_AM654)  += sdhci_am654.o
>  obj-$(CONFIG_MMC_WBSD)         += wbsd.o
> diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
> new file mode 100644
> index 0000000..a1aa21b
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-milbeaut.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2013 - 2015 Fujitsu Semiconductor, Ltd
> + *              Vincent Yang <vincent.yang@tw.fujitsu.com>
> + * Copyright (C) 2015 Linaro Ltd  Andy Green <andy.green@linaro.org>
> + * Copyright (C) 2019 Socionext Inc.
> + *              Takao Orito <orito.takao@socionext.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +
> +#include "sdhci-pltfm.h"
> +#include "sdhci_f_sdh30.h"
> +
> +/* milbeaut bridge controller register */
> +#define MLB_SOFT_RESET         0x0200
> +#define  MLB_SOFT_RESET_RSTX           BIT(0)
> +
> +#define MLB_WP_CD_LED_SET      0x0210
> +#define  MLB_WP_CD_LED_SET_LED_INV  BIT(2)
> +
> +#define MLB_CR_SET                     0x0220
> +#define  MLB_CR_SET_CR_TOCLKUNIT       BIT(24)
> +#define  MLB_CR_SET_CR_TOCLKFREQ_SFT   (16)
> +#define  MLB_CR_SET_CR_TOCLKFREQ_MASK  (0x3F << MLB_CR_SET_CR_TOCLKFREQ_SFT)
> +#define  MLB_CR_SET_CR_BCLKFREQ_SFT    (8)
> +#define  MLB_CR_SET_CR_BCLKFREQ_MASK   (0xFF << MLB_CR_SET_CR_BCLKFREQ_SFT)
> +#define  MLB_CR_SET_CR_RTUNTIMER_SFT   (4)
> +#define  MLB_CR_SET_CR_RTUNTIMER_MASK  (0xF << MLB_CR_SET_CR_RTUNTIMER_SFT)
> +
> +#define MLB_SD_TOCLK_I_DIV  16
> +#define MLB_TOCLKFREQ_UNIT_THRES    16000000
> +#define MLB_CAL_TOCLKFREQ_MHZ(rate) (rate / MLB_SD_TOCLK_I_DIV / 1000000)
> +#define MLB_CAL_TOCLKFREQ_KHZ(rate) (rate / MLB_SD_TOCLK_I_DIV / 1000)
> +#define MLB_TOCLKFREQ_MAX   63
> +#define MLB_TOCLKFREQ_MIN    1
> +
> +#define MLB_SD_BCLK_I_DIV   4
> +#define MLB_CAL_BCLKFREQ(rate)  (rate / MLB_SD_BCLK_I_DIV / 1000000)
> +#define MLB_BCLKFREQ_MAX        255
> +#define MLB_BCLKFREQ_MIN          1
> +
> +#define MLB_CDR_SET                    0x0230
> +#define MLB_CDR_SET_CLK2POW16  3
> +
> +struct f_sdhost_priv {
> +       struct clk *clk_iface;
> +       struct clk *clk;
> +       struct device *dev;
> +       bool enable_cmd_dat_delay;
> +};
> +
> +static void sdhci_milbeaut_soft_voltage_switch(struct sdhci_host *host)
> +{
> +       u32 ctrl = 0;
> +
> +       usleep_range(2500, 3000);
> +       ctrl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
> +       ctrl |= F_SDH30_CRES_O_DN;
> +       sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
> +       ctrl |= F_SDH30_MSEL_O_1_8;
> +       sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
> +
> +       ctrl &= ~F_SDH30_CRES_O_DN;
> +       sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
> +       usleep_range(2500, 3000);
> +
> +       ctrl = sdhci_readl(host, F_SDH30_TUNING_SETTING);
> +       ctrl |= F_SDH30_CMD_CHK_DIS;
> +       sdhci_writel(host, ctrl, F_SDH30_TUNING_SETTING);
> +}
> +
> +static unsigned int sdhci_milbeaut_get_min_clock(struct sdhci_host *host)
> +{
> +       return F_SDH30_MIN_CLOCK;
> +}
> +
> +static void sdhci_milbeaut_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       u16 clk;
> +       u32 ctl;
> +       ktime_t timeout;
> +
> +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clk = (clk & ~SDHCI_CLOCK_CARD_EN) | SDHCI_CLOCK_INT_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       sdhci_reset(host, mask);
> +
> +       clk |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       timeout = ktime_add_ms(ktime_get(), 10);
> +       while (1) {
> +               bool timedout = ktime_after(ktime_get(), timeout);
> +
> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clk & SDHCI_CLOCK_INT_STABLE)
> +                       break;
> +               if (timedout) {
> +                       pr_err("%s: Internal clock never stabilised.\n",
> +                               mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       return;
> +               }
> +               udelay(10);
> +       }
> +
> +       if (priv->enable_cmd_dat_delay) {
> +               ctl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
> +               ctl |= F_SDH30_CMD_DAT_DELAY;
> +               sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
> +       }
> +}
> +
> +static void sdhci_milbeaut_set_power(struct sdhci_host *host,
> +                       unsigned char mode, unsigned short vdd)
> +{
> +       if (!IS_ERR(host->mmc->supply.vmmc)) {
> +               struct mmc_host *mmc = host->mmc;
> +
> +               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +       }
> +       sdhci_set_power_noreg(host, mode, vdd);
> +}
> +
> +static const struct sdhci_ops sdhci_milbeaut_ops = {
> +       .voltage_switch = sdhci_milbeaut_soft_voltage_switch,
> +       .get_min_clock = sdhci_milbeaut_get_min_clock,
> +       .reset = sdhci_milbeaut_reset,
> +       .set_clock = sdhci_set_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
> +       .set_power = sdhci_milbeaut_set_power,
> +};
> +
> +static void sdhci_milbeaut_bridge_reset(struct sdhci_host *host,
> +                                               int reset_flag)
> +{
> +       if (reset_flag)
> +               sdhci_writel(host, 0, MLB_SOFT_RESET);
> +       else
> +               sdhci_writel(host, MLB_SOFT_RESET_RSTX, MLB_SOFT_RESET);
> +}
> +
> +static void sdhci_milbeaut_bridge_init(struct sdhci_host *host,
> +                                               int rate)
> +{
> +       u32 val, clk;
> +
> +       /* IO_SDIO_CR_SET should be set while reset */
> +       val = sdhci_readl(host, MLB_CR_SET);
> +       val &= ~(MLB_CR_SET_CR_TOCLKFREQ_MASK | MLB_CR_SET_CR_TOCLKUNIT |
> +                       MLB_CR_SET_CR_BCLKFREQ_MASK);
> +       if (rate >= MLB_TOCLKFREQ_UNIT_THRES) {
> +               clk = MLB_CAL_TOCLKFREQ_MHZ(rate);
> +               clk = min_t(u32, MLB_TOCLKFREQ_MAX, clk);
> +               val |= MLB_CR_SET_CR_TOCLKUNIT |
> +                       (clk << MLB_CR_SET_CR_TOCLKFREQ_SFT);
> +       } else {
> +               clk = MLB_CAL_TOCLKFREQ_KHZ(rate);
> +               clk = min_t(u32, MLB_TOCLKFREQ_MAX, clk);
> +               clk = max_t(u32, MLB_TOCLKFREQ_MIN, clk);
> +               val |= clk << MLB_CR_SET_CR_TOCLKFREQ_SFT;
> +       }
> +
> +       clk = MLB_CAL_BCLKFREQ(rate);
> +       clk = min_t(u32, MLB_BCLKFREQ_MAX, clk);
> +       clk = max_t(u32, MLB_BCLKFREQ_MIN, clk);
> +       val |=  clk << MLB_CR_SET_CR_BCLKFREQ_SFT;
> +       val &= ~MLB_CR_SET_CR_RTUNTIMER_MASK;
> +       sdhci_writel(host, val, MLB_CR_SET);
> +
> +       sdhci_writel(host, MLB_CDR_SET_CLK2POW16, MLB_CDR_SET);
> +
> +       sdhci_writel(host, MLB_WP_CD_LED_SET_LED_INV, MLB_WP_CD_LED_SET);
> +}
> +
> +static void sdhci_milbeaut_vendor_init(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       u32 ctl;
> +
> +       ctl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
> +       ctl |= F_SDH30_CRES_O_DN;
> +       sdhci_writel(host, ctl, F_SDH30_IO_CONTROL2);
> +       ctl &= ~F_SDH30_MSEL_O_1_8;
> +       sdhci_writel(host, ctl, F_SDH30_IO_CONTROL2);
> +       ctl &= ~F_SDH30_CRES_O_DN;
> +       sdhci_writel(host, ctl, F_SDH30_IO_CONTROL2);
> +
> +       ctl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
> +       ctl |= F_SDH30_SIN | F_SDH30_AHB_INCR_16 | F_SDH30_AHB_INCR_8 |
> +              F_SDH30_AHB_INCR_4;
> +       ctl &= ~(F_SDH30_AHB_BIGED | F_SDH30_BUSLOCK_EN);
> +       sdhci_writew(host, ctl, F_SDH30_AHB_CONFIG);
> +
> +       if (priv->enable_cmd_dat_delay) {
> +               ctl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
> +               ctl |= F_SDH30_CMD_DAT_DELAY;
> +               sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
> +       }
> +}
> +
> +static const struct of_device_id mlb_dt_ids[] = {
> +       {
> +               .compatible = "socionext,milbeaut-m10v-sdhci-3.0",
> +       },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mlb_dt_ids);
> +
> +static void sdhci_milbeaut_init(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       int rate = clk_get_rate(priv->clk);
> +       u16 ctl;
> +
> +       sdhci_milbeaut_bridge_reset(host, 0);
> +
> +       ctl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       ctl &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
> +       sdhci_writew(host, ctl, SDHCI_CLOCK_CONTROL);
> +
> +       sdhci_milbeaut_bridge_reset(host, 1);
> +
> +       sdhci_milbeaut_bridge_init(host, rate);
> +       sdhci_milbeaut_bridge_reset(host, 0);
> +
> +       sdhci_milbeaut_vendor_init(host);
> +}
> +
> +static int sdhci_milbeaut_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       int irq, ret = 0;
> +       struct f_sdhost_priv *priv;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(dev, "%s: no irq specified\n", __func__);
> +               return irq;
> +       }
> +
> +       host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       priv = sdhci_priv(host);
> +       priv->dev = dev;
> +
> +       host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +                          SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +                          SDHCI_QUIRK_CLOCK_BEFORE_RESET |
> +                          SDHCI_QUIRK_DELAY_AFTER_POWER;
> +       host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
> +                       SDHCI_QUIRK2_TUNING_WORK_AROUND |
> +                       SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +
> +       priv->enable_cmd_dat_delay = device_property_read_bool(dev,
> +                                               "fujitsu,cmd-dat-delay-select");
> +
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto err;
> +
> +       platform_set_drvdata(pdev, host);
> +
> +       host->hw_name = "f_sdh30";
> +       host->ops = &sdhci_milbeaut_ops;
> +       host->irq = irq;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       host->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(host->ioaddr)) {
> +               ret = PTR_ERR(host->ioaddr);
> +               goto err;
> +       }
> +
> +       if (dev_of_node(dev)) {
> +               sdhci_get_of_property(pdev);
> +
> +               priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
> +               if (IS_ERR(priv->clk_iface)) {
> +                       ret = PTR_ERR(priv->clk_iface);
> +                       goto err;
> +               }
> +
> +               ret = clk_prepare_enable(priv->clk_iface);
> +               if (ret)
> +                       goto err;
> +
> +               priv->clk = devm_clk_get(&pdev->dev, "core");
> +               if (IS_ERR(priv->clk)) {
> +                       ret = PTR_ERR(priv->clk);
> +                       goto err_clk;
> +               }
> +
> +               ret = clk_prepare_enable(priv->clk);
> +               if (ret)
> +                       goto err_clk;
> +       }
> +
> +       sdhci_milbeaut_init(host);
> +
> +       ret = sdhci_add_host(host);
> +       if (ret)
> +               goto err_add_host;
> +
> +       return 0;
> +
> +err_add_host:
> +       clk_disable_unprepare(priv->clk);
> +err_clk:
> +       clk_disable_unprepare(priv->clk_iface);
> +err:
> +       sdhci_free_host(host);
> +       return ret;
> +}
> +
> +static int sdhci_milbeaut_remove(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +
> +       sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
> +                         0xffffffff);
> +
> +       clk_disable_unprepare(priv->clk_iface);
> +       clk_disable_unprepare(priv->clk);
> +
> +       sdhci_free_host(host);
> +       platform_set_drvdata(pdev, NULL);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver sdhci_milbeaut_driver = {
> +       .driver = {
> +               .name = "sdhci-milbeaut",
> +               .of_match_table = of_match_ptr(mlb_dt_ids),
> +       },
> +       .probe  = sdhci_milbeaut_probe,
> +       .remove = sdhci_milbeaut_remove,
> +};
> +
> +module_platform_driver(sdhci_milbeaut_driver);
> +
> +MODULE_DESCRIPTION("MILBEAUT SD Card Controller driver");
> +MODULE_AUTHOR("Takao Orito <orito.takao@socionext.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:sdhci-milbeaut");
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 485f759..ca4c99a 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -19,31 +19,7 @@
>  #include <linux/clk.h>
>
>  #include "sdhci-pltfm.h"
> -
> -/* F_SDH30 extended Controller registers */
> -#define F_SDH30_AHB_CONFIG             0x100
> -#define  F_SDH30_AHB_BIGED             0x00000040
> -#define  F_SDH30_BUSLOCK_DMA           0x00000020
> -#define  F_SDH30_BUSLOCK_EN            0x00000010
> -#define  F_SDH30_SIN                   0x00000008
> -#define  F_SDH30_AHB_INCR_16           0x00000004
> -#define  F_SDH30_AHB_INCR_8            0x00000002
> -#define  F_SDH30_AHB_INCR_4            0x00000001
> -
> -#define F_SDH30_TUNING_SETTING         0x108
> -#define  F_SDH30_CMD_CHK_DIS           0x00010000
> -
> -#define F_SDH30_IO_CONTROL2            0x114
> -#define  F_SDH30_CRES_O_DN             0x00080000
> -#define  F_SDH30_MSEL_O_1_8            0x00040000
> -
> -#define F_SDH30_ESD_CONTROL            0x124
> -#define  F_SDH30_EMMC_RST              0x00000002
> -#define  F_SDH30_EMMC_HS200            0x01000000
> -
> -#define F_SDH30_CMD_DAT_DELAY          0x200
> -
> -#define F_SDH30_MIN_CLOCK              400000
> +#include "sdhci_f_sdh30.h"
>
>  struct f_sdhost_priv {
>         struct clk *clk_iface;
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.h b/drivers/mmc/host/sdhci_f_sdh30.h
> new file mode 100644
> index 0000000..fc1ad28
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci_f_sdh30.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2013 - 2015 Fujitsu Semiconductor, Ltd
> + *              Vincent Yang <vincent.yang@tw.fujitsu.com>
> + * Copyright (C) 2015 Linaro Ltd  Andy Green <andy.green@linaro.org>
> + * Copyright (C) 2019 Socionext Inc.
> + *
> + */
> +
> +/* F_SDH30 extended Controller registers */
> +#define F_SDH30_AHB_CONFIG      0x100
> +#define  F_SDH30_AHB_BIGED      BIT(6)
> +#define  F_SDH30_BUSLOCK_DMA    BIT(5)
> +#define  F_SDH30_BUSLOCK_EN     BIT(4)
> +#define  F_SDH30_SIN            BIT(3)
> +#define  F_SDH30_AHB_INCR_16    BIT(2)
> +#define  F_SDH30_AHB_INCR_8     BIT(1)
> +#define  F_SDH30_AHB_INCR_4     BIT(0)
> +
> +#define F_SDH30_TUNING_SETTING  0x108
> +#define  F_SDH30_CMD_CHK_DIS    BIT(16)
> +
> +#define F_SDH30_IO_CONTROL2     0x114
> +#define  F_SDH30_CRES_O_DN      BIT(19)
> +#define  F_SDH30_MSEL_O_1_8     BIT(18)
> +
> +#define F_SDH30_ESD_CONTROL     0x124
> +#define         F_SDH30_EMMC_RST               BIT(1)
> +#define  F_SDH30_CMD_DAT_DELAY BIT(9)
> +#define         F_SDH30_EMMC_HS200             BIT(24)
> +
> +#define F_SDH30_MIN_CLOCK              400000
> --
> 1.9.1
>
>

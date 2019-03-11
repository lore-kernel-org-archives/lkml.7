Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA83C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E4D20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552331424;
	bh=ZeMOmNSDHkkxSZd7sXZ88BGp6+aaHLPzW7cZtxj6aok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FUK7DcSVxbkIEMcRb9sLwqHA98ooRrvXQvrOouNu9G9Zip5coQo+lgKhQW0mO8ERK
	 Ln+fVhNDcySl81d7AtNYmz5qMSph7JOXOzLy4Il6GJZ1+IVCJNrwxhZRWFqCYIhV92
	 t5HTzd+VV1jhkkk9SF53cgsSvnDY4WPtQNr8VXjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfCKTKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKTKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:10:22 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BDB206BA;
        Mon, 11 Mar 2019 19:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552331420;
        bh=ZeMOmNSDHkkxSZd7sXZ88BGp6+aaHLPzW7cZtxj6aok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tQbbgdwLq+UW+HG4qrJ5c1jgERXIRMx+Lr76mL5hU/Yl27/FbeWNczTuhf66GhePd
         mg0zOEMn6RBpHkfORTAboO/XBdpD0givQ29V9Sw25y5VDrTceQsZesWZD9QYKBVmDc
         sO/DB0bjD3Vk3L2UDFW260lLZjPJU0qYVvt85e+I=
Received: by mail-wr1-f49.google.com with SMTP id i8so130050wrm.0;
        Mon, 11 Mar 2019 12:10:19 -0700 (PDT)
X-Gm-Message-State: APjAAAX/FIC0PeP4BikR+BDrjZjuEoLAukuhASkgDv4dR2Hspc3eXlau
        uREe++WtiriC/hglcF+dI6mee3R2bf3ipi10kgs=
X-Google-Smtp-Source: APXvYqzPVJ3gDzoTVrS30HG8PisphpGG850IvHsKFQNFtzVGpVVBPF5d2RJlsrpr4mzJfLPXgCfRjNpHzRGl5ykbb9Q=
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr20472317wrm.291.1552331418142;
 Mon, 11 Mar 2019 12:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-3-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-3-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 11 Mar 2019 12:10:06 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpJU83t=YUCVQ8KNhSPG_8FUs-vsBN8R5=uSpRgoekhVw@mail.gmail.com>
Message-ID: <CAGp9LzpJU83t=YUCVQ8KNhSPG_8FUs-vsBN8R5=uSpRgoekhVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] mfd: mt6397: extract irq related code from core driver
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would expect the patch just a migration patch that just moves the
code and should not add something changed or something new in the
patch.
but a new mt6397_irq_pm_notifier is being added into mt6397-irq.c so I
guessed the patch is needed to be refined and split into several
patches on advance if required.

          Sean

On Sun, Mar 10, 2019 at 8:49 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> In order to support different types of irq design, we decide to add
> separate irq drivers for different design and keep mt6397 mfd core
> simple and reusable to all generations of PMICs so far.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/Makefile            |   2 +-
>  drivers/mfd/mt6397-core.c       | 228 ++++++----------------------------------
>  drivers/mfd/mt6397-irq.c        | 214 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h |  12 +++
>  4 files changed, 259 insertions(+), 197 deletions(-)
>  create mode 100644 drivers/mfd/mt6397-irq.c
>
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4..088e249 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -230,7 +230,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)        += intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)     += intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)     += intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)  += intel_soc_pmic_chtdc_ti.o
> -obj-$(CONFIG_MFD_MT6397)       += mt6397-core.o
> +obj-$(CONFIG_MFD_MT6397)       += mt6397-core.o mt6397-irq.o
>
>  obj-$(CONFIG_MFD_ALTERA_A10SR) += altera-a10sr.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)  += sun4i-gpadc.o
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index acb9812..53f1edc 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -12,7 +12,6 @@
>   * GNU General Public License for more details.
>   */
>
> -#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> @@ -26,10 +25,6 @@
>  #define MT6397_RTC_BASE                0xe000
>  #define MT6397_RTC_SIZE                0x3e
>
> -#define MT6323_CHIP_ID         0x23
> -#define MT6391_CHIP_ID         0x91
> -#define MT6397_CHIP_ID         0x97
> -
>  static const struct resource mt6397_rtc_resources[] = {
>         {
>                 .start = MT6397_RTC_BASE,
> @@ -94,182 +89,24 @@
>         }
>  };
>
> -static void mt6397_irq_lock(struct irq_data *data)
> -{
> -       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> -
> -       mutex_lock(&mt6397->irqlock);
> -}
> -
> -static void mt6397_irq_sync_unlock(struct irq_data *data)
> -{
> -       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> -
> -       regmap_write(mt6397->regmap, mt6397->int_con[0],
> -                    mt6397->irq_masks_cur[0]);
> -       regmap_write(mt6397->regmap, mt6397->int_con[1],
> -                    mt6397->irq_masks_cur[1]);
> -
> -       mutex_unlock(&mt6397->irqlock);
> -}
> -
> -static void mt6397_irq_disable(struct irq_data *data)
> -{
> -       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> -       int shift = data->hwirq & 0xf;
> -       int reg = data->hwirq >> 4;
> -
> -       mt6397->irq_masks_cur[reg] &= ~BIT(shift);
> -}
> -
> -static void mt6397_irq_enable(struct irq_data *data)
> -{
> -       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> -       int shift = data->hwirq & 0xf;
> -       int reg = data->hwirq >> 4;
> -
> -       mt6397->irq_masks_cur[reg] |= BIT(shift);
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
> -{
> -       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(irq_data);
> -       int shift = irq_data->hwirq & 0xf;
> -       int reg = irq_data->hwirq >> 4;
> -
> -       if (on)
> -               mt6397->wake_mask[reg] |= BIT(shift);
> -       else
> -               mt6397->wake_mask[reg] &= ~BIT(shift);
> -
> -       return 0;
> -}
> -#else
> -#define mt6397_irq_set_wake NULL
> -#endif
> -
> -static struct irq_chip mt6397_irq_chip = {
> -       .name = "mt6397-irq",
> -       .irq_bus_lock = mt6397_irq_lock,
> -       .irq_bus_sync_unlock = mt6397_irq_sync_unlock,
> -       .irq_enable = mt6397_irq_enable,
> -       .irq_disable = mt6397_irq_disable,
> -       .irq_set_wake = mt6397_irq_set_wake,
> +struct chip_data {
> +       u32 cid_addr;
>  };
>
> -static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
> -               int irqbase)
> -{
> -       unsigned int status;
> -       int i, irq, ret;
> -
> -       ret = regmap_read(mt6397->regmap, reg, &status);
> -       if (ret) {
> -               dev_err(mt6397->dev, "Failed to read irq status: %d\n", ret);
> -               return;
> -       }
> -
> -       for (i = 0; i < 16; i++) {
> -               if (status & BIT(i)) {
> -                       irq = irq_find_mapping(mt6397->irq_domain, irqbase + i);
> -                       if (irq)
> -                               handle_nested_irq(irq);
> -               }
> -       }
> -
> -       regmap_write(mt6397->regmap, reg, status);
> -}
> -
> -static irqreturn_t mt6397_irq_thread(int irq, void *data)
> -{
> -       struct mt6397_chip *mt6397 = data;
> -
> -       mt6397_irq_handle_reg(mt6397, mt6397->int_status[0], 0);
> -       mt6397_irq_handle_reg(mt6397, mt6397->int_status[1], 16);
> -
> -       return IRQ_HANDLED;
> -}
> -
> -static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
> -                                       irq_hw_number_t hw)
> -{
> -       struct mt6397_chip *mt6397 = d->host_data;
> -
> -       irq_set_chip_data(irq, mt6397);
> -       irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
> -       irq_set_nested_thread(irq, 1);
> -       irq_set_noprobe(irq);
> -
> -       return 0;
> -}
> -
> -static const struct irq_domain_ops mt6397_irq_domain_ops = {
> -       .map = mt6397_irq_domain_map,
> +static const struct chip_data mt6323_core = {
> +       .cid_addr = MT6323_CID,
>  };
>
> -static int mt6397_irq_init(struct mt6397_chip *mt6397)
> -{
> -       int ret;
> -
> -       mutex_init(&mt6397->irqlock);
> -
> -       /* Mask all interrupt sources */
> -       regmap_write(mt6397->regmap, mt6397->int_con[0], 0x0);
> -       regmap_write(mt6397->regmap, mt6397->int_con[1], 0x0);
> -
> -       mt6397->irq_domain = irq_domain_add_linear(mt6397->dev->of_node,
> -               MT6397_IRQ_NR, &mt6397_irq_domain_ops, mt6397);
> -       if (!mt6397->irq_domain) {
> -               dev_err(mt6397->dev, "could not create irq domain\n");
> -               return -ENOMEM;
> -       }
> -
> -       ret = devm_request_threaded_irq(mt6397->dev, mt6397->irq, NULL,
> -               mt6397_irq_thread, IRQF_ONESHOT, "mt6397-pmic", mt6397);
> -       if (ret) {
> -               dev_err(mt6397->dev, "failed to register irq=%d; err: %d\n",
> -                       mt6397->irq, ret);
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int mt6397_irq_suspend(struct device *dev)
> -{
> -       struct mt6397_chip *chip = dev_get_drvdata(dev);
> -
> -       regmap_write(chip->regmap, chip->int_con[0], chip->wake_mask[0]);
> -       regmap_write(chip->regmap, chip->int_con[1], chip->wake_mask[1]);
> -
> -       enable_irq_wake(chip->irq);
> -
> -       return 0;
> -}
> -
> -static int mt6397_irq_resume(struct device *dev)
> -{
> -       struct mt6397_chip *chip = dev_get_drvdata(dev);
> -
> -       regmap_write(chip->regmap, chip->int_con[0], chip->irq_masks_cur[0]);
> -       regmap_write(chip->regmap, chip->int_con[1], chip->irq_masks_cur[1]);
> -
> -       disable_irq_wake(chip->irq);
> -
> -       return 0;
> -}
> -#endif
> -
> -static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
> -                       mt6397_irq_resume);
> +static const struct chip_data mt6397_core = {
> +       .cid_addr = MT6397_CID,
> +};
>
>  static int mt6397_probe(struct platform_device *pdev)
>  {
>         int ret;
>         unsigned int id;
>         struct mt6397_chip *pmic;
> +       const struct chip_data *pmic_core;
>
>         pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
>         if (!pmic)
> @@ -285,28 +122,30 @@ static int mt6397_probe(struct platform_device *pdev)
>         if (!pmic->regmap)
>                 return -ENODEV;
>
> -       platform_set_drvdata(pdev, pmic);
> +       pmic_core = of_device_get_match_data(&pdev->dev);
> +       if (!pmic_core)
> +               return -ENODEV;
>
> -       ret = regmap_read(pmic->regmap, MT6397_CID, &id);
> +       ret = regmap_read(pmic->regmap, pmic_core->cid_addr, &id);
>         if (ret) {
> -               dev_err(pmic->dev, "Failed to read chip id: %d\n", ret);
> +               dev_err(&pdev->dev, "Failed to read chip id: %d\n", ret);
>                 return ret;
>         }
>
> +       pmic->chip_id = id & 0xff;
> +
> +       platform_set_drvdata(pdev, pmic);
> +
>         pmic->irq = platform_get_irq(pdev, 0);
>         if (pmic->irq <= 0)
>                 return pmic->irq;
>
> -       switch (id & 0xff) {
> -       case MT6323_CHIP_ID:
> -               pmic->int_con[0] = MT6323_INT_CON0;
> -               pmic->int_con[1] = MT6323_INT_CON1;
> -               pmic->int_status[0] = MT6323_INT_STATUS0;
> -               pmic->int_status[1] = MT6323_INT_STATUS1;
> -               ret = mt6397_irq_init(pmic);
> -               if (ret)
> -                       return ret;
> +       ret = mt6397_irq_init(pmic);
> +       if (ret)
> +               return ret;
>
> +       switch (pmic->chip_id) {
> +       case MT6323_CHIP_ID:
>                 ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
>                                            ARRAY_SIZE(mt6323_devs), NULL,
>                                            0, pmic->irq_domain);
> @@ -314,21 +153,13 @@ static int mt6397_probe(struct platform_device *pdev)
>
>         case MT6391_CHIP_ID:
>         case MT6397_CHIP_ID:
> -               pmic->int_con[0] = MT6397_INT_CON0;
> -               pmic->int_con[1] = MT6397_INT_CON1;
> -               pmic->int_status[0] = MT6397_INT_STATUS0;
> -               pmic->int_status[1] = MT6397_INT_STATUS1;
> -               ret = mt6397_irq_init(pmic);
> -               if (ret)
> -                       return ret;
> -
>                 ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
>                                            ARRAY_SIZE(mt6397_devs), NULL,
>                                            0, pmic->irq_domain);
>                 break;
>
>         default:
> -               dev_err(&pdev->dev, "unsupported chip: %d\n", id);
> +               dev_err(&pdev->dev, "unsupported chip: %d\n", pmic->chip_id);
>                 ret = -ENODEV;
>                 break;
>         }
> @@ -342,9 +173,15 @@ static int mt6397_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id mt6397_of_match[] = {
> -       { .compatible = "mediatek,mt6397" },
> -       { .compatible = "mediatek,mt6323" },
> -       { }
> +       {
> +               .compatible = "mediatek,mt6323",
> +               .data = &mt6323_core,
> +       }, {
> +               .compatible = "mediatek,mt6397",
> +               .data = &mt6397_core,
> +       }, {
> +               /* sentinel */
> +       }
>  };
>  MODULE_DEVICE_TABLE(of, mt6397_of_match);
>
> @@ -359,7 +196,6 @@ static int mt6397_probe(struct platform_device *pdev)
>         .driver = {
>                 .name = "mt6397",
>                 .of_match_table = of_match_ptr(mt6397_of_match),
> -               .pm = &mt6397_pm_ops,
>         },
>         .id_table = mt6397_id,
>  };
> diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
> new file mode 100644
> index 0000000..669e93d
> --- /dev/null
> +++ b/drivers/mfd/mt6397-irq.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2019 MediaTek Inc.
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/suspend.h>
> +#include <linux/mfd/mt6323/core.h>
> +#include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/registers.h>
> +
> +static void mt6397_irq_lock(struct irq_data *data)
> +{
> +       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> +
> +       mutex_lock(&mt6397->irqlock);
> +}
> +
> +static void mt6397_irq_sync_unlock(struct irq_data *data)
> +{
> +       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> +
> +       regmap_write(mt6397->regmap, mt6397->int_con[0],
> +                    mt6397->irq_masks_cur[0]);
> +       regmap_write(mt6397->regmap, mt6397->int_con[1],
> +                    mt6397->irq_masks_cur[1]);
> +
> +       mutex_unlock(&mt6397->irqlock);
> +}
> +
> +static void mt6397_irq_disable(struct irq_data *data)
> +{
> +       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> +       int shift = data->hwirq & 0xf;
> +       int reg = data->hwirq >> 4;
> +
> +       mt6397->irq_masks_cur[reg] &= ~BIT(shift);
> +}
> +
> +static void mt6397_irq_enable(struct irq_data *data)
> +{
> +       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(data);
> +       int shift = data->hwirq & 0xf;
> +       int reg = data->hwirq >> 4;
> +
> +       mt6397->irq_masks_cur[reg] |= BIT(shift);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
> +{
> +       struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(irq_data);
> +       int shift = irq_data->hwirq & 0xf;
> +       int reg = irq_data->hwirq >> 4;
> +
> +       if (on)
> +               mt6397->wake_mask[reg] |= BIT(shift);
> +       else
> +               mt6397->wake_mask[reg] &= ~BIT(shift);
> +
> +       return 0;
> +}
> +#else
> +#define mt6397_irq_set_wake NULL
> +#endif
> +
> +static struct irq_chip mt6397_irq_chip = {
> +       .name = "mt6397-irq",
> +       .irq_bus_lock = mt6397_irq_lock,
> +       .irq_bus_sync_unlock = mt6397_irq_sync_unlock,
> +       .irq_enable = mt6397_irq_enable,
> +       .irq_disable = mt6397_irq_disable,
> +       .irq_set_wake = mt6397_irq_set_wake,
> +};
> +
> +static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
> +                                 int irqbase)
> +{
> +       unsigned int status;
> +       int i, irq, ret;
> +
> +       ret = regmap_read(mt6397->regmap, reg, &status);
> +       if (ret) {
> +               dev_err(mt6397->dev, "Failed to read irq status: %d\n", ret);
> +               return;
> +       }
> +
> +       for (i = 0; i < 16; i++) {
> +               if (status & BIT(i)) {
> +                       irq = irq_find_mapping(mt6397->irq_domain, irqbase + i);
> +                       if (irq)
> +                               handle_nested_irq(irq);
> +               }
> +       }
> +
> +       regmap_write(mt6397->regmap, reg, status);
> +}
> +
> +static irqreturn_t mt6397_irq_thread(int irq, void *data)
> +{
> +       struct mt6397_chip *mt6397 = data;
> +
> +       mt6397_irq_handle_reg(mt6397, mt6397->int_status[0], 0);
> +       mt6397_irq_handle_reg(mt6397, mt6397->int_status[1], 16);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +                                irq_hw_number_t hw)
> +{
> +       struct mt6397_chip *mt6397 = d->host_data;
> +
> +       irq_set_chip_data(irq, mt6397);
> +       irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
> +       irq_set_nested_thread(irq, 1);
> +       irq_set_noprobe(irq);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops mt6397_irq_domain_ops = {
> +       .map = mt6397_irq_domain_map,
> +};
> +
> +static int mt6397_irq_pm_notifier(struct notifier_block *notifier,
> +                                 unsigned long pm_event, void *unused)
> +{
> +       struct mt6397_chip *chip =
> +               container_of(notifier, struct mt6397_chip, pm_nb);
> +
> +       switch (pm_event) {
> +       case PM_SUSPEND_PREPARE:
> +               regmap_write(chip->regmap,
> +                            chip->int_con[0], chip->wake_mask[0]);
> +               regmap_write(chip->regmap,
> +                            chip->int_con[1], chip->wake_mask[1]);
> +               enable_irq_wake(chip->irq);
> +               break;
> +
> +       case PM_POST_SUSPEND:
> +               regmap_write(chip->regmap,
> +                            chip->int_con[0], chip->irq_masks_cur[0]);
> +               regmap_write(chip->regmap,
> +                            chip->int_con[1], chip->irq_masks_cur[1]);
> +               disable_irq_wake(chip->irq);
> +               break;
> +
> +       default:
> +               break;
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
> +int mt6397_irq_init(struct mt6397_chip *chip)
> +{
> +       int ret;
> +
> +       mutex_init(&chip->irqlock);
> +
> +       switch (chip->chip_id) {
> +       case MT6323_CHIP_ID:
> +               chip->int_con[0] = MT6323_INT_CON0;
> +               chip->int_con[1] = MT6323_INT_CON1;
> +               chip->int_status[0] = MT6323_INT_STATUS0;
> +               chip->int_status[1] = MT6323_INT_STATUS1;
> +               break;
> +
> +       case MT6391_CHIP_ID:
> +       case MT6397_CHIP_ID:
> +               chip->int_con[0] = MT6397_INT_CON0;
> +               chip->int_con[1] = MT6397_INT_CON1;
> +               chip->int_status[0] = MT6397_INT_STATUS0;
> +               chip->int_status[1] = MT6397_INT_STATUS1;
> +               break;
> +
> +       default:
> +               dev_err(chip->dev, "unsupported chip: 0x%x\n", chip->chip_id);
> +               return -ENODEV;
> +       }
> +
> +       /* Mask all interrupt sources */
> +       regmap_write(chip->regmap, chip->int_con[0], 0x0);
> +       regmap_write(chip->regmap, chip->int_con[1], 0x0);
> +
> +       chip->pm_nb.notifier_call = mt6397_irq_pm_notifier;
> +       chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
> +                                                MT6397_IRQ_NR,
> +                                                &mt6397_irq_domain_ops,
> +                                                chip);
> +       if (!chip->irq_domain) {
> +               dev_err(chip->dev, "could not create irq domain\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
> +                                       mt6397_irq_thread, IRQF_ONESHOT,
> +                                       "mt6397-pmic", chip);
> +       if (ret) {
> +               dev_err(chip->dev, "failed to register irq=%d; err: %d\n",
> +                       chip->irq, ret);
> +               return ret;
> +       }
> +
> +       register_pm_notifier(&chip->pm_nb);
> +       return 0;
> +}
> diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
> index d678f52..23c8c6a 100644
> --- a/include/linux/mfd/mt6397/core.h
> +++ b/include/linux/mfd/mt6397/core.h
> @@ -15,6 +15,14 @@
>  #ifndef __MFD_MT6397_CORE_H__
>  #define __MFD_MT6397_CORE_H__
>
> +#include <linux/notifier.h>
> +
> +enum chip_id {
> +       MT6323_CHIP_ID = 0x23,
> +       MT6391_CHIP_ID = 0x91,
> +       MT6397_CHIP_ID = 0x97,
> +};
> +
>  enum mt6397_irq_numbers {
>         MT6397_IRQ_SPKL_AB = 0,
>         MT6397_IRQ_SPKR_AB,
> @@ -54,6 +62,7 @@ enum mt6397_irq_numbers {
>  struct mt6397_chip {
>         struct device *dev;
>         struct regmap *regmap;
> +       struct notifier_block pm_nb;
>         int irq;
>         struct irq_domain *irq_domain;
>         struct mutex irqlock;
> @@ -62,6 +71,9 @@ struct mt6397_chip {
>         u16 irq_masks_cache[2];
>         u16 int_con[2];
>         u16 int_status[2];
> +       u16 chip_id;
>  };
>
> +int mt6397_irq_init(struct mt6397_chip *mt6397);
> +
>  #endif /* __MFD_MT6397_CORE_H__ */
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

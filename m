Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD6C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D899E21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R/6MonHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfCOHKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:10:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33108 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfCOHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:10:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id x9so4923309qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1diMq4WJf0sTZ2VyC+cL2Il2XXkfSonBGtuMNRW/+8=;
        b=R/6MonHW4O7YJfXp5dWCg7R66FMAvKglTeuXcOknhZtFLRctmrdma5LW9e8mEOpdhA
         UZ6L3aqiFAMokkAeuhDOx6OraxG5Dp22M8KKdcGEsy6a0rqFxeFEUxJg3i8A76Smt0ob
         usPns/bYxvPTxbh1HKvgmqM9mL8HBYffGUSDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1diMq4WJf0sTZ2VyC+cL2Il2XXkfSonBGtuMNRW/+8=;
        b=U6RYBnYTg0et28KgPqNNAB/s9xAytosJMD2jYEZulnIw30ESPe2NvhBu5CUBiftdXs
         mQPEnVlKn1vadjyVuJpDArCvaNDTpNbeUDO+7jSkmQg4BEDqjKJnZLozZ3n3F0rhQytM
         hTmFiWDZTxQc6qxyXDZfE8uc9gq5SRBv5rMXPfdmzByEhXSbV2rFmSJDODIPNnSKOneq
         WPjBE8JRuraK3ls9af1roINj04/36kvmRM/b8jhOh3sz/gI7kDSktjS8hkrg93BtD+mD
         rwTNDzfgQT0qV2cSGy+B4ye+zoaP59pQpNvK4M3xv5pVb20CYZOHzzHLTh5BDnHooGp6
         jmFQ==
X-Gm-Message-State: APjAAAWjarMVO1nPrlf8SFYN549Ujypr0jma1foWpWQalZ1FZDJrAPZj
        1VbXroWZj1HEuf0K8OjyE7tkDIAoqDo+purpuSwdZw==
X-Google-Smtp-Source: APXvYqzOR1jN6FUEM3x2nKQqfkHOK4ISE3Q5xiuAhhSQT1c0ns+worzITzNwo3ZQyb1HgpomcXHq0mIjZJ1HLZpegfw=
X-Received: by 2002:a37:9682:: with SMTP id y124mr1602034qkd.288.1552633830671;
 Fri, 15 Mar 2019 00:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-6-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-6-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 15 Mar 2019 15:10:19 +0800
Message-ID: <CANMq1KCg9Bm3OQpvfNw5ZiYfzApri_+Byatrtsf8O42W+ZYiXg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mfd: Add support for the MediaTek MT6358 PMIC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        tientzu@chromium.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-rtc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Claire Chang who found some issue with this patch.

On Mon, Mar 11, 2019 at 11:48 AM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> This adds support for the MediaTek MT6358 PMIC. This is a
> multifunction device with the following sub modules:
>
> - Regulator
> - RTC
> - Codec
> - Interrupt
>
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6358 MFD is a child device of the pwrap.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/Makefile                 |    2 +-
>  drivers/mfd/mt6358-irq.c             |  236 +++++
>  drivers/mfd/mt6397-core.c            |   63 +-
>  include/linux/mfd/mt6358/core.h      |  158 +++
>  include/linux/mfd/mt6358/registers.h | 1926 ++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |    3 +
>  6 files changed, 2386 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mfd/mt6358-irq.c
>  create mode 100644 include/linux/mfd/mt6358/core.h
>  create mode 100644 include/linux/mfd/mt6358/registers.h
>
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 088e249..50be021 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -230,7 +230,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)        += intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)     += intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)     += intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)  += intel_soc_pmic_chtdc_ti.o
> -obj-$(CONFIG_MFD_MT6397)       += mt6397-core.o mt6397-irq.o
> +obj-$(CONFIG_MFD_MT6397)       += mt6397-core.o mt6397-irq.o mt6358-irq.o
>
>  obj-$(CONFIG_MFD_ALTERA_A10SR) += altera-a10sr.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)  += sun4i-gpadc.o
> diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
> new file mode 100644
> index 0000000..2941d87
> --- /dev/null
> +++ b/drivers/mfd/mt6358-irq.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2019 MediaTek Inc.
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/mt6358/core.h>
> +#include <linux/mfd/mt6358/registers.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static struct irq_top_t mt6358_ints[] = {
> +       MT6358_TOP_GEN(BUCK),
> +       MT6358_TOP_GEN(LDO),
> +       MT6358_TOP_GEN(PSC),
> +       MT6358_TOP_GEN(SCK),
> +       MT6358_TOP_GEN(BM),
> +       MT6358_TOP_GEN(HK),
> +       MT6358_TOP_GEN(AUD),
> +       MT6358_TOP_GEN(MISC),
> +};
> +
> +static int parsing_hwirq_to_top_group(unsigned int hwirq)
> +{
> +       int top_group;
> +
> +       for (top_group = 1; top_group < ARRAY_SIZE(mt6358_ints); top_group++) {
> +               if (mt6358_ints[top_group].hwirq_base > hwirq) {
> +                       top_group--;
> +                       break;
> +               }
> +       }
> +       return top_group;
> +}
> +
> +static void pmic_irq_enable(struct irq_data *data)
> +{
> +       unsigned int hwirq = irqd_to_hwirq(data);
> +       struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
> +       struct pmic_irq_data *irqd = chip->irq_data;
> +
> +       irqd->enable_hwirq[hwirq] = true;
> +}
> +
> +static void pmic_irq_disable(struct irq_data *data)
> +{
> +       unsigned int hwirq = irqd_to_hwirq(data);
> +       struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
> +       struct pmic_irq_data *irqd = chip->irq_data;
> +
> +       irqd->enable_hwirq[hwirq] = false;
> +}
> +
> +static void pmic_irq_lock(struct irq_data *data)
> +{
> +       struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
> +
> +       mutex_lock(&chip->irqlock);
> +}
> +
> +static void pmic_irq_sync_unlock(struct irq_data *data)
> +{
> +       unsigned int i, top_gp, en_reg, int_regs, shift;
> +       struct mt6397_chip *chip = irq_data_get_irq_chip_data(data);
> +       struct pmic_irq_data *irqd = chip->irq_data;
> +
> +       for (i = 0; i < irqd->num_pmic_irqs; i++) {
> +               if (irqd->enable_hwirq[i] ==
> +                               irqd->cache_hwirq[i])
> +                       continue;
> +
> +               top_gp = parsing_hwirq_to_top_group(i);
> +               int_regs = mt6358_ints[top_gp].num_int_bits / MT6358_REG_WIDTH;
> +               en_reg = mt6358_ints[top_gp].en_reg +
> +                       mt6358_ints[top_gp].en_reg_shift * int_regs;
> +               shift = (i - mt6358_ints[top_gp].hwirq_base) % MT6358_REG_WIDTH;
> +               regmap_update_bits(chip->regmap, en_reg, BIT(shift),
> +                                  irqd->enable_hwirq[i] << shift);
> +               irqd->cache_hwirq[i] = irqd->enable_hwirq[i];
> +       }
> +       mutex_unlock(&chip->irqlock);
> +}
> +
> +static int pmic_irq_set_type(struct irq_data *data, unsigned int type)
> +{
> +       return 0;
> +}
> +
> +static struct irq_chip mt6358_irq_chip = {
> +       .name = "mt6358-irq",
> +       .irq_enable = pmic_irq_enable,
> +       .irq_disable = pmic_irq_disable,
> +       .irq_bus_lock = pmic_irq_lock,
> +       .irq_bus_sync_unlock = pmic_irq_sync_unlock,
> +       .irq_set_type = pmic_irq_set_type,
> +};
> +
> +static void mt6358_irq_sp_handler(struct mt6397_chip *chip,
> +                                 unsigned int top_gp)
> +{
> +       unsigned int sta_reg, irq_status;
> +       unsigned int hwirq, virq;
> +       int ret, i, j;
> +
> +       for (i = 0; i < mt6358_ints[top_gp].num_int_regs; i++) {
> +               sta_reg = mt6358_ints[top_gp].sta_reg +
> +                       mt6358_ints[top_gp].sta_reg_shift * i;
> +               ret = regmap_read(chip->regmap, sta_reg, &irq_status);
> +               if (ret) {
> +                       dev_err(chip->dev,
> +                               "Failed to read irq status: %d\n", ret);
> +                       return;
> +               }
> +
> +               if (!irq_status)
> +                       continue;
> +
> +               for (j = 0; j < MT6358_REG_WIDTH ; j++) {
> +                       if ((irq_status & BIT(j)) == 0)
> +                               continue;
> +                       hwirq = mt6358_ints[top_gp].hwirq_base +
> +                               MT6358_REG_WIDTH * i + j;
> +                       virq = irq_find_mapping(chip->irq_domain, hwirq);
> +                       if (virq)
> +                               handle_nested_irq(virq);
> +               }
> +
> +               regmap_write(chip->regmap, sta_reg, irq_status);
> +       }
> +}
> +
> +static irqreturn_t mt6358_irq_handler(int irq, void *data)
> +{
> +       struct mt6397_chip *chip = data;
> +       struct pmic_irq_data *mt6358_irq_data = chip->irq_data;
> +       unsigned int top_irq_status;
> +       unsigned int i;
> +       int ret;
> +
> +       ret = regmap_read(chip->regmap,
> +                         mt6358_irq_data->top_int_status_reg,
> +                         &top_irq_status);
> +       if (ret) {
> +               dev_err(chip->dev, "Can't read TOP_INT_STATUS ret=%d\n", ret);
> +               return IRQ_NONE;
> +       }
> +
> +       for (i = 0; i < mt6358_irq_data->num_top; i++) {
> +               if (top_irq_status & BIT(mt6358_ints[i].top_offset))
> +                       mt6358_irq_sp_handler(chip, i);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int pmic_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +                              irq_hw_number_t hw)
> +{
> +       struct mt6397_chip *mt6397 = d->host_data;
> +
> +       irq_set_chip_data(irq, mt6397);
> +       irq_set_chip_and_handler(irq, &mt6358_irq_chip, handle_level_irq);
> +       irq_set_nested_thread(irq, 1);
> +       irq_set_noprobe(irq);
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops mt6358_irq_domain_ops = {
> +       .map = pmic_irq_domain_map,
> +       .xlate = irq_domain_xlate_twocell,
> +};
> +
> +int mt6358_irq_init(struct mt6397_chip *chip)
> +{
> +       int i, j, ret;
> +       struct pmic_irq_data *irqd;
> +
> +       irqd = devm_kzalloc(chip->dev, sizeof(struct pmic_irq_data *),
> +                           GFP_KERNEL);
> +       if (!irqd)
> +               return -ENOMEM;
> +
> +       chip->irq_data = irqd;
> +
> +       mutex_init(&chip->irqlock);
> +       irqd->top_int_status_reg = MT6358_TOP_INT_STATUS0;
> +       irqd->num_pmic_irqs = MT6358_IRQ_NR;
> +       irqd->num_top = ARRAY_SIZE(mt6358_ints);
> +
> +       irqd->enable_hwirq = devm_kcalloc(chip->dev,
> +                                         irqd->num_pmic_irqs,
> +                                         sizeof(bool),
> +                                         GFP_KERNEL);
> +       if (!irqd->enable_hwirq)
> +               return -ENOMEM;
> +
> +       irqd->cache_hwirq = devm_kcalloc(chip->dev,
> +                                        irqd->num_pmic_irqs,
> +                                        sizeof(bool),
> +                                        GFP_KERNEL);
> +       if (!irqd->cache_hwirq)
> +               return -ENOMEM;
> +
> +       /* Disable all interrupt for initializing */
> +       for (i = 0; i < irqd->num_top; i++) {
> +               for (j = 0; j < mt6358_ints[i].num_int_regs; j++)
> +                       regmap_write(chip->regmap,
> +                                    mt6358_ints[i].en_reg +
> +                                    mt6358_ints[i].en_reg_shift * j, 0);
> +       }
> +
> +       chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
> +                                                irqd->num_pmic_irqs,
> +                                                &mt6358_irq_domain_ops, chip);
> +       if (!chip->irq_domain) {
> +               dev_err(chip->dev, "could not create irq domain\n");
> +               return -ENODEV;
> +       }
> +
> +       ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
> +                                       mt6358_irq_handler, IRQF_ONESHOT,
> +                                       mt6358_irq_chip.name, chip);
> +       if (ret) {
> +               dev_err(chip->dev, "failed to register irq=%d; err: %d\n",
> +                       chip->irq, ret);
> +               return ret;
> +       }
> +
> +       enable_irq_wake(chip->irq);
> +       return ret;
> +}
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 53f1edc..9ef14f9 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -18,12 +18,36 @@
>  #include <linux/regmap.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/mt6323/core.h>
> +#include <linux/mfd/mt6358/core.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6358/registers.h>
>  #include <linux/mfd/mt6397/registers.h>
>
> +#define MT6358_RTC_BASE                0x0588
> +#define MT6358_RTC_SIZE                0x3c
> +#define MT6358_RTC_WRTGR_OFFSET        0x3a
>  #define MT6397_RTC_BASE                0xe000
>  #define MT6397_RTC_SIZE                0x3e
> +#define MT6397_RTC_WRTGR_OFFSET        0x3c
> +
> +static const struct resource mt6358_rtc_resources[] = {
> +       {
> +               .start = MT6358_RTC_BASE,
> +               .end   = MT6358_RTC_BASE + MT6358_RTC_SIZE,
> +               .flags = IORESOURCE_MEM,
> +       },
> +       {
> +               .start = MT6358_IRQ_RTC,
> +               .end   = MT6358_IRQ_RTC,
> +               .flags = IORESOURCE_IRQ,
> +       },
> +       {
> +               .start = MT6358_RTC_WRTGR_OFFSET,
> +               .end   = MT6358_RTC_WRTGR_OFFSET,
> +               .flags = IORESOURCE_REG,
> +       },
> +};
>
>  static const struct resource mt6397_rtc_resources[] = {
>         {
> @@ -36,6 +60,11 @@
>                 .end   = MT6397_IRQ_RTC,
>                 .flags = IORESOURCE_IRQ,
>         },
> +       {
> +               .start = MT6397_RTC_WRTGR_OFFSET,
> +               .end   = MT6397_RTC_WRTGR_OFFSET,
> +               .flags = IORESOURCE_REG,
> +       },
>  };
>
>  static const struct resource mt6323_keys_resources[] = {
> @@ -63,6 +92,21 @@
>         },
>  };
>
> +static const struct mfd_cell mt6358_devs[] = {
> +       {
> +               .name = "mt6358-regulator",
> +               .of_compatible = "mediatek,mt6358-regulator"
> +       }, {
> +               .name = "mt6397-rtc",
> +               .num_resources = ARRAY_SIZE(mt6358_rtc_resources),
> +               .resources = mt6358_rtc_resources,
> +               .of_compatible = "mediatek,mt6358-rtc",
> +       }, {
> +               .name = "mt6358-sound",
> +               .of_compatible = "mediatek,mt6358-sound"
> +       },
> +};
> +
>  static const struct mfd_cell mt6397_devs[] = {
>         {
>                 .name = "mt6397-rtc",
> @@ -97,6 +141,10 @@ struct chip_data {
>         .cid_addr = MT6323_CID,
>  };
>
> +static const struct chip_data mt6358_core = {
> +       .cid_addr = MT6358_SWCID,
> +};
> +
>  static const struct chip_data mt6397_core = {
>         .cid_addr = MT6397_CID,
>  };
> @@ -140,7 +188,11 @@ static int mt6397_probe(struct platform_device *pdev)
>         if (pmic->irq <= 0)
>                 return pmic->irq;
>
> -       ret = mt6397_irq_init(pmic);
> +       if (pmic->chip_id == MT6358_CHIP_ID)
> +               ret = mt6358_irq_init(pmic);
> +       else
> +               ret = mt6397_irq_init(pmic);
> +
>         if (ret)
>                 return ret;
>
> @@ -151,6 +203,12 @@ static int mt6397_probe(struct platform_device *pdev)
>                                            0, pmic->irq_domain);
>                 break;
>
> +       case MT6358_CHIP_ID:
> +               ret = devm_mfd_add_devices(&pdev->dev, -1, mt6358_devs,
> +                                          ARRAY_SIZE(mt6358_devs), NULL,
> +                                          0, pmic->irq_domain);
> +               break;
> +
>         case MT6391_CHIP_ID:
>         case MT6397_CHIP_ID:
>                 ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> @@ -177,6 +235,9 @@ static int mt6397_probe(struct platform_device *pdev)
>                 .compatible = "mediatek,mt6323",
>                 .data = &mt6323_core,
>         }, {
> +               .compatible = "mediatek,mt6358",
> +               .data = &mt6358_core,
> +       }, {
>                 .compatible = "mediatek,mt6397",
>                 .data = &mt6397_core,
>         }, {
> diff --git a/include/linux/mfd/mt6358/core.h b/include/linux/mfd/mt6358/core.h
> new file mode 100644
> index 0000000..ce9e08a
> --- /dev/null
> +++ b/include/linux/mfd/mt6358/core.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +#ifndef __MFD_MT6358_CORE_H__
> +#define __MFD_MT6358_CORE_H__
> +
> +#define MT6358_REG_WIDTH 16
> +
> +struct irq_top_t {
> +       int hwirq_base;
> +       unsigned int num_int_regs;
> +       unsigned int num_int_bits;
> +       unsigned int en_reg;
> +       unsigned int en_reg_shift;
> +       unsigned int sta_reg;
> +       unsigned int sta_reg_shift;
> +       unsigned int top_offset;
> +};
> +
> +struct pmic_irq_data {
> +       unsigned int num_top;
> +       unsigned int num_pmic_irqs;
> +       unsigned short top_int_status_reg;
> +       bool *enable_hwirq;
> +       bool *cache_hwirq;
> +};
> +
> +enum mt6358_irq_top_status_shift {
> +       MT6358_BUCK_TOP = 0,
> +       MT6358_LDO_TOP,
> +       MT6358_PSC_TOP,
> +       MT6358_SCK_TOP,
> +       MT6358_BM_TOP,
> +       MT6358_HK_TOP,
> +       MT6358_AUD_TOP,
> +       MT6358_MISC_TOP,
> +};
> +
> +enum mt6358_irq_numbers {
> +       MT6358_IRQ_VPROC11_OC = 0,
> +       MT6358_IRQ_VPROC12_OC,
> +       MT6358_IRQ_VCORE_OC,
> +       MT6358_IRQ_VGPU_OC,
> +       MT6358_IRQ_VMODEM_OC,
> +       MT6358_IRQ_VDRAM1_OC,
> +       MT6358_IRQ_VS1_OC,
> +       MT6358_IRQ_VS2_OC,
> +       MT6358_IRQ_VPA_OC,
> +       MT6358_IRQ_VCORE_PREOC,
> +       MT6358_IRQ_VFE28_OC = 16,
> +       MT6358_IRQ_VXO22_OC,
> +       MT6358_IRQ_VRF18_OC,
> +       MT6358_IRQ_VRF12_OC,
> +       MT6358_IRQ_VEFUSE_OC,
> +       MT6358_IRQ_VCN33_OC,
> +       MT6358_IRQ_VCN28_OC,
> +       MT6358_IRQ_VCN18_OC,
> +       MT6358_IRQ_VCAMA1_OC,
> +       MT6358_IRQ_VCAMA2_OC,
> +       MT6358_IRQ_VCAMD_OC,
> +       MT6358_IRQ_VCAMIO_OC,
> +       MT6358_IRQ_VLDO28_OC,
> +       MT6358_IRQ_VA12_OC,
> +       MT6358_IRQ_VAUX18_OC,
> +       MT6358_IRQ_VAUD28_OC,
> +       MT6358_IRQ_VIO28_OC,
> +       MT6358_IRQ_VIO18_OC,
> +       MT6358_IRQ_VSRAM_PROC11_OC,
> +       MT6358_IRQ_VSRAM_PROC12_OC,
> +       MT6358_IRQ_VSRAM_OTHERS_OC,
> +       MT6358_IRQ_VSRAM_GPU_OC,
> +       MT6358_IRQ_VDRAM2_OC,
> +       MT6358_IRQ_VMC_OC,
> +       MT6358_IRQ_VMCH_OC,
> +       MT6358_IRQ_VEMC_OC,
> +       MT6358_IRQ_VSIM1_OC,
> +       MT6358_IRQ_VSIM2_OC,
> +       MT6358_IRQ_VIBR_OC,
> +       MT6358_IRQ_VUSB_OC,
> +       MT6358_IRQ_VBIF28_OC,
> +       MT6358_IRQ_PWRKEY = 48,
> +       MT6358_IRQ_HOMEKEY,
> +       MT6358_IRQ_PWRKEY_R,
> +       MT6358_IRQ_HOMEKEY_R,
> +       MT6358_IRQ_NI_LBAT_INT,
> +       MT6358_IRQ_CHRDET,
> +       MT6358_IRQ_CHRDET_EDGE,
> +       MT6358_IRQ_VCDT_HV_DET,
> +       MT6358_IRQ_RTC = 64,
> +       MT6358_IRQ_FG_BAT0_H = 80,
> +       MT6358_IRQ_FG_BAT0_L,
> +       MT6358_IRQ_FG_CUR_H,
> +       MT6358_IRQ_FG_CUR_L,
> +       MT6358_IRQ_FG_ZCV,
> +       MT6358_IRQ_FG_BAT1_H,
> +       MT6358_IRQ_FG_BAT1_L,
> +       MT6358_IRQ_FG_N_CHARGE_L,
> +       MT6358_IRQ_FG_IAVG_H,
> +       MT6358_IRQ_FG_IAVG_L,
> +       MT6358_IRQ_FG_TIME_H,
> +       MT6358_IRQ_FG_DISCHARGE,
> +       MT6358_IRQ_FG_CHARGE,
> +       MT6358_IRQ_BATON_LV = 96,
> +       MT6358_IRQ_BATON_HT,
> +       MT6358_IRQ_BATON_BAT_IN,
> +       MT6358_IRQ_BATON_BAT_OUT,
> +       MT6358_IRQ_BIF,
> +       MT6358_IRQ_BAT_H = 112,
> +       MT6358_IRQ_BAT_L,
> +       MT6358_IRQ_BAT2_H,
> +       MT6358_IRQ_BAT2_L,
> +       MT6358_IRQ_BAT_TEMP_H,
> +       MT6358_IRQ_BAT_TEMP_L,
> +       MT6358_IRQ_AUXADC_IMP,
> +       MT6358_IRQ_NAG_C_DLTV,
> +       MT6358_IRQ_AUDIO = 128,
> +       MT6358_IRQ_ACCDET = 133,
> +       MT6358_IRQ_ACCDET_EINT0,
> +       MT6358_IRQ_ACCDET_EINT1,
> +       MT6358_IRQ_SPI_CMD_ALERT = 144,
> +       MT6358_IRQ_NR,
> +};
> +
> +#define MT6358_IRQ_BUCK_BASE MT6358_IRQ_VPROC11_OC
> +#define MT6358_IRQ_LDO_BASE MT6358_IRQ_VFE28_OC
> +#define MT6358_IRQ_PSC_BASE MT6358_IRQ_PWRKEY
> +#define MT6358_IRQ_SCK_BASE MT6358_IRQ_RTC
> +#define MT6358_IRQ_BM_BASE MT6358_IRQ_FG_BAT0_H
> +#define MT6358_IRQ_HK_BASE MT6358_IRQ_BAT_H
> +#define MT6358_IRQ_AUD_BASE MT6358_IRQ_AUDIO
> +#define MT6358_IRQ_MISC_BASE MT6358_IRQ_SPI_CMD_ALERT
> +
> +#define MT6358_IRQ_BUCK_BITS (MT6358_IRQ_VCORE_PREOC - MT6358_IRQ_BUCK_BASE + 1)
> +#define MT6358_IRQ_LDO_BITS (MT6358_IRQ_VBIF28_OC - MT6358_IRQ_LDO_BASE + 1)
> +#define MT6358_IRQ_PSC_BITS (MT6358_IRQ_VCDT_HV_DET - MT6358_IRQ_PSC_BASE + 1)
> +#define MT6358_IRQ_SCK_BITS (MT6358_IRQ_RTC - MT6358_IRQ_SCK_BASE + 1)
> +#define MT6358_IRQ_BM_BITS (MT6358_IRQ_BIF - MT6358_IRQ_BM_BASE + 1)
> +#define MT6358_IRQ_HK_BITS (MT6358_IRQ_NAG_C_DLTV - MT6358_IRQ_HK_BASE + 1)
> +#define MT6358_IRQ_AUD_BITS (MT6358_IRQ_ACCDET_EINT1 - MT6358_IRQ_AUD_BASE + 1)
> +#define MT6358_IRQ_MISC_BITS   \
> +       (MT6358_IRQ_SPI_CMD_ALERT - MT6358_IRQ_MISC_BASE + 1)
> +
> +#define MT6358_TOP_GEN(sp)     \
> +{      \
> +       .hwirq_base = MT6358_IRQ_##sp##_BASE,   \
> +       .num_int_regs = \
> +               (MT6358_IRQ_##sp##_BITS / MT6358_REG_WIDTH) + 1,        \
> +       .num_int_bits = MT6358_IRQ_##sp##_BITS, \
> +       .en_reg = MT6358_##sp##_TOP_INT_CON0,           \
> +       .en_reg_shift = 0x6,    \
> +       .sta_reg = MT6358_##sp##_TOP_INT_STATUS0,               \
> +       .sta_reg_shift = 0x2,   \
> +       .top_offset = MT6358_##sp##_TOP,        \
> +}
> +
> +#endif /* __MFD_MT6358_CORE_H__ */

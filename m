Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD09D20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4b7NnVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCKIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:22:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33559 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfCKIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:22:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id z39so4081916qtz.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+r5jSBU0PvEF+EoRYAnovk2UG54T5z8ivE5G6JkOrY=;
        b=U4b7NnVF07eSZyc6Pm23toTw3/6ivjUVZnVOc9uyaXZXhEKwssDQulPBXGoDNPDndd
         BjDCkoYBvERuAWA3k29D4U+w9pKiasmf4uAWWYJAs/OTmPifVqD1UWZXj8bAfZmjHrqu
         w3+qg7Q+ob0J7/CHVfAROo+dSqDK4BNEMqE40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+r5jSBU0PvEF+EoRYAnovk2UG54T5z8ivE5G6JkOrY=;
        b=GFB+0dCvA62oNPtxMhvgAFdv82IUOWdTTYtY6q1HlFy5tzBjuIk+RCBz7cdFKLsFEb
         yceodz+GwrG8SO9tcwyOu4vC+TpF5Otaj5ynmhVwQ3tditQdcIPI79T70/ihdnUEAUJ+
         djPIHBc6StiAJDgOjYu09N/YJYP0O+1kVPnet3vul3GCDDbwpJbXd2T0fBa5FgIAkgDY
         pFuw7SujNg4ySp/ehxkuXqzn3hEyFE2EKVpeuwyM/fzNXu9TmMBS49SUfC9Pa4IjL3KT
         u/Kp7yNnv1rdwXLgcOmVHPAE+fmpXQJ1V5zYDzkw99m02N7+gkmF42PtRBF4N6HtCguT
         p7rQ==
X-Gm-Message-State: APjAAAVHtAU0Pmc4IPUSn06NtIcU/B0earvCyimWeeEISW4+C7WutTpT
        cUhqSmrVvrBITjJsJ6N9nGqzSiU5ijb64h0ExwgxPHkwe2Q=
X-Google-Smtp-Source: APXvYqzXorQHJB+dO/2gp3fUns0rQbfmQs64q2YZBueFfLPc1sU+K5eIFrMg+Zn/BsBLZ1BY33N5i72CBIB6UBPyVpU=
X-Received: by 2002:ac8:2847:: with SMTP id 7mr24221204qtr.335.1552292536089;
 Mon, 11 Mar 2019 01:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-6-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-6-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 11 Mar 2019 16:22:05 +0800
Message-ID: <CANMq1KDPPuDC4O3W1EjqoLAzfwitx-pqX0Aq8zycomsigcHLFw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mfd: Add support for the MediaTek MT6358 PMIC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
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

I think mka@ already told you that, but I'd rename to something like
get_hwirq_top_group.

> +{
> +       int top_group;
> +

Should we also add this? (I know that MT6358_TOP_GEN(BUCK).hwirq_base
== 0, but nothing really guarantees that.
if (mt6358_ints[0].hwirq_base < hwirq)
   return -1;

> +       for (top_group = 1; top_group < ARRAY_SIZE(mt6358_ints); top_group++) {
> +               if (mt6358_ints[top_group].hwirq_base > hwirq) {
> +                       top_group--;
> +                       break;

More simply:
return top_group-1;

> +               }
> +       }
> +       return top_group;

return -1 on error, and check for errors in the code below. If you
don't do that, you run the risk of accessing some array out of bounds.

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

I think this fits in 80 chars.

> +                       continue;
> +
> +               top_gp = parsing_hwirq_to_top_group(i);

This is quite inefficient: you keep going through mt6358_ints for all
i. Can you just figure out (and remember) which group we are currently
in in this loop?

outside the loop:
top_gp = 0;

here:
while ((top_gp+1) < ARRAY_SIZE(mt6358_ints) && i >=
mt6358_ints[top_gp+1].hwirq_base)
   top_gp++;

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

Why do you need to stub this function out? I think the core will
already check if the irq_chip supports this function or not. I think
you can just leave it as NULL in the struct below.

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
[snip]

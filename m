Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E900CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9BE218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+eztiYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfCUF6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:58:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47059 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfCUF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:58:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so4370885qts.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEHVtVb+d/eLGsCDxKw3Qvt4xZMpxqa0Pw6egvYAp/M=;
        b=i+eztiYc28JatgXPyWwvtOGMiXlXNJpSEWsqqNJxEbmdi9peflo/larj6YFZzxZ0kT
         2it2Lwof6tKzVCxu7XKiD+M/drRWW1x/KdYul9z/St5oFEeYDhBxtzX7wmjzSv5R8FLa
         Fqe1RCbwLVq6gxza2zPN5M3R+qp+AgnWzPHGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEHVtVb+d/eLGsCDxKw3Qvt4xZMpxqa0Pw6egvYAp/M=;
        b=Uv1YOrUoRHH7ssMDAaOrwzq/IZG68ajmh4d0W4rkxtoVIAmamtPOy2eduLDBa5ZUUx
         iai/9RknccL3o78ePRqd+aBIUye5C5/1nk1wZCbha3oLQ8inp2gbmpw7uFFewyZDJ+Og
         +07kCTNxy0+JGLbyxcynlv55u3/v6SRMNl1jBqhKNirMHrdEhR28yAeubI+Gi+x+8h/V
         nmC+Cgx9jLJW32XFO4s07HkwaZ/iheKnnfPTUGetERUZersEpNnU7vFRtko9BhdkBzoz
         0KEnY9uRaY90PPF22HNlLx1RygFSS7obWYsx/duktknVUZtOkZyssd5RAO+GqWXfuFmC
         pPLg==
X-Gm-Message-State: APjAAAWFGVVjUj4dvBf0cqXWhaVW3U9zsKYV701Jx+c6qo4w+w9JXqcZ
        ks7Ct7zTJuIBIhYNwxeHH/ZSWWTwybkH/aKX45yM0Q==
X-Google-Smtp-Source: APXvYqyzJZ1uq5fZnxToQiVCf8OWAXGV+MbWSf0NdnTJeW4r6KnI9dHNStO3jZUvvItD5AODVz7Fj/3KiY9jy1N7lOw=
X-Received: by 2002:aed:35b0:: with SMTP id c45mr1555880qte.144.1553147884942;
 Wed, 20 Mar 2019 22:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190319080140.24055-1-weiyi.lu@mediatek.com> <20190319080140.24055-11-weiyi.lu@mediatek.com>
In-Reply-To: <20190319080140.24055-11-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 21 Mar 2019 13:57:53 +0800
Message-ID: <CANMq1KAU4o1ad+CM09QtPTGey+mzheg3bR4+iDXpcW+znRC9fQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] soc: mediatek: Add multiple step bus protection control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Both MT8183 & MT6765 have more control steps of bus protection
> than previous project. And there add more bus protection registers
> reside at infracfg & smi-common. Also add new APIs for multiple
> step bus protection control with more customize arguments.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Makefile           |  2 +-
>  drivers/soc/mediatek/mtk-scpsys-ext.c   | 99 +++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-scpsys.c       | 24 ++++++
>  include/linux/soc/mediatek/scpsys-ext.h | 39 ++++++++++
>  4 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
>  create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
>
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 64ce5eeaba32..b9dbad6b12f9 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,4 +1,4 @@
>  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
> new file mode 100644
> index 000000000000..f630edb2f65d
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <Owen.Chen@mediatek.com>
> + */
> +#include <linux/ktime.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
> +
> +#define MTK_POLL_DELAY_US   10
> +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
> +
> +static int set_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> +               u32 reg_set, u32 reg_sta, u32 reg_en)
> +{
> +       u32 val;
> +
> +       if (reg_set)
> +               regmap_write(map, reg_set, mask);
> +       else
> +               regmap_update_bits(map, reg_en, mask, mask);
> +
> +       return regmap_read_poll_timeout(map, reg_sta,
> +                       val, (val & ack_mask) == ack_mask,
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int clear_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> +               u32 reg_clr, u32 reg_sta, u32 reg_en)
> +{
> +       u32 val;
> +
> +       if (reg_clr)
> +               regmap_write(map, reg_clr, mask);
> +       else
> +               regmap_update_bits(map, reg_en, mask, 0);
> +
> +       return regmap_read_poll_timeout(map, reg_sta,
> +                       val, !(val & ack_mask),
> +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_STEPS && bp_table[i].mask; i++) {
> +               struct regmap *map;
> +               int ret;
> +
> +               if (bp_table[i].type == IFR_TYPE)
> +                       map = infracfg;
> +               else if (bp_table[i].type == SMI_TYPE)
> +                       map = smi_common;
> +               else
> +                       return -EINVAL;
> +
> +               ret = set_bus_protection(map,
> +                               bp_table[i].mask, bp_table[i].mask,
> +                               bp_table[i].set_ofs, bp_table[i].sta_ofs,
> +                               bp_table[i].en_ofs);
> +
> +               if (ret)
> +                       return ret;

Should you undo the rest of the operations and clear bus protection on
the ones that were already enabled?

> +       }
> +
> +       return 0;
> +}
> +
> +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common)
> +{
> +       int i;
> +
> +       for (i = MAX_STEPS - 1; i >= 0; i--) {

So when you set protection, you stop at the first bp_table[i].mask ==
0, but when you clear it, you call clear_bus_protection for those, as
well. You should just skip over the ones when bp_table[i].mask == 0?

e.g.
if (!bp_table[i].mask)
   continue;

> +               struct regmap *map;
> +               int ret;
> +
> +               if (bp_table[i].type == IFR_TYPE)
> +                       map = infracfg;
> +               else if (bp_table[i].type == SMI_TYPE)
> +                       map = smi_common;
> +               else
> +                       return -EINVAL;
> +
> +               ret = clear_bus_protection(map,
> +                               bp_table[i].mask, bp_table[i].clr_ack_mask,
> +                               bp_table[i].clr_ofs, bp_table[i].sta_ofs,
> +                               bp_table[i].en_ofs);
> +
> +               if (ret)
> +                       return ret;

Similar question, is it ok to just abort? Or should you try to clear
the protection on all others, too?

> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index c6360de4e41e..181bf7bce591 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -12,6 +12,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/soc/mediatek/infracfg.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
>
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> @@ -121,6 +122,7 @@ static const char * const clk_names[] = {
>   * @basic_clk_name: provide the same purpose with field "clk_id"
>   *                  by declaring basic clock prefix name rather than clk_id.
>   * @caps: The flag for active wake-up action.
> + * @bp_table: The mask table for multiple step bus protection.
>   */
>  struct scp_domain_data {
>         const char *name;
> @@ -132,6 +134,7 @@ struct scp_domain_data {
>         enum clk_id clk_id[MAX_CLKS];
>         const char *basic_clk_name[MAX_CLKS];
>         u8 caps;
> +       struct bus_prot bp_table[MAX_STEPS];
>  };
>
>  struct scp;
> @@ -155,6 +158,7 @@ struct scp {
>         struct device *dev;
>         void __iomem *base;
>         struct regmap *infracfg;
> +       struct regmap *smi_common;
>         struct scp_ctrl_reg ctrl_reg;
>         bool bus_prot_reg_update;
>  };
> @@ -291,6 +295,10 @@ static int scpsys_bus_protect_enable(struct scp_domain *scpd)
>                 ret = mtk_infracfg_set_bus_protection(scp->infracfg,
>                                 scpd->data->bus_prot_mask,
>                                 scp->bus_prot_reg_update);
> +       } else if (scpd->data->bp_table[0].mask) {
> +               ret = mtk_scpsys_ext_set_bus_protection(scpd->data->bp_table,
> +                               scp->infracfg,
> +                               scp->smi_common);
>         }
>
>         return ret;
> @@ -305,6 +313,11 @@ static int scpsys_bus_protect_disable(struct scp_domain *scpd)
>                 ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
>                                 scpd->data->bus_prot_mask,
>                                 scp->bus_prot_reg_update);
> +       } else if (scpd->data->bp_table[0].mask) {
> +               ret = mtk_scpsys_ext_clear_bus_protection(
> +                               scpd->data->bp_table,
> +                               scp->infracfg,
> +                               scp->smi_common);
>         }
>
>         return ret;
> @@ -475,6 +488,17 @@ static struct scp *init_scp(struct platform_device *pdev,
>                 return ERR_CAST(scp->infracfg);
>         }
>
> +       scp->smi_common = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                       "smi_comm");
> +
> +       if (scp->smi_common == ERR_PTR(-ENODEV)) {
> +               scp->smi_common = NULL;
> +       } else if (IS_ERR(scp->smi_common)) {
> +               dev_err(&pdev->dev, "Cannot find smi_common controller: %ld\n",
> +                               PTR_ERR(scp->smi_common));
> +               return ERR_CAST(scp->smi_common);
> +       }
> +
>         for (i = 0; i < num; i++) {
>                 struct scp_domain *scpd = &scp->domains[i];
>                 const struct scp_domain_data *data = &scp_domain_data[i];
> diff --git a/include/linux/soc/mediatek/scpsys-ext.h b/include/linux/soc/mediatek/scpsys-ext.h
> new file mode 100644
> index 000000000000..d0ed295c88a7
> --- /dev/null
> +++ b/include/linux/soc/mediatek/scpsys-ext.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_MEDIATEK_SCPSYS_EXT_H
> +#define __SOC_MEDIATEK_SCPSYS_EXT_H
> +
> +#define MAX_STEPS      4
> +
> +#define BUS_PROT(_type, _set_ofs, _clr_ofs,                    \
> +               _en_ofs, _sta_ofs, _mask, _clr_ack_mask) {      \
> +               .type = _type,                                  \
> +               .set_ofs = _set_ofs,                            \
> +               .clr_ofs = _clr_ofs,                            \
> +               .en_ofs = _en_ofs,                              \
> +               .sta_ofs = _sta_ofs,                            \
> +               .mask = _mask,                                  \
> +               .clr_ack_mask = _clr_ack_mask,                  \
> +       }
> +
> +enum regmap_type {

Maybe add INVALID_TYPE = 0, so that you can skip over those when
looping over them, instead of checking if mask is 0?

> +       IFR_TYPE,
> +       SMI_TYPE,
> +       MAX_REGMAP_TYPE,

This is not used, right? Do you really need it?

> +};
> +
> +struct bus_prot {
> +       enum regmap_type type;
> +       u32 set_ofs;
> +       u32 clr_ofs;
> +       u32 en_ofs;
> +       u32 sta_ofs;
> +       u32 mask;
> +       u32 clr_ack_mask;
> +};
> +
> +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common);
> +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> +       struct regmap *infracfg, struct regmap *smi_common);
> +
> +#endif /* __SOC_MEDIATEK_SCPSYS_EXT_H */
> --
> 2.18.0
>

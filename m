Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A333C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066612133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i27JYu2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfB1OLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:11:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34096 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbfB1OLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:11:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so17799257oty.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pw5tRURBEWyhR5TAkwk8AwqHKVXdGazGDxa3l/5xvR4=;
        b=i27JYu2cWh6yvaqELSe1IJ79ML2KOYpPt930naP8dxg/Se9uDwEtMzJb0M/37qbQ/E
         wYoB3ndUd3gfxyVQskpF86b1P6D4wEerFPBWe0IzJIdK1pbjtxd48WYdhFpAJXw31p/f
         G97LbIT7GQKcjYO97oxhWX5Sb914zwE8fxdOAL626JICDYiYlrOxVKyBNxXHTfyT9lW7
         KT5xQtNYc8XgDWeJ2quQ+zk/S7PmQtPG82QV3B34x9qV0k/+8CqSouZWvBqOrrPG1zdq
         jB8eksmfQhDSxFLxFYaSBaQT+HpFWxKchR0uje8T0Pt3VLtsluNbY5EK1WWhJmdYIXR5
         fT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pw5tRURBEWyhR5TAkwk8AwqHKVXdGazGDxa3l/5xvR4=;
        b=nFecEN2TseSztP1pLKBabw2eROy00LuPw7dnwjNh63oAjDLkp7J8uVrzb22EOgZyaF
         6qBd3hK3VPA9m7JqKTc2jQUoO/KS2qNrHX2W8WL+3zJPG90RawpRikD94Pd9NFOBU+MO
         ufJmT/0WyNQA6fdtSMV6tCQ0G7P4r5axakrG+kSBiHJwU0U8q+p+iK8KwIsDNAmwIt0t
         roDEXxDiJU/st9Mmc1AZFmrifHAV7BEKso+FAF4pY5tn8n/OsgdoMxygIneYsmN+ZS8v
         Is87ySUbwQgi9Yafnurn1xzyyO7pbl2WFby3nW7ih42WhK/E8IPvuMq3QM+wJrWc0QoP
         W1oA==
X-Gm-Message-State: AHQUAuZYiMFvzPMViSK6ttts3o/QjIUIHRevqn/IrLcfvY2B8ikn8wgE
        cRu04oEC4kmvOH6z7kc/gii1+8DVakzeZ0m6QvGzLQ==
X-Google-Smtp-Source: AHgI3IaOzQINZ+XYhIDNl5aL/nhv2VDAQWXEIfLXLNzusQ0p/9WLhzCLqvKQTPh0QXlUWaa/YcAR6pJclgfKgqjkjBo=
X-Received: by 2002:a9d:80e:: with SMTP id 14mr5773959oty.108.1551363093873;
 Thu, 28 Feb 2019 06:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20190228134022.32625-1-axel.lin@ingics.com> <20190228134022.32625-8-axel.lin@ingics.com>
In-Reply-To: <20190228134022.32625-8-axel.lin@ingics.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 28 Feb 2019 15:11:22 +0100
Message-ID: <CAMpxmJVYsvPWuxG-vo1LBQUFkQHfCcyTU19G=JvxYi_S0P6gtw@mail.gmail.com>
Subject: Re: [PATCH 07/11] regulator: max77650: Convert to use regulator_set/get_current_limit_regmap
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Ban <James.Ban.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 lut 2019 o 14:41 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a):
>
> Use regulator_set/get_current_limit_regmap helpers to save some code.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/max77650-regulator.c | 74 +++++++++-----------------
>  1 file changed, 25 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/m=
ax77650-regulator.c
> index a1af414db751..31ebf34b01ec 100644
> --- a/drivers/regulator/max77650-regulator.c
> +++ b/drivers/regulator/max77650-regulator.c
> @@ -26,9 +26,6 @@
>  #define MAX77650_REGULATOR_AD_ENABLED          BIT(3)
>
>  #define MAX77650_REGULATOR_CURR_LIM_MASK       GENMASK(7, 6)
> -#define MAX77650_REGULATOR_CURR_LIM_BITS(_reg) \
> -               (((_reg) & MAX77650_REGULATOR_CURR_LIM_MASK) >> 6)
> -#define MAX77650_REGULATOR_CURR_LIM_SHIFT(_val)        ((_val) << 6)
>
>  enum {
>         MAX77650_REGULATOR_ID_LDO =3D 0,
> @@ -82,7 +79,7 @@ static const u32 max77651_sbb1_regulator_volt_table[] =
=3D {
>                 _val =3D MAX77651_REGULATOR_SBB1_SEL_ENC(_val);          =
 \
>         } while (0)
>
> -static const int max77650_current_limit_table[] =3D {
> +static const unsigned int max77650_current_limit_table[] =3D {
>         1000000, 866000, 707000, 500000,
>  };
>
> @@ -220,47 +217,6 @@ static int max77651_regulator_sbb1_set_voltage_sel(s=
truct regulator_dev *rdev,
>         return 0;
>  }
>
> -static int max77650_regulator_get_current_limit(struct regulator_dev *rd=
ev)
> -{
> -       struct max77650_regulator_desc *rdesc;
> -       struct regmap *map;
> -       int val, rv, limit;
> -
> -       rdesc =3D rdev_get_drvdata(rdev);
> -       map =3D rdev_get_regmap(rdev);
> -
> -       rv =3D regmap_read(map, rdesc->regA, &val);
> -       if (rv)
> -               return rv;
> -
> -       limit =3D MAX77650_REGULATOR_CURR_LIM_BITS(val);
> -
> -       return max77650_current_limit_table[limit];
> -}
> -
> -static int max77650_regulator_set_current_limit(struct regulator_dev *rd=
ev,
> -                                               int min_uA, int max_uA)
> -{
> -       struct max77650_regulator_desc *rdesc;
> -       struct regmap *map;
> -       int i, limit;
> -
> -       rdesc =3D rdev_get_drvdata(rdev);
> -       map =3D rdev_get_regmap(rdev);
> -
> -       for (i =3D 0; i < ARRAY_SIZE(max77650_current_limit_table); i++) =
{
> -               limit =3D max77650_current_limit_table[i];
> -
> -               if (limit >=3D min_uA && limit <=3D max_uA) {
> -                       return regmap_update_bits(map, rdesc->regA,
> -                                       MAX77650_REGULATOR_CURR_LIM_MASK,
> -                                       MAX77650_REGULATOR_CURR_LIM_SHIFT=
(i));
> -               }
> -       }
> -
> -       return -EINVAL;
> -}
> -
>  static const struct regulator_ops max77650_regulator_LDO_ops =3D {
>         .is_enabled             =3D max77650_regulator_is_enabled,
>         .enable                 =3D max77650_regulator_enable,
> @@ -280,8 +236,8 @@ static const struct regulator_ops max77650_regulator_=
SBB_ops =3D {
>         .map_voltage            =3D regulator_map_voltage_linear,
>         .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
>         .set_voltage_sel        =3D max77650_regulator_set_voltage_sel,
> -       .get_current_limit      =3D max77650_regulator_get_current_limit,
> -       .set_current_limit      =3D max77650_regulator_set_current_limit,
> +       .get_current_limit      =3D regulator_get_current_limit_regmap,
> +       .set_current_limit      =3D regulator_set_current_limit_regmap,
>         .set_active_discharge   =3D regulator_set_active_discharge_regmap=
,
>  };
>
> @@ -293,8 +249,8 @@ static const struct regulator_ops max77651_SBB1_regul=
ator_ops =3D {
>         .list_voltage           =3D regulator_list_voltage_table,
>         .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
>         .set_voltage_sel        =3D max77651_regulator_sbb1_set_voltage_s=
el,
> -       .get_current_limit      =3D max77650_regulator_get_current_limit,
> -       .set_current_limit      =3D max77650_regulator_set_current_limit,
> +       .get_current_limit      =3D regulator_get_current_limit_regmap,
> +       .set_current_limit      =3D regulator_set_current_limit_regmap,
>         .set_active_discharge   =3D regulator_set_active_discharge_regmap=
,
>  };
>
> @@ -343,6 +299,10 @@ static struct max77650_regulator_desc max77650_SBB0_=
desc =3D {
>                 .enable_time            =3D 100,
>                 .type                   =3D REGULATOR_VOLTAGE,
>                 .owner                  =3D THIS_MODULE,
> +               .csel_reg               =3D MAX77650_REG_CNFG_SBB0_A,
> +               .csel_mask              =3D MAX77650_REGULATOR_CURR_LIM_M=
ASK,
> +               .curr_table             =3D max77650_current_limit_table,
> +               .n_current_limits =3D ARRAY_SIZE(max77650_current_limit_t=
able),
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB0_A,
>         .regB           =3D MAX77650_REG_CNFG_SBB0_B,
> @@ -368,6 +328,10 @@ static struct max77650_regulator_desc max77650_SBB1_=
desc =3D {
>                 .enable_time            =3D 100,
>                 .type                   =3D REGULATOR_VOLTAGE,
>                 .owner                  =3D THIS_MODULE,
> +               .csel_reg               =3D MAX77650_REG_CNFG_SBB1_A,
> +               .csel_mask              =3D MAX77650_REGULATOR_CURR_LIM_M=
ASK,
> +               .curr_table             =3D max77650_current_limit_table,
> +               .n_current_limits =3D ARRAY_SIZE(max77650_current_limit_t=
able),
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB1_A,
>         .regB           =3D MAX77650_REG_CNFG_SBB1_B,
> @@ -392,6 +356,10 @@ static struct max77650_regulator_desc max77651_SBB1_=
desc =3D {
>                 .enable_time            =3D 100,
>                 .type                   =3D REGULATOR_VOLTAGE,
>                 .owner                  =3D THIS_MODULE,
> +               .csel_reg               =3D MAX77650_REG_CNFG_SBB1_A,
> +               .csel_mask              =3D MAX77650_REGULATOR_CURR_LIM_M=
ASK,
> +               .curr_table             =3D max77650_current_limit_table,
> +               .n_current_limits =3D ARRAY_SIZE(max77650_current_limit_t=
able),
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB1_A,
>         .regB           =3D MAX77650_REG_CNFG_SBB1_B,
> @@ -417,6 +385,10 @@ static struct max77650_regulator_desc max77650_SBB2_=
desc =3D {
>                 .enable_time            =3D 100,
>                 .type                   =3D REGULATOR_VOLTAGE,
>                 .owner                  =3D THIS_MODULE,
> +               .csel_reg               =3D MAX77650_REG_CNFG_SBB2_A,
> +               .csel_mask              =3D MAX77650_REGULATOR_CURR_LIM_M=
ASK,
> +               .curr_table             =3D max77650_current_limit_table,
> +               .n_current_limits =3D ARRAY_SIZE(max77650_current_limit_t=
able),
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB2_A,
>         .regB           =3D MAX77650_REG_CNFG_SBB2_B,
> @@ -442,6 +414,10 @@ static struct max77650_regulator_desc max77651_SBB2_=
desc =3D {
>                 .enable_time            =3D 100,
>                 .type                   =3D REGULATOR_VOLTAGE,
>                 .owner                  =3D THIS_MODULE,
> +               .csel_reg               =3D MAX77650_REG_CNFG_SBB2_A,
> +               .csel_mask              =3D MAX77650_REGULATOR_CURR_LIM_M=
ASK,
> +               .curr_table             =3D max77650_current_limit_table,
> +               .n_current_limits =3D ARRAY_SIZE(max77650_current_limit_t=
able),
>         },
>         .regA           =3D MAX77650_REG_CNFG_SBB2_A,
>         .regB           =3D MAX77650_REG_CNFG_SBB2_B,
> --
> 2.17.1
>

Looks good.

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD59C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035502083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WZIoFrNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCYN6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:58:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42368 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:58:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id w139so6989458oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vD7cJUhsmHS/0FPej9VQOW5KdOly/6b6KXEJPGHydiA=;
        b=WZIoFrNcpZVZrxkicMv6g09cJOkOr/DzW+TjLB+3Z+gKD+f+AJ6bGRicfC7xnfZR8w
         uMQqNrerI/gYfGU8OhznfMWlwNh6S3+OlhbyE3adVurwoDBKZh5iZHgOzgpv+gOQC6D8
         NGxVkpnFuKkAs+OVb/8AtqwECZmC7oov+WOiSveuJpjgjWEpGTwPJyDCrbqVR0MXjEGO
         08FaSPQZPgdQMki3p2EKP/z1J4KbLl1XbT0LPbImr+B5fM3Jt9kyjCK3PE9KiKpMiTIr
         0P0W50+1bqCkuju8Lf/kBJOKVah2ICsJb9RhmbfPMp2R2f7GwQyYk8DtoTJGoS4sMrLV
         dY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vD7cJUhsmHS/0FPej9VQOW5KdOly/6b6KXEJPGHydiA=;
        b=dZ/LGz0gPgsdnJqjL4OyOiKWA7/6XRR/FjVVwwlEw6ukocO/DfC/VCw520/TNYeRSq
         EG9NqI9rpf97+ZZ5xKZ5uaU8pi9oKrMqex9p34w0/TgOXpn6Qk0GZZO2TA+djmJfv+Yf
         HuC6wJJViHocD9hZ2u9g+Sx5FLzvCuIZYFz485YC1uOsup26xJeAIrhwY+xAn94NhLcP
         raRO8PzkUm3KEiuIrCfC3VQW9AbMzXD2R5bEsXvSnOwT/jfsrU+qOy5WZcfi1LABGIbO
         NySx3zbxwO814I8VkynYq5ar/n4bd6gFzPGqgo7AOl8uMWALkcpd/J6yArTcOWkDgKCF
         acgw==
X-Gm-Message-State: APjAAAWiVpTYM69HNa6pbI8x19/koQig22v3wLCPoYKUs8HffE/R+Tfh
        kjFuKPteftV4zjEqhn/V264+3JmIFV+HCpTRgyRV2A==
X-Google-Smtp-Source: APXvYqxk5f0Sch6sHVvfy8pY3rNn3bRY9w72Vc/HOeIgoyj/Xy4xC7uZvV2ovBF4UXSchHiLLMNeElUKBlIq11iW32U=
X-Received: by 2002:aca:5843:: with SMTP id m64mr12013814oib.114.1553522313836;
 Mon, 25 Mar 2019 06:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190325135557.3423-1-axel.lin@ingics.com>
In-Reply-To: <20190325135557.3423-1-axel.lin@ingics.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 25 Mar 2019 14:58:22 +0100
Message-ID: <CAMpxmJW0Wpv9eo7hr8z7R7YuT0B10Z-2Wz-KTYnrDpdu3WCTRg@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable
 linear range
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 25 mar 2019 o 14:56 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a):
>
> The pickable linear range is suitable for The MAX77651 SBB1.
> According to MAX77651 TV_SBB1 Code Table:
> Use BIT[1:0] as range selectors.
> Use BIT[5:2] as selectors for each linear range.
>
> The MAX77651 SBB1 supports up to selector 57, selector 58 ~ 63 are RSVD,
> thus set n_voltage to 58.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Bartosz,
> I don't have this h/w, please help to review and test this patch.
> Thanks,
> Axel
>
>  drivers/regulator/max77650-regulator.c | 134 +++++++++----------------
>  1 file changed, 45 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/m=
ax77650-regulator.c
> index 5c4f86c98510..24b4a0a3c3bb 100644
> --- a/drivers/regulator/max77650-regulator.c
> +++ b/drivers/regulator/max77650-regulator.c
> @@ -20,6 +20,8 @@
>
>  #define MAX77650_REGULATOR_V_LDO_MASK          GENMASK(6, 0)
>  #define MAX77650_REGULATOR_V_SBB_MASK          GENMASK(5, 0)
> +#define MAX77651_REGULATOR_V_SBB1_MASK         GENMASK(5, 2)
> +#define MAX77651_REGULATOR_V_SBB1_RANGE_MASK   GENMASK(1, 0)
>
>  #define MAX77650_REGULATOR_AD_MASK             BIT(3)
>  #define MAX77650_REGULATOR_AD_DISABLED         0x00
> @@ -27,6 +29,8 @@
>
>  #define MAX77650_REGULATOR_CURR_LIM_MASK       GENMASK(7, 6)
>
> +static struct max77650_regulator_desc max77651_SBB1_desc;
> +
>  enum {
>         MAX77650_REGULATOR_ID_LDO =3D 0,
>         MAX77650_REGULATOR_ID_SBB0,
> @@ -41,43 +45,20 @@ struct max77650_regulator_desc {
>         unsigned int regB;
>  };
>
> -static const unsigned int max77651_sbb1_regulator_volt_table[] =3D {
> -       2400000, 3200000, 4000000, 4800000,
> -       2450000, 3250000, 4050000, 4850000,
> -       2500000, 3300000, 4100000, 4900000,
> -       2550000, 3350000, 4150000, 4950000,
> -       2600000, 3400000, 4200000, 5000000,
> -       2650000, 3450000, 4250000, 5050000,
> -       2700000, 3500000, 4300000, 5100000,
> -       2750000, 3550000, 4350000, 5150000,
> -       2800000, 3600000, 4400000, 5200000,
> -       2850000, 3650000, 4450000, 5250000,
> -       2900000, 3700000, 4500000,       0,
> -       2950000, 3750000, 4550000,       0,
> -       3000000, 3800000, 4600000,       0,
> -       3050000, 3850000, 4650000,       0,
> -       3100000, 3900000, 4700000,       0,
> -       3150000, 3950000, 4750000,       0,
> +static const unsigned int max77651_sbb1_volt_range_sel[] =3D {
> +       0x0, 0x1, 0x2, 0x3
>  };
>
> -#define MAX77651_REGULATOR_SBB1_SEL_DEC(_val) \
> -               (((_val & 0x3c) >> 2) | ((_val & 0x03) << 4))
> -#define MAX77651_REGULATOR_SBB1_SEL_ENC(_val) \
> -               (((_val & 0x30) >> 4) | ((_val & 0x0f) << 2))
> -
> -#define MAX77650_REGULATOR_SBB1_SEL_DECR(_val)                         \
> -       do {                                                            \
> -               _val =3D MAX77651_REGULATOR_SBB1_SEL_DEC(_val);          =
 \
> -               _val--;                                                 \
> -               _val =3D MAX77651_REGULATOR_SBB1_SEL_ENC(_val);          =
 \
> -       } while (0)
> -
> -#define MAX77650_REGULATOR_SBB1_SEL_INCR(_val)                         \
> -       do {                                                            \
> -               _val =3D MAX77651_REGULATOR_SBB1_SEL_DEC(_val);          =
 \
> -               _val++;                                                 \
> -               _val =3D MAX77651_REGULATOR_SBB1_SEL_ENC(_val);          =
 \
> -       } while (0)
> +static const struct regulator_linear_range max77651_sbb1_volt_ranges[] =
=3D {
> +       /* range index 0 */
> +       REGULATOR_LINEAR_RANGE(2400000, 0x00, 0x0f, 50000),
> +       /* range index 1 */
> +       REGULATOR_LINEAR_RANGE(3200000, 0x00, 0x0f, 50000),
> +       /* range index 2 */
> +       REGULATOR_LINEAR_RANGE(4000000, 0x00, 0x0f, 50000),
> +       /* range index 3 */
> +       REGULATOR_LINEAR_RANGE(4800000, 0x00, 0x09, 50000),
> +};
>
>  static const unsigned int max77650_current_limit_table[] =3D {
>         1000000, 866000, 707000, 500000,
> @@ -130,6 +111,7 @@ static int max77650_regulator_disable(struct regulato=
r_dev *rdev)
>  static int max77650_regulator_set_voltage_sel(struct regulator_dev *rdev=
,
>                                               unsigned int sel)
>  {
> +       struct max77650_regulator_desc *rdesc =3D rdev_get_drvdata(rdev);
>         int rv =3D 0, curr, diff;
>         bool ascending;
>
> @@ -137,15 +119,24 @@ static int max77650_regulator_set_voltage_sel(struc=
t regulator_dev *rdev,
>          * If the regulator is disabled, we can program the desired
>          * voltage right away.
>          */
> -       if (!max77650_regulator_is_enabled(rdev))
> -               return regulator_set_voltage_sel_regmap(rdev, sel);
> +       if (!max77650_regulator_is_enabled(rdev)) {
> +               if (rdesc =3D=3D &max77651_SBB1_desc)
> +                       return regulator_set_voltage_sel_pickable_regmap(=
rdev,
> +                                                                        =
sel);
> +               else
> +                       return regulator_set_voltage_sel_regmap(rdev, sel=
);
> +       }
>
>         /*
>          * Otherwise we need to manually ramp the output voltage up/down
>          * one step at a time.
>          */
>
> -       curr =3D regulator_get_voltage_sel_regmap(rdev);
> +       if (rdesc =3D=3D &max77651_SBB1_desc)
> +               curr =3D regulator_get_voltage_sel_pickable_regmap(rdev);
> +       else
> +               curr =3D regulator_get_voltage_sel_regmap(rdev);
> +
>         if (curr < 0)
>                 return curr;
>
> @@ -162,57 +153,18 @@ static int max77650_regulator_set_voltage_sel(struc=
t regulator_dev *rdev,
>          * the selector equals 0.
>          */
>         for (ascending ? curr++ : curr--;; ascending ? curr++ : curr--) {
> -               rv =3D regulator_set_voltage_sel_regmap(rdev, curr);
> -               if (rv)
> -                       return rv;
> -
> -               if (curr =3D=3D sel)
> -                       break;
> -       }
> -
> -       return 0;
> -}
> -
> -/*
> - * Special case: non-linear voltage table for max77651 SBB1 - software
> - * must ensure the voltage is ramped in 50mV increments.
> - */
> -static int max77651_regulator_sbb1_set_voltage_sel(struct regulator_dev =
*rdev,
> -                                                  unsigned int sel)
> -{
> -       int rv =3D 0, curr, vcurr, vdest, vdiff;
> -
> -       /*
> -        * If the regulator is disabled, we can program the desired
> -        * voltage right away.
> -        */
> -       if (!max77650_regulator_is_enabled(rdev))
> -               return regulator_set_voltage_sel_regmap(rdev, sel);
> -
> -       curr =3D regulator_get_voltage_sel_regmap(rdev);
> -       if (curr < 0)
> -               return curr;
> -
> -       if (curr =3D=3D sel)
> -               return 0; /* Already there. */
> -
> -       vcurr =3D max77651_sbb1_regulator_volt_table[curr];
> -       vdest =3D max77651_sbb1_regulator_volt_table[sel];
> -       vdiff =3D vcurr - vdest;
> -
> -       for (;;) {
> -               if (vdiff > 0)
> -                       MAX77650_REGULATOR_SBB1_SEL_DECR(curr);
> +               if (rdesc =3D=3D &max77651_SBB1_desc)
> +                       rv =3D regulator_set_voltage_sel_pickable_regmap(=
rdev,
> +                                                                      cu=
rr);
>                 else
> -                       MAX77650_REGULATOR_SBB1_SEL_INCR(curr);
> +                       rv =3D regulator_set_voltage_sel_regmap(rdev, cur=
r);
>
> -               rv =3D regulator_set_voltage_sel_regmap(rdev, curr);
>                 if (rv)
>                         return rv;
>
>                 if (curr =3D=3D sel)
>                         break;
> -       };
> +       }
>
>         return 0;
>  }
> @@ -241,14 +193,14 @@ static const struct regulator_ops max77650_regulato=
r_SBB_ops =3D {
>         .set_active_discharge   =3D regulator_set_active_discharge_regmap=
,
>  };
>
> -/* Special case for max77651 SBB1 - non-linear voltage mapping. */
> +/* Special case for max77651 SBB1 - pickable linear-range voltage mappin=
g. */
>  static const struct regulator_ops max77651_SBB1_regulator_ops =3D {
>         .is_enabled             =3D max77650_regulator_is_enabled,
>         .enable                 =3D max77650_regulator_enable,
>         .disable                =3D max77650_regulator_disable,
> -       .list_voltage           =3D regulator_list_voltage_table,
> -       .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
> -       .set_voltage_sel        =3D max77651_regulator_sbb1_set_voltage_s=
el,
> +       .list_voltage           =3D regulator_list_voltage_pickable_linea=
r_range,
> +       .get_voltage_sel        =3D regulator_get_voltage_sel_pickable_re=
gmap,
> +       .set_voltage_sel        =3D max77650_regulator_set_voltage_sel,
>         .get_current_limit      =3D regulator_get_current_limit_regmap,
>         .set_current_limit      =3D regulator_set_current_limit_regmap,
>         .set_active_discharge   =3D regulator_set_active_discharge_regmap=
,
> @@ -345,9 +297,13 @@ static struct max77650_regulator_desc max77651_SBB1_=
desc =3D {
>                 .supply_name            =3D "in-sbb1",
>                 .id                     =3D MAX77650_REGULATOR_ID_SBB1,
>                 .ops                    =3D &max77651_SBB1_regulator_ops,
> -               .volt_table             =3D max77651_sbb1_regulator_volt_=
table,
> -               .n_voltages =3D ARRAY_SIZE(max77651_sbb1_regulator_volt_t=
able),
> -               .vsel_mask              =3D MAX77650_REGULATOR_V_SBB_MASK=
,
> +               .linear_range_selectors =3D max77651_sbb1_volt_range_sel,
> +               .linear_ranges          =3D max77651_sbb1_volt_ranges,
> +               .n_linear_ranges        =3D ARRAY_SIZE(max77651_sbb1_volt=
_ranges),
> +               .n_voltages             =3D 58,
> +               .vsel_range_mask        =3D MAX77651_REGULATOR_V_SBB1_RAN=
GE_MASK,
> +               .vsel_range_reg         =3D MAX77650_REG_CNFG_SBB1_A,
> +               .vsel_mask              =3D MAX77651_REGULATOR_V_SBB1_MAS=
K,
>                 .vsel_reg               =3D MAX77650_REG_CNFG_SBB1_A,
>                 .active_discharge_off   =3D MAX77650_REGULATOR_AD_DISABLE=
D,
>                 .active_discharge_on    =3D MAX77650_REGULATOR_AD_ENABLED=
,
> --
> 2.17.1
>

Oh nice! I didn't know about this feature. I'll test it tomorrow.

Bart

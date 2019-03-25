Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5610C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5820685
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGQlwMT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfCYSZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:25:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36112 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:25:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id y36so11509086qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHd/yOQ4vI7JZ+LktW3pXFi1l+q5YqpUFBZXm47gewQ=;
        b=TGQlwMT5saB7skx4Xax1JDJFegFINr4VkDzVFxSPKTN6q7Gx7+dEKw9V5K7GiIcVpj
         wFcoTjG9zy4acWwLH0zBg6+nuDIYf7D4DK+uuUOhP/r5P8a2ywlG5r8ukXX4pDwvO1Nf
         ubV7l15t39JK7e3k99AbWQw12CG7pF+rOz6Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHd/yOQ4vI7JZ+LktW3pXFi1l+q5YqpUFBZXm47gewQ=;
        b=H9t6eyvvlhTxq6b/aJaNMMwupO2J6pM6JLdTBTtQKcVG0LOBSCRAsqDbQJN09WyWLp
         03iII4sEB2S932nX5gl+bHjQE2rp0wHHvL9QGQB45cR2+Tayvjuo/bP65G0tJ8Y3q2w7
         OnwLQ4+ED6zsVQzwvARA+JlI4RsAJaVj0ZiVtYtfkC3YKZnXWHiVoekizygudSR2r8l3
         kPOV7gAexB8CTGMPlx9WwoF2L94kGA/UQMXXPYp8XWcc5xNQopNKLYpQtwW2UcQcNMPI
         vSX/ko6BExl44nTeWtzG+Mw8RNaCOW8k/WorLW/Bhdck98zI3vKUjK6/QlY03Dl6YDfD
         bvuw==
X-Gm-Message-State: APjAAAUA+ZnR7VkYZMaCOtVzAwEo/FmQK2PlcmYY7OH7miG5yxGPm/Pd
        n1N4YOEZ4sexosmbokptoxcD3E4ZSMHlM1ioMdAh4g==
X-Google-Smtp-Source: APXvYqztHuzQvSJG7cGobCGOghfWOAJ1OvO62iLHNr/9kH1FffeEtC6pFAyMYaAeBOBGm2xDOVJlkAZYRMDGDOCLdlA=
X-Received: by 2002:aed:35f7:: with SMTP id d52mr21534805qte.335.1553538318525;
 Mon, 25 Mar 2019 11:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190325122302.5483-1-zhiyong.tao@mediatek.com> <20190325122302.5483-5-zhiyong.tao@mediatek.com>
In-Reply-To: <20190325122302.5483-5-zhiyong.tao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 25 Mar 2019 11:25:07 -0700
Message-ID: <CANMq1KBwjNxi2fMLFna5r0ak56+8paMq1YbLWHEScTzzLqf+Bw@mail.gmail.com>
Subject: Re: [PATCH 4/4] pinctrl: add drive for I2C related pins on MT8183
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        chuanjia.liu@mediatek.com, biao.huang@mediatek.com,
        hongzhou.yang@mediatek.com, Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:23 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> This patch provides the advanced drive for I2C used pins on MT8183.
> The detail strength specification description of the I2C pin:
> When E1=0/E0=0, the strength is 0.125mA.
> When E1=0/E0=1, the strength is 0.25mA.
> When E1=1/E0=0, the strength is 0.5mA.
> When E1=1/E0=1, the strength is 1mA.
> For I2C pins, there are existing generic driving setup and the above
> specific driving setup. I2C pins can only support 2/4/6/8/10/12/14/16mA
> driving adjustment in generic driving setup. But in specific driving
> setup, they can support 0.125/0.25/0.5/1mA adjustment.
> If we enable specific driving setup for I2C pins,
> the existing generic driving setup will be disabled.
> For some special features, we need the I2C pins specific driving setup.
> The specific driving setup is controlled by E1E0EN.
> So we need add extra vendor driving preperty instead of the generic
> driving property. We can add "mediatek,drive-strength-adv = <XXX>;"
> to describe the specific driving setup property.
> "XXX" means the value of E1E0EN. So the valid arguments of
> "mediatek,drive-strength-adv" are from 0 to 7.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 47 ++++++++++++++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 11 ++++++
>  drivers/pinctrl/mediatek/pinctrl-paris.c         | 12 ++++++
>  4 files changed, 120 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> index 6262fd3678ea..2c7409ed16fa 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> @@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
>         PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
>  };
>
> +static const struct mtk_pin_field_calc mt8183_pin_e1e0en_range[] = {
> +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 20, 1),
> +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 15, 1),
> +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 12, 1),
> +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 7, 1),
> +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 12, 1),
> +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 9, 1),
> +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 19, 1),
> +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 22, 1),
> +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 24, 1),
> +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 14, 1),
> +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 27, 1),
> +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 17, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8183_pin_e0_range[] = {
> +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 21, 1),
> +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 16, 1),
> +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 13, 1),
> +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 8, 1),
> +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 13, 1),
> +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 10, 1),
> +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 20, 1),
> +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 23, 1),
> +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 25, 1),
> +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 15, 1),
> +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 28, 1),
> +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 18, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8183_pin_e1_range[] = {
> +       PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 22, 1),
> +       PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 17, 1),
> +       PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 14, 1),
> +       PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 9, 1),
> +       PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 14, 1),
> +       PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 11, 1),
> +       PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 21, 1),
> +       PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 24, 1),
> +       PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 26, 1),
> +       PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 16, 1),
> +       PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 29, 1),
> +       PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 19, 1),
> +};
> +
>  static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
>         [PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
>         [PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
> @@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
>         [PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
>         [PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
>         [PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
> +       [PINCTRL_PIN_REG_DRV_EN] = MTK_RANGE(mt8183_pin_e1e0en_range),
> +       [PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_e0_range),
> +       [PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_e1_range),
>  };
>
>  static const char * const mt8183_pinctrl_register_base_names[] = {
> @@ -517,6 +565,8 @@ static const struct mtk_pin_soc mt8183_data = {
>         .drive_get = mtk_pinconf_drive_get_rev1,
>         .adv_pull_get = mtk_pinconf_adv_pull_get,
>         .adv_pull_set = mtk_pinconf_adv_pull_set,
> +       .adv_drive_get = mtk_pinconf_adv_drive_get,
> +       .adv_drive_set = mtk_pinconf_adv_drive_set,
>  };
>
>  static const struct of_device_id mt8183_pinctrl_of_match[] = {
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index b1c368455d30..ef8732e8966b 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -674,3 +674,50 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
>
>         return 0;
>  }
> +
> +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, u32 arg)
> +{
> +       int err;
> +
> +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN, arg & 1);

Should 1, 2, 4 masks be defined as masks somewhere above in this file?

> +       if (err)
> +               return err;
> +
> +       if (arg & 1) {

It's the second time you use arg & 1.

Maybe define:
int en = arg & 1;
int e0 = !!(arg & 2);
int e1 = !!(arg & 4);

Also, I feel that the code looks a little cleaner if you just return early here:
if (!(arg & 1))
   return err;

> +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0,
> +                                      !!(arg & 2));
> +               if (err)
> +                       return err;
> +
> +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
> +                                      !!(arg & 4));
> +               if (err)
> +                       return err;
> +       }
> +
> +       return err;
> +}
> +
> +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, u32 *val)

Is there any user for this function? If not, why do we even define it?

> +{
> +       u32 en, e0, e1;
> +       int err;
> +
> +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN, &en);
> +       if (err)
> +               return err;
> +
> +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, &e0);
> +       if (err)
> +               return err;
> +
> +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, &e1);
> +       if (err)
> +               return err;
> +
> +       *val = (e0 | e1 << 1 | en << 2) & 0x7;

I'm confused. Here, e0 is bit 0, e1 is bit 1, end is bit 2. But above
in mtk_pinconf_adv_drive_set, it seems to be in this order: en, e0,
e1?

> +
> +       return 0;
> +}
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> index 6d24522739d9..1b7da42aa1d5 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> @@ -63,6 +63,9 @@ enum {
>         PINCTRL_PIN_REG_IES,
>         PINCTRL_PIN_REG_PULLEN,
>         PINCTRL_PIN_REG_PULLSEL,
> +       PINCTRL_PIN_REG_DRV_EN,
> +       PINCTRL_PIN_REG_DRV_E0,
> +       PINCTRL_PIN_REG_DRV_E1,
>         PINCTRL_PIN_REG_MAX,
>  };
>
> @@ -224,6 +227,10 @@ struct mtk_pin_soc {
>         int (*adv_pull_get)(struct mtk_pinctrl *hw,
>                             const struct mtk_pin_desc *desc, bool pullup,
>                             u32 *val);
> +       int (*adv_drive_set)(struct mtk_pinctrl *hw,
> +                            const struct mtk_pin_desc *desc, u32 arg);
> +       int (*adv_drive_get)(struct mtk_pinctrl *hw,
> +                            const struct mtk_pin_desc *desc, u32 *val);
>
>         /* Specific driver data */
>         void                            *driver_data;
> @@ -287,5 +294,9 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
>  int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
>                              const struct mtk_pin_desc *desc, bool pullup,
>                              u32 *val);
> +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, u32 arg);
> +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, u32 *val);
>
>  #endif /* __PINCTRL_MTK_COMMON_V2_H */
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index b59e10852bfb..dcd295f0eb4b 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -20,12 +20,14 @@
>  #define MTK_PIN_CONFIG_RDSEL   (PIN_CONFIG_END + 2)
>  #define MTK_PIN_CONFIG_PU_ADV  (PIN_CONFIG_END + 3)
>  #define MTK_PIN_CONFIG_PD_ADV  (PIN_CONFIG_END + 4)
> +#define MTK_PIN_CONFIG_DRV_ADV (PIN_CONFIG_END + 5)
>
>  static const struct pinconf_generic_params mtk_custom_bindings[] = {
>         {"mediatek,tdsel",      MTK_PIN_CONFIG_TDSEL,           0},
>         {"mediatek,rdsel",      MTK_PIN_CONFIG_RDSEL,           0},
>         {"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,         1},
>         {"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,       1},
> +       {"mediatek,drive-strength-adv", MTK_PIN_CONFIG_DRV_ADV, 2},
>  };
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -34,6 +36,7 @@ static const struct pin_config_item mtk_conf_items[] = {
>         PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
>         PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
>         PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
> +       PCONFDUMP(MTK_PIN_CONFIG_DRV_ADV, "drive-strengt-adv", NULL, true),

drive-strength-adv

>  };
>  #endif
>
> @@ -311,6 +314,15 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                         return -ENOTSUPP;
>                 }
>                 break;
> +       case MTK_PIN_CONFIG_DRV_ADV:
> +               if (hw->soc->adv_drive_set) {
> +                       err = hw->soc->adv_drive_set(hw, desc, arg);
> +                       if (err)
> +                               return err;
> +               } else {
> +                       return -ENOTSUPP;
> +               }
> +               break;
>         default:
>                 err = -ENOTSUPP;
>         }
> --
> 2.12.5
>

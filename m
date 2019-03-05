Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D08BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B918E206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551748573;
	bh=511KmFJ6iE8xlIN/eeEImKZSeX9y1CjSr5j4vWH3Mq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GQmqfbVLlgJHcCux7oo3ITogGmg45dX4Pc7et6biIxntiDr1m85Q9nKQAdlJKvRLU
	 soDa3LsHliMQpx2u3QVz+f9kgeWQL24xaBKNy8nhIxxQJlQEyM2j/eWsD5d3bVNqw3
	 va7J6ua6wX1Q1U/SXGYV7PICvZZvJF8y2pzMDCXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCEBQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:16:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCEBQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:16:11 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1319820830;
        Tue,  5 Mar 2019 01:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551748569;
        bh=511KmFJ6iE8xlIN/eeEImKZSeX9y1CjSr5j4vWH3Mq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JyPwVPHGfDfOvCkrx/jb5u0JfMHaDu0ERHqyW97DAvq3dGpSdw3uAcm+kBj3t8sgD
         quE7K5dWkic5vcc1J8ARLEQLGmn34Bvdpe/Vp1wnp8Gdw9N33k35rfJu5KVSp5yBA6
         mlDkXjwFyuQuyrLYDi49Srkf8CQg20c8x6x0kCOQ=
Received: by mail-wr1-f47.google.com with SMTP id n2so7582692wrw.8;
        Mon, 04 Mar 2019 17:16:09 -0800 (PST)
X-Gm-Message-State: APjAAAUXMehAy3WTLLogyIGQ7NF+L/msq3iseflkr9SmHRaxnJACVpYc
        1AeOie6992JQyyEcbf1Zs6ZoOEBOcM170pdWK24=
X-Google-Smtp-Source: APXvYqzispaNk3xgQNFMet8q/jEU59ImqCzO6kbUN8ZG0D2Gpx+R4thQBHvxxzu1ZooBPuy/tBt+6da9I+x6HS6lcBY=
X-Received: by 2002:a5d:5410:: with SMTP id g16mr14027408wrv.214.1551748567450;
 Mon, 04 Mar 2019 17:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20190303015341.986-1-zhiyong.tao@mediatek.com> <20190303015341.986-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20190303015341.986-2-zhiyong.tao@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 4 Mar 2019 17:15:55 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpzdpUMHPC5_98EKxj5+z6QQ--KjpG6eAGMkNQjvZ7+Mw@mail.gmail.com>
Message-ID: <CAGp9LzpzdpUMHPC5_98EKxj5+z6QQ--KjpG6eAGMkNQjvZ7+Mw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: add drive for I2C related pins on MT8183
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Liguo Zhang <liguo.zhang@mediatek.com>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?SG9uZ2t1biBDYW8gKOabuea0quWdpCk=?= 
        <hongkun.cao@mediatek.com>, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <chuanjia.liu@mediatek.com>,
        =?UTF-8?B?RXJpbiBMbyAo576F6ZuF6b2hKQ==?= <erin.lo@mediatek.com>,
        =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 5:53 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> This patch provides the advanced drive for I2C used pins on MT8183.
> The detail strength specification description of the I2C pin is as follows.
> When E1=0/E0=0, the strength is 0.125mA.
> When E1=0/E0=1, the strength is 0.25mA.
> When E1=1/E0=0, the strength is 0.5mA.
> When E1=1/E0=1, the strength is 1mA.

Three things are needed to be added

The first is we need to add more words in the git message about what
relationship between the specific driving setup and existing generic
driving setup.

The second is stating why we need to add extra vendor driving property
in the patch is, instead of using the generic driving property.

The third is we need to add the dt-binding document prior to the change.

>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 45 +++++++++++++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 13 ++++++
>  drivers/pinctrl/mediatek/pinctrl-paris.c         | 20 ++++++++++
>  4 files changed, 128 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> index 6262fd3678ea..f034574fc593 100644
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
> +       [PINCTRL_PIN_REG_DRV_EN_DIS] = MTK_RANGE(mt8183_pin_e1e0en_range),
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
> index 4a9e0d4c2bbc..da024279ec59 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -668,3 +668,48 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
>
>         return 0;
>  }
> +
> +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, bool enable,
> +                             u32 arg)
> +{
> +       int err;
> +
> +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, arg & 1);
> +       if (err)
> +               return 0;

return err;

> +
> +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
> +                              !!(arg & 2));
> +       if (err)
> +               return 0;

return err;

> +
> +       arg = enable ? 1 : 0;
> +
> +       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, arg);
> +

it looks like it is redundant operation to set e0 and e1 when we want
to disable the advanced driving.

> +       return err;
> +}
> +
> +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, u32 *val)
> +{
> +       u32 en, e0, e1;
> +       int err;
> +
> +       err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, &en);
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
> +
> +       return 0;
> +}
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> index 6d24522739d9..795a3b10d54e 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> @@ -63,6 +63,9 @@ enum {
>         PINCTRL_PIN_REG_IES,
>         PINCTRL_PIN_REG_PULLEN,
>         PINCTRL_PIN_REG_PULLSEL,
> +       PINCTRL_PIN_REG_DRV_EN_DIS,
> +       PINCTRL_PIN_REG_DRV_E0,
> +       PINCTRL_PIN_REG_DRV_E1,
>         PINCTRL_PIN_REG_MAX,
>  };
>
> @@ -224,6 +227,11 @@ struct mtk_pin_soc {
>         int (*adv_pull_get)(struct mtk_pinctrl *hw,
>                             const struct mtk_pin_desc *desc, bool pullup,
>                             u32 *val);
> +       int (*adv_drive_set)(struct mtk_pinctrl *hw,
> +                            const struct mtk_pin_desc *desc, bool enable,
> +                            u32 arg);
> +       int (*adv_drive_get)(struct mtk_pinctrl *hw,
> +                            const struct mtk_pin_desc *desc, u32 *val);
>
>         /* Specific driver data */
>         void                            *driver_data;
> @@ -287,5 +295,10 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
>  int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
>                              const struct mtk_pin_desc *desc, bool pullup,
>                              u32 *val);
> +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, bool enable,
> +                            u32 arg);
> +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> +                             const struct mtk_pin_desc *desc, u32 *val);
>
>  #endif /* __PINCTRL_MTK_COMMON_V2_H */
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index b59e10852bfb..8c473d48cd5f 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -20,12 +20,16 @@
>  #define MTK_PIN_CONFIG_RDSEL   (PIN_CONFIG_END + 2)
>  #define MTK_PIN_CONFIG_PU_ADV  (PIN_CONFIG_END + 3)
>  #define MTK_PIN_CONFIG_PD_ADV  (PIN_CONFIG_END + 4)
> +#define MTK_PIN_CONFIG_DRV_EN_ADV      (PIN_CONFIG_END + 5)
> +#define MTK_PIN_CONFIG_DRV_DIS_ADV     (PIN_CONFIG_END + 6)
>
>  static const struct pinconf_generic_params mtk_custom_bindings[] = {
>         {"mediatek,tdsel",      MTK_PIN_CONFIG_TDSEL,           0},
>         {"mediatek,rdsel",      MTK_PIN_CONFIG_RDSEL,           0},
>         {"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,         1},
>         {"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,       1},
> +       {"mediatek,drive-enable-adv", MTK_PIN_CONFIG_DRV_EN_ADV,        2},
> +       {"mediatek,drive-disable-adv", MTK_PIN_CONFIG_DRV_DIS_ADV,      2},

adding a  "mediatek,drive-strength-adv"  is enough as the generic
driving strength property doing.

>  };
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -34,6 +38,8 @@ static const struct pin_config_item mtk_conf_items[] = {
>         PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
>         PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
>         PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
> +       PCONFDUMP(MTK_PIN_CONFIG_DRV_EN_ADV, "drive-enable-adv", NULL, true),
> +       PCONFDUMP(MTK_PIN_CONFIG_DRV_DIS_ADV, "drive-disable-adv", NULL, true),
>  };
>  #endif
>
> @@ -311,6 +317,20 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>                         return -ENOTSUPP;
>                 }
>                 break;
> +       case MTK_PIN_CONFIG_DRV_EN_ADV:
> +       case MTK_PIN_CONFIG_DRV_DIS_ADV:
> +               if (hw->soc->adv_drive_set) {
> +                       bool enable;
> +
> +                       enable = param == MTK_PIN_CONFIG_DRV_EN_ADV;
> +                       err = hw->soc->adv_drive_set(hw, desc, enable,
> +                                                   arg);
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

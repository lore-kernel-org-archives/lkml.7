Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339B0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EC8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEdDTneM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfDPII4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:08:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37977 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:08:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id d13so17078783edr.5;
        Tue, 16 Apr 2019 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=at6KAlj74a6ETP3gzcH5M7n3r/EceULSK5NSdXRvN1o=;
        b=ZEdDTneMPQibS+INkiDBgNp8o6Gqb4SiAr2zRwGP19x0/RTllUVZCv0Q5Og3omAXbd
         OZtBdPon6uxUB5WbreGioolRbbFxldc4A5dH4bFZJ62vzxCx+xodvDKmuYe1NlFVY+Uu
         pMTiWEsFzprRZxZpRZ6QycSEoCmifPz4b/fQozydv/u70EtAJf52EGd36ImP/j7fD0uv
         v8zMmUGnTd7hr87sCQtLUUwl6otk7A3tzH0NxKuy2NxDtbcthSRTU9RcGc9TPR9nYXib
         KVqxvVbfOpqEKA0GayOsrVoPbUK4kQttfjAW6topekWF0Z4FpjvmX0j8ZR2cfCbdkWAC
         p1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=at6KAlj74a6ETP3gzcH5M7n3r/EceULSK5NSdXRvN1o=;
        b=tlJqTJw6X3+ndoklXnfG87hJKm9vasifKx3MBA6YD9n8vu0WEBeRJtBPX4nugJFyIA
         xxx+kMc00BkZDfUb8XCUBkzNDt5Xd6Ep5N7kRv+aRTOaoiMQCYS7YEvUrBCzwsewk5Nu
         Pa6bYZEQUdNMLC/8MT73rUWREwJsz4nwrf+9zx50ivkWhAwZfBSQEJm89i2EJSdoSHBZ
         fo+wal+uhDPWTHpYdfN+dgIZQx2Wg5ca3NEqR2OlSmFOKLumxEr1c2xEmDTk78WbB5JG
         hjrVNDEhmJugBRb0dOIBOodJ3hKBC0kOV6fxqyWcsEOSNozZm8u+ZmbB7AUmkEqJv0z6
         Ag3A==
X-Gm-Message-State: APjAAAWsxNl0zI2noSzuQId3ztlnu7MSO0K2jYsfuSU6bnbZwfIbmKUa
        6Go+SOnwjc0hu5pggZRWu5Xotpf61Z8=
X-Google-Smtp-Source: APXvYqwmuJrhuL0r5rPyW9vQiN7U2q9NdCqm6LjpU/QSy0skN4NZom3fbgkpybwEM+q6phdYvGIsJw==
X-Received: by 2002:a17:906:2a94:: with SMTP id l20mr22129179eje.44.1555402131980;
        Tue, 16 Apr 2019 01:08:51 -0700 (PDT)
Received: from ziggy.stardust ([37.223.141.112])
        by smtp.gmail.com with ESMTPSA id l26sm7035280ejr.82.2019.04.16.01.08.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 01:08:51 -0700 (PDT)
Subject: Re: [PATCH RESEND v3 4/4] pinctrl: add drive for I2C related pins on
 MT8183
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org, mark.rutland@arm.com,
        sean.wang@kernel.org
Cc:     srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        eddie.huang@mediatek.com, chuanjia.liu@mediatek.com,
        biao.huang@mediatek.com, hongzhou.yang@mediatek.com,
        erin.lo@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20190325124137.6117-1-zhiyong.tao@mediatek.com>
 <20190325124137.6117-5-zhiyong.tao@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <206361ee-b238-4017-83fe-702ea59ae9c5@gmail.com>
Date:   Tue, 16 Apr 2019 10:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190325124137.6117-5-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/03/2019 13:41, Zhiyong Tao wrote:
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

Linus, did that fall through the cracks? Do you have any comments on this driver?

Regards,
Matthias

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> index 6262fd3678ea..2c7409ed16fa 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> @@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
>  	PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
>  };
>  
> +static const struct mtk_pin_field_calc mt8183_pin_e1e0en_range[] = {
> +	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 20, 1),
> +	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 15, 1),
> +	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 12, 1),
> +	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 7, 1),
> +	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 12, 1),
> +	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 9, 1),
> +	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 19, 1),
> +	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 22, 1),
> +	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 24, 1),
> +	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 14, 1),
> +	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 27, 1),
> +	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 17, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8183_pin_e0_range[] = {
> +	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 21, 1),
> +	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 16, 1),
> +	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 13, 1),
> +	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 8, 1),
> +	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 13, 1),
> +	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 10, 1),
> +	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 20, 1),
> +	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 23, 1),
> +	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 25, 1),
> +	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 15, 1),
> +	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 28, 1),
> +	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 18, 1),
> +};
> +
> +static const struct mtk_pin_field_calc mt8183_pin_e1_range[] = {
> +	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 22, 1),
> +	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 17, 1),
> +	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 14, 1),
> +	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 9, 1),
> +	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 14, 1),
> +	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 11, 1),
> +	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 21, 1),
> +	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 24, 1),
> +	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 26, 1),
> +	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 16, 1),
> +	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 29, 1),
> +	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 19, 1),
> +};
> +
>  static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
>  	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
>  	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
> @@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
>  	[PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
>  	[PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
>  	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
> +	[PINCTRL_PIN_REG_DRV_EN] = MTK_RANGE(mt8183_pin_e1e0en_range),
> +	[PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_e0_range),
> +	[PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_e1_range),
>  };
>  
>  static const char * const mt8183_pinctrl_register_base_names[] = {
> @@ -517,6 +565,8 @@ static const struct mtk_pin_soc mt8183_data = {
>  	.drive_get = mtk_pinconf_drive_get_rev1,
>  	.adv_pull_get = mtk_pinconf_adv_pull_get,
>  	.adv_pull_set = mtk_pinconf_adv_pull_set,
> +	.adv_drive_get = mtk_pinconf_adv_drive_get,
> +	.adv_drive_set = mtk_pinconf_adv_drive_set,
>  };
>  
>  static const struct of_device_id mt8183_pinctrl_of_match[] = {
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index b1c368455d30..ef8732e8966b 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -674,3 +674,50 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
>  
>  	return 0;
>  }
> +
> +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> +			      const struct mtk_pin_desc *desc, u32 arg)
> +{
> +	int err;
> +
> +	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN, arg & 1);
> +	if (err)
> +		return err;
> +
> +	if (arg & 1) {
> +		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0,
> +				       !!(arg & 2));
> +		if (err)
> +			return err;
> +
> +		err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
> +				       !!(arg & 4));
> +		if (err)
> +			return err;
> +	}
> +
> +	return err;
> +}
> +
> +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> +			      const struct mtk_pin_desc *desc, u32 *val)
> +{
> +	u32 en, e0, e1;
> +	int err;
> +
> +	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN, &en);
> +	if (err)
> +		return err;
> +
> +	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, &e0);
> +	if (err)
> +		return err;
> +
> +	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, &e1);
> +	if (err)
> +		return err;
> +
> +	*val = (e0 | e1 << 1 | en << 2) & 0x7;
> +
> +	return 0;
> +}
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> index 6d24522739d9..1b7da42aa1d5 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
> @@ -63,6 +63,9 @@ enum {
>  	PINCTRL_PIN_REG_IES,
>  	PINCTRL_PIN_REG_PULLEN,
>  	PINCTRL_PIN_REG_PULLSEL,
> +	PINCTRL_PIN_REG_DRV_EN,
> +	PINCTRL_PIN_REG_DRV_E0,
> +	PINCTRL_PIN_REG_DRV_E1,
>  	PINCTRL_PIN_REG_MAX,
>  };
>  
> @@ -224,6 +227,10 @@ struct mtk_pin_soc {
>  	int (*adv_pull_get)(struct mtk_pinctrl *hw,
>  			    const struct mtk_pin_desc *desc, bool pullup,
>  			    u32 *val);
> +	int (*adv_drive_set)(struct mtk_pinctrl *hw,
> +			     const struct mtk_pin_desc *desc, u32 arg);
> +	int (*adv_drive_get)(struct mtk_pinctrl *hw,
> +			     const struct mtk_pin_desc *desc, u32 *val);
>  
>  	/* Specific driver data */
>  	void				*driver_data;
> @@ -287,5 +294,9 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
>  int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
>  			     const struct mtk_pin_desc *desc, bool pullup,
>  			     u32 *val);
> +int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
> +			      const struct mtk_pin_desc *desc, u32 arg);
> +int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
> +			      const struct mtk_pin_desc *desc, u32 *val);
>  
>  #endif /* __PINCTRL_MTK_COMMON_V2_H */
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index b59e10852bfb..dcd295f0eb4b 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -20,12 +20,14 @@
>  #define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
>  #define MTK_PIN_CONFIG_PU_ADV	(PIN_CONFIG_END + 3)
>  #define MTK_PIN_CONFIG_PD_ADV	(PIN_CONFIG_END + 4)
> +#define MTK_PIN_CONFIG_DRV_ADV	(PIN_CONFIG_END + 5)
>  
>  static const struct pinconf_generic_params mtk_custom_bindings[] = {
>  	{"mediatek,tdsel",	MTK_PIN_CONFIG_TDSEL,		0},
>  	{"mediatek,rdsel",	MTK_PIN_CONFIG_RDSEL,		0},
>  	{"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,		1},
>  	{"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,	1},
> +	{"mediatek,drive-strength-adv", MTK_PIN_CONFIG_DRV_ADV,	2},
>  };
>  
>  #ifdef CONFIG_DEBUG_FS
> @@ -34,6 +36,7 @@ static const struct pin_config_item mtk_conf_items[] = {
>  	PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
>  	PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
>  	PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
> +	PCONFDUMP(MTK_PIN_CONFIG_DRV_ADV, "drive-strengt-adv", NULL, true),
>  };
>  #endif
>  
> @@ -311,6 +314,15 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>  			return -ENOTSUPP;
>  		}
>  		break;
> +	case MTK_PIN_CONFIG_DRV_ADV:
> +		if (hw->soc->adv_drive_set) {
> +			err = hw->soc->adv_drive_set(hw, desc, arg);
> +			if (err)
> +				return err;
> +		} else {
> +			return -ENOTSUPP;
> +		}
> +		break;
>  	default:
>  		err = -ENOTSUPP;
>  	}
> 

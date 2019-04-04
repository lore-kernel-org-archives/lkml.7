Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18372075D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSvKofTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDDDDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:03:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:03:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so482074pgh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7flZ0vNmDa8QHDBY5emh+d1rUq3wAbWkUcOvPIufW+4=;
        b=dSvKofTbAqbKDDwwXDBbJ6XcCrSYor4vr/fh0GsQwYiJrDYr6QWDCk1educyw3aACi
         CdEkZxflepKFdU9PE5MXgFgD7YGVBRhnECVCw5q4Fg3XjGgXtuFDKR5soFeTMNVs9Yud
         ddA7GBwgeaEpYvKrifB+cLkAodi8kec25/zF+6evjmfegkRHGTXN+y8rlCUsyqEp4rNa
         MnTivo5PV7iSA3RHMl5orFJndGHIWTBJ5mnWW1ATu3oQR4eOuGOOSlKOIIWoJke7x+uF
         yOXVcPXIeMEWM3Yk6y3sMcQePXSi+0T8RI6lYuprBYG+H0zHcSTaF+qrf3sL8d23KpbL
         X5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7flZ0vNmDa8QHDBY5emh+d1rUq3wAbWkUcOvPIufW+4=;
        b=svTSkPqBRGEkVKCXlniThFTXPUu+QAY4JdptezcZKKFQQAWnBsC2vleKVPD0NuqOdq
         50yY2ZRXYCC4b1nUzxuLOmVDYBifDd/D7A2sDhRFXFap+QdTWoW7lG673a04VKLJgPw7
         YUpF4jY2woYDchZBJ1xLL3/n8HLu40wO2LTBqMaMs0MZhHKXEANKYo74CWeLDctPVDWu
         WLqHA6+P9USpi3CEe6bc1LERlqrynp0Im46fQJr/sGfwwhrscg/AV4VCCRc6uhvX8Tyg
         RtrWTtHgBAhUknkZN1SjV4r0L6aRN24c3m007F6WZkUdM7COZ+g0P01GC8C1nuRYsKZ2
         czTA==
X-Gm-Message-State: APjAAAUZWkAxUS5bWgsBeZEQ0aoT90e3loYF9G4hyF1oVqzfvelJP0Wc
        AwmPesRvJiEvMD0+cWCkjgRZHQ==
X-Google-Smtp-Source: APXvYqxx6agKro9wfK75n9n3oF7X5hoKo6OE7EH9d+bp28kkyDnegi2yv5AodH9zKRptVWJXfeUKmQ==
X-Received: by 2002:a63:3281:: with SMTP id y123mr3277922pgy.272.1554347020763;
        Wed, 03 Apr 2019 20:03:40 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id n65sm54905273pfb.160.2019.04.03.20.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:03:39 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] thermal: rockchip: add pinctrl control
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-2-git-send-email-zhangqing@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <30325add-d75a-6775-50c0-d2d2274ff81e@linaro.org>
Date:   Thu, 4 Apr 2019 05:03:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554100985-11385-2-git-send-email-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 08:43, Elaine Zhang wrote:
> Based on the TSADC Tshut mode to select pinctrl,
> instead of setting pinctrl based on architecture
> (Not depends on pinctrl setting by "init" or "default").
> And it requires setting the tshut polarity before select pinctrl.

I'm not sure to fully read the description. Can you rephrase/elaborate
the changelog?

> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 61 +++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 9c7643d62ed7..faa6c7792155 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -34,7 +34,7 @@
>   */
>  enum tshut_mode {
>  	TSHUT_MODE_CRU = 0,
> -	TSHUT_MODE_GPIO,
> +	TSHUT_MODE_OTP,

Why do you change the enum name? The impact on the patch is much higher,
no ?

>  };
>  
>  /**
> @@ -172,6 +172,9 @@ struct rockchip_thermal_data {
>  	int tshut_temp;
>  	enum tshut_mode tshut_mode;
>  	enum tshut_polarity tshut_polarity;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *gpio_state;
> +	struct pinctrl_state *otp_state;
>  };
>  
>  /**
> @@ -807,7 +810,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	u32 val;
>  
>  	val = readl_relaxed(regs + TSADCV2_INT_EN);
> -	if (mode == TSHUT_MODE_GPIO) {
> +	if (mode == TSHUT_MODE_OTP) {
>  		val &= ~TSADCV2_SHUT_2CRU_SRC_EN(chn);
>  		val |= TSADCV2_SHUT_2GPIO_SRC_EN(chn);
>  	} else {
> @@ -822,7 +825,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>  	.chn_num = 1, /* one channel for tsadc */
>  
> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
>  
> @@ -846,7 +849,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>  	.chn_num = 1, /* one channel for tsadc */
>  
> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
>  
> @@ -871,7 +874,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
>  	.chn_num = 2, /* two channels for tsadc */
>  
> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
>  
> @@ -919,7 +922,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>  	.chn_num = 2, /* two channels for tsadc */
>  
> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
>  
> @@ -944,7 +947,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>  	.chn_num = 2, /* two channels for tsadc */
>  
> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
>  
> @@ -969,7 +972,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>  	.chn_num = 2, /* two channels for tsadc */
>  
> -	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_mode = TSHUT_MODE_OTP, /* default TSHUT via GPIO give PMIC */
>  	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>  	.tshut_temp = 95000,
>  
> @@ -1080,6 +1083,20 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
>  	.set_trips = rockchip_thermal_set_trips,
>  };
>  
> +static void thermal_pinctrl_select_otp(struct rockchip_thermal_data *thermal)
> +{
> +	if (!IS_ERR(thermal->pinctrl) && !IS_ERR_OR_NULL(thermal->otp_state))
> +		pinctrl_select_state(thermal->pinctrl,
> +				     thermal->otp_state);
> +}
> +
> +static void thermal_pinctrl_select_gpio(struct rockchip_thermal_data *thermal)
> +{
> +	if (!IS_ERR(thermal->pinctrl) && !IS_ERR_OR_NULL(thermal->gpio_state))
> +		pinctrl_select_state(thermal->pinctrl,
> +				     thermal->gpio_state);
> +}

You should not have to create a couple of specific functions just to
check the pinctrl pointers are set. The caller should do that.

>  static int rockchip_configure_from_dt(struct device *dev,
>  				      struct device_node *np,
>  				      struct rockchip_thermal_data *thermal)
> @@ -1103,7 +1120,7 @@ static int rockchip_configure_from_dt(struct device *dev,
>  	if (of_property_read_u32(np, "rockchip,hw-tshut-mode", &tshut_mode)) {
>  		dev_warn(dev,
>  			 "Missing tshut mode property, using default (%s)\n",
> -			 thermal->chip->tshut_mode == TSHUT_MODE_GPIO ?
> +			 thermal->chip->tshut_mode == TSHUT_MODE_OTP ?
>  				"gpio" : "cru");
>  		thermal->tshut_mode = thermal->chip->tshut_mode;
>  	} else {
> @@ -1242,6 +1259,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	thermal->chip->control(thermal->regs, false);
> +
>  	error = clk_prepare_enable(thermal->clk);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> @@ -1267,6 +1286,24 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	thermal->chip->initialize(thermal->grf, thermal->regs,
>  				  thermal->tshut_polarity);
>  
> +	if (thermal->tshut_mode == TSHUT_MODE_OTP) {
> +		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> +		if (IS_ERR(thermal->pinctrl))
> +			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
> +
> +		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
> +							   "gpio");
> +		if (IS_ERR_OR_NULL(thermal->gpio_state))
> +			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
> +
> +		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
> +							  "otpout");
> +		if (IS_ERR_OR_NULL(thermal->otp_state))
> +			dev_err(&pdev->dev, "failed to find thermal otpout state\n");

What is the meaning for the rest of the code if the lookup fails for any
of those ?

> +		thermal_pinctrl_select_otp(thermal);
> +	}
> +
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		error = rockchip_thermal_register_sensor(pdev, thermal,
>  						&thermal->sensors[i],
> @@ -1338,7 +1375,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  	clk_disable(thermal->pclk);
>  	clk_disable(thermal->clk);
>  
> -	pinctrl_pm_select_sleep_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_OTP)
> +		thermal_pinctrl_select_gpio(thermal);
>  
>  	return 0;
>  }
> @@ -1383,7 +1421,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  	for (i = 0; i < thermal->chip->chn_num; i++)
>  		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>  
> -	pinctrl_pm_select_default_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_OTP)
> +		thermal_pinctrl_select_otp(thermal);
>  
>  	return 0;
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


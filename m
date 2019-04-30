Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB7C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDC121670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxATa+VE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfD3Ni6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:38:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33859 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfD3Ni4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:38:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16so18662630wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=itopA/ItRE7ZMWfQuGvoXaTCudQHZDXEixDU5B3vzos=;
        b=hxATa+VEqQe59yueuVRTCPUR5y+WfuYh2iPbJElIGltimA4qVtAgZ6VonBKccZRolN
         b8x6WnqvTL10fcbLkvyFf33CSGh5Y/iGV/ifZQbpxOIXUq/PUc0A5f9uNJ/zW/nA1pL9
         Mf5mwGvlRaexP67OjHDNIAhFlsW0MQbxA5Z4OSZOjF4DAkoxN2/6w3S5Sqc2DNQI/jI0
         Y43MU6UBI7wg+m8590tAZbZdiMNM176Fe/nu4sW8fc5J9AA+nbyBYYHFSRXKvS/8JjK+
         DNYpv0ZPQRXVT2xT/9Uj27WwTqaIJd4Cv1hobBFYxf5dos6S3RgKrE+nztobtmwKG8mX
         Gewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=itopA/ItRE7ZMWfQuGvoXaTCudQHZDXEixDU5B3vzos=;
        b=K7VNZA9d1b4+6SyJ04fCbLYoo/70khfv5TfwKy01nFASEiffl2yYCvYEw4cUnCOWsk
         aaUGhdknxTgtzi+5BHdO10tgHdWx3X+y33GDqH2G3E5yWXHLSwlbzEDkyxYhVZ1L1HnW
         9JiwXhIX5fqIy9qzR9Z9ljtCmH/i8KiPRkPll3cZQPfK0iRBJol6BcB7T8DsJiTg2efN
         XrdbRwKIv1Ys8kPJIUAvLB5pDSKIV1X6wXZK8H9z30AOMVgArXnaHhe69ozZl7UCUCPp
         TAX9QV8xamGVrruWcQaoJMq/G+hMKnoalqMD/WlCNxGdh9rcU3khWayK2tVWfCk3VbbI
         MIzA==
X-Gm-Message-State: APjAAAXf/z11c/zjtWZdSf8tVm4DqHwgmZH7Lyceft591MnTKPisTDBL
        YueJJ9pCXKM9lMTDYimM28oUzw==
X-Google-Smtp-Source: APXvYqxJo6YyqwjGZPozpgX+q3kMxOob3HtcBfq/38IG6fntTQ3NVABFe5nH5Cv3beZjeSSkT9EwJQ==
X-Received: by 2002:a5d:5447:: with SMTP id w7mr1041635wrv.325.1556631533884;
        Tue, 30 Apr 2019 06:38:53 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id o16sm25803167wro.63.2019.04.30.06.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 06:38:53 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1556618986-18923-1-git-send-email-zhangqing@rock-chips.com>
 <1556618986-18923-2-git-send-email-zhangqing@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <785392a0-282a-1e51-a4d6-a6d5ca478949@linaro.org>
Date:   Tue, 30 Apr 2019 15:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556618986-18923-2-git-send-email-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2019 12:09, Elaine Zhang wrote:
> Explicitly use the pinctrl to set/unset the right mode
> instead of relying on the pinctrl init mode.
> And it requires setting the tshut polarity before select pinctrl.
> 
> When the temperature sensor mode is set to 0, it will automatically
> reset the board via the Clock-Reset-Unit (CRU) if the over temperature
> threshold is reached. However, when the pinctrl initializes, it does a
> transition to "otp_out" which may lead the SoC restart all the time.
> 
> "otp_out" IO may be connected to the RESET circuit on the hardware.
> If the IO is in the wrong state, it will trigger RESET.
> (similar to the effect of pressing the RESET button)
> which will cause the soc to restart all the time.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



> ---
>  drivers/thermal/rockchip_thermal.c | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 9c7643d62ed7..6dc7fc516abf 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
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
> @@ -1242,6 +1245,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	thermal->chip->control(thermal->regs, false);
> +
>  	error = clk_prepare_enable(thermal->clk);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
> @@ -1267,6 +1272,30 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	thermal->chip->initialize(thermal->grf, thermal->regs,
>  				  thermal->tshut_polarity);
>  
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
> +		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> +		if (IS_ERR(thermal->pinctrl)) {
> +			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
> +			return PTR_ERR(thermal->pinctrl);
> +		}
> +
> +		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
> +							   "gpio");
> +		if (IS_ERR_OR_NULL(thermal->gpio_state)) {
> +			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
> +			return -EINVAL;
> +		}
> +
> +		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
> +							  "otpout");
> +		if (IS_ERR_OR_NULL(thermal->otp_state)) {
> +			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
> +			return -EINVAL;
> +		}
> +
> +		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
> +	}
> +
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		error = rockchip_thermal_register_sensor(pdev, thermal,
>  						&thermal->sensors[i],
> @@ -1337,8 +1366,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  
>  	clk_disable(thermal->pclk);
>  	clk_disable(thermal->clk);
> -
> -	pinctrl_pm_select_sleep_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> +		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);
>  
>  	return 0;
>  }
> @@ -1383,7 +1412,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  	for (i = 0; i < thermal->chip->chn_num; i++)
>  		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>  
> -	pinctrl_pm_select_default_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> +		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
>  
>  	return 0;
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


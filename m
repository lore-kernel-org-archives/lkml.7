Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBFC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE06206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cd5k/15u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfD1Mpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:45:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45969 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfD1Mpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 08:45:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so11534221wra.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjtjPVeH9uJpdgJ4+Mz+dHECKsOeFzPmFSYQ0lOXlR8=;
        b=cd5k/15uADqLMAJw5B8UKQEopJ8j6JAZ8bDdTsspGpZJM9P99gq16aT6wnVAGC9zdQ
         b0XQImUdKpjAK96KhCQtqj1LBQfMNyQh8Vq3DjDtk1sUdiVtEump4CyxBlpEnvy2jsp5
         FKYRefQkMzhOjvsllnKX3FHpZc7A41Tu79VdNJ1UjdII9P1jX3HmkXT+u78WShOmHf/C
         PgRcAA51s/ZwPZ+OiZ1c6yAhJrGjkfRen4mIwO/oNbe9izzg+MlZ3IrsEHWoRMG5vEah
         oQHzFAyIbAivvD/hA3O7YenYJ87R6D3iwxdRXcV7ncRhIoPe3D8MIgn4P7hVUxzXqAO5
         aSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjtjPVeH9uJpdgJ4+Mz+dHECKsOeFzPmFSYQ0lOXlR8=;
        b=DdVJAYlQnzyeMbfJNHmb0PcgCMFG5nPjlRHMd0oj5UabxKNxcAhABXyGa+GXDrQ4bg
         eOMLtbE2PQSzG18m6KkX4eqGflh4U4dhQPRoJm3xTDnyIQPPosL8BZrLfofqjl0xVExR
         sKYTt+kQeuCoxwpqIX6f3Lt65DosrdWZJhnQfT1vFekX+6j0UfG/Q68QD2PjAvZxW3xd
         6E0NQp7UoQjQ6smRUMY3IJ37Kp5CmbPi4NT1YxnhQoESAjbv2IMTgkkw8w4g2pXhm70q
         94mFqiZ5YwZVYR7eAFPh9oNd1vsuT8PXmWO/yf1YjI22BVJf3Fv9NLq9m2Ir+vJmlCMF
         qo8A==
X-Gm-Message-State: APjAAAUVZnuXuiuK7xZvzRXDFXczZyDilQsI14+NVyiJFGx8zca/EHNl
        20C1mGrSYCicU7JpijyPsnaTcw==
X-Google-Smtp-Source: APXvYqwtDjW+k72NDXuTsG5WeDiwQ61HiZNWbQq5aHjsOa5EhP2zQp77AArxVEbt3c/64dpOVmjsVw==
X-Received: by 2002:a5d:4e86:: with SMTP id e6mr385971wru.59.1556455529976;
        Sun, 28 Apr 2019 05:45:29 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id d11sm3488520wmb.39.2019.04.28.05.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 05:45:29 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/3] thermal: rockchip: fix up the tsadc pinctrl
 setting error
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1556187154-22632-1-git-send-email-zhangqing@rock-chips.com>
 <1556187154-22632-2-git-send-email-zhangqing@rock-chips.com>
Message-ID: <be0170d7-64dc-896d-b847-5be192304791@linaro.org>
Date:   Sun, 28 Apr 2019 14:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556187154-22632-2-git-send-email-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 12:12, Elaine Zhang wrote:
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
> ---
>  drivers/thermal/rockchip_thermal.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 9c7643d62ed7..03ff494f2864 100644
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
> @@ -1267,6 +1272,31 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	thermal->chip->initialize(thermal->grf, thermal->regs,
>  				  thermal->tshut_polarity);
>  
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
> +		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
> +		if (IS_ERR(thermal->pinctrl)) {
> +			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
> +			panic("panic_on_find thermal pinctrl...\n");

I realize my comment was confusing. I was not saying to add a panic()
call here but that the code was accessing a NULL pointer. Please remove
the panic.

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

I don't understand this portion of code. The test above says tshut_mode
is TSHUT_MODE_GPIO. Why acting on thermal->otp_state then ?


In my previous comment, I was suggesting the following:

Two more fields instead of three:

	struct rockchip_thermal_data {
  		int tshut_temp;
	  	enum tshut_mode tshut_mode;
  		enum tshut_polarity tshut_polarity;
	 	struct pinctrl *pinctrl;
		struct pinctrl_state *pinctrl_state;
	};

	[ ... ]

	thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
	if (IS_ERR(thermal->pinctrl)) {
		dev_err("...");
		return PTR_ERR(thermal->pinctrl);
	}

	thermal->pinctrl_state = pinctrl_lookup_state(thermal->pinctrl,
		thermal->tshut_mode == TSHUT_MODE_GPIO ? "gpio" :
							"otpout";

	if (IS_ERR_OR_NULL(thermal->pinctrl_state) {
		dev_err("...");
		return PTR_ERR(thermal->pinctrl_state);
	}

 	pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);


	[ ... ]

Is it wrong ?


> +	}
> +
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		error = rockchip_thermal_register_sensor(pdev, thermal,
>  						&thermal->sensors[i],
> @@ -1337,8 +1367,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  
>  	clk_disable(thermal->pclk);
>  	clk_disable(thermal->clk);
> -
> -	pinctrl_pm_select_sleep_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> +		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);

And then:
	 pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);

>  
>  	return 0;
>  }
> @@ -1383,7 +1413,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  	for (i = 0; i < thermal->chip->chn_num; i++)
>  		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
>  
> -	pinctrl_pm_select_default_state(dev);
> +	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
> +		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);

And then
	pinctrl_select_state(thermal->pinctrl, thermal->pinctrl_state);

>  	return 0;
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


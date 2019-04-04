Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE28C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDB21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/kuhY9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDDDIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:08:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40179 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDDDIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:08:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so401531plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5leik6S6No5EZTddJwuepRt2JsDU9cFHxAqjqn0iBr4=;
        b=B/kuhY9Db92e15oXiPQqPJNUrMQBT6XQd3rmBP8FdrBm5vuX5Hs8mFycf57JrWjS/d
         XJxTWczXqG9+J6BvsRS3bJlO8GkmGcyy0o57f59LHI+rV3rvm9Fj+eLBGVPkUs+YufnO
         2jFUxLHUZ58k4hVg9Bu1I5Ali14m0E3S5aPOW+m53PS9jp4lJZKcgFI8dLYzZgYmIIZ7
         xeQCKIgskDPxKG4gTWz2xcvebqIVA7c8o/Vx/TMQ5ewL/IISeMBHfkV6S0dQAVsjHjQ/
         JUUgiEJLp/VVua98m9X2h79Z7Y4n0IZBKeXyFc/nAl59d0LCpC8uzD+9MVRpcLJIJo7N
         0/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5leik6S6No5EZTddJwuepRt2JsDU9cFHxAqjqn0iBr4=;
        b=ujxTDrTJt3LfWFQTTZdZeLYwK8vPwdNEjPgfeKDjsmkKinsnAF+SKUJuEB8NEMc2iR
         q5VsomSGx5FG/9OeQYaeAXqD/DE5hqfNk7vMD3ARQxs+Mq9CKqjsZOGEyQMF/RWst96B
         C7Y7XAUL/VXGykvcOy5G+mGVMEmTMcoCFMzXvrdZzXCxQ89/3mnS3xiSVGw5Ot1jaT0l
         VMbwhtAjekIvq+N971dTFk23Y6d0F+HKhvQ7CnpxnaM4oIWcfW8o6aiD8KXVvP5/tIx6
         nv6PxpBBakdpuAvKQ6Xt3RbhASVdoJ+Y9+I1Kpm1fe3uJ55/vyBeiVGKNXcV4X+4RiHN
         JOHg==
X-Gm-Message-State: APjAAAWLg2rF1ADf5k1t2eVJrNMGWg12F6+XUKyAypHJy7tp5BFJjQy3
        XTkIHfzZm7OxraSZA228iDU4bA==
X-Google-Smtp-Source: APXvYqxRhwhThDGvy0C+R7z4t13xKgTiHwM/lCYBxrTlssKyJFOLEcVanQqoy2LQfB5/FdybivWX/w==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr3812082ply.200.1554347315009;
        Wed, 03 Apr 2019 20:08:35 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id 8sm35173747pfs.50.2019.04.03.20.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:08:33 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] thermal: rockchip: Support the PX30 SoC in thermal
 driver
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-4-git-send-email-zhangqing@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b00bffe4-8aad-ad86-bac8-d196b22b304d@linaro.org>
Date:   Thu, 4 Apr 2019 05:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554100985-11385-4-git-send-email-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 08:43, Elaine Zhang wrote:
> PX30 SOC has two Temperature Sensors for CPU and GPU.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index faa6c7792155..d5c161e63361 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -225,11 +225,15 @@ struct rockchip_thermal_data {
>  #define GRF_TSADC_TESTBIT_L			0x0e648
>  #define GRF_TSADC_TESTBIT_H			0x0e64c
>  
> +#define PX30_GRF_SOC_CON2			0x0408
> +
>  #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
>  #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
>  #define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
>  #define GRF_TSADC_VCM_EN_H			(0x10001 << 7)
>  
> +#define GRF_CON_TSADC_CH_INV			(0x10001 << 1)
> +
>  /**
>   * struct tsadc_table - code to temperature conversion table
>   * @code: the value of adc channel
> @@ -692,6 +696,14 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
>  			       regs + TSADCV2_AUTO_CON);
>  }
>  
> +static void rk_tsadcv4_initialize(struct regmap *grf, void __iomem *regs,
> +				  enum tshut_polarity tshut_polarity)
> +{
> +	rk_tsadcv2_initialize(grf, regs, tshut_polarity);
> +	if (!IS_ERR(grf))

Why this test ? grf is not modified by the 'rk_tsadcv2_initialize' function.

> +		regmap_write(grf, PX30_GRF_SOC_CON2, GRF_CON_TSADC_CH_INV);
> +}
> +
>  static void rk_tsadcv2_irq_ack(void __iomem *regs)
>  {
>  	u32 val;
> @@ -821,6 +833,30 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	writel_relaxed(val, regs + TSADCV2_INT_EN);
>  }
>  
> +static const struct rockchip_tsadc_chip px30_tsadc_data = {
> +	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	.chn_num = 2, /* 2 channels for tsadc */
> +
> +	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> +	.tshut_temp = 95000,
> +
> +	.initialize = rk_tsadcv4_initialize,
> +	.irq_ack = rk_tsadcv3_irq_ack,
> +	.control = rk_tsadcv3_control,
> +	.get_temp = rk_tsadcv2_get_temp,
> +	.set_alarm_temp = rk_tsadcv2_alarm_temp,
> +	.set_tshut_temp = rk_tsadcv2_tshut_temp,
> +	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> +
> +	.table = {
> +		.id = rk3328_code_table,
> +		.length = ARRAY_SIZE(rk3328_code_table),
> +		.data_mask = TSADCV2_DATA_MASK,
> +		.mode = ADC_INCREMENT,
> +	},
> +};
> +
>  static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>  	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>  	.chn_num = 1, /* one channel for tsadc */
> @@ -993,6 +1029,9 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  };
>  
>  static const struct of_device_id of_rockchip_thermal_match[] = {
> +	{	.compatible = "rockchip,px30-tsadc",
> +		.data = (void *)&px30_tsadc_data,
> +	},
>  	{
>  		.compatible = "rockchip,rv1108-tsadc",
>  		.data = (void *)&rv1108_tsadc_data,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C55DC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E954C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5u/91Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfEPJjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:39:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfEPJjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:39:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so1183348wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/2P/+zpthD8J0bBsqle4/WtYky/qbKCN/ws/oEssuM=;
        b=m5u/91NgYcCMwqpp3FUYVvUI7FaWpb6lu8UoCA0mb3JgCJl2i5+yTfL4AAxWn7lDFG
         0OifT7JQoNjLpOVlUHhPQZMGosBoii6APenGN5yG7ND+t7Q6HK71OsaSViYYWw2J98Il
         SecRk90xPC+c9d2EcYbSfveytXBAx3ysX3jD54W1/QjxWqNWcRNfreroH9lEoUCsIW89
         HpSK2lOiP0PL1P07NIxW11iROCz40L6nBOyV7/VMjw+7HI0uqiKwGPXgIfA1qz3HFHJW
         P9alm1HiH+f5iMpaQzk/s7JN12bwUU3Ice6h4alGT3XOAlsOlmYr7xcZPSfjjgXZxg23
         y4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/2P/+zpthD8J0bBsqle4/WtYky/qbKCN/ws/oEssuM=;
        b=UUL1lbWltC2s3NRix2c5ZTPPUjRooUuGP0qOqxSabXe21bB/vPjgZic8IbJl18s+dF
         gjwkx2AzR0YTVmCLZazgSBOdAGs5FeRnctfm9z8z9jUq+ihgLH8+k0Ijpb2ODIh+7dHZ
         HsLokvScPTEfirsak2hMX2drQ4wCi9kDs3pahr9IBlpCZ/dY57Pqv+Kk8c/GiHVppSAc
         P8hft7eFr5lSlozDLViDK2p14BrNblFRNxub3tJ0rGPEaPd3pWC+j8+5851giffHrUJo
         Kv1uHBROzPfxKusf0q6W7UC83sMJsuw75y4mO3uoPAb4H+xEWhA6FpyeR9OcNJbkGrv8
         3fqw==
X-Gm-Message-State: APjAAAX9vnqIaMQ3W/iaUrUZs26Uc7AgYmxkdmp1yVw5ZlKCOof4+wEi
        af+Xf2/sgRgQbN4k5CtXlxhnQA==
X-Google-Smtp-Source: APXvYqwRaCbqpWbqY1SS++Z4UyGqEDPAtFw/ysX1kr1OflkcFMzeJf12oTV4FH5k51KjF8ADJbLCQA==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr4360237wrr.92.1557999541416;
        Thu, 16 May 2019 02:39:01 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id k184sm8586854wmk.0.2019.05.16.02.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 02:39:00 -0700 (PDT)
Subject: Re: [PATCH V12 2/5] thermal: of-thermal: add API for getting sensor
 ID from DT
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d9c719c4-b5d1-580f-218e-0421126310e1@linaro.org>
Date:   Thu, 16 May 2019 11:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555384609-7030-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 05:22, Anson Huang wrote:
> On some platforms like i.MX8QXP, the thermal driver needs a
> real HW sensor ID from DT thermal zone, the HW sensor ID is
> used to get temperature from SCU firmware, and the virtual
> sensor ID starting from 0 to N is NOT used at all, this patch
> adds new API thermal_zone_of_get_sensor_id() to provide the
> feature of getting sensor ID from DT thermal zone's node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Eduardo?

What do you think about this patch?

> ---
> New patch.
> ---
>  drivers/thermal/of-thermal.c | 53 ++++++++++++++++++++++++++++++++++----------
>  include/linux/thermal.h      | 10 +++++++++
>  2 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 2df059c..2e4320c 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -446,6 +446,46 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>  }
>  
>  /**
> + * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
> + * @tz_np: a valid thermal zone device node.
> + * @sensor_specs: pointer to output arguments structure will be passed back.
> + * @id: a sensor ID pointer will be passed back.
> + *
> + * This function will get sensor ID from a given thermal zone node, use
> + * "thermal-sensors" as list name, and get sensor ID from first phandle's
> + * argument.
> + *
> + * Return: 0 on success, proper error code otherwise.
> + */
> +
> +int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> +				  struct of_phandle_args *sensor_specs,
> +				  u32 *id)
> +{
> +	int ret;
> +
> +	ret = of_parse_phandle_with_args(tz_np,
> +					 "thermal-sensors",
> +					 "#thermal-sensor-cells",
> +					 0,
> +					 sensor_specs);
> +	if (ret)
> +		return ret;
> +
> +	if (sensor_specs->args_count >= 1) {
> +		*id = sensor_specs->args[0];
> +		WARN(sensor_specs->args_count > 1,
> +		     "%pOFn: too many cells in sensor specifier %d\n",
> +		     sensor_specs->np, sensor_specs->args_count);
> +	} else {
> +		*id = 0;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
> +
> +/**
>   * thermal_zone_of_sensor_register - registers a sensor to a DT thermal zone
>   * @dev: a valid struct device pointer of a sensor device. Must contain
>   *       a valid .of_node, for the sensor node.
> @@ -500,21 +540,10 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>  		int ret, id;
>  
>  		/* For now, thermal framework supports only 1 sensor per zone */
> -		ret = of_parse_phandle_with_args(child, "thermal-sensors",
> -						 "#thermal-sensor-cells",
> -						 0, &sensor_specs);
> +		ret = thermal_zone_of_get_sensor_id(child, &sensor_specs, &id);
>  		if (ret)
>  			continue;
>  
> -		if (sensor_specs.args_count >= 1) {
> -			id = sensor_specs.args[0];
> -			WARN(sensor_specs.args_count > 1,
> -			     "%pOFn: too many cells in sensor specifier %d\n",
> -			     sensor_specs.np, sensor_specs.args_count);
> -		} else {
> -			id = 0;
> -		}
> -
>  		if (sensor_specs.np == sensor_np && id == sensor_id) {
>  			tzd = thermal_zone_of_add_sensor(child, sensor_np,
>  							 data, ops);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5f4705f..970fb37 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -375,6 +375,9 @@ struct thermal_trip {
>  
>  /* Function declarations */
>  #ifdef CONFIG_THERMAL_OF
> +int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> +				  struct of_phandle_args *sensor_specs,
> +				  u32 *id);
>  struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>  				const struct thermal_zone_of_device_ops *ops);
> @@ -386,6 +389,13 @@ struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
>  void devm_thermal_zone_of_sensor_unregister(struct device *dev,
>  					    struct thermal_zone_device *tz);
>  #else
> +
> +static int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
> +					 struct of_phandle_args *sensor_specs,
> +					 u32 *id)
> +{
> +	return -ENOENT;
> +}
>  static inline struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>  				const struct thermal_zone_of_device_ops *ops)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B046FC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659B22070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krUKFgf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfDOUHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:07:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44830 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfDOUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:07:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so23549272wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KE5M9cPNUm9KFk3zKjzkoab+gnX1jSXIXATLx0bvMG8=;
        b=krUKFgf9omSh1ebeycBG1V+85ZNipDGDPPfbI7rWagkv6xR2mLB3pwZ44lU9pWBiI6
         rszVZXVVkD43Iwb4dCS5x6i2bYYyeBDHNWXK7sICfbzI7OuMMzHYCV3KfthEPWi94oye
         fbVKtBZhdtq7y6QiLpwM54XQ0tiqZLH0ERdHipAHUrjzGYhwtMRMxrtBk0k/E+1/BtkK
         iKKYW168qnyFnpYjLqtGhXi2bYncsK8z1WMzE1x9SfTaKcGh6tpHX5RLnIIvMYh5cPsN
         pWyf9s+hUMrvHU5yc2nx6kPv+oi7YndaI4lTPwEz1EgV/BKtPf92cOefRQT3YDIoXiyd
         HYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KE5M9cPNUm9KFk3zKjzkoab+gnX1jSXIXATLx0bvMG8=;
        b=QevFX2XuEDIhPxC29jR7CcNw7ZsKiLjwLym5lnZgcA9B8Tyyc3ySN/eVdPInZvMroZ
         VdTuYFsh5MnQgENNhsCFZQnSVgtpsEPqvs4h4saHgL9WqQsZPuWwgvQ+lRmq9xbpzSxK
         2pjFYNfDHeyib7bsbyJxlLGViDlQY+j3sKkR7gkYUDMZ9WUT0e08YU5/FrceM8QrRhJP
         cDAxLnpHWLFyu2c4AjAzUWLbiLMG2u+jjpZkmZuRTKqqXvxCp1ZiTd4cpSm5ygE4+sBc
         nYQ3rm++RWQtkvvEhO3KmkYKgJl24RDYRQ91L0vQ+xHcExNcWDdHlu+BezQnlwudQ0h2
         yACw==
X-Gm-Message-State: APjAAAU6OL5GUpe2KOeS5HTo2i4iIQfi9q+QugvSSVuE7NU7n9wrtmY5
        a4c/kaXZyUK18ISvFc3c8f3B7w==
X-Google-Smtp-Source: APXvYqxLEqVMm0h/IWuv8KV9NbC/Rq6vYzgRf/6Tf7e2suJeMetzjUZ2wA1ikk5+x+OkUOePeyC/sw==
X-Received: by 2002:adf:ed86:: with SMTP id c6mr48595366wro.146.1555358839124;
        Mon, 15 Apr 2019 13:07:19 -0700 (PDT)
Received: from [192.168.0.41] (4.112.130.77.rev.sfr.net. [77.130.112.4])
        by smtp.googlemail.com with ESMTPSA id z14sm72752810wrv.78.2019.04.15.13.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:07:18 -0700 (PDT)
Subject: Re: [PATCH RESEND V11 2/4] thermal: imx_sc: add i.MX system
 controller thermal support
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
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Gross <andy.gross@linaro.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554881866-26333-1-git-send-email-Anson.Huang@nxp.com>
 <1554881866-26333-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f90759bd-3bf1-1db1-6338-1c90c705ee75@linaro.org>
Date:   Mon, 15 Apr 2019 22:07:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554881866-26333-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 09:43, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and thermal sensors etc..
> 
> This patch adds i.MX system controller thermal driver support,
> Linux kernel has to communicate with system controller via MU
> (message unit) IPC to get each thermal sensor's temperature,
> it supports multiple sensors which are passed from device tree,
> please see the binding doc for details.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V10:
> 	- remove "imx,sensor-resource-id" property, put the HW resource ID inside thermal-zones node,
> 	  and driver needs to parse the phandle argument to get HW resource ID and use it to register
> 	  thermal zone.
> ---
>  drivers/thermal/Kconfig          |  11 +++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/imx_sc_thermal.c | 159 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/thermal/imx_sc_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 653aa27..4e4fa7e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -223,6 +223,17 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config IMX_SC_THERMAL
> +	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
> +	depends on (ARCH_MXC && IMX_SCU) || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
> +	  system controller inside, Linux kernel has to communicate with system
> +	  controller via MU (message unit) IPC to get temperature from thermal
> +	  sensor. It supports one critical trip point and one
> +	  passive trip point for each thermal sensor.
> +
>  config MAX77620_THERMAL
>  	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>  	depends on MFD_MAX77620
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 486d682..4062627 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> +obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> new file mode 100644
> index 0000000..0af0f09
> --- /dev/null
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +#define IMX_SC_MISC_FUNC_GET_TEMP	13
> +#define IMX_SC_C_TEMP			0
> +
> +static struct imx_sc_ipc *thermal_ipc_handle;
> +
> +struct imx_sc_sensor {
> +	struct thermal_zone_device *tzd;
> +	u32 resource_id;
> +};
> +
> +struct req_get_temp {
> +	u16 resource_id;
> +	u8 type;
> +} __packed;
> +
> +struct resp_get_temp {
> +	u16 celsius;
> +	u8 tenths;
> +} __packed;
> +
> +struct imx_sc_msg_misc_get_temp {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct req_get_temp req;
> +		struct resp_get_temp resp;
> +	} data;
> +} __packed;

Do we really need to add the __packed for the struct imx_sc_sensor and
the struct imx_sc_msg_misc_get_temp?

> +static int imx_sc_thermal_get_temp(void *data, int *temp)
> +{
> +	struct imx_sc_msg_misc_get_temp msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	struct imx_sc_sensor *sensor = data;
> +	int ret;
> +
> +	msg.data.req.resource_id = sensor->resource_id;
> +	msg.data.req.type = IMX_SC_C_TEMP;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> +	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
> +	hdr->size = 2;
> +
> +	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> +	if (ret) {
> +		pr_err("read temp sensor %d failed, ret %d\n",
> +			sensor->resource_id, ret);
> +		return ret;
> +	}
> +
> +	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
> +	.get_temp = imx_sc_thermal_get_temp,
> +};
> +
> +static int imx_sc_thermal_get_sensor_id(struct device_node *sensor_np, u32 *id)
> +{
> +	struct of_phandle_args sensor_specs;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_args(sensor_np,
> +					 "thermal-sensors",
> +					 "#thermal-sensor-cells",
> +					 0,
> +					 &sensor_specs);
> +	if (ret)
> +		return ret;
> +
> +	if (sensor_specs.args_count >= 1) {
> +		*id = sensor_specs.args[0];
> +		WARN(sensor_specs.args_count > 1,
> +		     "%pOFn: too many cells in sensor specifier %d\n",
> +		     sensor_specs.np, sensor_specs.args_count);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_sc_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np, *child;
> +	int ret;
> +
> +	ret = imx_scu_get_handle(&thermal_ipc_handle);
> +	if (ret)
> +		return ret;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(np, child) {
> +		struct imx_sc_sensor *sensor =
> +			devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
> +		if (!sensor)
> +			return -ENOMEM;
> +
> +		ret = imx_sc_thermal_get_sensor_id(child, &sensor->resource_id);


IMO, this function should be generic and added to the of-thermal.c

> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to get valid sensor resource id: %d\n",
> +				ret);
> +			break;
> +		}
> +
> +		sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +								   sensor->resource_id,
> +								   sensor,
> +								   &imx_sc_thermal_ops);
> +		if (IS_ERR(sensor->tzd)) {
> +			dev_err(&pdev->dev, "failed to register thermal zone\n");
> +			ret = PTR_ERR(sensor->tzd);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
>
> +static const struct of_device_id imx_sc_thermal_table[] = {
> +	{ .compatible = "fsl,imx-sc-thermal", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
> +
> +static struct platform_driver imx_sc_thermal_driver = {
> +		.probe = imx_sc_thermal_probe,
> +		.driver = {
> +			.name = "imx-sc-thermal",
> +			.of_match_table = imx_sc_thermal_table,
> +		},
> +};
> +module_platform_driver(imx_sc_thermal_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system controller");
> +MODULE_LICENSE("GPL v2");
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


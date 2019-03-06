Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F9BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712CA20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS1gQPJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfCFQGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:06:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41864 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCFQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:06:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so8957311pfn.8;
        Wed, 06 Mar 2019 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J8MHLJs93wrjRd42BSejHjevUFgX7QUjTgz49rje4yw=;
        b=YS1gQPJy525uIoDtA4QEFtInFTnr90yNXvXpwGVl+J0sUBv1D3L5U+W4/0CXVpYJ7G
         odBFj5J3GnDw81MuK52ZkN+vfpNaXzHzRg0AyRRXfJtT7pAx5/LUAf8QGCH3a5DA//7w
         rbG/h48d6TVtb2k1BPoVxmrGjF/G5lYcHEaGOQErFMSaC3kUmJSsarBgnXV2f+VAYq35
         R0/wDn9zk+A6i71CuVNF8pRhnT/OBtcXu4t0jaOMrw1AVkXv4Z6MjhcwwaFpfEGgfG2n
         SSiL3bcS07ngnOmhZTD38ZJG0+9reu2TQqoHjdVY8zbyJ0uiCG7cYlp5eLUf8knAZ8yS
         2YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8MHLJs93wrjRd42BSejHjevUFgX7QUjTgz49rje4yw=;
        b=hKwfxNLkWWLT+QOwdGppu8Qpc/nBrx+gqST06WNjQq0dzxPFMpwmlJqY83B39lQzBc
         CK4JktZkyZNXLR1BhAF3kH5SiRgCHKJzto2NwYZ5Ib8QO9SKcTfbPDoHmkbBH7rs+KEq
         E0Pe3LwRIZwDWzDbcXvjx4pRudG+EqaDtOzAEdlE3iZ9TWXngF9ilaRnqlUEUCPPWhGV
         wLc/mr8a9eT+A7HhNWXwUjIqNs4WqD2/AnMS6XzP6UxZrx9J17xwCVMgvoG8mIMub6kE
         B8Hko0SMvtSyEuDLnpFyA3eN8J/UrkZAsc8V0S0ggtrIRFtOyxOHQ9vlg3tThjKwRbja
         v+Jw==
X-Gm-Message-State: APjAAAV0Rz0t+ySmCzm6Hb2RIWOJqMrT5nsSsvv/MRZvzs9dchKoly+y
        gCWv1u3Efp41mpLQUfO/jRk=
X-Google-Smtp-Source: APXvYqx5dXqLmC1YLl6Rsj76afi77MiEmr5HyvyRA7U4BE9l7MWZEfiGnIdczvTlZfAQsIFyKzNOxA==
X-Received: by 2002:a17:902:d20b:: with SMTP id t11mr7755705ply.318.1551888370504;
        Wed, 06 Mar 2019 08:06:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b8sm3833593pfi.129.2019.03.06.08.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:06:09 -0800 (PST)
Subject: Re: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b850967-d90a-5bd8-6ecf-99819f95805e@roeck-us.net>
Date:   Wed, 6 Mar 2019 08:06:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 5:06 PM, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and watchdog etc..
> 
> This patch adds i.MX system controller watchdog driver support,
> watchdog operation needs to be done in secure EL3 mode via
> ARM-Trusted-Firmware, using SMC call, CPU will trap into
> ARM-Trusted-Firmware and then it will request system controller
> to do watchdog operation via IPC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Guenter Roeck <linux@roekc-us.net>

> ---
> Changes since V6:
> 	- use module_platform_driver() instead of module_init/exit to make code simple.
> ---
>   drivers/watchdog/Kconfig      |  14 ++++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/imx_sc_wdt.c | 174 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 189 insertions(+)
>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 242eea8..33a6523 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -641,6 +641,20 @@ config IMX2_WDT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called imx2_wdt.
>   
> +config IMX_SC_WDT
> +	tristate "IMX SC Watchdog"
> +	depends on IMX_SCU
> +	depends on HAVE_ARM_SMCCC
> +	select WATCHDOG_CORE
> +	help
> +	  This is the driver for the system controller watchdog
> +	  on the NXP i.MX SoCs with system controller inside.
> +	  If you have one of these processors and wish to have
> +	  watchdog support enabled, say Y, otherwise say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called imx_sc_wdt.
> +
>   config UX500_WATCHDOG
>   	tristate "ST-Ericsson Ux500 watchdog"
>   	depends on MFD_DB8500_PRCMU
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index ba930e4..136d9f0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
>   obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>   obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>   obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
> +obj-$(CONFIG_IMX_SC_WDT) += imx_sc_wdt.o
>   obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>   obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>   obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o
> diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
> new file mode 100644
> index 0000000..ee48709
> --- /dev/null
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT 60
> +/*
> + * Software timer tick implemented in scfw side, support 10ms to 0xffffffff ms
> + * in theory, but for normal case, 1s~128s is enough, you can change this max
> + * value in case it's not enough.
> + */
> +#define MAX_TIMEOUT 128
> +
> +#define IMX_SIP_TIMER			0xC2000002
> +#define IMX_SIP_TIMER_START_WDOG		0x01
> +#define IMX_SIP_TIMER_STOP_WDOG		0x02
> +#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
> +#define IMX_SIP_TIMER_PING_WDOG		0x04
> +#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
> +#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
> +#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
> +
> +#define SC_TIMER_WDOG_ACTION_PARTITION	0
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0000);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int timeout = DEFAULT_TIMEOUT;
> +module_param(timeout, uint, 0000);
> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
> +
> +static int imx_sc_wdt_ping(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return 0;
> +}
> +
> +static int imx_sc_wdt_start(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		return -EACCES;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
> +		      SC_TIMER_WDOG_ACTION_PARTITION,
> +		      0, 0, 0, 0, 0, &res);
> +	return res.a0 ? -EACCES : 0;
> +}
> +
> +static int imx_sc_wdt_stop(struct watchdog_device *wdog)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0 ? -EACCES : 0;
> +}
> +
> +static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
> +				unsigned int timeout)
> +{
> +	struct arm_smccc_res res;
> +
> +	wdog->timeout = timeout;
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
> +		      timeout * 1000, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0 ? -EACCES : 0;
> +}
> +
> +static const struct watchdog_ops imx_sc_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = imx_sc_wdt_start,
> +	.stop  = imx_sc_wdt_stop,
> +	.ping  = imx_sc_wdt_ping,
> +	.set_timeout = imx_sc_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info imx_sc_wdt_info = {
> +	.identity	= "i.MX SC watchdog timer",
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT,
> +};
> +
> +static int imx_sc_wdt_probe(struct platform_device *pdev)
> +{
> +	struct watchdog_device *imx_sc_wdd;
> +	int ret;
> +
> +	imx_sc_wdd = devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
> +	if (!imx_sc_wdd)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, imx_sc_wdd);
> +
> +	imx_sc_wdd->info = &imx_sc_wdt_info;
> +	imx_sc_wdd->ops = &imx_sc_wdt_ops;
> +	imx_sc_wdd->min_timeout = 1;
> +	imx_sc_wdd->max_timeout = MAX_TIMEOUT;
> +	imx_sc_wdd->parent = &pdev->dev;
> +	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
> +
> +	ret = watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to set timeout value, using default\n");
> +
> +	watchdog_stop_on_reboot(imx_sc_wdd);
> +	watchdog_stop_on_unregister(imx_sc_wdd);
> +
> +	ret = devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
> +{
> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(imx_sc_wdd))
> +		imx_sc_wdt_stop(imx_sc_wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
> +{
> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(imx_sc_wdd))
> +		imx_sc_wdt_start(imx_sc_wdd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
> +			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
> +
> +static struct platform_driver imx_sc_wdt_driver = {
> +	.probe		= imx_sc_wdt_probe,
> +	.driver		= {
> +		.name	= "imx-sc-wdt",
> +		.pm	= &imx_sc_wdt_pm_ops,
> +	},
> +};
> +module_platform_driver(imx_sc_wdt_driver);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
> +MODULE_LICENSE("GPL v2");
> 


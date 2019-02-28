Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B2EC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183A22184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCmVNKz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfB1O6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:58:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45562 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfB1O6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:58:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so9829010pfm.12;
        Thu, 28 Feb 2019 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zPeOUPiYZ2bidBkLyojOpzpk15cGGdqYqObBBwY45jM=;
        b=vCmVNKz5q5P5fMTZ7u1MS/+6Jl63GCji9U4Dcs6+50ZlCr1OTfG5GAnRd8s1dcJvCh
         Z5gINLlHTPhh9QWCqgjONMQa3eXFpCaIfiaDjraLZX97bJyiQKzBIR85K05YBETvTOiv
         +mIG+WCjKop2daoEfYYJNaU7TfQjFGr76ILuwFLE+kleIIaub9jqQsekOZw3nVImn65B
         oKSUG4SojCDNaIfIrc1pyD7O3zQPppl0Msc3x3qhM781J5HsWXzYKhViEftg7NfXcUDZ
         LmuTs65Wt4lBGxFugiKnBcqlOkpewaLglDhzf/6GCgWR//p/PYGAh+LCrSZqyY04uRR8
         WSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPeOUPiYZ2bidBkLyojOpzpk15cGGdqYqObBBwY45jM=;
        b=hqlRcXWo176ETGd5KmUGhfv+WLRsGnUlbcBfwMbXXvkxYk0TBXuDKlN/WOQMz4FshX
         w7NhTiL5UOQOd1HR6aIYXw7a7ztavT6CRGZ6n/sQCax1a7fpWA9kNwUgHX/GOGyewJbf
         IIZvbHkxCYC3OouRO+rERFBRmolnz/fO/wZX3ZQw3Q50+ZJZ797n+IGFLI2rPxZee219
         /7yc4vr45ZYkFd6Bbgqj+pxTtHKso1uFmwtl3jQj6SMl5kMkTDzkTEF2RWN6lLqQu/VT
         YO9QTc0EjgYLi5WIjRtVvHtm3mVzPojYg03PVyD5U16wRrUZdzAH3aRXJl37eQmjPyZt
         6g2A==
X-Gm-Message-State: AHQUAuZ6p9CyfqdYxJHNixUiv/xnpdiz+Cx+HKPKpyw3oXOPmr57X4M/
        uCnTxyD6vfWSBGSaZGwM/b0=
X-Google-Smtp-Source: AHgI3IZpffKtOC7bIvdIgfO//QtkY05bkN1+7T1u5u+nSNrhu85X8wm5Geqw+aXuwhnp7Rf4O6Iuyw==
X-Received: by 2002:a63:d357:: with SMTP id u23mr8678672pgi.153.1551365912188;
        Thu, 28 Feb 2019 06:58:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186sm37067689pga.36.2019.02.28.06.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:58:31 -0800 (PST)
Subject: Re: [PATCH V4 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1551340510-2324-1-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <575f5a40-5590-12fc-e117-a97577982844@roeck-us.net>
Date:   Thu, 28 Feb 2019 06:58:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551340510-2324-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 11:59 PM, Anson Huang wrote:
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
> ---
> Changes since V3:
>          - add ARM64 dependency for this driver;
>          - change SPDX license to GPL-2.0 to match module license;
>          - register platform device in driver instead of getting from dts;
> 	- return linux error code instead of system controller firmware error code for watchdog operation
> 	  failed case.
> ---
>   drivers/watchdog/Kconfig      |  13 +++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/imx_sc_wdt.c | 201 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 215 insertions(+)
>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 65c3c42..8c6575e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -625,6 +625,19 @@ config IMX2_WDT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called imx2_wdt.
>   
> +config IMX_SC_WDT
> +	tristate "IMX SC Watchdog"
> +	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
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

With this patch applied, alpha:allmodconfig and almost all other
allmodconfig/allyesconfig builds fail with:

ERROR: "__arm_smccc_smc" [drivers/watchdog/imx_sc_wdt.ko] undefined!
scripts/Makefile.modpost:92: recipe for target '__modpost' failed
make[1]: *** [__modpost] Error 1
Makefile:1260: recipe for target 'modules' failed

as I told you before would happen. For the future, please consider
that forcing me to "prove" such failures does take a significant
amount of time, which is not always readily available.

Guenter


>   config UX500_WATCHDOG
>   	tristate "ST-Ericsson Ux500 watchdog"
>   	depends on MFD_DB8500_PRCMU
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 4e78a8c..0c9da63 100644
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
> index 0000000..50b49b2
> --- /dev/null
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -0,0 +1,201 @@
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
> +#include <linux/of.h>
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
> +static struct platform_device *imx_sc_wdt_pdev;
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
> +
> +static int __init imx_sc_wdt_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&imx_sc_wdt_driver);
> +	if (ret)
> +		return ret;
> +
> +	imx_sc_wdt_pdev = platform_device_register_simple("imx-sc-wdt", -1, NULL, 0);
> +	if (IS_ERR(imx_sc_wdt_pdev)) {
> +		platform_driver_unregister(&imx_sc_wdt_driver);
> +		return PTR_ERR(imx_sc_wdt_pdev);
> +	}
> +
> +	return 0;
> +}
> +module_init(imx_sc_wdt_init);
> +
> +static void __exit imx_sc_wdt_exit(void)
> +{
> +	platform_driver_unregister(&imx_sc_wdt_driver);
> +	platform_device_unregister(imx_sc_wdt_pdev);
> +}
> +module_exit(imx_sc_wdt_exit);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
> +MODULE_LICENSE("GPL v2");
> 


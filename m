Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1759BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600E20652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX/UwwZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfCDNxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:53:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34643 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfCDNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:53:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so3165247pgd.1;
        Mon, 04 Mar 2019 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K4QBlbmaFUa1jSEn4J2Cliq8zh+ss9xsRhAItqI5N5Q=;
        b=EX/UwwZ2jduXnaTPSA2RAhX+uja2GsmNMlx9g2rVHOfXJXFc5ovXxn76fPqhGU5b+L
         4rtrXGH1q241UmpRG7drlMjMQ8B9cxnmhAvq+nmSd9kNTTERA1lrjZcAcEO/G0lMtst0
         w8NV82bL5bsgKvv+Jpb00S5ABnhqeuKGEZN4kisR5jslpqb+vPszuAgsedU05EhcirvY
         2tNzc1f3XyU3avreq90dXfFY34oQFIsjTgqpo2Ha2cu3iloN9Ks4+dp9Aolnk226MRMT
         eJBqp0ucR447nnLtGJJvQXbZuXqbQJGNfzeVXR+ocRp20pj6WR/m7KIq82DdZ71HZzHa
         orEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K4QBlbmaFUa1jSEn4J2Cliq8zh+ss9xsRhAItqI5N5Q=;
        b=pmm3G+bqjXV31fLiTy9/0fgyBjub5m2tD7hvO4ZgzrlHcabYDMMqobveh75pOZzubD
         cQ+xQO59rsohrK1sgrVgKVoInRdyEc/Xjp90iqIpWAp9slQh0dOnZt91mpBaw79MGgby
         CYgMWE8ulyq2UJbHbbsfcMXXvPHU1U6HS6wyzVlRVm/C4Fu9vADYQLXD0UBMvXmRLPSC
         iBdDylrHmJpEsndCj2MIJROlvqyf70SaWpz6d23kfXVSeADoEzcYoNyAJ6Bt4sY+/p17
         /2rJSHue+IyC/IB8tEvMh6MNZL/LOJnM8z0AC8CjZjAHgPjSs1P4xd0b5X0yWlc7JaC5
         Z3HA==
X-Gm-Message-State: APjAAAXdRGBSwAhlK3StXVN7huPa7Z3IpM4LVyEXm7XkTEq+OI7iSqTc
        uHkIWYAWNC98WULIRepewzQ=
X-Google-Smtp-Source: AHgI3IafTBfG2HIZdUf1Wi1IX74OwSXX38HskX2uJscWSn7sHQC+nFaF7BZClGu7Lp0ypSLggyShdA==
X-Received: by 2002:a62:138f:: with SMTP id 15mr19989886pft.219.1551707588689;
        Mon, 04 Mar 2019 05:53:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm8595566pgj.64.2019.03.04.05.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:53:07 -0800 (PST)
Subject: Re: [PATCH V5 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1551421837-21230-1-git-send-email-Anson.Huang@nxp.com>
 <20190301183141.GA26332@roeck-us.net>
 <DB3PR0402MB39165C1FE3289E145E86DAA1F5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <19c52bda-aaaa-f67d-3627-d5a303386dae@roeck-us.net>
 <DB3PR0402MB39166CAAF8DA49931A02A315F5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4453525f-7cdf-2b2c-8d6d-beb87af7fb9a@roeck-us.net>
Date:   Mon, 4 Mar 2019 05:53:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39166CAAF8DA49931A02A315F5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/19 7:22 PM, Anson Huang wrote:
> Hi, Guenter
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
>> Roeck
>> Sent: 2019年3月4日 10:46
>> To: Anson Huang <anson.huang@nxp.com>
>> Cc: catalin.marinas@arm.com; will.deacon@arm.com; wim@linux-
>> watchdog.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; Andy Gross
>> <andy.gross@linaro.org>; heiko@sntech.de; horms+renesas@verge.net.au;
>> arnd@arndb.de; olof@lixom.net; bjorn.andersson@linaro.org;
>> jagan@amarulasolutions.com; enric.balletbo@collabora.com;
>> marc.w.gonzalez@free.fr; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>
>> Subject: Re: [PATCH V5 1/2] watchdog: imx_sc: Add i.MX system controller
>> watchdog support
>>
>> On 3/3/19 5:32 PM, Anson Huang wrote:
>>> Hi, Guenter
>>>
>>> Best Regards!
>>> Anson Huang
>>>
>>>> -----Original Message-----
>>>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
>>>> Roeck
>>>> Sent: 2019年3月2日 2:32
>>>> To: Anson Huang <anson.huang@nxp.com>
>>>> Cc: catalin.marinas@arm.com; will.deacon@arm.com; wim@linux-
>>>> watchdog.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
>>>> kernel@pengutronix.de; festevam@gmail.com; Andy Gross
>>>> <andy.gross@linaro.org>; heiko@sntech.de;
>> horms+renesas@verge.net.au;
>>>> arnd@arndb.de; olof@lixom.net; bjorn.andersson@linaro.org;
>>>> jagan@amarulasolutions.com; enric.balletbo@collabora.com;
>>>> marc.w.gonzalez@free.fr; linux-arm-kernel@lists.infradead.org; linux-
>>>> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; dl-linux-imx
>>>> <linux-imx@nxp.com>
>>>> Subject: Re: [PATCH V5 1/2] watchdog: imx_sc: Add i.MX system
>>>> controller watchdog support
>>>>
>>>> On Fri, Mar 01, 2019 at 06:35:31AM +0000, Anson Huang wrote:
>>>>> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
>>>>> inside, the system controller is in charge of controlling power,
>>>>> clock and watchdog etc..
>>>>>
>>>>> This patch adds i.MX system controller watchdog driver support,
>>>>> watchdog operation needs to be done in secure EL3 mode via
>>>>> ARM-Trusted-Firmware, using SMC call, CPU will trap into
>>>>> ARM-Trusted-Firmware and then it will request system controller to
>>>>> do watchdog operation via IPC.
>>>>>
>>>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>>>> ---
>>>>> Changes since V4:
>>>>> 	- change the module build dependency as depends on IMX_SCU and
>>>> HAVE_ARM_SMCCC, as this
>>>>> 	  driver is ONLY for i.MX SoC with SCU inside and it uses ARM SMC call.
>>>>> ---
>>>>>    drivers/watchdog/Kconfig      |  14 +++
>>>>>    drivers/watchdog/Makefile     |   1 +
>>>>>    drivers/watchdog/imx_sc_wdt.c | 201
>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 216 insertions(+)
>>>>>    create mode 100644 drivers/watchdog/imx_sc_wdt.c
>>>>>
>>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>>> index
>>>>> 65c3c42..a6bfa54 100644
>>>>> --- a/drivers/watchdog/Kconfig
>>>>> +++ b/drivers/watchdog/Kconfig
>>>>> @@ -625,6 +625,20 @@ config IMX2_WDT
>>>>>    	  To compile this driver as a module, choose M here: the
>>>>>    	  module will be called imx2_wdt.
>>>>>
>>>>> +config IMX_SC_WDT
>>>>> +	tristate "IMX SC Watchdog"
>>>>> +	depends on IMX_SCU
>>>>> +	depends on HAVE_ARM_SMCCC
>>>>> +	select WATCHDOG_CORE
>>>>> +	help
>>>>> +	  This is the driver for the system controller watchdog
>>>>> +	  on the NXP i.MX SoCs with system controller inside.
>>>>> +	  If you have one of these processors and wish to have
>>>>> +	  watchdog support enabled, say Y, otherwise say N.
>>>>> +
>>>>> +	  To compile this driver as a module, choose M here: the
>>>>> +	  module will be called imx_sc_wdt.
>>>>> +
>>>>>    config UX500_WATCHDOG
>>>>>    	tristate "ST-Ericsson Ux500 watchdog"
>>>>>    	depends on MFD_DB8500_PRCMU
>>>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>>>> index 4e78a8c..0c9da63 100644
>>>>> --- a/drivers/watchdog/Makefile
>>>>> +++ b/drivers/watchdog/Makefile
>>>>> @@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) +=
>>>> nuc900_wdt.o
>>>>>    obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>>>>>    obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>>>>>    obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>>>>> +obj-$(CONFIG_IMX_SC_WDT) += imx_sc_wdt.o
>>>>>    obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>>>>>    obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>>>>>    obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o diff --git
>>>>> a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
>> new
>>>>> file mode 100644 index 0000000..50b49b2
>>>>> --- /dev/null
>>>>> +++ b/drivers/watchdog/imx_sc_wdt.c
>>>>> @@ -0,0 +1,201 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Copyright 2018-2019 NXP.
>>>>> + */
>>>>> +
>>>>> +#include <linux/arm-smccc.h>
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/moduleparam.h>
>>>>> +#include <linux/of.h>
>>>>
>>>> Should no longer be needed.
>>>
>>> Correct, I will remove it.
>>>
>>>>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/reboot.h>
>>>>> +#include <linux/watchdog.h>
>>>>> +
>>>>> +#define DEFAULT_TIMEOUT 60
>>>>> +/*
>>>>> + * Software timer tick implemented in scfw side, support 10ms to
>>>>> +0xffffffff ms
>>>>> + * in theory, but for normal case, 1s~128s is enough, you can
>>>>> +change this max
>>>>> + * value in case it's not enough.
>>>>> + */
>>>>> +#define MAX_TIMEOUT 128
>>>>> +
>>>>> +#define IMX_SIP_TIMER			0xC2000002
>>>>> +#define IMX_SIP_TIMER_START_WDOG		0x01
>>>>> +#define IMX_SIP_TIMER_STOP_WDOG		0x02
>>>>> +#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
>>>>> +#define IMX_SIP_TIMER_PING_WDOG		0x04
>>>>> +#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
>>>>> +#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
>>>>> +#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
>>>>> +
>>>>> +#define SC_TIMER_WDOG_ACTION_PARTITION	0
>>>>> +
>>>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>>>> module_param(nowayout,
>>>>> +bool, 0000); MODULE_PARM_DESC(nowayout, "Watchdog cannot be
>>>> stopped
>>>>> +once started (default="
>>>>> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>>>> +
>>>>> +static unsigned int timeout = DEFAULT_TIMEOUT;
>>>>> +module_param(timeout, uint, 0000); MODULE_PARM_DESC(timeout,
>>>>> +"Watchdog timeout in
>>>> seconds
>>>>> +(default="
>>>>> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
>>>>> +
>>>>> +static struct platform_device *imx_sc_wdt_pdev;
>>>>> +
>>>>> +static int imx_sc_wdt_ping(struct watchdog_device *wdog) {
>>>>> +	struct arm_smccc_res res;
>>>>> +
>>>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
>>>>> +		      0, 0, 0, 0, 0, 0, &res);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int imx_sc_wdt_start(struct watchdog_device *wdog) {
>>>>> +	struct arm_smccc_res res;
>>>>> +
>>>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
>>>>> +		      0, 0, 0, 0, 0, 0, &res);
>>>>> +	if (res.a0)
>>>>> +		return -EACCES;
>>>>> +
>>>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
>>>>> +		      SC_TIMER_WDOG_ACTION_PARTITION,
>>>>> +		      0, 0, 0, 0, 0, &res);
>>>>> +	return res.a0 ? -EACCES : 0;
>>>>> +}
>>>>> +
>>>>> +static int imx_sc_wdt_stop(struct watchdog_device *wdog) {
>>>>> +	struct arm_smccc_res res;
>>>>> +
>>>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
>>>>> +		      0, 0, 0, 0, 0, 0, &res);
>>>>> +
>>>>> +	return res.a0 ? -EACCES : 0;
>>>>> +}
>>>>> +
>>>>> +static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
>>>>> +				unsigned int timeout)
>>>>> +{
>>>>> +	struct arm_smccc_res res;
>>>>> +
>>>>> +	wdog->timeout = timeout;
>>>>> +	arm_smccc_smc(IMX_SIP_TIMER,
>>>> IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
>>>>> +		      timeout * 1000, 0, 0, 0, 0, 0, &res);
>>>>> +
>>>>> +	return res.a0 ? -EACCES : 0;
>>>>> +}
>>>>> +
>>>>> +static const struct watchdog_ops imx_sc_wdt_ops = {
>>>>> +	.owner = THIS_MODULE,
>>>>> +	.start = imx_sc_wdt_start,
>>>>> +	.stop  = imx_sc_wdt_stop,
>>>>> +	.ping  = imx_sc_wdt_ping,
>>>>> +	.set_timeout = imx_sc_wdt_set_timeout, };
>>>>> +
>>>>> +static const struct watchdog_info imx_sc_wdt_info = {
>>>>> +	.identity	= "i.MX SC watchdog timer",
>>>>> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>>>>> +			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT, };
>>>>> +
>>>>> +static int imx_sc_wdt_probe(struct platform_device *pdev) {
>>>>> +	struct watchdog_device *imx_sc_wdd;
>>>>> +	int ret;
>>>>> +
>>>>> +	imx_sc_wdd = devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd),
>>>> GFP_KERNEL);
>>>>> +	if (!imx_sc_wdd)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	platform_set_drvdata(pdev, imx_sc_wdd);
>>>>> +
>>>>> +	imx_sc_wdd->info = &imx_sc_wdt_info;
>>>>> +	imx_sc_wdd->ops = &imx_sc_wdt_ops;
>>>>> +	imx_sc_wdd->min_timeout = 1;
>>>>> +	imx_sc_wdd->max_timeout = MAX_TIMEOUT;
>>>>> +	imx_sc_wdd->parent = &pdev->dev;
>>>>> +	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
>>>>> +
>>>>> +	ret = watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
>>>>> +	if (ret)
>>>>> +		dev_warn(&pdev->dev, "Failed to set timeout value, using
>>>>> +default\n");
>>>>> +
>>>>> +	watchdog_stop_on_reboot(imx_sc_wdd);
>>>>> +	watchdog_stop_on_unregister(imx_sc_wdd);
>>>>> +
>>>>> +	ret = devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
>>>>> +	if (ret) {
>>>>> +		dev_err(&pdev->dev, "Failed to register watchdog device\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int __maybe_unused imx_sc_wdt_suspend(struct device *dev) {
>>>>> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
>>>>> +
>>>>> +	if (watchdog_active(imx_sc_wdd))
>>>>> +		imx_sc_wdt_stop(imx_sc_wdd);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int __maybe_unused imx_sc_wdt_resume(struct device *dev) {
>>>>> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
>>>>> +
>>>>> +	if (watchdog_active(imx_sc_wdd))
>>>>> +		imx_sc_wdt_start(imx_sc_wdd);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
>>>>> +			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
>>>>> +
>>>>> +static struct platform_driver imx_sc_wdt_driver = {
>>>>> +	.probe		= imx_sc_wdt_probe,
>>>>> +	.driver		= {
>>>>> +		.name	= "imx-sc-wdt",
>>>>> +		.pm	= &imx_sc_wdt_pm_ops,
>>>>> +	},
>>>>> +};
>>>>> +
>>>>> +static int __init imx_sc_wdt_init(void) {
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = platform_driver_register(&imx_sc_wdt_driver);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	imx_sc_wdt_pdev = platform_device_register_simple("imx-sc-wdt", -
>>>> 1, NULL, 0);
>>>>> +	if (IS_ERR(imx_sc_wdt_pdev)) {
>>>>> +		platform_driver_unregister(&imx_sc_wdt_driver);
>>>>> +		return PTR_ERR(imx_sc_wdt_pdev);
>>>>> +	}
>>>>
>>>> I just realized what you are doing here. So the watchdog will always
>>>> be instantiated if/when the module is loaded. I don't think that was
>>>> the idea, and it seems to be risky. What happens if someone loads the
>>>> module on a system where the watchdog is not supported ? There maye
>>>> be lots of "Access Denied" errors, or something undefined may happen.
>>>
>>> I thought the "depends on IMX_SCU" was already added in Kconfig, that
>>> means the module will be ONLY built with IMX_SCU enabled, and watchdog
>>> will be always enabled if IMX_SCU is enabled. Is it safe enough?
>>>
>> No. The driver will be built with arm64:defconfig, meaning it will be built for
>> all arm64 systems using defconfig. Any such system will have the driver
>> installed as module, and nothing will prevent the user from running
>> modprobe. But even if it wasn't enabled with defconfig, we must not
>> instantiate the driver on an arbitrary system.
>>
>>>>
>>>> Is everyone on Cc: ok with this ? Is this how we handle
>>>> instantiations nowadays ?  Or should the driver be instantiated from
>>>> imx_scu_probe() in drivers/firmware/imx/imx-scu.c ?
>>>>
>>>> Sorry if the answer is obvious, but I am still struggling with "no
>>>> more instantiations through devicetree".
>>>>
>>>> If the driver is auto-instantiated when the module is loaded, as
>>>> currently written, there needs to be some check if it is actually
>>>> supported, possibly in
>>>> imx_sc_wdt_init() or, if that is not possible, in the probe function.
>>>> I don't like that, but it would at least prevent the module from
>>>> being loaded when the hardware is not supported.
>>>
>>> Other modules depend on the IMX_SCU IPC will have defer probe there to
>>> make sure IMX_SCU driver is ready for IPC handle, since watchdog
>>> driver ONLY uses ARM SMC but no IPC call, so I did NOT add the defer
>>> probe handle here, so if adding it can answer your question/concern,
>>> then I can add it, although I think the dependency in Kconfig should
>>> be good here. Without SCU firmware ready, the SoC does NOT boot up A
>> core with ATF/Linux at all.
>>>
>> That has nothing to do with deferred probing. My concern is that the driver
>> will be instantiated just by loading it, no matter if the hardware supporting it
>> is present or not.
>>
>> Having a devicetree node would have prevented that since it instantiates the
>> child drivers with devm_of_platform_populate() in imx_scu_probe(). The
>> equivalent is to register the platform device from imx_scu_probe().
>> That is the only means to prevent the driver from being instantiated where it
>> shouldn't. As mentioned before, I would have preferred the devicetree
>> method, but having it no longer available doesn't mean that we should add
>> risky code.
>>
>> Maybe you can check in the init function if the 'fsl,imx-scu' node exists, and
>> instantiate the driver if it does. I don't like that either, but it would be
>> acceptable to me - and maybe better than instantiating it manually from
>> imx_scu_probe().
> 
> OK, I can add check of "fsl,imx-scu" in init function and ONLY instantiate the driver if
> it exist, since there is no watchdog node in devicetree and "fsl,imx-scu" should be treated
> as watchdog node, so adding such check also makes some sense, putting it inside SCU
> driver is NOT that good I think, do you agree?
> 

I dislike both. Putting it into the SCU driver probe function would be more
appropriate. Putting it into the watchdog driver is worse since it should
really only be instantiated if (and after) the parent driver is instantiated,
and the parent driver should be listed as its parent. That will get lost
if you put the check into the watchdog driver.

I would suggest to submit the patch for the SCU driver first. If that gets
rejected by its maintainer, we'll have to do it in the watchdog driver.

Guenter

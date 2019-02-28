Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2506F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSNCTk9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfB1OZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:25:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34023 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfB1OZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:25:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so9816051pfn.1;
        Thu, 28 Feb 2019 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V+A8lnuwtppMC4E5jx4m1uiVOVP/JT6ZWJVoU+0uEbQ=;
        b=fSNCTk9m6b7iqLBNUprc7OjiofHX7C4WHZHe9Z/WRDVGilHOI5XQHFXWURRIJVKzlX
         DAfKTSREMIszJX7WGqODRxIJwZHCq4AbSdqTHk5vq6IfXN+Wsfn87sK3llsr8z3Al55O
         JZj0DhGWbocdqoIfsAiyeYEfA0KIhQOuUald/FBkKh1sVLQMx8/eVK6xox1d6xw0RT0K
         XqjOvRWg6SdoxLJOGLjQA4NFxASqSIRvHRKY1Zi9wyJmDk/EPz9tv3lPSKG3Gxxzy51t
         61WJOfrU8uDICI/FdYSy/ykfL3kL4L0v4DcHQIu3IArr0DPQz+300eIWAm3WIPpX1cAg
         G5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V+A8lnuwtppMC4E5jx4m1uiVOVP/JT6ZWJVoU+0uEbQ=;
        b=uc8k4v7CdJQ1dYbOOSiqUfzo9/kw7myFSzf27uR3cJ1OwjwpEKpdPtNWvEizu2c9py
         22LMKISkDZC0gDf8OAwBqlHM5Gw9n2ZGUHHLAmtgRmczui2YhpOTuFIgktkn4dWcJbF7
         nDAJuzfOyWbshnkTaTc0DEOQ67SVdTYB6vM2TiCG87kIurc5sBWOrhU7LlvxN3kwSM8O
         eTewLbHmoBwbwuJ5Ggkcctd2ldhSCsH7PuSsft/sqSyTK/6DvLkgO4pRcsddCx1phrY/
         kjV9PL1/AlTadnQkvUd77yeJ0LiI9XPhXWDNlSAmp004zQpLD20wGYPNiQ7sBvdvkUlI
         7zUw==
X-Gm-Message-State: AHQUAuba58HlpgSxLC5Xq5286WTxNX035eF4aOupeytfd0BO58XLQOkF
        9whiedA3BbfamsM/+4NZGsw=
X-Google-Smtp-Source: AHgI3IYFTi4phi2GSRZIZMGVkXdekekaTsC8hg1giVj5PUGIqGVZB0pLEkWJUwnby2pdUwOWCKTsfg==
X-Received: by 2002:a63:69c2:: with SMTP id e185mr8757742pgc.4.1551363925948;
        Thu, 28 Feb 2019 06:25:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k7sm52057375pgr.28.2019.02.28.06.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:25:24 -0800 (PST)
Subject: Re: [PATCH V3 2/4] watchdog: imx_sc: Add i.MX system controller
 watchdog support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
 <1551060850-22553-3-git-send-email-Anson.Huang@nxp.com>
 <20190226223846.GB30985@roeck-us.net>
 <AM6PR0402MB39111FFC11568D4FD342D5A5F5750@AM6PR0402MB3911.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4a625bd0-cee2-02ca-a3f4-52ad08ec6893@roeck-us.net>
Date:   Thu, 28 Feb 2019 06:25:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <AM6PR0402MB39111FFC11568D4FD342D5A5F5750@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 10:15 PM, Anson Huang wrote:
> Hi, Guenter
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
>> Roeck
>> Sent: 2019Äê2ÔÂ27ÈÕ 6:39
>> To: Anson Huang <anson.huang@nxp.com>
>> Cc: robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
>> catalin.marinas@arm.com; will.deacon@arm.com; wim@linux-watchdog.org;
>> Aisheng Dong <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel
>> Baluta <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>;
>> horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb.de;
>> olof@lixom.net; bjorn.andersson@linaro.org; jagan@amarulasolutions.com;
>> enric.balletbo@collabora.com; marc.w.gonzalez@free.fr;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-watchdog@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>
>> Subject: Re: [PATCH V3 2/4] watchdog: imx_sc: Add i.MX system controller
>> watchdog support
>>
>> On Mon, Feb 25, 2019 at 02:19:10AM +0000, Anson Huang wrote:
>>> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
>>> inside, the system controller is in charge of controlling power, clock
>>> and watchdog etc..
>>>
>>> This patch adds i.MX system controller watchdog driver support,
>>> watchdog operation needs to be done in secure EL3 mode via
>>> ARM-Trusted-Firmware, using SMC call, CPU will trap into
>>> ARM-Trusted-Firmware and then it will request system controller to do
>>> watchdog operation via IPC.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>> Changes since V2:
>>> 	- improve watchdog_init_timeout() operation and error check,
>> setting it
>>> 	  via module parameter "timeout", if it is invalid, roll back to use
>> defaul
>>> 	  timeout value DEFAULT_TIMEOUT;
>>> 	- change compatible string to "fsl,imx-sc-wdt" to make driver more
>> generic
>>> 	  for all i.MX platforms with system controller watchdog inside.
>>> ---
>>>   drivers/watchdog/Kconfig      |  13 +++
>>>   drivers/watchdog/Makefile     |   1 +
>>>   drivers/watchdog/imx_sc_wdt.c | 183
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 197 insertions(+)
>>>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
>>> 65c3c42..5c5b8ba 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -625,6 +625,19 @@ config IMX2_WDT
>>>   	  To compile this driver as a module, choose M here: the
>>>   	  module will be called imx2_wdt.
>>>
>>> +config IMX_SC_WDT
>>> +	tristate "IMX SC Watchdog"
>>> +	depends on ARCH_MXC || COMPILE_TEST
>>
>> Wondering: Did you test on other architectures ? The code calls
>> arm_smccc_smc(), which is unlikely to be available on non-ARM platforms,
>> and I don't see a dummy declaration for those.
> 
> Although the ARCH_MXC means for Freescale i.MX SoCs which are all with
> ARM platforms, but since this driver is targeted for i.MX SoC ARMv8 with system
> controller inside, so I will add ARM64 dependency here.
> 
> +       depends on (ARCH_MXC && ARM64) || COMPILE_TEST
> 

You are missing my point. It will still try to compile with, say,
alpha:allmodconfig (or x86_64:allmodconfig). Did you try that ?

Guenter

>>
>>> +	select WATCHDOG_CORE
>>> +	help
>>> +	  This is the driver for the system controller watchdog
>>> +	  on the NXP i.MX SoCs with system controller inside.
>>> +	  If you have one of these processors and wish to have
>>> +	  watchdog support enabled, say Y, otherwise say N.
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called imx_sc_wdt.
>>> +
>>>   config UX500_WATCHDOG
>>>   	tristate "ST-Ericsson Ux500 watchdog"
>>>   	depends on MFD_DB8500_PRCMU
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index 4e78a8c..0c9da63 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) +=
>> nuc900_wdt.o
>>>   obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
>>>   obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
>>>   obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
>>> +obj-$(CONFIG_IMX_SC_WDT) += imx_sc_wdt.o
>>>   obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
>>>   obj-$(CONFIG_RETU_WATCHDOG) += retu_wdt.o
>>>   obj-$(CONFIG_BCM2835_WDT) += bcm2835_wdt.o diff --git
>>> a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c new
>>> file mode 100644 index 0000000..7b22575
>>> --- /dev/null
>>> +++ b/drivers/watchdog/imx_sc_wdt.c
>>> @@ -0,0 +1,183 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright 2018-2019 NXP.
>>> + */
>>> +
>>> +#include <linux/arm-smccc.h>
>>> +#include <linux/io.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/reboot.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +#define DEFAULT_TIMEOUT 60
>>> +/*
>>> + * Software timer tick implemented in scfw side, support 10ms to
>>> +0xffffffff ms
>>> + * in theory, but for normal case, 1s~128s is enough, you can change
>>> +this max
>>> + * value in case it's not enough.
>>> + */
>>> +#define MAX_TIMEOUT 128
>>> +
>>> +#define IMX_SIP_TIMER			0xC2000002
>>> +#define IMX_SIP_TIMER_START_WDOG		0x01
>>> +#define IMX_SIP_TIMER_STOP_WDOG		0x02
>>> +#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
>>> +#define IMX_SIP_TIMER_PING_WDOG		0x04
>>> +#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
>>> +#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
>>> +#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
>>> +
>>> +#define SC_TIMER_WDOG_ACTION_PARTITION	0
>>> +
>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> module_param(nowayout,
>>> +bool, 0000); MODULE_PARM_DESC(nowayout, "Watchdog cannot be
>> stopped
>>> +once started (default="
>>> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>> +
>>> +static unsigned int timeout = DEFAULT_TIMEOUT;
>>
>> I assume this means that you specifically do _not_ want to support timeout
>> configuration via devicetree (unless the user explicitly sets the timeout to 0
>> here).
>>
>> Not that it really matters, since it looks like Rob won't accept a watchdog
>> node anyway.
> 
> Yes, currently we will NOT get it from devicetree, although user can still pass
> it via insmod parameter, but if the parameter is NOT specified or is invalid,
> default value will be used.
> 
>>
>>> +module_param(timeout, uint, 0000);
>>> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
>>> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
>>> +
>>> +static int imx_sc_wdt_ping(struct watchdog_device *wdog) {
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
>>> +		      0, 0, 0, 0, 0, 0, &res);
>>> +
>>> +	return res.a0;
>>
>> I didn't comment on this before, but I am wondering: Does the system
>> controller code return Linux error codes ? Is this documented somewhere ?
> 
> I checked our system controller firmware, the ONLY possible error code system controller
> returns is SC_ERR_NOACCESS, so I will make it return -EACCES if error happen, for the
> ping operation, system controller always returns 0, so I will make it return 0.
> 
>>
>>> +}
>>> +
>>> +static int imx_sc_wdt_start(struct watchdog_device *wdog) {
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
>>> +		      0, 0, 0, 0, 0, 0, &res);
>>> +	if (res.a0)
>>> +		return res.a0;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
>>> +		      SC_TIMER_WDOG_ACTION_PARTITION,
>>> +		      0, 0, 0, 0, 0, &res);
>>> +	return res.a0;
>>> +}
>>> +
>>> +static int imx_sc_wdt_stop(struct watchdog_device *wdog) {
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
>>> +		      0, 0, 0, 0, 0, 0, &res);
>>> +
>>> +	return res.a0;
>>> +}
>>> +
>>> +static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
>>> +				unsigned int timeout)
>>> +{
>>> +	struct arm_smccc_res res;
>>> +
>>> +	wdog->timeout = timeout;
>>> +	arm_smccc_smc(IMX_SIP_TIMER,
>> IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
>>> +		      timeout * 1000, 0, 0, 0, 0, 0, &res);
>>> +
>>> +	return res.a0;
>>> +}
>>> +
>>> +static const struct watchdog_ops imx_sc_wdt_ops = {
>>> +	.owner = THIS_MODULE,
>>> +	.start = imx_sc_wdt_start,
>>> +	.stop  = imx_sc_wdt_stop,
>>> +	.ping  = imx_sc_wdt_ping,
>>> +	.set_timeout = imx_sc_wdt_set_timeout, };
>>> +
>>> +static const struct watchdog_info imx_sc_wdt_info = {
>>> +	.identity	= "i.MX SC watchdog timer",
>>> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>>> +			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT, };
>>> +
>>> +static int imx_sc_wdt_probe(struct platform_device *pdev) {
>>> +	struct watchdog_device *imx_sc_wdd;
>>> +	int ret;
>>> +
>>> +	imx_sc_wdd = devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd),
>> GFP_KERNEL);
>>> +	if (!imx_sc_wdd)
>>> +		return -ENOMEM;
>>> +
>>> +	platform_set_drvdata(pdev, imx_sc_wdd);
>>> +
>>> +	imx_sc_wdd->info = &imx_sc_wdt_info;
>>> +	imx_sc_wdd->ops = &imx_sc_wdt_ops;
>>> +	imx_sc_wdd->min_timeout = 1;
>>> +	imx_sc_wdd->max_timeout = MAX_TIMEOUT;
>>> +	imx_sc_wdd->parent = &pdev->dev;
>>> +	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
>>> +
>>> +	ret = watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
>>> +	if (ret)
>>> +		dev_warn(&pdev->dev, "Failed to set timeout value, using
>>> +default\n");
>>> +
>>> +	watchdog_stop_on_reboot(imx_sc_wdd);
>>> +	watchdog_stop_on_unregister(imx_sc_wdd);
>>> +
>>> +	ret = devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "Failed to register watchdog device\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id imx_sc_wdt_dt_ids[] = {
>>> +	{ .compatible = "fsl,imx-sc-wdt", },
>>> +	{ /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);
>>
>> I assume this will be dropped and replaced with platform code, per feedback
>> from Rob.
> 
> Yes, I will remove it in V4, just register platform device in driver directly.
> 
>>
>>> +
>>> +static int __maybe_unused imx_sc_wdt_suspend(struct device *dev) {
>>> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
>>> +
>>> +	if (watchdog_active(imx_sc_wdd))
>>> +		imx_sc_wdt_stop(imx_sc_wdd);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int __maybe_unused imx_sc_wdt_resume(struct device *dev) {
>>> +	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
>>> +
>>> +	if (watchdog_active(imx_sc_wdd))
>>> +		imx_sc_wdt_start(imx_sc_wdd);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
>>> +			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
>>> +
>>> +static struct platform_driver imx_sc_wdt_driver = {
>>> +	.probe		= imx_sc_wdt_probe,
>>> +	.driver		= {
>>> +		.name	= "imx-sc-wdt",
>>> +		.of_match_table = imx_sc_wdt_dt_ids,
>>> +		.pm	= &imx_sc_wdt_pm_ops,
>>> +	},
>>> +};
>>> +
>>> +module_platform_driver(imx_sc_wdt_driver);
>>> +
>>> +MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
>>> +MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
>>> +MODULE_LICENSE("GPL v2");
>>
>> The module license conflicts with the SPDX license which says 2.0+.
> 
> OK, I will change the SPDX license to 2.0.
> 
> Please help review V4 patch series, the dt-binding and dts patch will be removed.
> 
> Thanks,
> Anson.
> 


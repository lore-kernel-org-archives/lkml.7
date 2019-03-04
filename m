Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B648C10F00
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E0720842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkEh1r1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfCDCpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:45:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44179 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfCDCpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:45:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id a3so1865879pff.11;
        Sun, 03 Mar 2019 18:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sj70rW/pBDJM8uwyquRhOOmCoxgq5rHU12GwK5LlmSA=;
        b=hkEh1r1GhA0Vm2BuisjXySWnUzRtFLOqG61xF3Uixe8V6MdHmEzC3ArNXPIMyd8iiI
         uHRd1puCBrd54T+fYa1e0TwPDxqwExeTrMhht9bSJuqBRnFJUxG80HG6tfxAJ7KGu56X
         i8gUoxBu8FR1wWgbcn6oUNK7vvwkzYVCpUnlQrxEZBjD1XJ9LF8I4aPvjj/g4s8SHBY9
         Cje5J0+hlcJDNrL/fk1exdINJ3RSAY9teqiQS1jETdphGNMHDkd2GoHq+2/mE1yT07ie
         U6EsRDzfRG8+GCyOjJtiVI/oIrGR85NkAS1qjpz1LzeEW5tB1TGyES0Wz6U8OOia3Fqm
         yvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sj70rW/pBDJM8uwyquRhOOmCoxgq5rHU12GwK5LlmSA=;
        b=e7IkkCucT3CJ5hhptHm8QM1iG/rXwSCvY5dJBiCuPi3e0iY0iAPBxaI3OKblnC218y
         vEgN4YPZrBqM3htZuKAhzbo/pxz/o4JflNGnGNjhQ0KOkzmW3GgVtkreGmmOHwJK9L2j
         umdsVGgvGKzWZxPSybASCsO2ysMzdY/RyquNPpSB6Ib7Ql0JsSYf9+j3Bw/mQIOYklty
         lOoQoTZOO5bH9XevQgl6P09uCiSkhu8XFYdQE1G9b6lXDfmYSwwsgJHzn/igXRMCsZxq
         3GtmZd1ggPGpCkDzDaE0ipuDsnqCaFYGkaWEgvVcmd5K6BKSc5XIiMZuT+6s6sAhiSdv
         BPCg==
X-Gm-Message-State: APjAAAXSXnIOA3KatosCe6u7tgquA8qwVWJL6CVQf8GLI3pVl4gAmcvU
        dRmL9akJ2M2yWVe0aMP7a3c=
X-Google-Smtp-Source: APXvYqzZqR9+JH3rQgQH+L+E3aMIr6bkQbD4c4tWEcAc5WgT/Zz8OCovAxtBE+iywKYmsD30B29FxA==
X-Received: by 2002:a17:902:7c8f:: with SMTP id y15mr17785480pll.44.1551667549356;
        Sun, 03 Mar 2019 18:45:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a184sm6780073pge.68.2019.03.03.18.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 18:45:48 -0800 (PST)
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
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <19c52bda-aaaa-f67d-3627-d5a303386dae@roeck-us.net>
Date:   Sun, 3 Mar 2019 18:45:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39165C1FE3289E145E86DAA1F5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/19 5:32 PM, Anson Huang wrote:
> Hi, Guenter
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
>> Roeck
>> Sent: 2019Äê3ÔÂ2ÈÕ 2:32
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
>> On Fri, Mar 01, 2019 at 06:35:31AM +0000, Anson Huang wrote:
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
>>> Changes since V4:
>>> 	- change the module build dependency as depends on IMX_SCU and
>> HAVE_ARM_SMCCC, as this
>>> 	  driver is ONLY for i.MX SoC with SCU inside and it uses ARM SMC call.
>>> ---
>>>   drivers/watchdog/Kconfig      |  14 +++
>>>   drivers/watchdog/Makefile     |   1 +
>>>   drivers/watchdog/imx_sc_wdt.c | 201
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 216 insertions(+)
>>>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
>>> 65c3c42..a6bfa54 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -625,6 +625,20 @@ config IMX2_WDT
>>>   	  To compile this driver as a module, choose M here: the
>>>   	  module will be called imx2_wdt.
>>>
>>> +config IMX_SC_WDT
>>> +	tristate "IMX SC Watchdog"
>>> +	depends on IMX_SCU
>>> +	depends on HAVE_ARM_SMCCC
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
>>> file mode 100644 index 0000000..50b49b2
>>> --- /dev/null
>>> +++ b/drivers/watchdog/imx_sc_wdt.c
>>> @@ -0,0 +1,201 @@
>>> +// SPDX-License-Identifier: GPL-2.0
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
>>
>> Should no longer be needed.
> 
> Correct, I will remove it.
> 
>>
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
>>> +static unsigned int timeout = DEFAULT_TIMEOUT; module_param(timeout,
>>> +uint, 0000); MODULE_PARM_DESC(timeout, "Watchdog timeout in
>> seconds
>>> +(default="
>>> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
>>> +
>>> +static struct platform_device *imx_sc_wdt_pdev;
>>> +
>>> +static int imx_sc_wdt_ping(struct watchdog_device *wdog) {
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
>>> +		      0, 0, 0, 0, 0, 0, &res);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx_sc_wdt_start(struct watchdog_device *wdog) {
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
>>> +		      0, 0, 0, 0, 0, 0, &res);
>>> +	if (res.a0)
>>> +		return -EACCES;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
>>> +		      SC_TIMER_WDOG_ACTION_PARTITION,
>>> +		      0, 0, 0, 0, 0, &res);
>>> +	return res.a0 ? -EACCES : 0;
>>> +}
>>> +
>>> +static int imx_sc_wdt_stop(struct watchdog_device *wdog) {
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
>>> +		      0, 0, 0, 0, 0, 0, &res);
>>> +
>>> +	return res.a0 ? -EACCES : 0;
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
>>> +	return res.a0 ? -EACCES : 0;
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
>>> +		.pm	= &imx_sc_wdt_pm_ops,
>>> +	},
>>> +};
>>> +
>>> +static int __init imx_sc_wdt_init(void) {
>>> +	int ret;
>>> +
>>> +	ret = platform_driver_register(&imx_sc_wdt_driver);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	imx_sc_wdt_pdev = platform_device_register_simple("imx-sc-wdt", -
>> 1, NULL, 0);
>>> +	if (IS_ERR(imx_sc_wdt_pdev)) {
>>> +		platform_driver_unregister(&imx_sc_wdt_driver);
>>> +		return PTR_ERR(imx_sc_wdt_pdev);
>>> +	}
>>
>> I just realized what you are doing here. So the watchdog will always be
>> instantiated if/when the module is loaded. I don't think that was the idea,
>> and it seems to be risky. What happens if someone loads the module on a
>> system where the watchdog is not supported ? There maye be lots of "Access
>> Denied" errors, or something undefined may happen.
> 
> I thought the "depends on IMX_SCU" was already added in Kconfig, that means
> the module will be ONLY built with IMX_SCU enabled, and watchdog will be always
> enabled if IMX_SCU is enabled. Is it safe enough?
> 
No. The driver will be built with arm64:defconfig, meaning it will be built
for all arm64 systems using defconfig. Any such system will have the
driver installed as module, and nothing will prevent the user from
running modprobe. But even if it wasn't enabled with defconfig, we must
not instantiate the driver on an arbitrary system.

>>
>> Is everyone on Cc: ok with this ? Is this how we handle instantiations
>> nowadays ?  Or should the driver be instantiated from imx_scu_probe() in
>> drivers/firmware/imx/imx-scu.c ?
>>
>> Sorry if the answer is obvious, but I am still struggling with "no more
>> instantiations through devicetree".
>>
>> If the driver is auto-instantiated when the module is loaded, as currently
>> written, there needs to be some check if it is actually supported, possibly in
>> imx_sc_wdt_init() or, if that is not possible, in the probe function. I don't like
>> that, but it would at least prevent the module from being loaded when the
>> hardware is not supported.
> 
> Other modules depend on the IMX_SCU IPC will have defer probe there to make
> sure IMX_SCU driver is ready for IPC handle, since watchdog driver ONLY uses
> ARM SMC but no IPC call, so I did NOT add the defer probe handle here, so if adding
> it can answer your question/concern, then I can add it, although I think the dependency
> in Kconfig should be good here. Without SCU firmware ready, the SoC does NOT boot
> up A core with ATF/Linux at all.
> 
That has nothing to do with deferred probing. My concern is that the driver will
be instantiated just by loading it, no matter if the hardware supporting it
is present or not.

Having a devicetree node would have prevented that since it instantiates the
child drivers with devm_of_platform_populate() in imx_scu_probe(). The
equivalent is to register the platform device from imx_scu_probe().
That is the only means to prevent the driver from being instantiated where
it shouldn't. As mentioned before, I would have preferred the devicetree method,
but having it no longer available doesn't mean that we should add risky code.

Maybe you can check in the init function if the 'fsl,imx-scu' node exists,
and instantiate the driver if it does. I don't like that either, but it would
be acceptable to me - and maybe better than instantiating it manually from
imx_scu_probe().

Guenter

> Thanks,
> Anson.
> 
> RTC:
>   68 static int imx_sc_rtc_probe(struct platform_device *pdev)
>   69 {
>   70         int ret;
>   71
>   72         ret = imx_scu_get_handle(&rtc_ipc_handle);
>   73         if (ret)
>   74                 return ret;
> 
> SCU:
>   92 int imx_scu_get_handle(struct imx_sc_ipc **ipc)
>   93 {
>   94         if (!imx_sc_ipc_handle)
>   95                 return -EPROBE_DEFER;
>   96
>   97         *ipc = imx_sc_ipc_handle;
>   98         return 0;
>   99 }
> 100 EXPORT_SYMBOL(imx_scu_get_handle);
> 
>>
>> Guenter
>>
>>> +
>>> +	return 0;
>>> +}
>>> +module_init(imx_sc_wdt_init);
>>> +
>>> +static void __exit imx_sc_wdt_exit(void) {
>>> +	platform_driver_unregister(&imx_sc_wdt_driver);
>>> +	platform_device_unregister(imx_sc_wdt_pdev);
>>> +}
>>> +module_exit(imx_sc_wdt_exit);
>>> +
>>> +MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
>>> +MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
>>> +MODULE_LICENSE("GPL v2");
>>> --
>>> 2.7.4
>>>


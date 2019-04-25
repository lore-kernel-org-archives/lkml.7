Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE926C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABDB217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbcT6pPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfDYEEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 00:04:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38740 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfDYEEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 00:04:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so10471498pgl.5;
        Wed, 24 Apr 2019 21:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nu5sH0YqAXQ3e3qXiNtCAr5asf/yCKCdGPPw7KB81/s=;
        b=XbcT6pPJF4JfXAuInqMgkppr+J2tCbpQF5NdeGzGjzVnvN03Uzd+7ihxknsHeLrDVb
         qtKLRi8fEIg4jCUjjaQQ6pKsxGHm+2CLNLuoAV3lb97QDYyJtsQIeA9iSnPaYbAhyvz1
         cznPa1L55xEVyefhLEw0qFuUs/gDNYrh9BoxMT169Q61Fp5aylsSPMLYWz+tpdzW/3vu
         /JNPFoQi97FQfdsh0nq8uVt0LCU6rPp1+iq/6Ts7NSMOhJcnaCxbEOvq4kfdvwJNloBP
         +z1TiqHhPP0J+GMl+Nm9bCSzM+YqfZ5bz8LH3ewGf/gw9gLcQyzePYVUFL8AM3maZxzv
         neOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nu5sH0YqAXQ3e3qXiNtCAr5asf/yCKCdGPPw7KB81/s=;
        b=cdtU2LeqAhAQjDlI1VxxZWbqJKLAUBxYNsUs0YFkb7nhKvrdQlKMHkf3hPbhbiWVWN
         LzW3QBIa/KSYruW7G087VSiYbv75Kfl0g4eCFFNe+Wag0Tjx4ZA4R2uPIxFpm/XyTjJd
         dls3hImKijafbXDxUnFNRgj+Cgt82yYLAfV6RypsCZc6ZCSRlgV7DA4LlEIG2cBGfq1W
         7ADh37/T1amECTvy+8wcIqp2RV0Y/9GnEcc0egBn5H6Bk8/dUr6M0HjQH/wcg1Xx5IBJ
         t1kji6AnT9BzyCK0mLiAs3wxDs1UMgUT8WmBYIzY1Ur4ApidNnL4GPMPVzWf699moZld
         GKOQ==
X-Gm-Message-State: APjAAAWVMsfv2SpxbyhsEEz+8qfPIl/GK6Mrrqgi0LdCvU8/0nZ5xI0Q
        v2nJvgBR16TYO8tiC1oFzVE=
X-Google-Smtp-Source: APXvYqy+kyvqqKRln0gIvgJeQ2kGcQllxmKSL5aZAUU/ECrwjqfUbbHSJXlq1ZbYfdQAQyqpM2wp8g==
X-Received: by 2002:a62:2c89:: with SMTP id s131mr14480999pfs.211.1556165050416;
        Wed, 24 Apr 2019 21:04:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j28sm26747081pgb.46.2019.04.24.21.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 21:04:09 -0700 (PDT)
Subject: Re: [PATCH 2/2] watchdog: imx_sc: Add pretimeout support
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
 <1556154581-31890-2-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <21bd7656-541e-5f77-af8e-a5ea40b904a6@roeck-us.net>
Date:   Wed, 24 Apr 2019 21:04:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556154581-31890-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 6:14 PM, Anson Huang wrote:
> i.MX system controller watchdog can support pretimeout IRQ
> via general SCU MU IRQ, it depends on IMX_SCU and driver MUST
> be probed after SCU IPC ready, then enable corresponding SCU
> IRQ group and register SCU IRQ notifier, when watchdog pretimeout
> IRQ fires, SCU MU IRQ will be handled and watchdog pretimeout
> notifier will be called to handle the event.
> 

Ah, here is the missing patch.

As mentioned in my other reply, the watchdog driver does now depend
on the SCU IPC handle and should be instantiated accordingly.
Using -EPROBE_DEFER to work around bad dependencies is not a solution.

Additional comment below.

Guenter

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>   drivers/watchdog/Kconfig      |  1 +
>   drivers/watchdog/imx_sc_wdt.c | 65 +++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 44a3158..f2c2c1a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -644,6 +644,7 @@ config IMX2_WDT
>   config IMX_SC_WDT
>   	tristate "IMX SC Watchdog"
>   	depends on HAVE_ARM_SMCCC
> +	depends on IMX_SCU
>   	select WATCHDOG_CORE
>   	help
>   	  This is the driver for the system controller watchdog
> diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
> index 49848b6..f45ed10 100644
> --- a/drivers/watchdog/imx_sc_wdt.c
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/arm-smccc.h>
> +#include <linux/firmware/imx/sci.h>
>   #include <linux/io.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
> @@ -33,11 +34,16 @@
>   
>   #define SC_TIMER_WDOG_ACTION_PARTITION	0
>   
> +#define SC_IRQ_WDOG			1
> +#define SC_IRQ_GROUP_WDOG		1
> +
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0000);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
> +struct watchdog_device *imx_sc_wdd;
> +
>   static int imx_sc_wdt_ping(struct watchdog_device *wdog)
>   {
>   	struct arm_smccc_res res;
> @@ -85,12 +91,42 @@ static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
>   	return res.a0 ? -EACCES : 0;
>   }
>   
> +static int imx_sc_wdt_set_pretimeout(struct watchdog_device *wdog,
> +				     unsigned int pretimeout)
> +{
> +	struct arm_smccc_res res;
> +
> +	wdog->pretimeout = pretimeout;
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_PRETIME_WDOG,
> +		      pretimeout * 1000, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0 ? -EACCES : 0;

If this function returns an error, why does it set wdog->pretimeout
unconditionally ? That seems wrong.

> +}
> +
> +static int imx_sc_wdt_notify(struct notifier_block *nb,
> +			     unsigned long event, void *group)
> +{
> +	/* ignore other irqs */
> +	if (!(event & SC_IRQ_WDOG &&
> +		(*(u8 *)group == SC_IRQ_GROUP_WDOG)))

	if (!(event & SC_IRQ_WDO) || *(u8 *)group != SC_IRQ_GROUP_WDOG)

would be easier to understand. Either case, the second part of the expression
has an unnecessary (), and multi-line alignment seems to be off.

> +		return 0;
> +
> +	watchdog_notify_pretimeout(imx_sc_wdd);

The notifier block should be embedded in a local data structure,
which would include strict watchdog_device and struct notifier_block.
This would avoid the need for a static variable.

> +
> +	return 0;

If the function always returns 0, why not the following ?
Above code seems unnecessary complex for no good reason.

	if (event & SC_IRQ_WDOG &&
	    *(u8 *)group == SC_IRQ_GROUP_WDOG)
		watchdog_notify_pretimeout(imx_sc_wdd);

	return 0;

> +}
> +
> +static struct notifier_block imx_sc_wdt_notifier = {
> +	.notifier_call = imx_sc_wdt_notify,
> +};
> +
>   static const struct watchdog_ops imx_sc_wdt_ops = {
>   	.owner = THIS_MODULE,
>   	.start = imx_sc_wdt_start,
>   	.stop  = imx_sc_wdt_stop,
>   	.ping  = imx_sc_wdt_ping,
>   	.set_timeout = imx_sc_wdt_set_timeout,
> +	.set_pretimeout = imx_sc_wdt_set_pretimeout,
>   };
>   
>   static const struct watchdog_info imx_sc_wdt_info = {
> @@ -102,9 +138,15 @@ static const struct watchdog_info imx_sc_wdt_info = {
>   static int imx_sc_wdt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct watchdog_device *imx_sc_wdd;
>   	int ret;
>   
> +	/* wait until i.MX SCU IPC ready */
> +	ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WDOG,
> +				       SC_IRQ_WDOG,
> +				       true);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
> +

And if the error is anything else it is ignored ?
Also, what happens if the interrupt triggers before imx_sc_wdd is set ?

>   	imx_sc_wdd = devm_kzalloc(dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
>   	if (!imx_sc_wdd)
>   		return -ENOMEM;
> @@ -117,6 +159,7 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
>   	imx_sc_wdd->max_timeout = MAX_TIMEOUT;
>   	imx_sc_wdd->parent = dev;
>   	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
> +	imx_sc_wdd->pretimeout = 0;

Unnecessary.

>   
>   	watchdog_init_timeout(imx_sc_wdd, 0, dev);
>   	watchdog_stop_on_reboot(imx_sc_wdd);
> @@ -128,13 +171,26 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	ret = imx_scu_irq_register_notifier(&imx_sc_wdt_notifier);
> +	if (ret)
> +		dev_warn(&pdev->dev,
> +			 "Failed to register watchdog irq notifier\n");

pretimeout support doesn't work in this case, and any claim to support it
seems inappropriate.

> +
>   	return 0;
>   }
>   
> -static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
> +static int imx_sc_wdt_remove(struct platform_device *pdev)
>   {
> -	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> +	imx_scu_irq_unregister_notifier(&imx_sc_wdt_notifier);
> +	imx_scu_irq_group_enable(SC_IRQ_GROUP_WDOG,
> +				 SC_IRQ_WDOG,
> +				 false);
>   
I would prefer to see devm_add_action() calls.

> +	return 0;
> +}
> +
> +static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
> +{
>   	if (watchdog_active(imx_sc_wdd))
>   		imx_sc_wdt_stop(imx_sc_wdd);
>   
> @@ -143,8 +199,6 @@ static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
>   
>   static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
>   {
> -	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> -
>   	if (watchdog_active(imx_sc_wdd))
>   		imx_sc_wdt_start(imx_sc_wdd);
>   
> @@ -162,6 +216,7 @@ MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);
>   
>   static struct platform_driver imx_sc_wdt_driver = {
>   	.probe		= imx_sc_wdt_probe,
> +	.remove		= imx_sc_wdt_remove,
>   	.driver		= {
>   		.name	= "imx-sc-wdt",
>   		.of_match_table = imx_sc_wdt_dt_ids,
> 


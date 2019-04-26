Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C632054F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwRxPuc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfDZURW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:17:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46449 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:17:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id j11so2215721pff.13;
        Fri, 26 Apr 2019 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6wu2vkoKFurv77hR7C4xkMbnljIuBWN13gn2RKz/e4=;
        b=pwRxPuc7D6iDUTztxw7gBSde8UItK07uJO5IuLOiScu4xOWTNBLQDwHUQhgBymj71k
         13x6Z4Z5Bq+zrEZY63U1n2vXvwomHXu+LyR0/hojGNNWltYT83iluHQ2WXZK/9PbCnEi
         sJwxGgAFZg7Tm1xAlvF5MbIGzXHqwHXzY4Ym5hV1iycXX0+bFUyFzriVKAp5QX5QAx0C
         QRI4TVCJ+x7so/nTXC55J0t2kbsgt6rkC3bTGjj/cthi5SCPL8xl394YWH+L/BGxhRbP
         mIOjhZ7durXfLUqKBRLKchs5cTlX4trkhTkxjBRDKlHKg7agF2JkfmvvNLo8YNiBoJke
         x5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6wu2vkoKFurv77hR7C4xkMbnljIuBWN13gn2RKz/e4=;
        b=HvZgZmMIxQbY5tACYCV5C6vbo++pPtpCM83LyW65PMLxeqRqQZBeTymuBBK531t2RT
         H/ZOYsV4tvQmzuD39Tf495BM+K1ciZ0YrG8rAKkf6/Hypll8iigjq/dhzh8q4MNHKRsZ
         8tOxbKfqWppliqm5NZD7f+u08yJytpYWQRAwAmMouFI/It+Eguqg1NusEdovDLdGfmOs
         EP9yRxI2Y/jWRQ/plCuJ9vPRle49ZmaHWsC2/kCcCYCkUbi7dvbLL1z+GUzL0FvFlRmq
         TPXFz6vc3CZzEAtJaNUnEkNR1HzV0IcOC3izISnigyIyAfxSnY02FoelxfypdAj+IB7T
         lCKQ==
X-Gm-Message-State: APjAAAXVF/LCCqulr7F/ekpHuKcBc3qLSAIfEeNVHPn8NX5WTteTzyLq
        cPce0BxNYYbSQ+UTdOKPcwI=
X-Google-Smtp-Source: APXvYqxZozvTornAdnqV3jqAvk2j3MYVbp79QXnv3RMh37Kuvw9mMuM7HNCrTGHlBhqZ7OFrfB/qfA==
X-Received: by 2002:a63:ff05:: with SMTP id k5mr32944370pgi.342.1556309841065;
        Fri, 26 Apr 2019 13:17:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b63sm73764734pfj.54.2019.04.26.13.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 13:17:20 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:17:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] watchdog: imx_sc: Add pretimeout support
Message-ID: <20190426201719.GB21075@roeck-us.net>
References: <1556154581-31890-1-git-send-email-Anson.Huang@nxp.com>
 <1556154581-31890-2-git-send-email-Anson.Huang@nxp.com>
 <21bd7656-541e-5f77-af8e-a5ea40b904a6@roeck-us.net>
 <DB3PR0402MB3916867C62AEB8999EC9EBD4F53D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916867C62AEB8999EC9EBD4F53D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 05:44:45AM +0000, Anson Huang wrote:
> Hi, Guenter
> 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> > Roeck
> > Sent: Thursday, April 25, 2019 12:04 PM
> > To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > wim@linux-watchdog.org; Aisheng Dong <aisheng.dong@nxp.com>; linux-
> > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > watchdog@vger.kernel.org
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 2/2] watchdog: imx_sc: Add pretimeout support
> > 
> > On 4/24/19 6:14 PM, Anson Huang wrote:
> > > i.MX system controller watchdog can support pretimeout IRQ via general
> > > SCU MU IRQ, it depends on IMX_SCU and driver MUST be probed after SCU
> > > IPC ready, then enable corresponding SCU IRQ group and register SCU
> > > IRQ notifier, when watchdog pretimeout IRQ fires, SCU MU IRQ will be
> > > handled and watchdog pretimeout notifier will be called to handle the
> > > event.
> > >
> > 
> > Ah, here is the missing patch.
> > 
> > As mentioned in my other reply, the watchdog driver does now depend on
> > the SCU IPC handle and should be instantiated accordingly.
> > Using -EPROBE_DEFER to work around bad dependencies is not a solution.
> 
> So, I have to move the i.MX system controller watchdog node into the i.MX SCU
> node in DT file now? As it depends on i.MX SCU firmware. If so, should I remove the

Yes, that is what I would suggest.

> previous i.MX system controller binding doc (fsl-imx-sc-wdt.txt) and add binding doc
> to (Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt) ?  
> 
I can't comment on that; I am neutral on how the documentation is
handled.

> > 
> > Additional comment below.
> > 
> > Guenter
> > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >   drivers/watchdog/Kconfig      |  1 +
> > >   drivers/watchdog/imx_sc_wdt.c | 65
> > +++++++++++++++++++++++++++++++++++++++----
> > >   2 files changed, 61 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > > 44a3158..f2c2c1a 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -644,6 +644,7 @@ config IMX2_WDT
> > >   config IMX_SC_WDT
> > >   	tristate "IMX SC Watchdog"
> > >   	depends on HAVE_ARM_SMCCC
> > > +	depends on IMX_SCU
> > >   	select WATCHDOG_CORE
> > >   	help
> > >   	  This is the driver for the system controller watchdog diff --git
> > > a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c index
> > > 49848b6..f45ed10 100644
> > > --- a/drivers/watchdog/imx_sc_wdt.c
> > > +++ b/drivers/watchdog/imx_sc_wdt.c
> > > @@ -4,6 +4,7 @@
> > >    */
> > >
> > >   #include <linux/arm-smccc.h>
> > > +#include <linux/firmware/imx/sci.h>
> > >   #include <linux/io.h>
> > >   #include <linux/init.h>
> > >   #include <linux/kernel.h>
> > > @@ -33,11 +34,16 @@
> > >
> > >   #define SC_TIMER_WDOG_ACTION_PARTITION	0
> > >
> > > +#define SC_IRQ_WDOG			1
> > > +#define SC_IRQ_GROUP_WDOG		1
> > > +
> > >   static bool nowayout = WATCHDOG_NOWAYOUT;
> > >   module_param(nowayout, bool, 0000);
> > >   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once
> > started (default="
> > >   		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> > >
> > > +struct watchdog_device *imx_sc_wdd;
> > > +
> > >   static int imx_sc_wdt_ping(struct watchdog_device *wdog)
> > >   {
> > >   	struct arm_smccc_res res;
> > > @@ -85,12 +91,42 @@ static int imx_sc_wdt_set_timeout(struct
> > watchdog_device *wdog,
> > >   	return res.a0 ? -EACCES : 0;
> > >   }
> > >
> > > +static int imx_sc_wdt_set_pretimeout(struct watchdog_device *wdog,
> > > +				     unsigned int pretimeout)
> > > +{
> > > +	struct arm_smccc_res res;
> > > +
> > > +	wdog->pretimeout = pretimeout;
> > > +	arm_smccc_smc(IMX_SIP_TIMER,
> > IMX_SIP_TIMER_SET_PRETIME_WDOG,
> > > +		      pretimeout * 1000, 0, 0, 0, 0, 0, &res);
> > > +
> > > +	return res.a0 ? -EACCES : 0;
> > 
> > If this function returns an error, why does it set wdog->pretimeout
> > unconditionally ? That seems wrong.
> 
> You are right, I will fix it in V2, but looks like some other watchdog drivers also has such issue, such
> as below:
> 
> drivers/watchdog/pm8916_wdt.c
> drivers/watchdog/sprd_wdt.c
> 
You are correct, but that doesn't make this one better.

> > 
> > > +}
> > > +
> > > +static int imx_sc_wdt_notify(struct notifier_block *nb,
> > > +			     unsigned long event, void *group) {
> > > +	/* ignore other irqs */
> > > +	if (!(event & SC_IRQ_WDOG &&
> > > +		(*(u8 *)group == SC_IRQ_GROUP_WDOG)))
> > 
> > 	if (!(event & SC_IRQ_WDO) || *(u8 *)group !=
> > SC_IRQ_GROUP_WDOG)
> > 
> > would be easier to understand. Either case, the second part of the
> > expression has an unnecessary (), and multi-line alignment seems to be off.
> 
> Will improve it and fix the line alignment in V2.
> 
> > 
> > > +		return 0;
> > > +
> > > +	watchdog_notify_pretimeout(imx_sc_wdd);
> > 
> > The notifier block should be embedded in a local data structure, which would
> > include strict watchdog_device and struct notifier_block.
> > This would avoid the need for a static variable.
> 
> OK, I will add a local data structure to do it in V2.
> 
> > 
> > > +
> > > +	return 0;
> > 
> > If the function always returns 0, why not the following ?
> > Above code seems unnecessary complex for no good reason.
> > 
> > 	if (event & SC_IRQ_WDOG &&
> > 	    *(u8 *)group == SC_IRQ_GROUP_WDOG)
> > 		watchdog_notify_pretimeout(imx_sc_wdd);
> > 
> > 	return 0;
> 
> OK.
> 
> > 
> > > +}
> > > +
> > > +static struct notifier_block imx_sc_wdt_notifier = {
> > > +	.notifier_call = imx_sc_wdt_notify,
> > > +};
> > > +
> > >   static const struct watchdog_ops imx_sc_wdt_ops = {
> > >   	.owner = THIS_MODULE,
> > >   	.start = imx_sc_wdt_start,
> > >   	.stop  = imx_sc_wdt_stop,
> > >   	.ping  = imx_sc_wdt_ping,
> > >   	.set_timeout = imx_sc_wdt_set_timeout,
> > > +	.set_pretimeout = imx_sc_wdt_set_pretimeout,
> > >   };
> > >
> > >   static const struct watchdog_info imx_sc_wdt_info = { @@ -102,9
> > > +138,15 @@ static const struct watchdog_info imx_sc_wdt_info = {
> > >   static int imx_sc_wdt_probe(struct platform_device *pdev)
> > >   {
> > >   	struct device *dev = &pdev->dev;
> > > -	struct watchdog_device *imx_sc_wdd;
> > >   	int ret;
> > >
> > > +	/* wait until i.MX SCU IPC ready */
> > > +	ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WDOG,
> > > +				       SC_IRQ_WDOG,
> > > +				       true);
> > > +	if (ret == -EPROBE_DEFER)
> > > +		return ret;
> > > +
> > 
> > And if the error is anything else it is ignored ?
> > Also, what happens if the interrupt triggers before imx_sc_wdd is set ?
> 
> Other error ONLY means the IPC failed, the IRQ WDOG group will NOT be enabled,
> it does NOT impact other wdog functions, so I did NOT handle it, maybe I can add
> some warning message to tell user that pretimeout function is failed if other error
> occurs and also disable the pretimeout function in wdog info?
> 
Something like that, yes.

> If interrupt triggers before imx_sc_wdd is set, since the notifier is NOT registered yet,
> so the wdog interrupt will be ignored.  
> 
> > 
> > >   	imx_sc_wdd = devm_kzalloc(dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
> > >   	if (!imx_sc_wdd)
> > >   		return -ENOMEM;
> > > @@ -117,6 +159,7 @@ static int imx_sc_wdt_probe(struct platform_device
> > *pdev)
> > >   	imx_sc_wdd->max_timeout = MAX_TIMEOUT;
> > >   	imx_sc_wdd->parent = dev;
> > >   	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
> > > +	imx_sc_wdd->pretimeout = 0;
> > 
> > Unnecessary.
> 
> OK.
> 
> > 
> > >
> > >   	watchdog_init_timeout(imx_sc_wdd, 0, dev);
> > >   	watchdog_stop_on_reboot(imx_sc_wdd);
> > > @@ -128,13 +171,26 @@ static int imx_sc_wdt_probe(struct
> > platform_device *pdev)
> > >   		return ret;
> > >   	}
> > >
> > > +	ret = imx_scu_irq_register_notifier(&imx_sc_wdt_notifier);
> > > +	if (ret)
> > > +		dev_warn(&pdev->dev,
> > > +			 "Failed to register watchdog irq notifier\n");
> > 
> > pretimeout support doesn't work in this case, and any claim to support it
> > seems inappropriate.
> 
> So how to disable pretimeout function in this case, just overwrite the watchdog_info
> to remove the WDIOF_PRETIMEOUT?
> 
Yes, though I don't recall seeing WDIOF_PRETIMEOUT to start with.

Guenter

> > 
> > > +
> > >   	return 0;
> > >   }
> > >
> > > -static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
> > > +static int imx_sc_wdt_remove(struct platform_device *pdev)
> > >   {
> > > -	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> > > +	imx_scu_irq_unregister_notifier(&imx_sc_wdt_notifier);
> > > +	imx_scu_irq_group_enable(SC_IRQ_GROUP_WDOG,
> > > +				 SC_IRQ_WDOG,
> > > +				 false);
> > >
> > I would prefer to see devm_add_action() calls.
> 
> Ah, agreed, will do it in V2.
> 
> Thanks,
> Anson.
> 
> > 
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused imx_sc_wdt_suspend(struct device *dev) {
> > >   	if (watchdog_active(imx_sc_wdd))
> > >   		imx_sc_wdt_stop(imx_sc_wdd);
> > >
> > > @@ -143,8 +199,6 @@ static int __maybe_unused
> > > imx_sc_wdt_suspend(struct device *dev)
> > >
> > >   static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
> > >   {
> > > -	struct watchdog_device *imx_sc_wdd = dev_get_drvdata(dev);
> > > -
> > >   	if (watchdog_active(imx_sc_wdd))
> > >   		imx_sc_wdt_start(imx_sc_wdd);
> > >
> > > @@ -162,6 +216,7 @@ MODULE_DEVICE_TABLE(of, imx_sc_wdt_dt_ids);
> > >
> > >   static struct platform_driver imx_sc_wdt_driver = {
> > >   	.probe		= imx_sc_wdt_probe,
> > > +	.remove		= imx_sc_wdt_remove,
> > >   	.driver		= {
> > >   		.name	= "imx-sc-wdt",
> > >   		.of_match_table = imx_sc_wdt_dt_ids,
> > >
> 

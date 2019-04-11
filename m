Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35C7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957AB217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDKQNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:13:42 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54927 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:13:42 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A01A660009;
        Thu, 11 Apr 2019 16:13:39 +0000 (UTC)
Date:   Thu, 11 Apr 2019 18:13:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pnx4008: readout watchddog state
Message-ID: <20190411161339.GL3578@piout.net>
References: <20190411153646.32228-1-alexandre.belloni@bootlin.com>
 <20190411160305.GA27530@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411160305.GA27530@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 09:03:05-0700, Guenter Roeck wrote:
> Hi Alexandre,
> 
> On Thu, Apr 11, 2019 at 05:36:46PM +0200, Alexandre Belloni wrote:
> > Readout the enabled state so it is possible to get the pre-userspace
> > handler working. Also, avoid disabling the watchdog when nowayout is set to
> > ensure the watchdog continues working and triggers if there is an issue
> > later in the boot or if userspace fails to start.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/watchdog/pnx4008_wdt.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> > index 8e261799c84e..9e3714e3814c 100644
> > --- a/drivers/watchdog/pnx4008_wdt.c
> > +++ b/drivers/watchdog/pnx4008_wdt.c
> > @@ -209,7 +209,11 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
> >  	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
> >  	watchdog_set_restart_priority(&pnx4008_wdd, 128);
> >  
> > -	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
> > +	if (readl(WDTIM_CTRL(wdt_base)) & COUNT_ENAB)
> > +		set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
> > +
> > +	if (!nowayout)
> > +		pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
> 
> I don't see the point of stopping the watchdog here, even though that is the
> old behavior. If it is possible to detect that the watchdog is running, we
> can let the core handle pings until the watchdog device is opened. The code
> above does that, but only if nowayout is set. That seems inconsistent and
> unnecessary. Is there a downside to doing that unconditionally ?
> 

I guess the downside is the change of behaviour. I don't think many will
be affected but they will have to ensure the core pings the watchdog
until the device is open.  WATCHDOG_HANDLE_BOOT_ENABLED is y by default
so that should be fine for most.

Honestly, I would just never disable the watchdog, that is the whole
point of this patch. If you are fine with that, I will just remove the
line.


> Nitpick: s/watchddog/watchdog/ in subject line.
> 

I'll fix it.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

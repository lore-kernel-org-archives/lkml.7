Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90964C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEEC20449
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmLms1Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDKQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:37:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40365 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDKQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:37:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3665745plr.7;
        Thu, 11 Apr 2019 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yl+SJAYse++tdKvZE+ctkB5OJXGi/RdijHoQr6kHeRc=;
        b=XmLms1HvPXnGhQgBpLt03jGcPI4Ft0A7qYojoi5R9s8jv2AA0zbVRBMA1C9MfHDBTr
         t/u4subE7CBeMwAw5erYBOrU0dQZuG6MxBDwOVtjBhVFU77bTspv/5FmXVWK8rfUf3EJ
         zkop/jea++i2S770Li4Du2Th4XAACBhi/hg6f84JDD7WcCKU5kNE6G5YIeiFuj/t7aDx
         bzHZPCZ0crD2GXxjN+M6/YyotfqbfPnh7zgZYcz+Q7nT5yU/AJgcIBOVEPVlYlGApKM6
         ScNlYmHYsxIc4a4pKprkoHRrEw89bVy6HKnI2oN0gbeWC4a+c6CB5qNHTChrWf3x7hzr
         yP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yl+SJAYse++tdKvZE+ctkB5OJXGi/RdijHoQr6kHeRc=;
        b=PyFDw1WXSEzd1cWD+C2TcBU3lLH9AJh8BXkR+EiGF9lyMo3bxJWrhcW9SjQc/Wb2/R
         UKY8FNg3rbH0bpxvd6//KEwxy32WSMk/g0Uu/KrkDwIyU+bAq0mMj4jJjT3bwqCpookf
         cSOOoMCcU8Q2OzXq5JfgeB84K0Emv/S2pu5tKUXTXQ86KQig0CtJqR/eM0miYSKMp4Xa
         CG/qkwTqYYdI4KDVgGoRfK3NQp3jN3LPFWq3rTx4+ejlsRg6XNx0rNN5VU3TwaBD0Dub
         5WSJeZc4rqDfEa5+m3+BKpdvgWDQ1jSaHfGONEvoLGG0ErkhQAmNY5E0A1M342rzuiVD
         Kx0w==
X-Gm-Message-State: APjAAAXIN5TDZCQUldk5sfdsFgwV2lo4UBay5AuWL482Q0+1PiSI9ka4
        cocGfPXLdSjj3TWtVL0rnQ8=
X-Google-Smtp-Source: APXvYqwTODw4scwKngWNO1kL6up4p4KdxBOrVC/O1ONis9tbQy+iBp2IbdZSftj0SpObYnwDpwBy9Q==
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11mr2624799plk.266.1555000639007;
        Thu, 11 Apr 2019 09:37:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b15sm54408759pgg.90.2019.04.11.09.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:37:18 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:37:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pnx4008: readout watchddog state
Message-ID: <20190411163717.GA28797@roeck-us.net>
References: <20190411153646.32228-1-alexandre.belloni@bootlin.com>
 <20190411160305.GA27530@roeck-us.net>
 <20190411161339.GL3578@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411161339.GL3578@piout.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 06:13:39PM +0200, Alexandre Belloni wrote:
> On 11/04/2019 09:03:05-0700, Guenter Roeck wrote:
> > Hi Alexandre,
> > 
> > On Thu, Apr 11, 2019 at 05:36:46PM +0200, Alexandre Belloni wrote:
> > > Readout the enabled state so it is possible to get the pre-userspace
> > > handler working. Also, avoid disabling the watchdog when nowayout is set to
> > > ensure the watchdog continues working and triggers if there is an issue
> > > later in the boot or if userspace fails to start.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > ---
> > >  drivers/watchdog/pnx4008_wdt.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> > > index 8e261799c84e..9e3714e3814c 100644
> > > --- a/drivers/watchdog/pnx4008_wdt.c
> > > +++ b/drivers/watchdog/pnx4008_wdt.c
> > > @@ -209,7 +209,11 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
> > >  	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
> > >  	watchdog_set_restart_priority(&pnx4008_wdd, 128);
> > >  
> > > -	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
> > > +	if (readl(WDTIM_CTRL(wdt_base)) & COUNT_ENAB)
> > > +		set_bit(WDOG_HW_RUNNING, &pnx4008_wdd.status);
> > > +
> > > +	if (!nowayout)
> > > +		pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
> > 
> > I don't see the point of stopping the watchdog here, even though that is the
> > old behavior. If it is possible to detect that the watchdog is running, we
> > can let the core handle pings until the watchdog device is opened. The code
> > above does that, but only if nowayout is set. That seems inconsistent and
> > unnecessary. Is there a downside to doing that unconditionally ?
> > 
> 
> I guess the downside is the change of behaviour. I don't think many will
> be affected but they will have to ensure the core pings the watchdog
> until the device is open.  WATCHDOG_HANDLE_BOOT_ENABLED is y by default
> so that should be fine for most.
> 
Your code already does change behavior if nowayout is set.

> Honestly, I would just never disable the watchdog, that is the whole
> point of this patch. If you are fine with that, I will just remove the
> line.
> 
Please.

Thanks,
Guenter

> 
> > Nitpick: s/watchddog/watchdog/ in subject line.
> > 
> 
> I'll fix it.
> 
> 
> -- 
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

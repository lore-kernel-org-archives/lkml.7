Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B4E206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu+QHcKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfG3P5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:57:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44101 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfG3P5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:57:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so30284773pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0NaHg6fB++B/oHrlKTF/AWvpclA/KtptWNPlOhBEu0o=;
        b=Lu+QHcKvJFzvOTTexit555M/XSXUkUQWT4tD6loMbFW02HG3mm7Zs1//fQzFpVqBxB
         TOvar4APtgDLa56xMWhJ7fpm55CeJvQJjnPYnCGx7yWRBukGV4kBaVFvXyz7DbfVVohu
         Etqw72cR1ojoy/xR0jSeLs1blUsnbTzo2yArSTe5II8GX1E+fxQLAjhnmJHumrG0VeGk
         x8ahn5IG13WFE2JVJjoeTdZ5h3haNI3AZYQMMTYfXwgdLZBsVn2YKJ3YWlcRt92WcJc0
         lBrqce6vxVx4l4fRmJkdSY2/qyqswMaomb2QDo0zInJD43Xf3E7kr83k0HlcGbyHbzvC
         yGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0NaHg6fB++B/oHrlKTF/AWvpclA/KtptWNPlOhBEu0o=;
        b=Ozhlja8k3NjcrAm3NLdFEUNp0qKjV+kpwa3t1mEuOfoEU24oB3M4n9ARSdMbhc8B7T
         TaA7KJg64iDbg7LIrG35d1R2BhOMJsYDpOBaT1tThcfvx2hHsQYnQ0L7WXWpSirl+ZBX
         F6eFz1mF27dn5KB+vja2uz5groCbSS+J42Ezuf+0yXMrff6BC/MR5GlSsnMU7BN9XN18
         0PFRQlaj5QDa+6XbIT1h0UrCkSZGN5WhVVVlrqctF5gtsY9ELd10TZi1MustETpbNjm1
         mYG613loi9yRJV6sZ1kEC/F0URG5bPMOYqD/1O8sPTp04oUy2uDk07UCunj2/9AUhlRH
         B9Bg==
X-Gm-Message-State: APjAAAX0RwnA9H+YSQ0uyg70MdQbdTQpDKHg0qc1poSgY8jRsVR1hUGo
        k3BpO2Nm1C1BxIr5DcOsiPA=
X-Google-Smtp-Source: APXvYqwlESv9JHKTlgYzRIqCFokW2Dyl8C4s4ykXe1hm7/Bz13AOFDGIyTvXlC4SDq2abAZNZ3Vscg==
X-Received: by 2002:a63:c009:: with SMTP id h9mr82211318pgg.166.1564502259001;
        Tue, 30 Jul 2019 08:57:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1sm82959155pfg.55.2019.07.30.08.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 08:57:38 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:57:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-watchdog@cger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Marking legacy watchdog drivers as deprecated / obsolete
Message-ID: <20190730155737.GA22593@roeck-us.net>
References: <20190729220720.GB5712@roeck-us.net>
 <CAK8P3a16dON3g-BzUOrdHu3ryCD+FyJn29EwcT_aQAdj-jvFnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a16dON3g-BzUOrdHu3ryCD+FyJn29EwcT_aQAdj-jvFnA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:00:36AM +0200, Arnd Bergmann wrote:
> On Tue, Jul 30, 2019 at 12:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi,
> >
> > we have recently seen a number of changes to legacy watchdog drivers,
> > mostly surrounding the coding style used some 10+ years ago, but also
> > fixing minor formatting or coding problems found by static analyzers.
> > This slowly rises above the level of background noise.
> >
> > Would it be acceptable to mark all those drivers as deprecated/obsolete,
> > warn users that the driver should be converted to use the watchdog
> > subsystem, and that it will otherwise be removed in a later Linux kernel
> > version ? This would give us an idea which drivers are still in use,
> > and it would enable us to remove the remaining drivers maybe 5 or 6
> > releases for now.
> >
> > Thoughts ?
> 
> I don't think an automated approach across 61 drivers is likely to work
> well. About half of the drivers appear to be for specific SoCs, and
> removing the watchdog driver while keeping the rest of the SoC support
> would not be helpful, it  just means we break one of the drivers for the
> last remaining users of an old SoC the next time they try to upgrade to
> a new kernel.
> 

The primary goal would be to identify drivers still in use, and to trigger
efforts to convert those drivers to the new infrastructure. Removal of
obsolete / unused drivers would be a separate decision, to be made at some
point in the future, and individually for each driver. I specifically wasn't
trying to suggest auto-removal.

Guenter

> It would probably be helpful to go through the list and see if any of
> the drivers
> are for platforms that are already gone. FWIW, here is the list of drivers that
> have their own .ioctl() method, taken from a patch I'm sending soon
> to add a .compat_ioctl handler:
> 
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> arch/um/drivers/harddog_kern.c
> drivers/char/ipmi/ipmi_watchdog.c
> drivers/hwmon/fschmd.c
> drivers/rtc/rtc-ds1374.c
> drivers/watchdog/acquirewdt.c
> drivers/watchdog/advantechwdt.c
> drivers/watchdog/alim1535_wdt.c
> drivers/watchdog/alim7101_wdt.c
> drivers/watchdog/ar7_wdt.c
> drivers/watchdog/at91rm9200_wdt.c
> drivers/watchdog/ath79_wdt.c
> drivers/watchdog/bcm63xx_wdt.c
> drivers/watchdog/cpu5wdt.c
> drivers/watchdog/eurotechwdt.c
> drivers/watchdog/f71808e_wdt.c
> drivers/watchdog/gef_wdt.c
> drivers/watchdog/geodewdt.c
> drivers/watchdog/ib700wdt.c
> drivers/watchdog/ibmasr.c
> drivers/watchdog/indydog.c
> drivers/watchdog/intel_scu_watchdog.c
> drivers/watchdog/iop_wdt.c
> drivers/watchdog/it8712f_wdt.c
> drivers/watchdog/ixp4xx_wdt.c
> drivers/watchdog/ks8695_wdt.c
> drivers/watchdog/m54xx_wdt.c
> drivers/watchdog/machzwd.c
> drivers/watchdog/mixcomwd.c
> drivers/watchdog/mtx-1_wdt.c
> drivers/watchdog/mv64x60_wdt.c
> drivers/watchdog/nuc900_wdt.c
> drivers/watchdog/nv_tco.c
> drivers/watchdog/pc87413_wdt.c
> drivers/watchdog/pcwd.c
> drivers/watchdog/pcwd_pci.c
> drivers/watchdog/pcwd_usb.c
> drivers/watchdog/pika_wdt.c
> drivers/watchdog/pnx833x_wdt.c
> drivers/watchdog/rc32434_wdt.c
> drivers/watchdog/rdc321x_wdt.c
> drivers/watchdog/riowd.c
> drivers/watchdog/sa1100_wdt.c
> drivers/watchdog/sb_wdog.c
> drivers/watchdog/sbc60xxwdt.c
> drivers/watchdog/sbc7240_wdt.c
> drivers/watchdog/sbc_epx_c3.c
> drivers/watchdog/sbc_fitpc2_wdt.c
> drivers/watchdog/sc1200wdt.c
> drivers/watchdog/sc520_wdt.c
> drivers/watchdog/sch311x_wdt.c
> drivers/watchdog/scx200_wdt.c
> drivers/watchdog/smsc37b787_wdt.c
> drivers/watchdog/w83877f_wdt.c
> drivers/watchdog/w83977f_wdt.c
> drivers/watchdog/wafer5823wdt.c
> drivers/watchdog/wdrtas.c
> drivers/watchdog/wdt.c
> drivers/watchdog/wdt285.c
> drivers/watchdog/wdt977.c
> drivers/watchdog/wdt_pci.c
> 
>       Arnd

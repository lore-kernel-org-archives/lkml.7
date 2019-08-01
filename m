Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7974B2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbfHAWFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:05:15 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:59192 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfHAWFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:05:15 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 18:05:14 EDT
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 043817A0215;
        Thu,  1 Aug 2019 23:58:37 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Guenter Roeck <linux@roeck-us.net>
Subject: Re: Marking legacy watchdog drivers as deprecated / obsolete
Date:   Thu, 1 Aug 2019 23:58:34 +0200
User-Agent: KMail/1.9.10
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-watchdog@cger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190729220720.GB5712@roeck-us.net> <CAK8P3a16dON3g-BzUOrdHu3ryCD+FyJn29EwcT_aQAdj-jvFnA@mail.gmail.com> <20190730155737.GA22593@roeck-us.net>
In-Reply-To: <20190730155737.GA22593@roeck-us.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201908012358.34991.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 July 2019 17:57:37 Guenter Roeck wrote:
> On Tue, Jul 30, 2019 at 10:00:36AM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 30, 2019 at 12:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Hi,
> > >
> > > we have recently seen a number of changes to legacy watchdog drivers,
> > > mostly surrounding the coding style used some 10+ years ago, but also
> > > fixing minor formatting or coding problems found by static analyzers.
> > > This slowly rises above the level of background noise.
> > >
> > > Would it be acceptable to mark all those drivers as deprecated/obsolete,
> > > warn users that the driver should be converted to use the watchdog
> > > subsystem, and that it will otherwise be removed in a later Linux kernel
> > > version ? This would give us an idea which drivers are still in use,
> > > and it would enable us to remove the remaining drivers maybe 5 or 6
> > > releases for now.
> > >
> > > Thoughts ?
> > 
> > I don't think an automated approach across 61 drivers is likely to work
> > well. About half of the drivers appear to be for specific SoCs, and
> > removing the watchdog driver while keeping the rest of the SoC support
> > would not be helpful, it  just means we break one of the drivers for the
> > last remaining users of an old SoC the next time they try to upgrade to
> > a new kernel.
> > 
> 
> The primary goal would be to identify drivers still in use, and to trigger
> efforts to convert those drivers to the new infrastructure. Removal of
> obsolete / unused drivers would be a separate decision, to be made at some
> point in the future, and individually for each driver. I specifically wasn't
> trying to suggest auto-removal.
> 
> Guenter
> 
> > It would probably be helpful to go through the list and see if any of
> > the drivers
> > are for platforms that are already gone. FWIW, here is the list of drivers that
> > have their own .ioctl() method, taken from a patch I'm sending soon
> > to add a .compat_ioctl handler:
> > 
> > arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> > arch/um/drivers/harddog_kern.c
> > drivers/char/ipmi/ipmi_watchdog.c
> > drivers/hwmon/fschmd.c
> > drivers/rtc/rtc-ds1374.c
> > drivers/watchdog/acquirewdt.c
> > drivers/watchdog/advantechwdt.c
> > drivers/watchdog/alim1535_wdt.c
> > drivers/watchdog/alim7101_wdt.c
> > drivers/watchdog/ar7_wdt.c
> > drivers/watchdog/at91rm9200_wdt.c
> > drivers/watchdog/ath79_wdt.c
> > drivers/watchdog/bcm63xx_wdt.c
> > drivers/watchdog/cpu5wdt.c
> > drivers/watchdog/eurotechwdt.c
> > drivers/watchdog/f71808e_wdt.c
> > drivers/watchdog/gef_wdt.c
> > drivers/watchdog/geodewdt.c
> > drivers/watchdog/ib700wdt.c
> > drivers/watchdog/ibmasr.c
> > drivers/watchdog/indydog.c
> > drivers/watchdog/intel_scu_watchdog.c
> > drivers/watchdog/iop_wdt.c
> > drivers/watchdog/it8712f_wdt.c
> > drivers/watchdog/ixp4xx_wdt.c
> > drivers/watchdog/ks8695_wdt.c
> > drivers/watchdog/m54xx_wdt.c
> > drivers/watchdog/machzwd.c
> > drivers/watchdog/mixcomwd.c
> > drivers/watchdog/mtx-1_wdt.c
> > drivers/watchdog/mv64x60_wdt.c
> > drivers/watchdog/nuc900_wdt.c
> > drivers/watchdog/nv_tco.c
> > drivers/watchdog/pc87413_wdt.c
> > drivers/watchdog/pcwd.c
> > drivers/watchdog/pcwd_pci.c
> > drivers/watchdog/pcwd_usb.c
> > drivers/watchdog/pika_wdt.c
> > drivers/watchdog/pnx833x_wdt.c
> > drivers/watchdog/rc32434_wdt.c
> > drivers/watchdog/rdc321x_wdt.c
> > drivers/watchdog/riowd.c
> > drivers/watchdog/sa1100_wdt.c
> > drivers/watchdog/sb_wdog.c
> > drivers/watchdog/sbc60xxwdt.c
> > drivers/watchdog/sbc7240_wdt.c
> > drivers/watchdog/sbc_epx_c3.c
> > drivers/watchdog/sbc_fitpc2_wdt.c
> > drivers/watchdog/sc1200wdt.c
> > drivers/watchdog/sc520_wdt.c
> > drivers/watchdog/sch311x_wdt.c
> > drivers/watchdog/scx200_wdt.c
> > drivers/watchdog/smsc37b787_wdt.c
> > drivers/watchdog/w83877f_wdt.c
> > drivers/watchdog/w83977f_wdt.c
> > drivers/watchdog/wafer5823wdt.c
> > drivers/watchdog/wdrtas.c
> > drivers/watchdog/wdt.c
> > drivers/watchdog/wdt285.c
> > drivers/watchdog/wdt977.c
> > drivers/watchdog/wdt_pci.c
> > 
> >       Arnd
> 

I have some older x86 boards so I probably could test some of them. Likely ALi chipset (alim1535_wdt.c and/or alim7101_wdt.c) and some super I/Os (it8712f_wdt.c, w83877f_wdt.c, w83977f_wdt.c).

-- 
Ondrej Zary

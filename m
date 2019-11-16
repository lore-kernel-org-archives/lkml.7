Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D82C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1052F20728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m4OI0FC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKPKuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 05:50:03 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59400 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPKuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 05:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D521F5TA31KjTzw2pGHrAaQYXT1UKy+cBhgY5ORVh8U=; b=m4OI0FC8DC3aEC56/n2cdCPPd
        UcCS1ua2xs7DUNYqa1ax0vCbc3IWWOTq830lAbad1xFED3Lz7Qwj2FFZ0mm58ex+JBYk4t65YlesO
        OR1i2LwKEZ2AEFr5DJLAHoV5WXApfnBs/UB2dQI4GoPJ6tZEhMkgO0t2v+zZ1N5wE84uI5r8DD1r6
        DR/+jdX78YTt7g6KaSqRgBvKeTehYt1n7c1C1eZ3RV8xV9iKg6ufF/gqOKcQ0ezN7+VBGiD68ODL7
        mxY7BHAC1jTwbg5rHFOnQ5gpifo2Z/frmdPejL3nyOy2+yxdJI+ZWIvZLSqffryDH0mJyIXEI9Upf
        P4kfcZyfQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36222)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iVveA-00072t-2z; Sat, 16 Nov 2019 10:49:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iVve0-0005QC-NG; Sat, 16 Nov 2019 10:49:32 +0000
Date:   Sat, 16 Nov 2019 10:49:32 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, tomeu.vizoso@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        mgalka@collabora.com, Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: rmk/for-next bisection: boot on
 ox820-cloudengines-pogoplug-series-3
Message-ID: <20191116104932.GT25745@shell.armlinux.org.uk>
References: <5dcf8f19.1c69fb81.c02f3.91f2@mx.google.com>
 <CAKv+Gu_r2Cb3d3OXaOdYy+4V9noL6exJoK6pHevUm2WfPzsr1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_r2Cb3d3OXaOdYy+4V9noL6exJoK6pHevUm2WfPzsr1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 10:26:27AM +0000, Ard Biesheuvel wrote:
> (+ Arnd)
> 
> On Sat, 16 Nov 2019 at 05:54, kernelci.org bot <bot@kernelci.org> wrote:
> >
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
> >
> > Summary:
> >   Start:      b6c3c42cfda0 ARM: 8938/1: kernel: initialize broadcast hrtimer based clock event device
> >   Details:    https://kernelci.org/boot/id/5dcf3f0359b514dc84cf54c8
> >   Plain log:  https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.txt
> >   HTML log:   https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.html
> >   Result:     ea70bf6e92c5 ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
> >
> 
> OK, so this regression is caused by the fact that the 'armv7' cache
> maintenance routines in the decompressor are also used for ARMv6 cores
> if they implement the CPUID extension, which I failed to realise when
> I sent this patch.
> 
> There are roughly three ways to deal with this:
> 1) add a mask/val match pair for ARM11MPcore and ARM1176 that hardwire
> them to the ARMv6 routines, even though they implement the CPUID
> extension. This would be very easy, but assumes that those two cores
> are the only ones that are affected by this.
> 2) modify the v7 routines to check for the L1Hvd MMFR1 attribute (in
> the flush routine) and for the CP15BEN SCTLR bit (in the on/off
> routines), and jump to the respective v6 variants if the CPU turns out
> not to support the v7 one.
> 3) revert the patch, and just enable the CP15 barriers (and issue a v7
> barrier) in the v7 on() and flush() routines.
> 
> I am leaning towards the latter, since it is the most straightforward,
> even though it mixes v7 and cp15 barriers in the same function, but
> that was mostly a cosmetic concern anyway.

I'm going to drop the patches - if -rc8 is released tomorrow maybe we
can have a go at solving it next week.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

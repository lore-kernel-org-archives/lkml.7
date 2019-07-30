Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A383C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA20120882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfG3IAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:00:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42187 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbfG3IAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:00:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so45912441qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 01:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXOYG8WkPwL9EExmcM4sEuNa9Vbv+nhq+zhrdFkdFdE=;
        b=MEu0j2TzNdVHhbT5WoX1ZPmksauze/s3JoFrhxFnQqHerBA88EDNHUHeFwsrwSnh5A
         oywteaVsNNGK9ZD1i3VmfOdUSV2eLYaK9H+TtKZCGAIIz1MrhOr47igCMwZ1DoneKB5Y
         OFWp/SiCEIzHZ/SWAzBAkfNkKx1oIQ5p5xTsxDv5d4BVBNrvpndHAjc21iWxArsj1rL5
         G3VMvETLVtYIJphlwu1EhSAcYcD4mURvtTMnn8mzItmOj4qGN9q06uKkE2lZnqYyS/4z
         XCX5H6oP5T9Rr1cjb3K0G/kX3aVnLLHxCjSGsrQPnRhPgDTxzHzGIMTaA99D4NAAyupU
         N0SQ==
X-Gm-Message-State: APjAAAWuI6asl1/xlHeCD/UlSKrl6vvXL4T0+NUa7wcr7xvwhlwgTzbS
        Bm9K5ygR7Bb1l58nq8LKVedUMJHljmcK6LhW7uv8FyT3vaE=
X-Google-Smtp-Source: APXvYqwujNPEiH+Mw2LDyR8585CAhIWkGRjCAKi3HiSv65teDUbYlm3rMyf0TcpRRlepn4iyjTH5yfSAa+u8/k1+H4M=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr74911485qkc.394.1564473652768;
 Tue, 30 Jul 2019 01:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190729220720.GB5712@roeck-us.net>
In-Reply-To: <20190729220720.GB5712@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 10:00:36 +0200
Message-ID: <CAK8P3a16dON3g-BzUOrdHu3ryCD+FyJn29EwcT_aQAdj-jvFnA@mail.gmail.com>
Subject: Re: Marking legacy watchdog drivers as deprecated / obsolete
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@cger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> we have recently seen a number of changes to legacy watchdog drivers,
> mostly surrounding the coding style used some 10+ years ago, but also
> fixing minor formatting or coding problems found by static analyzers.
> This slowly rises above the level of background noise.
>
> Would it be acceptable to mark all those drivers as deprecated/obsolete,
> warn users that the driver should be converted to use the watchdog
> subsystem, and that it will otherwise be removed in a later Linux kernel
> version ? This would give us an idea which drivers are still in use,
> and it would enable us to remove the remaining drivers maybe 5 or 6
> releases for now.
>
> Thoughts ?

I don't think an automated approach across 61 drivers is likely to work
well. About half of the drivers appear to be for specific SoCs, and
removing the watchdog driver while keeping the rest of the SoC support
would not be helpful, it  just means we break one of the drivers for the
last remaining users of an old SoC the next time they try to upgrade to
a new kernel.

It would probably be helpful to go through the list and see if any of
the drivers
are for platforms that are already gone. FWIW, here is the list of drivers that
have their own .ioctl() method, taken from a patch I'm sending soon
to add a .compat_ioctl handler:

arch/powerpc/platforms/52xx/mpc52xx_gpt.c
arch/um/drivers/harddog_kern.c
drivers/char/ipmi/ipmi_watchdog.c
drivers/hwmon/fschmd.c
drivers/rtc/rtc-ds1374.c
drivers/watchdog/acquirewdt.c
drivers/watchdog/advantechwdt.c
drivers/watchdog/alim1535_wdt.c
drivers/watchdog/alim7101_wdt.c
drivers/watchdog/ar7_wdt.c
drivers/watchdog/at91rm9200_wdt.c
drivers/watchdog/ath79_wdt.c
drivers/watchdog/bcm63xx_wdt.c
drivers/watchdog/cpu5wdt.c
drivers/watchdog/eurotechwdt.c
drivers/watchdog/f71808e_wdt.c
drivers/watchdog/gef_wdt.c
drivers/watchdog/geodewdt.c
drivers/watchdog/ib700wdt.c
drivers/watchdog/ibmasr.c
drivers/watchdog/indydog.c
drivers/watchdog/intel_scu_watchdog.c
drivers/watchdog/iop_wdt.c
drivers/watchdog/it8712f_wdt.c
drivers/watchdog/ixp4xx_wdt.c
drivers/watchdog/ks8695_wdt.c
drivers/watchdog/m54xx_wdt.c
drivers/watchdog/machzwd.c
drivers/watchdog/mixcomwd.c
drivers/watchdog/mtx-1_wdt.c
drivers/watchdog/mv64x60_wdt.c
drivers/watchdog/nuc900_wdt.c
drivers/watchdog/nv_tco.c
drivers/watchdog/pc87413_wdt.c
drivers/watchdog/pcwd.c
drivers/watchdog/pcwd_pci.c
drivers/watchdog/pcwd_usb.c
drivers/watchdog/pika_wdt.c
drivers/watchdog/pnx833x_wdt.c
drivers/watchdog/rc32434_wdt.c
drivers/watchdog/rdc321x_wdt.c
drivers/watchdog/riowd.c
drivers/watchdog/sa1100_wdt.c
drivers/watchdog/sb_wdog.c
drivers/watchdog/sbc60xxwdt.c
drivers/watchdog/sbc7240_wdt.c
drivers/watchdog/sbc_epx_c3.c
drivers/watchdog/sbc_fitpc2_wdt.c
drivers/watchdog/sc1200wdt.c
drivers/watchdog/sc520_wdt.c
drivers/watchdog/sch311x_wdt.c
drivers/watchdog/scx200_wdt.c
drivers/watchdog/smsc37b787_wdt.c
drivers/watchdog/w83877f_wdt.c
drivers/watchdog/w83977f_wdt.c
drivers/watchdog/wafer5823wdt.c
drivers/watchdog/wdrtas.c
drivers/watchdog/wdt.c
drivers/watchdog/wdt285.c
drivers/watchdog/wdt977.c
drivers/watchdog/wdt_pci.c

      Arnd

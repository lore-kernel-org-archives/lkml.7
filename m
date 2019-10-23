Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D03CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F8821872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405715AbfJWNNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:13:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbfJWNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:13:18 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N0WsG-1i2Q9I2DmG-00wUtA; Wed, 23 Oct 2019 15:13:16 +0200
Received: by mail-qt1-f174.google.com with SMTP id d17so17563196qto.3;
        Wed, 23 Oct 2019 06:13:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUvr/EHRgKKqvbAbV5FhhCWbuOItsJJh3bd3H9fsCEz0JBKpLEM
        6H/8nIYZhwEyTNRddt/T1wLK1+/3h8pbHHXc9qI=
X-Google-Smtp-Source: APXvYqwyklGa+hU94PEjBetixWY4koQXLl44bdA7QqFGHctKg3vHkVWCQgnQFCjrA3OSGO0d2Jdn/TI29o9nax1bT50=
X-Received: by 2002:ac8:33d4:: with SMTP id d20mr8948137qtb.204.1571836395377;
 Wed, 23 Oct 2019 06:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-10-arnd@arndb.de> <20191023115544.GA11048@pi3>
In-Reply-To: <20191023115544.GA11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:12:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0s6VCujZRbFN3NkoX=LDw0jwYJg01xOnSdn=DM3TKm1Q@mail.gmail.com>
Message-ID: <CAK8P3a0s6VCujZRbFN3NkoX=LDw0jwYJg01xOnSdn=DM3TKm1Q@mail.gmail.com>
Subject: Re: [PATCH 10/36] ARM: s5pv210: use private pm save/restore
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t+Hfc6SEiVLo6ko/SzZIszsVSiUE9AsrbclU9caoLGTrb7UsZHJ
 ZQ8j7eZsohO992djr0lcPVhtZ/6i3VseunxbFXAFZze90Dse1xSWODDxnWcHbDMsOUwbfRA
 uv/zQxv3LbuO7nDV4vLxsl8GlJP8105OjBvmS8uDZyHvwQhfJRF+Zj2QEyx1peiMFDZMeIF
 lJ116TgLAMijLmB0HIAiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ocy5qycobI=:5uIjV1XzRimLi8KksTah2i
 PCKWN0Gcz4waoEVC/OwV3tQLO+3o8lZMIBwZWi6Jn4Hq8wedmWV7L79PTkDxsLbzit/4teN5A
 +T6k6OeDvTw+Y+zLlNPYXSvp5d0uMkhhx0WYWu76mUHSBm+1wwfrVHB/sg3lpG4AizTP27ICX
 qHqhp/YTmEZ2f2DP040k1R6+yp1cYZrv6ur95NdRDp7kbSWbbMTAH1UeXdZl18fESMC0PS078
 K5eOLFpnGhpghH2iRByqVa1kxNs7wIhrn7Ju9u1YUWqVQnc3O68EpFqJZQTL50YjZZrjmnTQF
 4+YnR18YxMII6GNEXbOJoDG6wY0FY4A/lk0tH8tJYhkVZaVXK5CxPAHog+ha03tCeDwS1dcRh
 U4MglaNTkTUTqVZr0QB42/I831+Ol+BhrOWvX1paJYozeSrz3n6U1+Xe3zP9ve+fbxQJBY3cE
 85SV9MwjL8GKDcXBWnvdE8ZW43YpRP0GmROHqWKs7OQsO984TmICxj2M+bR73VVI9JFHkepxX
 kyBI7LRZ4hhcZY52DwH6KQ1Fs/CONWGzhcBX4cWXC+yLXvBiLrf1ihUXIXAq308/uIjIDAu2z
 AcFcPqJbkwfTkb5fZpt0YMv3HRTedAKsIj+eO4wAW+CYF6va74q5C4gmTInC4pkVf1i+l5dl0
 k8jtD1YF8ckrBeAjsy1e1uFXhhdsknoMtPyWHmR1smMGiF16KwsOMkylKiBa03ccveelluNWP
 b23IA9KIS8xhCyZsdQWwFafWt+sNUhOTI6Z4aE7AUsJ2orRL0Je3+wzWrJ8UZ48aJ171618W1
 u/mtJSrA9T+Dq6qglXvInZSB2DAIV9nEnIy+XEK9+9eb6/ZXaPRiyIMuKL/rdyoiEpX3MkZsZ
 kxD0nBODwie5mYiSwsAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/arch/arm/mach-s5pv210/regs-clock.h b/arch/arm/mach-s5pv210/regs-clock.h
> > index 2a35c831a9b0..8c7530614e37 100644
> > --- a/arch/arm/mach-s5pv210/regs-clock.h
> > +++ b/arch/arm/mach-s5pv210/regs-clock.h
> > @@ -9,7 +9,7 @@
> >  #ifndef __ASM_ARCH_REGS_CLOCK_H
> >  #define __ASM_ARCH_REGS_CLOCK_H __FILE__
> >
> > -#include <plat/map-base.h>
> > +#define S3C_VA_SYS           ((void __iomem __force *)0xF6100000)
>
> The same as for one of earlier patches - I prefer to keep the S3C_ADDR()
> macro for consistency.

Ok, done.

As the constant is only used in arch/arm/mach-s5pv210/pm.c and the
s5pv210_dt_restart() function, I think it would be best to use ioremap()
here and remove the constant as well as s5pv210_fdt_map_sys() and
s5pv210_dt_map_io().

That can clearly be a follow-up patch.

> > diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> > index d88b9b84f3a9..025ce22876c1 100644
> > --- a/arch/arm/plat-samsung/Makefile
> > +++ b/arch/arm/plat-samsung/Makefile
> > @@ -24,9 +24,7 @@ obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
> >
> >  # PM support
> >
> > -obj-$(CONFIG_PM_SLEEP)               += pm-common.o
> > -obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm-common.o
>
> CONFIG_EXYNOS_CPU_SUSPEND looks unrelated and seems to be not needed at
> all. Can you remove it in separate patch?

Done.

        Arnd

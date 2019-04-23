Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED163C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B135920811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TTTyd9iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfDWEaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:30:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:43902 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDWEaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 00:30:39 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3N4UQSV021162
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:30:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3N4UQSV021162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555993827;
        bh=tDayOFS+qie7TFutkRnxtKOP5HHCoT0TvnQHG283m5E=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=TTTyd9iHxg/jIBREhG0JOqjlKy+T9AHC7IUxTEIPkhKITZ+N5BGogBFq4hRH8Cvxv
         DAnArtv583sfNlg00rt7wMrlFM5r+7TIn0WWwIFV9IZKfyplQnIr6eC+14IsGWOLgz
         S1i7ukj75Qbihi/oFoFkWQg0uHuB/2BkJBLs5O2WDsU9uz10kX1RjehpFN0CTy1aBb
         KeoFOYojTB3Mm+PwRoPPKGhlz8xx9rnOTvf8F0uNu1FpSfo0QeuIPCELbtnREbg5o4
         3uqqLr6d4Wdxnj9/KeynLkP1b4wuI0NMGta3+wLcZzpvNkKTZ9VbYUE1p+H4LhiiLd
         OvU6IePSE0d+w==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id x84so2901605vkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 21:30:26 -0700 (PDT)
X-Gm-Message-State: APjAAAX0vaKTHVDcn8X1pAHkM0Ii23BIbf6cMk+3Mb8IGOsUX4ofgIrq
        m3+X+umgUkOPmd+wHnUxoVJrsY8Y2ZO8v2A66Ds=
X-Google-Smtp-Source: APXvYqxvcnViWFEVDUcHibrqdwT4fTTzuJv/We+3TwopgBZfURhChEjn/fuNt8VYAquHsvBnlS5OubRhsNRmNfGVOVM=
X-Received: by 2002:a1f:b297:: with SMTP id b145mr12338753vkf.74.1555993825416;
 Mon, 22 Apr 2019 21:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-2-yamada.masahiro@socionext.com> <20190415151450.GG3578@piout.net>
 <20190419113937.jtkdqcud7lozoqpo@M43218.corp.atmel.com> <CAK7LNATU190SqP00uwj03d-wgbhmO5J3XM6xVMvnYn1xx5_O7w@mail.gmail.com>
In-Reply-To: <CAK7LNATU190SqP00uwj03d-wgbhmO5J3XM6xVMvnYn1xx5_O7w@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 23 Apr 2019 13:29:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARHeQJPxZdr=OQW3=+9cx+C+8weBSriY4h0cKAHD2Mv5w@mail.gmail.com>
Message-ID: <CAK7LNARHeQJPxZdr=OQW3=+9cx+C+8weBSriY4h0cKAHD2Mv5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: at91: move platform-specific asm-offset.h to arch/arm/mach-at91
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 8:10 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Apr 20, 2019 at 4:03 AM Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> >
> > On Mon, Apr 15, 2019 at 05:14:50PM +0200, Alexandre Belloni wrote:
> > > External E-Mail
> > >
> > >
> > > On 08/04/2019 16:54:26+0900, Masahiro Yamada wrote:
> > > > <generated/at91_pm_data-offsets.h> is only generated and included
> > > > by arch/arm/mach-at91/, so it does not need to reside in the
> > > > globally visible include/generated/.
> > > >
> > > > I moved and renamed it to arch/arm/mach-at91/pm_data-offsets.h
> > > > since the prefix 'at91_' is just redundant in mach-at91/.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > >
> >
> > Applied in at91-soc. Let me know if it's an issue, I plan to do the PR
> > soon.

Sorry. A more fatal issue is this breaks O= build.

Could you drop it?

Thanks.



>
>
> There is one minor issue.
>
> If you apply 2/3 (this one) alone,
> arch/arm/mach-at91/pm_data-offsets.h is not cleaned.
>
>
> 1/3 fixes the "make clean" issue:
> https://lkml.org/lkml/2019/4/8/153
>
>
> That is why I sent this as a series
> in order to avoid the regression of cleaning.
>
>
>
> Thanks.
>
> Masahiro Yamada
>
>
> > Regards
> >
> > Ludovic
> >
> > > > ---
> > > >
> > > > Can this be applied to ARM-SOC tree in a series?
> > > > (with Ack from the platform sub-maintainer.)
> > > >
> > > > at91_pm_data-offsets.h header does not need to reside in
> > > > include/generated/, but you may ask
> > > > "Why must it get out of include/generated/?"
> > > >
> > > > My main motivation is to avoid a race condition in the currently
> > > > proposed patch:
> > > >
> > > > https://lore.kernel.org/patchwork/patch/1052763/
> > > >
> > > > This patch tries to embed some build artifacts into the kernel.
> > > >
> > > > If arch/arm/mach-at91/ and kernel/ are built at the same time,
> > > > it may embed a truncated file.
> > > >
> > > >
> > > >  arch/arm/mach-at91/.gitignore   | 1 +
> > > >  arch/arm/mach-at91/Makefile     | 5 +++--
> > > >  arch/arm/mach-at91/pm_suspend.S | 2 +-
> > > >  3 files changed, 5 insertions(+), 3 deletions(-)
> > > >  create mode 100644 arch/arm/mach-at91/.gitignore
> > > >
> > > > diff --git a/arch/arm/mach-at91/.gitignore b/arch/arm/mach-at91/.gitignore
> > > > new file mode 100644
> > > > index 000000000000..2ecd6f51c8a9
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-at91/.gitignore
> > > > @@ -0,0 +1 @@
> > > > +pm_data-offsets.h
> > > > diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> > > > index 31b61f0e1c07..de64301dcff2 100644
> > > > --- a/arch/arm/mach-at91/Makefile
> > > > +++ b/arch/arm/mach-at91/Makefile
> > > > @@ -19,9 +19,10 @@ ifeq ($(CONFIG_PM_DEBUG),y)
> > > >  CFLAGS_pm.o += -DDEBUG
> > > >  endif
> > > >
> > > > -include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s FORCE
> > > > +$(obj)/pm_data-offsets.h: $(obj)/pm_data-offsets.s FORCE
> > > >     $(call filechk,offsets,__PM_DATA_OFFSETS_H__)
> > > >
> > > > -arch/arm/mach-at91/pm_suspend.o: include/generated/at91_pm_data-offsets.h
> > > > +$(obj)/pm_suspend.o: $(obj)/pm_data-offsets.h
> > > >
> > > >  targets += pm_data-offsets.s
> > > > +clean-files += pm_data-offsets.h
> > > > diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> > > > index bfe1c4d06901..a31c1b20f3fa 100644
> > > > --- a/arch/arm/mach-at91/pm_suspend.S
> > > > +++ b/arch/arm/mach-at91/pm_suspend.S
> > > > @@ -14,7 +14,7 @@
> > > >  #include <linux/linkage.h>
> > > >  #include <linux/clk/at91_pmc.h>
> > > >  #include "pm.h"
> > > > -#include "generated/at91_pm_data-offsets.h"
> > > > +#include "pm_data-offsets.h"
> > > >
> > > >  #define    SRAMC_SELF_FRESH_ACTIVE         0x01
> > > >  #define    SRAMC_SELF_FRESH_EXIT           0x00
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > --
> > > Alexandre Belloni, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> > >
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D62C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB4F21855
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zr9dN/sI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDSXK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:10:57 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:19292 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDSXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:10:57 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3JNAbIS007248
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 08:10:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3JNAbIS007248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555715438;
        bh=pa90i84vyjdYK0dtVSvPrJVmCogqAS44X1pILdjRN0o=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=zr9dN/sII2PIEJis1Us+3M25Fv/um3oBl/w5/TzrZd1yyFmq0fambtz9d2udfdmRg
         hmyHgmor6UbKTkU6wFZ260c+X60wUOf8KVR4UcZecn7c2NnILEZtI7/twLQG/DHxg6
         ZJbrlH9xqXGaOPUra/mnYMdaaRNbTGCsP1SUwQJHeiU2pWKrz9lil7jIYFqA8EhLFn
         Z+N3CxWTGDRn+y+GVjAmYWhF0XqRTssss3NlWn3W5Vu6yfS82QH+RUz3l0fnt+T66z
         2JfAegTl9mD0bPOFGDbCmcCeOGsZuM7u/EEF3uY/Buw1STDZ5wkMkEA8e1k8+xlS4S
         KXJULBw1tdqgQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id s2so3523013vsi.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:10:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWq3pgWCtdi7CWJfn7JcUkTJUnumCLQ8LUqMVaCCM2uHzlB47FH
        kOSiNUgAfXPlGDKfNVIr/KQcILjGPRqKMSZuq/k=
X-Google-Smtp-Source: APXvYqwJX8yinQUcgwOvjvlKxyFmQM9l0v3k0xwu5fHkmmCaEFIL3l3BWeuL6KGXAWkLfmiQ1rEdO4HK58cy8zdAWxE=
X-Received: by 2002:a67:f105:: with SMTP id n5mr3550845vsk.181.1555715436589;
 Fri, 19 Apr 2019 16:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-2-yamada.masahiro@socionext.com> <20190415151450.GG3578@piout.net>
 <20190419113937.jtkdqcud7lozoqpo@M43218.corp.atmel.com>
In-Reply-To: <20190419113937.jtkdqcud7lozoqpo@M43218.corp.atmel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 20 Apr 2019 08:10:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATU190SqP00uwj03d-wgbhmO5J3XM6xVMvnYn1xx5_O7w@mail.gmail.com>
Message-ID: <CAK7LNATU190SqP00uwj03d-wgbhmO5J3XM6xVMvnYn1xx5_O7w@mail.gmail.com>
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

On Sat, Apr 20, 2019 at 4:03 AM Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> On Mon, Apr 15, 2019 at 05:14:50PM +0200, Alexandre Belloni wrote:
> > External E-Mail
> >
> >
> > On 08/04/2019 16:54:26+0900, Masahiro Yamada wrote:
> > > <generated/at91_pm_data-offsets.h> is only generated and included
> > > by arch/arm/mach-at91/, so it does not need to reside in the
> > > globally visible include/generated/.
> > >
> > > I moved and renamed it to arch/arm/mach-at91/pm_data-offsets.h
> > > since the prefix 'at91_' is just redundant in mach-at91/.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
>
> Applied in at91-soc. Let me know if it's an issue, I plan to do the PR
> soon.


There is one minor issue.

If you apply 2/3 (this one) alone,
arch/arm/mach-at91/pm_data-offsets.h is not cleaned.


1/3 fixes the "make clean" issue:
https://lkml.org/lkml/2019/4/8/153


That is why I sent this as a series
in order to avoid the regression of cleaning.



Thanks.

Masahiro Yamada


> Regards
>
> Ludovic
>
> > > ---
> > >
> > > Can this be applied to ARM-SOC tree in a series?
> > > (with Ack from the platform sub-maintainer.)
> > >
> > > at91_pm_data-offsets.h header does not need to reside in
> > > include/generated/, but you may ask
> > > "Why must it get out of include/generated/?"
> > >
> > > My main motivation is to avoid a race condition in the currently
> > > proposed patch:
> > >
> > > https://lore.kernel.org/patchwork/patch/1052763/
> > >
> > > This patch tries to embed some build artifacts into the kernel.
> > >
> > > If arch/arm/mach-at91/ and kernel/ are built at the same time,
> > > it may embed a truncated file.
> > >
> > >
> > >  arch/arm/mach-at91/.gitignore   | 1 +
> > >  arch/arm/mach-at91/Makefile     | 5 +++--
> > >  arch/arm/mach-at91/pm_suspend.S | 2 +-
> > >  3 files changed, 5 insertions(+), 3 deletions(-)
> > >  create mode 100644 arch/arm/mach-at91/.gitignore
> > >
> > > diff --git a/arch/arm/mach-at91/.gitignore b/arch/arm/mach-at91/.gitignore
> > > new file mode 100644
> > > index 000000000000..2ecd6f51c8a9
> > > --- /dev/null
> > > +++ b/arch/arm/mach-at91/.gitignore
> > > @@ -0,0 +1 @@
> > > +pm_data-offsets.h
> > > diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> > > index 31b61f0e1c07..de64301dcff2 100644
> > > --- a/arch/arm/mach-at91/Makefile
> > > +++ b/arch/arm/mach-at91/Makefile
> > > @@ -19,9 +19,10 @@ ifeq ($(CONFIG_PM_DEBUG),y)
> > >  CFLAGS_pm.o += -DDEBUG
> > >  endif
> > >
> > > -include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s FORCE
> > > +$(obj)/pm_data-offsets.h: $(obj)/pm_data-offsets.s FORCE
> > >     $(call filechk,offsets,__PM_DATA_OFFSETS_H__)
> > >
> > > -arch/arm/mach-at91/pm_suspend.o: include/generated/at91_pm_data-offsets.h
> > > +$(obj)/pm_suspend.o: $(obj)/pm_data-offsets.h
> > >
> > >  targets += pm_data-offsets.s
> > > +clean-files += pm_data-offsets.h
> > > diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> > > index bfe1c4d06901..a31c1b20f3fa 100644
> > > --- a/arch/arm/mach-at91/pm_suspend.S
> > > +++ b/arch/arm/mach-at91/pm_suspend.S
> > > @@ -14,7 +14,7 @@
> > >  #include <linux/linkage.h>
> > >  #include <linux/clk/at91_pmc.h>
> > >  #include "pm.h"
> > > -#include "generated/at91_pm_data-offsets.h"
> > > +#include "pm_data-offsets.h"
> > >
> > >  #define    SRAMC_SELF_FRESH_ACTIVE         0x01
> > >  #define    SRAMC_SELF_FRESH_EXIT           0x00
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Alexandre Belloni, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> >



-- 
Best Regards
Masahiro Yamada

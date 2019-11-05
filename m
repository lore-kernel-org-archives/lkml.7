Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4654CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC16120717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EGNHG3Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfKEB5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:57:55 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:25816 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfKEB5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:57:55 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xA51ve2p032734;
        Tue, 5 Nov 2019 10:57:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xA51ve2p032734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572919061;
        bh=wnNLKDcLbY3/yKFW6RfxoG2eNTucv+kYwn7VETE2Ss4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EGNHG3Gf56RamlIbWHuLeOWObCMMRhDJbFCPltyeSCQ/fp+jBIyW3Xg51a8GBioJZ
         g25/G6GhcdmEtPCM6HCU12tEGZsN2umDShfxqwkY736okcSEXatODaIJdZhMyBgKbC
         Q8Ybjy0U+nJUSnzkUebOZtlBXMQzDmOQgBi6uSRWk8xQMpjaVE76zinEzUox7rGa5/
         Zepr/Ao266Co8YxuqDdssK9rByY9cenRyhQdK5ySrztrK9YjPt3ieoiwKcmsjAyt/L
         tSaIqgMHmLY36NOASFPaFv6NIKpxpNvE1AiZa0NGsdv2S0SevI1sZAlU+B47x8UMmB
         eJ4tklhr2l5zQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id k15so12395176vsp.2;
        Mon, 04 Nov 2019 17:57:41 -0800 (PST)
X-Gm-Message-State: APjAAAU/k64xMlPmMAVWUr7NVaz+38TsfaLt33IPhcOL23VelnntkwaL
        f13WelwN8Qt30Zl+CG7X205vHAHOXfo0usaQgNY=
X-Google-Smtp-Source: APXvYqzFNajTAhIs/fw26OaE2g+A5ZLDCiX8mkE1P9UMTg1Ch/QNPc3yAz63Ebx/DZ4nOX6a4pcbQNdTpnUu7q5CLMU=
X-Received: by 2002:a67:2d08:: with SMTP id t8mr14547734vst.155.1572919059960;
 Mon, 04 Nov 2019 17:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20191101081148.23274-1-yamada.masahiro@socionext.com>
 <20191101081148.23274-3-yamada.masahiro@socionext.com> <CAL_Jsq+_vKmhVacTnt7fXJFsFGkg0AopdiZ4XaQ3V4M=zhn_CA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+_vKmhVacTnt7fXJFsFGkg0AopdiZ4XaQ3V4M=zhn_CA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Nov 2019 10:57:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-rd6FsBY4CUk3yFzRgEE4mZyytQG6OCBb9Ww2f7bwcg@mail.gmail.com>
Message-ID: <CAK7LNAQ-rd6FsBY4CUk3yFzRgEE4mZyytQG6OCBb9Ww2f7bwcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: decompressor: simplify libfdt builds
To:     Rob Herring <robh+dt@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 10:04 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Nov 1, 2019 at 3:12 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Copying source files during the build time may not end up with
> > as clean code as you expect.
> >
> > lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
> > nicely. Let's follow that approach for the arm decompressor, too.
> >
> > Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove the
> > Makefile messes.
> >
> > Another nice thing is we no longer need to maintain the separate
> > libfdt_env.h since we can include <linux/libfdt_env.h>, and the
> > diff stat also looks nice.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v2: None
> >
> >  arch/arm/boot/compressed/.gitignore     |  9 -------
> >  arch/arm/boot/compressed/Makefile       | 33 +++++++------------------
> >  arch/arm/boot/compressed/atags_to_fdt.c |  1 +
> >  arch/arm/boot/compressed/fdt.c          |  2 ++
> >  arch/arm/boot/compressed/fdt_ro.c       |  2 ++
> >  arch/arm/boot/compressed/fdt_rw.c       |  2 ++
> >  arch/arm/boot/compressed/fdt_wip.c      |  2 ++
> >  arch/arm/boot/compressed/libfdt_env.h   | 22 -----------------
> >  8 files changed, 18 insertions(+), 55 deletions(-)
> >  create mode 100644 arch/arm/boot/compressed/fdt.c
> >  create mode 100644 arch/arm/boot/compressed/fdt_ro.c
> >  create mode 100644 arch/arm/boot/compressed/fdt_rw.c
> >  create mode 100644 arch/arm/boot/compressed/fdt_wip.c
> >  delete mode 100644 arch/arm/boot/compressed/libfdt_env.h
>
> Looks fine to me other than my question on licensing on patch 1.
>
> Who did you want to take the series? I can take it with Russell's ack.

Rob,
I'd like you to take the whole of this patch set
if there is no objection.

Russell,
Is this patch OK with you?



> >
> > -$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
> > -       $(addprefix $(obj)/,$(libfdt_hdrs))
> > +OBJS   += $(libfdt_objs)
>
> Seems like this file could benefit from doing 'OBJS-$(CONFIG_*)' style
> variables.

I agree, but this kind of refactoring is
not the main interest of this series.

It should be done by a separate patch if it is desired.



> > diff --git a/arch/arm/boot/compressed/fdt.c b/arch/arm/boot/compressed/fdt.c
> > new file mode 100644
> > index 000000000000..f8ea7a201ab1
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/fdt.c
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include "../../../../lib/fdt.c"
> > diff --git a/arch/arm/boot/compressed/fdt_ro.c b/arch/arm/boot/compressed/fdt_ro.c
> > new file mode 100644
> > index 000000000000..93970a4ad5ae
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/fdt_ro.c
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include "../../../../lib/fdt_ro.c"
> > diff --git a/arch/arm/boot/compressed/fdt_rw.c b/arch/arm/boot/compressed/fdt_rw.c
> > new file mode 100644
> > index 000000000000..f7c6b8b7e01c
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/fdt_rw.c
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include "../../../../lib/fdt_rw.c"
> > diff --git a/arch/arm/boot/compressed/fdt_wip.c b/arch/arm/boot/compressed/fdt_wip.c
> > new file mode 100644
> > index 000000000000..048d2c7a088d
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/fdt_wip.c
> > @@ -0,0 +1,2 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include "../../../../lib/fdt_wip.c"


I gave GPL-2.0-only to this,
but it should be the same as lib/fdt*.c,
which is now being discussed in 1/3.



-- 
Best Regards
Masahiro Yamada

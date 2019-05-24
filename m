Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5E5C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09D120851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390928AbfEXMjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:39:22 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42436 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390781AbfEXMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:39:21 -0400
Received: by mail-ua1-f68.google.com with SMTP id e9so3432958uar.9;
        Fri, 24 May 2019 05:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8BS7qBD61gkszF8TETLiaJ/w6Ke2fe/2O4AZ5tzxRU=;
        b=o1uvkEeNppHFpCZVqzwhbol+HGvzckfdDXfqBd0rf80gIyNxU52j7el7kw2Hvz+BhQ
         IO7OTHXny6cpvFWFGFnuxU+AapRmtntuNgGIP10DqXQIr67ut4/7WLxlxlYaC6hV5VmR
         nyDYtf9D5popSoRIuzrB0uQjbfHSSZPwSerpL+hWM7Eut8b99Zq/abBN+Lk9aiCCpCx4
         pt4stsdmbH8RYK8JP/m5fKoLnbQoP4BtquLbwLr0a4GdKCbt1Lu4IjJArtFPoecuYwuN
         Mj5G1AkpSrqM4tC8qjTACHioA/+ktASmbppd6lkitFwzarIfl87SFit3Vg1vaNUai9sR
         9ozA==
X-Gm-Message-State: APjAAAVgZNwV8Ft146y1t/BqiCOuxmM414aRDRvOYXGiAHWc7e9ZO+02
        a8oPgv3tX2rqvrr8lWCi6nqYawJmTETIlgdzsSA=
X-Google-Smtp-Source: APXvYqxCD+59NtWoY2L+uV9CXk4yN4AziG3UcCB1/CcRvwjxyNk9G1Yz3/qTWfZSWNEOSMvGkzSHwss5D0pmmtH6T5g=
X-Received: by 2002:ab0:1849:: with SMTP id j9mr3942524uag.75.1558701560479;
 Fri, 24 May 2019 05:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <1558442111-10599-1-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdWGwfDtRcfdzPCpQaM8X=x+s0uT7j+EnRP4Yta+4Nx9Gg@mail.gmail.com> <TYAPR01MB40157EF547D93D3B98330CBCDF020@TYAPR01MB4015.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB40157EF547D93D3B98330CBCDF020@TYAPR01MB4015.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 May 2019 14:39:07 +0200
Message-ID: <CAMuHMdXqehwg9Nng8jzVY0Evj6hsvnad1dmgWU02Dc4vGGsTCQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: renesas: r9a06g032: Add clock domain support
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gareth,

On Fri, May 24, 2019 at 2:28 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> On Tue, May 22, 2019 at 1:02 PM Gareth Williams
> <geert@linux-m68k.org> wrote:
> > On Tue, May 21, 2019 at 2:35 PM Gareth Williams
> > <gareth.williams.jx@renesas.com> wrote:
> > > There are several clocks on the r9ag032 which are currently not
> > > enabled in their drivers that can be delegated to clock domain system
> > > for power management. Therefore add support for clock domain
> > > functionality to the
> > > r9a06g032 clock driver.
> > >
> > > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> > > ---
> > > v2:
> > >  - Rebased onto kernel/git/geert/renesas-drivers.git
> >
> > Thanks for the update!
> >
> > >  drivers/clk/renesas/r9a06g032-clocks.c | 243
> > > ++++++++++++++++++++++++---------
> > >  1 file changed, 176 insertions(+), 67 deletions(-)
> >
> > Please also update
> > Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt,
> > to describe #power-domain-cells (must be 0), and to update the provider
> > and consumer examples.
> >
> > > --- a/drivers/clk/renesas/r9a06g032-clocks.c
> > > +++ b/drivers/clk/renesas/r9a06g032-clocks.c

> > > +int __init r9a06g032_attach_dev(struct generic_pm_domain *unused,
> >
> > Missing static.
> > Please drop the __init, as devices can be attached anytime (no section
> > mismatch warnings?).
> Because the clock array used __initconst, I only got a section mismatch warning
> without __init in the attach function. I will remove both so it compiles cleanly
> without expecting devices to be attached at one point.

Oh right, r9a06g032_attach_dev() uses r9a06g032_clocks[].
So the __initconst must be indeed dropped from the latter, unless you find some
way to store the managed flag elsewhere.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

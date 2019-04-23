Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB60C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3320811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfDWLyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:54:21 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42639 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:54:20 -0400
Received: by mail-ua1-f67.google.com with SMTP id h4so4641733uaj.9;
        Tue, 23 Apr 2019 04:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q323ppK0vM6XyH9rEbKLGc9XXrnw3iqwnCBWa4fN7yY=;
        b=GTRxTis60UnAWUUl6KOLS1kyQyj492nNflqRnMJORrmSZZw3vadZaQ+u3E1HO4CAGZ
         oZIDhrs0k5/G1d8vS9493/8tCleWGAOR24Vmv2mIzELnQQ1amIZW+9esIXiB7MVtM3HZ
         Me/kSGFRnDCYNQLiykTEonPyvIYFDz7Mh7ZTeNy/35VL3QVaHwn3a16zSwlOK/6qcGTl
         v6MJDnadb0sGzb4fGjkGJAMa+Wg3OkRIZJGgCjsTjONladCW3Ob6KLzkkj+XcuIQrhm+
         hkN3ejfEpUs/aCttCQGIXCFlTWVR+UuLzmP2vezDW8jzbAAQHkdivZDIVYBOKpVRVHIH
         sIew==
X-Gm-Message-State: APjAAAUn76EfuAEFFEnBjx2W3e54Af0NlkcwQIaWwRReMRUz5n8eqGsK
        dBwDE+8i9b7KoB9QSnULSle8LI7Sgp7vmdw04BsGIE2Y
X-Google-Smtp-Source: APXvYqyqJQCZASXWGLhuQWsdF/fUTf9U33OIWm+JWDI45gism2K047iFbbZWhc+OerHNYMRluYuRlrhhSNMkZq3OPbc=
X-Received: by 2002:ab0:791:: with SMTP id c17mr2226723uaf.96.1556020458998;
 Tue, 23 Apr 2019 04:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <5cbe596c.1c69fb81.e252.b9d0@mx.google.com> <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
In-Reply-To: <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Apr 2019 13:54:06 +0200
Message-ID: <CAMuHMdXHuQtxuMsGi0OGLcn7NSO5+ZDzDSfaFj+j=P+RLusZHw@mail.gmail.com>
Subject: Re: clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        guillaume.tucker@collabora.com,
        Kevin Hilman <khilman@baylibre.com>, matthew.hart@linaro.org,
        mgalka@collabora.com, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 23, 2019 at 5:56 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting kernelci.org bot (2019-04-22 17:16:44)
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
> >
> > Summary:
> >   Start:      a55b079c961b Merge branch 'clk-hisi' into clk-next
> >   Details:    https://kernelci.org/boot/id/5cbe3cdb59b514fd22fe6025
> >   Plain log:  https://storage.kernelci.org//clk/clk-next/v5.1-rc1-142-ga55b079c961b/arm/omap2plus_defconfig/gcc-7/lab-baylibre/boot-omap4-panda.txt
> >   HTML log:   https://storage.kernelci.org//clk/clk-next/v5.1-rc1-142-ga55b079c961b/arm/omap2plus_defconfig/gcc-7/lab-baylibre/boot-omap4-panda.html
> >   Result:     ecbf3f1795fd clk: fixed-factor: Let clk framework find parent
> >
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >
> > Parameters:
> >   Tree:       clk
> >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
> >   Branch:     clk-next
> >   Target:     panda
> >   CPU arch:   arm
> >   Lab:        lab-baylibre
> >   Compiler:   gcc-7
> >   Config:     omap2plus_defconfig
> >   Test suite: boot
> >
> > Breaking commit found:
>
> Awesome! I LOVE IT!!!
>
> >
> > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> > index 241b3f8c61a9..5b09f2cdb7de 100644
> > --- a/drivers/clk/clk-fixed-factor.c
> > +++ b/drivers/clk/clk-fixed-factor.c
> > @@ -64,12 +64,14 @@ const struct clk_ops clk_fixed_factor_ops = {
> >  };
> >  EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
> >
> > -struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
> > -               const char *name, const char *parent_name, unsigned long flags,
> > -               unsigned int mult, unsigned int div)
> > +static struct clk_hw *
> > +__clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
> > +               const char *name, const char *parent_name, int index,
> > +               unsigned long flags, unsigned int mult, unsigned int div)
> >  {
> >         struct clk_fixed_factor *fix;
> >         struct clk_init_data init;
> > +       struct clk_parent_data pdata = { .index = index };
> >         struct clk_hw *hw;
> >         int ret;
> >
> > @@ -85,11 +87,17 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
> >         init.name = name;
> >         init.ops = &clk_fixed_factor_ops;
> >         init.flags = flags | CLK_IS_BASIC;
> > -       init.parent_names = &parent_name;
> > +       if (parent_name)
> > +               init.parent_names = &parent_name;
> > +       else
> > +               init.parent_data = &pdata;
>
> Ick. I realized that 'init.parent_names' here can be full of junk! Let's
> initialize it properly. Maybe that makes this all better?
>
> ----8<----
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 5b09f2cdb7de..2d988a7585d5 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -70,7 +70,7 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
>                 unsigned long flags, unsigned int mult, unsigned int div)
>  {
>         struct clk_fixed_factor *fix;
> -       struct clk_init_data init;
> +       struct clk_init_data init = { };
>         struct clk_parent_data pdata = { .index = index };
>         struct clk_hw *hw;
>         int ret;

Thank you, this fixes the issue on r8a73a4/ape6evm, r8a7740/armadillo,
and sh73a0/kzm9g for me.

Fixes: ecbf3f1795fda561 ("clk: fixed-factor: Let clk framework find parent")
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

For reference, the crash log on r8a73a4/ape6evm with earlycon enabled is:

Unable to handle kernel paging request at virtual address 9d3cbbd0
pgd = (ptrval)
[9d3cbbd0] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.1.0-rc6-ape6evm-05231-g1e7e3c938ac19d0f #92
Hardware name: Generic R8A73A4 (Flattened Device Tree)
PC is at strlen+0x4/0x24
LR is at kstrdup+0x18/0x4c
pc : [<c04f4d04>]    lr : [<c01269c4>]    psr: a00000d3
sp : c06cde80  ip : ef01e2c0  fp : c06cdee0
r10: c06d9408  r9 : 00000001  r8 : ef01e280
r7 : ef01e280  r6 : c02bc64c  r5 : 00000cc0  r4 : 9d3cbbd0
r3 : 9d3cbbd0  r2 : c0506000  r1 : 00000cc0  r0 : 9d3cbbd0
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
Stack: (0xc06cde80 to 0xc06ce000)
de80: ef021300 00000000 ef01e380 ef01e280 ef01e280 c02bc64c 600000d3 00000000
dea0: c0730db4 c014e1c4 ef000c00 ef01e380 c06d9408 ef01e380 00000000 ef7f2d54
dec0: ef7f2f58 ef01e680 00000001 c02bccdc ef01e380 c02bde58 00000001 00000000
dee0: 00000000 00000000 00000000 00000000 ef7f2f58 c0535838 c06d9408 c06cdee0
df00: c0730db4 60000001 00000020 9d3cbbd0 00000000 ef7f2d54 00000000 c06d9408
df20: c06d9408 00000001 ef01e688 c02bdff8 00000000 00000000 00000001 00000002
df40: ef7f2f58 00000002 00000001 9d3cbbd0 00000000 c06cdf6c ef01eb40 c0693db0
df60: 00000000 ef7f2d54 00000000 ef01e508 ef01e748 9d3cbbd0 00000007 00000000
df80: ef7e6f00 ffffffff c074ab40 c06d9400 c074ab40 00000001 c06b28e4 c0674488
dfa0: 00000000 c0671e78 ffffffff ffffffff 00000000 c067186c 00000000 c06d9408
dfc0: 00000000 c06b28e4 9d39bad0 00000000 00000000 c0671330 00000051 10c0387d
dfe0: 00000f44 40f00000 412fc0f3 10c5387d 00000000 00000000 00000000 00000000
[<c04f4d04>] (strlen) from [<c01269c4>] (kstrdup+0x18/0x4c)
[<c01269c4>] (kstrdup) from [<c02bc64c>] (__clk_register+0x150/0x6c0)
[<c02bc64c>] (__clk_register) from [<c02bccdc>] (of_clk_hw_register+0x14/0x20)
[<c02bccdc>] (of_clk_hw_register) from [<c02bde58>]
(__clk_hw_register_fixed_factor+0xfc/0x114)
[<c02bde58>] (__clk_hw_register_fixed_factor) from [<c02bdff8>]
(_of_fixed_factor_clk_setup+0xec/0x15c)
[<c02bdff8>] (_of_fixed_factor_clk_setup) from [<c0693db0>]
(of_clk_init+0x1b4/0x258)
[<c0693db0>] (of_clk_init) from [<c0674488>] (time_init+0x20/0x2c)
[<c0674488>] (time_init) from [<c0671e78>] (start_kernel+0x318/0x474)
[<c0671e78>] (start_kernel) from [<00000000>] (  (null))
Code: e12fff1e e1a0300c eafffff3 e1a03000 (e5d32000)
---[ end trace 8ec24e97351727c3 ]---

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

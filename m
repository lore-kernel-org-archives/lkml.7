Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8128C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908E52071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OA+RUDJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfKVTus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:50:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34550 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfKVTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:50:39 -0500
Received: by mail-il1-f195.google.com with SMTP id p6so8085471ilp.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 11:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyRnrvFbKUOfWzI19gExh12vx/PZLGimga2bs60+0rg=;
        b=OA+RUDJec1zbsPLoLU0dCoxx6xbx0tsBB62Qm4SHZcHVeR/2ATi57wl31NeQzd4tg1
         /xCVNLQWLAp6RLqp30D/SZ9jZ5rl3zICIBDZ6y5p3oJ7Te5UxO4u3e5KMwC6A11Suy0z
         JgXa6o+CQDEiWqlK5jIUBc/SE/P3FIpMp59Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyRnrvFbKUOfWzI19gExh12vx/PZLGimga2bs60+0rg=;
        b=Gprdqis9YLf+01xfGFlm/VS7YnHe3wzYSHcop9AD7UTY87YFW+tbEWsU/AgzF/HedE
         Tl+Lta8AZLjlpVd/cKIYerI0jCoUnPLDtjo9uu86Ty494xu2NAh75vy+miFBgWdzs3bA
         CFEur2SxaSjLqCKyJc3sz/m9qZKCV/g28SMQQd5vmj7xTBDyxp8hft35OG4rMTJkzBl5
         5zbarDR/93H8Al1jSnQT0UFqLn8wOL3jlvT/BEm36p6msJ8jFFmF6f7hlRo8RHSoqMP2
         87ozAhusOqL4a6eOTU/Il/AgdICa/XH+Ssvwj7b59GrQzgZouSrAJPdA5ANJBTWbb+kV
         0jNw==
X-Gm-Message-State: APjAAAVfkVQcr17FQW9ZFiH+/8qzIMihLcPcG3Xe+pNJRQ0PfD1AWMzw
        fF7eMuUh9jKi9py9XvYdpYJkc8jDPF0/XxIRShfziw==
X-Google-Smtp-Source: APXvYqy2MjzP9e0pqftYQIuPVxsJXa/qxJt+NKqaiGIYIamnMQIqEiJIqrVzZTadWbqFnULsiOnsnWWWxVkXQIGhDQg=
X-Received: by 2002:a92:3ac5:: with SMTP id i66mr19019865ilf.28.1574452233184;
 Fri, 22 Nov 2019 11:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-5-jagan@amarulasolutions.com> <20191028153427.pc3tnoz2d23filhx@hendrix>
 <CAMty3ZCisTrFGjzHyqSofqFAsKSLV1n2xP5Li3Lonhdi0WUZVA@mail.gmail.com>
 <20191029085401.gvqpwmmpyml75vis@hendrix> <CAMty3ZAWPZSHtAZDf_0Dpx588YGGv3pJX1cXMfkZus3+WF94cA@mail.gmail.com>
 <20191103173227.GF7001@gilmour> <CAMty3ZD5uxU=xb0z7PWaXzodYbWRJkP9HjGX-HZYFT4bwk0GOg@mail.gmail.com>
 <20191122181820.GQ4345@gilmour.lan>
In-Reply-To: <20191122181820.GQ4345@gilmour.lan>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 23 Nov 2019 01:20:21 +0530
Message-ID: <CAMty3ZDePC=B-DgfCcjRhJTeciwZmSEU-c4u1=sN_Hs0RgbC7Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] drm/sun4i: dsi: Handle bus clock explicitly
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 22, 2019 at 11:48 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Thu, Nov 21, 2019 at 05:24:47PM +0530, Jagan Teki wrote:
> > On Sun, Nov 3, 2019 at 11:02 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Fri, Nov 01, 2019 at 07:42:55PM +0530, Jagan Teki wrote:
> > > > Hi Maxime,
> > > >
> > > > On Tue, Oct 29, 2019 at 2:24 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > > >
> > > > > On Tue, Oct 29, 2019 at 04:03:56AM +0530, Jagan Teki wrote:
> > > > > > > > explicit handling of common clock would require since the A64
> > > > > > > > doesn't need to mention the clock-names explicitly in dts since it
> > > > > > > > support only one bus clock.
> > > > > > > >
> > > > > > > > Also pass clk_id NULL instead "bus" to regmap clock init function
> > > > > > > > since the single clock variants no need to mention clock-names
> > > > > > > > explicitly.
> > > > > > >
> > > > > > > You don't need explicit clock handling. Passing NULL as the argument
> > > > > > > in regmap_init_mmio_clk will make it use the first clock, which is the
> > > > > > > bus clock.
> > > > > >
> > > > > > Indeed I tried that, since NULL clk_id wouldn't enable the bus clock
> > > > > > during regmap_mmio_gen_context code, passing NULL triggering vblank
> > > > > > timeout.
> > > > >
> > > > > There's a bunch of users of NULL in tree, so finding out why NULL
> > > > > doesn't work is the way forward.
> > > >
> > > > I'd have looked the some of the users before checking the code as
> > > > well. As I said passing NULL clk_id to devm_regmap_init_mmio_clk =>
> > > > __devm_regmap_init_mmio_clk would return before processing the clock.
> > > >
> > > > Here is the code snippet on the tree just to make sure I'm on the same
> > > > page or not.
> > > >
> > > > static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
> > > >                                         const char *clk_id,
> > > >                                         void __iomem *regs,
> > > >                                         const struct regmap_config *config)
> > > > {
> > > >         -----------------------
> > > >         --------------
> > > >         if (clk_id == NULL)
> > > >                 return ctx;
> > > >
> > > >         ctx->clk = clk_get(dev, clk_id);
> > > >         if (IS_ERR(ctx->clk)) {
> > > >                 ret = PTR_ERR(ctx->clk);
> > > >                 goto err_free;
> > > >         }
> > > >
> > > >         ret = clk_prepare(ctx->clk);
> > > >         if (ret < 0) {
> > > >                 clk_put(ctx->clk);
> > > >                 goto err_free;
> > > >         }
> > > >         -------------
> > > >         ---------------
> > > > }
> > > >
> > > > Yes, I did check on the driver in the tree before committing explicit
> > > > clock handle, which make similar requirements like us in [1]. this
> > > > imx2 wdt driver is handling the explicit clock as well. I'm sure this
> > > > driver is updated as I have seen few changes related to this driver in
> > > > ML.
> > >
> > > I guess we have two ways to go at this then.
> > >
> > > Either we remove the return, but it might have a few side-effects, or
> > > we call clk_get with NULL or bus depending on the case, and then call
> > > regmap_mmio_attach_clk.
> >
> > Thanks for the inputs.
> >
> > Please have a look at this snippet, I have used your second
> > suggestions. let me know if you have any comments?
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 8fa90cfc2ac8..91c95e56d870 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -1109,24 +1109,36 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >          return PTR_ERR(dsi->regulator);
> >      }
> >
> > -    dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
> > -                          &sun6i_dsi_regmap_config);
> > -    if (IS_ERR(dsi->regs)) {
> > -        dev_err(dev, "Couldn't create the DSI encoder regmap\n");
> > -        return PTR_ERR(dsi->regs);
> > -    }
> > -
> >      dsi->reset = devm_reset_control_get_shared(dev, NULL);
> >      if (IS_ERR(dsi->reset)) {
> >          dev_err(dev, "Couldn't get our reset line\n");
> >          return PTR_ERR(dsi->reset);
> >      }
> >
> > +    dsi->regs = regmap_init_mmio(dev, base, &sun6i_dsi_regmap_config);
>
> You should use the devm variant here

Sure.

>
> > +    if (IS_ERR(dsi->regs)) {
> > +        dev_err(dev, "Couldn't init regmap\n");
> > +        return PTR_ERR(dsi->regs);
> > +    }
> > +
> > +    dsi->bus_clk = devm_clk_get(dev, NULL);
>
> I guess you still need to pass 'bus' here?

But the idea here is not to specify clock name explicitly to support
A64. otherwise A64 would fail as we are not specifying the clock-names
explicitly on dsi node.

dsi: dsi@1ca0000 {
       compatible = "allwinner,sun50i-a64-mipi-dsi";
       reg = <0x01ca0000 0x1000>;
       interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
       clocks = <&ccu CLK_BUS_MIPI_DSI>;
       resets = <&ccu RST_BUS_MIPI_DSI>;
      phys = <&dphy>;
      phy-names = "dphy";
.....
};

>
> > +    if (IS_ERR(dsi->bus_clk)) {
> > +        dev_err(dev, "Couldn't get the DSI bus clock\n");
> > +        ret = PTR_ERR(dsi->bus_clk);
> > +        goto err_regmap;
> > +    } else {
> > +        printk("Jagan.. Got the BUS clock\n");
> > +        ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
> > +        if (ret)
> > +            goto err_bus_clk;
> > +    }
> > +
> >      if (dsi->variant->has_mod_clk) {
> >          dsi->mod_clk = devm_clk_get(dev, "mod");
> >          if (IS_ERR(dsi->mod_clk)) {
> >              dev_err(dev, "Couldn't get the DSI mod clock\n");
> > -            return PTR_ERR(dsi->mod_clk);
> > +            ret = PTR_ERR(dsi->mod_clk);
> > +            goto err_attach_clk;
> >          }
> >      }
> >
> > @@ -1167,6 +1179,14 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >  err_unprotect_clk:
> >      if (dsi->variant->has_mod_clk)
> >          clk_rate_exclusive_put(dsi->mod_clk);
> > +err_attach_clk:
> > +    if (!IS_ERR(dsi->bus_clk))
> > +        regmap_mmio_detach_clk(dsi->regs);
> > +err_bus_clk:
> > +    if (!IS_ERR(dsi->bus_clk))
> > +        clk_put(dsi->bus_clk);
> > +err_regmap:
> > +    regmap_exit(dsi->regs);
> >      return ret;
> >  }
> >
> > @@ -1181,6 +1201,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> >      if (dsi->variant->has_mod_clk)
> >          clk_rate_exclusive_put(dsi->mod_clk);
> >
> > +    if (!IS_ERR(dsi->bus_clk)) {
> > +        regmap_mmio_detach_clk(dsi->regs);
> > +        clk_put(dsi->bus_clk);
>
> This will trigger a warning, you put down the reference twice

You mean regmap_mmio_detach_clk will put the clk?

Jagan.

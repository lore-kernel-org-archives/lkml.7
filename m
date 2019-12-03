Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013B020684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NbCUwlha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfLCGiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:38:19 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44775 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfLCGiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:38:18 -0500
Received: by mail-io1-f65.google.com with SMTP id z23so2386251iog.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wpTQKnkngieuqXuzL7uZpLiKACy2LcoAuQquti9jps=;
        b=NbCUwlhamyMm8r7AOBEKPKTnKIR8a03HSnFaFm5T29JB6EoEHzTfUYuqeWVTovEJuR
         PEi7n0RtUBpm5MP+F4XmS8zG/MtaaUPC4wP/N8wkWP+6nC5rZS1IdlTcS+wAa/1hrZO1
         UZDjYdywaEr0Jq66vc3clKK8ZF6mQZ1KuGSP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wpTQKnkngieuqXuzL7uZpLiKACy2LcoAuQquti9jps=;
        b=FqCnP3wipyU6FS4ZN1zijXT1TnNt3ys2nBeCGfe6IzHZI3x8aticZUfyaFeloFpPO+
         Mm+RGgVas/I457cJaBlnYMdEb3cw9xDY4AM53I2uMNNDz7oUeON3/zoNTKyJrP90b6P5
         Yj3d7V5/Mm2I3oBOzf6/GnQ8TMtcfLc0W8H8oaDajjls9hMMRtNkNQktJSNsGRsGcfqc
         pF03AsP9WihI7tnjbttw7trAyan5a3sw5wWMfv+599/5rjAvWsNwPxfRaM7WjKVqULn/
         mC99Kv400yjZhisBRjKGv2iPQGdUwEe4iWCJhIsB6YZnvufzPMaugnm61sCtYVkhRtcU
         C3Lg==
X-Gm-Message-State: APjAAAVbYgtwxsylK8nUQ1o9zMYvjVcLJXyzOBnRCnRG/iv6wpHmjsTi
        RsKvtIWQThPOIwTTyR8gCRyuGunw68Rhp4y+xQ+ibg==
X-Google-Smtp-Source: APXvYqzw5MRI9bLbpC8aBKtEMr/lv/4bW1UrRcpCmyT5f0lq7NP3QUXl7E1sr2Kqyin1ufYe3yt6t3462BRba831Hcg=
X-Received: by 2002:a5d:804e:: with SMTP id b14mr1170073ior.77.1575355097154;
 Mon, 02 Dec 2019 22:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-5-jagan@amarulasolutions.com> <20191028153427.pc3tnoz2d23filhx@hendrix>
 <CAMty3ZCisTrFGjzHyqSofqFAsKSLV1n2xP5Li3Lonhdi0WUZVA@mail.gmail.com>
 <20191029085401.gvqpwmmpyml75vis@hendrix> <CAMty3ZAWPZSHtAZDf_0Dpx588YGGv3pJX1cXMfkZus3+WF94cA@mail.gmail.com>
 <20191103173227.GF7001@gilmour> <CAMty3ZD5uxU=xb0z7PWaXzodYbWRJkP9HjGX-HZYFT4bwk0GOg@mail.gmail.com>
 <20191122181820.GQ4345@gilmour.lan> <CAMty3ZDePC=B-DgfCcjRhJTeciwZmSEU-c4u1=sN_Hs0RgbC7Q@mail.gmail.com>
 <20191128175134.kcgtylfo4ax6ifz7@gilmour.lan>
In-Reply-To: <20191128175134.kcgtylfo4ax6ifz7@gilmour.lan>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 3 Dec 2019 12:08:06 +0530
Message-ID: <CAMty3ZBBkAk3==9u9XS3utms8GZD-5wPKu1WSR3byh5h-tY8aw@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] drm/sun4i: dsi: Handle bus clock explicitly
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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

On Thu, Nov 28, 2019 at 11:21 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sat, Nov 23, 2019 at 01:20:21AM +0530, Jagan Teki wrote:
> > > > Please have a look at this snippet, I have used your second
> > > > suggestions. let me know if you have any comments?
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > index 8fa90cfc2ac8..91c95e56d870 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > @@ -1109,24 +1109,36 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > > >          return PTR_ERR(dsi->regulator);
> > > >      }
> > > >
> > > > -    dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
> > > > -                          &sun6i_dsi_regmap_config);
> > > > -    if (IS_ERR(dsi->regs)) {
> > > > -        dev_err(dev, "Couldn't create the DSI encoder regmap\n");
> > > > -        return PTR_ERR(dsi->regs);
> > > > -    }
> > > > -
> > > >      dsi->reset = devm_reset_control_get_shared(dev, NULL);
> > > >      if (IS_ERR(dsi->reset)) {
> > > >          dev_err(dev, "Couldn't get our reset line\n");
> > > >          return PTR_ERR(dsi->reset);
> > > >      }
> > > >
> > > > +    dsi->regs = regmap_init_mmio(dev, base, &sun6i_dsi_regmap_config);
> > >
> > > You should use the devm variant here
> >
> > Sure.
> >
> > >
> > > > +    if (IS_ERR(dsi->regs)) {
> > > > +        dev_err(dev, "Couldn't init regmap\n");
> > > > +        return PTR_ERR(dsi->regs);
> > > > +    }
> > > > +
> > > > +    dsi->bus_clk = devm_clk_get(dev, NULL);
> > >
> > > I guess you still need to pass 'bus' here?
> >
> > But the idea here is not to specify clock name explicitly to support
> > A64. otherwise A64 would fail as we are not specifying the clock-names
> > explicitly on dsi node.
>
> Right. But you have no guarantee that the bus clock is going to be the
> first one on the other SoCs either.
>
> What about something like that instead:
>
> char *clk_name = NULL;
> if (dsi->has_mod_clk)
>     clk_name = "bus";
>
> clk = devm_clk_get(dev, clk_name);
> if (IS_ERR(clk))
>     return PTR_ERR(clk));
>
> regmap_mmio_attach_clk(regmap, clk);

This makes sense, thanks for your input. I have tested in A33, A64.

>
> >
> > dsi: dsi@1ca0000 {
> >        compatible = "allwinner,sun50i-a64-mipi-dsi";
> >        reg = <0x01ca0000 0x1000>;
> >        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> >        clocks = <&ccu CLK_BUS_MIPI_DSI>;
> >        resets = <&ccu RST_BUS_MIPI_DSI>;
> >       phys = <&dphy>;
> >       phy-names = "dphy";
> > .....
> > };
> >
> > >
> > > > +    if (IS_ERR(dsi->bus_clk)) {
> > > > +        dev_err(dev, "Couldn't get the DSI bus clock\n");
> > > > +        ret = PTR_ERR(dsi->bus_clk);
> > > > +        goto err_regmap;
> > > > +    } else {
> > > > +        printk("Jagan.. Got the BUS clock\n");
> > > > +        ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
> > > > +        if (ret)
> > > > +            goto err_bus_clk;
> > > > +    }
> > > > +
> > > >      if (dsi->variant->has_mod_clk) {
> > > >          dsi->mod_clk = devm_clk_get(dev, "mod");
> > > >          if (IS_ERR(dsi->mod_clk)) {
> > > >              dev_err(dev, "Couldn't get the DSI mod clock\n");
> > > > -            return PTR_ERR(dsi->mod_clk);
> > > > +            ret = PTR_ERR(dsi->mod_clk);
> > > > +            goto err_attach_clk;
> > > >          }
> > > >      }
> > > >
> > > > @@ -1167,6 +1179,14 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > > >  err_unprotect_clk:
> > > >      if (dsi->variant->has_mod_clk)
> > > >          clk_rate_exclusive_put(dsi->mod_clk);
> > > > +err_attach_clk:
> > > > +    if (!IS_ERR(dsi->bus_clk))
> > > > +        regmap_mmio_detach_clk(dsi->regs);
> > > > +err_bus_clk:
> > > > +    if (!IS_ERR(dsi->bus_clk))
> > > > +        clk_put(dsi->bus_clk);
> > > > +err_regmap:
> > > > +    regmap_exit(dsi->regs);
> > > >      return ret;
> > > >  }
> > > >
> > > > @@ -1181,6 +1201,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> > > >      if (dsi->variant->has_mod_clk)
> > > >          clk_rate_exclusive_put(dsi->mod_clk);
> > > >
> > > > +    if (!IS_ERR(dsi->bus_clk)) {
> > > > +        regmap_mmio_detach_clk(dsi->regs);
> > > > +        clk_put(dsi->bus_clk);
> > >
> > > This will trigger a warning, you put down the reference twice
> >
> > You mean regmap_mmio_detach_clk will put the clk?
>
> No, devm_clk_get will.

Got it. Will update and send v12.

Jagan.

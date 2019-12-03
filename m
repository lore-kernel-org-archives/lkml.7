Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F785C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0080205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TXmjBts9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfLCQk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:40:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35767 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLCQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:40:58 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so4491925iol.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ADZgj43Zep4H1J8Mj/VcJbdRhlth0WbMyVNDk+DUIs=;
        b=TXmjBts9yGklEBgcKeaJmPgWfdWczDywq2O06IPDEIT3xHUMDBV9Bf3GG2LRGbbUQO
         YLGjlPpiwjuiq2m0zQyUODfL2ZDx4pcWVZfN62P8SoyUItV9lsPug55S2/BriSARk1T2
         f3RoXLS9d8de0kIJzky4X0Kem2u4PhhHNTQo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ADZgj43Zep4H1J8Mj/VcJbdRhlth0WbMyVNDk+DUIs=;
        b=pcyW98lh31eoQZ6rIwlNyM8GdJZATXGnDWrVLBu06caMeh0h5VX/4i57ynfl/3rB2h
         VXP6pYI4pmRw2Pd47WpoRsrHEBFClO8FDvvtV5Y/a4LNlu73uS1UXT4bbuoGlWl8vBFu
         7QyZGx0KWJiw6wQroyN+0JAyFgrivKqvW+Eii7sdBBzyRiDI+PzU5g9iJJoKFbnMPJhI
         gBsfGOb3/0L4Oc4j78nwtK2Ibt8dkNehqNlL89O3BMv6oUMDzIn/jkig323XA1cdoL47
         LBw2aLEiz2T75kYD/7+mBwjZD/fE++1oxXhJzEmmH7w+P9INtRNk2qyE6xRR/XnxDWBt
         FosQ==
X-Gm-Message-State: APjAAAXJfn3sZttLUCBSSwO6Q5H2WjpumbmrkLp3lYlLFW6cnvOYkVHA
        6H533KPVdtNayZT2vsqfDHHT72+rKOs4/e2BPH5Zsg==
X-Google-Smtp-Source: APXvYqyUknfFp7ci16vlAjPaM9OGfbOPPZ9eNQAS1v4OfvuieGIMGC+L+uFRpNs/Ig8YhB5lcLQP/3aiQWzMvjITjms=
X-Received: by 2002:a5d:804e:: with SMTP id b14mr3080676ior.77.1575391256874;
 Tue, 03 Dec 2019 08:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-4-jagan@amarulasolutions.com> <CAGb2v67kQ391QJhQYYYEdchHpRYBUDji=iYMZ9fKY3aCw0He-Q@mail.gmail.com>
In-Reply-To: <CAGb2v67kQ391QJhQYYYEdchHpRYBUDji=iYMZ9fKY3aCw0He-Q@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 3 Dec 2019 22:10:45 +0530
Message-ID: <CAMty3ZDCgfeU=czWVUfDY_c5Q4xS=n27RfmNvR+dLSAv3oZzYg@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] drm/sun4i: dsi: Add has_mod_clk quirk
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 8:09 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Dec 3, 2019 at 9:48 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > As per the user manual, look like mod clock is not mandatory
> > for all Allwinner MIPI DSI controllers, it is connected to
> > CLK_DSI_SCLK for A31 and not available in A64.
> >
> > So add has_mod_clk quirk and process the mod clk accordingly.
> >
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v12:
> > - none
> >
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++++--------
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 ++++
> >  2 files changed, 32 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index c958ca9bae63..8c4c541224dd 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/crc-ccitt.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_device.h>
> >  #include <linux/phy/phy-mipi-dphy.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > @@ -1093,6 +1094,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >         dsi->dev = dev;
> >         dsi->host.ops = &sun6i_dsi_host_ops;
> >         dsi->host.dev = dev;
> > +       dsi->variant = of_device_get_match_data(dev);
> >
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         base = devm_ioremap_resource(dev, res);
> > @@ -1120,17 +1122,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >                 return PTR_ERR(dsi->reset);
> >         }
> >
> > -       dsi->mod_clk = devm_clk_get(dev, "mod");
> > -       if (IS_ERR(dsi->mod_clk)) {
> > -               dev_err(dev, "Couldn't get the DSI mod clock\n");
> > -               return PTR_ERR(dsi->mod_clk);
> > +       if (dsi->variant->has_mod_clk) {
> > +               dsi->mod_clk = devm_clk_get(dev, "mod");
> > +               if (IS_ERR(dsi->mod_clk)) {
> > +                       dev_err(dev, "Couldn't get the DSI mod clock\n");
> > +                       return PTR_ERR(dsi->mod_clk);
> > +               }
> >         }
> >
> >         /*
> >          * In order to operate properly, that clock seems to be always
> >          * set to 297MHz.
> >          */
> > -       clk_set_rate_exclusive(dsi->mod_clk, 297000000);
> > +       if (dsi->variant->has_mod_clk)
> > +               clk_set_rate_exclusive(dsi->mod_clk, 297000000);
>
> The clk API can handle NULL pointers, so you don't need to add the if here...

Ohh. I'm not aware of this. does it added recently?

>
> >
> >         dsi->dphy = devm_phy_get(dev, "dphy");
> >         if (IS_ERR(dsi->dphy)) {
> > @@ -1160,7 +1165,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >  err_pm_disable:
> >         pm_runtime_disable(dev);
> >  err_unprotect_clk:
> > -       clk_rate_exclusive_put(dsi->mod_clk);
> > +       if (dsi->variant->has_mod_clk)
> > +               clk_rate_exclusive_put(dsi->mod_clk);
>
> and here...
>
> >         return ret;
> >  }
> >
> > @@ -1172,7 +1178,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> >         component_del(&pdev->dev, &sun6i_dsi_ops);
> >         mipi_dsi_host_unregister(&dsi->host);
> >         pm_runtime_disable(dev);
> > -       clk_rate_exclusive_put(dsi->mod_clk);
> > +       if (dsi->variant->has_mod_clk)
> > +               clk_rate_exclusive_put(dsi->mod_clk);
>
> and here ...
>
> >
> >         return 0;
> >  }
> > @@ -1189,7 +1196,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
> >         }
> >
> >         reset_control_deassert(dsi->reset);
> > -       clk_prepare_enable(dsi->mod_clk);
> > +       if (dsi->variant->has_mod_clk)
> > +               clk_prepare_enable(dsi->mod_clk);
>
> and here...
>
> >
> >         /*
> >          * Enable the DSI block.
> > @@ -1217,7 +1225,8 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
> >  {
> >         struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> >
> > -       clk_disable_unprepare(dsi->mod_clk);
> > +       if (dsi->variant->has_mod_clk)
> > +               clk_disable_unprepare(dsi->mod_clk);
>
> and here.
>
> >         reset_control_assert(dsi->reset);
> >         regulator_disable(dsi->regulator);
> >
> > @@ -1230,9 +1239,16 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
> >                            NULL)
> >  };
> >
> > +static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi = {
> > +       .has_mod_clk = true,
> > +};
> > +
> >  static const struct of_device_id sun6i_dsi_of_table[] = {
> > -       { .compatible = "allwinner,sun6i-a31-mipi-dsi" },
> > -       { }
> > +       {
> > +               .compatible = "allwinner,sun6i-a31-mipi-dsi",
> > +               .data = &sun6i_a31_mipi_dsi,
> > +       },
> > +       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > index 3f4846f581ef..d791c9f6fccf 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > @@ -15,6 +15,10 @@
> >
> >  #define SUN6I_DSI_TCON_DIV     4
> >
> > +struct sun6i_dsi_variant {
> > +       bool                    has_mod_clk;
> > +};
> > +
>
> You could choose to put this above the probe function, since this isn't used
> anywhere else, and a pointer field doesn't need the full definition.

Okay. Will it be okay to check the compatibility directly on probe
using of_device_is_compatible?

Jagan.

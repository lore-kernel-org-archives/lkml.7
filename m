Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FFA21848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AYvgtbDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfJCHBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:01:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37133 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfJCHBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:01:44 -0400
Received: by mail-io1-f68.google.com with SMTP id b19so3115632iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 00:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaTSOsWkX0NwMXV+OVQ4GdiZGiGZm7DQLiGys1P/CwM=;
        b=AYvgtbDiQ21Bs+qVq2dGhqdNnCjEZtjI+RtycTGJZwDSFgTMwWE/ZDzIDSjDPI+4ko
         XIJkx4HVNDR3hj83PjWGh38PHwo7NJn/JnLE30yVfqtLZvxtTvU81/OWwr1NfwK1qwm8
         ZsKxbOXBdfpY3Evv0RggiUM8VFxlUP6MW24aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaTSOsWkX0NwMXV+OVQ4GdiZGiGZm7DQLiGys1P/CwM=;
        b=jAsz7f8daJ47L0G4dW/Zfn00LOz/eK3nEwKROYwNxktz6AiUy9pi7ckBf83Sidu3e6
         Mzh9pDVMF36i+K7Yt/FFGFLQMj4DRGzNM4WetKu4lyjAzLRCRlqyb9Yg6YEJvQ6F232I
         AfuEA42MkEHW+tJSyzpQNNPh7lZvOGFmwXPBNtGgTIukxqgam3nhQXLR87YWCfeVV4T4
         hb+n28THRWJIPSNxqY3smXGd0/2rwfNSgylt52y/U0diQ2GomDSX0dOXOWTZfi89B2k2
         JxZPG93mnTFbr0Jq54Qx3LYMwZPOf7ZPx+Cu2Y5x/Gj3zG9bPrtcObcgizlCAs4vGC4K
         gK9w==
X-Gm-Message-State: APjAAAVQOPMNdu8qmwgksM/0+3BH6CuxVvdFNHDxHaTJ9J9qnAoBENXG
        fzrFYBZ4sopnJwluNOvD2wj7alHYz5NY2L9R6ldaEA==
X-Google-Smtp-Source: APXvYqxM2F/rF0fpKNncuUJT+YRkExY6NtSZFmZJqRNh7an4Mrr/PKtbKXdxgxjXj+qLiStrfZW997mYZqDUjGR51tg=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr7264826ior.173.1570086102574;
 Thu, 03 Oct 2019 00:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
 <20191003064527.15128-6-jagan@amarulasolutions.com> <CAGb2v64RJeHXSDknPvH3RrDLqPzSvR-p2k2vA73Zt1xsOd5TSw@mail.gmail.com>
In-Reply-To: <CAGb2v64RJeHXSDknPvH3RrDLqPzSvR-p2k2vA73Zt1xsOd5TSw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Oct 2019 12:31:31 +0530
Message-ID: <CAMty3ZBmY+wZ4MZD1ipjnfhVy3gBRCqsAXGqF79mo+eaX=L2fA@mail.gmail.com>
Subject: Re: [PATCH v11 5/7] drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 12:26 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Oct 3, 2019 at 2:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Allwinner MIPI DSI controllers are supplied with SoC
> > DSI power rails via VCC-DSI pin.
> >
> > Add support for this supply pin by adding voltage
> > regulator handling code to MIPI DSI driver.
> >
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 ++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 446dc56cc44b..fe9a3667f3a1 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -1110,6 +1110,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> >                 return PTR_ERR(base);
> >         }
> >
> > +       dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
> > +       if (IS_ERR(dsi->regulator)) {
> > +               dev_err(dev, "Couldn't get VCC-DSI supply\n");
> > +               return PTR_ERR(dsi->regulator);
> > +       }
> > +
> >         dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
> >                                               &sun6i_dsi_regmap_config);
> >         if (IS_ERR(dsi->regs)) {
> > @@ -1183,6 +1189,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> >  static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
> >  {
> >         struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> > +       int err;
> > +
> > +       err = regulator_enable(dsi->regulator);
> > +       if (err) {
> > +               dev_err(dsi->dev, "failed to enable VCC-DSI supply: %d\n", err);
> > +               return err;
> > +       }
> >
> >         reset_control_deassert(dsi->reset);
> >         clk_prepare_enable(dsi->mod_clk);
> > @@ -1215,6 +1228,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
> >
> >         clk_disable_unprepare(dsi->mod_clk);
> >         reset_control_assert(dsi->reset);
> > +       regulator_disable(dsi->regulator);
> >
> >         return 0;
> >  }
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > index 5c3ad5be0690..a01d44e9e461 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> > @@ -12,6 +12,7 @@
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_mipi_dsi.h>
> > +#include <linux/regulator/consumer.h>
>
> You don't need to include the header file since you are only
> including a pointer to the struct, and nothing else.

Yes, make sense. I will drop it.

>
> Otherwise,
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

thanks.

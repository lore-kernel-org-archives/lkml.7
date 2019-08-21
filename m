Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B63C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D539822DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcVtPlYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfHURi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:38:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54136 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfHURi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so2968435wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snHJbOIxMuni+9ewxirmTGZtbt0/91lUrWczUzbWoCw=;
        b=BcVtPlYJ/upiybh37sTArqy6cUMVSTDi81Abdd+h45pBWLCeh8NGnshEqtcEkvCNPf
         nchxrB+YsxWErEnTxspnFDEoiq4o9cYaA2HRZFJsSRPi3y2xawAXbpt9wMVa8UcFUunO
         5oCfqI/kUIeLekp7X5yluVrXpScjL2f6cgYah25ejzbDkeBdO0xwI7F60ijqIct29cbN
         dVYzok+RwPuAbMOtN+GvkUdenZvXf9gRKq1EEj1l18EF4GWhv9Phu7tTPscK/PwU5Hm9
         2kPcD/XSrBv6zlggZYP6l/JtWBlS096JH2Pxdc+PkNOUnKp0Fm7NETMWPT2O/ZTLjy7P
         3NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snHJbOIxMuni+9ewxirmTGZtbt0/91lUrWczUzbWoCw=;
        b=pcDxtz2QrvrCtbc3HLBkxQP4PARET+rFqvjWz11QBHMGUhC2mU719Pxslsb+Bo7zkP
         9+oG37kkASK445lNRfrEJJkvyJEGDpXpcaeGaV8AhZ4dspjQMQtAIktoncOKoebGEToc
         wCBXJuGfuzg56Zh4C1yvOblv/TmSneP7+Uu8UWjdktc2KxGcFa40TDBnzejgV7gawroZ
         K/XmFbYjVecE6Ffn18jNup3EU71NyEyVpoKMSh/vJXzQLfLyiVGEygqwW4cwV3uR+0TP
         u9BU62pE6xhlBIo/o8L97NZQVm9obH4TlJuKIY4pqfsR87w8VH2UiLFQ3+RiB0GxCe2U
         dtkQ==
X-Gm-Message-State: APjAAAXRweFqwfZVQvR2KTPnZBrH4OvpCOftFo36yNK6YUCCUU7LSdKW
        iJ9cAeIb0IGL7vY6DXt+4moP+pkBJ+h++DrSfvnWEQ==
X-Google-Smtp-Source: APXvYqx5W/xNayGIQfjvLGiIQ5yqIyh389FHxmiLjWmE4XGL9MrlvUfYbo/vDCPof3I9UP1X0kux3I+4E6gW/rX8ZVg=
X-Received: by 2002:a1c:f910:: with SMTP id x16mr1227357wmh.173.1566409135025;
 Wed, 21 Aug 2019 10:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190627151740.2277-1-matt.redfearn@thinci.com> <CALAqxLUsf4HJBcAcd+qzycFC3d8XbKk9HyQ7FfCrH8Ewc3mzvw@mail.gmail.com>
In-Reply-To: <CALAqxLUsf4HJBcAcd+qzycFC3d8XbKk9HyQ7FfCrH8Ewc3mzvw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 21 Aug 2019 10:38:43 -0700
Message-ID: <CALAqxLX6LjoDXZRpAo4gnpCbWdFD+3HPVDWCTKKO45rpam052g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: adv7511: Attach to DSI host at probe time
To:     Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Sean Paul <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 3:27 PM John Stultz <john.stultz@linaro.org> wrote:
> On Thu, Jun 27, 2019 at 8:18 AM Matt Redfearn <matt.redfearn@thinci.com> wrote:
> >
> > In contrast to all of the DSI panel drivers in drivers/gpu/drm/panel
> > which attach to the DSI host via mipi_dsi_attach() at probe time, the
> > ADV7533 bridge device does not. Instead it defers this to the point that
> > the upstream device connects to its bridge via drm_bridge_attach().
> > The generic Synopsys MIPI DSI host driver does not register it's own
> > drm_bridge until the MIPI DSI has attached. But it does not call
> > drm_bridge_attach() on the downstream device until the upstream device
> > has attached. This leads to a chicken and the egg failure and the DRM
> > pipeline does not complete.
> > Since all other mipi_dsi_device drivers call mipi_dsi_attach() in
> > probe(), make the adv7533 mipi_dsi_device do the same. This ensures that
> > the Synopsys MIPI DSI host registers it's bridge such that it is
> > available for the upstream device to connect to.
> >
> > Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
> >
> > ---
> >
> > Changes in v2:
> > Cleanup if adv7533_attach_dsi fails.
> >
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > index e7ddd3e3db9..807827bd910 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -874,9 +874,6 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
> >                                  &adv7511_connector_helper_funcs);
> >         drm_connector_attach_encoder(&adv->connector, bridge->encoder);
> >
> > -       if (adv->type == ADV7533)
> > -               ret = adv7533_attach_dsi(adv);
> > -
> >         if (adv->i2c_main->irq)
> >                 regmap_write(adv->regmap, ADV7511_REG_INT_ENABLE(0),
> >                              ADV7511_INT0_HPD);
> > @@ -1222,8 +1219,17 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
> >         drm_bridge_add(&adv7511->bridge);
> >
> >         adv7511_audio_init(dev, adv7511);
> > +
> > +       if (adv7511->type == ADV7533) {
> > +               ret = adv7533_attach_dsi(adv7511);
> > +               if (ret)
> > +                       goto err_remove_bridge;
> > +       }
> > +
> >         return 0;
> >
> > +err_remove_bridge:
> > +       drm_bridge_remove(&adv7511->bridge);
> >  err_unregister_cec:
> >         i2c_unregister_device(adv7511->i2c_cec);
> >         if (adv7511->cec_clk)
> > --
>
> As a heads up, I just did some testing on drm-misc-next and this patch
> seems to be breaking the HiKey board.  On bootup, I'm seeing:
> [    4.209615] adv7511 2-0039: 2-0039 supply avdd not found, using
> dummy regulator
> [    4.217075] adv7511 2-0039: 2-0039 supply dvdd not found, using
> dummy regulator
> [    4.224453] adv7511 2-0039: 2-0039 supply pvdd not found, using
> dummy regulator
> [    4.231804] adv7511 2-0039: 2-0039 supply a2vdd not found, using
> dummy regulator
> [    4.239242] adv7511 2-0039: 2-0039 supply v3p3 not found, using
> dummy regulator
> [    4.246615] adv7511 2-0039: 2-0039 supply v1p2 not found, using
> dummy regulator
> [    4.272970] adv7511 2-0039: failed to find dsi host
>
> over and over.

I also just got a report that our testing is seeing this on the db410c
board as well:
  https://bugs.linaro.org/show_bug.cgi?id=5345

It seems like the change is making it try to attach to the dsi too
early before the dsi has registered?

thanks
-john

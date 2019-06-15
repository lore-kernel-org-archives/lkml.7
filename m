Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFD7C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5FE2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BtucgTmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfFOAoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 20:44:37 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43013 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFOAog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 20:44:36 -0400
Received: by mail-ua1-f68.google.com with SMTP id o2so1524288uae.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 17:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hqhu3iKjp8F7B0PNppJXXZGMbjFkFcAKAjlOSHZGpCw=;
        b=BtucgTmjUbw04kv6gLtiH5nn5+UMipRd1oqlFsMTR2xCAp7dX7SUmOFAn+CiWX1/b0
         hhfIE8TVXUaoZx+P37dcbybW/6oDUCNAojfJQ3XVpYGMNP//S4/I38oQKNIvywS47Ah3
         eIKb/hDcaVeqiHgUKu6Oac7LI+kqGw2jXUavc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hqhu3iKjp8F7B0PNppJXXZGMbjFkFcAKAjlOSHZGpCw=;
        b=esNFrhAdxew+/ugpThR2S2o+H2ScLSEQPOWs0aOPzknCezwgdXk5Af2VWCGRZcZ23L
         YuBhK60s9Bq4syfxthWeK0cgATAQFa+7JCLBDoCfYxPLqK3f2jr/xLge3QM3fmobfrJa
         d+0ExsPFNllhd3UAdDMq1aGOOCEflolrJ+FAk6BYI+2iE65kEOQwbLUvdy2xBfCfu0Mq
         kiF5b55QSOtpZfHcDIwpCuWlVt9YEmo4I8y0XYgTSh0IKrCymQNMJpI4LGYJXTpM8jsQ
         KJxQ6Xa26SWR71elymfFwYbQ52Gfb+YaSomV+w65XOa3X/lY4wApSpRH0bWopS1MtDM8
         HiLQ==
X-Gm-Message-State: APjAAAU4idPObvSB2rKJXhmSOQ5gdMu++hLgvb6iGIrlwiEA8MKKzLhn
        z06025dj2rsr0pp94ED9ldCc0msUUAgWPuwqKLiUMg==
X-Google-Smtp-Source: APXvYqzjiaDBlFO8bdV4IvvtCzZkmZFMZ8APcuYtyha2wtOhOiLtK7BKGsOv/u0x5QU1iMYswss+zrH9W2lUt/K8C88=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr1811971uad.15.1560559475175;
 Fri, 14 Jun 2019 17:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-2-dbasehore@chromium.org> <20190612211807.GA13155@ravnborg.org>
 <CAGAzgsqgbr5rWpyWB1H_66=kxBRb7kw4wE7h34TJfE7eJ1mSQQ@mail.gmail.com>
In-Reply-To: <CAGAzgsqgbr5rWpyWB1H_66=kxBRb7kw4wE7h34TJfE7eJ1mSQQ@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Fri, 14 Jun 2019 17:44:24 -0700
Message-ID: <CAGAzgsqv8qYM-+_4bPLHtyiaox2jFLMMka8n1Wnk-q5LVPKqDg@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/panel: Add helper for reading DT rotation
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 5:43 PM dbasehore . <dbasehore@chromium.org> wrote:
>
> On Wed, Jun 12, 2019 at 2:18 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Derek.
> >
> > On Mon, Jun 10, 2019 at 09:03:46PM -0700, Derek Basehore wrote:
> > > This adds a helper function for reading the rotation (panel
> > > orientation) from the device tree.
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_panel.c | 41 +++++++++++++++++++++++++++++++++++++
> > >  include/drm/drm_panel.h     |  7 +++++++
> > >  2 files changed, 48 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > > index dbd5b873e8f2..3b689ce4a51a 100644
> > > --- a/drivers/gpu/drm/drm_panel.c
> > > +++ b/drivers/gpu/drm/drm_panel.c
> > > @@ -172,6 +172,47 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
> > >       return ERR_PTR(-EPROBE_DEFER);
> > >  }
> > >  EXPORT_SYMBOL(of_drm_find_panel);
> > > +
> > > +/**
> > > + * of_drm_get_panel_orientation - look up the rotation of the panel using a
> > > + * device tree node
> > > + * @np: device tree node of the panel
> > > + * @orientation: orientation enum to be filled in
> > The comment says "enum" but the type used is an int.
> > Why not use enum drm_panel_orientation?
> >
>
> The binding is just an int value, but I can change it to the enum.

Oops, I see what happened here. The way I wrote it should actually use the enum

>
> > > + *
> > > + * Looks up the rotation of a panel in the device tree. The rotation in the
> > > + * device tree is counter clockwise.
> > > + *
> > > + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> > > + * rotation property doesn't exist. -EERROR otherwise.
> > > + */
> > Initially I read -EEROOR as a specific error code.
> > But I gues the semantic is to say that a negative error code is returned
> > if something was wrong.
> > As we do not use the "-EERROR" syntax anywhere else in drm, please
> > reword like we do in other places.
> >
> >
> > Also - it is worth to mention that the rotation returned is
> > DRM_MODE_PANEL_ORIENTATION_UNKNOWN if the property is not specified.
> > I wonder if this is correct, as no property could also been
> > interpretated as DRM_MODE_PANEL_ORIENTATION_NORMAL.
> > And in most cases the roation property is optional, so one could
> > assume that no property equals 0 degree.
> >
> >
> >         Sam
> >
> > > +int of_drm_get_panel_orientation(const struct device_node *np, int *orientation)
> > > +{
> > > +     int rotation, ret;
> > > +
> > > +     ret = of_property_read_u32(np, "rotation", &rotation);
> > > +     if (ret == -EINVAL) {
> > > +             /* Don't return an error if there's no rotation property. */
> > > +             *orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> > > +             return 0;
> > > +     }
> > > +
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     if (rotation == 0)
> > > +             *orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
> > > +     else if (rotation == 90)
> > > +             *orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
> > > +     else if (rotation == 180)
> > > +             *orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
> > > +     else if (rotation == 270)
> > > +             *orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
> > > +     else
> > > +             return -EINVAL;
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(of_drm_get_panel_orientation);
> > >  #endif
> > >
> > >  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> > > diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> > > index 8c738c0e6e9f..13631b2efbaa 100644
> > > --- a/include/drm/drm_panel.h
> > > +++ b/include/drm/drm_panel.h
> > > @@ -197,11 +197,18 @@ int drm_panel_detach(struct drm_panel *panel);
> > >
> > >  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
> > >  struct drm_panel *of_drm_find_panel(const struct device_node *np);
> > > +int of_drm_get_panel_orientation(const struct device_node *np,
> > > +                              int *orientation);
> > >  #else
> > >  static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
> > >  {
> > >       return ERR_PTR(-ENODEV);
> > >  }
> > > +int of_drm_get_panel_orientation(const struct device_node *np,
> > > +                              int *orientation)
> > > +{
> > > +     return -ENODEV;
> > > +}
> > >  #endif
> > >
> > >  #endif
> > > --
> > > 2.22.0.rc2.383.gf4fbbf30c2-goog

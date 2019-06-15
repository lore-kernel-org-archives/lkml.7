Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D5C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8C62183E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJKsD2z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFOAnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 20:43:22 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42580 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOAnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 20:43:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id 190so2851642vsf.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6kNs3vEbtZJz4gwMNE28MUy8volKIouYnWugvC1QNU=;
        b=TJKsD2z1z6LHWkhgoQw49uj/KvYdTS4zbFAkQsUSVUQ3JEk20zJgrxRzVBZUGXky+U
         05mj3xF2RM3pjz4JVDJMHlBOWviTHw/Ksu/cCWRuiKqbTVSm3IQC/+NKQaFD89Z7owt4
         inHctQiUqxK3dyWeKKUR0/v4aWFYvh8U5FlKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6kNs3vEbtZJz4gwMNE28MUy8volKIouYnWugvC1QNU=;
        b=tQU6pbtfp39fNkXcNptE+G2UUprLRow3mwUePC+/CYD1sSPZMMHE2q/Y9rCOVNZ3Ka
         FRpEq7ozOjehMS90UcbKkxxZ2kVxjFF8UXL0xBLESowRRn1sDpBM3iqgzEuET+7dBJEE
         ENVt4KGi3tWapHZJoji3FbHOpfqdcY1DJ5WXQcZYUQ1CwgMOGm9ezcjvZYiGFhnlQuLF
         a8UpYuk4FDD/5PN1UFqr2BYPkwJ4ADYVZfiy31nobCZ9jzZHcLJGcLkYAlk9b/6duLuB
         PbXECxccLsIckKRGwRoarA8FQdp4SOcaO2vS9GaLNtJQc6y9bW57N24w1wGhFVHR9jzk
         +Q0Q==
X-Gm-Message-State: APjAAAXQGNU2/mq4UMNzihqFJvNT+0QYxdiTjIMM/KUtGL1Yo9Q3J2sz
        H5BiW8x5tBkdByMZ+XhWj4SaQpu2m9Jp4L6BTeUvuQ==
X-Google-Smtp-Source: APXvYqyINzqLgoly97nAXbatYBIej847145lvC8l1Nj5Kjy8R4NBcmHdKvzptibuPr0Xq13NWsmWUIGgZWXDsSkN+Eo=
X-Received: by 2002:a67:7d13:: with SMTP id y19mr35490665vsc.232.1560559400933;
 Fri, 14 Jun 2019 17:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-2-dbasehore@chromium.org> <20190612211807.GA13155@ravnborg.org>
In-Reply-To: <20190612211807.GA13155@ravnborg.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Fri, 14 Jun 2019 17:43:09 -0700
Message-ID: <CAGAzgsqgbr5rWpyWB1H_66=kxBRb7kw4wE7h34TJfE7eJ1mSQQ@mail.gmail.com>
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

On Wed, Jun 12, 2019 at 2:18 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Derek.
>
> On Mon, Jun 10, 2019 at 09:03:46PM -0700, Derek Basehore wrote:
> > This adds a helper function for reading the rotation (panel
> > orientation) from the device tree.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_panel.c | 41 +++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_panel.h     |  7 +++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index dbd5b873e8f2..3b689ce4a51a 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -172,6 +172,47 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
> >       return ERR_PTR(-EPROBE_DEFER);
> >  }
> >  EXPORT_SYMBOL(of_drm_find_panel);
> > +
> > +/**
> > + * of_drm_get_panel_orientation - look up the rotation of the panel using a
> > + * device tree node
> > + * @np: device tree node of the panel
> > + * @orientation: orientation enum to be filled in
> The comment says "enum" but the type used is an int.
> Why not use enum drm_panel_orientation?
>

The binding is just an int value, but I can change it to the enum.

> > + *
> > + * Looks up the rotation of a panel in the device tree. The rotation in the
> > + * device tree is counter clockwise.
> > + *
> > + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> > + * rotation property doesn't exist. -EERROR otherwise.
> > + */
> Initially I read -EEROOR as a specific error code.
> But I gues the semantic is to say that a negative error code is returned
> if something was wrong.
> As we do not use the "-EERROR" syntax anywhere else in drm, please
> reword like we do in other places.
>
>
> Also - it is worth to mention that the rotation returned is
> DRM_MODE_PANEL_ORIENTATION_UNKNOWN if the property is not specified.
> I wonder if this is correct, as no property could also been
> interpretated as DRM_MODE_PANEL_ORIENTATION_NORMAL.
> And in most cases the roation property is optional, so one could
> assume that no property equals 0 degree.
>
>
>         Sam
>
> > +int of_drm_get_panel_orientation(const struct device_node *np, int *orientation)
> > +{
> > +     int rotation, ret;
> > +
> > +     ret = of_property_read_u32(np, "rotation", &rotation);
> > +     if (ret == -EINVAL) {
> > +             /* Don't return an error if there's no rotation property. */
> > +             *orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> > +             return 0;
> > +     }
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (rotation == 0)
> > +             *orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
> > +     else if (rotation == 90)
> > +             *orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
> > +     else if (rotation == 180)
> > +             *orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
> > +     else if (rotation == 270)
> > +             *orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
> > +     else
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(of_drm_get_panel_orientation);
> >  #endif
> >
> >  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> > diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> > index 8c738c0e6e9f..13631b2efbaa 100644
> > --- a/include/drm/drm_panel.h
> > +++ b/include/drm/drm_panel.h
> > @@ -197,11 +197,18 @@ int drm_panel_detach(struct drm_panel *panel);
> >
> >  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
> >  struct drm_panel *of_drm_find_panel(const struct device_node *np);
> > +int of_drm_get_panel_orientation(const struct device_node *np,
> > +                              int *orientation);
> >  #else
> >  static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
> >  {
> >       return ERR_PTR(-ENODEV);
> >  }
> > +int of_drm_get_panel_orientation(const struct device_node *np,
> > +                              int *orientation)
> > +{
> > +     return -ENODEV;
> > +}
> >  #endif
> >
> >  #endif
> > --
> > 2.22.0.rc2.383.gf4fbbf30c2-goog

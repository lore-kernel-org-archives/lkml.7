Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A12C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135C32086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZCpcSru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFYWNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:13:04 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40932 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYWND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:13:03 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so244732vsd.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3n+LcMejLmcA2HmAuYiDTQTe/hLh9m1gb0zWqdGsK68=;
        b=VZCpcSruMkBN/fSuTzWYVVaGnaXStuxDTlxa6KFFowmHSW6v2Kp5xf+pb8sCdtaNmI
         xWDUgTBPVJTm3UOzht8hRhzYr5tvq5wbDau9K9ekcL7zkkOkPO6YsM415uZM6T3vh/XA
         fGfPjTr6Fy2AgIjssn8ZMUzqkRDozC0cHm7b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3n+LcMejLmcA2HmAuYiDTQTe/hLh9m1gb0zWqdGsK68=;
        b=G9O9ffwgF+RkOF1032LehYSR/Idz8a/oNZ4IMCm93km6WShymKjG9X1hIvyDaKA5gm
         lxnOu3aAp38FI76hBouowJl7+QjQJVNXoWYZjdod71Hwpnwv2YWuDEr8QmchfSdPdh7r
         0XDH8HjW6cn7K9/1lPbTuyJRhbeOKkX5yG0fopdbbKI58L0KsUe3jP4zoaQHpVTnkxiB
         GmGE8ysJmnEy8fe2wriMiGd4Z6ov2NYB04ONIE75+5LGL7dZZtuXhMOxLxrR2faGsFAK
         sCDL/3yfdiNYrSMbZOpMTauaFDdldZ35bbXDjW47yiS1/jVsmmwe8Oq5HCYurzIZhd1s
         kTGA==
X-Gm-Message-State: APjAAAUeR4xKC4BZPRW9zNzPp3snJTjfKas3GtC9SHqY0ApiHSyQAt8f
        +EiGCMPFzZUzyiik9DnXV3juSDYh7F018nDx9aLfRA==
X-Google-Smtp-Source: APXvYqxAFcpueCkXxA4fX5ZdmVpn9ubMtxiNatLRjWu9UrGeHKopzC5JOp9YWWvfIyG8W3lvQ5C/O8BukWSbyTUXEmY=
X-Received: by 2002:a67:cd9a:: with SMTP id r26mr780862vsl.152.1561500782182;
 Tue, 25 Jun 2019 15:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190622034105.188454-1-dbasehore@chromium.org>
 <20190622034105.188454-2-dbasehore@chromium.org> <20190624203632.GA12316@ravnborg.org>
In-Reply-To: <20190624203632.GA12316@ravnborg.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Tue, 25 Jun 2019 15:12:51 -0700
Message-ID: <CAGAzgspnknoX_6zP4__tjQonxg53jjJj-xP=yrQydA2FhMG2JA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/panel: Add helper for reading DT rotation
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
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

On Mon, Jun 24, 2019 at 1:36 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Derek.
>
> On Fri, Jun 21, 2019 at 08:41:02PM -0700, Derek Basehore wrote:
> > This adds a helper function for reading the rotation (panel
> > orientation) from the device tree.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_panel.c | 42 +++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_panel.h     |  7 +++++++
> >  2 files changed, 49 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index dbd5b873e8f2..507099af4b57 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -172,6 +172,48 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
> >       return ERR_PTR(-EPROBE_DEFER);
> >  }
> >  EXPORT_SYMBOL(of_drm_find_panel);
> > +
> > +/**
> > + * of_drm_get_panel_orientation - look up the rotation of the panel using a
> > + * device tree node
> > + * @np: device tree node of the panel
> > + * @orientation: orientation enum to be filled in
> > + *
> > + * Looks up the rotation of a panel in the device tree. The rotation in the
> > + * device tree is counter clockwise.
> > + *
> > + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> > + * rotation property doesn't exist. -EERROR otherwise.
> > + */
> This function should better spell out why it talks about rotation versus
> orientation.
>
> It happens that orientation, due to bad design choices is named rotation
> in DT.
> But then this function is all about orientation, that just happens to be
> named rotation in DT.
> And the comments associated to the function should reflect this.
>
> something like:
> /**
>  * of_drm_get_panel_orientation - look up the orientation of the panel using a
>  * device tree node
>  * @np: device tree node of the panel
>  * @orientation: orientation enum to be filled in
>  *
>  * Looks up the rotation property of a panel in the device tree.
>  * The orientation of the panel is expressed as a property named
>  * "rotation" in the device tree.
>  * The rotation in the device tree is counter clockwise.
>  *
>  * Return: 0 when a valid orientation value (0, 90, 180, or 270) is read or the
>  * rotation property doesn't exist. -EERROR otherwise.
>  */

I'll clear this up in the next patch set.

>
> This would at least remove some of my confusiuon.
> And then maybe add a bit more explanation to the binding property
> description too.

Tried this, yet I got told off for adding kernel details to the DT
documentation (which is frowned upon).

>
>         Sam
>
>
>
>
>
>
>
>
>
>
>
>
> > +int of_drm_get_panel_orientation(const struct device_node *np,
> > +                              enum drm_panel_orientation *orientation)
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
> > index 8c738c0e6e9f..3564952f1a4f 100644
> > --- a/include/drm/drm_panel.h
> > +++ b/include/drm/drm_panel.h
> > @@ -197,11 +197,18 @@ int drm_panel_detach(struct drm_panel *panel);
> >
> >  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
> >  struct drm_panel *of_drm_find_panel(const struct device_node *np);
> > +int of_drm_get_panel_orientation(const struct device_node *np,
> > +                              enum drm_panel_orientation *orientation);
> >  #else
> >  static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
> >  {
> >       return ERR_PTR(-ENODEV);
> >  }
> > +int of_drm_get_panel_orientation(const struct device_node *np,
> > +                              enum drm_panel_orientation *orientation)
> > +{
> > +     return -ENODEV;
> > +}
> >  #endif
> >
> >  #endif
> > --
> > 2.22.0.410.gd8fdbe21b5-goog

Thanks for the review

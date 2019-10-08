Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CCFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B39720679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="KMSNlY73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfJHO40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:56:26 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38494 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:56:26 -0400
Received: by mail-yb1-f193.google.com with SMTP id r68so78958ybf.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTRvcWuhsCDYM9nbsR+iqmjU/q191FPit5GKXH0WNCw=;
        b=KMSNlY73MWApM2LnJJ05n+pDdlTTB791f5huU/c6JQNIdCTYwu5MkPWBrSvcjOfwaJ
         RsIQQZmSbuw4lnEfKSiahEq5i1zzbr8exb3K+yZvrB88/MRZRDwfJE0uEVH86Nn9JU+g
         ucOEsnRc6GOLykNYKeJodJazifzD5v45OoQMGMMsy24WgeIvktRE9HHPLT+THzUJ0U56
         +O4i5niWNKzssNdcq0RQ/stQZ1Kg7JjqBeuRW5WjnD35EjEFcTyXJv9nbrvKfwqwnV7d
         u39UXN1UxhENUBpLUdibXVnm0FSA6IKRNt5ICPRuzTXP2yeWSg/vxwUvhUshH2yMywal
         4VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTRvcWuhsCDYM9nbsR+iqmjU/q191FPit5GKXH0WNCw=;
        b=f3e40UoAGgFUC0ozkUPasV77FMLQGxZwpUZVFx0dBmgwAu6D9hlzg6E6QONq46/4vL
         nn3Z59r1X17OxU9ubopWEENgNNTMuf1Lk+23nZJ1lMFNu4gEQq13pAUhXZ/XiyCXqwn7
         /VYW+h8iF8cLvbJaK0KVLilwDsUtQ1TN8ra+UFCHrmjxcaD4BZUDnGJAlvxBPZrKB7F+
         DuU6Y3N3S8U+xMx60hx4y0UV7uZcbDZ2H5VyS9SbZkqgxq88OwDmAWmYi8CZ0uJKuZFC
         oQasAX69o4SSqbx1SEvNmxcO01xfXsRcyh+1keThsPPD/qHqq2papZFE65MkN6wCT89y
         JG1A==
X-Gm-Message-State: APjAAAUKzDpA3tLjpFX0ned8mutShh8Z7cWWlqwyXDy+mm26oq+yTm2e
        xWRvpcC6UxHnujapFFNkgWspYA==
X-Google-Smtp-Source: APXvYqxd3yI0Qoe4+zUlG7M7FCEqmfoW9HKyX9KBsgoGA3ualtp6JoAIN3/M6dE0Jb3/fTE37mcn/g==
X-Received: by 2002:a25:df87:: with SMTP id w129mr15524540ybg.121.1570546584814;
        Tue, 08 Oct 2019 07:56:24 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id v15sm4644853ywa.39.2019.10.08.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 07:56:24 -0700 (PDT)
Date:   Tue, 8 Oct 2019 10:56:23 -0400
From:   Sean Paul <sean@poorly.run>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     Sean Paul <sean@poorly.run>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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
Subject: Re: [PATCH v8 1/4] drm/panel: Add helper for reading DT rotation
Message-ID: <20191008145623.GA85762@art_vandelay>
References: <20190925225833.7310-1-dbasehore@chromium.org>
 <20190925225833.7310-2-dbasehore@chromium.org>
 <20191007163822.GA126146@art_vandelay>
 <CAGAzgspJa1b1V06s3Om+OAbPLqWsWSptbVtQApEPAXDA7W-VSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGAzgspJa1b1V06s3Om+OAbPLqWsWSptbVtQApEPAXDA7W-VSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 03:12:00PM -0700, dbasehore . wrote:
> On Mon, Oct 7, 2019 at 9:38 AM Sean Paul <sean@poorly.run> wrote:
> >
> > On Wed, Sep 25, 2019 at 03:58:30PM -0700, Derek Basehore wrote:
> > > This adds a helper function for reading the rotation (panel
> > > orientation) from the device tree.
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > The patch LGTM, but I don't see it used anywhere later in the patch? Is there a
> > panel driver incoming?
> 
> Yeah, the boe-tv101wum-nl6 panel will use it. It's not in the patch
> currently sent upstream since I don't want to step on their toes, but
> I plan on sending a patch to add it as soon as that is merged.
> 
> I could hold back on this patch until that panel driver is merged too.

Yeah, I think it's probably best. I don't anticipate any changes will be
required, but it's always best to review the code end-to-end.

I haven't checked in on that review, but if it's close to landing, you can also
add a patch to this stack that is based on the in-flight patches. That way we can
get all the review out of the way and then when the panel lands, we can apply
your add-on with the rest of the series.

Sean

> Another alternative is to throw this into the generic drm_panel code,
> but there's no obvious place to put it since DRM seems to leave
> reading the DTS up to the panel drivers themselves.
> 
> >
> > Sean
> >
> > > ---
> > >  drivers/gpu/drm/drm_panel.c | 43 +++++++++++++++++++++++++++++++++++++
> > >  include/drm/drm_panel.h     |  9 ++++++++
> > >  2 files changed, 52 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > > index 6b0bf42039cf..0909b53b74e6 100644
> > > --- a/drivers/gpu/drm/drm_panel.c
> > > +++ b/drivers/gpu/drm/drm_panel.c
> > > @@ -264,6 +264,49 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
> > >       return ERR_PTR(-EPROBE_DEFER);
> > >  }
> > >  EXPORT_SYMBOL(of_drm_find_panel);
> > > +
> > > +/**
> > > + * of_drm_get_panel_orientation - look up the orientation of the panel through
> > > + * the "rotation" binding from a device tree node
> > > + * @np: device tree node of the panel
> > > + * @orientation: orientation enum to be filled in
> > > + *
> > > + * Looks up the rotation of a panel in the device tree. The orientation of the
> > > + * panel is expressed as a property name "rotation" in the device tree. The
> > > + * rotation in the device tree is counter clockwise.
> > > + *
> > > + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> > > + * rotation property doesn't exist. -EERROR otherwise.
> > > + */
> > > +int of_drm_get_panel_orientation(const struct device_node *np,
> > > +                              enum drm_panel_orientation *orientation)
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
> > > index 624bd15ecfab..d16158deacdc 100644
> > > --- a/include/drm/drm_panel.h
> > > +++ b/include/drm/drm_panel.h
> > > @@ -34,6 +34,8 @@ struct drm_device;
> > >  struct drm_panel;
> > >  struct display_timing;
> > >
> > > +enum drm_panel_orientation;
> > > +
> > >  /**
> > >   * struct drm_panel_funcs - perform operations on a given panel
> > >   *
> > > @@ -165,11 +167,18 @@ int drm_panel_get_modes(struct drm_panel *panel);
> > >
> > >  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
> > >  struct drm_panel *of_drm_find_panel(const struct device_node *np);
> > > +int of_drm_get_panel_orientation(const struct device_node *np,
> > > +                              enum drm_panel_orientation *orientation);
> > >  #else
> > >  static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
> > >  {
> > >       return ERR_PTR(-ENODEV);
> > >  }
> > > +static inline int of_drm_get_panel_orientation(const struct device_node *np,
> > > +             enum drm_panel_orientation *orientation)
> > > +{
> > > +     return -ENODEV;
> > > +}
> > >  #endif
> > >
> > >  #endif
> > > --
> > > 2.23.0.351.gc4317032e6-goog
> > >
> >
> > --
> > Sean Paul, Software Engineer, Google / Chromium OS

-- 
Sean Paul, Software Engineer, Google / Chromium OS

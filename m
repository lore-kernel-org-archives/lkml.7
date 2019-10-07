Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E75BECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F44620867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MRy0AppF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfJGWMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:12:15 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40920 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:12:14 -0400
Received: by mail-ua1-f66.google.com with SMTP id i13so4587088uaq.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 15:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+x3+NIU7NmFQGG7aY+XAxLXvLzEYeAhpOrsYIv4oDkM=;
        b=MRy0AppFIQGOlY6L6gMMEunAMXL17PrnNxCObaQGdWiDqCIMWNkg6d5h2eu2WrGsUo
         isbpiMoDVCMNQvERIIm5fZzgOV9cvY+1+AfjY/rODIpIhEefkrJ5GDUVMpt12++LLjRp
         9Vn/Kcj1lKTBr5qjg8tHk7Co5qMshcdfb/qIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+x3+NIU7NmFQGG7aY+XAxLXvLzEYeAhpOrsYIv4oDkM=;
        b=FxtppPufnrxpo3ThjXsoKxc/vNmei8yVnY58rr9Ohu/yeYpMhRuPH83dg2Yk1kk7UP
         blO34Prn82elzEQ84kmpredLjkhXsIg+HupN1nKjmwnZft6UMCGB+bQ+shubZJd4kzeX
         ChwAd2imbPuZWmbxcznik0/i6IOTIOlQ5VpDTq1/3DitqGii0tAiPTyagpZ8/rHwQL+p
         WbyMahIeNsp9tntECkqn5sJbN5xSSxLMOmefuGH2RWxdD4D+t1dmcmlbIiS0UlJHpJLT
         G8e26Cc1xScCHDf0EOYIFAG5jIlviFaCnXiLlPFgWz+CzIDDfa2OcGJh6J6qIke5WNIK
         WDsw==
X-Gm-Message-State: APjAAAWPqdphJsalYysV05LyLEp7AA1qKTIojtREpz/E8znyRxMdp1K7
        fzwH4AGBelJyU4qeRB3b7LBHlfuLPd0mReoft6EuQQ==
X-Google-Smtp-Source: APXvYqyj2OkEFxcgaK3ee1ZsjfoQHllyB0cVUX7JFrkWjEJQF39euy4IXlYwvBX6Hqde2i9o6z7Czff2zEOecIzL9i0=
X-Received: by 2002:a9f:2746:: with SMTP id a64mr3186185uaa.66.1570486332696;
 Mon, 07 Oct 2019 15:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190925225833.7310-1-dbasehore@chromium.org> <20190925225833.7310-2-dbasehore@chromium.org>
 <20191007163822.GA126146@art_vandelay>
In-Reply-To: <20191007163822.GA126146@art_vandelay>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Mon, 7 Oct 2019 15:12:00 -0700
Message-ID: <CAGAzgspJa1b1V06s3Om+OAbPLqWsWSptbVtQApEPAXDA7W-VSQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] drm/panel: Add helper for reading DT rotation
To:     Sean Paul <sean@poorly.run>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 9:38 AM Sean Paul <sean@poorly.run> wrote:
>
> On Wed, Sep 25, 2019 at 03:58:30PM -0700, Derek Basehore wrote:
> > This adds a helper function for reading the rotation (panel
> > orientation) from the device tree.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> The patch LGTM, but I don't see it used anywhere later in the patch? Is there a
> panel driver incoming?

Yeah, the boe-tv101wum-nl6 panel will use it. It's not in the patch
currently sent upstream since I don't want to step on their toes, but
I plan on sending a patch to add it as soon as that is merged.

I could hold back on this patch until that panel driver is merged too.
Another alternative is to throw this into the generic drm_panel code,
but there's no obvious place to put it since DRM seems to leave
reading the DTS up to the panel drivers themselves.

>
> Sean
>
> > ---
> >  drivers/gpu/drm/drm_panel.c | 43 +++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_panel.h     |  9 ++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index 6b0bf42039cf..0909b53b74e6 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -264,6 +264,49 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
> >       return ERR_PTR(-EPROBE_DEFER);
> >  }
> >  EXPORT_SYMBOL(of_drm_find_panel);
> > +
> > +/**
> > + * of_drm_get_panel_orientation - look up the orientation of the panel through
> > + * the "rotation" binding from a device tree node
> > + * @np: device tree node of the panel
> > + * @orientation: orientation enum to be filled in
> > + *
> > + * Looks up the rotation of a panel in the device tree. The orientation of the
> > + * panel is expressed as a property name "rotation" in the device tree. The
> > + * rotation in the device tree is counter clockwise.
> > + *
> > + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> > + * rotation property doesn't exist. -EERROR otherwise.
> > + */
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
> > index 624bd15ecfab..d16158deacdc 100644
> > --- a/include/drm/drm_panel.h
> > +++ b/include/drm/drm_panel.h
> > @@ -34,6 +34,8 @@ struct drm_device;
> >  struct drm_panel;
> >  struct display_timing;
> >
> > +enum drm_panel_orientation;
> > +
> >  /**
> >   * struct drm_panel_funcs - perform operations on a given panel
> >   *
> > @@ -165,11 +167,18 @@ int drm_panel_get_modes(struct drm_panel *panel);
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
> > +static inline int of_drm_get_panel_orientation(const struct device_node *np,
> > +             enum drm_panel_orientation *orientation)
> > +{
> > +     return -ENODEV;
> > +}
> >  #endif
> >
> >  #endif
> > --
> > 2.23.0.351.gc4317032e6-goog
> >
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS

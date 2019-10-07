Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4370C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F242070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="FJqwZjxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfJGQor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:44:47 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41530 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJGQoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:44:44 -0400
Received: by mail-yb1-f195.google.com with SMTP id 206so4885840ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mS7sB/58XsSxkboHmbK13TsSVS2ybGG0SGJkhPLzIRA=;
        b=FJqwZjxVOe6UsLTNkV6cNOcVkQDkC4KclLXXo4pRQPaTooIORzEaZBlqgEJeBPOOD3
         IJQUhOl2gpWpgG1j1CKSDYGLzeqAVgiFW2TicYYsu+Q1pQl+4rWLpGMHSz+gmo8/sdef
         4xi+IBkorshJTxmB9ad2V6X1MF6kmcgw7GD5sR4YoOZv9/m5a1pYaTFZgtIn+WkJUzB6
         9LJed7khMsczg24yP8Qh6TOa8wiJN2M8PC9lyanJtYECU2f8MvPAwAe983h359YDoDZ3
         K2zL4QAkwA3zmBcxhurUBINhBfwbLvkPULM+XvXvbImd6H3qCjdwP8yYXR+0QdCI9Zw/
         gWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mS7sB/58XsSxkboHmbK13TsSVS2ybGG0SGJkhPLzIRA=;
        b=eIs1RTYSgv5T/Uddw5q5YKBRKYy+Z2pd2DoQlzqDHJFJ1/kryYhhCOgQkr8S9cSRId
         ShHCsPXKCS4ft7iY/SoqqQl1hmQQyUFBQz7FfEicK32r07IhaNQNm2Xc9Jq7CWpQWGis
         e1/ZgFU69M7s+PRoEURNWt6Ggj4TOI0TqTayW35ohpfAZx20eTDFIrwXTk3zN1hhPnCV
         otJWYzCMppncZzogbvzahWXztA9CuJmh/EV+ktmGCZkZ0KKNMv3lO34lLznmcNoWulgG
         dBPOUj1LckwrVapR84zsadILLbtrs3cdd03oLRc6uPeLKrLFrF7d6gnLRl+OT/TznQ9h
         IL1Q==
X-Gm-Message-State: APjAAAWNg+1ZuTNbgCsZ3HCmIvga+ePe2tZvIGFARxWHykYoh9BneKy2
        7wsgHsjcacCV/nOuzR5O++nzyQ==
X-Google-Smtp-Source: APXvYqwPFh/oPWw5D1v70gKt9HcmvrDgbglMJChBEx8hH0KZ84ySsjUBo3BnYKMDcqeaE3bgeD+pGA==
X-Received: by 2002:a25:8107:: with SMTP id o7mr11026920ybk.292.1570466682206;
        Mon, 07 Oct 2019 09:44:42 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id p204sm4078445ywp.110.2019.10.07.09.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:44:41 -0700 (PDT)
Date:   Mon, 7 Oct 2019 12:44:41 -0400
From:   Sean Paul <sean@poorly.run>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>, Sean Paul <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>
Subject: Re: [v8,2/4] drm/panel: set display info in panel attach
Message-ID: <20191007164441.GB126146@art_vandelay>
References: <20190925225833.7310-3-dbasehore@chromium.org>
 <20190929052307.GA28304@jamwan02-TSP300>
 <CAGAzgspEA0mcEHwgxyWWh3Gn-iC+a21g5GUrhsRJrTHQ_OAYqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGAzgspEA0mcEHwgxyWWh3Gn-iC+a21g5GUrhsRJrTHQ_OAYqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:14:54PM -0700, dbasehore . wrote:
> On Sat, Sep 28, 2019 at 10:23 PM james qian wang (Arm Technology
> China) <james.qian.wang@arm.com> wrote:
> >
> > On Wed, Sep 25, 2019 at 03:58:31PM -0700, Derek Basehore wrote:
> > > Devicetree systems can set panel orientation via a panel binding, but
> > > there's no way, as is, to propagate this setting to the connector,
> > > where the property need to be added.
> > > To address this, this patch sets orientation, as well as other fixed
> > > values for the panel, in the drm_panel_attach function. These values
> > > are stored from probe in the drm_panel struct.
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > ---
> > >  drivers/gpu/drm/drm_panel.c | 28 +++++++++++++++++++++
> > >  include/drm/drm_panel.h     | 50 +++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 78 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > > index 0909b53b74e6..1cd2b56c9fe6 100644
> > > --- a/drivers/gpu/drm/drm_panel.c
> > > +++ b/drivers/gpu/drm/drm_panel.c
> > > @@ -104,11 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
> > >   */
> > >  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
> > >  {
> > > +     struct drm_display_info *info;
> > > +
> > >       if (panel->connector)
> > >               return -EBUSY;
> > >
> > >       panel->connector = connector;
> > >       panel->drm = connector->dev;
> > > +     info = &connector->display_info;
> > > +     info->width_mm = panel->width_mm;
> > > +     info->height_mm = panel->height_mm;
> > > +     info->bpc = panel->bpc;
> > > +     info->panel_orientation = panel->orientation;
> > > +     info->bus_flags = panel->bus_flags;
> > > +     if (panel->bus_formats)
> > > +             drm_display_info_set_bus_formats(&connector->display_info,
> > > +                                              panel->bus_formats,
> > > +                                              panel->num_bus_formats);
> > >
> > >       return 0;
> > >  }
> > > @@ -126,6 +138,22 @@ EXPORT_SYMBOL(drm_panel_attach);
> > >   */
> > >  void drm_panel_detach(struct drm_panel *panel)
> > >  {
> > > +     struct drm_display_info *info;
> > > +
> > > +     if (!panel->connector)
> > > +             goto out;
> > > +
> > > +     info = &panel->connector->display_info;
> > > +     info->width_mm = 0;
> > > +     info->height_mm = 0;
> > > +     info->bpc = 0;
> > > +     info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> > > +     info->bus_flags = 0;
> > > +     kfree(info->bus_formats);
> > > +     info->bus_formats = NULL;
> > > +     info->num_bus_formats = 0;
> > > +
> > > +out:
> > >       panel->connector = NULL;
> > >       panel->drm = NULL;
> > >  }
> > > diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> > > index d16158deacdc..f3587a54b8ac 100644
> > > --- a/include/drm/drm_panel.h
> > > +++ b/include/drm/drm_panel.h
> > > @@ -141,6 +141,56 @@ struct drm_panel {
> > >        */
> > >       const struct drm_panel_funcs *funcs;
> > >
> >
> > All these new added members seems dupliated with drm_display_info,
> > So I think, can we add a new drm_plane_funcs func:
> >
> > int (*set_display_info)(struct drm_panel *panel,
> >                         struct drm_display_info *info);
> 
> I don't disagree personally, since I originally wrote it this way, but
> 2 maintainers, Daniel Vetter and Thierry Reding, requested that it be
> changed. Unless that decision is reversed, I won't be changing this.
> 

Reading back the feedback on v1, I don't think anyone said they were against
storing a drm_display_info struct in drm_panel (no one really weighed in on
it one way or another). IMO duplicating a bunch of fields feels pretty icky.

I think most fields in drm_display_info have pretty reasonable defaults, so I'd
recommend just storing a copy in drm_panel. As Thierry suggests, we can
populate the dt parts in probe (orientation) and then copy over all or a subset
of the struct to connector on attach.

Sean

> >
> > Then in drm_panel_attach(), via this interface the specific panel
> > driver can directly set connector->display_info. like
> >
> >    ...
> >    if (panel->funcs && panel->funcs->set_display_info)
> >                 panel->funcs->unprepare(panel, connector->display_info);
> >    ...
> >
> > Thanks
> > James
> >
> > > +     /**
> > > +      * @width_mm:
> > > +      *
> > > +      * Physical width in mm.
> > > +      */
> > > +     unsigned int width_mm;
> > > +
> > > +     /**
> > > +      * @height_mm:
> > > +      *
> > > +      * Physical height in mm.
> > > +      */
> > > +     unsigned int height_mm;
> > > +
> > > +     /**
> > > +      * @bpc:
> > > +      *
> > > +      * Maximum bits per color channel. Used by HDMI and DP outputs.
> > > +      */
> > > +     unsigned int bpc;
> > > +
> > > +     /**
> > > +      * @orientation
> > > +      *
> > > +      * Installation orientation of the panel with respect to the chassis.
> > > +      */
> > > +     int orientation;
> > > +
> > > +     /**
> > > +      * @bus_formats
> > > +      *
> > > +      * Pixel data format on the wire.
> > > +      */
> > > +     const u32 *bus_formats;
> > > +
> > > +     /**
> > > +      * @num_bus_formats:
> > > +      *
> > > +      * Number of elements pointed to by @bus_formats
> > > +      */
> > > +     unsigned int num_bus_formats;
> > > +
> > > +     /**
> > > +      * @bus_flags:
> > > +      *
> > > +      * Additional information (like pixel signal polarity) for the pixel
> > > +      * data on the bus.
> > > +      */
> > > +     u32 bus_flags;
> > > +
> > >       /**
> > >        * @list:
> > >        *
> 
> Thanks for the review

-- 
Sean Paul, Software Engineer, Google / Chromium OS

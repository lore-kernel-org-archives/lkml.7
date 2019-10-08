Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E35C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156C52070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="dhhnvkQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfJHPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:03:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33053 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfJHPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:02:59 -0400
Received: by mail-yb1-f196.google.com with SMTP id w141so5449591ybe.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZTSIKqLe1Xh/tE/i1buAM4aJM5s7zBbM3sshp8Umhc=;
        b=dhhnvkQgwFWhCMKQ+XWonnecZzsSaVFVBPrCxe2TMcLGkg5PNZb0wW8wLsONDEKG/Q
         rWf9Ir2IRavbsOX42BgmynaM/qEn8Yc2zJputvpdjVW9LWkzzHYFFfirCWRbAopX8LR3
         o3ugcF8CWEoDnsZPD0YhgVQyISOrfeIXK3IPVnVGgbrqr8CEv15mHvpjHW4yG6IDped1
         kBKP4vmgM+mwB+FUgy5nEQRmPz1iGWJMYeCW9q4MW9WqXOrPbXO2tdQjUSS7XpZZFI2m
         u4c5UPYbjez2vEFAV0S81/W069RicABkUfiH9j5Ce9Y9XC1138v0KD83LSj/NpnHXOOu
         Wk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZTSIKqLe1Xh/tE/i1buAM4aJM5s7zBbM3sshp8Umhc=;
        b=NDJHfhx2zFwm5bEDsea38WHm2ISDF5+Tb/dUv+GGfRnYEAeegWvbuCyhDw/lj3+3dY
         A93Ap0hJAhXo2JgAHEOCN0AksIolBA4yRaUP+rvBSZfBUEFrECzgQ1uKwmzZLmnIi4vm
         +dYUsYdo/51jpc3QwK484/Valz1X6WGloVA7X3hSfEjqbt544qbEpylLTFp0Ou6YyiaS
         FsAlV0oqWI28Z9oXqdN8ULcmkqujCKeFWZSZfzaq5sj16ly68TWnxcjPqm6mJDHdsi11
         IH1aOzD9tjT6eb0hC2pTJ55OTIvDifbO0dTB1fr/OEa+d9aQsSr8KbaQ7/kTLZfqC4lq
         9L3w==
X-Gm-Message-State: APjAAAXdodW3WIZaJ5w1Ht935Qhoip5nSjK1ha5vX0DUBvPc+EJRH8YR
        D6ZDmmV65K4Tbgo72xezyItZtQ==
X-Google-Smtp-Source: APXvYqy39p5S3WFZZT7NiYaub1fXy7Bu93rQKzD9kNuqH+MdsdnurfzRi4Ts2yLz/4adcpC4DJClcA==
X-Received: by 2002:a25:c504:: with SMTP id v4mr14307259ybe.375.1570546978393;
        Tue, 08 Oct 2019 08:02:58 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id g20sm4699956ywe.98.2019.10.08.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:02:57 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:02:57 -0400
From:   Sean Paul <sean@poorly.run>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     Sean Paul <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
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
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>
Subject: Re: [v8,2/4] drm/panel: set display info in panel attach
Message-ID: <20191008150257.GB85762@art_vandelay>
References: <20190925225833.7310-3-dbasehore@chromium.org>
 <20190929052307.GA28304@jamwan02-TSP300>
 <CAGAzgspEA0mcEHwgxyWWh3Gn-iC+a21g5GUrhsRJrTHQ_OAYqQ@mail.gmail.com>
 <20191007164441.GB126146@art_vandelay>
 <CAGAzgsoGNNTeYTmRyC5YNGDHL+SBB2oCFaHFubYa=dnPst=f8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGAzgsoGNNTeYTmRyC5YNGDHL+SBB2oCFaHFubYa=dnPst=f8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/snip

> > > > > diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> > > > > index d16158deacdc..f3587a54b8ac 100644
> > > > > --- a/include/drm/drm_panel.h
> > > > > +++ b/include/drm/drm_panel.h
> > > > > @@ -141,6 +141,56 @@ struct drm_panel {
> > > > >        */
> > > > >       const struct drm_panel_funcs *funcs;
> > > > >
> > > >
> > > > All these new added members seems dupliated with drm_display_info,
> > > > So I think, can we add a new drm_plane_funcs func:
> > > >
> > > > int (*set_display_info)(struct drm_panel *panel,
> > > >                         struct drm_display_info *info);
> > >
> > > I don't disagree personally, since I originally wrote it this way, but
> > > 2 maintainers, Daniel Vetter and Thierry Reding, requested that it be
> > > changed. Unless that decision is reversed, I won't be changing this.
> > >
> >
> > Reading back the feedback on v1, I don't think anyone said they were against
> > storing a drm_display_info struct in drm_panel (no one really weighed in on
> > it one way or another). IMO duplicating a bunch of fields feels pretty icky.
> 
> Thanks for the review. Should we duplicate the entire struct, or just
> create a sub-struct, say, physical_properties that will be part of
> drm_display_info and drm_panel?

That's a good idea, but I think you can use the entire struct. Everything has
reasonable default values and I think it might be difficult to draw a line in
the sand as to which fields will or won't be useful for panels going forward.
Best for drivers to just treat the info in drm_display_info as best effort and
have good defaults IMO.

Sean

> 
> >
> > I think most fields in drm_display_info have pretty reasonable defaults, so I'd
> > recommend just storing a copy in drm_panel. As Thierry suggests, we can
> > populate the dt parts in probe (orientation) and then copy over all or a subset
> > of the struct to connector on attach.
> >
> > Sean
> >
> > > >
> > > > Then in drm_panel_attach(), via this interface the specific panel
> > > > driver can directly set connector->display_info. like
> > > >
> > > >    ...
> > > >    if (panel->funcs && panel->funcs->set_display_info)
> > > >                 panel->funcs->unprepare(panel, connector->display_info);
> > > >    ...
> > > >
> > > > Thanks
> > > > James
> > > >
> > > > > +     /**
> > > > > +      * @width_mm:
> > > > > +      *
> > > > > +      * Physical width in mm.
> > > > > +      */
> > > > > +     unsigned int width_mm;
> > > > > +
> > > > > +     /**
> > > > > +      * @height_mm:
> > > > > +      *
> > > > > +      * Physical height in mm.
> > > > > +      */
> > > > > +     unsigned int height_mm;
> > > > > +
> > > > > +     /**
> > > > > +      * @bpc:
> > > > > +      *
> > > > > +      * Maximum bits per color channel. Used by HDMI and DP outputs.
> > > > > +      */
> > > > > +     unsigned int bpc;
> > > > > +
> > > > > +     /**
> > > > > +      * @orientation
> > > > > +      *
> > > > > +      * Installation orientation of the panel with respect to the chassis.
> > > > > +      */
> > > > > +     int orientation;
> > > > > +
> > > > > +     /**
> > > > > +      * @bus_formats
> > > > > +      *
> > > > > +      * Pixel data format on the wire.
> > > > > +      */
> > > > > +     const u32 *bus_formats;
> > > > > +
> > > > > +     /**
> > > > > +      * @num_bus_formats:
> > > > > +      *
> > > > > +      * Number of elements pointed to by @bus_formats
> > > > > +      */
> > > > > +     unsigned int num_bus_formats;
> > > > > +
> > > > > +     /**
> > > > > +      * @bus_flags:
> > > > > +      *
> > > > > +      * Additional information (like pixel signal polarity) for the pixel
> > > > > +      * data on the bus.
> > > > > +      */
> > > > > +     u32 bus_flags;
> > > > > +
> > > > >       /**
> > > > >        * @list:
> > > > >        *
> > >
> > > Thanks for the review
> >
> > --
> > Sean Paul, Software Engineer, Google / Chromium OS

-- 
Sean Paul, Software Engineer, Google / Chromium OS

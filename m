Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CEECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CB020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fXBFCO32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfJIKrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:47:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46246 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfJIKrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:47:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id t3so1540470edw.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C/f6/fe6l9qpOq8K1lx4cS1L0t1Hq00anJTRcpjdZaY=;
        b=fXBFCO323Bm+FQBU/+LL08XySBNen3E6T9qKA4aIio7ZnVTc1qrmiXWPHfafjaF5OM
         5+mK5egfmwUECqbtv1EY9REiXUiGHZdUls0/dxznEkib+Mj3bSSpPBFsRkZrfsTEJLTB
         MelIIKF4vIGWv96w8TwbvIWb5b5NsUUnkfhjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=C/f6/fe6l9qpOq8K1lx4cS1L0t1Hq00anJTRcpjdZaY=;
        b=qTMFR12zSupuPQrowxur/JXLiCjaZaFsv018jMTodfmlZ+6OCuEIALvz7I7f8eazog
         Y/B+YxDqB46ep5PUx5+bKSVpSxJjJH61TVHHFZd04dKGNXk8Be1OxQLh5203tysI6mbw
         a3zwaIvHEjdKKvRxcXmCALkrDx99qZMOYHgYdWdem2Zw3be0HU2MqnbIoRzXx4k7I2DA
         i1qChzgEE0bFByn8NwlnLPHNxuUD4gt+iKbQiNA+IXXIBvfs2pEXG9I+qGxaeo04sByy
         I8M1LqNOTrbizmaxBD97Z3xdSJnL+iV0IAv3hVQxPudm5u6PoLjgN6Czfo8zdiQpPfgO
         pe9w==
X-Gm-Message-State: APjAAAW28SaIIhvNYZJRGdYqTSTOVZ14iByrLJpcFsWl9QuovA1Fw9vl
        kZdDlGLm+M6lkgAGeDKiiYFIrBzZaJ8=
X-Google-Smtp-Source: APXvYqwFKxcsVszGn80rMYG6TMaGo4tkWTwu1HVt5uwb1ZbnJ6lXbxPzQggnmUgneVU6eJIaIg8Pmw==
X-Received: by 2002:a50:f10a:: with SMTP id w10mr2253640edl.247.1570618050207;
        Wed, 09 Oct 2019 03:47:30 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id dv15sm208287ejb.49.2019.10.09.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:47:29 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:47:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jeykumar Sankaran <jsanka@codeaurora.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/meson: fix max mode_config height/width
Message-ID: <20191009104727.GX16989@phenom.ffwll.local>
Mail-Followup-To: Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
 <20181004100958.GI31561@phenom.ffwll.local>
 <0ef7fa13-ce77-f8a5-f5f3-6568be3d6145@baylibre.com>
 <CAKMK7uHxiDF3z19cMBb0o2o4Ev0DFJkhMR7Ny6U2776Ry4oc=A@mail.gmail.com>
 <8e980de4-5a52-8f3d-fba2-734617e40d1b@baylibre.com>
 <CAKMK7uE71OeOdDPb+5-cs9bByD-unYPxBV_R1t+4A0Nb4H6CAw@mail.gmail.com>
 <5dbd6337-7e08-f3f7-6d4a-d6bcaddfd3be@baylibre.com>
 <91cd8a2aebefd4ea3e9bcee5a4ef796a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cd8a2aebefd4ea3e9bcee5a4ef796a@codeaurora.org>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:28:48AM -0700, Jeykumar Sankaran wrote:
> Reviving this thread from the context of the below conversion:
> 
> https://lore.kernel.org/linux-arm-msm/db26145b-3f64-a334-f698-76f972332881@baylibre.com/T/#u
> 
> On 2018-10-05 01:19, Neil Armstrong wrote:
> > On 05/10/2018 09:58, Daniel Vetter wrote:
> > > On Fri, Oct 5, 2018 at 9:39 AM Neil Armstrong
> > > <narmstrong@baylibre.com> wrote:
> > > > 
> > 
> > [...]
> > 
> > > > OK, won't this be enough ?
> > > > --- a/include/drm/drm_mode_config.h
> > > > +++ b/include/drm/drm_mode_config.h
> > > > @@ -333,6 +333,8 @@ struct drm_mode_config_funcs {
> > > >   * @min_height: minimum fb pixel height on this device
> > > >   * @max_width: maximum fb pixel width on this device
> > > >   * @max_height: maximum fb pixel height on this device
> > > > + * @max_fb_width: maximum fb buffer width if differs from max_width
> > > > + * @max_fb_height: maximum fb buffer height if differs from
> > > > max_height
> > > >   * @funcs: core driver provided mode setting functions
> > > >   * @fb_base: base address of the framebuffer
> > > >   * @poll_enabled: track polling support for this device
> > > > @@ -508,6 +510,7 @@ struct drm_mode_config {
> > > > 
> > > >         int min_width, min_height;
> > > >         int max_width, max_height;
> > > > +       int max_fb_width, max_fb_height;
> > > >         const struct drm_mode_config_funcs *funcs;
> > > >         resource_size_t fb_base;
> > > > 
> > > > --- a/drivers/gpu/drm/drm_framebuffer.c
> > > > +++ b/drivers/gpu/drm/drm_framebuffer.c
> > > > @@ -283,14 +283,20 @@ drm_internal_framebuffer_create(struct
> > > > drm_device *dev,
> > > >                 return ERR_PTR(-EINVAL);
> > > >         }
> > > > 
> > > > -       if ((config->min_width > r->width) || (r->width >
> > > > config->max_width)) {
> > > > +       if ((config->min_width > r->width) ||
> > > > +           (!config->max_fb_width && r->width >
> > > > config->max_width) ||
> > > > +           (config->max_fb_width && r->width >
> > > > config->max_fb_width)) {
> > > >                 DRM_DEBUG_KMS("bad framebuffer width %d, should
> > > > be >= %d && <= %d\n",
> > > > -                         r->width, config->min_width,
> > > > config->max_width);
> > > > +                         r->width, config->min_width,
> > > > config->max_fb_width ?
> > > > +                         config->max_fb_width : config->max_width);
> > > >                 return ERR_PTR(-EINVAL);
> > > >         }
> > > > -       if ((config->min_height > r->height) || (r->height >
> > > > config->max_height)) {
> > > > +       if ((config->min_height > r->height) ||
> > > > +           (!config->max_fb_height && r->height >
> > > > config->max_height) ||
> > > > +           (config->max_fb_height && r->height >
> > > > config->max_fb_height)) {
> > > >                 DRM_DEBUG_KMS("bad framebuffer height %d, should
> > > > be >= %d && <= %d\n",
> > > > -                         r->height, config->min_height,
> > > > config->max_height);
> > > > +                         r->height, config->min_height,
> > > > config->max_fb_height ?
> > > > +                         config->max_fb_height :
> > > > config->max_height);
> > > >                 return ERR_PTR(-EINVAL);
> > > >         }
> > > > 
> > > > and in the driver :
> > > > 
> > > > +       drm->mode_config.max_width = 4096;
> > > > +       drm->mode_config.max_height = 3840;
> > > > +       drm->mode_config.max_fb_width = 16384;
> > > > +       drm->mode_config.max_fb_height = 8192;
> > > > 
> > > > With this I leave the mode filtering intact.
> > > 
> > > Not enough. See
> > > https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html#c.drm_connector_helper_funcs
> > > and scroll down to mode_valid. You need to filter modes both in the
> > > detect paths, and the atomic_check paths.
> > > 
> > > Detect is explicitly filtered out, but atomic_check was only
> > > implicitly filtered, through the max fb size checks. Ok, you could
> > > light up a mode that's bigger than max fb, but in practice, no
> > > userspace ever did that.
> 
> Daniel, MSM and few other vendor hardware have upscale blocks where the
> driver can expose fb sizes smaller than
> the mode resolution and use h/w upscaling to fill the screen. This would
> optimize the fetch bandwidth.
> 
> But with your code we're missing crucial
> > > validation now, and userspace could fall over that. What I think we
> > > need is to add mode filter against mode_config.max_width/height in
> > > drm_atomic_helper_check_modeset(). Probably best to stuff that into
> > > the mode_valid() function.
> > 
> Agreed! Since the above patch from Niel is taking care of cases where
> max/min fb values
> are not set, by checking against the original max/min values, can we
> separate out this
> core change from the driver level mode_valid changes? If Niel couldn't find
> the time, I can
> repost the above change.

Sure, I think Neil wouldn't mind if you take this over and get it ready
for merging. Just need to make sure we're not leaving any validation gaps
in core/helper code.
-Daniel

> 
> Thanks and Regards,
> Jeykumar S.
> 
> > Ok I understood now, thanks for pointer, I'll try to add this.
> > 
> > Neil
> > 
> > > 
> > > Cheers, Daniel
> > > > 
> > > > Neil
> > > > 
> > > > 
> > > > > -Daniel
> > > > > 
> > > > > > 
> > > > > > Neil
> > > > > > 
> > > > > > > 
> > > > > > > Bunch of igt to make sure we're not missing anything
> > > > > > > would be sweet on
> > > > > > > top, e.g. e.g. trying to set a mode over the limit
> > > > > > > and making sure it
> > > > > > > fails.
> > > > > > > 
> > > > > > > Cheers, Daniel
> > > > > > > 
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
> > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/gpu/drm/meson/meson_drv.c
> > > > > > > > b/drivers/gpu/drm/meson/meson_drv.c
> > > > > > > > index d344312..2e29968 100644
> > > > > > > > --- a/drivers/gpu/drm/meson/meson_drv.c
> > > > > > > > +++ b/drivers/gpu/drm/meson/meson_drv.c
> > > > > > > > @@ -243,8 +243,8 @@ static int
> > > > > > > > meson_drv_bind_master(struct device *dev, bool
> > > > > > > > has_components)
> > > > > > > >              goto free_drm;
> > > > > > > > 
> > > > > > > >      drm_mode_config_init(drm);
> > > > > > > > -    drm->mode_config.max_width = 3840;
> > > > > > > > -    drm->mode_config.max_height = 2160;
> > > > > > > > +    drm->mode_config.max_width = 16384;
> > > > > > > > +    drm->mode_config.max_height = 8192;
> > > > > > > >      drm->mode_config.funcs = &meson_mode_config_funcs;
> > > > > > > > 
> > > > > > > >      /* Hardware Initialization */
> > > > > > > > --
> > > > > > > > 2.7.4
> > > > > > > > 
> > > > > > > > _______________________________________________
> > > > > > > > dri-devel mailing list
> > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > > > 
> > > > > > 
> > > > > > _______________________________________________
> > > > > > dri-devel mailing list
> > > > > > dri-devel@lists.freedesktop.org
> > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > > 
> > > > > 
> > > > > 
> > > > 
> > > 
> > > 
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Jeykumar S

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

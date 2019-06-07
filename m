Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE3AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07175212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K6LwWAr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfFGPE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:04:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42777 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfFGPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:04:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so3454549edq.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTTkzXVn2E3fC3MRVPFzUyBEH8NuiFonw8OSIpNN83o=;
        b=K6LwWAr3cBnLh8mgXszP0ZbNMqER1JdG3JVKgSa3mmL9k5wTGLDO77Zu/Fmsd73Cw8
         igjROZMjkxeeLDyv5NhmspKxKqP52jw+Cr3poPNbG1uIIriAeQgovw/mYt3pIHYVo4li
         lZAWPrCi1SkKn2rS+Bf1BfHU7pRVUk/5TtVDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tTTkzXVn2E3fC3MRVPFzUyBEH8NuiFonw8OSIpNN83o=;
        b=VfB/35i86BW24MK0wO2xzzEIZNg8UgkayJuGP803bRgaZlRE6WkPZUeqy9IjN7QPRr
         flYdqmS4EeOBOLPgylAA0wVb8yTWRidiVxKuIVYmQO3yyUorDBiQW0pXWuHidQ2xRxlr
         M4mC4C7gnhQRdFnxoXffzhm/M/ss5BqFg0p6L3KIp8P7j8D1esmZCk512J6TyRec/DGr
         pZ0YkbPQurY85JiO1PYHxuxT5o8sUCsfhxhdw5COEhW3HjhBSOceYWsErEFecV2PLIbr
         VwKCCE80FuLkecRsvgmBM3DbG6UluSeonJCTsQ2MWHRafzcrIQHCt2xLI8bhF2BEX+wM
         fVpw==
X-Gm-Message-State: APjAAAVqRp/SWgn7WyyDldKW8lgbjOyTkwZyInOe9cKjEvTvCsxytVb/
        /0tXimw9vmkGGjcroZe27Ukq7Q==
X-Google-Smtp-Source: APXvYqxltyNdua/vTPG0cZQn6vEiV/hWI8pxFFiAkEMuiv2YITwt0fCBGoHz53bNGsQxlV08sJhnoA==
X-Received: by 2002:a17:906:7047:: with SMTP id r7mr47036191ejj.11.1559919865332;
        Fri, 07 Jun 2019 08:04:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a22sm420324ejj.3.2019.06.07.08.04.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 08:04:22 -0700 (PDT)
Date:   Fri, 7 Jun 2019 17:04:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <20190607150420.GI21222@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <20190607073957.GB21222@phenom.ffwll.local>
 <CADKXj+7OLRLrGo+YbxZjR7f90WNPPjT_rkcyt3GrxomCAjOjHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADKXj+7OLRLrGo+YbxZjR7f90WNPPjT_rkcyt3GrxomCAjOjHA@mail.gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:37:55AM -0300, Rodrigo Siqueira wrote:
> On Fri, Jun 7, 2019 at 4:40 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Jun 06, 2019 at 07:40:38PM -0300, Rodrigo Siqueira wrote:
> > > When vkms calls drm_universal_plane_init(), it sets 0 for the
> > > possible_crtcs parameter which works well for a single encoder and
> > > connector; however, this approach is not flexible and does not fit well
> > > for vkms. This commit adds an index parameter for vkms_plane_init()
> > > which makes code flexible and enables vkms to support other DRM features.
> > >
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> >
> > I think a core patch to WARN_ON if this is NULL would be good. Since
> > that's indeed a bit broken ... We'd need to check all callers to make sure
> > there's not other such bugs anywhere ofc.
> > -Daniel
> 
> Do you mean add WARN_ON in `drm_universal_plane_init()` if
> `possible_crtcs` is equal to zero?

Yeah, and same for endcoders I guess too. Altough with encoders I think
there's a ton of broken drivers.
-Daniel

> 
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
> > >  drivers/gpu/drm/vkms/vkms_drv.h    | 4 ++--
> > >  drivers/gpu/drm/vkms/vkms_output.c | 6 +++---
> > >  drivers/gpu/drm/vkms/vkms_plane.c  | 4 ++--
> > >  4 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > index 738dd6206d85..92296bd8f623 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > @@ -92,7 +92,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
> > >       dev->mode_config.max_height = YRES_MAX;
> > >       dev->mode_config.preferred_depth = 24;
> > >
> > > -     return vkms_output_init(vkmsdev);
> > > +     return vkms_output_init(vkmsdev, 0);
> > >  }
> > >
> > >  static int __init vkms_init(void)
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > > index 81f1cfbeb936..e81073dea154 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > > @@ -113,10 +113,10 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
> > >                              int *max_error, ktime_t *vblank_time,
> > >                              bool in_vblank_irq);
> > >
> > > -int vkms_output_init(struct vkms_device *vkmsdev);
> > > +int vkms_output_init(struct vkms_device *vkmsdev, int index);
> > >
> > >  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > > -                               enum drm_plane_type type);
> > > +                               enum drm_plane_type type, int index);
> > >
> > >  /* Gem stuff */
> > >  struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
> > > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > > index 3b162b25312e..1442b447c707 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > > @@ -36,7 +36,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
> > >       .get_modes    = vkms_conn_get_modes,
> > >  };
> > >
> > > -int vkms_output_init(struct vkms_device *vkmsdev)
> > > +int vkms_output_init(struct vkms_device *vkmsdev, int index)
> > >  {
> > >       struct vkms_output *output = &vkmsdev->output;
> > >       struct drm_device *dev = &vkmsdev->drm;
> > > @@ -46,12 +46,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> > >       struct drm_plane *primary, *cursor = NULL;
> > >       int ret;
> > >
> > > -     primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
> > > +     primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
> > >       if (IS_ERR(primary))
> > >               return PTR_ERR(primary);
> > >
> > >       if (enable_cursor) {
> > > -             cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
> > > +             cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
> > >               if (IS_ERR(cursor)) {
> > >                       ret = PTR_ERR(cursor);
> > >                       goto err_cursor;
> > > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > > index 0e67d2d42f0c..20ffc52f9194 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > > @@ -168,7 +168,7 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
> > >  };
> > >
> > >  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > > -                               enum drm_plane_type type)
> > > +                               enum drm_plane_type type, int index)
> > >  {
> > >       struct drm_device *dev = &vkmsdev->drm;
> > >       const struct drm_plane_helper_funcs *funcs;
> > > @@ -190,7 +190,7 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > >               funcs = &vkms_primary_helper_funcs;
> > >       }
> > >
> > > -     ret = drm_universal_plane_init(dev, plane, 0,
> > > +     ret = drm_universal_plane_init(dev, plane, 1 << index,
> > >                                      &vkms_plane_funcs,
> > >                                      formats, nformats,
> > >                                      NULL, type, NULL);
> > > --
> > > 2.21.0
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> 
> 
> -- 
> 
> Rodrigo Siqueira
> https://siqueira.tech

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

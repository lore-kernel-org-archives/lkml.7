Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C516DC31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D3C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC5u6Q0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfFRCTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:19:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34258 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfFRCTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:19:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so19211267edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QD9TzfSk0JxUEEnkfjtnbmT8A1d0YtzVMTHhyK2HJm0=;
        b=tC5u6Q0mhLyyst1CDhVTdCDFB2MNY131EdQ7BgXH8sLJjNRGFbvEayCQFs4YAmBoAF
         4RVAj0NLOk1rWLoj/bV57072C1IV2xLb7UwAfggf8T6IVVbhIT+H/LLHfTeqylk8JMrN
         g0CefZPyVMGqpZ93HQ7n/GGQHAOUWaXD3234u1GtCAcu2dSoXCajy9XwmKshCwHjvTJA
         0yhRFGYwvz9W8F+1QoqyIvVAJx/TFSTIrL+eTmAp3WOQKUoHHEV7bE97MCZKSQLacLTQ
         ZeYl1d5Nfxn/Tppe2R/H5ms5LMDwhi8a+3QJr1pztZUmW+utejHU21GwXQHn2R8Ba8z0
         5coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QD9TzfSk0JxUEEnkfjtnbmT8A1d0YtzVMTHhyK2HJm0=;
        b=OeBsZLi3AqclU3QWN2AYvqTExq+CO7AE6DvF9bHICZJkHFVwCoOwJQdhR5wahEn553
         T138vHenKZyx7YHCWAWDOqnCsa9eTPY0ktQUc2jtA0hQVJ/KBLV8HD+oVsAQoELk/UZ1
         cpQ0X/LUBqJ/eLbkvCL5siZjusrbBfoOvGKVZV2zrl7gHzRbj8VFt4iSX+/GJ9RDFDBG
         kDeln0Rs5YndpR3HpVOa5nWZGl1S+9xVgEMWXuarc6E6O77hduEgbrKa6GvLjI4g1M0v
         QpVm3b0IoYmEeWfdq28/m8Lwoh5hso+8OVlm1q3LRjo+LBnfNwlMa+/y/1nHwXitO3lI
         XdKw==
X-Gm-Message-State: APjAAAWnS9hTCJxMgVP0u2XkbxVhzPR9Llf8eyDxnOZlBkcFDIiobfMP
        nSSwPLd6WpoNSNQY/U50YO0=
X-Google-Smtp-Source: APXvYqyLpZQecX8wK0CGSokYGHmPZ4tG9sI0eWmqdIHtMKMnm4LXY8YmN/hkAkSKy4K4EI9lX2E6EA==
X-Received: by 2002:a50:ec03:: with SMTP id g3mr60688108edr.233.1560824390604;
        Mon, 17 Jun 2019 19:19:50 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id v32sm4271673edm.92.2019.06.17.19.19.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:19:50 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:19:44 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <20190618021944.7ilhgaswme2a6amt@smtp.gmail.com>
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <20190607073957.GB21222@phenom.ffwll.local>
 <CADKXj+7OLRLrGo+YbxZjR7f90WNPPjT_rkcyt3GrxomCAjOjHA@mail.gmail.com>
 <20190607150420.GI21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607150420.GI21222@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07, Daniel Vetter wrote:
> On Fri, Jun 07, 2019 at 11:37:55AM -0300, Rodrigo Siqueira wrote:
> > On Fri, Jun 7, 2019 at 4:40 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Thu, Jun 06, 2019 at 07:40:38PM -0300, Rodrigo Siqueira wrote:
> > > > When vkms calls drm_universal_plane_init(), it sets 0 for the
> > > > possible_crtcs parameter which works well for a single encoder and
> > > > connector; however, this approach is not flexible and does not fit well
> > > > for vkms. This commit adds an index parameter for vkms_plane_init()
> > > > which makes code flexible and enables vkms to support other DRM features.
> > > >
> > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > >
> > > I think a core patch to WARN_ON if this is NULL would be good. Since
> > > that's indeed a bit broken ... We'd need to check all callers to make sure
> > > there's not other such bugs anywhere ofc.
> > > -Daniel
> > 
> > Do you mean add WARN_ON in `drm_universal_plane_init()` if
> > `possible_crtcs` is equal to zero?
> 
> Yeah, and same for endcoders I guess too. Altough with encoders I think
> there's a ton of broken drivers.

I made the patch, but when I started to write the commit message, I just
realized that I did not understand why possible_crtcs should not be
equal zero. Why can we not use zero?

> -Daniel
> 
> > 
> > > > ---
> > > >  drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
> > > >  drivers/gpu/drm/vkms/vkms_drv.h    | 4 ++--
> > > >  drivers/gpu/drm/vkms/vkms_output.c | 6 +++---
> > > >  drivers/gpu/drm/vkms/vkms_plane.c  | 4 ++--
> > > >  4 files changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > index 738dd6206d85..92296bd8f623 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > > @@ -92,7 +92,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
> > > >       dev->mode_config.max_height = YRES_MAX;
> > > >       dev->mode_config.preferred_depth = 24;
> > > >
> > > > -     return vkms_output_init(vkmsdev);
> > > > +     return vkms_output_init(vkmsdev, 0);
> > > >  }
> > > >
> > > >  static int __init vkms_init(void)
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > > > index 81f1cfbeb936..e81073dea154 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > > > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > > > @@ -113,10 +113,10 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
> > > >                              int *max_error, ktime_t *vblank_time,
> > > >                              bool in_vblank_irq);
> > > >
> > > > -int vkms_output_init(struct vkms_device *vkmsdev);
> > > > +int vkms_output_init(struct vkms_device *vkmsdev, int index);
> > > >
> > > >  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > > > -                               enum drm_plane_type type);
> > > > +                               enum drm_plane_type type, int index);
> > > >
> > > >  /* Gem stuff */
> > > >  struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > > > index 3b162b25312e..1442b447c707 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > > > @@ -36,7 +36,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
> > > >       .get_modes    = vkms_conn_get_modes,
> > > >  };
> > > >
> > > > -int vkms_output_init(struct vkms_device *vkmsdev)
> > > > +int vkms_output_init(struct vkms_device *vkmsdev, int index)
> > > >  {
> > > >       struct vkms_output *output = &vkmsdev->output;
> > > >       struct drm_device *dev = &vkmsdev->drm;
> > > > @@ -46,12 +46,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> > > >       struct drm_plane *primary, *cursor = NULL;
> > > >       int ret;
> > > >
> > > > -     primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
> > > > +     primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
> > > >       if (IS_ERR(primary))
> > > >               return PTR_ERR(primary);
> > > >
> > > >       if (enable_cursor) {
> > > > -             cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
> > > > +             cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
> > > >               if (IS_ERR(cursor)) {
> > > >                       ret = PTR_ERR(cursor);
> > > >                       goto err_cursor;
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > index 0e67d2d42f0c..20ffc52f9194 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > > > @@ -168,7 +168,7 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
> > > >  };
> > > >
> > > >  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > > > -                               enum drm_plane_type type)
> > > > +                               enum drm_plane_type type, int index)
> > > >  {
> > > >       struct drm_device *dev = &vkmsdev->drm;
> > > >       const struct drm_plane_helper_funcs *funcs;
> > > > @@ -190,7 +190,7 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > > >               funcs = &vkms_primary_helper_funcs;
> > > >       }
> > > >
> > > > -     ret = drm_universal_plane_init(dev, plane, 0,
> > > > +     ret = drm_universal_plane_init(dev, plane, 1 << index,
> > > >                                      &vkms_plane_funcs,
> > > >                                      formats, nformats,
> > > >                                      NULL, type, NULL);
> > > > --
> > > > 2.21.0
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > 
> > 
> > 
> > -- 
> > 
> > Rodrigo Siqueira
> > https://siqueira.tech
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Rodrigo Siqueira
https://siqueira.tech

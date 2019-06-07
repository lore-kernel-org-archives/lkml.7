Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A1C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D822083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFCzRvA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfFGOiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:38:08 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43503 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfFGOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:38:08 -0400
Received: by mail-vk1-f196.google.com with SMTP id m193so415370vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKjcG7F74rIiLByNRNXlvSG6M2lGgmcbBTtJHkAJ5zo=;
        b=NFCzRvA7xNGXFJIiBAGsFIew1vbH/17AMDoG4G0Z0LDcyOjXCE4LF0R8qHY3CvI1H6
         NVZSIY6YpynXHyOycMicg5UGDAT4WIt+k74SkUmCmiCbUh9X5EUBtvUEekb8zmN57KfT
         eYGkIZ6KMvS7vS3yyKkJ/CvCdx6BmOcoy2CPYJBfJKbnpiLRiPFY0vCbh2ahi272nknF
         Bt83j4br8JxQRV9f7VP3knUKXEeh75MfPrmswl3y+AxqCj4KQrNr0hyP0wuDego20FBr
         K/lKhiOHvWMNR3mvUgkdEotSgJH/z5h6SyHdydQSEJWFtAYx/jYYLLq6gYKK6wOcUwak
         ccsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKjcG7F74rIiLByNRNXlvSG6M2lGgmcbBTtJHkAJ5zo=;
        b=CZFq7c2HjKFrYHA8q8qp3m0skXV3FRXbId3VXQdtD/2wAqaJqshB90LH4/j8nArgSM
         u0ytWmqXfVOFRpnw7jO1eJeEUxzSwHc3Ygd4s2pnIej3TJiYwADplBA0E2xXZCluM85D
         oU3EMpR6iKikqti51769XQalI08A5WGMxhluw2f6hwlFzaxrNNJinTn18sDscDvbKdml
         UZFDskQJQJm0jxDl/3lQuUWZBVSGhZH13xwTJWdfwhephNwGloNW8ugbDUU9YZpr+SbA
         Aucy5PN+gC4PbwXWZNREFcHOZqepBb7Db2ap+1h/KpSbacaxdbzjm88Jb2Jypzhrkk9D
         anIQ==
X-Gm-Message-State: APjAAAUF0eVzZrjuXfDVN5vGAsjLfVSBWfK4CHmGbXPfEK8hS53LHeQQ
        CB8abOc743vT5Gv+CJLU/T00vuPixYtAs7sa5Sg=
X-Google-Smtp-Source: APXvYqwOY2ArH7hx4LrnjaOK2c33/ATMBEzkouFb1iNTFL0VBn2w9Q4reHBa7XBt8fTGdXwDLzjzr0fCY6PsxovHzp4=
X-Received: by 2002:a1f:12d5:: with SMTP id 204mr8721141vks.4.1559918286637;
 Fri, 07 Jun 2019 07:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <e3bc263b273d91182e0577ed820b1c4f096834ec.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <20190607073957.GB21222@phenom.ffwll.local>
In-Reply-To: <20190607073957.GB21222@phenom.ffwll.local>
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Date:   Fri, 7 Jun 2019 11:37:55 -0300
Message-ID: <CADKXj+7OLRLrGo+YbxZjR7f90WNPPjT_rkcyt3GrxomCAjOjHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vkms: Use index instead of 0 in possible crtc
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 4:40 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Jun 06, 2019 at 07:40:38PM -0300, Rodrigo Siqueira wrote:
> > When vkms calls drm_universal_plane_init(), it sets 0 for the
> > possible_crtcs parameter which works well for a single encoder and
> > connector; however, this approach is not flexible and does not fit well
> > for vkms. This commit adds an index parameter for vkms_plane_init()
> > which makes code flexible and enables vkms to support other DRM features.
> >
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>
> I think a core patch to WARN_ON if this is NULL would be good. Since
> that's indeed a bit broken ... We'd need to check all callers to make sure
> there's not other such bugs anywhere ofc.
> -Daniel

Do you mean add WARN_ON in `drm_universal_plane_init()` if
`possible_crtcs` is equal to zero?

> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.c    | 2 +-
> >  drivers/gpu/drm/vkms/vkms_drv.h    | 4 ++--
> >  drivers/gpu/drm/vkms/vkms_output.c | 6 +++---
> >  drivers/gpu/drm/vkms/vkms_plane.c  | 4 ++--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > index 738dd6206d85..92296bd8f623 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -92,7 +92,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
> >       dev->mode_config.max_height = YRES_MAX;
> >       dev->mode_config.preferred_depth = 24;
> >
> > -     return vkms_output_init(vkmsdev);
> > +     return vkms_output_init(vkmsdev, 0);
> >  }
> >
> >  static int __init vkms_init(void)
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 81f1cfbeb936..e81073dea154 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -113,10 +113,10 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
> >                              int *max_error, ktime_t *vblank_time,
> >                              bool in_vblank_irq);
> >
> > -int vkms_output_init(struct vkms_device *vkmsdev);
> > +int vkms_output_init(struct vkms_device *vkmsdev, int index);
> >
> >  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > -                               enum drm_plane_type type);
> > +                               enum drm_plane_type type, int index);
> >
> >  /* Gem stuff */
> >  struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > index 3b162b25312e..1442b447c707 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -36,7 +36,7 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
> >       .get_modes    = vkms_conn_get_modes,
> >  };
> >
> > -int vkms_output_init(struct vkms_device *vkmsdev)
> > +int vkms_output_init(struct vkms_device *vkmsdev, int index)
> >  {
> >       struct vkms_output *output = &vkmsdev->output;
> >       struct drm_device *dev = &vkmsdev->drm;
> > @@ -46,12 +46,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> >       struct drm_plane *primary, *cursor = NULL;
> >       int ret;
> >
> > -     primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY);
> > +     primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
> >       if (IS_ERR(primary))
> >               return PTR_ERR(primary);
> >
> >       if (enable_cursor) {
> > -             cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR);
> > +             cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
> >               if (IS_ERR(cursor)) {
> >                       ret = PTR_ERR(cursor);
> >                       goto err_cursor;
> > diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> > index 0e67d2d42f0c..20ffc52f9194 100644
> > --- a/drivers/gpu/drm/vkms/vkms_plane.c
> > +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> > @@ -168,7 +168,7 @@ static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
> >  };
> >
> >  struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> > -                               enum drm_plane_type type)
> > +                               enum drm_plane_type type, int index)
> >  {
> >       struct drm_device *dev = &vkmsdev->drm;
> >       const struct drm_plane_helper_funcs *funcs;
> > @@ -190,7 +190,7 @@ struct drm_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> >               funcs = &vkms_primary_helper_funcs;
> >       }
> >
> > -     ret = drm_universal_plane_init(dev, plane, 0,
> > +     ret = drm_universal_plane_init(dev, plane, 1 << index,
> >                                      &vkms_plane_funcs,
> >                                      formats, nformats,
> >                                      NULL, type, NULL);
> > --
> > 2.21.0
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 

Rodrigo Siqueira
https://siqueira.tech

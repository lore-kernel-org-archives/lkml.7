Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE09C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E920820693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Uny0fv/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfDPJzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:55:47 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37074 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDPJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:55:47 -0400
Received: by mail-it1-f196.google.com with SMTP id u65so31514745itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOtP5rawsQYgjNr6H2qko1pVDJ0mjmSiF4+tgBqb16w=;
        b=Uny0fv/6WPKKGiJk6Km8CMbjOSj1Z2V3F+1gJGOJNlB9pcjCgwkG3mwx2EXwGF2IkP
         rj0p9zL4sUIqBfZHUyvkDDxOSgK6yOm9xBdK1q3uz6QBgQBa64LsVfdeFNrYUU8ogkRf
         UJFOxlEEWSH8ud+TejPHwMolHddo5x9SOdASQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOtP5rawsQYgjNr6H2qko1pVDJ0mjmSiF4+tgBqb16w=;
        b=mJi6M6c24RzKzB6meiybcTAXThGW7sNO8oH9clam4HHbzWwawrsUVCcGivKk9G02kh
         +6angK3hXemV/vcQakdgqa5jJXclv449Ce93AlPzK+IufrAlIq0IYzHyeRPX/98bFQvi
         5XkITcmb8klCBPvWeRFFnPOF3gc2wJsdHBDBmNk5SC7Eeul+seD+D4FJQGLK8CjebFgO
         fOXHpPjaSKI5/h/lYojaKX1ih8K7fM+YK3gRCRlqYUJv+AXO2C7yeaCrVOOcrp623Ogt
         41WqM6+gPyRJwEmeYOjMiStGNTKTdn4lKDP2mct2F3vd9KYJHvCWjTGAoKJR+UL2OS/c
         DuEA==
X-Gm-Message-State: APjAAAVjl9DExP9yJttEWoVbPkPkTalt/+emZnf9kvBOsvGrPfRq9zRB
        zITnpIBxDvB0ERKq+cFtBwPThdAnnONlB1HPWwNBuA==
X-Google-Smtp-Source: APXvYqyo2BmNtZ4yuEmQOste39uiFGrxnUHxnDijmxS0QMupghzMUss9SiJX+qJcP1dY8KtzJBgZ2u5OVrr3TGXL6vQ=
X-Received: by 2002:a24:6495:: with SMTP id t143mr27935127itc.156.1555408546064;
 Tue, 16 Apr 2019 02:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <1555078094-6587-2-git-send-email-ben.davis@arm.com>
 <20190415075922.GA24596@james-ThinkStation-P300> <20190415092045.GO15144@e110455-lin.cambridge.arm.com>
 <20190416073419.GN2665@phenom.ffwll.local> <20190416091658.GP15144@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190416091658.GP15144@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 16 Apr 2019 11:55:34 +0200
Message-ID: <CAKMK7uEZge0=WOWB7MTJUtXUg-q1YEgTxRAY6krtsEmGWEbY0w@mail.gmail.com>
Subject: Re: [v2,1/2] drm: Add writeback_w,h properties
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>,
        Ben Davis <Ben.Davis@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:17 AM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> On Tue, Apr 16, 2019 at 09:34:20AM +0200, Daniel Vetter wrote:
> > On Mon, Apr 15, 2019 at 10:20:45AM +0100, Liviu Dudau wrote:
> > > On Mon, Apr 15, 2019 at 08:59:30AM +0100, james qian wang (Arm Techno=
logy China) wrote:
> > > > On Fri, Apr 12, 2019 at 02:08:28PM +0000, Ben Davis wrote:
> > > > > Add new properties to specify width and height for writeback.
> > > > >
> > > > > Signed-off-by: Ben Davis <ben.davis@arm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++++++
> > > > >  drivers/gpu/drm/drm_writeback.c   | 28 +++++++++++++++++++++++++=
+++
> > > > >  include/drm/drm_connector.h       |  4 ++++
> > > > >  include/drm/drm_mode_config.h     | 10 ++++++++++
> > > > >  4 files changed, 50 insertions(+)
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/=
drm_atomic_uapi.c
> > > > > index d520a04..1f68dce 100644
> > > > > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > > > > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > > > > @@ -765,6 +765,10 @@ static int drm_atomic_connector_set_property=
(struct drm_connector *connector,
> > > > >                         return -EINVAL;
> > > > >                 }
> > > > >                 state->content_protection =3D val;
> > > > > +       } else if (property =3D=3D config->prop_writeback_w) {
> > > > > +               state->writeback_w =3D val;
> > > > > +       } else if (property =3D=3D config->prop_writeback_h) {
> > > > > +               state->writeback_h =3D val;
> > > > >         } else if (property =3D=3D config->writeback_fb_id_proper=
ty) {
> > > > >                 struct drm_framebuffer *fb =3D drm_framebuffer_lo=
okup(dev, NULL, val);
> > > > >                 int ret =3D drm_atomic_set_writeback_fb_for_conne=
ctor(state, fb);
> > > > > @@ -837,6 +841,10 @@ drm_atomic_connector_get_property(struct drm=
_connector *connector,
> > > > >                 *val =3D state->scaling_mode;
> > > > >         } else if (property =3D=3D connector->content_protection_=
property) {
> > > > >                 *val =3D state->content_protection;
> > > > > +       } else if (property =3D=3D config->prop_writeback_w) {
> > > > > +               *val =3D state->writeback_w;
> > > > > +       } else if (property =3D=3D config->prop_writeback_h) {
> > > > > +               *val =3D state->writeback_h;
> > > > >         } else if (property =3D=3D config->writeback_fb_id_proper=
ty) {
> > > > >                 /* Writeback framebuffer is one-shot, write and f=
orget */
> > > > >                 *val =3D 0;
> > > > > diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/dr=
m_writeback.c
> > > > > index c20e6fe..3d0453e 100644
> > > > > --- a/drivers/gpu/drm/drm_writeback.c
> > > > > +++ b/drivers/gpu/drm/drm_writeback.c
> > > > > @@ -74,6 +74,12 @@
> > > > >   *     applications making use of writeback connectors *always* =
retrieve an
> > > > >   *     out-fence for the commit and use it appropriately.
> > > > >   *     From userspace, this property will always read as zero.
> > > > > + *
> > > > > + *  "WRITEBACK_W":
> > > > > + *     The width of the writeback buffer to write back. 0 acts a=
s default.
> > > > > + *
> > > > > + *  "WRITEBACK_H":
> > > > > + *     The height of the writeback buffer to write back. 0 acts =
as default.
> > > > >   */
> > > > >
> > > > >  #define fence_to_wb_connector(x) container_of(x->lock, \
> > > > > @@ -141,6 +147,22 @@ static int create_writeback_properties(struc=
t drm_device *dev)
> > > > >                 dev->mode_config.writeback_out_fence_ptr_property=
 =3D prop;
> > > > >         }
> > > > >
> > > > > +       if (!dev->mode_config.prop_writeback_w) {
> > > > > +               prop =3D drm_property_create_range(dev, DRM_MODE_=
PROP_ATOMIC,
> > > > > +                                                "WRITEBACK_W", 1=
, UINT_MAX);
> > > > > +               if (!prop)
> > > > > +                       return -ENOMEM;
> > > > > +               dev->mode_config.prop_writeback_w =3D prop;
> > > > > +       }
> > > > > +
> > > > > +       if (!dev->mode_config.prop_writeback_h) {
> > > > > +               prop =3D drm_property_create_range(dev, DRM_MODE_=
PROP_ATOMIC,
> > > > > +                                                "WRITEBACK_H", 1=
, UINT_MAX);
> > > > > +               if (!prop)
> > > > > +                       return -ENOMEM;
> > > > > +               dev->mode_config.prop_writeback_h =3D prop;
> > > > > +       }
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > @@ -225,6 +247,12 @@ int drm_writeback_connector_init(struct drm_=
device *dev,
> > > > >         drm_object_attach_property(&connector->base,
> > > > >                                    config->writeback_pixel_format=
s_property,
> > > > >                                    blob->base.id);
> > > > > +
> > > > > +       drm_object_attach_property(&connector->base,
> > > > > +                                  config->prop_writeback_w, 0);
> > > > > +       drm_object_attach_property(&connector->base,
> > > > > +                                  config->prop_writeback_h, 0);
> > > >
> > > > Hi Ben:
> > > > Do we real need these two individual properties for specifing the w=
riteback
> > > > w/h, can we use fb->w/h ?
> > > > And since these two properties are added as common and standard pro=
perties,
> > > > it influnce all existing write-back implementation which all assume=
d
> > > > writeback size as fb->w/h.
> > >
> > > The idea of having these additional properties was to maintain backwa=
rds
> > > compatibility (of some sort). If you don't set writeback_w/h then the
> > > assumption is that they are the same as fb->w/h, but I can see how it=
's
> > > going to be confusing to have fb->w/h different from crtc->w/h and
> > > different from writeback_w/h.
> >
> > Since we already have crtc_w/h independent of writeback_fb_w/h, do we n=
eed
> > another set of w/h? Are all the interactions between these tree
> > well-defined?
>
> No, we probably don't need another set of w/h values. As for the
> interaction, I propose the following:
>
> - writeback is only attached to a connector, so the crtc_x/y/w/h are the
>   "input source" parameters into the writeback. Given that we put in the
>   writeback the content of the CRTC, I suggest we ignore x,y (consider
>   them to be always 0 for the writeback output).

There's no crtc_x/y. And what I meant with crtc_w/h is
crtc_state->mode->h/vdisplay. And you can already express scaling with
that, by setting the plane_state->crtc_x/y/h/w parameters as you wish.

> - writeback has a framebuffer attached, so we can use the fb->w/h to
>   determine if we need to do any scaling of the output.

Hm, not sure we want that. You might want to automatically round
fb->w/h to whatever (ok right now we don't do that I think anywhere),
so forcing the output to match the fb->h/w doesn't make sense for me.
It's also inconsistent with how we treat fb attached to planes (where
we have the full set of src coordinates).

> > Atm I'm assuming that writeback is using crtc_w/h into the fb, at offse=
t
> > 0, not scaled any further. But the planes themselves can be scaled into
> > the crtc_w/h window ofc.
>
> Our hardware has the ability to also write back one of the planes and
> scale it during writeback, but we have no way of expressing that in DRM
> via connectors, so we are going to ignore that case. The supported usecas=
e
> is for the planes to be scaled into the "composition" area which is the s=
ize
> of the CRTC, and then writeback that to memory, possibly with scaling (we
> officially only going to support downscaling due to external dependencies
> on the memory clock that is needed for supporting upscaling).

Hm, see above, you can already express that:
- set crtc_state->mode->h/vdisplay to what you want the resulting
writeback image to be sized at.
- place the plane however you want using the plane properties within
that crtc window.

Cheers, Daniel

>
> Liviu
>
>
> >
> > Iirc the hw supporting writeback thus far needs a dedicated crtc for
> > writeback, so adding yet another scaling window is not needed?
> > -Daniel
> >
> > > > To compatible with existing writeback support, I suggest to keep to
> > > > use fb->w/h or add these properties as malidp private.
> > >
> > > We don't need to make them malidp private, there is nothing malidp
> > > specific in them. I'll talk with Ben, we should probably drop this pa=
tch
> > > entirely and just enable malidp scaling when fb->w/h differ from
> > > crtc->w/h.
> > >
> > > Best regards,
> > > Liviu
> > >
> > >
> > > >
> > > > Thanks
> > > > James
> > > >
> > > >
> > > > >         wb_connector->pixel_formats_blob_ptr =3D blob;
> > > > >
> > > > >         return 0;
> > > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connec=
tor.h
> > > > > index 8fe22ab..51c4cb2 100644
> > > > > --- a/include/drm/drm_connector.h
> > > > > +++ b/include/drm/drm_connector.h
> > > > > @@ -515,6 +515,10 @@ struct drm_connector_state {
> > > > >          */
> > > > >         struct drm_writeback_job *writeback_job;
> > > > >
> > > > > +       /** @writeback_w: width of plane to write to wb buffer */
> > > > > +       /** @writeback_h: height of plane to write to wb buffer *=
/
> > > > > +       uint32_t writeback_w, writeback_h;
> > > > > +
> > > > >         /**
> > > > >          * @max_requested_bpc: Connector property to limit the ma=
ximum bit
> > > > >          * depth of the pixels.
> > > > > diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode=
_config.h
> > > > > index 7f60e8e..a0c2133 100644
> > > > > --- a/include/drm/drm_mode_config.h
> > > > > +++ b/include/drm/drm_mode_config.h
> > > > > @@ -622,6 +622,16 @@ struct drm_mode_config {
> > > > >          */
> > > > >         struct drm_property *prop_crtc_h;
> > > > >         /**
> > > > > +        * @prop_writeback_w: Writeback connector property for th=
e plane
> > > > > +        * destination position in the writeback buffer.
> > > > > +        */
> > > > > +       struct drm_property *prop_writeback_w;
> > > > > +       /**
> > > > > +        * @prop_writeback_h: Writeback connector property for th=
e plane
> > > > > +        * destination position in the writeback buffer.
> > > > > +        */
> > > > > +       struct drm_property *prop_writeback_h;
> > > > > +       /**
> > > > >          * @prop_fb_id: Default atomic plane property to specify =
the
> > > > >          * &drm_framebuffer.
> > > > >          */
> > > >
> > > > Pls del this window style line ending
> > > >
> > >
> > > --
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > | I would like to |
> > > | fix the world,  |
> > > | but they're not |
> > > | giving me the   |
> > >  \ source code!  /
> > >   ---------------
> > >     =C2=AF\_(=E3=83=84)_/=C2=AF
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

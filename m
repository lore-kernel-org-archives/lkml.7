Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8779AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4620B2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0pGwNxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfFRWK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:10:27 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39580 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:10:26 -0400
Received: by mail-ua1-f65.google.com with SMTP id j8so7682226uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JOxAk+z+pSo05o3ILvgyuqhb6qQtI6SCgUWBMEpVZio=;
        b=U0pGwNxg+KbdILSBlq2xQUmRsFjU2LnHbiTRcB/YLsBZ8uOsB0zV5+zKR/LH3KWJLR
         Tt+WzeKLz3iTnCvbRH/QHrvFg/JI4LZvBc1WvgIOR8IY6PBiRTDKcAbdS58Ns251a+Lt
         IrmTKf5zkgQFu70dJ5z30686n4j6dPvRUroj9Mj+H218Y9j42E2CyNT2HB0FVZJyFvOq
         usKjLWdY7BcxZQ6sUad5Zs3+/g1ZT1LnLkkJcLZTxqUR/XHOvBE9g7ObBovnDV6/cs85
         S7LNP7Ngl6fZZ4NtJ2aDBs9cdKNF2B5NpgT2WtpuA+jsLKnWk6VhHO4u0WtP4orlyvy3
         /qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JOxAk+z+pSo05o3ILvgyuqhb6qQtI6SCgUWBMEpVZio=;
        b=kq/WLF7+H7PUYIN73LjuIccnRlQOhanuPuoEn/RE6JCm2rhDczEMmHXCMooJRvtKte
         2H8Sj33OfXXj/HgAbeQlqmcI3hYSjftOBtcvGOmqHgNZt4b63KCtzIJ8XFisZ/ZfoY/0
         1CV2amZzhi8A/MMTDLl2dSW+vhewGwaq8pe8+WtYpgYti+V+WjJ0BmPBeUIq2BkV4YIL
         EKA6/fXsgZvS76/Wb7rCASbzGHYGkHYVEdRuHHsThRJ3pR9bBt3lLnesB9EaRMhIPAAH
         51E2JHdom9qnLL0LmyT7vp5ox8+p9vj8biayM8u/etjMBQoyfirPPOOz6NUvnuV/13rz
         rbrw==
X-Gm-Message-State: APjAAAVQxvmjWG3/UsqUMX1k32qMX8hTZri1k9MCljhdgsbibQcFBO6w
        V2mgxdChOlhAny/uwsmQYpgwk8ds00K8wVGmO7I=
X-Google-Smtp-Source: APXvYqzH5eZ4P28bohxS3LyU2sUexAkQT2syBl355wSi/rtx0KsC9L34n6fH8hTzkFgDiprrDvyiQBjJ0AaS5oq63kc=
X-Received: by 2002:a9f:21d6:: with SMTP id 80mr33627112uac.60.1560895825096;
 Tue, 18 Jun 2019 15:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
 <4787369d4927fa709da050e7481e48102842fd97.1560820888.git.rodrigosiqueiramelo@gmail.com>
 <20190618093356.GR12905@phenom.ffwll.local>
In-Reply-To: <20190618093356.GR12905@phenom.ffwll.local>
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Date:   Tue, 18 Jun 2019 19:10:14 -0300
Message-ID: <CADKXj+4W8W-2UE0=r4p_dY9uwO_Suusigszq7B_U-rbU=tMHMg@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] drm/vkms: Add support for writeback
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 6:34 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Jun 17, 2019 at 11:45:55PM -0300, Rodrigo Siqueira wrote:
> > This patch implements the necessary functions to add writeback support
> > for vkms. This feature is useful for testing compositors if you don't
> > have hardware with writeback support.
> >
> > Change in V2:
> > - Rework signal completion (Brian)
> > - Integrates writeback with active_planes (Daniel)
> > - Compose cursor (Daniel)
>
> Not quite what I had in mind ... my idea was to reuse the crc worker
> (hence renaming all that stuff to vkms_composer). The problem here is tha=
t
> now we have the blend/compose code duplicated, at least parts of it. Plus
> if you enable both crc and writeback, then we compose 2x, which is a bit
> too much.
>
> Rough sketch of an implementation:
>
> - add writeback_pending, like we have crc_pending already. Difference is
>   that writeback is one-shot, i.e. set it in atomic_check somewhere, clea=
r
>   it in the crc_worker (well, composer_worker now). vblank hrtimer will
>   not re-enable that one (unlike crc_pending).
>
> - in the crc worker, if writeback_pending is set, then compose everything
>   into the writeback buffer instead of into our private crc buffer. Excep=
t
>   that we use different memory, crc computation will be done exactly the
>   same. For subsequent frames with the same crtc_state we will again use
>   the normal crc buffer to compose & compute the crc.
>
> The benefit here is that we'll only have one place in vkms that does
> composing, so if we add lots more features in the future, it'll be much
> easier to maintain. Also since this guarantees that the crc will match
> exactly what we've written back, we can use the crc to help validate our
> writeback code.

Thanks for your review and comments, I think that I understood all of
them. I=E2=80=99ll prepare a V3.

> Cheers, Daniel
>
> >
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/Makefile         |   3 +-
> >  drivers/gpu/drm/vkms/vkms_drv.c       |   7 ++
> >  drivers/gpu/drm/vkms/vkms_drv.h       |   6 +
> >  drivers/gpu/drm/vkms/vkms_output.c    |   6 +
> >  drivers/gpu/drm/vkms/vkms_writeback.c | 166 ++++++++++++++++++++++++++
> >  5 files changed, 187 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c
> >
> > diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makef=
ile
> > index b4c040854bd6..091e6fa643d1 100644
> > --- a/drivers/gpu/drm/vkms/Makefile
> > +++ b/drivers/gpu/drm/vkms/Makefile
> > @@ -6,6 +6,7 @@ vkms-y :=3D \
> >       vkms_crtc.o \
> >       vkms_gem.o \
> >       vkms_composer.o \
> > -     vkms_crc.o
> > +     vkms_crc.o \
> > +     vkms_writeback.o
> >
> >  obj-$(CONFIG_DRM_VKMS) +=3D vkms.o
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkm=
s_drv.c
> > index 966b3d653189..d870779abf9d 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -30,6 +30,10 @@ bool enable_cursor;
> >  module_param_named(enable_cursor, enable_cursor, bool, 0444);
> >  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
> >
> > +bool enable_writeback;
> > +module_param_named(enable_writeback, enable_writeback, bool, 0444);
> > +MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector=
");
> > +
> >  static const struct file_operations vkms_driver_fops =3D {
> >       .owner          =3D THIS_MODULE,
> >       .open           =3D drm_open,
> > @@ -158,6 +162,9 @@ static int __init vkms_init(void)
> >               goto out_fini;
> >       }
> >
> > +     if (enable_writeback)
> > +             DRM_INFO("Writeback connector enabled");
> > +
> >       ret =3D vkms_modeset_init(vkms_device);
> >       if (ret)
> >               goto out_fini;
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkm=
s_drv.h
> > index ad63dbe5e994..bf3fa737b3d7 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -7,6 +7,7 @@
> >  #include <drm/drm.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_encoder.h>
> > +#include <drm/drm_writeback.h>
> >  #include <linux/hrtimer.h>
> >
> >  #define XRES_MIN    20
> > @@ -19,6 +20,7 @@
> >  #define YRES_MAX  8192
> >
> >  extern bool enable_cursor;
> > +extern bool enable_writeback;
> >
> >  struct vkms_data {
> >       struct drm_framebuffer fb;
> > @@ -63,6 +65,7 @@ struct vkms_output {
> >       struct drm_crtc crtc;
> >       struct drm_encoder encoder;
> >       struct drm_connector connector;
> > +     struct drm_writeback_connector wb_connector;
> >       struct hrtimer vblank_hrtimer;
> >       ktime_t period_ns;
> >       struct drm_pending_vblank_event *event;
> > @@ -143,4 +146,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, c=
onst char *source_name,
> >                          size_t *values_cnt);
> >  void vkms_crc_work_handle(struct work_struct *work);
> >
> > +/* Writeback */
> > +int enable_writeback_connector(struct vkms_device *vkmsdev);
> > +
> >  #endif /* _VKMS_DRV_H_ */
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/=
vkms_output.c
> > index fb1941a6522c..3b093ae8f373 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -84,6 +84,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, in=
t index)
> >               goto err_attach;
> >       }
> >
> > +     if (enable_writeback) {
> > +             ret =3D enable_writeback_connector(vkmsdev);
> > +             if (ret)
> > +                     DRM_ERROR("Failed to init writeback connector\n")=
;
> > +     }
> > +
> >       drm_mode_config_reset(dev);
> >
> >       return 0;
> > diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vk=
ms/vkms_writeback.c
> > new file mode 100644
> > index 000000000000..56632eb393cb
> > --- /dev/null
> > +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> > @@ -0,0 +1,166 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include "vkms_drv.h"
> > +#include "vkms_composer.h"
> > +#include <drm/drm_writeback.h>
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +
> > +static const u32 vkms_wb_formats[] =3D {
> > +     DRM_FORMAT_XRGB8888,
> > +};
> > +
> > +static const struct drm_connector_funcs vkms_wb_connector_funcs =3D {
> > +     .fill_modes =3D drm_helper_probe_single_connector_modes,
> > +     .destroy =3D drm_connector_cleanup,
> > +     .reset =3D drm_atomic_helper_connector_reset,
> > +     .atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate=
_state,
> > +     .atomic_destroy_state =3D drm_atomic_helper_connector_destroy_sta=
te,
> > +};
> > +
> > +static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
> > +                                     struct drm_crtc_state *crtc_state=
,
> > +                                     struct drm_connector_state *conn_=
state)
> > +{
> > +     struct drm_framebuffer *fb;
> > +     const struct drm_display_mode *mode =3D &crtc_state->mode;
> > +
> > +     if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> > +             return 0;
> > +
> > +     fb =3D conn_state->writeback_job->fb;
> > +     if (fb->width !=3D mode->hdisplay || fb->height !=3D mode->vdispl=
ay) {
> > +             DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> > +                           fb->width, fb->height);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (fb->format->format !=3D DRM_FORMAT_XRGB8888) {
> > +             struct drm_format_name_buf format_name;
> > +
> > +             DRM_DEBUG_KMS("Invalid pixel format %s\n",
> > +                           drm_get_format_name(fb->format->format,
> > +                                               &format_name));
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct drm_encoder_helper_funcs vkms_wb_encoder_helper_fu=
ncs =3D {
> > +     .atomic_check =3D vkms_wb_encoder_atomic_check,
> > +};
> > +
> > +static int vkms_wb_connector_get_modes(struct drm_connector *connector=
)
> > +{
> > +     struct drm_device *dev =3D connector->dev;
> > +
> > +     return drm_add_modes_noedid(connector, dev->mode_config.max_width=
,
> > +                                 dev->mode_config.max_height);
> > +}
> > +
> > +static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_conn=
ector,
> > +                            struct drm_writeback_job *job)
> > +{
> > +     struct vkms_gem_object *vkms_obj;
> > +     struct drm_gem_object *gem_obj;
> > +     int ret;
> > +
> > +     if (!job->fb)
> > +             return 0;
> > +
> > +     gem_obj =3D drm_gem_fb_get_obj(job->fb, 0);
> > +     ret =3D vkms_gem_vmap(gem_obj);
> > +     if (ret) {
> > +             DRM_ERROR("vmap failed: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     vkms_obj =3D drm_gem_to_vkms_gem(gem_obj);
> > +     job->priv =3D vkms_obj->vaddr;
> > +
> > +     return 0;
> > +}
> > +
> > +static void vkms_wb_cleanup_job(struct drm_writeback_connector *connec=
tor,
> > +                             struct drm_writeback_job *job)
> > +{
> > +     struct drm_gem_object *gem_obj;
> > +
> > +     if (!job->fb)
> > +             return;
> > +
> > +     gem_obj =3D drm_gem_fb_get_obj(job->fb, 0);
> > +     vkms_gem_vunmap(gem_obj);
> > +}
> > +
> > +static void vkms_wb_atomic_commit(struct drm_connector *conn,
> > +                               struct drm_connector_state *state)
> > +{
> > +     struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(conn->d=
ev);
> > +     struct vkms_output *output =3D &vkmsdev->output;
> > +     struct vkms_crtc_state *crtc_state =3D output->crc_state;
> > +     struct drm_writeback_connector *wb_conn =3D &output->wb_connector=
;
> > +     struct drm_connector_state *conn_state =3D wb_conn->base.state;
> > +     void *priv_data =3D conn_state->writeback_job->priv;
> > +     struct vkms_data *primary_data =3D NULL;
> > +     struct vkms_data *cursor_data =3D NULL;
> > +     struct drm_framebuffer *fb =3D NULL;
> > +     struct vkms_gem_object *vkms_obj;
> > +     struct drm_gem_object *gem_obj;
> > +
> > +     if (!conn_state)
> > +             return;
> > +
> > +     if (!conn_state->writeback_job || !conn_state->writeback_job->fb)=
 {
> > +             DRM_DEBUG_DRIVER("Disable writeback\n");
> > +             return;
> > +     }
> > +
> > +     if (crtc_state->num_active_planes >=3D 1)
> > +             primary_data =3D crtc_state->active_planes[0]->data;
> > +
> > +     if (crtc_state->num_active_planes =3D=3D 2)
> > +             cursor_data =3D crtc_state->active_planes[1]->data;
> > +
> > +     if (!primary_data)
> > +             return;
> > +
> > +     fb =3D &primary_data->fb;
> > +     gem_obj =3D drm_gem_fb_get_obj(fb, 0);
> > +     vkms_obj =3D drm_gem_to_vkms_gem(gem_obj);
> > +
> > +     if (!vkms_obj->vaddr || !priv_data)
> > +             return;
> > +
> > +     drm_writeback_queue_job(wb_conn, state);
> > +
> > +     memcpy(priv_data, vkms_obj->vaddr, vkms_obj->gem.size);
> > +     if (cursor_data)
> > +             compose_cursor(cursor_data, primary_data, priv_data);
> > +
> > +     drm_writeback_signal_completion(wb_conn, 0);
> > +}
> > +
> > +static const struct drm_connector_helper_funcs vkms_wb_conn_helper_fun=
cs =3D {
> > +     .get_modes =3D vkms_wb_connector_get_modes,
> > +     .prepare_writeback_job =3D vkms_wb_prepare_job,
> > +     .cleanup_writeback_job =3D vkms_wb_cleanup_job,
> > +     .atomic_commit =3D vkms_wb_atomic_commit,
> > +};
> > +
> > +int enable_writeback_connector(struct vkms_device *vkmsdev)
> > +{
> > +     struct drm_writeback_connector *wb =3D &vkmsdev->output.wb_connec=
tor;
> > +
> > +     vkmsdev->output.wb_connector.encoder.possible_crtcs =3D 1;
> > +     drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
> > +
> > +     return drm_writeback_connector_init(&vkmsdev->drm, wb,
> > +                                         &vkms_wb_connector_funcs,
> > +                                         &vkms_wb_encoder_helper_funcs=
,
> > +                                         vkms_wb_formats,
> > +                                         ARRAY_SIZE(vkms_wb_formats));
> > +}
> > +
> > --
> > 2.21.0
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



--=20

Rodrigo Siqueira
https://siqueira.tech

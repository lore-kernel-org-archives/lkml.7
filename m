Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE7EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DF20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY12FPWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfCASft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:35:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38855 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCASfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:35:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so20294305oic.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 10:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D0GDFSZmWDjvNe//7F78fEk7xv42+6p+PAugrPkX5mI=;
        b=BY12FPWUfOsgC4vPrdHNGIRQwIfNZA70zHY2l7BDOPg7gc1TALsEzhwUs23uiagrwk
         EhAgVpvCSz+vp1t4Qx8iUcqhLHFZGXpYQohSKks7P2rwSkMbaeaqBXihowmMehLFm0Mg
         ChhvXQ8b66mBaNfH9Fx8YyK7qPT98IDfhqOF77WWdl2mJ+VPLPCUi9jwC4xisLTu6YEm
         vwcoovmee8QkJsEWQEIg82X0AAIiI4+9SzozLucge9rGTGUMgOSAukAG9y7lkJUdUkvg
         ep3+5soIcEfd/KjfZnTHxbrmff3NltOBgfMbnI+jxWVvy3aaJhB++tFhyU/nG2Xd82k7
         LlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D0GDFSZmWDjvNe//7F78fEk7xv42+6p+PAugrPkX5mI=;
        b=VSlU2JLsif20OaonSInBCcOC4zDpyKANi5qUvx871Qxl/vHnLg6dYHSYY4VZTw0b8f
         6qk+WQ2OPg2hqnRHiNKsu7DJOVCfQqg1aUGsHBr2NjpPiWTXUPbXJxPvMlubnM/0/+x5
         3zOWNu1yFgeEosoOTLtSBXLkqidMIB5poehXmbZGQyQsgVoAm+j7tKD30BIznrSmSevT
         GdlYGhtycqLXVGn2o5NLr8Lb2xJ3U2qh/aZ6JZseYU/M6TDLmDnrOR2R8MI8ZxM+GdyW
         0nm6ncwTiuNFk4hbxXO/HlwDb0mM3tBzdEQ46KQIydIhQZ8t9XJqRI6pacqU9zBjgfOx
         7ZKw==
X-Gm-Message-State: AHQUAuarmkxgpp4j05/SG9NsfkwGo9Pb1djCFgj+mLSA5NCFAb9BhsZr
        C7bbmOrtKWgl/sBFEOJmSedWtTYfSnkReRklw2rFX1Q1
X-Google-Smtp-Source: AHgI3IZojpM9yjcniUfJ8heCdD/3JZnxPz5RPtU6qnDteCEYqHUw0kTs9IbjgErl/abrjS1r8AklGz8Lx2FzXYu3+Oc=
X-Received: by 2002:aca:4205:: with SMTP id p5mr4269758oia.15.1551465347203;
 Fri, 01 Mar 2019 10:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
 <20190228101107.GL2665@phenom.ffwll.local> <20190228140341.GG20097@intel.com>
 <CAKkTe8Ei2fbz4L2noLvGWMCsHy1f7sadOV-horjNsGBEHt=q3w@mail.gmail.com> <20190301152558.GR20097@intel.com>
In-Reply-To: <20190301152558.GR20097@intel.com>
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
Date:   Fri, 1 Mar 2019 15:35:35 -0300
Message-ID: <CAKkTe8HbgkVm1i2xAFT6ecgv2jFjyoqrSEYUpx_40Uj=ogKYPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em sex, 1 de mar de 2019 =C3=A0s 12:26, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> escreveu:
>
> On Fri, Mar 01, 2019 at 11:55:11AM -0300, Shayenne Moura wrote:
> > Em qui, 28 de fev de 2019 =C3=A0s 11:03, Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> escreveu:
> > >
> > > On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter wrote:
> > > > On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wrote:
> > > > > vkms_crc_work_handle needs the value of the actual frame to
> > > > > schedule the workqueue that calls periodically the vblank
> > > > > handler and the destroy state functions. However, the frame
> > > > > value returned from vkms_vblank_simulate is updated and
> > > > > diminished in vblank_get_timestamp because it is not in a
> > > > > vblank interrupt, and return an inaccurate value.
> > > > >
> > > > > Solve this getting the actual vblank frame directly from the
> > > > > vblank->count inside the `struct drm_crtc`, instead of using
> > > > > the `drm_accurate_vblank_count` function.
> > > > >
> > > > > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> > > >
> > > > Sorry for the delay, I'm a bit swamped right now :-/
> > > >
> > > > Debug work you're doing here is really impressive! But I have no id=
ea
> > > > what's going on. It doesn't look like it's just papering over a bug=
 (like
> > > > the in_vblank_irq check we've discussed on irc), but I also have no=
 idea
> > > > why it works.
> > > >
> > > > I'll pull in Ville, he understands this better than me.
> > >
> > > It's not entirely clear what we're trying to fix. From what I can see
> > > the crc work seems to be in no way synchronized with page flips, so
> > > I'm not sure how all this is really supposed to work.
> > >
> >
> > Hi, Ville!
> >
> > Thank you for the review! :)
> >
> > I do not understand well what crc code is doing, but the issue that I f=
ound
> > is related to the vblank timestamp and frame count.
> >
> > When vkms handles the crc_cursor it uses the start frame and end frame
> > values to verify if it needs to call the function 'drm_crtc_add_crc_ent=
ry()'
> > for each frame.
> >
> > However, when getting the frame count, the code is calling the function
> > drm_update_vblank_count(dev, pipe, false) and, because of the 'false',
> > subtracting the actual vblank timestamp (consequently, the frame count
> > value), causing conflicts.
>
> The in_vblank_irq behavour looks sane to me. What are these conflicts?
>

The entire history was:
 - I sent the patch with bugfix for vblank extra frame. The patch changed
   our function vkms_get_vblank_timestamp() to look like this:

bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
                   int *max_error, ktime_t *vblank_time,
                   bool in_vblank_irq)
{
    struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(dev);
    struct vkms_output *output =3D &vkmsdev->output;

    *vblank_time =3D output->vblank_hrtimer.node.expires;

+   if (!in_vblank_irq)
+        *vblank_time -=3D output->period_ns;

    return true;
}

 - This patch solve the issue that I was looking for (extra vblank
frames on kms_flip).

 - However, kms_cursor_crc tests, which passed before my patch, started to =
fail.

 - Debugging them, I found that the problem was inside of function
`vkms_vblank_simulate()`
when it was handling the crc_enabled (inside  if (state && output->crc_enab=
led))
and inside the function vkms_crc_work_handle() too.

 - Following the steps:
1. Inside vkms_vblank_simulate() we call drm_crtc_accurate_vblank_count()
2. In its turn, drm_crtc_accurate_vblank_count() calls the function
   drm_update_vblank_count(dev, pipe, false).  /* This false is default */
3. Finally, the =E2=80=9Cfalse=E2=80=9D used in drm_update_vblank_count(), =
will be
  passed to vkms_get_vblank_timestamp() and the condition =E2=80=9Cif
  (!in_vblank_irq)=E2=80=9D will be executed multiple times (we don=E2=80=
=99t want it).

 - Inside vkms_crc, the issue is that the returned frame value change for
every call of drm_crtc_accurate_vblank_count() because
in_vblank_irq =3D=3D false.

 - To solve this, I used the value already calculated on vblank->count,
instead of using the helper function that updates the value.

Shayenne

> >
> > Does it make sense? I am not sure about this crc code behavior.
> >
> > Shayenne
> >
> > > > -Daniel
> > > >
> > > > > ---
> > > > >  drivers/gpu/drm/vkms/vkms_crc.c  | 4 +++-
> > > > >  drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
> > > > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vk=
ms/vkms_crc.c
> > > > > index d7b409a3c0f8..09a8b00ef1f1 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_crc.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> > > > > @@ -161,6 +161,8 @@ void vkms_crc_work_handle(struct work_struct =
*work)
> > > > >     struct vkms_output *out =3D drm_crtc_to_vkms_output(crtc);
> > > > >     struct vkms_device *vdev =3D container_of(out, struct vkms_de=
vice,
> > > > >                                             output);
> > > > > +   unsigned int pipe =3D drm_crtc_index(crtc);
> > > > > +   struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];
> > > > >     struct vkms_crc_data *primary_crc =3D NULL;
> > > > >     struct vkms_crc_data *cursor_crc =3D NULL;
> > > > >     struct drm_plane *plane;
> > > > > @@ -196,7 +198,7 @@ void vkms_crc_work_handle(struct work_struct =
*work)
> > > > >     if (primary_crc)
> > > > >             crc32 =3D _vkms_get_crc(primary_crc, cursor_crc);
> > > > >
> > > > > -   frame_end =3D drm_crtc_accurate_vblank_count(crtc);
> > > > > +   frame_end =3D vblank->count;
> > > > >
> > > > >     /* queue_work can fail to schedule crc_work; add crc for
> > > > >      * missing frames
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/v=
kms/vkms_crtc.c
> > > > > index 8a9aeb0a9ea8..9bf3268e2e92 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > @@ -10,6 +10,8 @@ static enum hrtimer_restart vkms_vblank_simulat=
e(struct hrtimer *timer)
> > > > >                                               vblank_hrtimer);
> > > > >     struct drm_crtc *crtc =3D &output->crtc;
> > > > >     struct vkms_crtc_state *state =3D to_vkms_crtc_state(crtc->st=
ate);
> > > > > +   unsigned int pipe =3D drm_crtc_index(crtc);
> > > > > +   struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];
> > > > >     u64 ret_overrun;
> > > > >     bool ret;
> > > > >
> > > > > @@ -20,7 +22,7 @@ static enum hrtimer_restart vkms_vblank_simulat=
e(struct hrtimer *timer)
> > > > >             DRM_ERROR("vkms failure on handling vblank");
> > > > >
> > > > >     if (state && output->crc_enabled) {
> > > > > -           u64 frame =3D drm_crtc_accurate_vblank_count(crtc);
> > > > > +           u64 frame =3D vblank->count;
> > > > >
> > > > >             /* update frame_start only if a queued vkms_crc_work_=
handle()
> > > > >              * has read the data
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Ville Syrj=C3=A4l=C3=A4
> > > Intel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

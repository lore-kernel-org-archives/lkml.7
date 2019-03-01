Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B30420851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j55Q3Nhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbfCAOzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:55:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38338 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfCAOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:55:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so19685019oic.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+A/rUjiNblflB10yhvy5uekIIynt3TlBlwJKLro1nXg=;
        b=j55Q3NhcRL7TS0X2zFFj65MT+xftMoy57OLmfI3KNcU6Rzs4uDjmwTrsa/6ZoxB+qy
         CSMyLOAXv2kfgFBXX8VBDHHZZMRSRBu3Xu6vf2iOro2/fMoWV27W27a9ZK24nHqjlWO2
         egGUHVL7LzV/kTAmFC9qwlL9dkHhRtYc4QCAZiwfPQXEQmfjnWuzir4uFjaV2ERP69xh
         t+paHsqQvVzWwfjCbMCt45+HzpjzuzoQVqevlhOrsM01P5Vvf1R6byzwodL0GViFrWSd
         fxv6fr8EH+1EMCH1of9fx7l+CrtcNabSywdyor+e1y1tAOrBijZ1+Sv0VqOrsi0hXfp2
         GzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+A/rUjiNblflB10yhvy5uekIIynt3TlBlwJKLro1nXg=;
        b=ZSxxTbBeCDhefkcBwqcB3rCcoDwdBOYD3vuvwdY9bTZFCFKI87k5dGIT7rfsq+mX2z
         QepykkIY0qmJ4NgCzibAyIJl2EFlHhdjkBn3QApe1lks3iSH9w1Fgjt4/RaoZh2eQ7AO
         GdXpxd/Cg4JHWY6vtod6HO9oPZpv4FyDlwx9pYMvTn2x6VNbRBXSkk6aBmejYfGH+CmX
         UmbUkiApxsheKRyF7BlJQuZeCtpSP1moGiJrYpawg9oKAMrpXxdbj+10SceswQ2cQXNl
         Bo1v26gPT0HX3F7yVIaADCJBEJCl32jJ+XU4dU5QsN3NTHDdPH6QjAmq5Mnxe7KiXgWz
         RZ7g==
X-Gm-Message-State: AHQUAubVeHVIeg3oJEp0Pap21Jrd03Y5MVHBybe18sDuQqCjkd1PPrgl
        KbK3qR+qIUwRoNIuiy6u+96Cy45JFC9I74Uophk=
X-Google-Smtp-Source: AHgI3IZJQE8+n6LbLDsqWpK7KDkF6SPjmgtnZ1pusZUwZSn/0bE92cLjtJaZYDWawuf5UaEEdUhgXxRGTA/HA+saj+4=
X-Received: by 2002:aca:ba06:: with SMTP id k6mr3601504oif.159.1551452122694;
 Fri, 01 Mar 2019 06:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
 <20190228101107.GL2665@phenom.ffwll.local> <20190228140341.GG20097@intel.com>
In-Reply-To: <20190228140341.GG20097@intel.com>
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
Date:   Fri, 1 Mar 2019 11:55:11 -0300
Message-ID: <CAKkTe8Ei2fbz4L2noLvGWMCsHy1f7sadOV-horjNsGBEHt=q3w@mail.gmail.com>
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

Em qui, 28 de fev de 2019 =C3=A0s 11:03, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> escreveu:
>
> On Thu, Feb 28, 2019 at 11:11:07AM +0100, Daniel Vetter wrote:
> > On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wrote:
> > > vkms_crc_work_handle needs the value of the actual frame to
> > > schedule the workqueue that calls periodically the vblank
> > > handler and the destroy state functions. However, the frame
> > > value returned from vkms_vblank_simulate is updated and
> > > diminished in vblank_get_timestamp because it is not in a
> > > vblank interrupt, and return an inaccurate value.
> > >
> > > Solve this getting the actual vblank frame directly from the
> > > vblank->count inside the `struct drm_crtc`, instead of using
> > > the `drm_accurate_vblank_count` function.
> > >
> > > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> >
> > Sorry for the delay, I'm a bit swamped right now :-/
> >
> > Debug work you're doing here is really impressive! But I have no idea
> > what's going on. It doesn't look like it's just papering over a bug (li=
ke
> > the in_vblank_irq check we've discussed on irc), but I also have no ide=
a
> > why it works.
> >
> > I'll pull in Ville, he understands this better than me.
>
> It's not entirely clear what we're trying to fix. From what I can see
> the crc work seems to be in no way synchronized with page flips, so
> I'm not sure how all this is really supposed to work.
>

Hi, Ville!

Thank you for the review! :)

I do not understand well what crc code is doing, but the issue that I found
is related to the vblank timestamp and frame count.

When vkms handles the crc_cursor it uses the start frame and end frame
values to verify if it needs to call the function 'drm_crtc_add_crc_entry()=
'
for each frame.

However, when getting the frame count, the code is calling the function
drm_update_vblank_count(dev, pipe, false) and, because of the 'false',
subtracting the actual vblank timestamp (consequently, the frame count
value), causing conflicts.

Does it make sense? I am not sure about this crc code behavior.

Shayenne

> > -Daniel
> >
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_crc.c  | 4 +++-
> > >  drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
> > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/v=
kms_crc.c
> > > index d7b409a3c0f8..09a8b00ef1f1 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> > > @@ -161,6 +161,8 @@ void vkms_crc_work_handle(struct work_struct *wor=
k)
> > >     struct vkms_output *out =3D drm_crtc_to_vkms_output(crtc);
> > >     struct vkms_device *vdev =3D container_of(out, struct vkms_device=
,
> > >                                             output);
> > > +   unsigned int pipe =3D drm_crtc_index(crtc);
> > > +   struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];
> > >     struct vkms_crc_data *primary_crc =3D NULL;
> > >     struct vkms_crc_data *cursor_crc =3D NULL;
> > >     struct drm_plane *plane;
> > > @@ -196,7 +198,7 @@ void vkms_crc_work_handle(struct work_struct *wor=
k)
> > >     if (primary_crc)
> > >             crc32 =3D _vkms_get_crc(primary_crc, cursor_crc);
> > >
> > > -   frame_end =3D drm_crtc_accurate_vblank_count(crtc);
> > > +   frame_end =3D vblank->count;
> > >
> > >     /* queue_work can fail to schedule crc_work; add crc for
> > >      * missing frames
> > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/=
vkms_crtc.c
> > > index 8a9aeb0a9ea8..9bf3268e2e92 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > @@ -10,6 +10,8 @@ static enum hrtimer_restart vkms_vblank_simulate(st=
ruct hrtimer *timer)
> > >                                               vblank_hrtimer);
> > >     struct drm_crtc *crtc =3D &output->crtc;
> > >     struct vkms_crtc_state *state =3D to_vkms_crtc_state(crtc->state)=
;
> > > +   unsigned int pipe =3D drm_crtc_index(crtc);
> > > +   struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe];
> > >     u64 ret_overrun;
> > >     bool ret;
> > >
> > > @@ -20,7 +22,7 @@ static enum hrtimer_restart vkms_vblank_simulate(st=
ruct hrtimer *timer)
> > >             DRM_ERROR("vkms failure on handling vblank");
> > >
> > >     if (state && output->crc_enabled) {
> > > -           u64 frame =3D drm_crtc_accurate_vblank_count(crtc);
> > > +           u64 frame =3D vblank->count;
> > >
> > >             /* update frame_start only if a queued vkms_crc_work_hand=
le()
> > >              * has read the data
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

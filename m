Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B0FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174A820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sj9JInCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfFMSzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:55:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38691 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfFMSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:55:53 -0400
Received: by mail-vs1-f66.google.com with SMTP id k9so132128vso.5;
        Thu, 13 Jun 2019 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4OQtg+Kb8n0/7lnmdInZbUHkri3Yl0Dz8LW1LSwlW6I=;
        b=sj9JInCj7SObNH40j+jPWiWM94RML1vfeC8hDQw1aPWnM+T7z5X2i7RlGRbMfdfHDG
         z+ywVsIR18hPj/NTc0itgVaAW4niiUcwCtY9hjABeQ+tQ+dwpo+ChX3TtEjRQo4RqqsI
         tbol77ftvXgyL3FU8FNcv/EGa5thHTPc9a7rEG7Op7lO9YgMPDPMnUhRlWsW57wvIPjf
         j18Xkwsf6DrbRVk2xC/oKmpHVJ4qV0C+w3sJwiHo3mvw6auz0GozxoNVB/zxXAtXwO89
         Wqf8jklOJJDuEQLdbzWsoMB3ExAcy6KyLaVw8H7hySkglRDRjyj079LWx3vrH97ws8tZ
         yW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4OQtg+Kb8n0/7lnmdInZbUHkri3Yl0Dz8LW1LSwlW6I=;
        b=mUk/yP1gl4aMPYYZt9SsyZ+4y7mz4J354xOSUTEIm+GCbpjABrQW3seGyLRZkM4rvv
         jPDsT7+jOU0VYhrhTuk48HDH+7OIRXhFSIIYwUfSuHXGX4q6FwJhjbQUdaYo5Wrlfz5l
         YKGdP4A6zDSbCT4daXubZ8R1PVL5TX+Ac7de7cmwmDerb+K7OHBNOjME60bmNi+/eS05
         aaJshVuDsYiVNgtFu56bYBcxJcg61HkZClgujE/JuL+SdPb6aWGMX/9x47LriIpPt0YD
         qsM6LLLCUOGBMwHmrBBv9qJc5mvP3KCFV8/abr1ST0hmIAEWfv3jlwnz4ZQR2MNvTwp2
         d3AA==
X-Gm-Message-State: APjAAAUIO+dYOMa4tNmzNq5Gvt8ubq4AHdZCsj26IdSSRbVyZazTXod6
        wFD+jG6nFxBXCyaruJ7z62FAHpw/cMDfDTWQm5fXE+MHh/0=
X-Google-Smtp-Source: APXvYqzT+lMnv6Xnxg0qzHQuRCrr7fpcFtbfilzse/1Obe+a0E60uXzqfzVt0d3RIq235gmNwp+QCGngLGBwj6bezhQ=
X-Received: by 2002:a67:b14d:: with SMTP id z13mr10977506vsl.190.1560452151309;
 Thu, 13 Jun 2019 11:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190613021054.cdewdb3azy6zuoyw@smtp.gmail.com> <20190613050403.GA21502@ravnborg.org>
In-Reply-To: <20190613050403.GA21502@ravnborg.org>
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Date:   Thu, 13 Jun 2019 15:55:40 -0300
Message-ID: <CADKXj+7X2ukpM16OHxenTCNtBPHUaj7Z8eBz3ZpyDYpZ2vGC9g@mail.gmail.com>
Subject: Re: Drop use of DRM_WAIT_ON() [Was: drm/drm_vblank: Change EINVAL by
 the correct errno]
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Intel GFX ML <intel-gfx@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

I tested it by using VKMS and kms_flip, and tests related to =E2=80=9Cvblan=
k=E2=80=9D
fails (e.g., basic-flip-vs-wf_vblank, blocking-absolute-wf_vblank,
flip-vs-absolute-wf_vblank, etc). I tried to dig into this issue, and
you can see my comments inline:

On Thu, Jun 13, 2019 at 2:04 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rodrigo.
>
> On Wed, Jun 12, 2019 at 11:10:54PM -0300, Rodrigo Siqueira wrote:
> > For historical reason, the function drm_wait_vblank_ioctl always return
> > -EINVAL if something gets wrong. This scenario limits the flexibility
> > for the userspace make detailed verification of the problem and take
> > some action. In particular, the validation of =E2=80=9Cif (!dev->irq_en=
abled)=E2=80=9D
> > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > support vblank or not. If the driver does not support VBlank, the
> > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > Additionally, some operations are unsupported by this function, and
> > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > libdrm, which is used by many compositors; because of this, it is
> > important to check if this change breaks any compositor. In this sense,
> > the following projects were examined:
> >
> > * Drm-hwcomposer
> > * Kwin
> > * Sway
> > * Wlroots
> > * Wayland-core
> > * Weston
> > * Xorg (67 different drivers)
> >
> > For each repository the verification happened in three steps:
> >
> > * Update the main branch
> > * Look for any occurrence "drmWaitVBlank" with the command:
> >   git grep -n "drmWaitVBlank"
> > * Look in the git history of the project with the command:
> >   git log -SdrmWaitVBlank
> >
> > Finally, none of the above projects validate the use of EINVAL which
> > make safe, at least for these projects, to change the return values.
> >
> > Change since V2:
> >  Daniel Vetter and Chris Wilson
> >  - Replace ENOTTY by EOPNOTSUPP
> >  - Return EINVAL if the parameters are wrong
> >
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> > Update:
> >   Now IGT has a way to validate if a driver has vblank support or not.
> >   See: https://gitlab.freedesktop.org/drm/igt-gpu-tools/commit/2d244aed=
69165753f3adbbd6468db073dc1acf9A
> >
> >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.=
c
> > index 0d704bddb1a6..d76a783a7d4b 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1578,10 +1578,10 @@ int drm_wait_vblank_ioctl(struct drm_device *de=
v, void *data,
> >       unsigned int flags, pipe, high_pipe;
> >
> >       if (!dev->irq_enabled)
> > -             return -EINVAL;
> > +             return -EOPNOTSUPP;
> >
> >       if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > -             return -EINVAL;
> > +             return -EOPNOTSUPP;
> >
> >       if (vblwait->request.type &
> >           ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
>
> When touching this function, could I ask you to take a look at
> eliminating the use of DRM_WAIT_ON()?
> It comes from the deprecated drm_os_linux.h header, and it is only of
> the few remaining users of DRM_WAIT_ON().
>
> Below you can find my untested first try - where I did an attempt not to
> change behaviour.
>
>         Sam
>
> commit 17b119b02467356198b57bca9949b146082bcaa1
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Thu May 30 09:38:47 2019 +0200
>
>     drm/vblank: drop use of DRM_WAIT_ON()
>
>     DRM_WAIT_ON() is from the deprecated drm_os_linux header and
>     the modern replacement is the wait_event_*.
>
>     The return values differ, so a conversion is needed to
>     keep the original interface towards userspace.
>     Introduced a switch/case to make code obvious and to allow
>     different debug prints depending on the result.
>
>     The timeout value of 3 * HZ was translated to 30 msec
>
>     Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>     Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>     Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>     Cc: Sean Paul <sean@poorly.run>
>     Cc: David Airlie <airlied@linux.ie>
>     Cc: Daniel Vetter <daniel@ffwll.ch>
>
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 0d704bddb1a6..51fc6b106333 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -31,7 +31,6 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_print.h>
> -#include <drm/drm_os_linux.h>
>  #include <drm/drm_vblank.h>
>
>  #include "drm_internal.h"
> @@ -1668,18 +1667,27 @@ int drm_wait_vblank_ioctl(struct drm_device *dev,=
 void *data,
>         if (req_seq !=3D seq) {
>                 DRM_DEBUG("waiting on vblank count %llu, crtc %u\n",
>                           req_seq, pipe);
> -               DRM_WAIT_ON(ret, vblank->queue, 3 * HZ,
> -                           vblank_passed(drm_vblank_count(dev, pipe),
> -                                         req_seq) ||
> -                           !READ_ONCE(vblank->enabled));
> +               ret =3D wait_event_interruptible_timeout(vblank->queue,
> +                       vblank_passed(drm_vblank_count(dev, pipe), req_se=
q) ||
> +                                     !READ_ONCE(vblank->enabled),
> +                       msecs_to_jiffies(30));

Maybe I=E2=80=99m wrong, but msecs_to_jiffies(30) is much smaller than 3 * =
HZ. Right?

>         }
>
> -       if (ret !=3D -EINTR) {
> +       switch (ret) {
> +       case 1:
> +               ret =3D 0;
>                 drm_wait_vblank_reply(dev, pipe, &vblwait->reply);
> -
>                 DRM_DEBUG("crtc %d returning %u to client\n",
>                           pipe, vblwait->reply.sequence);
> -       } else {
> +               break;
> +       case 0:
> +               ret =3D -EBUSY;

After applying your patch, I noticed that drm_wait_vblank_ioctl()
consistently returns EBUSY, which is the cause of the errors in the
userspace. After that, I decided to take a look at DRM_WAIT_ON; See
below the code and my comments:

#define DRM_WAIT_ON( ret, queue, timeout, condition )        \
do {                                \
    DECLARE_WAITQUEUE(entry, current);            \
    unsigned long end =3D jiffies + (timeout);        \
    add_wait_queue(&(queue), &entry);            \
                                \
    for (;;) {                        \
        __set_current_state(TASK_INTERRUPTIBLE);    \
        if (condition)                    \
            break;                    \
        if (time_after_eq(jiffies, end)) {        \
            ret =3D -EBUSY;                \
            break;                    \
        }                        \

I think that your code does not handle this condition for EBUSY in the
same way of DRM_WAIT_ON(), or did I miss something?

Best regards

> +               drm_wait_vblank_reply(dev, pipe, &vblwait->reply);
> +               DRM_DEBUG("timeout waiting for vblank. crtc %d returning =
%u to client\n",
> +                         pipe, vblwait->reply.sequence);
> +               break;
> +       default:
> +               ret =3D -EINTR;
>                 DRM_DEBUG("crtc %d vblank wait interrupted by signal\n", =
pipe);
>         }
>


--=20

Rodrigo Siqueira
https://siqueira.tech

Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A83C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910E7204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdUyfzpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfFZNhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:37:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36748 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:37:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id v20so765004uao.3;
        Wed, 26 Jun 2019 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=is/ujkoZicHG2BibnpnLpAegsLraJDOqvg5EgkUGsS0=;
        b=IdUyfzpGPTccHKxZnHQiTAf0O89bmOsqYbavdIQtAOB1kU8BwTZYT15uJkoj/1vEcN
         rm4fS4IbFKYA9KlsN6w6Nk3djG2t7D3mR0MehHmeh4NjwAFi3XUY8R2N1IYSaXcN6zYO
         4jC4eesVaM5c+rhzsoa5ZdtWe8RIFTYZWM3qDnccj8iaPfmk2VGW8EYwKhdqIswvghU2
         2j47Itxu8AdbXZU1WLVO8S9s3IOtTBZMcRKa25dilMyRvlha0OcDa4Eg4leTVu7u/MD6
         g3T+mMhfaVnIhHFrZag/e22PnhEEqGBAVHHSk1oRCxO8rn00KKW2rGEKBtQIi6cQNl5w
         5d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=is/ujkoZicHG2BibnpnLpAegsLraJDOqvg5EgkUGsS0=;
        b=tIjjQrjGG7q2qezhkzIz1XeFgz2nEjRBUkE61LK60WJuJq0wSUW8Ib2NnSa+R0wdgt
         FQbLUl/+sJjtqpa2omkwLB4Z7vCl9d4SUzYM2wO/kJWWkmIUh/faBwSsa8KUM3HjUDI9
         Ffwg/Rh/1GypFZZ/VHLzNPAH38RJv+TpLH5pY4D2FcAzF3VaObdWdAkbkHHXe9l78909
         RACd9/x0jl9ckqPtosazDfz/OhfnphiCgW3dcWAH4qClKXsWG24xSnpzT1NoQ2VthEOE
         o0tjIXVxVnIQDrvpDer/DAD+5zha/z89NkFIhrxGGSUQy95eW6icY15Lf4jPrAoi/fdK
         1urQ==
X-Gm-Message-State: APjAAAXGS4TiunF1GVbiqVKEevSFEXgHlSxy+xTq/zi3Od5eq0wGvB2l
        gibthMp0732yoHZmSNICVrccbOibPcfCUXbUkpKPv//Vx1I=
X-Google-Smtp-Source: APXvYqy8R5tVK0LIjN1Tts0iTEE7Nh0qNsb/DwSEKJFOqodoXJVgTSYIWTeyUj8o6H0Q5YI9s6QKfHv+8c+bRRTvXLo=
X-Received: by 2002:ab0:2850:: with SMTP id c16mr2498783uaq.128.1561556242469;
 Wed, 26 Jun 2019 06:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
 <20190619074856.GJ12905@phenom.ffwll.local> <20190619075059.GK12905@phenom.ffwll.local>
 <20190626020005.vb5gmqcvkyzgcjee@smtp.gmail.com> <CAKMK7uEd71XTeuZeu1Km8Vq1K1VJJbgANyaZNWm4v18Qh-OqVw@mail.gmail.com>
In-Reply-To: <CAKMK7uEd71XTeuZeu1Km8Vq1K1VJJbgANyaZNWm4v18Qh-OqVw@mail.gmail.com>
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Date:   Wed, 26 Jun 2019 10:37:11 -0300
Message-ID: <CADKXj+5+QHr1a0aiVZ1cSiPbtZhUAjmqiTmoQHGyEhodbcA2WQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH V4] drm/drm_vblank: Change EINVAL by the
 correct errno
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 4:53 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jun 26, 2019 at 4:00 AM Rodrigo Siqueira
> <rodrigosiqueiramelo@gmail.com> wrote:
> >
> > On 06/19, Daniel Vetter wrote:
> > > On Wed, Jun 19, 2019 at 09:48:56AM +0200, Daniel Vetter wrote:
> > > > On Tue, Jun 18, 2019 at 11:07:50PM -0300, Rodrigo Siqueira wrote:
> > > > > For historical reason, the function drm_wait_vblank_ioctl always =
return
> > > > > -EINVAL if something gets wrong. This scenario limits the flexibi=
lity
> > > > > for the userspace make detailed verification of the problem and t=
ake
> > > > > some action. In particular, the validation of =E2=80=9Cif (!dev->=
irq_enabled)=E2=80=9D
> > > > > in the drm_wait_vblank_ioctl is responsible for checking if the d=
river
> > > > > support vblank or not. If the driver does not support VBlank, the
> > > > > function drm_wait_vblank_ioctl returns EINVAL which does not repr=
esent
> > > > > the real issue; this patch changes this behavior by return EOPNOT=
SUPP.
> > > > > Additionally, some operations are unsupported by this function, a=
nd
> > > > > returns EINVAL; this patch also changes the return value to EOPNO=
TSUPP
> > > > > in this case. Lastly, the function drm_wait_vblank_ioctl is invok=
ed by
> > > > > libdrm, which is used by many compositors; because of this, it is
> > > > > important to check if this change breaks any compositor. In this =
sense,
> > > > > the following projects were examined:
> > > > >
> > > > > * Drm-hwcomposer
> > > > > * Kwin
> > > > > * Sway
> > > > > * Wlroots
> > > > > * Wayland-core
> > > > > * Weston
> > > > > * Xorg (67 different drivers)
> > > > >
> > > > > For each repository the verification happened in three steps:
> > > > >
> > > > > * Update the main branch
> > > > > * Look for any occurrence "drmWaitVBlank" with the command:
> > > > >   git grep -n "drmWaitVBlank"
> > > > > * Look in the git history of the project with the command:
> > > > >   git log -SdrmWaitVBlank
> > > > >
> > > > > Finally, none of the above projects validate the use of EINVAL wh=
ich
> > > > > make safe, at least for these projects, to change the return valu=
es.
> > > > >
> > > > > Change since V3:
> > > > >  - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)
> > > > >
> > > > > Change since V2:
> > > > >  Daniel Vetter and Chris Wilson
> > > > >  - Replace ENOTTY by EOPNOTSUPP
> > > > >  - Return EINVAL if the parameters are wrong
> > > > >
> > > >
> > > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > >
> > > > Apologies for the confusion on the last time around. btw if someone=
 tells
> > > > you "r-b (or a-b) with these changes", then just apply the r-b/a-b =
tag
> > > > next time around. Otherwise people will re-review the same thing ov=
er and
> > > > over again.
> > >
> > > btw when resending patches it's good practice to add anyone who comme=
nted
> > > on it (or who commented on the igt test for the same patch and other =
way
> > > round) onto the explicit Cc: list of the patch. That way it's easier =
for
> > > them to follow the patch evolution and do a quick r-b once they're ha=
ppy.
> >
> > Thanks for these valuable tips.
> > Do you think that is a good idea to resend this patch CC's everybody? O=
r
> > is it ok if I just apply it?
>
> Hm I thought I answered that on irc ... but just today I realized that
> we missed 2 ioctls. There's also drm_crtc_get_sequence_ioctl and
> drm_crtc_queue_sequence_ioctl which have the same dev->irq_enabled
> check and I think should be treated the same.

Hi,

I reexamined all the composers described in the commit message (latest
versions) to check if any project use and validate the return value
from  drm_crtc_get_sequence_ioctl and drm_crtc_queue_sequence_ioctl. I
noticed that mesa and xserver use them. FWIU replace EINVAL by
EOPNOTSUPP is harmless for mesa project, however it is not the same
for xserver.

Take a look at line 189 and 238 of hw/xfree86/drivers/modesetting/vblank.c

* https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/driver=
s/modesetting/vblank.c#L238
* https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/driver=
s/modesetting/vblank.c#L189

A little bit below the above lines, you can see a validation like that:

  if (ret !=3D -1 || (errno !=3D ENOTTY && errno !=3D EINVAL))

In other words, if we change the EINVAL by EOPNOTSUPP
drm_crtc_[get|queue]_sequence_ioctl we could break xserver. I noticed
that Keith Packard introduced these ioctls to the kernel and also to
the xserver, I will prepare a new version and CC Keith. Should I do
another thing to notify xserver developers?

Thanks

> Can you pls resend with those addressed too? Then you can also resend
> with the cc's all added.
> -Daniel
>
> >
> > > If you don't do that then much bigger chances your patch gets ignored=
.
> > > -Daniel
> > > >
> > > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_vblank.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_v=
blank.c
> > > > > index 603ab105125d..bed233361614 100644
> > > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > > @@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device=
 *dev, void *data,
> > > > >   unsigned int flags, pipe, high_pipe;
> > > > >
> > > > >   if (!dev->irq_enabled)
> > > > > -         return -EINVAL;
> > > > > +         return -EOPNOTSUPP;
> > > > >
> > > > >   if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > > >           return -EINVAL;
> > > > > --
> > > > > 2.21.0
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> >
> > --
> > Rodrigo Siqueira
> > https://siqueira.tech
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch



--=20

Rodrigo Siqueira
https://siqueira.tech

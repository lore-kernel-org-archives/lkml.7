Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9918C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B89A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dhnixGsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfFZHxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:53:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40623 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfFZHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:53:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so1583253otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gK6sTyPGkQBsRICOrU/v96WJmqJIHrnWAm3pchdZ41g=;
        b=dhnixGsyA2slTRiz9/IZXqyzJj+DNdLVG1xw0yaJZotw9dcpV5jLJAP5lOCnVQaycl
         j14Xs78Ap7s+m7sNn+ZBOpLwEUsTo1zP8VjLSDWRxxQXbeo8lz8SaArHZJyMC6Uvo9gv
         EmmGw0RuonOrOcm9M0DS3CBlhVro4tLFcehNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gK6sTyPGkQBsRICOrU/v96WJmqJIHrnWAm3pchdZ41g=;
        b=hWEZJLCBsMzzskINv7M6RnQMuYTLVTK/7GUtUZxn37HsThENs0ZMXcWnZPsApMyZoK
         w1zd0bIwmrvfxbM10/DxxegZIQL4a3ovCP+M5YAwvZSDn68/kLnJthFUz3eHs9inLfxw
         jljem+YWyYisLCmMXFFyWqJzpxemduraOywUqQKokXVCdi4uDJQGHRjNs/evqGf8ISMP
         NzMfaZgvKNavcW0Z41DB4ZLwYrIQwc6T3lJc1Rfq8q3iZwCdx8UMcCVfOjZyNi+xa0w0
         gr2f6lsGN101rLnPujRgaDHERmIKI/9pzcZKRaVTNKeQX/QXxjA2qCEUVj5U9TAkBCBy
         fZbg==
X-Gm-Message-State: APjAAAWADAL2JGdPvz31DaXxdPEuIeFPt4cmCigWtPiG8R0iY/cAzR+z
        YHq5dQjQmfsQPKr4Liw5Kb+7bYnKLszFFXY1dnnDJg==
X-Google-Smtp-Source: APXvYqyUs3Td+S7saRzPYCnaOjLCKshI6la+7/TjmiLqpBi3SV2mdzqTgrEw6uzagAHcAMFWXHb9UganSr1nLrAuZHo=
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr2161271otr.303.1561535585757;
 Wed, 26 Jun 2019 00:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
 <20190619074856.GJ12905@phenom.ffwll.local> <20190619075059.GK12905@phenom.ffwll.local>
 <20190626020005.vb5gmqcvkyzgcjee@smtp.gmail.com>
In-Reply-To: <20190626020005.vb5gmqcvkyzgcjee@smtp.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jun 2019 09:52:54 +0200
Message-ID: <CAKMK7uEd71XTeuZeu1Km8Vq1K1VJJbgANyaZNWm4v18Qh-OqVw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH V4] drm/drm_vblank: Change EINVAL by the
 correct errno
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
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

On Wed, Jun 26, 2019 at 4:00 AM Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
>
> On 06/19, Daniel Vetter wrote:
> > On Wed, Jun 19, 2019 at 09:48:56AM +0200, Daniel Vetter wrote:
> > > On Tue, Jun 18, 2019 at 11:07:50PM -0300, Rodrigo Siqueira wrote:
> > > > For historical reason, the function drm_wait_vblank_ioctl always re=
turn
> > > > -EINVAL if something gets wrong. This scenario limits the flexibili=
ty
> > > > for the userspace make detailed verification of the problem and tak=
e
> > > > some action. In particular, the validation of =E2=80=9Cif (!dev->ir=
q_enabled)=E2=80=9D
> > > > in the drm_wait_vblank_ioctl is responsible for checking if the dri=
ver
> > > > support vblank or not. If the driver does not support VBlank, the
> > > > function drm_wait_vblank_ioctl returns EINVAL which does not repres=
ent
> > > > the real issue; this patch changes this behavior by return EOPNOTSU=
PP.
> > > > Additionally, some operations are unsupported by this function, and
> > > > returns EINVAL; this patch also changes the return value to EOPNOTS=
UPP
> > > > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked=
 by
> > > > libdrm, which is used by many compositors; because of this, it is
> > > > important to check if this change breaks any compositor. In this se=
nse,
> > > > the following projects were examined:
> > > >
> > > > * Drm-hwcomposer
> > > > * Kwin
> > > > * Sway
> > > > * Wlroots
> > > > * Wayland-core
> > > > * Weston
> > > > * Xorg (67 different drivers)
> > > >
> > > > For each repository the verification happened in three steps:
> > > >
> > > > * Update the main branch
> > > > * Look for any occurrence "drmWaitVBlank" with the command:
> > > >   git grep -n "drmWaitVBlank"
> > > > * Look in the git history of the project with the command:
> > > >   git log -SdrmWaitVBlank
> > > >
> > > > Finally, none of the above projects validate the use of EINVAL whic=
h
> > > > make safe, at least for these projects, to change the return values=
.
> > > >
> > > > Change since V3:
> > > >  - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)
> > > >
> > > > Change since V2:
> > > >  Daniel Vetter and Chris Wilson
> > > >  - Replace ENOTTY by EOPNOTSUPP
> > > >  - Return EINVAL if the parameters are wrong
> > > >
> > >
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >
> > > Apologies for the confusion on the last time around. btw if someone t=
ells
> > > you "r-b (or a-b) with these changes", then just apply the r-b/a-b ta=
g
> > > next time around. Otherwise people will re-review the same thing over=
 and
> > > over again.
> >
> > btw when resending patches it's good practice to add anyone who comment=
ed
> > on it (or who commented on the igt test for the same patch and other wa=
y
> > round) onto the explicit Cc: list of the patch. That way it's easier fo=
r
> > them to follow the patch evolution and do a quick r-b once they're happ=
y.
>
> Thanks for these valuable tips.
> Do you think that is a good idea to resend this patch CC's everybody? Or
> is it ok if I just apply it?

Hm I thought I answered that on irc ... but just today I realized that
we missed 2 ioctls. There's also drm_crtc_get_sequence_ioctl and
drm_crtc_queue_sequence_ioctl which have the same dev->irq_enabled
check and I think should be treated the same.

Can you pls resend with those addressed too? Then you can also resend
with the cc's all added.
-Daniel

>
> > If you don't do that then much bigger chances your patch gets ignored.
> > -Daniel
> > >
> > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_vblank.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vbl=
ank.c
> > > > index 603ab105125d..bed233361614 100644
> > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > @@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device *=
dev, void *data,
> > > >   unsigned int flags, pipe, high_pipe;
> > > >
> > > >   if (!dev->irq_enabled)
> > > > -         return -EINVAL;
> > > > +         return -EOPNOTSUPP;
> > > >
> > > >   if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > >           return -EINVAL;
> > > > --
> > > > 2.21.0
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

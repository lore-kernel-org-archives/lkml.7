Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA734C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A35214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZO6Hq7Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392723AbfETRaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:30:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39256 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfETRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:30:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id r7so13745354otn.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w7xwTUeYKrSfrBM+h5HUVdnqdBSB9vUCYGXp5xJ95JM=;
        b=ZO6Hq7OiQp6lSdZjsMVmEKmik7on/WpvOCHpf6t5krk+Uu33ZZMN5cWid3galoDMwP
         7ZTVZ54oCZxOPmo508EYHqUKt6Uj4LDIctXkSFXCsYTlwW5gNNXjO8hMSjN4pXgL3u9l
         KwkCaCHzNMs30yvqBzZCLH7+W19DPtgu8PPMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7xwTUeYKrSfrBM+h5HUVdnqdBSB9vUCYGXp5xJ95JM=;
        b=ckQ52ySxvJkEDXAPOq7R107qFeRuILr14zeywjv2xSFFdBQKdSmvfoEIQu1tEj8aWr
         +HAIcuyifQGjDfvSIuRoTAUpAxmJeXDRXeTKIl1ChAMRasf6dP4PJjx4oGXxCjLAchvr
         h/RO8G9B9hx4iatI/h46V63xwRYihB8IMRugaq//7MCF+LTVmEiF50lv+VX8pf9z4jdB
         kUa0fdwOEJlyQTRTvrkxQjfH8/CmxXrC13o9DdxIYKNTIsZ0waUKNSXZ2IvCkTenbeov
         A6biqNwfEZICoeZCs716OQbKak0eKKTW5aiDDP8Xm8FSdEOgYlxt8l7XVdKKY7YcxdEH
         fC3A==
X-Gm-Message-State: APjAAAWhkEMUP8diKmtY8yzF7HsUqq3G17AB1N5wcs/QenskNVqowEdo
        11R9xO3/GbWknOMDQwkrBKaYNG9iq3An2OoZoxnevw==
X-Google-Smtp-Source: APXvYqwOlCRN4NfxRZOxiCVCCKQQSFLJ4oJHeZsGEOmvyD5lsNebxeBwi/+3AHWtrOzY7HEBCJDqaznneLRmesw/7LA=
X-Received: by 2002:a9d:7395:: with SMTP id j21mr37290262otk.204.1558373402987;
 Mon, 20 May 2019 10:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-28-daniel.vetter@ffwll.ch> <20190520172008.GB27230@ravnborg.org>
In-Reply-To: <20190520172008.GB27230@ravnborg.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 20 May 2019 19:29:52 +0200
Message-ID: <CAKMK7uEfyaex+kWyphReA9uaX9p21hDd_WquskocarvWtq1MHA@mail.gmail.com>
Subject: Re: [PATCH 27/33] fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 7:20 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Daniel.
>
> > With the recursion broken in the previous patch we can drop the
> > FBINFO_MISC_USEREVENT flag around calls to fb_blank - recursion
> > prevention was it's only job.
> >
> When grepping for FBINFO_MISC_USEREVENT I get a few hits not addressed
> in the patch below:
>
> drivers/video/fbdev/core/fbcon.c:                       if (!(info->flags=
 & FBINFO_MISC_USEREVENT))
> drivers/video/fbdev/core/fbmem.c:                       if (!ret && (flag=
s & FBINFO_MISC_USEREVENT)) {
> drivers/video/fbdev/core/fbmem.c:                               info->fla=
gs &=3D ~FBINFO_MISC_USEREVENT;
> drivers/video/fbdev/core/fbmem.c:               info->flags |=3D FBINFO_M=
ISC_USEREVENT;
> drivers/video/fbdev/core/fbmem.c:               info->flags &=3D ~FBINFO_=
MISC_USEREVENT;
> drivers/video/fbdev/core/fbmem.c:               info->flags |=3D FBINFO_M=
ISC_USEREVENT;
> drivers/video/fbdev/core/fbmem.c:               info->flags &=3D ~FBINFO_=
MISC_USEREVENT;
> drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags |=3D FBINFO_MISC_U=
SEREVENT;
> drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags &=3D ~FBINFO_MISC_=
USEREVENT;
> drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags |=3D FBINFO_MISC_U=
SEREVENT;
> drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags &=3D ~FBINFO_MISC_=
USEREVENT;
> drivers/video/fbdev/ps3fb.c:                            info->flags |=3D =
FBINFO_MISC_USEREVENT;
> drivers/video/fbdev/ps3fb.c:                            info->flags &=3D =
~FBINFO_MISC_USEREVENT;
> drivers/video/fbdev/sh_mobile_lcdcfb.c:  * FBINFO_MISC_USEREVENT flag is =
set. Since we do not want to fake a
> include/linux/fb.h:#define FBINFO_MISC_USEREVENT          0x10000 /* even=
t request
>
> The use in ps3fb looks like a candidate for removal and this file is not
> touch in this patch series, so I guess I did not miss it.
>
> As I did not apply the full series maybe some of the other users was
> already taken care of.

It's also used to break recursion around fb_set_par and fb_set_pan.
Untangling that one would be possible, but also requires untangling
some locking, so a lot more work. If you chase all the call paths then
you'll noticed that the users still left have no overlap with the ones
I'm removing here.
-Daniel

>
>
>         Sam
>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Yisheng Xie <ysxie@foxmail.com>
> > Cc: "Micha=C5=82 Miros=C5=82aw" <mirq-linux@rere.qmqm.pl>
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: Rob Clark <robdclark@gmail.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c   | 5 ++---
> >  drivers/video/fbdev/core/fbmem.c   | 3 ---
> >  drivers/video/fbdev/core/fbsysfs.c | 2 --
> >  3 files changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/cor=
e/fbcon.c
> > index f85d794a3bee..c1a7476e980f 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2382,9 +2382,8 @@ static int fbcon_blank(struct vc_data *vc, int bl=
ank, int mode_switch)
> >                       fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
> >                       ops->cursor_flash =3D (!blank);
> >
> > -                     if (!(info->flags & FBINFO_MISC_USEREVENT))
> > -                             if (fb_blank(info, blank))
> > -                                     fbcon_generic_blank(vc, info, bla=
nk);
> > +                     if (fb_blank(info, blank))
> > +                             fbcon_generic_blank(vc, info, blank);
> >               }
> >
> >               if (!blank)
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/cor=
e/fbmem.c
> > index 7f95c7e80155..65a075ccac4a 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1194,10 +1194,7 @@ static long do_fb_ioctl(struct fb_info *info, un=
signed int cmd,
> >       case FBIOBLANK:
> >               console_lock();
> >               lock_fb_info(info);
> > -             info->flags |=3D FBINFO_MISC_USEREVENT;
> >               ret =3D fb_blank(info, arg);
> > -             info->flags &=3D ~FBINFO_MISC_USEREVENT;
> > -
> >               /* might again call into fb_blank */
> >               fbcon_fb_blanked(info, arg);
> >               unlock_fb_info(info);
> > diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/c=
ore/fbsysfs.c
> > index 252d4f52d2a5..882b471d619e 100644
> > --- a/drivers/video/fbdev/core/fbsysfs.c
> > +++ b/drivers/video/fbdev/core/fbsysfs.c
> > @@ -310,9 +310,7 @@ static ssize_t store_blank(struct device *device,
> >
> >       arg =3D simple_strtoul(buf, &last, 0);
> >       console_lock();
> > -     fb_info->flags |=3D FBINFO_MISC_USEREVENT;
> >       err =3D fb_blank(fb_info, arg);
> > -     fb_info->flags &=3D ~FBINFO_MISC_USEREVENT;
> >       /* might again call into fb_blank */
> >       fbcon_fb_blanked(fb_info, arg);
> >       console_unlock();
> > --
> > 2.20.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

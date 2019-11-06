Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E67AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCBB21848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIWeJBPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfKFPXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:23:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39798 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfKFPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:23:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id p18so3229725ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7u4DJelTiLo3xdFi3FzOMpoZhJ7TQZl0WcryvK6J9QA=;
        b=KIWeJBPuhJIAD/GVcGzaGJS+QMkD9/lwi4OA2yEfei4X0kyOd5lkP6owSnmSOlcb//
         hLiDIFY0rOjg6HKi9gqv4i1mNoKNrb8dBXvtBzMZA2i7MMx6PVrbXJ0p+KWjODCSomic
         bkrTkwl9f0CSJRIsIoaXrE0P48aC0jNJKUO9y8oNVlCuHz+wL+pYw5ENACAl3LT1CmyA
         VqI3z37xPuxXCaqWr+z6hv1kenP8OzDUoTEp/y8fcuyX6NX1UZteVbKNqiX5JphUkzzH
         D4FkVVAkZ8n3gw5zy6QzuIBJbHGIFIXKSAbb+v8OMzsIs0+xLlVs6Mfmf5X/T21AURe/
         TBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7u4DJelTiLo3xdFi3FzOMpoZhJ7TQZl0WcryvK6J9QA=;
        b=jogjeP/Z/GV62NcinnB4CcgqIy1GAHzdcuKOEz62cQZIAAJo7WUk/UQmWVnASc4iUR
         EDkVgvriXo+1lvTddBCqFCXndmxb6eDAcOMG4Z43Iv8ieo0g7EAGt3Dl8EXCPAaGWhuR
         E4RxpkV+POu7K9DYBaqalufIc1OBaYX8LWPTc9csun1RnG/X2ooHILYwQ8ygql8t53ED
         sk/rtrgNuwtsuv+Y7J9RMUxlaQZC1cQE4B4FJjmiiXRASeXgw/3VAosWxm8lUL3csHR+
         wvVeHoHXZA6tvn7piXUhCndfL/Vd1Va6XgvGQ3dVewRrh3VGx4PLEAzadaprt5PFPI4+
         OodA==
X-Gm-Message-State: APjAAAXVeeua2Cri5Pg72GfQH6nUJFXOWJD2jGXr3Ku5ofsDXTQBtXax
        BOymRmUziuLEZk8yNho5ahaPx7sXyvE4jS5tKiK8kg==
X-Google-Smtp-Source: APXvYqyrq0kT7d6RQ0yg6I9REVRZIMZLgthEOIGQLGqNlD36KJ255nhNn3PAxsNUoFt5oULhzVOjMIgenQ1hD6OFvFs=
X-Received: by 2002:a2e:9119:: with SMTP id m25mr2475827ljg.24.1573053798616;
 Wed, 06 Nov 2019 07:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20191106094400.445834-1-paul.kocialkowski@bootlin.com> <20191106094400.445834-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20191106094400.445834-2-paul.kocialkowski@bootlin.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 6 Nov 2019 16:23:07 +0100
Message-ID: <CAMeQTsa+tYWAA5vkChqDvEiFmbjFzNp804fD6J4GfLgHUBho9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/gma500: Add missing call to allow enabling vblank
 on psb/cdv
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        James Hilliard <james.hilliard1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 10:44 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This adds a missing call to drm_crtc_vblank_on to the common DPMS helper
> (used by poulsbo and cedartrail), which is called in the CRTC enable path.
>
> With that call, it becomes possible to enable vblank when needed.
> It is already balanced by a drm_crtc_vblank_off call in the helper.
>
> Other platforms (oaktrail and medfield) use a dedicated DPMS helper that
> does not have the proper vblank on/off hooks. They are not added in this
> commit due to lack of hardware to test it with.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Don't think we ever found a need for having vblanks enabled... until
now. I'll have a look if something can be done for Oaktrail since I
have hw.

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

> ---
>  drivers/gpu/drm/gma500/gma_display.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> index e20ccb5d10fd..bc07ae2a9a1d 100644
> --- a/drivers/gpu/drm/gma500/gma_display.c
> +++ b/drivers/gpu/drm/gma500/gma_display.c
> @@ -255,6 +255,8 @@ void gma_crtc_dpms(struct drm_crtc *crtc, int mode)
>                 /* Give the overlay scaler a chance to enable
>                  * if it's on this pipe */
>                 /* psb_intel_crtc_dpms_video(crtc, true); TODO */
> +
> +               drm_crtc_vblank_on(crtc);
>                 break;
>         case DRM_MODE_DPMS_OFF:
>                 if (!gma_crtc->active)
> --
> 2.23.0
>

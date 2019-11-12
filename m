Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BCAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2952196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlbA2lkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKLKUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:20:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35307 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKLKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:20:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id r7so17145313ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 02:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wt2tEGTMbBPb9EywvqOKOcH2ynL0iBFpbMNN4+VttJ0=;
        b=XlbA2lkx5U6xHQpjpbtaPonUBRx8Bgbc9b0c0WsGCtpccg3XNabQSjfxQQMRs7LSy3
         CeEJEksFBroPrS6PWgQTN0XTRgomAjXS8WglIacf4vA7CL73qKqSptdAFrwiIazmgRob
         eJMFRZyuN2xgrDkcOa1epW+7vPZ+o4En9jvvNp3/xqkhqGgalnSPBlre1FjB/GoFsSEt
         xXvhXF6o4D3fdmSq5BdJ8gtMSi72WfQ3Zewzq1QIfdw/cCSAGnuR9Ke9UxQGitkIo3DS
         Enf6jzQVgg2rirgr4fquWQ6GEcJkfCW5pl/D+f6spNU+IzR2emUgHHl01u76fAi67ubk
         NHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wt2tEGTMbBPb9EywvqOKOcH2ynL0iBFpbMNN4+VttJ0=;
        b=OVRrGHfooNiXsXfxsilOR1VJHf8DlHGVLmV5BVi97nqaI9pCdnSIe4Yj1lMtgUMWPD
         8B+aHG3eV4Xn7BrV1xzPTGkS2Qaskh1Xkezhj2IsPZSZaQdB1+LG8Pw6MBXonGye1LKS
         iLAnOFmy2iKAoxYjgCPJIIwyFig9tBdVxXnXI5utijQ+B1rUF4kft4Qjfc0lMJT0QMB5
         MId/qEaBMsYZA5wIUR3HDxZJk45sVp2QWYxysEVRhxnHxVBjR+7QItIulfW/56ft7m5h
         yT6hmFK0F4qj4F/c5L3eUgAJDFzbjdQ3CJkxHE0+G5e7Ib0M6VLKKzFsahYXsuJHSxFV
         X1Iw==
X-Gm-Message-State: APjAAAU3AJTsytiFzQ28p6nqnRZTDxut5gslgOfbPTiROOgk/7jkda+N
        84f5T7mUGb/UX8hDqfWWtKCfSz2K11MS8PjxJkvgBu7H
X-Google-Smtp-Source: APXvYqwLv1QgL2LY5NF5oc3QxBBclz4En9VtQbqxmqlW3vDAlGPhSJ+CTuktQ/HjVllWY5WHsgIXoLqwTbvrEiWLmT8=
X-Received: by 2002:a2e:9e45:: with SMTP id g5mr17502010ljk.58.1573554038403;
 Tue, 12 Nov 2019 02:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20191107153048.843881-1-paul.kocialkowski@bootlin.com>
In-Reply-To: <20191107153048.843881-1-paul.kocialkowski@bootlin.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue, 12 Nov 2019 11:20:27 +0100
Message-ID: <CAMeQTsYG+YvXqQqvJvsxT1h0z5zZJbdCtc5wPjUossvwidV=cA@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Fixup fbdev stolen size usage evaluation
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        James Hilliard <james.hilliard1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 4:30 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> psbfb_probe performs an evaluation of the required size from the stolen
> GTT memory, but gets it wrong in two distinct ways:
> - The resulting size must be page-size-aligned;
> - The size to allocate is derived from the surface dimensions, not the fb
>   dimensions.
>
> When two connectors are connected with different modes, the smallest will
> be stored in the fb dimensions, but the size that needs to be allocated must
> match the largest (surface) dimensions. This is what is used in the actual
> allocation code.
>
> Fix this by correcting the evaluation to conform to the two points above.
> It allows correctly switching to 16bpp when one connector is e.g. 1920x1080
> and the other is 1024x768.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/gma500/framebuffer.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
> index 218f3bb15276..90237abee088 100644
> --- a/drivers/gpu/drm/gma500/framebuffer.c
> +++ b/drivers/gpu/drm/gma500/framebuffer.c
> @@ -462,6 +462,7 @@ static int psbfb_probe(struct drm_fb_helper *helper,
>                 container_of(helper, struct psb_fbdev, psb_fb_helper);
>         struct drm_device *dev = psb_fbdev->psb_fb_helper.dev;
>         struct drm_psb_private *dev_priv = dev->dev_private;
> +       unsigned int fb_size;
>         int bytespp;
>
>         bytespp = sizes->surface_bpp / 8;
> @@ -471,8 +472,11 @@ static int psbfb_probe(struct drm_fb_helper *helper,
>         /* If the mode will not fit in 32bit then switch to 16bit to get
>            a console on full resolution. The X mode setting server will
>            allocate its own 32bit GEM framebuffer */
> -       if (ALIGN(sizes->fb_width * bytespp, 64) * sizes->fb_height >
> -                       dev_priv->vram_stolen_size) {
> +       fb_size = ALIGN(sizes->surface_width * bytespp, 64) *
> +                 sizes->surface_height;
> +       fb_size = ALIGN(fb_size, PAGE_SIZE);
> +
> +       if (fb_size > dev_priv->vram_stolen_size) {

psb_gtt_alloc_range() already aligns by PAGE_SIZE for us. Looks like
we align a couple of times extra for luck. This needs cleaning up
instead of adding even more aligns.

Your size calculation looks correct and indeed makes my 1024x600 +
1920x1080 setup actually display something, but for some reason I get
an incorrect panning on the smaller screen and stale data on the
surface only visible by the larger CRTC. Any idea what's going on?

>                  sizes->surface_bpp = 16;
>                  sizes->surface_depth = 16;
>          }
> --
> 2.23.0
>

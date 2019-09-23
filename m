Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E75C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377C720673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbfIWPMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:12:31 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45495 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfIWPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:12:29 -0400
Received: by mail-ua1-f65.google.com with SMTP id j5so4434956uak.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3kJHh6x6PZgjBD0We03FtFePJ26YGI0fd0dSyGdyrw=;
        b=tiJsBpVMiQZTI+Ynikr8AtIzWl96aHMK84/+l99+SNHx64Ux+HLNN7ibRjGyPFlYie
         W2O/kRYDrLgm+cjbeNj8Ax0M8LD4u65NnywI5EbPVVOUjMslppt5V50Kado6rY/3XOsg
         KtYnDiJa8hHHdhZxSDp5sURq5mKC9/RFydJQx6HSwAiZ+Sw4zajoJ9Ot6hpEQydO6dX4
         9WZYXS7g924bQQ9bZzPG0uPVEGObZml6s6XUNm9bu7ZVmMLLBr/vMd8qBKFL09Twtw0a
         oyFIEd3s+JtGAECN9R6mQO5srjsA7d1iFzCCYstuHd6sIL01FcRwhIEp3KP5bC45kb0K
         ZzlQ==
X-Gm-Message-State: APjAAAXKuUa6wuLrOsTS3gzj7mbX7DFmPKN7vldhMOA08UC5r24pQuds
        6zuC1+2BA/sFq+t/xlNPbGW1/w57YFgbnEghFVU=
X-Google-Smtp-Source: APXvYqzQoQmYenWT7/Rp/GfofyPGwYSQdRq84aMIVrUQrSCxufEIPREpZK2n9BbCiTar8xtgEzovOQ3o2DCwEH89QN4=
X-Received: by 2002:a9f:21f6:: with SMTP id 109mr15199844uac.109.1569251546830;
 Mon, 23 Sep 2019 08:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <1569242880-182878-1-git-send-email-hjc@rock-chips.com> <1569242880-182878-3-git-send-email-hjc@rock-chips.com>
In-Reply-To: <1569242880-182878-3-git-send-email-hjc@rock-chips.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 23 Sep 2019 11:12:15 -0400
Message-ID: <CAKb7Uvgo=93HxGX9F9BvReKbPpbQRozztk0_+GXKqZ3PydCHsA@mail.gmail.com>
Subject: Re: [PATCH 13/36] drm/nouveau: use bpp instead of cpp for drm_format_info
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 8:56 AM Sandy Huang <hjc@rock-chips.com> wrote:
>
> cpp[BytePerPlane] can't describe the 10bit data format correctly,
> So we use bpp[BitPerPlane] to instead cpp.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c     | 7 ++++---
>  drivers/gpu/drm/nouveau/dispnv50/base507c.c | 4 ++--
>  drivers/gpu/drm/nouveau/dispnv50/ovly507e.c | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> index f22f010..59d2f07 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> @@ -874,11 +874,12 @@ nv04_crtc_do_mode_set_base(struct drm_crtc *crtc,
>
>         /* Update the framebuffer location. */
>         regp->fb_start = nv_crtc->fb.offset & ~3;
> -       regp->fb_start += (y * drm_fb->pitches[0]) + (x * drm_fb->format->cpp[0]);
> +       regp->fb_start += (y * drm_fb->pitches[0]) +
> +                               (x * drm_fb->format->bpp[0] / 8);
>         nv_set_crtc_base(dev, nv_crtc->index, regp->fb_start);
>
>         /* Update the arbitration parameters. */
> -       nouveau_calc_arb(dev, crtc->mode.clock, drm_fb->format->cpp[0] * 8,
> +       nouveau_calc_arb(dev, crtc->mode.clock, drm_fb->format->bpp[0],
>                          &arb_burst, &arb_lwm);
>
>         regp->CRTC[NV_CIO_CRE_FF_INDEX] = arb_burst;
> @@ -1238,7 +1239,7 @@ nv04_crtc_page_flip(struct drm_crtc *crtc, struct drm_framebuffer *fb,
>
>         /* Initialize a page flip struct */
>         *s = (struct nv04_page_flip_state)
> -               { { }, event, crtc, fb->format->cpp[0] * 8, fb->pitches[0],
> +               { { }, event, crtc, fb->format->bpp[0], fb->pitches[0],
>                   new_bo->bo.offset };
>
>         /* Keep vblanks on during flip, for the target crtc of this flip */
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/base507c.c b/drivers/gpu/drm/nouveau/dispnv50/base507c.c
> index d5e295c..59883bd0 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/base507c.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/base507c.c
> @@ -190,12 +190,12 @@ base507c_acquire(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw,
>                 return ret;
>
>         if (!wndw->func->ilut) {
> -               if ((asyh->base.cpp != 1) ^ (fb->format->cpp[0] != 1))
> +               if (asyh->base.cpp != 1 ^ fb->format->bpp[0] != 8)

Please leave the parens in. Even if it works out to the same thing
(don't know), ^ vs != ordering isn't fresh in many people's minds
(mine included).

>                         asyh->state.color_mgmt_changed = true;
>         }
>
>         asyh->base.depth = fb->format->depth;
> -       asyh->base.cpp = fb->format->cpp[0];
> +       asyh->base.cpp = fb->format->bpp[0] / 8;
>         asyh->base.x = asyw->state.src.x1 >> 16;
>         asyh->base.y = asyw->state.src.y1 >> 16;
>         asyh->base.w = asyw->state.fb->width;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c b/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c
> index cc41766..c6c2e0b 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/ovly507e.c
> @@ -135,7 +135,7 @@ ovly507e_acquire(struct nv50_wndw *wndw, struct nv50_wndw_atom *asyw,
>         if (ret)
>                 return ret;
>
> -       asyh->ovly.cpp = fb->format->cpp[0];
> +       asyh->ovly.cpp = fb->format->bpp[0] / 8;
>         return 0;
>  }
>
> --
> 2.7.4
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB5C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87782166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2oP6Nva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfKFPZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:25:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46785 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfKFPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:25:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id 19so13193619lft.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kpt1tMqBU2FG8Pm1FbFS5640gv2u5fVbhPUnnmuHCDk=;
        b=K2oP6Nva56UfcPhWfgStsFBYCAsokhE7pf+F3uK3ErR+EInHLPlS9LeCwD00P94dAf
         klz0rDvjuMkE9pNQ49l0FNWsMMLYf6jIWfidO9867TkMHb9053P599iy4mCJVVp/ocB8
         OJEo62ZaVSwPgxnaikGCujPfs/GrRSHZ03c+mYmCTIcsGj/yRweLehJ6HdtUCFypNL1x
         BH8RO0LpxYfmAKu/iLBeIQDz4kv5qBd8E7BuDuWoo8w40O35TG+cW/gtQj0AUyQV2AIA
         R1BegY2dsdYm1QQ7qPqgUxnkpcTIO0SpQhUa6rH3dwZ2uEdsBdtKov87rFgKfDx8GaRl
         mwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kpt1tMqBU2FG8Pm1FbFS5640gv2u5fVbhPUnnmuHCDk=;
        b=KRAssZBk+o3fabYfsTZF5YW5lk7CIAyMMf1e0JTOHsR7wzs7BVSIADnLhrBDmbEubY
         ULPPzczp0G3Rn4omr1l2GUJ4cf0rNPxHGbU7lZz6fOuv/VdcQkmxh5tEXovfzmnw4uS/
         l3gqqJmPzcyjT5JDQG2SCqUypDJJK8CVq2sX0ifNYAnrqurCDilbqnP1zW7OKNiB/3Ya
         bYv9D/sW7rHwdXf0Oz7LVCOw8m3rWR3fhUGsRypNdT9bZrFhQf+1A9SIHH8xR3Oh9NOK
         7mydHXkHFBZUzJ5jFVcRTTmnvw8vh7vzWBenqrZZEXJRL79QjVOc+Xq4/L9jP0fdXuR6
         sByA==
X-Gm-Message-State: APjAAAWZhmbgPXtKTAwy0O/6tjzprHcl9brj0VI2zLtDNYNA9TC8CoTb
        Q2zReyfGkrK6wJ1cqBk+hzthPoTGcO2EKbT1j+U=
X-Google-Smtp-Source: APXvYqx79330Uffd1npteE8w8+65z1biNi0WznSNuwOnl89J7bl0hH3ubXKiE4WDDde6AYS0XW7p5Esokzw77/vnrMk=
X-Received: by 2002:a19:4909:: with SMTP id w9mr1969323lfa.174.1573053909911;
 Wed, 06 Nov 2019 07:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20191106094400.445834-1-paul.kocialkowski@bootlin.com> <20191106094400.445834-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20191106094400.445834-3-paul.kocialkowski@bootlin.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 6 Nov 2019 16:24:59 +0100
Message-ID: <CAMeQTsa=SWXHt8ZvToa9x5qc6W29B6B4Ssvixs3nd-w=+dYGzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/gma500: Add page flip support on psb/cdv
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
> Legacy (non-atomic) page flip support is added to the driver by using the
> mode_set_base CRTC function, that allows configuring a new framebuffer for
> display. Since the function requires the primary plane's fb to be set
> already, this is done prior to calling the function in the page flip helper
> and reverted if the flip fails.
>
> The vblank interrupt handler is also refactored to support passing an event.
> The PIPE_TE_STATUS bit is also considered to indicate vblank on medfield
> only, as explained in psb_enable_vblank.
>
> It was tested by running weston on both poulsbo and cedartrail.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/gma500/cdv_intel_display.c |  1 +
>  drivers/gpu/drm/gma500/gma_display.c       | 46 ++++++++++++++++++++++
>  drivers/gpu/drm/gma500/gma_display.h       |  6 +++
>  drivers/gpu/drm/gma500/psb_intel_display.c |  1 +
>  drivers/gpu/drm/gma500/psb_intel_drv.h     |  3 ++
>  drivers/gpu/drm/gma500/psb_irq.c           | 18 +++++++--
>  6 files changed, 72 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
> index 8b784947ed3b..7109d3d19be0 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> @@ -979,6 +979,7 @@ const struct drm_crtc_funcs cdv_intel_crtc_funcs = {
>         .gamma_set = gma_crtc_gamma_set,
>         .set_config = gma_crtc_set_config,
>         .destroy = gma_crtc_destroy,
> +       .page_flip = gma_crtc_page_flip,
>  };
>
>  const struct gma_clock_funcs cdv_clock_funcs = {
> diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> index bc07ae2a9a1d..17f136985d21 100644
> --- a/drivers/gpu/drm/gma500/gma_display.c
> +++ b/drivers/gpu/drm/gma500/gma_display.c
> @@ -503,6 +503,52 @@ void gma_crtc_destroy(struct drm_crtc *crtc)
>         kfree(gma_crtc);
>  }
>
> +int gma_crtc_page_flip(struct drm_crtc *crtc,
> +                      struct drm_framebuffer *fb,
> +                      struct drm_pending_vblank_event *event,
> +                      uint32_t page_flip_flags,
> +                      struct drm_modeset_acquire_ctx *ctx)
> +{
> +       struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> +       struct drm_framebuffer *current_fb = crtc->primary->fb;
> +       struct drm_framebuffer *old_fb = crtc->primary->old_fb;
> +       const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
> +       struct drm_device *dev = crtc->dev;
> +       unsigned long flags;
> +       int ret;
> +
> +       if (!crtc_funcs->mode_set_base)
> +               return -EINVAL;
> +
> +       /* Using mode_set_base requires the new fb to be set already. */
> +       crtc->primary->fb = fb;
> +
> +       if (event) {
> +               spin_lock_irqsave(&dev->event_lock, flags);
> +
> +               WARN_ON(drm_crtc_vblank_get(crtc) != 0);
> +
> +               gma_crtc->page_flip_event = event;
> +
> +               /* Call this locked if we want an event at vblank interrupt. */
> +               ret = crtc_funcs->mode_set_base(crtc, crtc->x, crtc->y, old_fb);
> +               if (ret) {
> +                       gma_crtc->page_flip_event = NULL;
> +                       drm_crtc_vblank_put(crtc);
> +               }
> +
> +               spin_unlock_irqrestore(&dev->event_lock, flags);
> +       } else {
> +               ret = crtc_funcs->mode_set_base(crtc, crtc->x, crtc->y, old_fb);
> +       }
> +
> +       /* Restore previous fb in case of failure. */
> +       if (ret)
> +               crtc->primary->fb = current_fb;
> +
> +       return ret;
> +}
> +
>  int gma_crtc_set_config(struct drm_mode_set *set,
>                         struct drm_modeset_acquire_ctx *ctx)
>  {
> diff --git a/drivers/gpu/drm/gma500/gma_display.h b/drivers/gpu/drm/gma500/gma_display.h
> index fdbd7ecaa59c..7bd6c1ee8b21 100644
> --- a/drivers/gpu/drm/gma500/gma_display.h
> +++ b/drivers/gpu/drm/gma500/gma_display.h
> @@ -11,6 +11,7 @@
>  #define _GMA_DISPLAY_H_
>
>  #include <linux/pm_runtime.h>
> +#include <drm/drm_vblank.h>
>
>  struct drm_encoder;
>  struct drm_mode_set;
> @@ -71,6 +72,11 @@ extern void gma_crtc_prepare(struct drm_crtc *crtc);
>  extern void gma_crtc_commit(struct drm_crtc *crtc);
>  extern void gma_crtc_disable(struct drm_crtc *crtc);
>  extern void gma_crtc_destroy(struct drm_crtc *crtc);
> +extern int gma_crtc_page_flip(struct drm_crtc *crtc,
> +                             struct drm_framebuffer *fb,
> +                             struct drm_pending_vblank_event *event,
> +                             uint32_t page_flip_flags,
> +                             struct drm_modeset_acquire_ctx *ctx);
>  extern int gma_crtc_set_config(struct drm_mode_set *set,
>                                struct drm_modeset_acquire_ctx *ctx);
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
> index 4256410535f0..fed3b563e62e 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> @@ -432,6 +432,7 @@ const struct drm_crtc_funcs psb_intel_crtc_funcs = {
>         .gamma_set = gma_crtc_gamma_set,
>         .set_config = gma_crtc_set_config,
>         .destroy = gma_crtc_destroy,
> +       .page_flip = gma_crtc_page_flip,
>  };
>
>  const struct gma_clock_funcs psb_clock_funcs = {
> diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
> index cdf10333d1c2..16c6136f778b 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_drv.h
> +++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
> @@ -12,6 +12,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_vblank.h>
>  #include <linux/gpio.h>
>  #include "gma_display.h"
>
> @@ -182,6 +183,8 @@ struct gma_crtc {
>         struct psb_intel_crtc_state *crtc_state;
>
>         const struct gma_clock_funcs *clock_funcs;
> +
> +       struct drm_pending_vblank_event *page_flip_event;
>  };
>
>  #define to_gma_crtc(x) \
> diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
> index e6265fb85626..f787a51f6335 100644
> --- a/drivers/gpu/drm/gma500/psb_irq.c
> +++ b/drivers/gpu/drm/gma500/psb_irq.c
> @@ -165,11 +165,23 @@ static void mid_pipe_event_handler(struct drm_device *dev, int pipe)
>                 "%s, can't clear status bits for pipe %d, its value = 0x%x.\n",
>                 __func__, pipe, PSB_RVDC32(pipe_stat_reg));
>
> -       if (pipe_stat_val & PIPE_VBLANK_STATUS)
> -               drm_handle_vblank(dev, pipe);
> +       if (pipe_stat_val & PIPE_VBLANK_STATUS ||
> +           (IS_MFLD(dev) && pipe_stat_val & PIPE_TE_STATUS)) {
> +               struct drm_crtc *crtc = drm_crtc_from_index(dev, pipe);
> +               struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> +               unsigned long flags;
>
> -       if (pipe_stat_val & PIPE_TE_STATUS)
>                 drm_handle_vblank(dev, pipe);
> +
> +               spin_lock_irqsave(&dev->event_lock, flags);
> +               if (gma_crtc->page_flip_event) {
> +                       drm_crtc_send_vblank_event(crtc,
> +                                                  gma_crtc->page_flip_event);
> +                       gma_crtc->page_flip_event = NULL;
> +                       drm_crtc_vblank_put(crtc);
> +               }
> +               spin_unlock_irqrestore(&dev->event_lock, flags);
> +       }
>  }
>
>  /*
> --
> 2.23.0
>

Looks good!

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

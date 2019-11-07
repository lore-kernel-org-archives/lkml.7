Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A5C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413CC2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBTQVe6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfKGJIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:08:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46162 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733139AbfKGJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:08:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so1342671ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78AExQw87F6j+5cmQyF8HwoVKs76plqSueLpBLiBxSY=;
        b=sBTQVe6lfCi/O3jhcnXoPcLWPL8UvZ0+7MOWos7PeXvZebBoczPYeGUAcybOjdcllO
         byXy65jaMrpox81H52am+4n7uIMv1MtWZDMjK9GOZZQSP4qfrpfX/x7R8hdH5nHgl+bN
         gnGIJKgR0R7e7QqszE3Szy9+tNULNfrdH3qSjvwdCi8jpyJZvlEzZ4IzyqMjbgYUGxIu
         CD85w3ZDY/czsSKKibOo9i1FxqQfi7Elnwo+8A+SmK5FOQwu/W3PV0H8aEhH+3O3kkrn
         ShcXXxcoyRCj7fCgnb6vVgyWNDHS3dCADYnF9zxd3TFOJUdYo5mAZDRpbhSqGbu3LAss
         rPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78AExQw87F6j+5cmQyF8HwoVKs76plqSueLpBLiBxSY=;
        b=qn8CkKHYro2wLGVrEciNzPRozAzX7briuJWUsjPaXk4lotSos6C++amPwqdtDolcLf
         eZzW+8mWAhvz6C562pKN0PCQLcsRGz5OBooppcZaXCyZo/PdJckcod7pGBrRYj4Uyu5G
         KcYCcQU436f40Xe8JUA7pgoueAlMM6p2m1jHDQaX8SagttVASmGzy8Pt8/7Bm6HstbWa
         /RZc4gA4hp+1Kfr77R+7rwRrOyqr4FVe+gD6Kyc1OUaruMvJNvjzD/AfBA3PkWr6aK6W
         W5+9dQ3bEz/WBLkcI57D7XCn0neEF3PUb4SGpGEYgI4NTaejw3ToPiEE29+dndqsxkk0
         GrZw==
X-Gm-Message-State: APjAAAUb/Ot83/VF892AYlp53Mm3y85owDDG+9z3sE4Q/MJ19Rrr7hN1
        VF8DMy4OijSD7UImB5mgGJ9VCALSAzsAH1AJr8E=
X-Google-Smtp-Source: APXvYqxiWO/D0sVPvr380QW2An7LrGN7ck0ITiLwYplgQYiDcIGHEWTDyODHvsqOhrnni4Grr81bK4LPZ2Fi/PKrV78=
X-Received: by 2002:a2e:9119:: with SMTP id m25mr1595563ljg.24.1573117717108;
 Thu, 07 Nov 2019 01:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20191106094400.445834-1-paul.kocialkowski@bootlin.com>
 <20191106094400.445834-3-paul.kocialkowski@bootlin.com> <CAMeQTsa=SWXHt8ZvToa9x5qc6W29B6B4Ssvixs3nd-w=+dYGzA@mail.gmail.com>
 <20191107083140.GJ23790@phenom.ffwll.local>
In-Reply-To: <20191107083140.GJ23790@phenom.ffwll.local>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 7 Nov 2019 10:08:26 +0100
Message-ID: <CAMeQTsZ59B-h8TEyKnc03rz4-aXrAcx3wyWZqDG218Z1RxC5-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/gma500: Add page flip support on psb/cdv
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        James Hilliard <james.hilliard1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 9:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Nov 06, 2019 at 04:24:59PM +0100, Patrik Jakobsson wrote:
> > On Wed, Nov 6, 2019 at 10:44 AM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > >
> > > Legacy (non-atomic) page flip support is added to the driver by using the
> > > mode_set_base CRTC function, that allows configuring a new framebuffer for
> > > display. Since the function requires the primary plane's fb to be set
> > > already, this is done prior to calling the function in the page flip helper
> > > and reverted if the flip fails.
> > >
> > > The vblank interrupt handler is also refactored to support passing an event.
> > > The PIPE_TE_STATUS bit is also considered to indicate vblank on medfield
> > > only, as explained in psb_enable_vblank.
> > >
> > > It was tested by running weston on both poulsbo and cedartrail.
> > >
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/gma500/cdv_intel_display.c |  1 +
> > >  drivers/gpu/drm/gma500/gma_display.c       | 46 ++++++++++++++++++++++
> > >  drivers/gpu/drm/gma500/gma_display.h       |  6 +++
> > >  drivers/gpu/drm/gma500/psb_intel_display.c |  1 +
> > >  drivers/gpu/drm/gma500/psb_intel_drv.h     |  3 ++
> > >  drivers/gpu/drm/gma500/psb_irq.c           | 18 +++++++--
> > >  6 files changed, 72 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
> > > index 8b784947ed3b..7109d3d19be0 100644
> > > --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> > > +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> > > @@ -979,6 +979,7 @@ const struct drm_crtc_funcs cdv_intel_crtc_funcs = {
> > >         .gamma_set = gma_crtc_gamma_set,
> > >         .set_config = gma_crtc_set_config,
> > >         .destroy = gma_crtc_destroy,
> > > +       .page_flip = gma_crtc_page_flip,
> > >  };
> > >
> > >  const struct gma_clock_funcs cdv_clock_funcs = {
> > > diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> > > index bc07ae2a9a1d..17f136985d21 100644
> > > --- a/drivers/gpu/drm/gma500/gma_display.c
> > > +++ b/drivers/gpu/drm/gma500/gma_display.c
> > > @@ -503,6 +503,52 @@ void gma_crtc_destroy(struct drm_crtc *crtc)
> > >         kfree(gma_crtc);
> > >  }
> > >
> > > +int gma_crtc_page_flip(struct drm_crtc *crtc,
> > > +                      struct drm_framebuffer *fb,
> > > +                      struct drm_pending_vblank_event *event,
> > > +                      uint32_t page_flip_flags,
> > > +                      struct drm_modeset_acquire_ctx *ctx)
> > > +{
> > > +       struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> > > +       struct drm_framebuffer *current_fb = crtc->primary->fb;
> > > +       struct drm_framebuffer *old_fb = crtc->primary->old_fb;
> > > +       const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
> > > +       struct drm_device *dev = crtc->dev;
> > > +       unsigned long flags;
> > > +       int ret;
> > > +
> > > +       if (!crtc_funcs->mode_set_base)
> > > +               return -EINVAL;
> > > +
> > > +       /* Using mode_set_base requires the new fb to be set already. */
> > > +       crtc->primary->fb = fb;
> > > +
> > > +       if (event) {
> > > +               spin_lock_irqsave(&dev->event_lock, flags);
> > > +
> > > +               WARN_ON(drm_crtc_vblank_get(crtc) != 0);
> > > +
> > > +               gma_crtc->page_flip_event = event;
> > > +
> > > +               /* Call this locked if we want an event at vblank interrupt. */
> > > +               ret = crtc_funcs->mode_set_base(crtc, crtc->x, crtc->y, old_fb);
> > > +               if (ret) {
> > > +                       gma_crtc->page_flip_event = NULL;
> > > +                       drm_crtc_vblank_put(crtc);
> > > +               }
> > > +
> > > +               spin_unlock_irqrestore(&dev->event_lock, flags);
> > > +       } else {
> > > +               ret = crtc_funcs->mode_set_base(crtc, crtc->x, crtc->y, old_fb);
> > > +       }
> > > +
> > > +       /* Restore previous fb in case of failure. */
> > > +       if (ret)
> > > +               crtc->primary->fb = current_fb;
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  int gma_crtc_set_config(struct drm_mode_set *set,
> > >                         struct drm_modeset_acquire_ctx *ctx)
> > >  {
> > > diff --git a/drivers/gpu/drm/gma500/gma_display.h b/drivers/gpu/drm/gma500/gma_display.h
> > > index fdbd7ecaa59c..7bd6c1ee8b21 100644
> > > --- a/drivers/gpu/drm/gma500/gma_display.h
> > > +++ b/drivers/gpu/drm/gma500/gma_display.h
> > > @@ -11,6 +11,7 @@
> > >  #define _GMA_DISPLAY_H_
> > >
> > >  #include <linux/pm_runtime.h>
> > > +#include <drm/drm_vblank.h>
> > >
> > >  struct drm_encoder;
> > >  struct drm_mode_set;
> > > @@ -71,6 +72,11 @@ extern void gma_crtc_prepare(struct drm_crtc *crtc);
> > >  extern void gma_crtc_commit(struct drm_crtc *crtc);
> > >  extern void gma_crtc_disable(struct drm_crtc *crtc);
> > >  extern void gma_crtc_destroy(struct drm_crtc *crtc);
> > > +extern int gma_crtc_page_flip(struct drm_crtc *crtc,
> > > +                             struct drm_framebuffer *fb,
> > > +                             struct drm_pending_vblank_event *event,
> > > +                             uint32_t page_flip_flags,
> > > +                             struct drm_modeset_acquire_ctx *ctx);
> > >  extern int gma_crtc_set_config(struct drm_mode_set *set,
> > >                                struct drm_modeset_acquire_ctx *ctx);
> > >
> > > diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
> > > index 4256410535f0..fed3b563e62e 100644
> > > --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> > > +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> > > @@ -432,6 +432,7 @@ const struct drm_crtc_funcs psb_intel_crtc_funcs = {
> > >         .gamma_set = gma_crtc_gamma_set,
> > >         .set_config = gma_crtc_set_config,
> > >         .destroy = gma_crtc_destroy,
> > > +       .page_flip = gma_crtc_page_flip,
> > >  };
> > >
> > >  const struct gma_clock_funcs psb_clock_funcs = {
> > > diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
> > > index cdf10333d1c2..16c6136f778b 100644
> > > --- a/drivers/gpu/drm/gma500/psb_intel_drv.h
> > > +++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
> > > @@ -12,6 +12,7 @@
> > >  #include <drm/drm_crtc_helper.h>
> > >  #include <drm/drm_encoder.h>
> > >  #include <drm/drm_probe_helper.h>
> > > +#include <drm/drm_vblank.h>
> > >  #include <linux/gpio.h>
> > >  #include "gma_display.h"
> > >
> > > @@ -182,6 +183,8 @@ struct gma_crtc {
> > >         struct psb_intel_crtc_state *crtc_state;
> > >
> > >         const struct gma_clock_funcs *clock_funcs;
> > > +
> > > +       struct drm_pending_vblank_event *page_flip_event;
> > >  };
> > >
> > >  #define to_gma_crtc(x) \
> > > diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
> > > index e6265fb85626..f787a51f6335 100644
> > > --- a/drivers/gpu/drm/gma500/psb_irq.c
> > > +++ b/drivers/gpu/drm/gma500/psb_irq.c
> > > @@ -165,11 +165,23 @@ static void mid_pipe_event_handler(struct drm_device *dev, int pipe)
> > >                 "%s, can't clear status bits for pipe %d, its value = 0x%x.\n",
> > >                 __func__, pipe, PSB_RVDC32(pipe_stat_reg));
> > >
> > > -       if (pipe_stat_val & PIPE_VBLANK_STATUS)
> > > -               drm_handle_vblank(dev, pipe);
> > > +       if (pipe_stat_val & PIPE_VBLANK_STATUS ||
> > > +           (IS_MFLD(dev) && pipe_stat_val & PIPE_TE_STATUS)) {
> > > +               struct drm_crtc *crtc = drm_crtc_from_index(dev, pipe);
> > > +               struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> > > +               unsigned long flags;
> > >
> > > -       if (pipe_stat_val & PIPE_TE_STATUS)
> > >                 drm_handle_vblank(dev, pipe);
> > > +
> > > +               spin_lock_irqsave(&dev->event_lock, flags);
> > > +               if (gma_crtc->page_flip_event) {
> > > +                       drm_crtc_send_vblank_event(crtc,
> > > +                                                  gma_crtc->page_flip_event);
> > > +                       gma_crtc->page_flip_event = NULL;
> > > +                       drm_crtc_vblank_put(crtc);
> > > +               }
> > > +               spin_unlock_irqrestore(&dev->event_lock, flags);
> > > +       }
> > >  }
> > >
> > >  /*
> > > --
> > > 2.23.0
> > >
> >
> > Looks good!
> >
> > Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
>
> I'm assuming you'll also push these?
>
> Always confusing when maintainer/committers r-b but don't say anything
> about pushing the patch. Good chances it'll fall through cracks if that
> happens.
> -Daniel

Ah sorry, I also find it confusing. I'll push these.

-Patrik

> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

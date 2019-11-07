Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15712C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EC92187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a2E3yMQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbfKGIbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:31:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55777 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:31:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so1441531wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNm6dJzrRMYX4k/I2/IeuLmgKApgz9Wlrz46mUCJtlw=;
        b=a2E3yMQ/cbv6xI+BLoO6wpgtNq8LzdyY3mj//euDFAPMYBAmo+bGTZmTEja0wJLIto
         1K4ailIup2uCkKfntdTKKElou1jRPL7FIgeYsgeVKxVyzNJMwBsphQ3tGvgjzmIXSHYg
         6denNHRTiSlE1vbjO3sEb8U9cuDSWpWbZdCfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=kNm6dJzrRMYX4k/I2/IeuLmgKApgz9Wlrz46mUCJtlw=;
        b=uAUgeZgo79gg/2R6ElpRSL2PualqTe04s7LUOkjjwbd/sti2aYb04Wy0iwPQLNZ6zs
         6Y7vDBCox5asXb/j+syBRDCgxQe/TVgUUHCvz4I0JJgNJfbwVVemK6jDlAWN2q1uT5Nh
         iosIGOVI8kjYItjwnDiC/SapxlMYlNNIvhIJbacCY8VExc7aS60KdyeY3/o8QVDnQXEF
         MdgccnWusx3cFqhT3IYA7DfCccWqYPfsmvLZoCCL27z4ePNnPfv8r0ZhGYnmEeq3hbLY
         y5onvMH81YGkK4SNgK+x1pH7wfb/RC6glvpvHYmFSXLL94AUXKW7si/rpg4Rlrzj0FYd
         mY7Q==
X-Gm-Message-State: APjAAAVGU5/EKMcuuQzKDvv7lpdTZgQgkgJRHmaGKcXVEFQh8IjmYDtU
        /Wu2rAgYw0QsgVxjXrMCk5sapw==
X-Google-Smtp-Source: APXvYqzel5AMUwR60sylWzS3030mPe6fSHaxKepjaLlyOW4FnloapklZvmaQp+yv0IEmyxc4DdB+Hg==
X-Received: by 2002:a05:600c:20c9:: with SMTP id y9mr1593254wmm.72.1573115502604;
        Thu, 07 Nov 2019 00:31:42 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id r19sm2003740wrr.47.2019.11.07.00.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 00:31:41 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:31:40 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        James Hilliard <james.hilliard1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm/gma500: Add page flip support on psb/cdv
Message-ID: <20191107083140.GJ23790@phenom.ffwll.local>
Mail-Followup-To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        James Hilliard <james.hilliard1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20191106094400.445834-1-paul.kocialkowski@bootlin.com>
 <20191106094400.445834-3-paul.kocialkowski@bootlin.com>
 <CAMeQTsa=SWXHt8ZvToa9x5qc6W29B6B4Ssvixs3nd-w=+dYGzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeQTsa=SWXHt8ZvToa9x5qc6W29B6B4Ssvixs3nd-w=+dYGzA@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:24:59PM +0100, Patrik Jakobsson wrote:
> On Wed, Nov 6, 2019 at 10:44 AM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > Legacy (non-atomic) page flip support is added to the driver by using the
> > mode_set_base CRTC function, that allows configuring a new framebuffer for
> > display. Since the function requires the primary plane's fb to be set
> > already, this is done prior to calling the function in the page flip helper
> > and reverted if the flip fails.
> >
> > The vblank interrupt handler is also refactored to support passing an event.
> > The PIPE_TE_STATUS bit is also considered to indicate vblank on medfield
> > only, as explained in psb_enable_vblank.
> >
> > It was tested by running weston on both poulsbo and cedartrail.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/gma500/cdv_intel_display.c |  1 +
> >  drivers/gpu/drm/gma500/gma_display.c       | 46 ++++++++++++++++++++++
> >  drivers/gpu/drm/gma500/gma_display.h       |  6 +++
> >  drivers/gpu/drm/gma500/psb_intel_display.c |  1 +
> >  drivers/gpu/drm/gma500/psb_intel_drv.h     |  3 ++
> >  drivers/gpu/drm/gma500/psb_irq.c           | 18 +++++++--
> >  6 files changed, 72 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
> > index 8b784947ed3b..7109d3d19be0 100644
> > --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> > +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> > @@ -979,6 +979,7 @@ const struct drm_crtc_funcs cdv_intel_crtc_funcs = {
> >         .gamma_set = gma_crtc_gamma_set,
> >         .set_config = gma_crtc_set_config,
> >         .destroy = gma_crtc_destroy,
> > +       .page_flip = gma_crtc_page_flip,
> >  };
> >
> >  const struct gma_clock_funcs cdv_clock_funcs = {
> > diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> > index bc07ae2a9a1d..17f136985d21 100644
> > --- a/drivers/gpu/drm/gma500/gma_display.c
> > +++ b/drivers/gpu/drm/gma500/gma_display.c
> > @@ -503,6 +503,52 @@ void gma_crtc_destroy(struct drm_crtc *crtc)
> >         kfree(gma_crtc);
> >  }
> >
> > +int gma_crtc_page_flip(struct drm_crtc *crtc,
> > +                      struct drm_framebuffer *fb,
> > +                      struct drm_pending_vblank_event *event,
> > +                      uint32_t page_flip_flags,
> > +                      struct drm_modeset_acquire_ctx *ctx)
> > +{
> > +       struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> > +       struct drm_framebuffer *current_fb = crtc->primary->fb;
> > +       struct drm_framebuffer *old_fb = crtc->primary->old_fb;
> > +       const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
> > +       struct drm_device *dev = crtc->dev;
> > +       unsigned long flags;
> > +       int ret;
> > +
> > +       if (!crtc_funcs->mode_set_base)
> > +               return -EINVAL;
> > +
> > +       /* Using mode_set_base requires the new fb to be set already. */
> > +       crtc->primary->fb = fb;
> > +
> > +       if (event) {
> > +               spin_lock_irqsave(&dev->event_lock, flags);
> > +
> > +               WARN_ON(drm_crtc_vblank_get(crtc) != 0);
> > +
> > +               gma_crtc->page_flip_event = event;
> > +
> > +               /* Call this locked if we want an event at vblank interrupt. */
> > +               ret = crtc_funcs->mode_set_base(crtc, crtc->x, crtc->y, old_fb);
> > +               if (ret) {
> > +                       gma_crtc->page_flip_event = NULL;
> > +                       drm_crtc_vblank_put(crtc);
> > +               }
> > +
> > +               spin_unlock_irqrestore(&dev->event_lock, flags);
> > +       } else {
> > +               ret = crtc_funcs->mode_set_base(crtc, crtc->x, crtc->y, old_fb);
> > +       }
> > +
> > +       /* Restore previous fb in case of failure. */
> > +       if (ret)
> > +               crtc->primary->fb = current_fb;
> > +
> > +       return ret;
> > +}
> > +
> >  int gma_crtc_set_config(struct drm_mode_set *set,
> >                         struct drm_modeset_acquire_ctx *ctx)
> >  {
> > diff --git a/drivers/gpu/drm/gma500/gma_display.h b/drivers/gpu/drm/gma500/gma_display.h
> > index fdbd7ecaa59c..7bd6c1ee8b21 100644
> > --- a/drivers/gpu/drm/gma500/gma_display.h
> > +++ b/drivers/gpu/drm/gma500/gma_display.h
> > @@ -11,6 +11,7 @@
> >  #define _GMA_DISPLAY_H_
> >
> >  #include <linux/pm_runtime.h>
> > +#include <drm/drm_vblank.h>
> >
> >  struct drm_encoder;
> >  struct drm_mode_set;
> > @@ -71,6 +72,11 @@ extern void gma_crtc_prepare(struct drm_crtc *crtc);
> >  extern void gma_crtc_commit(struct drm_crtc *crtc);
> >  extern void gma_crtc_disable(struct drm_crtc *crtc);
> >  extern void gma_crtc_destroy(struct drm_crtc *crtc);
> > +extern int gma_crtc_page_flip(struct drm_crtc *crtc,
> > +                             struct drm_framebuffer *fb,
> > +                             struct drm_pending_vblank_event *event,
> > +                             uint32_t page_flip_flags,
> > +                             struct drm_modeset_acquire_ctx *ctx);
> >  extern int gma_crtc_set_config(struct drm_mode_set *set,
> >                                struct drm_modeset_acquire_ctx *ctx);
> >
> > diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
> > index 4256410535f0..fed3b563e62e 100644
> > --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> > +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> > @@ -432,6 +432,7 @@ const struct drm_crtc_funcs psb_intel_crtc_funcs = {
> >         .gamma_set = gma_crtc_gamma_set,
> >         .set_config = gma_crtc_set_config,
> >         .destroy = gma_crtc_destroy,
> > +       .page_flip = gma_crtc_page_flip,
> >  };
> >
> >  const struct gma_clock_funcs psb_clock_funcs = {
> > diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
> > index cdf10333d1c2..16c6136f778b 100644
> > --- a/drivers/gpu/drm/gma500/psb_intel_drv.h
> > +++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
> > @@ -12,6 +12,7 @@
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_probe_helper.h>
> > +#include <drm/drm_vblank.h>
> >  #include <linux/gpio.h>
> >  #include "gma_display.h"
> >
> > @@ -182,6 +183,8 @@ struct gma_crtc {
> >         struct psb_intel_crtc_state *crtc_state;
> >
> >         const struct gma_clock_funcs *clock_funcs;
> > +
> > +       struct drm_pending_vblank_event *page_flip_event;
> >  };
> >
> >  #define to_gma_crtc(x) \
> > diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
> > index e6265fb85626..f787a51f6335 100644
> > --- a/drivers/gpu/drm/gma500/psb_irq.c
> > +++ b/drivers/gpu/drm/gma500/psb_irq.c
> > @@ -165,11 +165,23 @@ static void mid_pipe_event_handler(struct drm_device *dev, int pipe)
> >                 "%s, can't clear status bits for pipe %d, its value = 0x%x.\n",
> >                 __func__, pipe, PSB_RVDC32(pipe_stat_reg));
> >
> > -       if (pipe_stat_val & PIPE_VBLANK_STATUS)
> > -               drm_handle_vblank(dev, pipe);
> > +       if (pipe_stat_val & PIPE_VBLANK_STATUS ||
> > +           (IS_MFLD(dev) && pipe_stat_val & PIPE_TE_STATUS)) {
> > +               struct drm_crtc *crtc = drm_crtc_from_index(dev, pipe);
> > +               struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> > +               unsigned long flags;
> >
> > -       if (pipe_stat_val & PIPE_TE_STATUS)
> >                 drm_handle_vblank(dev, pipe);
> > +
> > +               spin_lock_irqsave(&dev->event_lock, flags);
> > +               if (gma_crtc->page_flip_event) {
> > +                       drm_crtc_send_vblank_event(crtc,
> > +                                                  gma_crtc->page_flip_event);
> > +                       gma_crtc->page_flip_event = NULL;
> > +                       drm_crtc_vblank_put(crtc);
> > +               }
> > +               spin_unlock_irqrestore(&dev->event_lock, flags);
> > +       }
> >  }
> >
> >  /*
> > --
> > 2.23.0
> >
> 
> Looks good!
> 
> Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

I'm assuming you'll also push these?

Always confusing when maintainer/committers r-b but don't say anything
about pushing the patch. Good chances it'll fall through cracks if that
happens.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

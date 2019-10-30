Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C2DCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A712054F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2Nypfcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfJ3Q7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:59:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45546 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfJ3Q7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:59:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id x21so4117228qto.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMqDFxiAkQCaeJz8lKyiQDxleaMGXTHCEPFv7QgGNJ4=;
        b=Q2NypfcsGeSrDgFhup1I4LSDl9lhYuMHaafn5KLyhvWy08EneC/ZBVQhkw4fW8SHmX
         7Um0jLmGcspVjhRi13aWU8KTXBb/A0ZP5QWl83janNDy3AqugqNXE2F4A4owtD63K659
         ChNLHG9eJdriWW26G+e55cRSDdhm+AS2hgIZGPtPKfwNObOqvY34qgU1wmNyRaJR47SU
         n8+5G1xnmroEQQt6uyJlhIE+eKn7Idy3xNupERXhRbp0u0T/SgNeBLiSPmtnMVXdSNHj
         JWfr4WAX2FJcndfmde0DJ+84D/7705hAzeug0kcdH1DVMDiQZeLHE4Lzu35Rc8NYydRE
         KcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMqDFxiAkQCaeJz8lKyiQDxleaMGXTHCEPFv7QgGNJ4=;
        b=Uzgi5XeqMg6fzQz+rvSJyQw6rzZwMvjl9/m4uyyaAAIcKHzz99wqwuG5qrqfNws1Mh
         AaFu3ttHTJyzPkud5P6sF9KYbXxeanCtqGFi1CMq4GINNUWhWp20dQXdVQngceHOSYB2
         dUwj61LHlj4w4u651phfdqdorASoUEMztdWf6Ry5VOYhXCjF4+OLfQws67TaXHiagzp8
         2Jr3+95FcziTteBv8oSpkg1iy1zMpC6i0MtYw4RqrdyNGKXFS0VhjTieZid8U3KBGrOV
         2YXX9fJSxJHsVq3l4RTfRJm8ffIL4ujlm5JTwZ7qZCGGJwQO5UfVzUWey7prSeWKLhZY
         ifNg==
X-Gm-Message-State: APjAAAUmujKpyE9q2MFnMZvu+VFpV2YmtlmzXMxC1S5Bv++WjkkURO5w
        vRcwilUOuTY9/Dw5KaRIrMnhd1ZFBQc6vGKrlhA=
X-Google-Smtp-Source: APXvYqziHaqPLgZQqpJK0IQ8Rlq3w2D1c/+HwxuZvdtKQSUj/G4mSZJyp9qhjERZ0V2YAPmEn6G2drrL7jdmHN/lWtU=
X-Received: by 2002:ac8:3168:: with SMTP id h37mr1097149qtb.311.1572454768002;
 Wed, 30 Oct 2019 09:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190918200734.149876-1-sean@poorly.run> <20190918200734.149876-2-sean@poorly.run>
 <20190919141413.GU218215@art_vandelay>
In-Reply-To: <20190919141413.GU218215@art_vandelay>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 30 Oct 2019 17:59:16 +0100
Message-ID: <CAFqH_53iQt0o9keRQLyqx-B=bni37bkTACF=wBKgSLOLz-hw4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Measure Self Refresh Entry/Exit times to
 avoid thrashing
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>, jekarl@iki.fi,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Since 5.4-rc1 my Samsung Chromebook Plus (kevin) doesn't
suspend/resume correctly, at least once every ten suspend/resume
cycles the display doesn't turn on, and when this happens the kernel
log message reports:

[   60.420230] PM: suspend exit
[   60.463866] rockchip-dp ff970000.edp: AUX CH cmd reply timeout!
[   60.971653] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   61.478668] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   61.985661] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   62.492644] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   62.999617] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   63.506595] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   64.013678] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   64.522856] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   60.463866] rockchip-dp ff970000.edp: AUX CH cmd reply timeout!
[   60.971653] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   61.478668] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   61.985661] rockchip-dp ff970000.edp: AUX CH enable timeout!
[   62.492644] rockchip-dp ff970000.edp: AUX CH enable timeout!
...

Today I bisected the problem and pointed me to this commit. Reverting
the commit fixes the issue, but from I quick look I don't see any
obvious problem. I'll spend more time tomorrow looking at this but any
idea will be welcome.

Thanks,
 Enric

Missatge de Sean Paul <sean@poorly.run> del dia dj., 19 de set. 2019 a
les 16:14:
>
> On Wed, Sep 18, 2019 at 04:07:29PM -0400, Sean Paul wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> >
> > Currently the self refresh idle timer is a const set by the crtc. This
> > is fine if the self refresh entry/exit times are well-known for all
> > panels used on that crtc. However panels and workloads can vary quite a
> > bit, and a timeout which works well for one doesn't work well for
> > another.
> >
> > In the extreme, if the timeout is too short we could get in a situation
> > where the self refresh exits are taking so long we queue up a self refresh
> > entry before the exit commit is even finished.
> >
> > This patch changes the idle timeout to a moving average of the entry
> > times + a moving average of exit times + the crtc constant.
> >
> > This patch was tested on rockchip, with a kevin CrOS panel the idle
> > delay averages out to about ~235ms (35 entry + 100 exit + 100 const). On
> > the same board, the bob panel idle delay lands around ~340ms (90 entry
> > + 150 exit + 100 const).
> >
> > WRT the dedicated mutex in self_refresh_data, it would be nice if we
> > could rely on drm_crtc.mutex to protect the average times, but there are
> > a few reasons why a separate lock is a better choice:
> > - We can't rely on drm_crtc.mutex being held if we're doing a nonblocking
> >   commit
> > - We can't grab drm_crtc.mutex since drm_modeset_lock() doesn't tell us
> >   whether the lock was already held in the acquire context (it eats
> >   -EALREADY), so we can't tell if we should drop it or not
> > - We don't need such a heavy-handed lock for what we're trying to do,
> >   commit ordering doesn't matter, so a point-of-use lock will be less
> >   contentious
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Pushed the first 2 to drm-misc-next-fixes to fix the gru-bob regression. I'll
> fix up the 3rd patch separately.
>
> Thank you for the reviews!
>
> Sean
>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190917200443.64481-2-sean@poorly.run
> >
> > Changes in v2:
> > - Migrate locking explanation from comment to commit msg (Daniel)
> > - Turf constant entry delay and multiply the avg times by 2 (Daniel)
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c         | 20 ++++++
> >  drivers/gpu/drm/drm_self_refresh_helper.c   | 72 +++++++++++++++++++--
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  5 +-
> >  include/drm/drm_self_refresh_helper.h       |  6 +-
> >  4 files changed, 90 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 9d7e4da6c292..3f13fa9a9e24 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -26,6 +26,7 @@
> >   */
> >
> >  #include <linux/dma-fence.h>
> > +#include <linux/ktime.h>
> >
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > @@ -1570,9 +1571,23 @@ static void commit_tail(struct drm_atomic_state *old_state)
> >  {
> >       struct drm_device *dev = old_state->dev;
> >       const struct drm_mode_config_helper_funcs *funcs;
> > +     ktime_t start;
> > +     s64 commit_time_ms;
> >
> >       funcs = dev->mode_config.helper_private;
> >
> > +     /*
> > +      * We're measuring the _entire_ commit, so the time will vary depending
> > +      * on how many fences and objects are involved. For the purposes of self
> > +      * refresh, this is desirable since it'll give us an idea of how
> > +      * congested things are. This will inform our decision on how often we
> > +      * should enter self refresh after idle.
> > +      *
> > +      * These times will be averaged out in the self refresh helpers to avoid
> > +      * overreacting over one outlier frame
> > +      */
> > +     start = ktime_get();
> > +
> >       drm_atomic_helper_wait_for_fences(dev, old_state, false);
> >
> >       drm_atomic_helper_wait_for_dependencies(old_state);
> > @@ -1582,6 +1597,11 @@ static void commit_tail(struct drm_atomic_state *old_state)
> >       else
> >               drm_atomic_helper_commit_tail(old_state);
> >
> > +     commit_time_ms = ktime_ms_delta(ktime_get(), start);
> > +     if (commit_time_ms > 0)
> > +             drm_self_refresh_helper_update_avg_times(old_state,
> > +                                              (unsigned long)commit_time_ms);
> > +
> >       drm_atomic_helper_commit_cleanup_done(old_state);
> >
> >       drm_atomic_state_put(old_state);
> > diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
> > index 9095cebf2147..68f4765a5896 100644
> > --- a/drivers/gpu/drm/drm_self_refresh_helper.c
> > +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
> > @@ -5,6 +5,7 @@
> >   * Authors:
> >   * Sean Paul <seanpaul@chromium.org>
> >   */
> > +#include <linux/average.h>
> >  #include <linux/bitops.h>
> >  #include <linux/slab.h>
> >  #include <linux/workqueue.h>
> > @@ -50,10 +51,17 @@
> >   * atomic_check when &drm_crtc_state.self_refresh_active is true.
> >   */
> >
> > +#define SELF_REFRESH_AVG_SEED_MS 200
> > +
> > +DECLARE_EWMA(psr_time, 4, 4)
> > +
> >  struct drm_self_refresh_data {
> >       struct drm_crtc *crtc;
> >       struct delayed_work entry_work;
> > -     unsigned int entry_delay_ms;
> > +
> > +     struct mutex avg_mutex;
> > +     struct ewma_psr_time entry_avg_ms;
> > +     struct ewma_psr_time exit_avg_ms;
> >  };
> >
> >  static void drm_self_refresh_helper_entry_work(struct work_struct *work)
> > @@ -121,6 +129,44 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
> >       drm_modeset_acquire_fini(&ctx);
> >  }
> >
> > +/**
> > + * drm_self_refresh_helper_update_avg_times - Updates a crtc's SR time averages
> > + * @state: the state which has just been applied to hardware
> > + * @commit_time_ms: the amount of time in ms that this commit took to complete
> > + *
> > + * Called after &drm_mode_config_funcs.atomic_commit_tail, this function will
> > + * update the average entry/exit self refresh times on self refresh transitions.
> > + * These averages will be used when calculating how long to delay before
> > + * entering self refresh mode after activity.
> > + */
> > +void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> > +                                           unsigned int commit_time_ms)
> > +{
> > +     struct drm_crtc *crtc;
> > +     struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> > +     int i;
> > +
> > +     for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> > +                                   new_crtc_state, i) {
> > +             struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
> > +             struct ewma_psr_time *time;
> > +
> > +             if (old_crtc_state->self_refresh_active ==
> > +                 new_crtc_state->self_refresh_active)
> > +                     continue;
> > +
> > +             if (new_crtc_state->self_refresh_active)
> > +                     time = &sr_data->entry_avg_ms;
> > +             else
> > +                     time = &sr_data->exit_avg_ms;
> > +
> > +             mutex_lock(&sr_data->avg_mutex);
> > +             ewma_psr_time_add(time, commit_time_ms);
> > +             mutex_unlock(&sr_data->avg_mutex);
> > +     }
> > +}
> > +EXPORT_SYMBOL(drm_self_refresh_helper_update_avg_times);
> > +
> >  /**
> >   * drm_self_refresh_helper_alter_state - Alters the atomic state for SR exit
> >   * @state: the state currently being checked
> > @@ -152,6 +198,7 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
> >
> >       for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> >               struct drm_self_refresh_data *sr_data;
> > +             unsigned int delay;
> >
> >               /* Don't trigger the entry timer when we're already in SR */
> >               if (crtc_state->self_refresh_active)
> > @@ -161,8 +208,13 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
> >               if (!sr_data)
> >                       continue;
> >
> > +             mutex_lock(&sr_data->avg_mutex);
> > +             delay = (ewma_psr_time_read(&sr_data->entry_avg_ms) +
> > +                      ewma_psr_time_read(&sr_data->exit_avg_ms)) * 2;
> > +             mutex_unlock(&sr_data->avg_mutex);
> > +
> >               mod_delayed_work(system_wq, &sr_data->entry_work,
> > -                              msecs_to_jiffies(sr_data->entry_delay_ms));
> > +                              msecs_to_jiffies(delay));
> >       }
> >  }
> >  EXPORT_SYMBOL(drm_self_refresh_helper_alter_state);
> > @@ -170,12 +222,10 @@ EXPORT_SYMBOL(drm_self_refresh_helper_alter_state);
> >  /**
> >   * drm_self_refresh_helper_init - Initializes self refresh helpers for a crtc
> >   * @crtc: the crtc which supports self refresh supported displays
> > - * @entry_delay_ms: amount of inactivity to wait before entering self refresh
> >   *
> >   * Returns zero if successful or -errno on failure
> >   */
> > -int drm_self_refresh_helper_init(struct drm_crtc *crtc,
> > -                              unsigned int entry_delay_ms)
> > +int drm_self_refresh_helper_init(struct drm_crtc *crtc)
> >  {
> >       struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
> >
> > @@ -189,8 +239,18 @@ int drm_self_refresh_helper_init(struct drm_crtc *crtc,
> >
> >       INIT_DELAYED_WORK(&sr_data->entry_work,
> >                         drm_self_refresh_helper_entry_work);
> > -     sr_data->entry_delay_ms = entry_delay_ms;
> >       sr_data->crtc = crtc;
> > +     mutex_init(&sr_data->avg_mutex);
> > +     ewma_psr_time_init(&sr_data->entry_avg_ms);
> > +     ewma_psr_time_init(&sr_data->exit_avg_ms);
> > +
> > +     /*
> > +      * Seed the averages so they're non-zero (and sufficiently large
> > +      * for even poorly performing panels). As time goes on, this will be
> > +      * averaged out and the values will trend to their true value.
> > +      */
> > +     ewma_psr_time_add(&sr_data->entry_avg_ms, SELF_REFRESH_AVG_SEED_MS);
> > +     ewma_psr_time_add(&sr_data->exit_avg_ms, SELF_REFRESH_AVG_SEED_MS);
> >
> >       crtc->self_refresh_data = sr_data;
> >       return 0;
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > index 2f821c58007c..613404f86668 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -39,8 +39,6 @@
> >  #include "rockchip_drm_vop.h"
> >  #include "rockchip_rgb.h"
> >
> > -#define VOP_SELF_REFRESH_ENTRY_DELAY_MS 100
> > -
> >  #define VOP_WIN_SET(vop, win, name, v) \
> >               vop_reg_set(vop, &win->phy->name, win->base, ~0, v, #name)
> >  #define VOP_SCL_SET(vop, win, name, v) \
> > @@ -1563,8 +1561,7 @@ static int vop_create_crtc(struct vop *vop)
> >       init_completion(&vop->line_flag_completion);
> >       crtc->port = port;
> >
> > -     ret = drm_self_refresh_helper_init(crtc,
> > -                                        VOP_SELF_REFRESH_ENTRY_DELAY_MS);
> > +     ret = drm_self_refresh_helper_init(crtc);
> >       if (ret)
> >               DRM_DEV_DEBUG_KMS(vop->dev,
> >                       "Failed to init %s with SR helpers %d, ignoring\n",
> > diff --git a/include/drm/drm_self_refresh_helper.h b/include/drm/drm_self_refresh_helper.h
> > index 397a583ccca7..5b79d253fb46 100644
> > --- a/include/drm/drm_self_refresh_helper.h
> > +++ b/include/drm/drm_self_refresh_helper.h
> > @@ -12,9 +12,9 @@ struct drm_atomic_state;
> >  struct drm_crtc;
> >
> >  void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state);
> > +void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> > +                                           unsigned int commit_time_ms);
> >
> > -int drm_self_refresh_helper_init(struct drm_crtc *crtc,
> > -                              unsigned int entry_delay_ms);
> > -
> > +int drm_self_refresh_helper_init(struct drm_crtc *crtc);
> >  void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc);
> >  #endif
> > --
> > Sean Paul, Software Engineer, Google / Chromium OS
> >
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

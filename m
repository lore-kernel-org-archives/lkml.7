Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04ADC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5424C20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHFILQCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfKFDrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:47:11 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39629 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:47:10 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so13589442ioj.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2H/vfY+M3FOVI8nyc1KajqzdWqSXMeNKABjk0rdQL0=;
        b=YHFILQCp/WqkCCA/t3E5TZqDHrrZL0ezjrzpHcw8xJd/nT4G4Cov+gxz6SmCFE/cij
         9BNwJ62Azjuuo+MFxfXeBcRjneHg1rluxOFicfqjSD/DLMv1RCTlh2Qyg/nkHkYT5V9n
         Qjdyn0JZaL4uG6byGwnWrnkNocwPBsZrIuBSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2H/vfY+M3FOVI8nyc1KajqzdWqSXMeNKABjk0rdQL0=;
        b=NnkuqdWMslmPX6qRiCVcR9dc7nv0J7J6CJlFe/pNOeAq4o/ypSv+NRPecSF67pRl1X
         e/Ls6joSIf/bKFheg5i4tb1IgG1f7EQfeWRwWkJEJPYF7oMZBd0E4tU5bt6VZl1YMvoM
         QwJHT/mAepcXklG8/XIUZFIjgFc6qLgP7W+2s6zlU17zrUTOh7PquemFyoqyqzGKb7jF
         MSeXn0X78kPeZCWEyCuPQnAawMTvzs/cpFsyKVUQl9RTYRqQQ1nWL3Z4wFJdgH6jTufN
         1zgajv5BwlwcBV4CJC8Y6kLO7QAzJ50sxVaD7rwwwwuPy9BwlX/Jj/fIVLN6hngO/72v
         DmvQ==
X-Gm-Message-State: APjAAAV6Q12mHaggc1xUq5t0xHxQx1BqnSKKnBXg41armjtAMgw2AFbd
        O19qQEsxlX85ee36UcMEnrwlo1JmB5+DynQi/gt+mg==
X-Google-Smtp-Source: APXvYqzM4v8A7/KdBti0Vuh47ZVMEZFBED5Uz6EFt/lWzRoGkj9v0kX9qfllxewVAnd9O0epfOmwy6yqBkGg6SO1Zv4=
X-Received: by 2002:a02:742a:: with SMTP id o42mr25123417jac.24.1573012029823;
 Tue, 05 Nov 2019 19:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20191104173737.142558-1-robdclark@gmail.com>
In-Reply-To: <20191104173737.142558-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Tue, 5 Nov 2019 19:46:59 -0800
Message-ID: <CAJs_Fx4qbQXdDmxB4-F+vJTBr7y2YkSvGbOVGid6T1=HGZer6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] drm/atomic: fix self-refresh helpers crtc state dereference
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 9:39 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> drm_self_refresh_helper_update_avg_times() was incorrectly accessing the
> new incoming state after drm_atomic_helper_commit_hw_done().  But this
> state might have already been superceeded by an !nonblock atomic update
> resulting in dereferencing an already free'd crtc_state.
>
> TODO I *think* this will more or less do the right thing.. althought I'm
> not 100% sure if, for example, we enter psr in a nonblock commit, and
> then leave psr in a !nonblock commit that overtakes the completion of
> the nonblock commit.  Not sure if this sort of scenario can happen in
> practice.  But not crashing is better than crashing, so I guess we
> should either take this patch or rever the self-refresh helpers until
> Sean can figure out a better solution.

btw, I think we can drop this TODO para from the commit msg.. but
would be nice to get this (1/2) landed in v5.4-fixes as it fixes an
actual regressions..

patch 2/2 probably shouldn't be for v5.4, since according to kbuild
robot it is turning up some other problems.. but I still think it is
probably a good idea

BR,
-R

>
> Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c       | 14 +++++++++++++-
>  drivers/gpu/drm/drm_self_refresh_helper.c | 15 +++++++++------
>  include/drm/drm_self_refresh_helper.h     |  3 ++-
>  3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 3ef2ac52ce94..648494c813e5 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1581,8 +1581,11 @@ static void commit_tail(struct drm_atomic_state *old_state)
>  {
>         struct drm_device *dev = old_state->dev;
>         const struct drm_mode_config_helper_funcs *funcs;
> +       struct drm_crtc_state *new_crtc_state;
> +       struct drm_crtc *crtc;
>         ktime_t start;
>         s64 commit_time_ms;
> +       unsigned i, new_self_refresh_mask = 0;
>
>         funcs = dev->mode_config.helper_private;
>
> @@ -1602,6 +1605,14 @@ static void commit_tail(struct drm_atomic_state *old_state)
>
>         drm_atomic_helper_wait_for_dependencies(old_state);
>
> +       /*
> +        * We cannot safely access new_crtc_state after drm_atomic_helper_commit_hw_done()
> +        * so figure out which crtc's have self-refresh active beforehand:
> +        */
> +       for_each_new_crtc_in_state(old_state, crtc, new_crtc_state, i)
> +               if (new_crtc_state->self_refresh_active)
> +                       new_self_refresh_mask |= BIT(i);
> +
>         if (funcs && funcs->atomic_commit_tail)
>                 funcs->atomic_commit_tail(old_state);
>         else
> @@ -1610,7 +1621,8 @@ static void commit_tail(struct drm_atomic_state *old_state)
>         commit_time_ms = ktime_ms_delta(ktime_get(), start);
>         if (commit_time_ms > 0)
>                 drm_self_refresh_helper_update_avg_times(old_state,
> -                                                (unsigned long)commit_time_ms);
> +                                                (unsigned long)commit_time_ms,
> +                                                new_self_refresh_mask);
>
>         drm_atomic_helper_commit_cleanup_done(old_state);
>
> diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
> index 68f4765a5896..011b8d5f7dd6 100644
> --- a/drivers/gpu/drm/drm_self_refresh_helper.c
> +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
> @@ -133,6 +133,8 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>   * drm_self_refresh_helper_update_avg_times - Updates a crtc's SR time averages
>   * @state: the state which has just been applied to hardware
>   * @commit_time_ms: the amount of time in ms that this commit took to complete
> + * @new_self_refresh_mask: bitmask of crtc's that have self_refresh_active in
> + *    new state
>   *
>   * Called after &drm_mode_config_funcs.atomic_commit_tail, this function will
>   * update the average entry/exit self refresh times on self refresh transitions.
> @@ -140,22 +142,23 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>   * entering self refresh mode after activity.
>   */
>  void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> -                                             unsigned int commit_time_ms)
> +                                             unsigned int commit_time_ms,
> +                                             unsigned int new_self_refresh_mask)
>  {
>         struct drm_crtc *crtc;
> -       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +       struct drm_crtc_state *old_crtc_state;
>         int i;
>
> -       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> -                                     new_crtc_state, i) {
> +       for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
> +               bool new_self_refresh_active = new_self_refresh_mask & BIT(i);
>                 struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
>                 struct ewma_psr_time *time;
>
>                 if (old_crtc_state->self_refresh_active ==
> -                   new_crtc_state->self_refresh_active)
> +                   new_self_refresh_active)
>                         continue;
>
> -               if (new_crtc_state->self_refresh_active)
> +               if (new_self_refresh_active)
>                         time = &sr_data->entry_avg_ms;
>                 else
>                         time = &sr_data->exit_avg_ms;
> diff --git a/include/drm/drm_self_refresh_helper.h b/include/drm/drm_self_refresh_helper.h
> index 5b79d253fb46..b2c08b328aa1 100644
> --- a/include/drm/drm_self_refresh_helper.h
> +++ b/include/drm/drm_self_refresh_helper.h
> @@ -13,7 +13,8 @@ struct drm_crtc;
>
>  void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state);
>  void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> -                                             unsigned int commit_time_ms);
> +                                             unsigned int commit_time_ms,
> +                                             unsigned int new_self_refresh_mask);
>
>  int drm_self_refresh_helper_init(struct drm_crtc *crtc);
>  void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc);
> --
> 2.23.0
>

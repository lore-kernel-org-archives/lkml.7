Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A498CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0B12053B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Hg7SwH8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKAUHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:07:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43526 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfKAUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:07:05 -0400
Received: by mail-io1-f68.google.com with SMTP id c11so12133102iom.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9XbHQUSxDq9B2fBuL9mDt+Zz+PE63ygUr4teBcOseY=;
        b=Hg7SwH8Os7Mt6Hy5Uhc0YprZslXlv3Ffm9C6jPfxEHM2Ognx2JG+/k69EhxhCjVV3p
         DxA17xvbkTRBGClk7UCA62LE3l+9O0GmKVqNgjbnZ0voqByFL6KL18CU5cJQcffecmmr
         +HCyerf1ruUnvbA7D3QD7oWcMPjRjH1rRHqPSMJG+ILWH5FEB5hEYc0q3GTmlLUWBImn
         uuAUzGzdJQR6IhBrEBH9glsmaWhJ5Z/DcWnxLb9elJ5Xzn4hqi69EsJg8JMRcb9YE/fI
         57T3s4sr3T+f+OeTmHIIpHNZ80jQm3BdYtkRZglRhmwKZSM52CvnDcCYeB+oDDu3CtV3
         /wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9XbHQUSxDq9B2fBuL9mDt+Zz+PE63ygUr4teBcOseY=;
        b=H2cJYhEEXmuQIyDQT/E8AOvmmeFU97EodqwVzgQPPjZ4ct+Xh5HIijPkA10kSXGnik
         PnLk9Gks0p3M/pKUWf7zOQo/nchxIZNANtr8/7/S0lcny4vwhOmFeFRsHtk+Y1xV7PBU
         QKe8Rja30EHShNCvHDpF030MfB5CIgBa41ISh6tUZDdR4fcH135pUMjnb7j49UrDo2nM
         0nWhqi20Q+FF4tnYFJbldRMeEs2rM80GixbO5Hyk6CqAdE8t8ZIf0eH5ZbjdlIHDRPNf
         2stl3rdAbrKiM6JwtErJAxzhrXSxlkD6UnW6bkORWFI+L+0Uv3zFKO2XuXrlQZffJJiF
         ocoA==
X-Gm-Message-State: APjAAAXy6QBHt/3O06FabUJaBkVE+Jd4dZcm6Urpz4s5epB5tMfqqLj1
        5+keERYEkJmtd1qlVqkI3wxVREeYrP+Hac2mqFt7PA==
X-Google-Smtp-Source: APXvYqy5n1vXsytW26bqTvpzaABeBZZwvUCZ1vuhjQ9ddqyBcvJTAEptTluBPDHwD+Uc3eNC9nM15zbChm4srlB/2JY=
X-Received: by 2002:a6b:b4ca:: with SMTP id d193mr12235813iof.71.1572638823824;
 Fri, 01 Nov 2019 13:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191101180713.5470-1-robdclark@gmail.com>
In-Reply-To: <20191101180713.5470-1-robdclark@gmail.com>
From:   Sean Paul <sean@poorly.run>
Date:   Fri, 1 Nov 2019 16:06:28 -0400
Message-ID: <CAMavQKKMjge6MwH=-DS5Ngs8ZE5G_x_Vncy+YoqYrC0s0AfX=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/atomic: fix self-refresh helpers crtc state dereference
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 2:09 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> drm_self_refresh_helper_update_avg_times() was incorrectly accessing the
> new incoming state after drm_atomic_helper_commit_hw_done().  But this
> state might have already been superceeded by an !nonblock atomic update
> resulting in dereferencing an already free'd crtc_state.
>
> Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> TODO I *think* this will more or less do the right thing.. althought I'm
> not 100% sure if, for example, we enter psr in a nonblock commit, and
> then leave psr in a !nonblock commit that overtakes the completion of
> the nonblock commit.  Not sure if this sort of scenario can happen in
> practice.  But not crashing is better than crashing, so I guess we
> should either take this patch or rever the self-refresh helpers until
> Sean can figure out a better solution.
>
>  drivers/gpu/drm/drm_atomic_helper.c       |  2 ++
>  drivers/gpu/drm/drm_self_refresh_helper.c | 11 ++++++-----
>  include/drm/drm_atomic.h                  |  8 ++++++++
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 3ef2ac52ce94..732bd0ce9241 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2240,6 +2240,8 @@ void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
>         int i;
>
>         for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> +               old_state->crtcs[i].new_self_refresh_active = new_crtc_state->self_refresh_active;
> +
>                 commit = new_crtc_state->commit;
>                 if (!commit)
>                         continue;
> diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
> index 68f4765a5896..77b9079fa578 100644
> --- a/drivers/gpu/drm/drm_self_refresh_helper.c
> +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
> @@ -143,19 +143,20 @@ void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
>                                               unsigned int commit_time_ms)
>  {
>         struct drm_crtc *crtc;
> -       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +       struct drm_crtc_state *old_crtc_state;
>         int i;
>
> -       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> -                                     new_crtc_state, i) {
> +       for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
> +               bool new_self_refresh_active =
> +                               state->crtcs[i].new_self_refresh_active;
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
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 927e1205d7aa..86baf2b38bb3 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -155,6 +155,14 @@ struct __drm_crtcs_state {
>         struct drm_crtc *ptr;
>         struct drm_crtc_state *state, *old_state, *new_state;
>
> +       /**
> +        * @new_self_refresh_active:
> +        *
> +        * drm_atomic_helper_commit_hw_done() stashes new_crtc_state->self_refresh_active
> +        * so that it can be accessed late in drm_self_refresh_helper_update_avg_times().
> +        */
> +       bool new_self_refresh_active;
> +

Instead of stashing this in crtc, we could generate a bitmask local to
commit_tail and pass that to calc_avg_times? That way we don't have to
worry about someone using this when they shouldn't

Sean

>         /**
>          * @commit:
>          *
> --
> 2.21.0
>

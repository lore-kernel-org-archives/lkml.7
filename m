Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76845C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B15217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="cIfRAAiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfKFS6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:58:18 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39321 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKFS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:58:18 -0500
Received: by mail-yw1-f65.google.com with SMTP id k127so9950186ywc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0MXcH0+MhIAIwCsst+sUwWj3vWo2sspD8l9LQIiuDn8=;
        b=cIfRAAiC4qOCBoT4IlNmmCOs9EQ2pN4IhUvbQsdYXeFHylavkdQGeKM/3wVCba+aGL
         6MUuR52YYvyBqz1Y0YG56AwHc3EnAy2Tu5xAqyEkdpBXibfAET4SUObouTM5Mnygu15K
         ZWZPG0S/E7/dBd3Hr31G70u1SvmduxPKYYy6NVJNLPlPEmyZAv/Mz18+8BBm6IpAPVrA
         iTryLGi9BxvHLgrgsj0XCESANItuSjZfPLcHV5bjHKT/aiqnm5KfXd3st1OSocvTdDuR
         eA07Qzwnd/RcfAeahaxQd/rQL0DJJOw7TLyIFZ+O1CfMEdNV4jc4xp1pj8wcp31nkvZZ
         oXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0MXcH0+MhIAIwCsst+sUwWj3vWo2sspD8l9LQIiuDn8=;
        b=FC9QqfmZHL4sTXB09WE2HbU2gIZSZKG6ln8bqN85b2Bygho8cRElNwt/jyKtD6uWya
         OaWYeiNK8W9T9rzXlQ9fscTD55oLfV92akh4BmZWt+aPMTPUmrw3bLyn9EQWhWhOs/jb
         Ytev3Xq847dNtkGsNeCwYghVEr6t3orV+iu55USqidYJraZkIh7r2kDrq2ofTwsHJ+8s
         xrBYu3oiqfmxQ3p+vby1C4R/69zuy2+QbAizloB44jBoq4g3eXKvIM3KYXz1gvnT+1Es
         WsTPt9KTXCHteJk9aSCxL0H7t+V0tKk3iEMrthP7TIPtcwJe0UMhXQTclACBCemOty2A
         8v/Q==
X-Gm-Message-State: APjAAAXbo7RlHXAAVSJxZK8XJM5fMgda5kB6lLF0F04Qyhc8CXLP06Pb
        6PJvopZSYuO/IdTeEMz9Ur5K2g==
X-Google-Smtp-Source: APXvYqyoHGhHZ2Tokg56LUX7ZhWl32oT4TeFymTsLfThNayr5cMfbJBNkoJ+AUyPbHDYSJLaFfpniQ==
X-Received: by 2002:a81:5b03:: with SMTP id p3mr2658691ywb.189.1573066696343;
        Wed, 06 Nov 2019 10:58:16 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k62sm7166332ywd.72.2019.11.06.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 10:58:15 -0800 (PST)
Date:   Wed, 6 Nov 2019 13:58:14 -0500
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] drm/atomic: fix self-refresh helpers crtc state
 dereference
Message-ID: <20191106185814.GD63329@art_vandelay>
References: <20191104173737.142558-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104173737.142558-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 09:37:36AM -0800, Rob Clark wrote:
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
> 
> Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Thanks for tracking this down, Rob. I gave it a spin on my rk3399 kevin and it
behaved as expected.

I've pushed this patch to drm-misc-fixes in hopes it'll catch 5.4

Sean

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
>  	struct drm_device *dev = old_state->dev;
>  	const struct drm_mode_config_helper_funcs *funcs;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_crtc *crtc;
>  	ktime_t start;
>  	s64 commit_time_ms;
> +	unsigned i, new_self_refresh_mask = 0;
>  
>  	funcs = dev->mode_config.helper_private;
>  
> @@ -1602,6 +1605,14 @@ static void commit_tail(struct drm_atomic_state *old_state)
>  
>  	drm_atomic_helper_wait_for_dependencies(old_state);
>  
> +	/*
> +	 * We cannot safely access new_crtc_state after drm_atomic_helper_commit_hw_done()
> +	 * so figure out which crtc's have self-refresh active beforehand:
> +	 */
> +	for_each_new_crtc_in_state(old_state, crtc, new_crtc_state, i)
> +		if (new_crtc_state->self_refresh_active)
> +			new_self_refresh_mask |= BIT(i);
> +
>  	if (funcs && funcs->atomic_commit_tail)
>  		funcs->atomic_commit_tail(old_state);
>  	else
> @@ -1610,7 +1621,8 @@ static void commit_tail(struct drm_atomic_state *old_state)
>  	commit_time_ms = ktime_ms_delta(ktime_get(), start);
>  	if (commit_time_ms > 0)
>  		drm_self_refresh_helper_update_avg_times(old_state,
> -						 (unsigned long)commit_time_ms);
> +						 (unsigned long)commit_time_ms,
> +						 new_self_refresh_mask);
>  
>  	drm_atomic_helper_commit_cleanup_done(old_state);
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
> -					      unsigned int commit_time_ms)
> +					      unsigned int commit_time_ms,
> +					      unsigned int new_self_refresh_mask)
>  {
>  	struct drm_crtc *crtc;
> -	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	struct drm_crtc_state *old_crtc_state;
>  	int i;
>  
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> -				      new_crtc_state, i) {
> +	for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
> +		bool new_self_refresh_active = new_self_refresh_mask & BIT(i);
>  		struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
>  		struct ewma_psr_time *time;
>  
>  		if (old_crtc_state->self_refresh_active ==
> -		    new_crtc_state->self_refresh_active)
> +		    new_self_refresh_active)
>  			continue;
>  
> -		if (new_crtc_state->self_refresh_active)
> +		if (new_self_refresh_active)
>  			time = &sr_data->entry_avg_ms;
>  		else
>  			time = &sr_data->exit_avg_ms;
> diff --git a/include/drm/drm_self_refresh_helper.h b/include/drm/drm_self_refresh_helper.h
> index 5b79d253fb46..b2c08b328aa1 100644
> --- a/include/drm/drm_self_refresh_helper.h
> +++ b/include/drm/drm_self_refresh_helper.h
> @@ -13,7 +13,8 @@ struct drm_crtc;
>  
>  void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state);
>  void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> -					      unsigned int commit_time_ms);
> +					      unsigned int commit_time_ms,
> +					      unsigned int new_self_refresh_mask);
>  
>  int drm_self_refresh_helper_init(struct drm_crtc *crtc);
>  void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc);
> -- 
> 2.23.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

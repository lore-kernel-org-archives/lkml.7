Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEACC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527362067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="fpN3uw4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfISOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:14:15 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33197 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbfISOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:14:15 -0400
Received: by mail-yw1-f67.google.com with SMTP id i188so868442ywf.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=udmOyjd9D9tkFljgvi3r1XrIW/XfmorOvAaN7s+8Jwc=;
        b=fpN3uw4uMXsVCezAjyNW9ur4T/pM6qJb5e5n7XGGJT2qSrDhkNkfgnDxJ9KmlBNQPB
         p0hAx5NW9K5Hq5XDqWTdvHuA6lTLTFDCxijZZpZTqickdBBlvmIUexdUxX15HPnVLZxw
         Wq+HizWLYftCTSKiPDmsEE/8EUAP/YgIH44FPvc783K07en1rxX7f3lH8KI84SvRrX4r
         Sk4E7QxyYHYSiX5/2GikWfvc5Q/Kjh5BGUTBuhCOsHJ9AkQyuFDXMI2uXdY2jaR2Jk41
         6oOmPqXmarqNl1Ee3KHYlIUBdNwL/F84RBYG47UxIhjncPGdS90FbhA6O66w0j6UDWun
         vkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=udmOyjd9D9tkFljgvi3r1XrIW/XfmorOvAaN7s+8Jwc=;
        b=LoTtnW/JoBVORH5EqCjieb1ZBJaMueMKTLM/d4JiqJWObrmWtVCQ9EKi3nadpbz3nP
         6MjYCuoijtYJ9PnA34Gnb917SNIvbRGDLzyAfq8TPBJR9seBUE9Wj89LqXfiLkeUX7zK
         XY4TwQM3FwO50tkQp2A868Cnz/cApt97dgbpVTMPdn/3kR61OVRx5zn1AZ0NfL8kG8Em
         et+sojpmRBWsN6oF7UpVbU3R/bKgsaBJZWbP8XZnMNVnIWN7ASqQepee28HwYcRtOt2R
         TAll+VeW6ll1u93E7grqb+vpDke2ORbGu/8Ax09plCNh448lSWO3IX4wGQz5BHvd0oT2
         /2Cg==
X-Gm-Message-State: APjAAAWcTMeRY9U+iPDybkXZNrqdp7Z/gUgYa1m66IjTVthREVbenkep
        TYBbeyCLmlLriOKLpjhD7BaxnGBOnKmP+Q==
X-Google-Smtp-Source: APXvYqyIrM/I2o6POD5dYaVuNOMphdTt9P9xMiGUBl7nZ1fEtJ9pCoBZy7YCeft7N+10PTFz7M/TMQ==
X-Received: by 2002:a0d:c907:: with SMTP id l7mr7869011ywd.246.1568902454106;
        Thu, 19 Sep 2019 07:14:14 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id h136sm1947725ywc.83.2019.09.19.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:14:13 -0700 (PDT)
Date:   Thu, 19 Sep 2019 10:14:13 -0400
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     heiko@sntech.de, jekarl@iki.fi, daniel@ffwll.ch,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] drm: Measure Self Refresh Entry/Exit times to
 avoid thrashing
Message-ID: <20190919141413.GU218215@art_vandelay>
References: <20190918200734.149876-1-sean@poorly.run>
 <20190918200734.149876-2-sean@poorly.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918200734.149876-2-sean@poorly.run>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 04:07:29PM -0400, Sean Paul wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Currently the self refresh idle timer is a const set by the crtc. This
> is fine if the self refresh entry/exit times are well-known for all
> panels used on that crtc. However panels and workloads can vary quite a
> bit, and a timeout which works well for one doesn't work well for
> another.
> 
> In the extreme, if the timeout is too short we could get in a situation
> where the self refresh exits are taking so long we queue up a self refresh
> entry before the exit commit is even finished.
> 
> This patch changes the idle timeout to a moving average of the entry
> times + a moving average of exit times + the crtc constant.
> 
> This patch was tested on rockchip, with a kevin CrOS panel the idle
> delay averages out to about ~235ms (35 entry + 100 exit + 100 const). On
> the same board, the bob panel idle delay lands around ~340ms (90 entry
> + 150 exit + 100 const).
> 
> WRT the dedicated mutex in self_refresh_data, it would be nice if we
> could rely on drm_crtc.mutex to protect the average times, but there are
> a few reasons why a separate lock is a better choice:
> - We can't rely on drm_crtc.mutex being held if we're doing a nonblocking
>   commit
> - We can't grab drm_crtc.mutex since drm_modeset_lock() doesn't tell us
>   whether the lock was already held in the acquire context (it eats
>   -EALREADY), so we can't tell if we should drop it or not
> - We don't need such a heavy-handed lock for what we're trying to do,
>   commit ordering doesn't matter, so a point-of-use lock will be less
>   contentious
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Pushed the first 2 to drm-misc-next-fixes to fix the gru-bob regression. I'll
fix up the 3rd patch separately.

Thank you for the reviews!

Sean

> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190917200443.64481-2-sean@poorly.run
> 
> Changes in v2:
> - Migrate locking explanation from comment to commit msg (Daniel)
> - Turf constant entry delay and multiply the avg times by 2 (Daniel)
> ---
>  drivers/gpu/drm/drm_atomic_helper.c         | 20 ++++++
>  drivers/gpu/drm/drm_self_refresh_helper.c   | 72 +++++++++++++++++++--
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  5 +-
>  include/drm/drm_self_refresh_helper.h       |  6 +-
>  4 files changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 9d7e4da6c292..3f13fa9a9e24 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -26,6 +26,7 @@
>   */
>  
>  #include <linux/dma-fence.h>
> +#include <linux/ktime.h>
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -1570,9 +1571,23 @@ static void commit_tail(struct drm_atomic_state *old_state)
>  {
>  	struct drm_device *dev = old_state->dev;
>  	const struct drm_mode_config_helper_funcs *funcs;
> +	ktime_t start;
> +	s64 commit_time_ms;
>  
>  	funcs = dev->mode_config.helper_private;
>  
> +	/*
> +	 * We're measuring the _entire_ commit, so the time will vary depending
> +	 * on how many fences and objects are involved. For the purposes of self
> +	 * refresh, this is desirable since it'll give us an idea of how
> +	 * congested things are. This will inform our decision on how often we
> +	 * should enter self refresh after idle.
> +	 *
> +	 * These times will be averaged out in the self refresh helpers to avoid
> +	 * overreacting over one outlier frame
> +	 */
> +	start = ktime_get();
> +
>  	drm_atomic_helper_wait_for_fences(dev, old_state, false);
>  
>  	drm_atomic_helper_wait_for_dependencies(old_state);
> @@ -1582,6 +1597,11 @@ static void commit_tail(struct drm_atomic_state *old_state)
>  	else
>  		drm_atomic_helper_commit_tail(old_state);
>  
> +	commit_time_ms = ktime_ms_delta(ktime_get(), start);
> +	if (commit_time_ms > 0)
> +		drm_self_refresh_helper_update_avg_times(old_state,
> +						 (unsigned long)commit_time_ms);
> +
>  	drm_atomic_helper_commit_cleanup_done(old_state);
>  
>  	drm_atomic_state_put(old_state);
> diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
> index 9095cebf2147..68f4765a5896 100644
> --- a/drivers/gpu/drm/drm_self_refresh_helper.c
> +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
> @@ -5,6 +5,7 @@
>   * Authors:
>   * Sean Paul <seanpaul@chromium.org>
>   */
> +#include <linux/average.h>
>  #include <linux/bitops.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> @@ -50,10 +51,17 @@
>   * atomic_check when &drm_crtc_state.self_refresh_active is true.
>   */
>  
> +#define SELF_REFRESH_AVG_SEED_MS 200
> +
> +DECLARE_EWMA(psr_time, 4, 4)
> +
>  struct drm_self_refresh_data {
>  	struct drm_crtc *crtc;
>  	struct delayed_work entry_work;
> -	unsigned int entry_delay_ms;
> +
> +	struct mutex avg_mutex;
> +	struct ewma_psr_time entry_avg_ms;
> +	struct ewma_psr_time exit_avg_ms;
>  };
>  
>  static void drm_self_refresh_helper_entry_work(struct work_struct *work)
> @@ -121,6 +129,44 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>  	drm_modeset_acquire_fini(&ctx);
>  }
>  
> +/**
> + * drm_self_refresh_helper_update_avg_times - Updates a crtc's SR time averages
> + * @state: the state which has just been applied to hardware
> + * @commit_time_ms: the amount of time in ms that this commit took to complete
> + *
> + * Called after &drm_mode_config_funcs.atomic_commit_tail, this function will
> + * update the average entry/exit self refresh times on self refresh transitions.
> + * These averages will be used when calculating how long to delay before
> + * entering self refresh mode after activity.
> + */
> +void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> +					      unsigned int commit_time_ms)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	int i;
> +
> +	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> +				      new_crtc_state, i) {
> +		struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
> +		struct ewma_psr_time *time;
> +
> +		if (old_crtc_state->self_refresh_active ==
> +		    new_crtc_state->self_refresh_active)
> +			continue;
> +
> +		if (new_crtc_state->self_refresh_active)
> +			time = &sr_data->entry_avg_ms;
> +		else
> +			time = &sr_data->exit_avg_ms;
> +
> +		mutex_lock(&sr_data->avg_mutex);
> +		ewma_psr_time_add(time, commit_time_ms);
> +		mutex_unlock(&sr_data->avg_mutex);
> +	}
> +}
> +EXPORT_SYMBOL(drm_self_refresh_helper_update_avg_times);
> +
>  /**
>   * drm_self_refresh_helper_alter_state - Alters the atomic state for SR exit
>   * @state: the state currently being checked
> @@ -152,6 +198,7 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
>  
>  	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
>  		struct drm_self_refresh_data *sr_data;
> +		unsigned int delay;
>  
>  		/* Don't trigger the entry timer when we're already in SR */
>  		if (crtc_state->self_refresh_active)
> @@ -161,8 +208,13 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
>  		if (!sr_data)
>  			continue;
>  
> +		mutex_lock(&sr_data->avg_mutex);
> +		delay = (ewma_psr_time_read(&sr_data->entry_avg_ms) +
> +			 ewma_psr_time_read(&sr_data->exit_avg_ms)) * 2;
> +		mutex_unlock(&sr_data->avg_mutex);
> +
>  		mod_delayed_work(system_wq, &sr_data->entry_work,
> -				 msecs_to_jiffies(sr_data->entry_delay_ms));
> +				 msecs_to_jiffies(delay));
>  	}
>  }
>  EXPORT_SYMBOL(drm_self_refresh_helper_alter_state);
> @@ -170,12 +222,10 @@ EXPORT_SYMBOL(drm_self_refresh_helper_alter_state);
>  /**
>   * drm_self_refresh_helper_init - Initializes self refresh helpers for a crtc
>   * @crtc: the crtc which supports self refresh supported displays
> - * @entry_delay_ms: amount of inactivity to wait before entering self refresh
>   *
>   * Returns zero if successful or -errno on failure
>   */
> -int drm_self_refresh_helper_init(struct drm_crtc *crtc,
> -				 unsigned int entry_delay_ms)
> +int drm_self_refresh_helper_init(struct drm_crtc *crtc)
>  {
>  	struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
>  
> @@ -189,8 +239,18 @@ int drm_self_refresh_helper_init(struct drm_crtc *crtc,
>  
>  	INIT_DELAYED_WORK(&sr_data->entry_work,
>  			  drm_self_refresh_helper_entry_work);
> -	sr_data->entry_delay_ms = entry_delay_ms;
>  	sr_data->crtc = crtc;
> +	mutex_init(&sr_data->avg_mutex);
> +	ewma_psr_time_init(&sr_data->entry_avg_ms);
> +	ewma_psr_time_init(&sr_data->exit_avg_ms);
> +
> +	/*
> +	 * Seed the averages so they're non-zero (and sufficiently large
> +	 * for even poorly performing panels). As time goes on, this will be
> +	 * averaged out and the values will trend to their true value.
> +	 */
> +	ewma_psr_time_add(&sr_data->entry_avg_ms, SELF_REFRESH_AVG_SEED_MS);
> +	ewma_psr_time_add(&sr_data->exit_avg_ms, SELF_REFRESH_AVG_SEED_MS);
>  
>  	crtc->self_refresh_data = sr_data;
>  	return 0;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 2f821c58007c..613404f86668 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -39,8 +39,6 @@
>  #include "rockchip_drm_vop.h"
>  #include "rockchip_rgb.h"
>  
> -#define VOP_SELF_REFRESH_ENTRY_DELAY_MS 100
> -
>  #define VOP_WIN_SET(vop, win, name, v) \
>  		vop_reg_set(vop, &win->phy->name, win->base, ~0, v, #name)
>  #define VOP_SCL_SET(vop, win, name, v) \
> @@ -1563,8 +1561,7 @@ static int vop_create_crtc(struct vop *vop)
>  	init_completion(&vop->line_flag_completion);
>  	crtc->port = port;
>  
> -	ret = drm_self_refresh_helper_init(crtc,
> -					   VOP_SELF_REFRESH_ENTRY_DELAY_MS);
> +	ret = drm_self_refresh_helper_init(crtc);
>  	if (ret)
>  		DRM_DEV_DEBUG_KMS(vop->dev,
>  			"Failed to init %s with SR helpers %d, ignoring\n",
> diff --git a/include/drm/drm_self_refresh_helper.h b/include/drm/drm_self_refresh_helper.h
> index 397a583ccca7..5b79d253fb46 100644
> --- a/include/drm/drm_self_refresh_helper.h
> +++ b/include/drm/drm_self_refresh_helper.h
> @@ -12,9 +12,9 @@ struct drm_atomic_state;
>  struct drm_crtc;
>  
>  void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state);
> +void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> +					      unsigned int commit_time_ms);
>  
> -int drm_self_refresh_helper_init(struct drm_crtc *crtc,
> -				 unsigned int entry_delay_ms);
> -
> +int drm_self_refresh_helper_init(struct drm_crtc *crtc);
>  void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc);
>  #endif
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

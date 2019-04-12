Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38056C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA89F2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLNkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:40:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:40:03 -0400
Received: from [IPv6:2804:431:9718:a5e8:c168:522a:50d5:d06d] (unknown [IPv6:2804:431:9718:a5e8:c168:522a:50d5:d06d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E1B692813A9;
        Fri, 12 Apr 2019 14:39:48 +0100 (BST)
Subject: Re: [PATCH RFC v3 4/4] drm/atomic: hook atomic_async_{check,update}
 with PAGE_FLIP_ASYNC flag
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, daniels@collabora.com,
        alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>,
        tina.zhang@intel.com, boris.brezillon@collabora.com,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        nicholas.kazlauskas@amd.com,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Eric Anholt <eric@anholt.net>, Leo Li <sunpeng.li@amd.com>,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        David Francis <David.Francis@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <20190412125827.5877-1-helen.koike@collabora.com>
 <20190412125827.5877-5-helen.koike@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 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
Message-ID: <6bd78124-8758-d642-7235-ffb772ce4694@collabora.com>
Date:   Fri, 12 Apr 2019 10:39:40 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190412125827.5877-5-helen.koike@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/19 9:58 AM, Helen Koike wrote:
> Add atomic_async_{check,update} hooks in drm_plane_helper_funcs.
> These hooks are called when userspace requests asyncronous page flip in
> the atomic api through the flag DRM_MODE_PAGE_FLIP_ASYNC.
> 
> Update those hooks in the drivers that implement async functions, except
> for amdgpu who handles the flag in the normal path, and rockchip who
> doesn't support async page flip.
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> Hi,
> 
> This patch is an attempt to expose the implementation that already exist
> for true async page flips updates through atomic api when the
> DRM_MODE_PAGE_FLIP_ASYNC is used.
> 
> In this commit I'm re-introducing the atomic_async_{check,update} hooks.
> I know it is a bit weird to remove them first and them re-add them, but
> I did this in the last commit to avoid any state of inconsistency
> between commits, as rockchip doesn't support async page flip and they were
> being used as amend.
> So I reverted to amend first and then re-introced async again
> tied to the DRM_MODE_PAGE_FLIP_ASYNC flag (I also think this is easier
> to read).
> 
> To use async, it is required to have
> dev->mode_config.async_page_flip = true;
> but I see that only amdgpu and vc4 have this, so this patch won't take
> effect on mdp5.
> Nouveau and radeon also have this flag, but they don't implement the
> async hooks yet.
> 
> Please let me know what you think.
> 
> Thanks
> Helen
> 
> Changes in v3: None
> Changes in v2: None
> Changes in v1: None
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++
>  drivers/gpu/drm/drm_atomic_helper.c           | 31 ++++++++++++----
>  drivers/gpu/drm/drm_atomic_uapi.c             |  3 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |  2 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  4 ++
>  drivers/gpu/drm/vc4/vc4_plane.c               |  2 +
>  include/drm/drm_atomic.h                      |  2 +
>  include/drm/drm_atomic_helper.h               |  9 +++--
>  include/drm/drm_modeset_helper_vtables.h      | 37 +++++++++++++++++++
>  9 files changed, 83 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 711e7715e112..bb8a5f1997d6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3785,6 +3785,11 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
>  	 */
>  	.atomic_amend_check = dm_plane_atomic_async_check,
>  	.atomic_amend_update = dm_plane_atomic_async_update
> +	/*
> +	 * Note: amdgpu takes care of DRM_MODE_PAGE_FLIP_ASYNC flag in the
> +	 * normal commit path, thus .atomic_async_check and .atomic_async_update
> +	 * are not provided here.
> +	 */
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 9b0df08836c3..bfcf88359de5 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -947,16 +947,31 @@ int drm_atomic_helper_check(struct drm_device *dev,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * If async page flip was explicitly requested, but it is not possible,
> +	 * return error instead of falling back to a normal commit.
> +	 * If async_amend_check returns -EOPNOTSUPP, it means
> +	 * ->atomic_async_update hook doesn't exist, so fallback to normal
> +	 *  commit and let the driver handle DRM_MODE_PAGE_FLIP_ASYNC flag
> +	 *  through normal commit code path.
> +	 */
> +	if (state->async_update) {
> +		ret = drm_atomic_helper_async_amend_check(dev, state, false);
> +		state->async_update = !ret;
> +		return !ret || ret == -EOPNOTSUPP ? 0 : ret;
> +	}
> +
>  	/*
>  	 * If amend was explicitly requested, but it is not possible,
>  	 * return error instead of falling back to a normal commit.
>  	 */
>  	if (state->amend_update)
> -		return drm_atomic_helper_amend_check(dev, state);
> +		return drm_atomic_helper_async_amend_check(dev, state, true);
>  
>  	/* Legacy mode falls back to a normal commit if amend isn't possible. */
>  	if (state->legacy_cursor_update)
> -		state->amend_update = !drm_atomic_helper_amend_check(dev, state);
> +		state->amend_update =
> +			!drm_atomic_helper_async_amend_check(dev, state, true);
>  
>  	return 0;
>  }
> @@ -1651,8 +1666,9 @@ static void commit_work(struct work_struct *work)
>   * if not. Note that error just mean it can't be committed in amend mode, if it
>   * fails the commit should be treated like a normal commit.
>   */
> -int drm_atomic_helper_amend_check(struct drm_device *dev,
> -				   struct drm_atomic_state *state)
> +int drm_atomic_helper_async_amend_check(struct drm_device *dev,
> +					struct drm_atomic_state *state,
> +					bool amend)
>  {
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *crtc_state;
> @@ -1695,7 +1711,7 @@ int drm_atomic_helper_amend_check(struct drm_device *dev,
>  		return -EINVAL;
>  

Sorry, I forgot a modif here:

-       if (!funcs->atomic_amend_update)
-               return -EINVAL;
+       if ((amend && !funcs->atomic_amend_update) ||
+           !funcs->atomic_async_update)
+               return -EOPNOTSUPP;

I need to return -EOPNOTSUPP so I can know if async should fallback to
the normal async path, this is required for amdgpu as it handles the
PAGE_FLIP_ASYNC flag it self.

I'll correct this in the next version after your comments.

You can also see the series on
https://gitlab.collabora.com/koike/linux/commits/drm/amend/uapi

Thanks


>  	/* Only allow amend update for cursor type planes. */
> -	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> +	if (amend && plane->type != DRM_PLANE_TYPE_CURSOR)
>  		return -EINVAL;
>  
>  	/*
> @@ -1707,9 +1723,10 @@ int drm_atomic_helper_amend_check(struct drm_device *dev,
>  	    !try_wait_for_completion(&old_plane_state->commit->hw_done))
>  		return -EBUSY;
>  
> -	return funcs->atomic_amend_check(plane, new_plane_state);
> +	return amend ? funcs->atomic_amend_check(plane, new_plane_state) :
> +		       funcs->atomic_async_check(plane, new_plane_state);
>  }
> -EXPORT_SYMBOL(drm_atomic_helper_amend_check);
> +EXPORT_SYMBOL(drm_atomic_helper_async_amend_check);
>  
>  /**
>   * drm_atomic_helper_amend_commit - commit state in amend mode
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index d1962cdea602..1d9a6142218e 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1312,8 +1312,9 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
>  	state->acquire_ctx = &ctx;
>  	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
> +	state->async_update = !!(arg->flags & DRM_MODE_PAGE_FLIP_ASYNC);
>  	/* async takes precedence over amend */
> -	state->amend_update = arg->flags & DRM_MODE_PAGE_FLIP_ASYNC ? 0 :
> +	state->amend_update = state->async_update ? 0 :
>  					!!(arg->flags & DRM_MODE_ATOMIC_AMEND);
>  
>  retry:
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> index 814e8230cec6..e3b2a2c74852 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> @@ -531,6 +531,8 @@ static const struct drm_plane_helper_funcs mdp5_plane_helper_funcs = {
>  		.cleanup_fb = mdp5_plane_cleanup_fb,
>  		.atomic_check = mdp5_plane_atomic_check,
>  		.atomic_update = mdp5_plane_atomic_update,
> +		.atomic_async_check = mdp5_plane_atomic_async_check,
> +		.atomic_async_update = mdp5_plane_atomic_async_update,
>  		/*
>  		 * FIXME: ideally, instead of hooking async updates to amend,
>  		 * we could avoid tearing by modifying the pending commit.
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 216ad76118dc..c2f7201e52a9 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -954,6 +954,10 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
>  	.atomic_disable = vop_plane_atomic_disable,
>  	.atomic_amend_check = vop_plane_atomic_amend_check,
>  	.atomic_amend_update = vop_plane_atomic_amend_update,
> +	/*
> +	 * Note: rockchip doesn't support async page flip, thus
> +	 * .atomic_async_update and .atomic_async_check are not provided.
> +	 */
>  	.prepare_fb = drm_gem_fb_prepare_fb,
>  };
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index ea560000222d..24a9befe89e6 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -1175,6 +1175,8 @@ static const struct drm_plane_helper_funcs vc4_plane_helper_funcs = {
>  	 */
>  	.atomic_amend_check = vc4_plane_atomic_async_check,
>  	.atomic_amend_update = vc4_plane_atomic_async_update,
> +	.atomic_async_check = vc4_plane_atomic_async_check,
> +	.atomic_async_update = vc4_plane_atomic_async_update,
>  };
>  
>  static void vc4_plane_destroy(struct drm_plane *plane)
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index b1ced069ffc1..05756a09e762 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -300,6 +300,7 @@ struct __drm_private_objs_state {
>   * @ref: count of all references to this state (will not be freed until zero)
>   * @dev: parent DRM device
>   * @legacy_cursor_update: hint to enforce legacy cursor IOCTL semantics
> + * @async_update: hint for asyncronous page flip update
>   * @amend_update: hint for amend plane update
>   * @planes: pointer to array of structures with per-plane data
>   * @crtcs: pointer to array of CRTC pointers
> @@ -328,6 +329,7 @@ struct drm_atomic_state {
>  	 */
>  	bool allow_modeset : 1;
>  	bool legacy_cursor_update : 1;
> +	bool async_update : 1;
>  	bool amend_update : 1;
>  	/**
>  	 * @duplicated:
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index 8ce0594ccfb9..39e57d559a30 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -55,10 +55,11 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state);
>  int drm_atomic_helper_commit(struct drm_device *dev,
>  			     struct drm_atomic_state *state,
>  			     bool nonblock);
> -int drm_atomic_helper_amend_check(struct drm_device *dev,
> -				  struct drm_atomic_state *state);
> -void drm_atomic_helper_amend_commit(struct drm_device *dev,
> -				    struct drm_atomic_state *state);
> +int drm_atomic_helper_async_amend_check(struct drm_device *dev,
> +					struct drm_atomic_state *state,
> +					bool amend);
> +void drm_atomic_helper_async_amend_commit(struct drm_device *dev,
> +					  struct drm_atomic_state *state);
>  
>  int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
>  					struct drm_atomic_state *state,
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index d92e62dd76c4..c2863d62f160 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -1135,6 +1135,43 @@ struct drm_plane_helper_funcs {
>  	void (*atomic_disable)(struct drm_plane *plane,
>  			       struct drm_plane_state *old_state);
>  
> +	/**
> +	 * @atomic_async_check:
> +	 *
> +	 * Drivers should set this function pointer to check if a page flip can
> +	 * be performed asynchronously, i.e., immediately without waiting for a
> +	 * vblank.
> +	 *
> +	 * This hook is called by drm_atomic_async_check() to establish if a
> +	 * given update can be committed in async mode, that is, if it can
> +	 * jump ahead of the state currently queued for update.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * Return 0 on success and any error returned indicates that the update
> +	 * can not be applied in asynd mode.
> +	 */
> +	int (*atomic_async_check)(struct drm_plane *plane,
> +				  struct drm_plane_state *state);
> +
> +	/**
> +	 * @atomic_async_update:
> +	 *
> +	 * Drivers should set this function pointer to perform asynchronous page
> +	 * flips through the atomic api, i.e. not vblank synchronized.
> +	 *
> +	 * Note that unlike &drm_plane_helper_funcs.atomic_update this hook
> +	 * takes the new &drm_plane_state as parameter. When doing async_update
> +	 * drivers shouldn't replace the &drm_plane_state but update the
> +	 * current one with the new plane configurations in the new
> +	 * plane_state.
> +	 *
> +	 * FIXME:
> +	 *  - It only works for single plane updates
> +	 */
> +	void (*atomic_async_update)(struct drm_plane *plane,
> +				    struct drm_plane_state *new_state);
> +
>  	/**
>  	 * @atomic_amend_check:
>  	 *
> 

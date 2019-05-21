Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6382C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD4A21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MQgc0w+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfEUI6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:58:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58193 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:58:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190521085813euoutp02a0cc5401fddc1497607768f600682da0~gpwDd6Wnx1449314493euoutp02d
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:58:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190521085813euoutp02a0cc5401fddc1497607768f600682da0~gpwDd6Wnx1449314493euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558429093;
        bh=OE1gQiresqyILMa+/yJdLzca1LNXOxLD4Bi+m9VQpFQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MQgc0w+P4TTZkHw4q63SyNaWGYJ2YdH5i6ld+GDnUk1UXPBRnijIqgnGQJrxFRGdy
         cn4sbWsohE4tV8LT8GUWkdDO+ORmDISmZSoYaQ3Sa9mzf15eJVFF7R+ukQ2a9zQh/R
         s6XrHKTKuoIofz7BcEC5YC2HLaJNb2CX5ftBoQdI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190521085812eucas1p15fc8db7a892ad76e91b5f194c12c98bc~gpwC295eV3213032130eucas1p1z;
        Tue, 21 May 2019 08:58:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 66.CD.04377.4ADB3EC5; Tue, 21
        May 2019 09:58:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190521085811eucas1p11049c493675a2079005f8927b4f871c3~gpwCCcLSY1189911899eucas1p1B;
        Tue, 21 May 2019 08:58:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190521085811eusmtrp18e559dc2265b436d9bf03de82f1390e5~gpwB0LeIW1156111561eusmtrp10;
        Tue, 21 May 2019 08:58:11 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-35-5ce3bda4d1b1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.93.04140.3ADB3EC5; Tue, 21
        May 2019 09:58:11 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190521085811eusmtip1056e94904a6278b640b2f9844c7a45e6~gpwBZGbfN2557825578eusmtip1Y;
        Tue, 21 May 2019 08:58:10 +0000 (GMT)
Subject: Re: [PATCH v4 03/11] drm: Add atomic variants for bridge
 enable/disable
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <04aef058-fd7f-d37f-de84-6d05a66341bd@samsung.com>
Date:   Tue, 21 May 2019 10:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508160920.144739-4-sean@poorly.run>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87pL9j6OMbi3QNii99xJJouFD+8y
        W1z5+p7N4vKuOWwWD17uZ7S4O/kIkNhwltGB3WPemmqP2Q0XWTz2flvA4rH92wNWj/vdx5k8
        ju+6xe7xeZNcAHsUl01Kak5mWWqRvl0CV8bKJfoFs/Iqrv/7zt7AeDSii5GTQ0LAROLQ0h+s
        XYxcHEICKxglLv/rYIZwvjBKLF3exwRSJSTwmVHi7FZPmI7PG1dAFS1nlNh4+is7hPOWUeLt
        +4NADgeHsECQxJTPRSANIgIOEvf2LwcbxCywm1Fiw6tyEJtNQFPi7+abbCA2r4CdxMHm8+wg
        NouAqsTkfV1gtqhAhMT9YxtYIWoEJU7OfMICYnMKmEnMW9rJCDFTXqJ562xmCFtc4taT+Uwg
        90gIHGKXWPvyCiPE1S4Sy1+vY4OwhSVeHd/CDmHLSJye3MMCYddL3F/RwgzR3MEosXXDTmaI
        hLXE4eMXWUEeYwa6ev0ufYiwo8T3tR9ZQMISAnwSN94KQtzAJzFp23RmiDCvREebEES1osT9
        s1uhBopLLL3wlW0Co9IsJJ/NQvLNLCTfzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpe
        cn7uJkZgQjr97/iXHYy7/iQdYhTgYFTi4c2Y8ihGiDWxrLgy9xCjBAezkgjv6VNAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYxrvn+MqRUU4Tm6aQer
        xU3j0NniBx4/qsuZLnDBvfyMb+3cd7vuZTkdzZfc+jzd+vT/0z/uCu5pvn/3R+N5Ud7JnEpJ
        /nY6/9ISHwYIx9if/3SHr3XqxFqTEqGlAUbvHmwJuVk9defvpaz1U3hZ9n2TkThZY3pOJXyr
        3X6VmQ3cPrHGoT8uCZUosRRnJBpqMRcVJwIACLtF5EQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7qL9z6OMbizQtKi99xJJouFD+8y
        W1z5+p7N4vKuOWwWD17uZ7S4O/kIkNhwltGB3WPemmqP2Q0XWTz2flvA4rH92wNWj/vdx5k8
        ju+6xe7xeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsbKJfoFs/Iqrv/7zt7AeDSii5GTQ0LAROLzxhXMXYxcHEICSxkllu49wgKREJfY
        Pf8tM4QtLPHnWhcbRNFrRok5f16ydzFycAgLBElM+VwEUiMi4CBxb/9yJpAaZoHdjBL3X25i
        h2jYyihx++VpJpAqNgFNib+bb7KB2LwCdhIHm8+zg9gsAqoSk/d1gdmiAhESZ96vYIGoEZQ4
        OfMJmM0pYCYxb2knI4jNLKAu8WfeJWYIW16ieetsKFtc4taT+UwTGIVmIWmfhaRlFpKWWUha
        FjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMw23Hfm7Zwdj1LvgQowAHoxIPb8aURzFC
        rIllxZW5hxglOJiVRHhPnwIK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wReSVxBuaGppb
        WBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBcbjpB70rhlp1Tc6o8TRYftn0Y
        uYr/788L+cfvH0xwEXVX+FqxfOLUq5M3/Y0OWMzZsf5+t/iTeaYbLFze21cp8dq959Vuy8vN
        WPRLYda7JO0lm05aLwvWD9pTd60lg1N8TlXq/qMvl7IWKj+dwGcrY28QMNnl1QPONbqHblnu
        zxLYxcrvY9qoxFKckWioxVxUnAgA6v61HtkCAAA=
X-CMS-MailID: 20190521085811eucas1p11049c493675a2079005f8927b4f871c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190508160937epcas2p36170c1528618f4a187506e704f729951
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190508160937epcas2p36170c1528618f4a187506e704f729951
References: <20190508160920.144739-1-sean@poorly.run>
        <CGME20190508160937epcas2p36170c1528618f4a187506e704f729951@epcas2p3.samsung.com>
        <20190508160920.144739-4-sean@poorly.run>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.2019 18:09, Sean Paul wrote:
> From: Sean Paul <seanpaul@chromium.org>
>
> This patch adds atomic variants for all of
> pre_enable/enable/disable/post_disable bridge functions. These will be
> called from the appropriate atomic helper functions. If the bridge
> driver doesn't implement the atomic version of the function, we will
> fall back to the vanilla implementation.
>
> Note that some drivers call drm_bridge_disable directly, and these cases
> are not covered. It's up to the driver to decide whether to implement
> both atomic_disable and disable, or if it's not necessary.
>
> Changes in v3:
> - Added to the patchset
> Changes in v4:
> - Fix up docbook references (Daniel)
>
> Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-4-sean@poorly.run
>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>


In general patch looks OK, ie. it correctly mimics old behavior with
added atomic state.

However I have mixed feelings about it, because of the whole idea that
order of enabling/disabling bridges in the chain is the same for all
bridge chains is just incorrect. It depends on link types between
bridges, there are also multi-in/out bridges which does not fit at all
in this model. Due to this lack of flexibility developers either
explicitly avoids drm_bridge->next chaining in favor of custom
solutions, or worse they forcibly try to fit into this model by either
violating hw specs, either by introducing hacks into the drivers.

The simplest solution for this would be to just let parent bridge calls
children's callbacks explicitly (as exynos_drm_dsi and vc4_dsi do).

But since it is not a blocker I will left it up to you :) :

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


Regards

Andrzej


> ---
>  drivers/gpu/drm/drm_atomic_helper.c |   8 +-
>  drivers/gpu/drm/drm_bridge.c        | 110 ++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h            | 106 +++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index ccf01831f265..e8b7187a8494 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -995,7 +995,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call disable hooks twice.
>  		 */
> -		drm_bridge_disable(encoder->bridge);
> +		drm_atomic_bridge_disable(encoder->bridge, old_state);
>  
>  		/* Right function depends upon target state. */
>  		if (funcs) {
> @@ -1009,7 +1009,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
>  		}
>  
> -		drm_bridge_post_disable(encoder->bridge);
> +		drm_atomic_bridge_post_disable(encoder->bridge, old_state);
>  	}
>  
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> @@ -1308,7 +1308,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  		 * Each encoder has at most one connector (since we always steal
>  		 * it away), so we won't call enable hooks twice.
>  		 */
> -		drm_bridge_pre_enable(encoder->bridge);
> +		drm_atomic_bridge_pre_enable(encoder->bridge, old_state);
>  
>  		if (funcs) {
>  			if (funcs->atomic_enable)
> @@ -1319,7 +1319,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
>  				funcs->commit(encoder);
>  		}
>  
> -		drm_bridge_enable(encoder->bridge);
> +		drm_atomic_bridge_enable(encoder->bridge, old_state);
>  	}
>  
>  	drm_atomic_helper_commit_writebacks(dev, old_state);
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 138b2711d389..cba537c99e43 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -352,6 +352,116 @@ void drm_bridge_enable(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_enable);
>  
> +/**
> + * drm_atomic_bridge_disable - disables all bridges in the encoder chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.atomic_disable (falls back on
> + * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,
> + * starting from the last bridge to the first. These are called before calling
> + * &drm_encoder_helper_funcs.atomic_disable
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_disable(struct drm_bridge *bridge,
> +			       struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	drm_atomic_bridge_disable(bridge->next, state);
> +
> +	if (bridge->funcs->atomic_disable)
> +		bridge->funcs->atomic_disable(bridge, state);
> +	else if (bridge->funcs->disable)
> +		bridge->funcs->disable(bridge);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_disable);
> +
> +/**
> + * drm_atomic_bridge_post_disable - cleans up after disabling all bridges in the
> + *				    encoder chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.atomic_post_disable (falls back on
> + * &drm_bridge_funcs.post_disable) op for all the bridges in the encoder chain,
> + * starting from the first bridge to the last. These are called after completing
> + * &drm_encoder_helper_funcs.atomic_disable
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
> +				    struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	if (bridge->funcs->atomic_post_disable)
> +		bridge->funcs->atomic_post_disable(bridge, state);
> +	else if (bridge->funcs->post_disable)
> +		bridge->funcs->post_disable(bridge);
> +
> +	drm_atomic_bridge_post_disable(bridge->next, state);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_post_disable);
> +
> +/**
> + * drm_atomic_bridge_pre_enable - prepares for enabling all bridges in the
> + *				  encoder chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.atomic_pre_enable (falls back on
> + * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
> + * starting from the last bridge to the first. These are called before calling
> + * &drm_encoder_helper_funcs.atomic_enable
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
> +				  struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	drm_atomic_bridge_pre_enable(bridge->next, state);
> +
> +	if (bridge->funcs->atomic_pre_enable)
> +		bridge->funcs->atomic_pre_enable(bridge, state);
> +	else if (bridge->funcs->pre_enable)
> +		bridge->funcs->pre_enable(bridge);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_pre_enable);
> +
> +/**
> + * drm_atomic_bridge_enable - enables all bridges in the encoder chain
> + * @bridge: bridge control structure
> + * @state: atomic state being committed
> + *
> + * Calls &drm_bridge_funcs.atomic_enable (falls back on
> + * &drm_bridge_funcs.enable) op for all the bridges in the encoder chain,
> + * starting from the first bridge to the last. These are called after completing
> + * &drm_encoder_helper_funcs.atomic_enable
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + */
> +void drm_atomic_bridge_enable(struct drm_bridge *bridge,
> +			      struct drm_atomic_state *state)
> +{
> +	if (!bridge)
> +		return;
> +
> +	if (bridge->funcs->atomic_enable)
> +		bridge->funcs->atomic_enable(bridge, state);
> +	else if (bridge->funcs->enable)
> +		bridge->funcs->enable(bridge);
> +
> +	drm_atomic_bridge_enable(bridge->next, state);
> +}
> +EXPORT_SYMBOL(drm_atomic_bridge_enable);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node in
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index d4428913a4e1..322801884814 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -237,6 +237,103 @@ struct drm_bridge_funcs {
>  	 * The enable callback is optional.
>  	 */
>  	void (*enable)(struct drm_bridge *bridge);
> +
> +	/**
> +	 * @atomic_pre_enable:
> +	 *
> +	 * This callback should enable the bridge. It is called right before
> +	 * the preceding element in the display pipe is enabled. If the
> +	 * preceding element is a bridge this means it's called before that
> +	 * bridge's @atomic_pre_enable or @pre_enable function. If the preceding
> +	 * element is a &drm_encoder it's called right before the encoder's
> +	 * &drm_encoder_helper_funcs.atomic_enable hook.
> +	 *
> +	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
> +	 * will not yet be running when this callback is called. The bridge must
> +	 * not enable the display link feeding the next bridge in the chain (if
> +	 * there is one) when this callback is called.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_pre_enable. It
> +	 * would be prudent to also provide an implementation of @pre_enable if
> +	 * you are expecting driver calls into &drm_bridge_pre_enable.
> +	 *
> +	 * The @atomic_pre_enable callback is optional.
> +	 */
> +	void (*atomic_pre_enable)(struct drm_bridge *bridge,
> +				  struct drm_atomic_state *state);
> +
> +	/**
> +	 * @atomic_enable:
> +	 *
> +	 * This callback should enable the bridge. It is called right after
> +	 * the preceding element in the display pipe is enabled. If the
> +	 * preceding element is a bridge this means it's called after that
> +	 * bridge's @atomic_enable or @enable function. If the preceding element
> +	 * is a &drm_encoder it's called right after the encoder's
> +	 * &drm_encoder_helper_funcs.atomic_enable hook.
> +	 *
> +	 * The bridge can assume that the display pipe (i.e. clocks and timing
> +	 * signals) feeding it is running when this callback is called. This
> +	 * callback must enable the display link feeding the next bridge in the
> +	 * chain if there is one.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_enable. It
> +	 * would be prudent to also provide an implementation of @enable if
> +	 * you are expecting driver calls into &drm_bridge_enable.
> +	 *
> +	 * The enable callback is optional.
> +	 */
> +	void (*atomic_enable)(struct drm_bridge *bridge,
> +			      struct drm_atomic_state *state);
> +	/**
> +	 * @atomic_disable:
> +	 *
> +	 * This callback should disable the bridge. It is called right before
> +	 * the preceding element in the display pipe is disabled. If the
> +	 * preceding element is a bridge this means it's called before that
> +	 * bridge's @atomic_disable or @disable vfunc. If the preceding element
> +	 * is a &drm_encoder it's called right before the
> +	 * &drm_encoder_helper_funcs.atomic_disable hook.
> +	 *
> +	 * The bridge can assume that the display pipe (i.e. clocks and timing
> +	 * signals) feeding it is still running when this callback is called.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_disable. It
> +	 * would be prudent to also provide an implementation of @disable if
> +	 * you are expecting driver calls into &drm_bridge_disable.
> +	 *
> +	 * The disable callback is optional.
> +	 */
> +	void (*atomic_disable)(struct drm_bridge *bridge,
> +			       struct drm_atomic_state *state);
> +
> +	/**
> +	 * @atomic_post_disable:
> +	 *
> +	 * This callback should disable the bridge. It is called right after the
> +	 * preceding element in the display pipe is disabled. If the preceding
> +	 * element is a bridge this means it's called after that bridge's
> +	 * @atomic_post_disable or @post_disable function. If the preceding
> +	 * element is a &drm_encoder it's called right after the encoder's
> +	 * &drm_encoder_helper_funcs.atomic_disable hook.
> +	 *
> +	 * The bridge must assume that the display pipe (i.e. clocks and timing
> +	 * signals) feeding it is no longer running when this callback is
> +	 * called.
> +	 *
> +	 * Note that this function will only be invoked in the context of an
> +	 * atomic commit. It will not be invoked from &drm_bridge_post_disable.
> +	 * It would be prudent to also provide an implementation of
> +	 * @post_disable if you are expecting driver calls into
> +	 * &drm_bridge_post_disable.
> +	 *
> +	 * The post_disable callback is optional.
> +	 */
> +	void (*atomic_post_disable)(struct drm_bridge *bridge,
> +				    struct drm_atomic_state *state);
>  };
>  
>  /**
> @@ -314,6 +411,15 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>  void drm_bridge_enable(struct drm_bridge *bridge);
>  
> +void drm_atomic_bridge_disable(struct drm_bridge *bridge,
> +			       struct drm_atomic_state *state);
> +void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
> +				    struct drm_atomic_state *state);
> +void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
> +				  struct drm_atomic_state *state);
> +void drm_atomic_bridge_enable(struct drm_bridge *bridge,
> +			      struct drm_atomic_state *state);
> +
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
>  					u32 connector_type);



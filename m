Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4809CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A059C217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKAO4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:56:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:41661 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfKAO4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:56:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 07:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,255,1569308400"; 
   d="scan'208";a="351972710"
Received: from cepartan-mobl3.ger.corp.intel.com (HELO [10.249.40.248]) ([10.249.40.248])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2019 07:56:11 -0700
Subject: Re: [PATCH] drm/atomic: swap_state should stall on cleanup_done
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20191031223641.19208-1-robdclark@gmail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <4c71b8b5-fc37-f00d-92cb-551231a5c915@linux.intel.com>
Date:   Fri, 1 Nov 2019 15:56:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031223641.19208-1-robdclark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 31-10-2019 om 23:36 schreef Rob Clark:
> From: Rob Clark <robdclark@chromium.org>
>
> Stalling on cleanup_done ensures that any atomic state related to a
> nonblock commit no longer has dangling references to per-object state
> that can be freed.
>
> Otherwise, if a !nonblock commit completes after a nonblock commit has
> swapped state (ie. the synchronous part of the nonblock commit comes
> before the !nonblock commit), but before the asynchronous part of the
> nonblock commit completes, what was the new per-object state in the
> nonblock commit can be freed.
>
> This shows up with the new self-refresh helper, as _update_avg_times()
> dereferences the original old and new crtc_state.
>
> Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Other possibilities:
> 1) maybe block later before freeing atomic state?
> 2) refcount individual per-object state
>
>  drivers/gpu/drm/drm_atomic_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 3ef2ac52ce94..a5d95429f91b 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2711,7 +2711,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>  			if (!commit)
>  				continue;
>  
> -			ret = wait_for_completion_interruptible(&commit->hw_done);
> +			ret = wait_for_completion_interruptible(&commit->cleanup_done);
>  			if (ret)
>  				return ret;
>  		}
> @@ -2722,7 +2722,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>  			if (!commit)
>  				continue;
>  
> -			ret = wait_for_completion_interruptible(&commit->hw_done);
> +			ret = wait_for_completion_interruptible(&commit->cleanup_done);
>  			if (ret)
>  				return ret;
>  		}
> @@ -2733,7 +2733,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>  			if (!commit)
>  				continue;
>  
> -			ret = wait_for_completion_interruptible(&commit->hw_done);
> +			ret = wait_for_completion_interruptible(&commit->cleanup_done);
>  			if (ret)
>  				return ret;
>  		}

From setup_commit():

 * Completion of the hardware commit step must be signalled using
 * drm_atomic_helper_commit_hw_done(). After this step the driver is not allowed
 * to read or change any permanent software or hardware modeset state. The only
 * exception is state protected by other means than &drm_modeset_lock locks.
 * Only the free standing @state with pointers to the old state structures can
 * be inspected, e.g. to clean up old buffers using
 * drm_atomic_helper_cleanup_planes().

And the hw_done function says pretty much the same thing. :)


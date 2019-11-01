Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89286CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6919F21897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKASdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:33:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:56627 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfKASdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:33:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:33:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="352026410"
Received: from cepartan-mobl3.ger.corp.intel.com (HELO [10.249.40.248]) ([10.249.40.248])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2019 11:33:12 -0700
Subject: Re: [PATCH 2/2] drm/atomic: clear new_state pointers at hw_done
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20191101180713.5470-1-robdclark@gmail.com>
 <20191101180713.5470-2-robdclark@gmail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <ec3c1d7b-231a-862f-ce12-8ac4c9616ca5@linux.intel.com>
Date:   Fri, 1 Nov 2019 19:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101180713.5470-2-robdclark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 01-11-2019 om 19:07 schreef Rob Clark:
> From: Rob Clark <robdclark@chromium.org>
>
> The new state should not be accessed after this point.  Clear the
> pointers to make that explicit.
>
> This makes the error corrected in the previous patch more obvious.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Would be nice if you could cc intel-gfx@lists.freedesktop.org next time, so I know our CI infrastructure is happy;

It wouldn't surprise me if it catches 1 or 2 abuses in i915.

Otherwise Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Perhaps you could mail this to version to intel-gfx-trybot@lists.freedesktop.org using git-send-email so we at least get i915 results?

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 732bd0ce9241..176831df8163 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2234,13 +2234,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
>   */
>  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
>  {
> +	struct drm_connector *connector;
> +	struct drm_connector_state *old_conn_state, *new_conn_state;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	struct drm_plane *plane;
> +	struct drm_plane_state *old_plane_state, *new_plane_state;
>  	struct drm_crtc_commit *commit;
> +	struct drm_private_obj *obj;
> +	struct drm_private_state *old_obj_state, *new_obj_state;
>  	int i;
>  
> +	/*
> +	 * After this point, drivers should not access the permanent modeset
> +	 * state, so we also clear the new_state pointers to make this
> +	 * restriction explicit.
> +	 *
> +	 * For the CRTC state, we do this in the same loop where we signal
> +	 * hw_done, since we still need to new_crtc_state to fish out the
> +	 * commit.
> +	 */
> +
> +	for_each_oldnew_connector_in_state(old_state, connector, old_conn_state, new_conn_state, i) {
> +		old_state->connectors[i].new_state = NULL;
> +	}
> +
> +	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
> +		old_state->planes[i].new_state = NULL;
> +	}
> +
> +	for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_state, new_obj_state, i) {
> +		old_state->private_objs[i].new_state = NULL;
> +	}
> +
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
>  		old_state->crtcs[i].new_self_refresh_active = new_crtc_state->self_refresh_active;
> +		old_state->crtcs[i].new_state = NULL;
>  
>  		commit = new_crtc_state->commit;
>  		if (!commit)



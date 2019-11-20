Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD11B224B2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfKTOSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:18:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:21117 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbfKTOSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:18:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:18:42 -0800
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="196867261"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:18:38 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] drm/rect: remove useless call to clamp_t
In-Reply-To: <20191119133435.22525-1-benjamin.gaignard@st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191119133435.22525-1-benjamin.gaignard@st.com>
Date:   Wed, 20 Nov 2019 16:18:35 +0200
Message-ID: <871ru2y6kk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> Clamping a value between INT_MIN and INT_MAX always return the value itself
> and generate warnings when compiling with W=1.

Does that hold for 32-bit too?

BR,
Jani.

>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_rect.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_rect.c b/drivers/gpu/drm/drm_rect.c
> index b8363aaa9032..681f1fd09357 100644
> --- a/drivers/gpu/drm/drm_rect.c
> +++ b/drivers/gpu/drm/drm_rect.c
> @@ -89,7 +89,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>  		u32 new_src_w = clip_scaled(drm_rect_width(src),
>  					    drm_rect_width(dst), diff);
>  
> -		src->x1 = clamp_t(int64_t, src->x2 - new_src_w, INT_MIN, INT_MAX);
> +		src->x1 = src->x2 - new_src_w;
>  		dst->x1 = clip->x1;
>  	}
>  	diff = clip->y1 - dst->y1;
> @@ -97,7 +97,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>  		u32 new_src_h = clip_scaled(drm_rect_height(src),
>  					    drm_rect_height(dst), diff);
>  
> -		src->y1 = clamp_t(int64_t, src->y2 - new_src_h, INT_MIN, INT_MAX);
> +		src->y1 = src->y2 - new_src_h;
>  		dst->y1 = clip->y1;
>  	}
>  	diff = dst->x2 - clip->x2;
> @@ -105,7 +105,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>  		u32 new_src_w = clip_scaled(drm_rect_width(src),
>  					    drm_rect_width(dst), diff);
>  
> -		src->x2 = clamp_t(int64_t, src->x1 + new_src_w, INT_MIN, INT_MAX);
> +		src->x2 = src->x1 + new_src_w;
>  		dst->x2 = clip->x2;
>  	}
>  	diff = dst->y2 - clip->y2;
> @@ -113,7 +113,7 @@ bool drm_rect_clip_scaled(struct drm_rect *src, struct drm_rect *dst,
>  		u32 new_src_h = clip_scaled(drm_rect_height(src),
>  					    drm_rect_height(dst), diff);
>  
> -		src->y2 = clamp_t(int64_t, src->y1 + new_src_h, INT_MIN, INT_MAX);
> +		src->y2 = src->y1 + new_src_h;
>  		dst->y2 = clip->y2;
>  	}

-- 
Jani Nikula, Intel Open Source Graphics Center

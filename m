Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512DFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7220714
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfKTPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:22:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:64060 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfKTPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:22:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 07:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="204848878"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 20 Nov 2019 07:22:35 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 20 Nov 2019 17:22:34 +0200
Date:   Wed, 20 Nov 2019 17:22:34 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/rect: remove useless call to clamp_t
Message-ID: <20191120152234.GG1208@intel.com>
References: <20191119133435.22525-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119133435.22525-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 02:34:35PM +0100, Benjamin Gaignard wrote:
> Clamping a value between INT_MIN and INT_MAX always return the value itself
> and generate warnings when compiling with W=1.
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

Hmm. I think we borked this a bit when introducing clip_scaled().
'diff' can exceed dst width here so clip_scaled() should be able to
return a negative value.

Probably we should make this more consistent and do something like:
        diff = clip->x1 - dst->x1;
        if (diff > 0) {
-               u32 new_src_w = clip_scaled(drm_rect_width(src),
-                                           drm_rect_width(dst), diff);
+               int dst_w, new_src_w;
 
-               src->x1 = clamp_t(int64_t, src->x2 - new_src_w, INT_MIN, INT_MAX);
-               dst->x1 = clip->x1;
+               dst_w = drm_rect_width(dst);
+               diff = min(diff, dst_w);
+               new_src_w = clip_scaled(drm_rect_width(src), dst_w, diff);
+
+               src->x1 = src->x2 - new_src_w;
+               dst->x1 += diff;
        }

etc.

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
>  
> -- 
> 2.15.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel

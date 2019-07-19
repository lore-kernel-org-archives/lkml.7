Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59F6C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9599421849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfGSMj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:39:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:14690 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfGSMj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:39:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 05:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="scan'208";a="170126713"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 19 Jul 2019 05:39:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 19 Jul 2019 15:39:52 +0300
Date:   Fri, 19 Jul 2019 15:39:52 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, matthew.d.roper@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] drm/i915/icl: Remove set but not used variable
 'src_y'
Message-ID: <20190719123952.GK5942@intel.com>
References: <20190719024100.64738-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719024100.64738-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 02:41:00AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/i915/display/intel_sprite.c: In function 'g4x_sprite_check_scaling':
> drivers/gpu/drm/i915/display/intel_sprite.c:1494:13: warning:
>  variable 'src_y' set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks. Applied to drm-intel-next-queued.

PS. I removed the "/icl" from the subject line because this has nothing
to do with icelake hardware.

> ---
>  drivers/gpu/drm/i915/display/intel_sprite.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
> index 34586f29be60..9c3367491f04 100644
> --- a/drivers/gpu/drm/i915/display/intel_sprite.c
> +++ b/drivers/gpu/drm/i915/display/intel_sprite.c
> @@ -1491,7 +1491,7 @@ g4x_sprite_check_scaling(struct intel_crtc_state *crtc_state,
>  	const struct drm_framebuffer *fb = plane_state->base.fb;
>  	const struct drm_rect *src = &plane_state->base.src;
>  	const struct drm_rect *dst = &plane_state->base.dst;
> -	int src_x, src_y, src_w, src_h, crtc_w, crtc_h;
> +	int src_x, src_w, src_h, crtc_w, crtc_h;
>  	const struct drm_display_mode *adjusted_mode =
>  		&crtc_state->base.adjusted_mode;
>  	unsigned int cpp = fb->format->cpp[0];
> @@ -1502,7 +1502,6 @@ g4x_sprite_check_scaling(struct intel_crtc_state *crtc_state,
>  	crtc_h = drm_rect_height(dst);
>  
>  	src_x = src->x1 >> 16;
> -	src_y = src->y1 >> 16;
>  	src_w = drm_rect_width(src) >> 16;
>  	src_h = drm_rect_height(src) >> 16;
> 
> 

-- 
Ville Syrjälä
Intel

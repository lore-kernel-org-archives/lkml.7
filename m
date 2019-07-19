Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C9C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A102186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbfGSRXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:23:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:32702 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfGSRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:23:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 10:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,283,1559545200"; 
   d="scan'208";a="196010773"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 19 Jul 2019 10:23:36 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 19 Jul 2019 20:23:35 +0300
Date:   Fri, 19 Jul 2019 20:23:35 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        imre.deak@intel.com, madhav.chauhan@intel.com,
        vandita.kulkarni@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] drm/i915/dsi: remove set but not used variable
 'hfront_porch'
Message-ID: <20190719172335.GT5942@intel.com>
References: <20190719015136.103988-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719015136.103988-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:51:36AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/i915/display/icl_dsi.c: In function 'gen11_dsi_set_transcoder_timings':
> drivers/gpu/drm/i915/display/icl_dsi.c:768:6: warning:
>  variable 'hfront_porch' set but not used [-Wunused-but-set-variable]
> 
> It is never used and can be removed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks. Applied to drm-intel-next-queued.

> ---
>  drivers/gpu/drm/i915/display/icl_dsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index 4d952accfaaa..a42348be0438 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -763,7 +763,7 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
>  	enum transcoder dsi_trans;
>  	/* horizontal timings */
>  	u16 htotal, hactive, hsync_start, hsync_end, hsync_size;
> -	u16 hfront_porch, hback_porch;
> +	u16 hback_porch;
>  	/* vertical timings */
>  	u16 vtotal, vactive, vsync_start, vsync_end, vsync_shift;
>  
> @@ -772,8 +772,6 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
>  	hsync_start = adjusted_mode->crtc_hsync_start;
>  	hsync_end = adjusted_mode->crtc_hsync_end;
>  	hsync_size  = hsync_end - hsync_start;
> -	hfront_porch = (adjusted_mode->crtc_hsync_start -
> -			adjusted_mode->crtc_hdisplay);
>  	hback_porch = (adjusted_mode->crtc_htotal -
>  		       adjusted_mode->crtc_hsync_end);
>  	vactive = adjusted_mode->crtc_vdisplay;
> 
> 

-- 
Ville Syrjälä
Intel

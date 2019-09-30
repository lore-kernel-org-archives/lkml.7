Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB03C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490AC20679
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfI3Kjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:39:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:55949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfI3Kjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:39:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 03:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="202839979"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 30 Sep 2019 03:39:32 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 30 Sep 2019 13:39:31 +0300
Date:   Mon, 30 Sep 2019 13:39:31 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jeykumar Sankaran <jsanka@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, seanpaul@chromium.org,
        narmstrong@baylibre.com
Subject: Re: [PATCH] drm: add fb max width/height fields to drm_mode_config
Message-ID: <20190930103931.GZ1208@intel.com>
References: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
 <1569634131-13875-2-git-send-email-jsanka@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569634131-13875-2-git-send-email-jsanka@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 06:28:51PM -0700, Jeykumar Sankaran wrote:
> The mode_config max width/height values determine the maximum
> resolution the pixel reader can handle.

Not according to the docs I "fixed" a while ago.

> But the same values are
> used to restrict the size of the framebuffer creation. Hardware's
> with scaling blocks can operate on framebuffers larger/smaller than
> that of the pixel reader resolutions by scaling them down/up before
> rendering.
> 
> This changes adds a separate framebuffer max width/height fields
> in drm_mode_config to allow vendors to set if they are different
> than that of the default max resolution values.

If you're going to change the meaning of the old values you need
to fix the drivers too.

Personally I don't see too much point in this since you most likely
want to validate all the other timings as well, and so likely need
some kind of mode_valid implementation anyway. Hence to validate
modes there's not much benefit of having global min/max values.

> 
> Vendors setting these fields should fix their mode_set paths too
> by filtering and validating the modes against the appropriate max
> fields in their mode_valid() implementations.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jeykumar Sankaran <jsanka@codeaurora.org>
> ---
>  drivers/gpu/drm/drm_framebuffer.c | 15 +++++++++++----
>  include/drm/drm_mode_config.h     |  3 +++
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 5756431..2083168 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -300,14 +300,21 @@ struct drm_framebuffer *
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if ((config->min_width > r->width) || (r->width > config->max_width)) {
> +	if ((config->min_width > r->width) ||
> +	    (!config->max_fb_width && r->width > config->max_width) ||
> +	    (config->max_fb_width && r->width > config->max_fb_width)) {
>  		DRM_DEBUG_KMS("bad framebuffer width %d, should be >= %d && <= %d\n",
> -			  r->width, config->min_width, config->max_width);
> +			r->width, config->min_width, config->max_fb_width ?
> +			config->max_fb_width : config->max_width);
>  		return ERR_PTR(-EINVAL);
>  	}
> -	if ((config->min_height > r->height) || (r->height > config->max_height)) {
> +
> +	if ((config->min_height > r->height) ||
> +	    (!config->max_fb_height && r->height > config->max_height) ||
> +	    (config->max_fb_height && r->height > config->max_fb_height)) {
>  		DRM_DEBUG_KMS("bad framebuffer height %d, should be >= %d && <= %d\n",
> -			  r->height, config->min_height, config->max_height);
> +			r->height, config->min_height, config->max_fb_width ?
> +			config->max_fb_height : config->max_height);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 3bcbe30..c6394ed 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -339,6 +339,8 @@ struct drm_mode_config_funcs {
>   * @min_height: minimum fb pixel height on this device
>   * @max_width: maximum fb pixel width on this device
>   * @max_height: maximum fb pixel height on this device
> + * @max_fb_width: maximum fb buffer width if differs from max_width
> + * @max_fb_height: maximum fb buffer height if differs from  max_height
>   * @funcs: core driver provided mode setting functions
>   * @fb_base: base address of the framebuffer
>   * @poll_enabled: track polling support for this device
> @@ -523,6 +525,7 @@ struct drm_mode_config {
>  
>  	int min_width, min_height;
>  	int max_width, max_height;
> +	int max_fb_width, max_fb_height;
>  	const struct drm_mode_config_funcs *funcs;
>  	resource_size_t fb_base;
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel

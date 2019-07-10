Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6993C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8649C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfGJKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:00:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:42541 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfGJKAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:00:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 03:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186111514"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 10 Jul 2019 03:00:01 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 10 Jul 2019 13:00:00 +0300
Date:   Wed, 10 Jul 2019 13:00:00 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
Message-ID: <20190710100000.GZ5942@intel.com>
References: <20190709145151.23086-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709145151.23086-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
> The named mode could be invalid and then cmdline parser misses to validate
> mode's dimensions, happily adding 0x0 mode as a valid mode. One case where
> this happens is NVIDIA Tegra devices that are using downstream bootloader
> which adds "video=tegrafb" to the kernel's cmdline and thus upstream Tegra
> DRM driver fails to probe because of the invalid mode.
> 
> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")

Is that actually true? This problem has been in the code since forever AFAICS.

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 3 ++-
>  drivers/gpu/drm/drm_modes.c          | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index e95fceac8f8b..56d36779d213 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -180,7 +180,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
>  
>  create_mode:
>  	mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
> -	list_add(&mode->head, &connector->modes);
> +	if (mode)
> +		list_add(&mode->head, &connector->modes);

That's the same as what I did here
https://patchwork.freedesktop.org/patch/309223/?series=61781&rev=1

But I'd have to rebase that so let's just go with your patch.

>  
>  	return mode;
>  }
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 910561d4f071..74a5739df506 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -158,6 +158,9 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
>  	int interlace;
>  	u64 tmp;
>  
> +	if (!hdisplay || !vdisplay)
> +		return NULL;
> +
>  	/* allocate the drm_display_mode structure. If failure, we will
>  	 * return directly
>  	 */
> @@ -392,6 +395,9 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
>  	int hsync, hfront_porch, vodd_front_porch_lines;
>  	unsigned int tmp1, tmp2;
>  
> +	if (!hdisplay || !vdisplay)
> +		return NULL;
> +

These lgtm

Patch is
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  	drm_mode = drm_mode_create(dev);
>  	if (!drm_mode)
>  		return NULL;
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel

Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A210AC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B05E218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfGEMmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:42:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:4897 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfGEMmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:42:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 05:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="248182207"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga001.jf.intel.com with SMTP; 05 Jul 2019 05:41:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 05 Jul 2019 15:41:51 +0300
Date:   Fri, 5 Jul 2019 15:41:51 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        imre.deak@intel.com, dhinakaran.pandiyan@intel.com,
        chris@chris-wilson.co.uk, manasi.d.navare@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/i915: Remove set but not used variable
 'encoder'
Message-ID: <20190705124151.GN5942@intel.com>
References: <20190705113112.64715-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705113112.64715-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:31:12AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/i915/display/intel_dp.c: In function 'intel_dp_set_drrs_state':
> drivers/gpu/drm/i915/display/intel_dp.c:6623:24: warning:
>  variable 'encoder' set but not used [-Wunused-but-set-variable]
> 
> It's never used, so can be removed.Also remove related
> variable 'dig_port'
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to drm-intel-next-queued. Thanks for the patch.

> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 8f7188d71d08..0bdb7ecc5a81 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -6620,8 +6620,6 @@ static void intel_dp_set_drrs_state(struct drm_i915_private *dev_priv,
>  				    const struct intel_crtc_state *crtc_state,
>  				    int refresh_rate)
>  {
> -	struct intel_encoder *encoder;
> -	struct intel_digital_port *dig_port = NULL;
>  	struct intel_dp *intel_dp = dev_priv->drrs.dp;
>  	struct intel_crtc *intel_crtc = to_intel_crtc(crtc_state->base.crtc);
>  	enum drrs_refresh_rate_type index = DRRS_HIGH_RR;
> @@ -6636,9 +6634,6 @@ static void intel_dp_set_drrs_state(struct drm_i915_private *dev_priv,
>  		return;
>  	}
>  
> -	dig_port = dp_to_dig_port(intel_dp);
> -	encoder = &dig_port->base;
> -
>  	if (!intel_crtc) {
>  		DRM_DEBUG_KMS("DRRS: intel_crtc not initialized\n");
>  		return;
> 
> 

-- 
Ville Syrjälä
Intel

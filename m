Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B8C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DEB216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfFYPHe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:07:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:14395 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbfFYPHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:07:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 08:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="182907469"
Received: from triedme-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.180])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2019 08:07:28 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Furquan Shaikh <furquan@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, rajatja@google.com,
        marcheu@chromium.org, Furquan Shaikh <furquan@google.com>,
        "Lee\, Shawn C" <shawn.c.lee@intel.com>
Subject: Re: [PATCH] i915: intel_dp_aux_backlight: Fix max backlight calculations
In-Reply-To: <20190618062628.133783-1-furquan@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190618062628.133783-1-furquan@google.com>
Date:   Tue, 25 Jun 2019 18:09:20 +0300
Message-ID: <87v9wtog67.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Furquan Shaikh <furquan@google.com> wrote:
> Max backlight value for the panel was being calculated using byte
> count i.e. 0xffff if 2 bytes are supported for backlight brightness
> and 0xff if 1 byte is supported. However, EDP_PWMGEN_BIT_COUNT
> determines the number of active control bits used for the brightness
> setting. Thus, even if the panel uses 2 byte setting, it might not use
> all the control bits. Thus, max backlight should be set based on the
> value of EDP_PWMGEN_BIT_COUNT instead of assuming 65535 or 255.
>
> Additionally, EDP_PWMGEN_BIT_COUNT was being updated based on the VBT
> frequency which results in a different max backlight value. Thus,
> setting of EDP_PWMGEN_BIT_COUNT is moved to setup phase instead of
> enable so that max backlight can be calculated correctly. Only the
> frequency divider is set during the enable phase using the value of
> EDP_PWMGEN_BIT_COUNT.

The eDP aux backlight is another fine example of simple made
difficult. Ugh.

Shawn (Cc'd) has recently submitted patches to this code. Shawn, please
also look through this and provide your comments, if any.

One comment inline.

> Signed-off-by: Furquan Shaikh <furquan@google.com>
> Reviewed-by: Stéphane Marchesin <marcheu@chromium.org>
> ---
>  drivers/gpu/drm/i915/intel_dp_aux_backlight.c | 132 ++++++++++++------
>  1 file changed, 88 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
> index 357136f17f85..4636c8e8ae8a 100644
> --- a/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/intel_dp_aux_backlight.c
> @@ -110,61 +110,34 @@ static bool intel_dp_aux_set_pwm_freq(struct intel_connector *connector)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
>  	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
> -	int freq, fxp, fxp_min, fxp_max, fxp_actual, f = 1;
> -	u8 pn, pn_min, pn_max;
> +	int freq, fxp, f, fxp_actual, fxp_min, fxp_max;
> +	u8 pn;
>  
> -	/* Find desired value of (F x P)
> -	 * Note that, if F x P is out of supported range, the maximum value or
> -	 * minimum value will applied automatically. So no need to check that.
> -	 */
>  	freq = dev_priv->vbt.backlight.pwm_freq_hz;
> -	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
>  	if (!freq) {
>  		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
>  		return false;
>  	}
>  
> -	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
> -
> -	/* Use highest possible value of Pn for more granularity of brightness
> -	 * adjustment while satifying the conditions below.
> -	 * - Pn is in the range of Pn_min and Pn_max
> -	 * - F is in the range of 1 and 255
> -	 * - FxP is within 25% of desired value.
> -	 *   Note: 25% is arbitrary value and may need some tweak.
> -	 */
> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
> -			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) != 1) {
> -		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
> +	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT,
> +			      &pn) < 0) {
> +		DRM_DEBUG_KMS("Failed to read aux pwmgen bit count\n");
>  		return false;
>  	}
> -	if (drm_dp_dpcd_readb(&intel_dp->aux,
> -			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) != 1) {
> -		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
> -		return false;
> -	}
> -	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> -	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>  
> +	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
> +	f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
> +	fxp_actual = f << pn;
> +
> +	/* Ensure frequency is within 25% of desired value */
>  	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
>  	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
> -	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
> -		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
> -		return false;
> -	}
>  
> -	for (pn = pn_max; pn >= pn_min; pn--) {
> -		f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
> -		fxp_actual = f << pn;
> -		if (fxp_min <= fxp_actual && fxp_actual <= fxp_max)
> -			break;
> -	}
> -
> -	if (drm_dp_dpcd_writeb(&intel_dp->aux,
> -			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
> -		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
> +	if (fxp_min > fxp_actual || fxp_actual > fxp_max) {
> +		DRM_DEBUG_KMS("Actual frequency out of range\n");
>  		return false;
>  	}
> +
>  	if (drm_dp_dpcd_writeb(&intel_dp->aux,
>  			       DP_EDP_BACKLIGHT_FREQ_SET, (u8) f) < 0) {
>  		DRM_DEBUG_KMS("Failed to write aux backlight freq\n");
> @@ -224,16 +197,87 @@ static void intel_dp_aux_disable_backlight(const struct drm_connector_state *old
>  	set_aux_backlight_enable(enc_to_intel_dp(old_conn_state->best_encoder), false);
>  }
>  
> +static u32 intel_dp_aux_calc_max_backlight(struct intel_connector *connector)
> +{
> +	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
> +	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
> +	u32 max_backlight = 0;
> +	int freq, fxp, fxp_min, fxp_max, fxp_actual, f = 1;
> +	u8 pn, pn_min, pn_max;
> +
> +	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT, &pn)) {
> +		pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +		max_backlight = (1 << pn) - 1;
> +	}

If the dpcd read fails, pn may be uninitialized; need to check the
return value properly here.

Otherwise, seems fine, though unnecessarily complicated but that's
hardly your fault...


BR,
Jani.

> +
> +	/* Find desired value of (F x P)
> +	 * Note that, if F x P is out of supported range, the maximum value or
> +	 * minimum value will applied automatically. So no need to check that.
> +	 */
> +	freq = dev_priv->vbt.backlight.pwm_freq_hz;
> +	DRM_DEBUG_KMS("VBT defined backlight frequency %u Hz\n", freq);
> +	if (!freq) {
> +		DRM_DEBUG_KMS("Use panel default backlight frequency\n");
> +		return max_backlight;
> +	}
> +
> +	fxp = DIV_ROUND_CLOSEST(KHz(DP_EDP_BACKLIGHT_FREQ_BASE_KHZ), freq);
> +
> +	/* Use highest possible value of Pn for more granularity of brightness
> +	 * adjustment while satifying the conditions below.
> +	 * - Pn is in the range of Pn_min and Pn_max
> +	 * - F is in the range of 1 and 255
> +	 * - FxP is within 25% of desired value.
> +	 *   Note: 25% is arbitrary value and may need some tweak.
> +	 */
> +	if (drm_dp_dpcd_readb(&intel_dp->aux,
> +			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min) != 1) {
> +		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap min\n");
> +		return max_backlight;
> +	}
> +	if (drm_dp_dpcd_readb(&intel_dp->aux,
> +			       DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max) != 1) {
> +		DRM_DEBUG_KMS("Failed to read pwmgen bit count cap max\n");
> +		return max_backlight;
> +	}
> +	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> +
> +	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
> +	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);
> +	if (fxp_min < (1 << pn_min) || (255 << pn_max) < fxp_max) {
> +		DRM_DEBUG_KMS("VBT defined backlight frequency out of range\n");
> +		return max_backlight;
> +	}
> +
> +	for (pn = pn_max; pn >= pn_min; pn--) {
> +		f = clamp(DIV_ROUND_CLOSEST(fxp, 1 << pn), 1, 255);
> +		fxp_actual = f << pn;
> +		if (fxp_min <= fxp_actual && fxp_actual <= fxp_max)
> +			break;
> +	}
> +
> +	if (drm_dp_dpcd_writeb(&intel_dp->aux,
> +			       DP_EDP_PWMGEN_BIT_COUNT, pn) < 0) {
> +		DRM_DEBUG_KMS("Failed to write aux pwmgen bit count\n");
> +		return max_backlight;
> +	}
> +
> +	max_backlight = (1 << pn) - 1;
> +
> +	return max_backlight;
> +}
> +
>  static int intel_dp_aux_setup_backlight(struct intel_connector *connector,
>  					enum pipe pipe)
>  {
>  	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
>  	struct intel_panel *panel = &connector->panel;
>  
> -	if (intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
> -		panel->backlight.max = 0xFFFF;
> -	else
> -		panel->backlight.max = 0xFF;
> +	panel->backlight.max = intel_dp_aux_calc_max_backlight(connector);
> +
> +	if (!panel->backlight.max)
> +		return -ENODEV;
>  
>  	panel->backlight.min = 0;
>  	panel->backlight.level = intel_dp_aux_get_backlight(connector);

-- 
Jani Nikula, Intel Open Source Graphics Center

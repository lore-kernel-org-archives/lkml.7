Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BEF2073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCMk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:40:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:30336 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfLCMk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:40:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:40:26 -0800
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="204961932"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:40:21 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/i915: Assume 100% brightness when not in DPCD control mode
In-Reply-To: <20191122231616.2574-3-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191122231616.2574-1-lyude@redhat.com> <20191122231616.2574-3-lyude@redhat.com>
Date:   Tue, 03 Dec 2019 14:40:18 +0200
Message-ID: <87tv6hinv1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Lyude Paul <lyude@redhat.com> wrote:
> Currently we always determine the initial panel brightness level by
> simply reading the value from DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB. This
> seems wrong though, because if the panel is not currently in DPCD
> control mode there's not really any reason why there would be any
> brightness value programmed in the first place.
>
> This appears to be the case on the Lenovo ThinkPad X1 Extreme 2nd
> Generation, where the default value in these registers is always 0 on
> boot despite the fact the panel runs at max brightness by default.
> Getting the initial brightness value correct here is important as well,
> since the panel on this laptop doesn't behave well if it's ever put into
> DPCD control mode while the brightness level is programmed to 0.
>
> So, let's fix this by checking what the current backlight control mode
> is before reading the brightness level. If it's in DPCD control mode, we
> return the programmed brightness level. Otherwise we assume 100%
> brightness and return the highest possible brightness level. This also
> prevents us from accidentally programming a brightness level of 0.
>
> This is one of the many fixes that gets backlight controls working on
> the ThinkPad X1 Extreme 2nd Generation with optional 4K AMOLED screen.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  .../gpu/drm/i915/display/intel_dp_aux_backlight.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index fad470553cf9..0bf8772bc7bb 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -59,8 +59,23 @@ static u32 intel_dp_aux_get_backlight(struct intel_connector *connector)
>  {
>  	struct intel_dp *intel_dp = enc_to_intel_dp(&connector->encoder->base);
>  	u8 read_val[2] = { 0x0 };
> +	u8 control_reg;
>  	u16 level = 0;
>  
> +	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_EDP_DISPLAY_CONTROL_REGISTER,

Shouldn't that be DP_EDP_BACKLIGHT_MODE_SET_REGISTER instead?

> +			      &control_reg) != 1) {
> +		DRM_DEBUG_KMS("Failed to read the DPCD register 0x%x\n",
> +			      DP_EDP_DISPLAY_CONTROL_REGISTER);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If we're not in DPCD control mode yet, the programmed brightness
> +	 * value is meaningless and we should assume max brightness
> +	 */
> +	if (!(control_reg & DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD))
> +		return connector->panel.backlight.max;

It's not just a bit, I think you need to check (control_reg & mask) ==
value.

BR,
Jani.

> +
>  	if (drm_dp_dpcd_read(&intel_dp->aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB,
>  			     &read_val, sizeof(read_val)) < 0) {
>  		DRM_DEBUG_KMS("Failed to read DPCD register 0x%x\n",

-- 
Jani Nikula, Intel Open Source Graphics Center

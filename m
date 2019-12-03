Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111AA20803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfLCMmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:42:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:54928 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfLCMmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:42:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:42:23 -0800
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="213397102"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:42:19 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED panel
In-Reply-To: <20191122231616.2574-6-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191122231616.2574-1-lyude@redhat.com> <20191122231616.2574-6-lyude@redhat.com>
Date:   Tue, 03 Dec 2019 14:42:17 +0200
Message-ID: <87lfrtinrq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Lyude Paul <lyude@redhat.com> wrote:
> Annoyingly, the VBT on the ThinkPad X1 Extreme 2nd Gen indicates that
> the system uses plain PWM based backlight controls, when in reality the
> only backlight controls that work are the standard VESA eDP DPCD
> backlight controls.
>
> Honestly, this makes me wonder how many other systems have these issues
> or lie about this in their VBT. Not sure we have any good way of finding
> out until panels like this become more common place in the laptop
> market. For now, just add a DRM DP quirk to indicate that this panel is
> telling the truth and is being a good LCD.
>
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=112376
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_dp_helper.c                       |  4 ++++
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 10 ++++++++--
>  include/drm/drm_dp_helper.h                           |  8 ++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 2c7870aef469..ec7061e3a99b 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -1155,6 +1155,10 @@ static const struct dpcd_quirk dpcd_quirk_list[] = {
>  	{ OUI(0x00, 0x10, 0xfa), DEVICE_ID_ANY, false, BIT(DP_DPCD_QUIRK_NO_PSR) },
>  	/* CH7511 seems to leave SINK_COUNT zeroed */
>  	{ OUI(0x00, 0x00, 0x00), DEVICE_ID('C', 'H', '7', '5', '1', '1'), false, BIT(DP_DPCD_QUIRK_NO_SINK_COUNT) },
> +	/* Optional 4K AMOLED panel in the ThinkPad X1 Extreme 2nd Generation
> +	 * only supports DPCD backlight controls, despite advertising otherwise
> +	 */
> +	{ OUI(0xba, 0x41, 0x59), DEVICE_ID_ANY, false, BIT(DP_DPCD_QUIRK_FORCE_DPCD_BACKLIGHT) },
>  };
>  
>  #undef OUI
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 87b59db9ffe3..3d61260b08ad 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -325,11 +325,17 @@ intel_dp_aux_display_control_capable(struct intel_connector *connector)
>  int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
>  {
>  	struct intel_panel *panel = &intel_connector->panel;
> -	struct drm_i915_private *dev_priv = to_i915(intel_connector->base.dev);
> +	struct intel_dp *intel_dp =
> +		enc_to_intel_dp(&intel_connector->encoder->base);
> +	struct drm_i915_private *dev_priv =
> +		to_i915(intel_connector->base.dev);
>  
>  	if (i915_modparams.enable_dpcd_backlight == 0 ||
>  	    (i915_modparams.enable_dpcd_backlight == -1 &&
> -	    dev_priv->vbt.backlight.type != INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE))
> +	     dev_priv->vbt.backlight.type !=
> +		     INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE &&
> +	     !drm_dp_has_quirk(&intel_dp->desc,
> +			       DP_DPCD_QUIRK_FORCE_DPCD_BACKLIGHT)))
>  		return -ENODEV;
>  
>  	if (!intel_dp_aux_display_control_capable(intel_connector))
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 51ecb5112ef8..a444209cd54b 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1520,6 +1520,14 @@ enum drm_dp_quirk {
>  	 * The driver should ignore SINK_COUNT during detection.
>  	 */
>  	DP_DPCD_QUIRK_NO_SINK_COUNT,
> +	/**
> +	 * @DP_DPCD_QUIRK_FORCE_DPCD_BACKLIGHT:
> +	 *
> +	 * The device is telling the truth when it says that it uses DPCD
> +	 * backlight controls, even if the system's firmware disagrees.
> +	 * The driver should honor the DPCD backlight capabilities advertised.
> +	 */
> +	DP_DPCD_QUIRK_FORCE_DPCD_BACKLIGHT,
>  };
>  
>  /**

-- 
Jani Nikula, Intel Open Source Graphics Center

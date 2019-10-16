Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C1FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D903820872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404644AbfJPKdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:33:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:32846 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfJPKdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:33:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 03:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="189639979"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 16 Oct 2019 03:33:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 16 Oct 2019 13:33:06 +0300
Date:   Wed, 16 Oct 2019 13:33:06 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: Re: [PATCH] drm/i915/hdmi: enable resolution 3840x2160 for type 1
 HDMI
Message-ID: <20191016103306.GL1208@intel.com>
References: <20191016095757.4919-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016095757.4919-1-jian-hong@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 05:57:58PM +0800, Jian-Hong Pan wrote:
> Type 1 HDMI may be version 1.3 or upper, which supports higher max TMDS
> clock for higher resolutions,

Spec says "Type 1 adaptors can support DVI or HDMI up to a 165MHz TMDS clock rate."

And I've definitely seen HDMI dongles that can't deal with
eg. 1080p 12bpc @225MHz. We don't want users with black screens
out of the box, so NAK.

If you want to "overclock" your hardware you can do so by setting up
the modeline manually.

> like 3840x2160. This patch sets max TMDS
> clock according to the chip, if the adapter is type 1 HDMI.
> 
> Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=112018
> Fixes: b1ba124d8e95 ("drm/i915: Respect DP++ adaptor TMDS clock limit")
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index e02f0faecf02..74e4426ffcad 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2454,6 +2454,7 @@ intel_hdmi_dp_dual_mode_detect(struct drm_connector *connector, bool has_edid)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(connector->dev);
>  	struct intel_hdmi *hdmi = intel_attached_hdmi(connector);
> +	struct intel_encoder *encoder = &hdmi_to_dig_port(hdmi)->base;
>  	enum port port = hdmi_to_dig_port(hdmi)->base.port;
>  	struct i2c_adapter *adapter =
>  		intel_gmbus_get_adapter(dev_priv, hdmi->ddc_bus);
> @@ -2488,8 +2489,16 @@ intel_hdmi_dp_dual_mode_detect(struct drm_connector *connector, bool has_edid)
>  		return;
>  
>  	hdmi->dp_dual_mode.type = type;
> -	hdmi->dp_dual_mode.max_tmds_clock =
> -		drm_dp_dual_mode_max_tmds_clock(type, adapter);
> +	/* Type 1 HDMI may be version 1.3 or upper, which supports higher max
> +	 * TMDS clock for higher resolutions, like 3840x2160. So, set it
> +	 * according to the chip, if the adapter is type 1 HDMI.
> +	 */
> +	if (type == DRM_DP_DUAL_MODE_TYPE1_HDMI)
> +		hdmi->dp_dual_mode.max_tmds_clock =
> +			intel_hdmi_source_max_tmds_clock(encoder);
> +	else
> +		hdmi->dp_dual_mode.max_tmds_clock =
> +			drm_dp_dual_mode_max_tmds_clock(type, adapter);
>  
>  	DRM_DEBUG_KMS("DP dual mode adaptor (%s) detected (max TMDS clock: %d kHz)\n",
>  		      drm_dp_get_dual_mode_type_name(type),
> -- 
> 2.23.0

-- 
Ville Syrjälä
Intel

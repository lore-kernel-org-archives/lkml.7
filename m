Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87C3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFEF212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfFXNYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:24:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:15973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfFXNYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:24:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 06:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="163322976"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 24 Jun 2019 06:24:13 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 24 Jun 2019 16:24:13 +0300
Date:   Mon, 24 Jun 2019 16:24:13 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, CK Hu <ck.hu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Intel-gfx] [PATCH v3 3/4] drm/connector: Split out orientation
 quirk detection
Message-ID: <20190624132413.GN5942@intel.com>
References: <20190622034105.188454-1-dbasehore@chromium.org>
 <20190622034105.188454-4-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190622034105.188454-4-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 08:41:04PM -0700, Derek Basehore wrote:
> Not every platform needs quirk detection for panel orientation, so
> split the drm_connector_init_panel_orientation_property into two
> functions. One for platforms without the need for quirks, and the
> other for platforms that need quirks.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/gpu/drm/drm_connector.c | 45 ++++++++++++++++++++++++---------
>  drivers/gpu/drm/i915/intel_dp.c |  4 +--
>  drivers/gpu/drm/i915/vlv_dsi.c  |  5 ++--
>  include/drm/drm_connector.h     |  2 ++
>  4 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index e17586aaa80f..c4b01adf927a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1894,31 +1894,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
>   * drm_connector_init_panel_orientation_property -
>   *	initialize the connecters panel_orientation property
>   * @connector: connector for which to init the panel-orientation property.
> - * @width: width in pixels of the panel, used for panel quirk detection
> - * @height: height in pixels of the panel, used for panel quirk detection
>   *
>   * This function should only be called for built-in panels, after setting
>   * connector->display_info.panel_orientation first (if known).
>   *
> - * This function will check for platform specific (e.g. DMI based) quirks
> - * overriding display_info.panel_orientation first, then if panel_orientation
> - * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
> - * "panel orientation" property to the connector.
> + * This function will check if the panel_orientation is not
> + * DRM_MODE_PANEL_ORIENTATION_UNKNOWN. If not, it will attach the "panel
> + * orientation" property to the connector.
>   *
>   * Returns:
>   * Zero on success, negative errno on failure.
>   */
>  int drm_connector_init_panel_orientation_property(
> -	struct drm_connector *connector, int width, int height)
> +	struct drm_connector *connector)
>  {
>  	struct drm_device *dev = connector->dev;
>  	struct drm_display_info *info = &connector->display_info;
>  	struct drm_property *prop;
> -	int orientation_quirk;
> -
> -	orientation_quirk = drm_get_panel_orientation_quirk(width, height);
> -	if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> -		info->panel_orientation = orientation_quirk;
>  
>  	if (info->panel_orientation == DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
>  		return 0;
> @@ -1941,6 +1933,35 @@ int drm_connector_init_panel_orientation_property(
>  }
>  EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
>  
> +/**
> + * drm_connector_init_panel_orientation_property_quirk -
> + *	initialize the connecters panel_orientation property with a quirk
> + *	override
> + * @connector: connector for which to init the panel-orientation property.
> + * @width: width in pixels of the panel, used for panel quirk detection
> + * @height: height in pixels of the panel, used for panel quirk detection
> + *
> + * This function will check for platform specific (e.g. DMI based) quirks
> + * overriding display_info.panel_orientation first, then if panel_orientation
> + * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
> + * "panel orientation" property to the connector.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_init_panel_orientation_property_quirk(
> +	struct drm_connector *connector, int width, int height)
> +{
> +	int orientation_quirk;
> +
> +	orientation_quirk = drm_get_panel_orientation_quirk(width, height);
> +	if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> +		connector->display_info.panel_orientation = orientation_quirk;
> +
> +	return drm_connector_init_panel_orientation_property(connector);
> +}
> +EXPORT_SYMBOL(drm_connector_init_panel_orientation_property_quirk);
> +
>  int drm_connector_set_obj_prop(struct drm_mode_object *obj,
>  				    struct drm_property *property,
>  				    uint64_t value)
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index b099a9dc28fd..7d4e61cf5463 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -7282,8 +7282,8 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
>  	intel_panel_setup_backlight(connector, pipe);
>  
>  	if (fixed_mode)
> -		drm_connector_init_panel_orientation_property(
> -			connector, fixed_mode->hdisplay, fixed_mode->vdisplay);
> +		drm_connector_init_panel_orientation_property_quirk(connector,
> +				fixed_mode->hdisplay, fixed_mode->vdisplay);
>  
>  	return true;
>  
> diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_dsi.c
> index bfe2891eac37..fa9833dbe359 100644
> --- a/drivers/gpu/drm/i915/vlv_dsi.c
> +++ b/drivers/gpu/drm/i915/vlv_dsi.c
> @@ -1650,6 +1650,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
>  
>  	if (connector->panel.fixed_mode) {
>  		u32 allowed_scalers;
> +		int orientation;
>  
>  		allowed_scalers = BIT(DRM_MODE_SCALE_ASPECT) | BIT(DRM_MODE_SCALE_FULLSCREEN);
>  		if (!HAS_GMCH(dev_priv))
> @@ -1660,9 +1661,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
>  
>  		connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>  
> -		connector->base.display_info.panel_orientation =
> -			vlv_dsi_get_panel_orientation(connector);

Where did that go?

> -		drm_connector_init_panel_orientation_property(
> +		drm_connector_init_panel_orientation_property_quirk(
>  				&connector->base,
>  				connector->panel.fixed_mode->hdisplay,
>  				connector->panel.fixed_mode->vdisplay);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 47e749b74e5f..0468fd9a4418 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1370,6 +1370,8 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
>  void drm_connector_set_vrr_capable_property(
>  		struct drm_connector *connector, bool capable);
>  int drm_connector_init_panel_orientation_property(
> +	struct drm_connector *connector);
> +int drm_connector_init_panel_orientation_property_quirk(
>  	struct drm_connector *connector, int width, int height);
>  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  					  int min, int max);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel

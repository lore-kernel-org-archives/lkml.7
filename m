Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C342ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C837D20659
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Tk5DQyTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfJGQpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:45:53 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44716 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:45:53 -0400
Received: by mail-yw1-f67.google.com with SMTP id m13so5347871ywa.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uEyShXTm+JB/9yQz06mq2i1GCRkvjAHHbIYroAF3Vr0=;
        b=Tk5DQyTRms31VYqgiblUm3XBadR+cInO4hstTpWWznvGEhyMDevpPGQMjKyumlw69b
         9jpcL/P8lseJkQuJd31PZ15bFTzbsRCuw/eEYKrUWHcLJyJYwne6cc06GDvjHQTJWiQ0
         RviTBIL/8SB90UPyTdnJUJcfqfA2Hc50CxITCPPF7ftBI8eCKooT/lEs76OOabmC512H
         6pleyCDi/nG9STxP4KFNi0XhXIBgvlLpGD6wwkdjrztDaOMgMIJRxTpfvHGFhc9zaA8y
         dygwEkT2aHOY8LvO0ztCqW0LZrR+YfCMwYb02vQckOACq45Bsi+XwIhOU4Q76grOv/HL
         etCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEyShXTm+JB/9yQz06mq2i1GCRkvjAHHbIYroAF3Vr0=;
        b=aPYfRnJttJbF5E5fti2FfkE62xglsFICbEoC8HNdFn1Shse2WsEMKvqApDRczdNy9x
         285msx1jCfZLw3/6kZnChzQoD2TtSJKgZXOtWsMURFDkdu8sjkiPLIsKlWUs3U8pnEKC
         TLI4J/ZRbsPfSZOUVdiXS6BoEvlBUbtLfIFRiKASBcCvbZK97E15aoWMgfVwCMJ6Y0EJ
         Cu4h0znFcETJPv9DIFpoL4TuTHia6YBCpE3B1qlGAsPOzhyZ08tSubf2PYZ0fPj/5tgf
         r9Bfka0mHfR+dOezpFh4fQxPLfgOIK0nlPcxVUekG086Hmoa+/X3h9cNDAztwv94Vv8W
         qlBA==
X-Gm-Message-State: APjAAAXkKUkMKy7maorVFUq8k83s5bs+hq0GzGtI+/1x8b+hdC4sNeIB
        D9TtUpBzo5tlANXienw2DoZLFw==
X-Google-Smtp-Source: APXvYqxYNV4BfGQcvE7fKKbfOFn6gRKJ4xfGQW2Cm3ncGszU5Tg91sABL7qjuz4H/GsDeDQDffiWNw==
X-Received: by 2002:a81:6589:: with SMTP id z131mr19011625ywb.262.1570466752240;
        Mon, 07 Oct 2019 09:45:52 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k6sm4135994ywh.60.2019.10.07.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:45:51 -0700 (PDT)
Date:   Mon, 7 Oct 2019 12:45:51 -0400
From:   Sean Paul <sean@poorly.run>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 3/4] drm/connector: Split out orientation quirk
 detection
Message-ID: <20191007164551.GC126146@art_vandelay>
References: <20190925225833.7310-1-dbasehore@chromium.org>
 <20190925225833.7310-4-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925225833.7310-4-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:58:32PM -0700, Derek Basehore wrote:
> Not every platform needs quirk detection for panel orientation, so
> split the drm_connector_init_panel_orientation_property into two
> functions. One for platforms without the need for quirks, and the
> other for platforms that need quirks.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>  drivers/gpu/drm/drm_connector.c         | 45 ++++++++++++++++++-------
>  drivers/gpu/drm/i915/display/icl_dsi.c  |  2 +-
>  drivers/gpu/drm/i915/display/intel_dp.c |  4 +--
>  drivers/gpu/drm/i915/display/vlv_dsi.c  |  2 +-
>  include/drm/drm_connector.h             |  2 ++
>  5 files changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 4c766624b20d..faef25683faf 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1989,31 +1989,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
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
> @@ -2036,6 +2028,35 @@ int drm_connector_init_panel_orientation_property(
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
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index 6e398c33a524..483287984090 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -1538,7 +1538,7 @@ static void icl_dsi_add_properties(struct intel_connector *connector)
>  
>  	connector->base.display_info.panel_orientation =
>  			intel_dsi_get_panel_orientation(connector);
> -	drm_connector_init_panel_orientation_property(&connector->base,
> +	drm_connector_init_panel_orientation_property_quirk(&connector->base,
>  				connector->panel.fixed_mode->hdisplay,
>  				connector->panel.fixed_mode->vdisplay);
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 921ad0a2f7ba..419413fa8165 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -7076,8 +7076,8 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
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
> diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
> index a71b22bdd95b..46cfb0821c17 100644
> --- a/drivers/gpu/drm/i915/display/vlv_dsi.c
> +++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
> @@ -1634,7 +1634,7 @@ static void vlv_dsi_add_properties(struct intel_connector *connector)
>  
>  		connector->base.display_info.panel_orientation =
>  			vlv_dsi_get_panel_orientation(connector);
> -		drm_connector_init_panel_orientation_property(
> +		drm_connector_init_panel_orientation_property_quirk(
>  				&connector->base,
>  				connector->panel.fixed_mode->hdisplay,
>  				connector->panel.fixed_mode->vdisplay);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 681cb590f952..e3416ac11478 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1540,6 +1540,8 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
>  void drm_connector_set_vrr_capable_property(
>  		struct drm_connector *connector, bool capable);
>  int drm_connector_init_panel_orientation_property(
> +	struct drm_connector *connector);
> +int drm_connector_init_panel_orientation_property_quirk(
>  	struct drm_connector *connector, int width, int height);
>  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  					  int min, int max);
> -- 
> 2.23.0.351.gc4317032e6-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

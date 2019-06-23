Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0048C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4281205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfFWMLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:11:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40167 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfFWMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:11:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so17107841eds.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 05:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nakBwI4sZGx37gf/nqQhnhkTTc4nH7gPn8eeyN2vS8M=;
        b=jGJKD4H9hav46bGdbMRlwdFbQNtIosjeL9nmtg4PQxbF4b2vnJgf/GBWTMv4mvksoE
         jU8CUz2lkZC7lPHez6AYfVRv/kNb4TkRSDBl2m/bfZKaHwJpPlssrF9y+8uB+AbeoU6U
         6bL7uGnkisooGmPjyOTSwiHLAHGjVNQ5rIRl5ySz1zX/0DApJxSkywqXALXaSFA672Pq
         w7TbPLPsCjDrfqfHtfWJozy7vqbF1tZvNZOLKCY/2V0aR0U+tFmG52brJdSnfJlYitjS
         H21m/ZyMvBRPYvLvJP2gt/tMi00PB5qpw7AE1ljjgtmuNzRXLP3oUCC6VXF3gCbpy6Dv
         jrxA==
X-Gm-Message-State: APjAAAWOOIGywyZEQB67suJ+qxNwGmi75OGlcliXyAIbGWlomW1w1Hiu
        MLYcFlzPj5b4xCh4M0qYfnV+8Q==
X-Google-Smtp-Source: APXvYqyZ6F4Gqyf1cneAQ+IhpWxmyuyOUQ4oEoz0is6nrggMhomfTzXpIIkJ0JA2pB63Ppiz79GlZw==
X-Received: by 2002:a50:f781:: with SMTP id h1mr90781547edn.240.1561291868076;
        Sun, 23 Jun 2019 05:11:08 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y3sm2661992edr.27.2019.06.23.05.11.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 05:11:07 -0700 (PDT)
Subject: Re: [Intel-gfx] [PATCH v3 3/4] drm/connector: Split out orientation
 quirk detection
To:     Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, CK Hu <ck.hu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190622034105.188454-1-dbasehore@chromium.org>
 <20190622034105.188454-4-dbasehore@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ff551bd8-ab2b-a89f-281b-5b3d3c285efc@redhat.com>
Date:   Sun, 23 Jun 2019 14:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190622034105.188454-4-dbasehore@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-06-19 05:41, Derek Basehore wrote:
> Not every platform needs quirk detection for panel orientation, so
> split the drm_connector_init_panel_orientation_property into two
> functions. One for platforms without the need for quirks, and the
> other for platforms that need quirks.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>   drivers/gpu/drm/drm_connector.c | 45 ++++++++++++++++++++++++---------
>   drivers/gpu/drm/i915/intel_dp.c |  4 +--
>   drivers/gpu/drm/i915/vlv_dsi.c  |  5 ++--
>   include/drm/drm_connector.h     |  2 ++
>   4 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index e17586aaa80f..c4b01adf927a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1894,31 +1894,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
>    * drm_connector_init_panel_orientation_property -
>    *	initialize the connecters panel_orientation property
>    * @connector: connector for which to init the panel-orientation property.
> - * @width: width in pixels of the panel, used for panel quirk detection
> - * @height: height in pixels of the panel, used for panel quirk detection
>    *
>    * This function should only be called for built-in panels, after setting
>    * connector->display_info.panel_orientation first (if known).
>    *
> - * This function will check for platform specific (e.g. DMI based) quirks
> - * overriding display_info.panel_orientation first, then if panel_orientation
> - * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
> - * "panel orientation" property to the connector.
> + * This function will check if the panel_orientation is not
> + * DRM_MODE_PANEL_ORIENTATION_UNKNOWN. If not, it will attach the "panel
> + * orientation" property to the connector.
>    *
>    * Returns:
>    * Zero on success, negative errno on failure.
>    */
>   int drm_connector_init_panel_orientation_property(
> -	struct drm_connector *connector, int width, int height)
> +	struct drm_connector *connector)
>   {
>   	struct drm_device *dev = connector->dev;
>   	struct drm_display_info *info = &connector->display_info;
>   	struct drm_property *prop;
> -	int orientation_quirk;
> -
> -	orientation_quirk = drm_get_panel_orientation_quirk(width, height);
> -	if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> -		info->panel_orientation = orientation_quirk;
>   
>   	if (info->panel_orientation == DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
>   		return 0;
> @@ -1941,6 +1933,35 @@ int drm_connector_init_panel_orientation_property(
>   }
>   EXPORT_SYMBOL(drm_connector_init_panel_orientation_property);
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
>   int drm_connector_set_obj_prop(struct drm_mode_object *obj,
>   				    struct drm_property *property,
>   				    uint64_t value)
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index b099a9dc28fd..7d4e61cf5463 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -7282,8 +7282,8 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
>   	intel_panel_setup_backlight(connector, pipe);
>   
>   	if (fixed_mode)
> -		drm_connector_init_panel_orientation_property(
> -			connector, fixed_mode->hdisplay, fixed_mode->vdisplay);
> +		drm_connector_init_panel_orientation_property_quirk(connector,
> +				fixed_mode->hdisplay, fixed_mode->vdisplay);
>   
>   	return true;
>   
> diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_dsi.c
> index bfe2891eac37..fa9833dbe359 100644
> --- a/drivers/gpu/drm/i915/vlv_dsi.c
> +++ b/drivers/gpu/drm/i915/vlv_dsi.c
> @@ -1650,6 +1650,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
>   
>   	if (connector->panel.fixed_mode) {
>   		u32 allowed_scalers;
> +		int orientation;
>   
>   		allowed_scalers = BIT(DRM_MODE_SCALE_ASPECT) | BIT(DRM_MODE_SCALE_FULLSCREEN);
>   		if (!HAS_GMCH(dev_priv))

The above chunk seems to be a leftover from the previous version of this series.

Otherwise this patch looks good, with this fixed you can add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> @@ -1660,9 +1661,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
>   
>   		connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>   
> -		connector->base.display_info.panel_orientation =
> -			vlv_dsi_get_panel_orientation(connector);
> -		drm_connector_init_panel_orientation_property(
> +		drm_connector_init_panel_orientation_property_quirk(
>   				&connector->base,
>   				connector->panel.fixed_mode->hdisplay,
>   				connector->panel.fixed_mode->vdisplay);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 47e749b74e5f..0468fd9a4418 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1370,6 +1370,8 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
>   void drm_connector_set_vrr_capable_property(
>   		struct drm_connector *connector, bool capable);
>   int drm_connector_init_panel_orientation_property(
> +	struct drm_connector *connector);
> +int drm_connector_init_panel_orientation_property_quirk(
>   	struct drm_connector *connector, int width, int height);
>   int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>   					  int min, int max);
> 

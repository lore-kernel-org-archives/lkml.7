Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE70C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4266B204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF3UWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 16:22:53 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:34876 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF3UWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 16:22:53 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B93E120070;
        Sun, 30 Jun 2019 22:22:47 +0200 (CEST)
Date:   Sun, 30 Jun 2019 22:22:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, mka@chromium.org
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override
 typical timing
Message-ID: <20190630202246.GB15102@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401171724.215780-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=cm27Pg_UAAAA:8
        a=-VAfIpHNAAAA:8 a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=VQv1v-rfpna5m5GkDzwA:9
        a=WdM8EmG1RyxdikVb:21 a=PK01xQEQwDdgTzne:21 a=wPNLvfGTeEIA:10
        a=xmb-EsYY8bH0VWELuYED:22 a=srlwD-8ojaedGGhPAyx8:22
        a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas.

Again, long overdue. The review triggered several questions that you
should have had a long time ago.
Hopefully they makes sense to you.

	Sam

On Mon, Apr 01, 2019 at 10:17:19AM -0700, Douglas Anderson wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds the ability to override the typical display timing for a
> given panel. This is useful for devices which have timing constraints
> that do not apply across the entire display driver (eg: to avoid
> crosstalk between panel and digitizer on certain laptops). The rules are
> as follows:
> 
> - panel must not specify fixed mode (since the override mode will
>   either be the same as the fixed mode, or we'll be unable to
>   check the bounds of the overried)
> - panel must specify at least one display_timing range which will be
>   used to ensure the override mode fits within its bounds
> 
> Changes in v2:
>  - Parse the full display-timings node (using the native-mode) (Rob)
> Changes in v3:
>  - No longer parse display-timings subnode, use panel-timing (Rob)
> Changes in v4:
>  - Don't add mode from timing if override was specified (Thierry)
>  - Add warning if timing and fixed mode was specified (Thierry)
>  - Don't add fixed mode if timing was specified (Thierry)
>  - Refactor/rename a bit to avoid extra indentation from "if" tests
>  - i should be unsigned (Thierry)
>  - Add annoying WARN_ONs for some cases (Thierry)
>  - Simplify 'No display_timing found' handling (Thierry)
>  - Rename to panel_simple_parse_override_mode() (Thierry)
> Changes in v5:
>  - Added Heiko's Tested-by
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> 
>  drivers/gpu/drm/panel/panel-simple.c | 109 +++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9e8218f6a3f2..ad4f4aac2d44 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -34,6 +34,7 @@
>  #include <drm/drm_panel.h>
>  
>  #include <video/display_timing.h>
> +#include <video/of_display_timing.h>
>  #include <video/videomode.h>
>  
>  struct panel_desc {
> @@ -91,6 +92,8 @@ struct panel_simple {
>  	struct i2c_adapter *ddc;
>  
>  	struct gpio_desc *enable_gpio;
> +
> +	struct drm_display_mode override_mode;
I fail to see where this poiter is assigned.


>  };
>  
>  static inline struct panel_simple *to_panel_simple(struct drm_panel *panel)
> @@ -98,16 +101,13 @@ static inline struct panel_simple *to_panel_simple(struct drm_panel *panel)
>  	return container_of(panel, struct panel_simple, base);
>  }
>  
> -static int panel_simple_get_fixed_modes(struct panel_simple *panel)
> +static unsigned int panel_simple_get_timings_modes(struct panel_simple *panel)
>  {
>  	struct drm_connector *connector = panel->base.connector;
>  	struct drm_device *drm = panel->base.drm;
>  	struct drm_display_mode *mode;
>  	unsigned int i, num = 0;
>  
> -	if (!panel->desc)
> -		return 0;
> -
>  	for (i = 0; i < panel->desc->num_timings; i++) {
>  		const struct display_timing *dt = &panel->desc->timings[i];
>  		struct videomode vm;
> @@ -131,6 +131,16 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
>  		num++;
>  	}
>  
> +	return num;
> +}
> +
> +static unsigned int panel_simple_get_fixed_modes(struct panel_simple *panel)
> +{
> +	struct drm_connector *connector = panel->base.connector;
> +	struct drm_device *drm = panel->base.drm;
> +	struct drm_display_mode *mode;
> +	unsigned int i, num = 0;
> +
>  	for (i = 0; i < panel->desc->num_modes; i++) {
>  		const struct drm_display_mode *m = &panel->desc->modes[i];
>  
> @@ -152,6 +162,44 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
>  		num++;
>  	}
>  
> +	return num;
> +}
> +
> +static int panel_simple_get_non_edid_modes(struct panel_simple *panel)
> +{
> +	struct drm_connector *connector = panel->base.connector;
> +	struct drm_device *drm = panel->base.drm;
> +	struct drm_display_mode *mode;
> +	bool has_override = panel->override_mode.type;
This looks suspicious.
panel->override_mode.type is an unsigned int that may have a number of
bits set.
So the above code implicitly convert a .type != 0 to a true.
This can be expressed in a much more reader friendly way.

And on top of this, I cannot see that panel->override_mode points to a
valid instance of display_mode, at least not always.
> +	unsigned int num = 0;
> +
> +	if (!panel->desc)
> +		return 0;
> +
> +	if (has_override) {
> +		mode = drm_mode_duplicate(drm, &panel->override_mode);
> +		if (mode) {
> +			drm_mode_probed_add(connector, mode);
> +			num = 1;
> +		} else {
> +			dev_err(drm->dev, "failed to add override mode\n");
> +		}
> +	}
> +
> +	/* Only add timings if override was not there or failed to validate */
> +	if (num == 0 && panel->desc->num_timings)
> +		num = panel_simple_get_timings_modes(panel);
> +
> +	/*
> +	 * Only add fixed modes if timings/override added no mode.

This part I fail to understand.
If we have a panel where we in panel-simple have specified the timings,
and done so using display_timing so with proper {min, typ, max} then it
should be perfectly legal to specify a more precise variant in the DT
file.
Or what did I miss here?

> +	 *
> +	 * We should only ever have either the display timings specified
> +	 * or a fixed mode. Anything else is rather bogus.
> +	 */
> +	WARN_ON(panel->desc->num_timings && panel->desc->num_modes);
> +	if (num == 0)
> +		num = panel_simple_get_fixed_modes(panel);
> +
>  	connector->display_info.bpc = panel->desc->bpc;
>  	connector->display_info.width_mm = panel->desc->size.width;
>  	connector->display_info.height_mm = panel->desc->size.height;
> @@ -268,7 +316,7 @@ static int panel_simple_get_modes(struct drm_panel *panel)
>  	}
>  
>  	/* add hard-coded panel modes */
> -	num += panel_simple_get_fixed_modes(p);
> +	num += panel_simple_get_non_edid_modes(p);
>  
>  	return num;
>  }
> @@ -299,10 +347,58 @@ static const struct drm_panel_funcs panel_simple_funcs = {
>  	.get_timings = panel_simple_get_timings,
>  };
>  
> +#define PANEL_SIMPLE_BOUNDS_CHECK(to_check, bounds, field) \
> +	(to_check->field.typ >= bounds->field.min && \
> +	 to_check->field.typ <= bounds->field.max)
> +static void panel_simple_parse_override_mode(struct device *dev,
> +					     struct panel_simple *panel,
> +					     const struct display_timing *ot)
> +{
> +	const struct panel_desc *desc = panel->desc;
> +	struct videomode vm;
> +	unsigned int i;
> +
> +	if (WARN_ON(desc->num_modes)) {
> +		dev_err(dev, "Reject override mode: panel has a fixed mode\n");
> +		return;
> +	}
> +	if (WARN_ON(!desc->num_timings)) {
> +		dev_err(dev, "Reject override mode: no timings specified\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < panel->desc->num_timings; i++) {
> +		const struct display_timing *dt = &panel->desc->timings[i];
> +
> +		if (!PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hactive) ||
> +		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hfront_porch) ||
> +		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hback_porch) ||
> +		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hsync_len) ||
> +		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vactive) ||
> +		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vfront_porch) ||
> +		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vback_porch) ||
> +		    !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vsync_len))
> +			continue;
> +
> +		if (ot->flags != dt->flags)
> +			continue;
The binding do not say anything about flags. Is this check really
needed?

> +
> +		videomode_from_timing(ot, &vm);
> +		drm_display_mode_from_videomode(&vm, &panel->override_mode);

> +		panel->override_mode.type |= DRM_MODE_TYPE_DRIVER |
> +					     DRM_MODE_TYPE_PREFERRED;
> +		break;
> +	}
> +
> +	if (WARN_ON(!panel->override_mode.type))
> +		dev_err(dev, "Reject override mode: No display_timing found\n");
> +}
> +
>  static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  {
>  	struct device_node *backlight, *ddc;
>  	struct panel_simple *panel;
> +	struct display_timing dt;
>  	int err;
>  
>  	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
> @@ -348,6 +444,9 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  		}
>  	}
>  
> +	if (!of_get_display_timing(dev->of_node, "panel-timing", &dt))
> +		panel_simple_parse_override_mode(dev, panel, &dt);
> +
Naming bike-shedding.
With the new node name, the function name
panel_simple_parse_override_mode() could use an update.
Maybe: panel_simple_parse_panel_timing_node()


>  	drm_panel_init(&panel->base);
>  	panel->base.dev = dev;
>  	panel->base.funcs = &panel_simple_funcs;
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

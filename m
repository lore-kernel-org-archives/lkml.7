Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9EC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AF020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfFNPK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:10:26 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:36811 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:10:26 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 081442002E;
        Fri, 14 Jun 2019 17:10:19 +0200 (CEST)
Date:   Fri, 14 Jun 2019 17:10:18 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 2/2] drm/panel: Add support for Raydium RM67191 panel
 driver
Message-ID: <20190614151018.GA28829@ravnborg.org>
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com>
 <1560513063-24995-3-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560513063-24995-3-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=8AirrxEcAAAA:8
        a=mzydPrOCeu2ZGRC9EbsA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert.

On top of the feedback from Fabio here is a bit more.

> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +#include <video/mipi_display.h>
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>

Divide include up in block in following order:

#include <linux/*>

#include <video/*>

#incude <drm/*>

Within each block sort alphabetically.
Do not use the deprecated drmP.h - replace it with the necessary
includes.
Use an empty line between each include block.

> +
> +/* Write Manufacture Command Set Control */
> +#define WRMAUCCTR 0xFE
> +
> +/* Manufacturer Command Set pages (CMD2) */
> +struct cmd_set_entry {
> +	u8 cmd;
> +	u8 param;
> +};
> +
> +/*
> + * There is no description in the Reference Manual about these commands.
> + * We received them from vendor, so just use them as is.
> + */
> +static const struct cmd_set_entry manufacturer_cmd_set[] = {
> +	{0xFE, 0x0B},
> +	{0x28, 0x40},
> +	{0x29, 0x4F},
...
> +	{0x51, 0x04},
> +};
> +
> +static const u32 rad_bus_formats[] = {
> +	MEDIA_BUS_FMT_RGB888_1X24,
> +	MEDIA_BUS_FMT_RGB666_1X18,
> +	MEDIA_BUS_FMT_RGB565_1X16,
> +};
> +
> +struct rad_panel {
> +	struct drm_panel base;
In the other raydium driver we name this "panel", which is a more
descriptive name.

> +	struct mipi_dsi_device *dsi;
> +
> +	struct gpio_desc *reset;
> +	struct backlight_device *backlight;
> +
> +	bool prepared;
> +	bool enabled;
> +
> +	struct videomode vm;
> +	u32 width_mm;
> +	u32 height_mm;
> +};
> +
> +static int rad_panel_prepare(struct drm_panel *panel)
> +{
> +	struct rad_panel *rad = to_rad_panel(panel);
> +
> +	if (rad->prepared)
> +		return 0;
> +
> +	if (rad->reset) {
> +		gpiod_set_value(rad->reset, 0);
> +		usleep_range(5000, 10000);
> +		gpiod_set_value(rad->reset, 1);
> +		usleep_range(20000, 25000);
> +	}
> +
> +	rad->prepared = true;
> +
> +	return 0;
> +}
> +
> +static int rad_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct rad_panel *rad = to_rad_panel(panel);
> +	struct device *dev = &rad->dsi->dev;
> +
> +	if (!rad->prepared)
> +		return 0;
> +
> +	if (rad->enabled) {
> +		DRM_DEV_ERROR(dev, "Panel still enabled!\n");
> +		return -EPERM;
> +	}
This seems like overkill, what should trigger this?

> +
> +	if (rad->reset) {
> +		gpiod_set_value(rad->reset, 0);
> +		usleep_range(15000, 17000);
> +		gpiod_set_value(rad->reset, 1);
> +	}
> +
> +	rad->prepared = false;
> +
> +	return 0;
> +}
> +
> +static int rad_panel_enable(struct drm_panel *panel)
> +{
> +	struct rad_panel *rad = to_rad_panel(panel);
> +	struct mipi_dsi_device *dsi = rad->dsi;
> +	struct device *dev = &dsi->dev;
> +	int color_format = color_format_from_dsi_format(dsi->format);
> +	u16 brightness;
> +	int ret;
> +
> +	if (rad->enabled)
> +		return 0;
> +
> +	if (!rad->prepared) {
> +		DRM_DEV_ERROR(dev, "Panel not prepared!\n");
> +		return -EPERM;
> +	}
Seems like overkill.

> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	ret = rad_panel_push_cmd_list(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to send MCS (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	/* Select User Command Set table (CMD1) */
> +	ret = mipi_dsi_generic_write(dsi, (u8[]){ WRMAUCCTR, 0x00 }, 2);
> +	if (ret < 0)
> +		goto fail;
> +
> +	/* Software reset */
> +	ret = mipi_dsi_dcs_soft_reset(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to do Software Reset (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	usleep_range(15000, 17000);
> +
> +	/* Set DSI mode */
> +	ret = mipi_dsi_generic_write(dsi, (u8[]){ 0xC2, 0x0B }, 2);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set DSI mode (%d)\n", ret);
> +		goto fail;
> +	}
> +	/* Set tear ON */
> +	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set tear ON (%d)\n", ret);
> +		goto fail;
> +	}
> +	/* Set tear scanline */
> +	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0x380);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set tear scanline (%d)\n", ret);
> +		goto fail;
> +	}
> +	/* Set pixel format */
> +	ret = mipi_dsi_dcs_set_pixel_format(dsi, color_format);
> +	DRM_DEV_DEBUG_DRIVER(dev, "Interface color format set to 0x%x\n",
> +			     color_format);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set pixel format (%d)\n", ret);
> +		goto fail;
> +	}
> +	/* Set display brightness */
> +	brightness = rad->backlight->props.brightness;
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set display brightness (%d)\n",
> +			      ret);
> +		goto fail;
> +	}
brightness is written to again when you enable backlight below.
Seems redundant to do so twice.


> +	/* Exit sleep mode */
> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to exit sleep mode (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	usleep_range(5000, 10000);
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set display ON (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	backlight_enable(rad->backlight);
> +
> +	rad->enabled = true;
> +
> +	return 0;
> +
> +fail:
> +	if (rad->reset)
> +		gpiod_set_value(rad->reset, 0);
> +
> +	return ret;
> +}
> +
> +static int rad_panel_disable(struct drm_panel *panel)
> +{
> +	struct rad_panel *rad = to_rad_panel(panel);
> +	struct mipi_dsi_device *dsi = rad->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	if (!rad->enabled)
> +		return 0;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	backlight_disable(rad->backlight);
> +
> +	usleep_range(10000, 15000);
> +
> +	ret = mipi_dsi_dcs_set_display_off(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set display OFF (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(5000, 10000);
> +
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to enter sleep mode (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	rad->enabled = false;
> +
> +	return 0;
> +}
> +
> +static int rad_panel_get_modes(struct drm_panel *panel)
> +{
> +	struct rad_panel *rad = to_rad_panel(panel);
> +	struct device *dev = &rad->dsi->dev;
> +	struct drm_connector *connector = panel->connector;
> +	struct drm_display_mode *mode;
> +	u32 *bus_flags = &connector->display_info.bus_flags;
> +	int ret;
> +
> +	mode = drm_mode_create(connector->dev);
> +	if (!mode) {
> +		DRM_DEV_ERROR(dev, "Failed to create display mode!\n");
> +		return 0;
> +	}
> +
> +	drm_display_mode_from_videomode(&rad->vm, mode);
> +	mode->width_mm = rad->width_mm;
> +	mode->height_mm = rad->height_mm;
> +	connector->display_info.width_mm = rad->width_mm;
> +	connector->display_info.height_mm = rad->height_mm;
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +
> +	if (rad->vm.flags & DISPLAY_FLAGS_DE_HIGH)
> +		*bus_flags |= DRM_BUS_FLAG_DE_HIGH;
> +	if (rad->vm.flags & DISPLAY_FLAGS_DE_LOW)
> +		*bus_flags |= DRM_BUS_FLAG_DE_LOW;
> +	if (rad->vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +		*bus_flags |= DRM_BUS_FLAG_PIXDATA_NEGEDGE;
> +	if (rad->vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +		*bus_flags |= DRM_BUS_FLAG_PIXDATA_POSEDGE;
> +
> +	ret = drm_display_info_set_bus_formats(&connector->display_info,
> +					       rad_bus_formats,
> +					       ARRAY_SIZE(rad_bus_formats));
> +	if (ret)
> +		return ret;
> +
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	return 1;
> +}
> +
> +static int rad_bl_get_brightness(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +	struct device *dev = &dsi->dev;
> +	u16 brightness;
> +	int ret;
> +
> +	if (!rad->prepared)
> +		return 0;
> +
> +	DRM_DEV_DEBUG_DRIVER(dev, "\n");
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	bl->props.brightness = brightness;
> +
> +	return brightness & 0xff;
> +}
> +
> +static int rad_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +	struct device *dev = &dsi->dev;
> +	int ret = 0;
> +
> +	if (!rad->prepared)
> +		return 0;
> +
> +	DRM_DEV_DEBUG_DRIVER(dev, "New brightness: %d\n", bl->props.brightness);
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, bl->props.brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct backlight_ops rad_bl_ops = {
> +	.update_status = rad_bl_update_status,
> +	.get_brightness = rad_bl_get_brightness,
> +};
> +
> +static const struct drm_panel_funcs rad_panel_funcs = {
> +	.prepare = rad_panel_prepare,
> +	.unprepare = rad_panel_unprepare,
> +	.enable = rad_panel_enable,
> +	.disable = rad_panel_disable,
> +	.get_modes = rad_panel_get_modes,
> +};
> +
> +/*
> + * The clock might range from 66MHz (30Hz refresh rate)
> + * to 132MHz (60Hz refresh rate)
> + */
> +static const struct display_timing rad_default_timing = {
> +	.pixelclock = { 66000000, 132000000, 132000000 },
> +	.hactive = { 1080, 1080, 1080 },
> +	.hfront_porch = { 20, 20, 20 },
> +	.hsync_len = { 2, 2, 2 },
> +	.hback_porch = { 34, 34, 34 },
> +	.vactive = { 1920, 1920, 1920 },
> +	.vfront_porch = { 10, 10, 10 },
> +	.vsync_len = { 2, 2, 2 },
> +	.vback_porch = { 4, 4, 4 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW |
> +		 DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_LOW |
> +		 DISPLAY_FLAGS_PIXDATA_NEGEDGE,
> +};
> +
> +static int rad_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *timings;
> +	struct rad_panel *panel;
> +	struct backlight_properties bl_props;
> +	int ret;
> +	u32 video_mode;
> +
> +	panel = devm_kzalloc(&dsi->dev, sizeof(*panel), GFP_KERNEL);
> +	if (!panel)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, panel);
> +
> +	panel->dsi = dsi;
> +
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags =  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +			   MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +	ret = of_property_read_u32(np, "video-mode", &video_mode);
> +	if (!ret) {
> +		switch (video_mode) {
> +		case 0:
> +			/* burst mode */
> +			dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_BURST;
> +			break;
> +		case 1:
> +			/* non-burst mode with sync event */
> +			break;
> +		case 2:
> +			/* non-burst mode with sync pulse */
> +			dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +			break;
> +		default:
> +			dev_warn(dev, "invalid video mode %d\n", video_mode);
> +			break;
> +		}
> +	}
> +
> +	ret = of_property_read_u32(np, "dsi-lanes", &dsi->lanes);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get dsi-lanes property (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * 'display-timings' is optional, so verify if the node is present
> +	 * before calling of_get_videomode so we won't get console error
> +	 * messages
> +	 */
> +	timings = of_get_child_by_name(np, "display-timings");
> +	if (timings) {
> +		of_node_put(timings);
> +		ret = of_get_videomode(np, &panel->vm, 0);
> +	} else {
> +		videomode_from_timing(&rad_default_timing, &panel->vm);
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	of_property_read_u32(np, "width-mm", &panel->width_mm);
> +	of_property_read_u32(np, "height-mm", &panel->height_mm);
> +
> +	panel->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +
> +	if (IS_ERR(panel->reset))
> +		panel->reset = NULL;
> +	else
> +		gpiod_set_value(panel->reset, 0);
> +
> +	memset(&bl_props, 0, sizeof(bl_props));
> +	bl_props.type = BACKLIGHT_RAW;
> +	bl_props.brightness = 255;
> +	bl_props.max_brightness = 255;
> +
> +	panel->backlight = devm_backlight_device_register(dev, dev_name(dev),
> +							  dev, dsi,
> +							  &rad_bl_ops,
> +							  &bl_props);
> +	if (IS_ERR(panel->backlight)) {
> +		ret = PTR_ERR(panel->backlight);
> +		dev_err(dev, "Failed to register backlight (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	drm_panel_init(&panel->base);
> +	panel->base.funcs = &rad_panel_funcs;
> +	panel->base.dev = dev;
> +	dev_set_drvdata(dev, panel);
> +
> +	ret = drm_panel_add(&panel->base);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0)
> +		drm_panel_remove(&panel->base);
> +
> +	return ret;
> +}
> +
> +static int rad_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		DRM_DEV_ERROR(dev, "Failed to detach from host (%d)\n",
> +			      ret);
> +
> +	drm_panel_remove(&rad->base);
> +
> +	return 0;
> +}
> +
> +static void rad_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
> +
> +	rad_panel_disable(&rad->base);
> +	rad_panel_unprepare(&rad->base);
> +}
> +
> +#ifdef CONFIG_PM
> +static int rad_panel_suspend(struct device *dev)
> +{
> +	struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +	if (!rad->reset)
> +		return 0;
> +
> +	devm_gpiod_put(dev, rad->reset);
> +	rad->reset = NULL;
> +
> +	return 0;
> +}
> +
> +static int rad_panel_resume(struct device *dev)
> +{
> +	struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +	if (rad->reset)
> +		return 0;
> +
> +	rad->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(rad->reset))
> +		rad->reset = NULL;
> +
> +	return PTR_ERR_OR_ZERO(rad->reset);
> +}
> +
> +#endif
No other panels have suspend/resume.
Is it relevant?


> +
> +static const struct dev_pm_ops rad_pm_ops = {
> +	SET_RUNTIME_PM_OPS(rad_panel_suspend, rad_panel_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(rad_panel_suspend, rad_panel_resume)
> +};
> +
> +static const struct of_device_id rad_of_match[] = {
> +	{ .compatible = "raydium,rm67191", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rad_of_match);
> +
> +static struct mipi_dsi_driver rad_panel_driver = {
> +	.driver = {
> +		.name = "panel-raydium-rm67191",
> +		.of_match_table = rad_of_match,
> +		.pm	= &rad_pm_ops,
> +	},
> +	.probe = rad_panel_probe,
> +	.remove = rad_panel_remove,
> +	.shutdown = rad_panel_shutdown,
> +};
> +module_mipi_dsi_driver(rad_panel_driver);
> +
> +MODULE_AUTHOR("Robert Chiras <robert.chiras@nxp.com>");
> +MODULE_DESCRIPTION("DRM Driver for Raydium RM67191 MIPI DSI panel");
> +MODULE_LICENSE("GPL v2");


	Sam

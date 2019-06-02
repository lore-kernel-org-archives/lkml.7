Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F1C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C34279BD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFBSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 14:44:59 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:52266 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfFBSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:44:59 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B9FDD803C0;
        Sun,  2 Jun 2019 20:44:54 +0200 (CEST)
Date:   Sun, 2 Jun 2019 20:44:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH 2/2] drm/panel: Add Novatek NT39016 panel support
Message-ID: <20190602184453.GB10060@ravnborg.org>
References: <20190602164844.15659-1-paul@crapouillou.net>
 <20190602164844.15659-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602164844.15659-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=EHaNKQqtAAAA:8 a=4dAJPdOlH5hFgu4_sGMA:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=KIA0-nbnOXq3vJi0w304:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

Nice driver.
Feedback, mostly a repeat from irc, but you get it here too so others
can follow.

The backlight handling can be simplified.
Please see panel-innolux-p079zca.c as one (semi random) example.

	Sam
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

This driver is authored by Maarten ter Huurne <maarten@treewalker.org>
as well as you.
Could you get a s-o-b or at least some other formal
attribution of Maarten in the changelog.


> +
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <uapi/linux/media-bus-format.h>

Recently (after I was there) panels sort the include in blocks like
this:

#include <linux/*>

#include <other general files from include/*>

#include <drm/*>

Within each block the header files are sorted.

For media-bus-format.h - you could use:
#include <linux/media-bus-format.h>

> +
> +static int nt39016_prepare(struct drm_panel *drm_panel)
> +{
> +	struct nt39016 *panel = to_nt39016(drm_panel);
> +	int err;
> +
> +	err = regulator_enable(panel->supply);
> +	if (err) {
> +		dev_err(panel->dev, "Failed to enable power supply: %i", err);
> +		return err;
> +	}
> +
> +	/*
> +	 * Reset the NT39016.
> +	 * The documentation says the reset pulse should be at least 40 us to
> +	 * pass the glitch filter, but when testing I see some resets fail and
> +	 * some succeed when using a 70 us delay, so we use 100 us instead.
> +	 */
> +	gpiod_set_value_cansleep(panel->reset_gpio, 1);
> +	usleep_range(100, 1000);
> +	gpiod_set_value_cansleep(panel->reset_gpio, 0);
> +	udelay(2);
> +
> +	/* Init all registers. */
> +	err = regmap_multi_reg_write(panel->map, nt39016_panel_regs,
> +				     ARRAY_SIZE(nt39016_panel_regs));

Nice!

> +	if (err) {
> +		dev_err(panel->dev, "Failed to init registers: %i", err);

Maybe it is just me, but I wonder why %i and not %d?
You are consistent which is good.
But I saw no other panle drivers use %i, so consider to do like the
rest.


> +		goto err_disable_regulator;
> +	}
> +
> +	return 0;
> +
> +err_disable_regulator:
> +	regulator_disable(panel->supply);
> +	return err;
> +}
> +
> +static int nt39016_unprepare(struct drm_panel *drm_panel)
> +{
> +	struct nt39016 *panel = to_nt39016(drm_panel);
> +
> +	gpiod_set_value_cansleep(panel->reset_gpio, 1);
> +
> +	regulator_disable(panel->supply);
> +
> +	return 0;
> +}
> +
> +static int nt39016_enable(struct drm_panel *drm_panel)
> +{
> +	struct nt39016 *panel = to_nt39016(drm_panel);
> +	int err;
> +
> +	err = regmap_write(panel->map, NT39016_REG_SYSTEM, 0x07);
> +	if (err) {
> +		dev_err(panel->dev, "Unable to enable panel: %i", err);
> +		return err;
> +	}
> +
> +	/* Wait for the picture to be ready before enabling backlight */
> +	msleep(150);
> +
> +	if (panel->backlight) {
> +		panel->backlight->props.state &= ~BL_CORE_FBBLANK;
> +		panel->backlight->props.power = FB_BLANK_UNBLANK;
> +		backlight_update_status(panel->backlight);
> +	}
> +
> +	return 0;
> +}
> +
> +static int nt39016_disable(struct drm_panel *drm_panel)
> +{
> +	struct nt39016 *panel = to_nt39016(drm_panel);
> +	int err;
> +
> +	if (panel->backlight) {
> +		panel->backlight->props.power = FB_BLANK_POWERDOWN;
> +		panel->backlight->props.state |= BL_CORE_FBBLANK;
> +		backlight_update_status(panel->backlight);
> +	}
> +
> +	err = regmap_write(panel->map, NT39016_REG_SYSTEM, 0x05);
> +	if (err) {
> +		dev_err(panel->dev, "Unable to disable panel: %i", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
Can we get some nice constants for 0x04, 0x05 and 0x07?
(All values written to NT39016_REG_SYSTEM).

> +
> +static int nt39016_get_modes(struct drm_panel *drm_panel)
> +{
> +	struct nt39016 *panel = to_nt39016(drm_panel);
> +	const struct nt39016_panel_info *panel_info = panel->panel_info;
> +	struct drm_connector *connector = drm_panel->connector;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(drm_panel->drm, &panel_info->display_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.bpc = 8;
> +	connector->display_info.width_mm = panel_info->width_mm;
> +	connector->display_info.height_mm = panel_info->height_mm;
> +
> +	drm_display_info_set_bus_formats(&connector->display_info,
> +					 &panel_info->bus_format, 1);
> +	connector->display_info.bus_flags = panel_info->bus_flags;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs nt39016_funcs = {
> +	.prepare	= nt39016_prepare,
> +	.unprepare	= nt39016_unprepare,
> +	.enable		= nt39016_enable,
> +	.disable	= nt39016_disable,
> +	.get_modes	= nt39016_get_modes,
> +};
> +
> +static int nt39016_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct nt39016 *panel;
> +	int err;
> +
> +	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
> +	if (!panel)
> +		return -ENOMEM;
> +
> +	panel->dev = dev;
> +	spi_set_drvdata(spi, panel);
> +
> +	panel->panel_info = of_device_get_match_data(dev);
> +	if (!panel->panel_info)
> +		return -EINVAL;
> +
> +	panel->supply = devm_regulator_get(dev, "power");
> +	if (IS_ERR(panel->supply)) {
> +		dev_err(dev, "Failed to get power supply");
> +		return PTR_ERR(panel->supply);
> +	}
> +
> +	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(panel->reset_gpio)) {
> +		dev_err(dev, "Failed to get reset GPIO");
> +		return PTR_ERR(panel->reset_gpio);
> +	}
> +
> +	spi->bits_per_word = 8;
> +	spi->mode = SPI_MODE_3 | SPI_3WIRE;
> +	err = spi_setup(spi);
> +	if (err) {
> +		dev_err(dev, "Failed to setup SPI");
> +		return err;
> +	}
> +
> +	panel->map = devm_regmap_init_spi(spi, &nt39016_regmap_config);
> +	if (IS_ERR(panel->map)) {
> +		dev_err(dev, "Failed to init regmap");
> +		return PTR_ERR(panel->map);
> +	}
> +
> +	panel->backlight = devm_of_find_backlight(dev);
> +	if (IS_ERR(panel->backlight)) {
> +		err = PTR_ERR(panel->backlight);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get backlight handle");
> +		return err;
> +	}
> +
> +	drm_panel_init(&panel->drm_panel);
> +	panel->drm_panel.dev = dev;
> +	panel->drm_panel.funcs = &nt39016_funcs;
> +
> +	err = drm_panel_add(&panel->drm_panel);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to register panel");
> +		goto err_free_backlight;
> +	}
> +
> +	return 0;
> +
> +err_free_backlight:
> +	if (panel->backlight)
> +		put_device(&panel->backlight->dev);
When devm_xxx is used for backlight, the above is not needed.

Consider to write error codes for all what can fail in probe().
It may help you later when diving into logs.

> +
> +static int nt39016_remove(struct spi_device *spi)
> +{
> +	struct nt39016 *panel = spi_get_drvdata(spi);
> +
> +	drm_panel_remove(&panel->drm_panel);
> +
> +	nt39016_disable(&panel->drm_panel);
> +	nt39016_unprepare(&panel->drm_panel);
> +
> +	if (panel->backlight)
> +		put_device(&panel->backlight->dev);
Not needed.
> +
> +	return 0;
> +}
> +
> +static const struct nt39016_panel_info kd035g6_info = {
> +	.display_mode = {
> +		.clock = 6000,
> +		.hdisplay = 320,
> +		.hsync_start = 320 + 10,
> +		.hsync_end = 320 + 10 + 50,
> +		.htotal = 320 + 10 + 50 + 20,
> +		.vdisplay = 240,
> +		.vsync_start = 240 + 5,
> +		.vsync_end = 240 + 5 + 1,
> +		.vtotal = 240 + 5 + 1 + 4,
> +		.vrefresh = 60,
> +		.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +	},
> +	.width_mm = 71,
> +	.height_mm = 53,
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> +};
Everything specified - good!

> +
> +static const struct of_device_id nt39016_of_match[] = {
> +	{ .compatible = "kingdisplay,kd035g6-54nt", .data = &kd035g6_info },
> +	{},
Maybe write { /* sentinel */ } like many other drivers.
> +};
> +MODULE_DEVICE_TABLE(of, nt39016_of_match);
> +
> +static struct spi_driver nt39016_driver = {
> +	.driver = {
> +		.name = "nt39016",
> +		.of_match_table = nt39016_of_match,
> +	},
> +	.probe = nt39016_probe,
> +	.remove = nt39016_remove,
> +};
> +
> +module_spi_driver(nt39016_driver);
> +
> +MODULE_AUTHOR("Maarten ter Huurne <maarten@treewalker.org>");
> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> +MODULE_LICENSE("GPL v2");

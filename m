Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF712146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 07:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfCaHXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 03:23:42 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:50063 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCaHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 03:23:42 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 9888380301;
        Sun, 31 Mar 2019 09:23:35 +0200 (CEST)
Date:   Sun, 31 Mar 2019 09:23:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Ryan Pannell <ryan@osukl.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 4/4] drm/panel: Add Novatek NT35596 panel driver
Message-ID: <20190331072333.GA29704@ravnborg.org>
References: <20190321135955.25661-1-jagan@amarulasolutions.com>
 <20190321135955.25661-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321135955.25661-5-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8
        a=B3KMSFizEe0TvavdyI0A:9 a=FxVYhnmJS6Nt3-fl:21 a=5Dw-MxzeAUuWK6zi:21
        a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

Thanks for this new panel driver.

A few notes, please see inline comments below.

On Thu, Mar 21, 2019 at 07:29:55PM +0530, Jagan Teki wrote:
> Novatek NT35596 is a single-chip IC solution for small or medium-sized
> LTPS TFT LCD panels. NT35596 provides  several system interfaces like
> MIPI/SPI/I2C.
> 
> Currently added support for Microtech MTF050FHDI-03 is 1080x1920,
> 4-lane MIPI DSI LCD panel which has inbuilt NT35596 IC chip.
> 
> NT35596 support several regulators on the chip, among those only 4
> regulators like VCI, VDDI/DVDD, AVDD, AVEE are used for power-on
> sequence.
> 
> This driver added code for 3-regulator based power-on sequence as
> of now since MTF050FHDI-03 panel support it. This power-on sequence
> may be moved to panel_desc in future, if any new panel would come
> up with other type of sequence.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d18acda78a..4de80222cffb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4922,6 +4922,12 @@ S:	Maintained
>  F:	drivers/gpu/drm/tinydrm/hx8357d.c
>  F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
>  
> +DRM DRIVER FOR NOVATEK NT35596 MIPI-DSI LCD PANELS
> +M:	Jagan Teki <jagan@amarulasolutions.com>
> +S:	Maintained
> +F:	drivers/gpu/drm/panel/panel-novatek-nt35596.c
> +F:	Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
> +

I recall the entries in MAINTAINERS come in alphabetic order
based on their headline.
So this is the wrong order as "I" comes before "N":
DRM DRIVER FOR NOVATEK NT35596 MIPI-DSI LCD PANELS
DRM DRIVER FOR INTEL I810 VIDEO CARDS

Please move

> +#define NT35596_CMD_LEN			2
> +
> +struct nt35596_panel_desc {
> +	const struct drm_display_mode	*mode;
> +	unsigned int			lanes;
> +	unsigned long			flags;
> +	enum mipi_dsi_pixel_format	format;
> +	const struct nt35596_init_cmd	*panel_cmds;
> +	unsigned int			num_panel_cmds;
> +};
> +
> +struct nt35596 {
> +	struct drm_panel		panel;
> +	struct mipi_dsi_device		*dsi;
> +	const struct nt35596_panel_desc *desc;
> +
> +	struct backlight_device		*backlight;
> +	struct regulator		*dvdd;
> +	struct regulator		*avdd;
> +	struct regulator		*avee;
> +	struct gpio_desc		*reset;
> +

> +	bool				prepared;
> +	bool				enabled;
We should move these flags to the core as more and more
drivers seems to neeed them.
Something you could take a shot at?

> +};
> +
> +static inline struct nt35596 *panel_to_nt35596(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct nt35596, panel);
> +}
> +
> +struct nt35596_init_cmd {
> +	u8 data[NT35596_CMD_LEN];
> +};
> +
> +static const struct nt35596_init_cmd microtech_mtf050fhdi_cmds[] = {
> +	{ .data = { 0xFF, 0xEE } },
...
> +	/* Exit CMD1, Turn-off Tear ON */
> +	{ .data = { 0xFF, 0x00 } },
> +	{ .data = { 0x35, 0x00 } },
> +};
> +
> +static int nt35596_power_on(struct nt35596 *nt35596)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(nt35596->dvdd);
> +	if (ret)
> +		return ret;
> +
> +	/* T_power_ramp_up for VDDI */
> +	msleep(2);
> +
> +	ret = regulator_enable(nt35596->avdd);
> +	if (ret)
> +		return ret;
> +
> +	/* T_power_ramp_up for AVDD/AVEE */
> +	msleep(5);
> +
> +	ret = regulator_enable(nt35596->avee);
> +	if (ret)
> +		return ret;
> +
> +	msleep(10);
> +
> +	gpiod_set_value(nt35596->reset, 0);
> +
> +	msleep(120);
> +
> +	gpiod_set_value(nt35596->reset, 1);
> +
> +	/* wait for 120ms after reset deassert */
> +	msleep(120);
> +
> +	return 0;
> +}
> +
> +static int nt35596_power_off(struct nt35596 *nt35596)

This function never fails. Should you check regulator_disable()?
(Mst drivers skips check of regulator_disable() and it seems safe
to skip it here too.

Make it a void function if it cannot error out.

> +{
> +	gpiod_set_value(nt35596->reset, 0);
> +
> +	msleep(10);
> +
> +	regulator_disable(nt35596->avee);
> +
> +	/* T_power_ramp_down for AVEE/AVDD */
> +	msleep(5);
> +
> +	regulator_disable(nt35596->avdd);
> +
> +	/* T_power_ramp_down for VDDI */
> +	msleep(2);
> +
> +	regulator_disable(nt35596->dvdd);
> +
> +	return 0;
> +}
> +
> +static int nt35596_prepare(struct drm_panel *panel)
> +{
> +	struct nt35596 *nt35596 = panel_to_nt35596(panel);
> +	struct mipi_dsi_device *dsi = nt35596->dsi;
> +	const struct nt35596_panel_desc *desc = nt35596->desc;
> +	int ret, i;
> +
> +	if (nt35596->prepared)
> +		return 0;
> +
> +	ret = nt35596_power_on(nt35596);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < desc->num_panel_cmds; i++) {
> +		const struct nt35596_init_cmd *cmd = &desc->panel_cmds[i];
> +
> +		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
> +						NT35596_CMD_LEN);
> +		if (ret < 0) {
> +			DRM_DEV_ERROR(panel->dev,
> +				      "failed to write cmd %d: %d\n", i, ret);
> +			goto power_off;
> +		}
> +	}
> +
> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(panel->dev,
> +			      "failed to exit from sleep mode: %d\n", ret);
> +		goto power_off;
> +	}
> +
> +	/* wait for 120ms after sending exit sleep mode */
> +	msleep(120);
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(panel->dev,
> +			      "failed to set display on: %d\n", ret);
> +		goto power_off;
In the unprepare function we take care to exter sellp mode before we power off.
Should we not do the same here in this error case. We managed to exit
sleep mode just above (or so we think at least).

> +	}
> +
> +	nt35596->prepared = true;
> +
> +	return 0;
> +
> +power_off:
> +	if (nt35596_power_off(nt35596))
> +		DRM_DEV_ERROR(panel->dev, "failed to power off\n");
> +	return ret;
> +}
> +
> +static int nt35596_enable(struct drm_panel *panel)
> +{
> +	struct nt35596 *nt35596 = panel_to_nt35596(panel);
> +
> +	if (nt35596->enabled)
> +		return 0;
> +
> +	backlight_enable(nt35596->backlight);
> +
> +	nt35596->enabled = true;
> +
> +	return 0;
> +}
> +
> +static int nt35596_disable(struct drm_panel *panel)
> +{
> +	struct nt35596 *nt35596 = panel_to_nt35596(panel);
> +
> +	if (!nt35596->enabled)
> +		return 0;
> +
> +	backlight_disable(nt35596->backlight);
> +
> +	nt35596->enabled = false;
> +
> +	return 0;
> +}
> +
> +static int nt35596_unprepare(struct drm_panel *panel)
> +{
> +	struct nt35596 *nt35596 = panel_to_nt35596(panel);
> +
> +	if (!nt35596->prepared)
> +		return 0;
> +
> +	mipi_dsi_dcs_set_display_off(nt35596->dsi);
> +
> +	mipi_dsi_dcs_enter_sleep_mode(nt35596->dsi);
> +
> +	/* wait for 120ms after sending enter sleep mode */
> +	msleep(120);
> +
> +	nt35596_power_off(nt35596);
> +
> +	nt35596->prepared = false;
> +
> +	return 0;
> +}
> +
> +static int nt35596_get_modes(struct drm_panel *panel)
> +{
> +	struct nt35596 *nt35596 = panel_to_nt35596(panel);
> +	const struct drm_display_mode *desc_mode = nt35596->desc->mode;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, desc_mode);
> +	if (!mode) {
> +		DRM_DEV_ERROR(&nt35596->dsi->dev,
> +			      "failed to add mode %ux%ux@%u\n",
Please remove the extra "x" here                       ^
We want it to print "failed to add mode 1080x1920@50" and not
                    "failed to add mode 1080x1920x@50".

> +			      desc_mode->hdisplay,
> +			      desc_mode->vdisplay,
> +			      desc_mode->vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_set_name(mode);
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	panel->connector->display_info.width_mm = desc_mode->width_mm;
> +	panel->connector->display_info.height_mm = desc_mode->height_mm;
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs nt35596_funcs = {
> +	.disable	= nt35596_disable,
> +	.unprepare	= nt35596_unprepare,
> +	.prepare	= nt35596_prepare,
> +	.enable		= nt35596_enable,
> +	.get_modes	= nt35596_get_modes,
> +};
> +
> +static const struct drm_display_mode microtech_mtf050fhdi_mode = {
> +	.clock		= 147000,
> +
> +	.hdisplay	= 1080,
> +	.hsync_start	= 1080 + 408,
> +	.hsync_end	= 1080 + 408 + 4,
> +	.htotal		= 1080 + 408 + 4 + 38,
> +
> +	.vdisplay	= 1920,
> +	.vsync_start	= 1920 + 9,
> +	.vsync_end	= 1920 + 9 + 12,
> +	.vtotal		= 1920 + 9 + 12 + 9,
> +	.vrefresh	= 50,
> +
> +	.width_mm	= 64,
> +	.height_mm	= 118,
> +
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct nt35596_panel_desc microtech_mtf050fhdi_desc = {
> +	.mode		= &microtech_mtf050fhdi_mode,
> +	.lanes		= 4,
> +	.flags		= MIPI_DSI_MODE_VIDEO_BURST,
> +	.format		= MIPI_DSI_FMT_RGB888,
> +	.panel_cmds	= microtech_mtf050fhdi_cmds,
> +	.num_panel_cmds	= ARRAY_SIZE(microtech_mtf050fhdi_cmds),
> +};
> +
> +static int nt35596_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	const struct nt35596_panel_desc *desc;
> +	struct nt35596 *nt35596;
> +	int ret;
> +
> +	nt35596 = devm_kzalloc(&dsi->dev, sizeof(*nt35596), GFP_KERNEL);
> +	if (!nt35596)
> +		return -ENOMEM;
> +
> +	desc = of_device_get_match_data(&dsi->dev);
> +	dsi->mode_flags = desc->flags;
> +	dsi->format = desc->format;
> +	dsi->lanes = desc->lanes;
> +
> +	drm_panel_init(&nt35596->panel);
> +	nt35596->panel.dev = &dsi->dev;
> +	nt35596->panel.funcs = &nt35596_funcs;
> +
> +	nt35596->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
> +	if (IS_ERR(nt35596->dvdd)) {
> +		DRM_DEV_ERROR(&dsi->dev, "Couldn't get dvdd regulator\n");
> +		return PTR_ERR(nt35596->dvdd);
> +	}
It would be nive to have the error code in the above error logging.
Same goes for the remaining get operatiosn below.

> +
> +	nt35596->avdd = devm_regulator_get(&dsi->dev, "avdd");
> +	if (IS_ERR(nt35596->avdd)) {
> +		DRM_DEV_ERROR(&dsi->dev, "Couldn't get avdd regulator\n");
> +		return PTR_ERR(nt35596->avdd);
> +	}
> +
> +	nt35596->avee = devm_regulator_get(&dsi->dev, "avee");
> +	if (IS_ERR(nt35596->avee)) {
> +		DRM_DEV_ERROR(&dsi->dev, "Couldn't get avee regulator\n");
> +		return PTR_ERR(nt35596->avee);
> +	}
> +
> +	nt35596->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(nt35596->reset)) {
> +		DRM_DEV_ERROR(&dsi->dev, "Couldn't get our reset GPIO\n");
> +		return PTR_ERR(nt35596->reset);
> +	}
> +
> +	nt35596->backlight = devm_of_find_backlight(&dsi->dev);
> +	if (IS_ERR(nt35596->backlight))
> +		return PTR_ERR(nt35596->backlight);
> +
> +	ret = drm_panel_add(&nt35596->panel);
> +	if (ret < 0)
> +		return ret;
> +
> +	mipi_dsi_set_drvdata(dsi, nt35596);
> +	nt35596->dsi = dsi;
> +	nt35596->desc = desc;
> +
> +	return mipi_dsi_attach(dsi);
> +}
> +
> +static int nt35596_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct nt35596 *nt35596 = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&nt35596->panel);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id nt35596_of_match[] = {
> +	{
> +		.compatible = "microtech,mtf050fhdi-03",
> +		.data = &microtech_mtf050fhdi_desc,
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, nt35596_of_match);
> +
> +static struct mipi_dsi_driver nt35596_driver = {
> +	.probe = nt35596_dsi_probe,
> +	.remove = nt35596_dsi_remove,
> +	.driver = {
> +		.name = "novatek-nt35596",
> +		.of_match_table = nt35596_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(nt35596_driver);
> +
> +MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
> +MODULE_DESCRIPTION("Novatek NT35596 MIPI-DSI LCD panel");
> +MODULE_LICENSE("GPL");
Please check that this license mathes your SPDX identifier.

	Sam

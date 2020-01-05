Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2978C33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A6E207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAELXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 06:23:17 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34822 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgAELXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 06:23:17 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5AF7220054;
        Sun,  5 Jan 2020 12:23:12 +0100 (CET)
Date:   Sun, 5 Jan 2020 12:23:10 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, cawa.cheng@mediatek.com,
        bibby.hsieh@mediatek.com, linux-mediatek@lists.infradead.org,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH v7 2/8] drm/panel: support for BOE tv101wum-nl6 wuxga dsi
 video mode panel
Message-ID: <20200105112310.GB3309@ravnborg.org>
References: <20191012030720.27127-1-jitao.shi@mediatek.com>
 <20191012030720.27127-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012030720.27127-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8
        a=7gkXJVJtAAAA:8 a=D-QbINtN15ueE4Of3rkA:9 a=CjuIK1q_8ugA:10
        a=6heAxKwa5pAsJatQ0mat:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

On Sat, Oct 12, 2019 at 11:07:14AM +0800, Jitao Shi wrote:
> Add driver for BOE tv101wum-nl6 panel is a 10.1" 1200x1920 panel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---


> +
> +struct boe_panel {
> +	struct drm_panel base;
> +	struct mipi_dsi_device *dsi;
> +
> +	const struct panel_desc *desc;
> +
> +	struct backlight_device *backlight;

drm_panel has gained backlight support in drm-misc-next.
Please use this.

> +	struct regulator *pp1800;
> +	struct regulator *avee;
> +	struct regulator *avdd;
> +	struct gpio_desc *enable_gpio;
> +
> +	bool prepared;
> +	bool enabled;
This flag can be dropped when using drm_panel backlight support.

> +
> +	const struct drm_display_mode *mode;
> +};

> +
> +static int boe_panel_disable(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +
> +	if (!boe->enabled)
> +		return 0;
> +
> +	backlight_disable(boe->backlight);
> +
> +	boe->enabled = false;
> +
> +	return 0;
> +}
This function can be dropped when using the drm_panel backlight support.

> +
> +static int boe_panel_enable(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	int ret;
> +
> +	if (boe->enabled)
> +		return 0;
> +
> +	ret = backlight_enable(boe->backlight);
> +	if (ret) {
> +		dev_err(panel->dev, "Failed to enable backlight %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	boe->enabled = true;
> +
> +	return 0;
> +}
This function can be dropped when using the drm_panel backlight support.

> +
> +static const struct drm_display_mode boe_tv101wum_nl6_default_mode = {
> +	.clock = 159425,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 100,
> +	.hsync_end = 1200 + 100 + 40,
> +	.htotal = 1200 + 100 + 40 + 24,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 10,
> +	.vsync_end = 1920 + 10 + 14,
> +	.vtotal = 1920 + 10 + 14 + 4,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc boe_tv101wum_nl6_desc = {
> +	.modes = &boe_tv101wum_nl6_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width_mm = 135,
> +		.height_mm = 216,
> +	},
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init_cmds = boe_init_cmd,
> +};
> +
> +static int boe_panel_get_modes(struct drm_panel *panel)
This function now takes drm_connector as second argument.
See drm-misc-next.
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	const struct drm_display_mode *m = boe->desc->modes;
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, m);
Here you will need to use connector->dev to get the drm_device.

> +	if (!mode) {
> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> +			m->hdisplay, m->vdisplay, m->vrefresh);
> +		return -ENOMEM;
> +	}
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_set_name(mode);
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	panel->connector->display_info.width_mm = boe->desc->size.width_mm;
> +	panel->connector->display_info.height_mm = boe->desc->size.height_mm;
> +	panel->connector->display_info.bpc = boe->desc->bpc;
There is no connector in drm_panel today.
Use the connector in supplied as second argument.

> +
> +	return 1;
> +}
> +
> +	gpiod_set_value(boe->enable_gpio, 0);
> +
> +	boe->backlight = devm_of_find_backlight(dev);
> +	if (IS_ERR(boe->backlight))
> +		return PTR_ERR(boe->backlight);
Move this after drm_panel_init and use drm_panel_of_backlight()

The binding say that backlight is mandatory. This is really not checked
here. And I *think* backlight is optional.

> +
> +	drm_panel_init(&boe->base);
Here you need to specify connector_type as second argument.

> +
> +	boe->base.funcs = &boe_panel_funcs;
> +	boe->base.dev = &boe->dsi->dev;
> +
> +	return drm_panel_add(&boe->base);
> +}
> +
> +}
> +
> +static int boe_panel_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = boe_panel_disable(&boe->base);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
> +
> +	if (boe->base.dev)
> +		drm_panel_remove(&boe->base);
> +
> +	return 0;
> +}
This should just be:

	boe_panel_shutdown();
	ret = mipi_dsi_detach();
	if (ret < 0)
		...
	drm_panel_remove();


> +
> +static void boe_panel_shutdown(struct mipi_dsi_device *dsi)
> +{
> +	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
> +
> +	boe_panel_disable(&boe->base);
> +}
Please use drm_panel variants here.
And then I had expected to see:
	drm_panel_disable();
	drm_panel_unprepare();



> +
> +static const struct of_device_id boe_of_match[] = {
> +	{ .compatible = "boe,tv101wum-nl6",
> +	  .data = &boe_tv101wum_nl6_desc
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, boe_of_match);
> +
> +static struct mipi_dsi_driver boe_panel_driver = {
> +	.driver = {
> +		.name = "panel-boe-tv101wum-nl6",
> +		.of_match_table = boe_of_match,
> +	},
> +	.probe = boe_panel_probe,
> +	.remove = boe_panel_remove,
> +	.shutdown = boe_panel_shutdown,
> +};
> +module_mipi_dsi_driver(boe_panel_driver);
> +
> +MODULE_AUTHOR("Jitao Shi <jitao.shi@mediatek.com>");
> +MODULE_DESCRIPTION("BOE tv101wum-nl6 1200x1920 video mode panel driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.21.0

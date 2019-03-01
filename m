Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C71C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7F520663
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfCAWjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:39:11 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:58803 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfCAWjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:39:11 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A27D02008F;
        Fri,  1 Mar 2019 23:39:07 +0100 (CET)
Date:   Fri, 1 Mar 2019 23:39:06 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm/panel: Add Rocktech jh057n00900 panel driver
Message-ID: <20190301223906.GB30998@ravnborg.org>
References: <cover.1551445106.git.agx@sigxcpu.org>
 <21f8e44a5f65c97ef77d159c6be6603dba29232b.1551445106.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21f8e44a5f65c97ef77d159c6be6603dba29232b.1551445106.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=bMLOE1kPre8LCja2O0cA:9
        a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

Thanks for addressing review comments in first round.
Just a few nits in this follow-up.
With these nits addressed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

On Fri, Mar 01, 2019 at 02:02:04PM +0100, Guido Günther wrote:

> +#include <video/display_timing.h>
This include file is, as far as I could tell, no longer used and can be dropped.

> +
> +static int jh057n_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_duplicate(panel->drm, &default_mode);
> +	if (!mode) {
> +		DRM_ERROR("Failed to add mode %ux%u@%u",
> +			  default_mode.hdisplay, default_mode.vdisplay,
> +			  default_mode.vrefresh);
> +		return -ENOMEM;
Use DRM_DEV_ERROR()
You can find dev via: panel->base.drm-dev

> +
> +static int jh057n_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	struct jh057n *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio)) {
> +		DRM_DEV_ERROR(dev, "cannot get reset gpio");
> +		return PTR_ERR(ctx->reset_gpio);
> +	}
> +
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	ctx->dev = dev;
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> +		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> +
> +	ctx->backlight = devm_of_find_backlight(dev);
> +	if (IS_ERR(ctx->backlight))
> +		return PTR_ERR(ctx->backlight);
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev = dev;
> +	ctx->panel.funcs = &jh057n_drm_funcs;
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?");
> +		drm_panel_remove(&ctx->panel);
> +		return ret;
> +	}
> +
> +	DRM_INFO(DRV_NAME "_panel %ux%u@%u %ubpp dsi %udl - ready",
> +		 default_mode.hdisplay, default_mode.vdisplay,
> +		 default_mode.vrefresh,
> +		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);

You already have dev, so use DRM_DEV_INFO() and drop DRV_NAME

> +
> +static const struct of_device_id jh057n_of_match[] = {
> +	{ .compatible = "rocktech,jh057n00900" },
> +	{ /* Sentinel */ }
Lower case 's' (sorry, likely my bad)

> +	.probe	= jh057n_probe,
> +	.remove = jh057n_remove,
> +	.shutdown = jh057n_shutdown,
> +	.driver = {
> +		.name = DRV_NAME "_panel",
Drop "_panel" postfix. Other drivers do not use it.

	Sam

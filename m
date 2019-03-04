Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A019C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DE920835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCDRzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:55:02 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:60106 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfCDRzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:55:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 320F8FB03;
        Mon,  4 Mar 2019 18:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tSJ5gJM4tyRW; Mon,  4 Mar 2019 18:54:58 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 52DB0414EA; Mon,  4 Mar 2019 18:54:58 +0100 (CET)
Date:   Mon, 4 Mar 2019 18:54:58 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm/panel: Add Rocktech jh057n00900 panel driver
Message-ID: <20190304175458.GA4566@bogon.m.sigxcpu.org>
References: <cover.1551445106.git.agx@sigxcpu.org>
 <21f8e44a5f65c97ef77d159c6be6603dba29232b.1551445106.git.agx@sigxcpu.org>
 <20190301223906.GB30998@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190301223906.GB30998@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Mar 01, 2019 at 11:39:06PM +0100, Sam Ravnborg wrote:
> Hi Guido.
> 
> Thanks for addressing review comments in first round.
> Just a few nits in this follow-up.
> With these nits addressed:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks! I made all the suggested changes in v3, on top of that I
prepended 'panel-rockteck-' to the driver name to be more consistent
with other drivers.
 -- Guido

> 
> On Fri, Mar 01, 2019 at 02:02:04PM +0100, Guido Günther wrote:
> 
> > +#include <video/display_timing.h>
> This include file is, as far as I could tell, no longer used and can be dropped.
> 
> > +
> > +static int jh057n_get_modes(struct drm_panel *panel)
> > +{
> > +	struct drm_display_mode *mode;
> > +
> > +	mode = drm_mode_duplicate(panel->drm, &default_mode);
> > +	if (!mode) {
> > +		DRM_ERROR("Failed to add mode %ux%u@%u",
> > +			  default_mode.hdisplay, default_mode.vdisplay,
> > +			  default_mode.vrefresh);
> > +		return -ENOMEM;
> Use DRM_DEV_ERROR()
> You can find dev via: panel->base.drm-dev
> 
> > +
> > +static int jh057n_probe(struct mipi_dsi_device *dsi)
> > +{
> > +	struct device *dev = &dsi->dev;
> > +	struct jh057n *ctx;
> > +	int ret;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(ctx->reset_gpio)) {
> > +		DRM_DEV_ERROR(dev, "cannot get reset gpio");
> > +		return PTR_ERR(ctx->reset_gpio);
> > +	}
> > +
> > +	mipi_dsi_set_drvdata(dsi, ctx);
> > +
> > +	ctx->dev = dev;
> > +
> > +	dsi->lanes = 4;
> > +	dsi->format = MIPI_DSI_FMT_RGB888;
> > +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
> > +		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
> > +
> > +	ctx->backlight = devm_of_find_backlight(dev);
> > +	if (IS_ERR(ctx->backlight))
> > +		return PTR_ERR(ctx->backlight);
> > +
> > +	drm_panel_init(&ctx->panel);
> > +	ctx->panel.dev = dev;
> > +	ctx->panel.funcs = &jh057n_drm_funcs;
> > +
> > +	drm_panel_add(&ctx->panel);
> > +
> > +	ret = mipi_dsi_attach(dsi);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?");
> > +		drm_panel_remove(&ctx->panel);
> > +		return ret;
> > +	}
> > +
> > +	DRM_INFO(DRV_NAME "_panel %ux%u@%u %ubpp dsi %udl - ready",
> > +		 default_mode.hdisplay, default_mode.vdisplay,
> > +		 default_mode.vrefresh,
> > +		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
> 
> You already have dev, so use DRM_DEV_INFO() and drop DRV_NAME
> 
> > +
> > +static const struct of_device_id jh057n_of_match[] = {
> > +	{ .compatible = "rocktech,jh057n00900" },
> > +	{ /* Sentinel */ }
> Lower case 's' (sorry, likely my bad)
> 
> > +	.probe	= jh057n_probe,
> > +	.remove = jh057n_remove,
> > +	.shutdown = jh057n_shutdown,
> > +	.driver = {
> > +		.name = DRV_NAME "_panel",
> Drop "_panel" postfix. Other drivers do not use it.
> 
> 	Sam
> 

Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B902BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBB720854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfCONdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:33:02 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39035 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfCONdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:33:02 -0400
Received: from aptenodytes (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B3AC0200009;
        Fri, 15 Mar 2019 13:32:56 +0000 (UTC)
Message-ID: <c232d5620d6a3272a6064ce9ccdec5c86a3a7950.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 3/6] drm/sun4i: dsi: Add bridge support
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     jagan@amarulasolutions.com, Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Date:   Fri, 15 Mar 2019 14:32:55 +0100
In-Reply-To: <20190315130825.9005-4-jagan@amarulasolutions.com>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
         <20190315130825.9005-4-jagan@amarulasolutions.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-03-15 at 18:38 +0530, Jagan Teki wrote:
> Some display panels would come up with a non-DSI output which
> can have an option to connect DSI interface by means of bridge
> convertor.
> 
> This DSI to non-DSI bridge convertor would require a bridge
> driver that would communicate the DSI controller for bridge
> functionalities.
> 
> So, add support for bridge functionalities in Allwinner DSI
> controller.

See a few comments below.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 65 +++++++++++++++++++-------
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  1 +
>  2 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 0960b96b62cc..64d74313b842 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -781,6 +781,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
>  	if (!IS_ERR(dsi->panel))
>  		drm_panel_prepare(dsi->panel);
>  
> +	if (!IS_ERR(dsi->bridge))
> +		drm_bridge_pre_enable(dsi->bridge);
> +
>  	/*
>  	 * FIXME: This should be moved after the switch to HS mode.
>  	 *
> @@ -796,6 +799,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
>  	if (!IS_ERR(dsi->panel))
>  		drm_panel_enable(dsi->panel);
>  
> +	if (!IS_ERR(dsi->bridge))
> +		drm_bridge_enable(dsi->bridge);
> +
>  	sun6i_dsi_start(dsi, DSI_START_HSC);
>  
>  	udelay(1000);
> @@ -812,6 +818,9 @@ static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
>  	if (!IS_ERR(dsi->panel)) {
>  		drm_panel_disable(dsi->panel);
>  		drm_panel_unprepare(dsi->panel);
> +	} else if (!IS_ERR(dsi->bridge)) {
> +		drm_bridge_disable(dsi->bridge);
> +		drm_bridge_post_disable(dsi->bridge);
>  	}
>  
>  	phy_power_off(dsi->dphy);
> @@ -973,11 +982,16 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
>  	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
>  
>  	dsi->device = device;
> -	dsi->panel = of_drm_find_panel(device->dev.of_node);
> -	if (IS_ERR(dsi->panel))
> -		return PTR_ERR(dsi->panel);
>  
> -	dev_info(host->dev, "Attached device %s\n", device->name);
> +	dsi->bridge = of_drm_find_bridge(device->dev.of_node);
> +	if (!dsi->bridge) {

You are using IS_ERR to check that the bridge is alive in the changes
above, but switch to checking that it's non-NULL at this point.

Are both guaranteed to be interchangeable?

> +		dsi->panel = of_drm_find_panel(device->dev.of_node);
> +		if (IS_ERR(dsi->panel))
> +			return PTR_ERR(dsi->panel);
> +	}

You should probably use drm_of_find_panel_or_bridge instead of
duplicating the logic here.

> +	dev_info(host->dev, "Attached %s %s\n",
> +		 dsi->bridge ? "bridge" : "panel", device->name);
>  
>  	return 0;
>  }
> @@ -1055,8 +1069,10 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
>  	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
>  	int ret;
>  
> -	if (!dsi->panel)
> +	if (!(dsi->panel || dsi->bridge)) {
> +		dev_info(drm->dev, "No panel or bridge found... DSI output disabled\n");
>  		return -EPROBE_DEFER;
> +	}
>  
>  	dsi->drv = drv;
>  
> @@ -1078,19 +1094,29 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
>  	}
>  	dsi->encoder.possible_crtcs = BIT(0);
>  
> -	drm_connector_helper_add(&dsi->connector,
> -				 &sun6i_dsi_connector_helper_funcs);
> -	ret = drm_connector_init(drm, &dsi->connector,
> -				 &sun6i_dsi_connector_funcs,
> -				 DRM_MODE_CONNECTOR_DSI);
> -	if (ret) {
> -		dev_err(dsi->dev,
> -			"Couldn't initialise the DSI connector\n");
> -		goto err_cleanup_connector;
> +	if (dsi->panel) {
> +		drm_connector_helper_add(&dsi->connector,
> +					 &sun6i_dsi_connector_helper_funcs);
> +		ret = drm_connector_init(drm, &dsi->connector,
> +					 &sun6i_dsi_connector_funcs,
> +					 DRM_MODE_CONNECTOR_DSI);
> +		if (ret) {
> +			dev_err(dsi->dev,
> +				"Couldn't initialise the DSI connector\n");
> +			goto err_cleanup_connector;
> +		}
> +
> +		drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
> +		drm_panel_attach(dsi->panel, &dsi->connector);
>  	}
>  
> -	drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
> -	drm_panel_attach(dsi->panel, &dsi->connector);
> +	if (dsi->bridge) {
> +		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
> +		if (ret) {
> +			dev_err(dsi->dev, "Couldn't attach the DSI bridge\n");
> +			goto err_cleanup_connector;
> +		}
> +	}
>  
>  	return 0;
>  
> @@ -1104,7 +1130,12 @@ static void sun6i_dsi_unbind(struct device *dev, struct device *master,
>  {
>  	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
>  
> -	drm_panel_detach(dsi->panel);
> +	if (dsi->panel)
> +		drm_panel_detach(dsi->panel);
> +
> +	if (dsi->bridge)
> +		drm_bridge_detach(dsi->bridge);

As I mentionned in the first patch, this is quite suspicious since the
DRM core should be in charge of detaching the bridge, not the driver.

Cheers,

Paul

> +
>  }
>  
>  static const struct component_ops sun6i_dsi_ops = {
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> index 5c4983212f89..76874ff8e3ef 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> @@ -36,6 +36,7 @@ struct sun6i_dsi {
>  	struct sun4i_tcon	*tcon;
>  	struct mipi_dsi_device	*device;
>  	struct drm_panel	*panel;
> +	struct drm_bridge	*bridge;
>  	const struct sun6i_dsi_variant	*variant;
>  };
>  
> -- 
> 2.18.0.321.gffc6fa0e3
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


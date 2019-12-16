Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DDD20726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLPQLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:11:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfLPQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:11:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E3E5A28FC78
Message-ID: <ca0c26d124a0139de31405eacb7d098173897d16.camel@collabora.com>
Subject: Re: [PATCH v4 1/4] drm: bridge: dw_mipi_dsi: access registers via a
 regmap
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Date:   Mon, 16 Dec 2019 13:10:52 -0300
In-Reply-To: <20191202193359.703709-2-adrian.ratiu@collabora.com>
References: <20191202193359.703709-1-adrian.ratiu@collabora.com>
         <20191202193359.703709-2-adrian.ratiu@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thanks for the patch. This is nice consolidation work.
I'm Ccing Heiko for the Rockchip part.

See below for some comments.

On Mon, 2019-12-02 at 21:33 +0200, AdrianAdrian Ratiu wrote:
> Convert the common bridge code and the two rockchip & stm drivers
> which currently use it to the regmap API in anticipation for further
> changes to make it more generic and add older DSI host controller
> support as found on i.mx6 based devices.
> 
> The regmap becomes an internal state of the bridge. No functional
> changes other than requiring the platform drivers to use the
> pre-configured regmap supplied by the bridge after its probe() call
> instead of ioremp'ing the registers themselves.
> 
> In subsequent commits the bridge will become able to detect the
> DSI host core version and init the regmap with different register
> layouts. The platform drivers will continue to use the regmap without
> modifications or worrying about the specific layout in use (in other
> words the layout is abstracted away via the regmap).
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 215 ++++++++++--------
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  17 +-

At least for Rockchip, I'd rather see this done in two
steps: first some regmap infrastructure introduced,
and then in a follow-up patch, the rockchip driver
moved to it.

It's safer, and better from a bisection POV, and from
a first look it seems doable.

>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |  34 ++-

It would be good to do try the same for STM. It's also
simpler to review that way.

>  include/drm/bridge/dw_mipi_dsi.h              |   2 +-
>  4 files changed, 145 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index b6e793bb653c..6cb57807f3f9 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  
>  #include <video/mipi_display.h>
> @@ -226,7 +227,7 @@ struct dw_mipi_dsi {
>  	struct mipi_dsi_host dsi_host;
>  	struct drm_bridge *panel_bridge;
>  	struct device *dev;
> -	void __iomem *base;
> +	struct regmap *regs;
> 

You have the regmap here...
>  
>  	struct clk *pclk;
>  
[..]
> @@ -954,7 +952,6 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
>  	}
>  
>  	dsi->dev = dev;
> -	dsi->pdata.base = dsi->base;
>  	dsi->pdata.max_data_lanes = dsi->cdata->max_data_lanes;
>  	dsi->pdata.phy_ops = &dw_mipi_dsi_rockchip_phy_ops;
>  	dsi->pdata.host_ops = &dw_mipi_dsi_rockchip_host_ops;
> @@ -970,6 +967,8 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
>  		goto err_clkdisable;
>  	}
>  
> +	dsi->regs = dsi->pdata.regs;
> +

... and this goes for both STM and Rockchip: I don't think you need neither
the struct dw_mipi_dsi_plat_data.regs nor the
structdw_mipi_dsi_{rockchip, stm}.regs. You should be able to
just access the regmap via the struct dw_mipi_dsi.

[..]
>  
>  err_dsi_probe:
> @@ -474,7 +472,7 @@ static struct platform_driver dw_mipi_dsi_stm_driver = {
>  	.remove		= dw_mipi_dsi_stm_remove,
>  	.driver		= {
>  		.of_match_table = dw_mipi_dsi_stm_dt_ids,
> -		.name	= "stm32-display-dsi",
> +		.name	= DRIVER_NAME,

Unrelated change, please drop it.

>  		.pm = &dw_mipi_dsi_stm_pm_ops,
>  	},
>  };

Thanks,
Ezequiel


Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F35218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wniT5D8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfDYJS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:18:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35104 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfDYJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:18:24 -0400
Received: from pendragon.ideasonboard.com (net-37-182-44-227.cust.vodafonedsl.it [37.182.44.227])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BB565F;
        Thu, 25 Apr 2019 11:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556183901;
        bh=A8unK81K5jpjF7m6yXqXk3+YvT7+8zM3Gr8YuevpnrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wniT5D8jDiIXwqPEZvkoQRwTU3bxcTpJ6CbhNDJhroGSTHTFA3iFZCjIqSEgpb3wO
         a+zgtKry0vPp0P0z5hP35FiWY3AJXpgyj8Pv/ghTvs/9TcRHv/piQqNPgFOgv5psss
         sLNsMjZQmFOuJODtnzsS3nKOHwnkxz//XN5dM5eA=
Date:   Thu, 25 Apr 2019 12:18:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Archit Taneja <architt@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Wait for all active lanes to
 reach stop
Message-ID: <20190425091810.GA4557@pendragon.ideasonboard.com>
References: <20190424142124.25776-1-matt.redfearn@thinci.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424142124.25776-1-matt.redfearn@thinci.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Thank you for the patch.

On Wed, Apr 24, 2019 at 02:21:40PM +0000, Matt Redfearn wrote:
> The Synopsys manual states that software should wait for all active
> lanes to reach stop state (User manual section 3.1.5). Currently the
> driver only waits for / checks that the clock lane is in stop state. Fix
> this by waiting for the mask of PHY STATUS bits corresponding to the
> active lanes to be set.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

I don't have access to the datasheet, but the change makes sense.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index bd15c21a177..38e88071363 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -189,6 +189,10 @@
>  #define DSI_PHY_TX_TRIGGERS		0xac
>  
>  #define DSI_PHY_STATUS			0xb0
> +#define PHY_STOP_STATE_LANE_3		BIT(11)
> +#define PHY_STOP_STATE_LANE_2		BIT(9)
> +#define PHY_STOP_STATE_LANE_1		BIT(7)
> +#define PHY_STOP_STATE_LANE_0		BIT(4)
>  #define PHY_STOP_STATE_CLK_LANE		BIT(2)
>  #define PHY_LOCK			BIT(0)
>  
> @@ -752,7 +756,7 @@ static void dw_mipi_dsi_dphy_init(struct dw_mipi_dsi *dsi)
>  
>  static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>  {
> -	u32 val;
> +	u32 val, mask;
>  	int ret;
>  
>  	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
> @@ -763,11 +767,16 @@ static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>  	if (ret)
>  		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>  
> +	mask = PHY_STOP_STATE_CLK_LANE | PHY_STOP_STATE_LANE_0;
> +	mask |= (dsi->lanes >= 2) ? PHY_STOP_STATE_LANE_1 : 0;
> +	mask |= (dsi->lanes >= 3) ? PHY_STOP_STATE_LANE_2 : 0;
> +	mask |= (dsi->lanes == 4) ? PHY_STOP_STATE_LANE_3 : 0;
> +
>  	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
> -				 val, val & PHY_STOP_STATE_CLK_LANE, 1000,
> +				 val, (val & mask) == mask, 1000,
>  				 PHY_STATUS_TIMEOUT_US);
>  	if (ret)
> -		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
> +		DRM_DEBUG_DRIVER("failed to wait phy stop state\n");
>  }
>  
>  static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)

-- 
Regards,

Laurent Pinchart

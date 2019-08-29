Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A544C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C49E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CeFkqqrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfH2O54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:57:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50168 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfH2O5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:57:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190829145753euoutp023ed39c8f25f02f1d322468ccb0a3d5b7~-bKo3jK-Y2959029590euoutp02e
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:57:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190829145753euoutp023ed39c8f25f02f1d322468ccb0a3d5b7~-bKo3jK-Y2959029590euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567090673;
        bh=KxscT7RPibRDnohD40SHh0EXIthWDkooZkjV1MEWsxM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CeFkqqrxvqmh/zmiXUdlva0Mipn7MEF+mdhe1G+1WHSwSGk3gF9CGSTzoMjwyV8gB
         /VlofHRGAO9/JEXuMElNi7URKlt0N2LYVM5lZOIWJ53HyDhZT2ZD+cRWd/3Mx4w0gm
         1KhpZFwePe1tcRc7u1y9h7L6o5H8aRV+sEPY+G5U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190829145752eucas1p16f70a60e9afd626f4cecfeb59d7206f8~-bKn4CyMQ1865018650eucas1p1X;
        Thu, 29 Aug 2019 14:57:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 17.68.04469.0F7E76D5; Thu, 29
        Aug 2019 15:57:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190829145751eucas1p10d2f66eca4676fbd7ca9002e5f00734f~-bKnHQAUs1864918649eucas1p1l;
        Thu, 29 Aug 2019 14:57:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190829145751eusmtrp1091fb058ef4b58ec492d5ada4a0e649b~-bKm4tRYj2894528945eusmtrp1Z;
        Thu, 29 Aug 2019 14:57:51 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-60-5d67e7f0cd3b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.F2.04166.FE7E76D5; Thu, 29
        Aug 2019 15:57:51 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190829145750eusmtip25d5d20f41ae51fafa24b9d96ba8607f6~-bKl57SKJ2010020100eusmtip2b;
        Thu, 29 Aug 2019 14:57:50 +0000 (GMT)
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Matt Redfearn <matt.redfearn@thinci.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3f72a209-55b0-c361-2737-ad4cb811053b@samsung.com>
Date:   Thu, 29 Aug 2019 16:57:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829060550.62095-1-john.stultz@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTYRzHe/Yeex1uvE7DJ7WiUVDikSH1kiIKgW8U1H8dYrnybYrOY693
        REpZXvOszHmkYbr8o7ymOaJshkem5hU21JlHaSaaJ+JB214j//v8ju/z+37hIRDxH8yOCA6L
        YhRh0lAJLkAbWte7nRd+yvyPlz0kKWV3B48aWJnHqcG1GYT6vOFMdfweRKnUnHI+1a8twimt
        oZRH6TL9KPW6BlAj1V2AWteWoFTd/D2UGp+pxLxF9PxQMp8uTOxF6SbVCJ+eKK4xlikFGN2e
        3cejh7++xenG1TGMNqS38ejyJ4M43azMQ+nCvHGMXqo9cFF4VeAZyIQGxzAKV68AQVDPx21+
        RPepuMTUEn4iyHJKAxYEJN1hTf8znonFpBrAiSQqDQiMvAzgbGYuyhVLABatvsPSAGFWKIfC
        uX4lgBVqzY56DsD0xzYmtia94WzjNGZiG/ICzFlrxUwChMxA4eOBSWAa4OQxuFX3DTexkPSC
        VbXbZgFKHoFZzWVm3ktehotjLRi3YwU7CiZRE1uQnrBVX2E+jJAHYeNcEcKxLdRPmuIIjEbL
        CJjbnYRzrs/AuulYLrI1/NVWz+fYAXbmZaAc34UG9X2E06YAqKluQriBB2xp6zWnR4ymX2td
        ubYPVJb387jnRXBozoqzIIK5DfkI1xbClAdibvsQNHRpdh60hS++rODZQKLaFUy1K4xqVxjV
        /7ulAK0Ctkw0K5cxrFsYE+vCSuVsdJjM5Wa4vBYYP2LndtviG7DSd0MHSAJILIVPm2X+Ykwa
        w8bLdQASiMRGOH6Y8RcLA6XxCYwi/LoiOpRhdcCeQCW2wtt7xvzEpEwaxYQwTASj+DflERZ2
        iaA+ny78IFlF7GtGf2T6IldObyYz8vxbxXK1hcOn5/rhKZtz7l3CjcrUO+7u+8+e/P7It/TE
        Roi4ZsQnTyVaqHp5aWqqtvn9PpoSBS5np8sMW7q4NcdrCXZ6+yUny8YC5FUAG2uZE+nSvrR2
        Xt/jtSkpPprp1eQRP68cnuuKVI1KUDZI6uaIKFjpX0XhDCeEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42I5/e/4Pd33z9NjDXZNlbfoPXeSyeLK1/ds
        Fle/v2S2OPNb1+Lkm6ssFp0Tl7BbXN41h81i1/0FTBaH+qItVvzcymhxd8NZRoufu+axWGx+
        38xi8ejlclYHPo/3N1rZPWY3XGTx2DnrLrvH47kbgdyOmaweJyZcYvK4c20Pm8f2bw9YPe53
        H2fyWDLtKpvHgd7JLB6zJz9i9fi8SS6AN0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q
        2DzWyshUSd/OJiU1J7MstUjfLkEv4/yRf+wF58wrGjrnsTcw9ut0MXJwSAiYSPTeyO9i5OIQ
        EljKKLHmzBrWLkZOoLi4xO75b5khbGGJP9e62CCKXjNKtN5/zgiSEBZwkHi9/QUryCARAV+J
        zT+dQGqYBfpYJJ4e+sQM0dDPKDHpxguwqWwCmhJ/N99kA7F5BewkVm36BxZnEVCV6D+wEMwW
        FYiQOLxjFiNEjaDEyZlPWEBsTgEbiWO3ljGB2MwC6hJ/5l1ihrDlJba/nQNli0vcejKfaQKj
        0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgWlg27Gfm3cwXtoY
        fIhRgINRiYfXYnt6rBBrYllxZe4hRgkOZiUR3kcqqbFCvCmJlVWpRfnxRaU5qcWHGE2BnpvI
        LCWanA9MUXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhiFM+dV
        Fa0t8s8o+CikvmeGaFEWt8ayiAQtu5UfNb+pT/9oPz32i+xk+ZCLtrdeurx+6Gj7Z63C2+sB
        KfMe+siZM27//pUxIN9EZqL+oscGN4Ii+bNzvvsfWtq7WGryYqfgGcJTtiiV5LH+O34/+bN2
        qd27IuEtT4Mu+BqyOZU6zv9yRzk0r06JpTgj0VCLuag4EQBzxWP0GQMAAA==
X-CMS-MailID: 20190829145751eucas1p10d2f66eca4676fbd7ca9002e5f00734f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829060605epcas3p4e67faa772911b8b84fee026fe953ca15
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829060605epcas3p4e67faa772911b8b84fee026fe953ca15
References: <CGME20190829060605epcas3p4e67faa772911b8b84fee026fe953ca15@epcas3p4.samsung.com>
        <20190829060550.62095-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2019 08:05, John Stultz wrote:
> Since commit 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI
> host at probe time") landed in -next the HiKey board would fail
> to boot, looping:
>
>   adv7511 2-0039: failed to find dsi host
>
> messages over and over. Andrzej Hajda suggested this is due to a
> circular dependency issue, and that the adv7511 change is
> correcting the improper order used earlier.
>
> Unfortunately this means the DSI drivers that use adv7511 need
> to also need to be updated to use the proper ordering to
> continue to work.
>
> This patch tries to reorder the initialization to register the
> dsi_host first, and then call component_add via dsi_host_attach,
> instead of doing that at probe time.
>
> This seems to resolve the issue with the HiKey board.
>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Matt Redfearn <matt.redfearn@thinci.com>
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: David Airlie <airlied@linux.ie>,
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
> Fixes: 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI host at probe time")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> Note: I'm really not super familiar with the DSI code here,
> and am mostly just trying to refactor the existing code in a
> similar fashion to the suggested dw-mipi-dsi-rockchip.c
> implementation. Careful review would be greatly appreciated!
>
> Also there is an outstanding regression on the db410c since it
> similarly uses the adv7511 and probably needs a similar rework.
> ---
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 111 ++++++++++---------
>  1 file changed, 56 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> index 5bf8138941de..696cee1a1219 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> @@ -79,6 +79,7 @@ struct dsi_hw_ctx {
>  };
>  
>  struct dw_dsi {
> +	struct device *dev;
>  	struct drm_encoder encoder;
>  	struct drm_bridge *bridge;
>  	struct mipi_dsi_host host;
> @@ -724,51 +725,6 @@ static int dw_drm_encoder_init(struct device *dev,
>  	return 0;
>  }
>  
> -static int dsi_host_attach(struct mipi_dsi_host *host,
> -			   struct mipi_dsi_device *mdsi)
> -{
> -	struct dw_dsi *dsi = host_to_dsi(host);
> -
> -	if (mdsi->lanes < 1 || mdsi->lanes > 4) {
> -		DRM_ERROR("dsi device params invalid\n");
> -		return -EINVAL;
> -	}
> -
> -	dsi->lanes = mdsi->lanes;
> -	dsi->format = mdsi->format;
> -	dsi->mode_flags = mdsi->mode_flags;
> -
> -	return 0;
> -}
> -
> -static int dsi_host_detach(struct mipi_dsi_host *host,
> -			   struct mipi_dsi_device *mdsi)
> -{
> -	/* do nothing */
> -	return 0;
> -}
> -
> -static const struct mipi_dsi_host_ops dsi_host_ops = {
> -	.attach = dsi_host_attach,
> -	.detach = dsi_host_detach,
> -};
> -
> -static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
> -{
> -	struct mipi_dsi_host *host = &dsi->host;
> -	int ret;
> -
> -	host->dev = dev;
> -	host->ops = &dsi_host_ops;
> -	ret = mipi_dsi_host_register(host);
> -	if (ret) {
> -		DRM_ERROR("failed to register dsi host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int dsi_bridge_init(struct drm_device *dev, struct dw_dsi *dsi)
>  {
>  	struct drm_encoder *encoder = &dsi->encoder;
> @@ -796,10 +752,6 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
>  	if (ret)
>  		return ret;
>  
> -	ret = dsi_host_init(dev, dsi);
> -	if (ret)
> -		return ret;
> -
>  	ret = dsi_bridge_init(drm_dev, dsi);
>  	if (ret)
>  		return ret;
> @@ -817,13 +769,22 @@ static const struct component_ops dsi_ops = {
>  	.unbind	= dsi_unbind,
>  };
>  
> -static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
> +static int dsi_host_attach(struct mipi_dsi_host *host,
> +			   struct mipi_dsi_device *mdsi)
>  {
> -	struct dsi_hw_ctx *ctx = dsi->ctx;
> -	struct device_node *np = pdev->dev.of_node;
> -	struct resource *res;
> +	struct dw_dsi *dsi = host_to_dsi(host);
> +	struct device_node *np = dsi->dev->of_node;
>  	int ret;
>  
> +	if (mdsi->lanes < 1 || mdsi->lanes > 4) {
> +		DRM_ERROR("dsi device params invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	dsi->lanes = mdsi->lanes;
> +	dsi->format = mdsi->format;
> +	dsi->mode_flags = mdsi->mode_flags;
> +
>  	/*
>  	 * Get the endpoint node. In our case, dsi has one output port1
>  	 * to which the external HDMI bridge is connected.
> @@ -832,6 +793,42 @@ static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
>  	if (ret)
>  		return ret;
>  
> +	return component_add(dsi->dev, &dsi_ops);
> +}
> +
> +static int dsi_host_detach(struct mipi_dsi_host *host,
> +			   struct mipi_dsi_device *mdsi)
> +{
> +	/* do nothing */
> +	return 0;
> +}
> +
> +static const struct mipi_dsi_host_ops dsi_host_ops = {
> +	.attach = dsi_host_attach,
> +	.detach = dsi_host_detach,
> +};
> +
> +static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
> +{
> +	struct mipi_dsi_host *host = &dsi->host;
> +	int ret;
> +
> +	host->dev = dev;
> +	host->ops = &dsi_host_ops;
> +	ret = mipi_dsi_host_register(host);
> +	if (ret) {
> +		DRM_ERROR("failed to register dsi host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
> +{
> +	struct dsi_hw_ctx *ctx = dsi->ctx;
> +	struct resource *res;
> +
>  	ctx->pclk = devm_clk_get(&pdev->dev, "pclk");
>  	if (IS_ERR(ctx->pclk)) {
>  		DRM_ERROR("failed to get pclk clock\n");
> @@ -862,15 +859,19 @@ static int dsi_probe(struct platform_device *pdev)
>  	}
>  	dsi = &data->dsi;
>  	ctx = &data->ctx;
> +	dsi->dev = &pdev->dev;
>  	dsi->ctx = ctx;
>  
>  	ret = dsi_parse_dt(pdev, dsi);
>  	if (ret)
>  		return ret;
>  
> -	platform_set_drvdata(pdev, data);
> +	ret = dsi_host_init(&pdev->dev, dsi);
> +	if (ret)
> +		return ret;
>  
> -	return component_add(&pdev->dev, &dsi_ops);
> +	platform_set_drvdata(pdev, data);


I suspect platform_set_drvdata should be before dsi_host_init.

Imagine dsi_probe calls dsi_host_init it registers dsi_host and
instantly dsi_device appears, so dsi_host_attach is called, it calls
component_add and dsi_bind is called, which requires valid drvdata.


Beside this it looks correct, but it would be good to test it.

So after fixing above you can add my R-B.


Regards

Andrzej


> +	return 0;
>  }
>  
>  static int dsi_remove(struct platform_device *pdev)



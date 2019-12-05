Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CAC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D3E20659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LP3ZQoW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfLENaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:30:07 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60950 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLENaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:30:07 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 60B6D2E5;
        Thu,  5 Dec 2019 14:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575552604;
        bh=WvmzgvQByzYsM1PR+dhoUGTk69sy/jPs0F82Ylk9tFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP3ZQoW5e2pdJFBg995C8H+bC3rWIt1JndR3xEoBd5rjwbYW2iCfdWkehafbXh0v4
         FSR/3dSPc84kkI7Ynpe9Dm5Ch5R37vIFCCT2eE3hjdMGveT5c8bN5P8Kzwf1bygwyH
         4AiM9shFSX7G9WjSWT2reW7Xwps1hkv7Cy4X0+rY=
Date:   Thu, 5 Dec 2019 15:29:57 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Brian Masney <masneyb@onstation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>, Sean Paul <seanpaul@chromium.org>,
        nd <nd@arm.com>, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 03/28] drm/bridge/analogix: Use drm_bridge_init()
Message-ID: <20191205132957.GB16034@pendragon.ideasonboard.com>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
 <20191204114732.28514-4-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191204114732.28514-4-mihail.atanassov@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 11:48:04AM +0000, Mihail Atanassov wrote:
> No functional change.
> 
> The setting of bridge->of_node by drm_bridge_init() in
> analogix_dp_core.c is safe, since ->of_node isn't used directly and the
> bridge isn't published with drm_bridge_add().

Still, it's not the right device, is it ? And if we later extend the
usage of dev in drm_bridge_init() it could cause issues. I think you
should use the right device pointer.

> 
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 5 ++---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 8 ++------
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 ++---
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index b4f3a923a52a..130d5c3a07ef 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -696,8 +696,6 @@ static int anx6345_i2c_probe(struct i2c_client *client,
>  
>  	mutex_init(&anx6345->lock);
>  
> -	anx6345->bridge.of_node = client->dev.of_node;
> -
>  	anx6345->client = client;
>  	i2c_set_clientdata(client, anx6345);
>  
> @@ -760,7 +758,8 @@ static int anx6345_i2c_probe(struct i2c_client *client,
>  	/* Look for supported chip ID */
>  	anx6345_poweron(anx6345);
>  	if (anx6345_get_chip_id(anx6345)) {
> -		anx6345->bridge.funcs = &anx6345_bridge_funcs;
> +		drm_bridge_init(&anx6345->bridge, &client->dev,
> +				&anx6345_bridge_funcs, NULL, NULL);
>  		drm_bridge_add(&anx6345->bridge);
>  
>  		return 0;
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> index 41867be03751..e37892cdc9cf 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> @@ -1214,10 +1214,6 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  
>  	mutex_init(&anx78xx->lock);
>  
> -#if IS_ENABLED(CONFIG_OF)
> -	anx78xx->bridge.of_node = client->dev.of_node;
> -#endif
> -
>  	anx78xx->client = client;
>  	i2c_set_clientdata(client, anx78xx);
>  
> @@ -1321,8 +1317,8 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  		goto err_poweroff;
>  	}
>  
> -	anx78xx->bridge.funcs = &anx78xx_bridge_funcs;
> -
> +	drm_bridge_init(&anx78xx->bridge, &client->dev, &anx78xx_bridge_funcs,
> +			NULL, NULL);
>  	drm_bridge_add(&anx78xx->bridge);
>  
>  	/* If cable is pulled out, just poweroff and wait for HPD event */
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index bb411fe52ae8..4042ba9a98d8 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1585,9 +1585,8 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
>  
>  	dp->bridge = bridge;
>  
> -	bridge->driver_private = dp;
> -	bridge->funcs = &analogix_dp_bridge_funcs;
> -
> +	drm_bridge_init(bridge, drm_dev->dev, &analogix_dp_bridge_funcs,
> +			NULL, dp);
>  	ret = drm_bridge_attach(dp->encoder, bridge, NULL);
>  	if (ret) {
>  		DRM_ERROR("failed to attach drm bridge\n");

-- 
Regards,

Laurent Pinchart

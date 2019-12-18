Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF575C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BD5206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZKaWnXPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLRPt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:49:56 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48236 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfLRPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:49:56 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 934E0B23;
        Wed, 18 Dec 2019 16:49:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1576684193;
        bh=ckbI8wccE/ygxqSPEp5v6gm6VLIHWS9j1JU7iO9qAus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKaWnXPp1KNWhioJ4LWrYqXdnssNO8Lakl3X78HwTFChxIwk/YlSgB6+eCBExnItz
         HUp/Vr1Le7KAfBVjMX4lQptH9vQz1+xIQYYaNGGbeKB3+RFMEENx8ln9qUbMO5UFEc
         P8c3hDmfl2CZO2XIlholujzUWvxmLIZyNcHn3lbg=
Date:   Wed, 18 Dec 2019 17:49:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] drm/bridge: dw-hdmi: add max bpc connector
 property
Message-ID: <20191218154942.GG4863@pendragon.ideasonboard.com>
References: <20191218154637.17509-1-narmstrong@baylibre.com>
 <20191218154637.17509-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218154637.17509-3-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil and Jonas,

Thank you for the patch.

On Wed, Dec 18, 2019 at 04:46:29PM +0100, Neil Armstrong wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> Add the max_bpc property to the dw-hdmi connector to prepare support
> for 10, 12 & 16bit output support.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 6a0b4b3a6739..e7a0600f8cc5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2368,6 +2368,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>  				    DRM_MODE_CONNECTOR_HDMIA,
>  				    hdmi->ddc);
>  
> +	drm_atomic_helper_connector_reset(connector);
> +
> +	drm_connector_attach_max_bpc_property(connector, 8, 16);
> +

I'm not asking you to rework this, but have you given any thought on how
we would be able to support this feature in a model where the bridge
wouldn't create a connector anymore (as done in the latest version of
the omapdrm series) ?

>  	if (hdmi->version >= 0x200a && hdmi->plat_data->use_drm_infoframe)
>  		drm_object_attach_property(&connector->base,
>  			connector->dev->mode_config.hdr_output_metadata_property, 0);

-- 
Regards,

Laurent Pinchart

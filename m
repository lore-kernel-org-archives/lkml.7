Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B99DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085DC214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="irIL/oCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfDYJUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:20:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35156 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfDYJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:20:46 -0400
Received: from pendragon.ideasonboard.com (net-37-182-44-227.cust.vodafonedsl.it [37.182.44.227])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D34A5F;
        Thu, 25 Apr 2019 11:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556184044;
        bh=wKFgUNVPvgrqDMksLeW8+jhcvEQFGoAKVyqd+Lj7fmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irIL/oCS3OmdEXTEPeCYUpdW7MpBKSIAi3bxudpC1daOyrlL5MZHjB8g07jprkRBh
         XoQtV74cPXqktR09x9LFeRGpymtzgY2c9NXJz8o09HLOs8k0XTee3LWkPvRepxGd2J
         UqDHlfaJWtIozRRE6JO6AkRwmfg9XtBm75s710w0=
Date:   Thu, 25 Apr 2019 12:20:33 +0300
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
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Don't blindly call post_disable
Message-ID: <20190425092033.GB4557@pendragon.ideasonboard.com>
References: <20190424142148.25927-1-matt.redfearn@thinci.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424142148.25927-1-matt.redfearn@thinci.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Thank you for the patch.

On Wed, Apr 24, 2019 at 02:22:00PM +0000, Matt Redfearn wrote:
> The DRM documentation states that post_disable is an optional callback.
> As such an implementing device may not populate it. To avoid panicing
> the kernel by calling a NULL function pointer, we should NULL check it
> before blindy calling it.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 38e88071363..0ee440216b8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -805,7 +805,8 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
>  	 * This needs to be fixed in the drm_bridge framework and the API
>  	 * needs to be updated to manage our own call chains...
>  	 */
> -	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
> +	if (dsi->panel_bridge->funcs->post_disable)
> +		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
>  
>  	if (dsi->slave) {
>  		dw_mipi_dsi_disable(dsi->slave);

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F787C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E27B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LcsEQV1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfLENdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:33:19 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:32816 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLENdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:33:18 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2AE2B2E5;
        Thu,  5 Dec 2019 14:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575552797;
        bh=CM/D7ImuDda2Rno8YpyzWs+w1xLm2R0xK+5mrlUzuag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcsEQV1+tNRZ8+JNpWuKyv2NVE95IXgah30yaQpfG55D04a4e5y5hjCIrQ4DnI0gl
         XkhhLhOfqjV+57w7t/Gsn5SGbZOv3qrahwvr1p341yaLFe/CFS7rL0fqvIneZqiSOj
         Rdb9Kt1k2+7O0+J+TaGmQtBTrD617A6k/GDE513A=
Date:   Thu, 5 Dec 2019 15:33:10 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 18/28] drm/bridge: thc63: Use drm_bridge_init()
Message-ID: <20191205133310.GE16034@pendragon.ideasonboard.com>
References: <20191204114732.28514-1-mihail.atanassov@arm.com>
 <20191204114732.28514-19-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191204114732.28514-19-mihail.atanassov@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail,

Thank you for the patch.

On Wed, Dec 04, 2019 at 11:48:18AM +0000, Mihail Atanassov wrote:
> No functional change.
> 
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
> index 3d74129b2995..abe806db5f4d 100644
> --- a/drivers/gpu/drm/bridge/thc63lvd1024.c
> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
> @@ -218,11 +218,8 @@ static int thc63_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	thc63->bridge.driver_private = thc63;
> -	thc63->bridge.of_node = pdev->dev.of_node;
> -	thc63->bridge.funcs = &thc63_bridge_func;
> -	thc63->bridge.timings = &thc63->timings;
> -
> +	drm_bridge_init(&thc63->bridge, &pdev->dev, &thc63_bridge_func,
> +			&thc63->timings, thc63);

I think driver_private is unused, so the last argument can be NULL.

>  	drm_bridge_add(&thc63->bridge);
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart

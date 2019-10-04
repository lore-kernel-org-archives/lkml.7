Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C98C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD182133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OsTRP76d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfJDHCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:02:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42478 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbfJDHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:02:47 -0400
Received: from pendragon.ideasonboard.com (modemcable151.96-160-184.mc.videotron.ca [184.160.96.151])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 55CAB2E5;
        Fri,  4 Oct 2019 09:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1570172565;
        bh=zrmGFbzG/xfE9YuhXNxnTY76RKJI2smtQphq1F+z+qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsTRP76d6DshPuBsb+yJthu1LXvQRz2gJ/DeNpO+FRr80VEQBegUxgXQB/Xk4XNA7
         Z2Oa1uF1bX19rXANY+O6G5WWa1svRYuun46yNIarOMkrP1BziraQjA+ePnMcjxX9Wv
         CQh80E7fSvDHK7yJ3klcIw+WS5aefuRxP9r9JWiA=
Date:   Fri, 4 Oct 2019 10:02:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sii902x: Variable status in
 sii902x_connector_detect() could be uninitialized if regmap_read() fails
Message-ID: <20190930231948.GB10149@pendragon.ideasonboard.com>
References: <20190930044502.18734-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930044502.18734-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yizhuo,

Thank you for the patch.

On Sun, Sep 29, 2019 at 09:45:02PM -0700, Yizhuo wrote:
> In function sii902x_connector_detect(), variable "status" could be
> initialized if regmap_read() fails. However, "status" is used to

I assume you meant "could be uninitialized" ?

> decide the return value, which is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 38f75ac580df..afce64f51ff2 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -246,7 +246,7 @@ static enum drm_connector_status
>  sii902x_connector_detect(struct drm_connector *connector, bool force)
>  {
>  	struct sii902x *sii902x = connector_to_sii902x(connector);
> -	unsigned int status;
> +	unsigned int status = 0;
>  
>  	mutex_lock(&sii902x->mutex);

I'll add a bit more context:

> 	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>
> 	mutex_unlock(&sii902x->mutex);
>
> 	return (status & SII902X_PLUGGED_STATUS) ?
> 	       connector_status_connected : connector_status_disconnected;

If regmap read fails, shouldn't we return connector_status_unknown ?

-- 
Regards,

Laurent Pinchart

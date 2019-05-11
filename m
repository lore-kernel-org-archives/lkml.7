Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5342C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BE220657
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 19:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qPeEvNAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEKTco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 15:32:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57458 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 15:32:44 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9466F2B6;
        Sat, 11 May 2019 21:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1557603162;
        bh=4GxJMWPvsoT7sFOH6pc36YVXHmeGHUgyYVxKO5tdj9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPeEvNAymM9eKh3Qwo99SifRNGsfBkUKuBbkdHyqQXDjM26T+QWENZN1wP9bZJPSK
         AsJ9RTRH3yLdizwG/v/lZmC9iub8mKO1ri/rapjQZP2GJjxWvR7+NKDuMg1M5tE4OO
         0BQJtf7fldzjxQ4FLShSoM8HWsmqOAVSv3y3981I=
Date:   Sat, 11 May 2019 22:32:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bridge: adv7511: Fix low refresh rate selection
Message-ID: <20190511193226.GO13043@pendragon.ideasonboard.com>
References: <20190424132210.26338-1-matt.redfearn@thinci.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424132210.26338-1-matt.redfearn@thinci.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Thank you for the patch.

On Wed, Apr 24, 2019 at 01:22:27PM +0000, Matt Redfearn wrote:
> The driver currently sets register 0xfb (Low Refresh Rate) based on the
> value of mode->vrefresh. Firstly, this field is specified to be in Hz,
> but the magic numbers used by the code are Hz * 1000. This essentially
> leads to the low refresh rate always being set to 0x01, since the
> vrefresh value will always be less than 24000. Fix the magic numbers to
> be in Hz.
> Secondly, according to the comment in drm_modes.h, the field is not
> supposed to be used in a functional way anyway. Instead, use the helper
> function drm_mode_vrefresh().
> 
> Fixes: 9c8af882bf12 ("drm: Add adv7511 encoder driver")
> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>

Wow, a 4.5 year old bug fix, nice :-)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 85c2d407a52..e7ddd3e3db9 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -747,11 +747,11 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
>  			vsync_polarity = 1;
>  	}
>  
> -	if (mode->vrefresh <= 24000)
> +	if (drm_mode_vrefresh(mode) <= 24)
>  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_24HZ;
> -	else if (mode->vrefresh <= 25000)
> +	else if (drm_mode_vrefresh(mode) <= 25)
>  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_25HZ;
> -	else if (mode->vrefresh <= 30000)
> +	else if (drm_mode_vrefresh(mode) <= 30)
>  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_30HZ;
>  	else
>  		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF2CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0F42070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dvw7tFAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCDMdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:33:08 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36372 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:33:07 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5196322;
        Mon,  4 Mar 2019 13:33:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551702785;
        bh=P33PS7fjnYDz/GZa2On6m7yWbUlifnxHKa/xIBpslSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvw7tFAvOZDbXw5p70R61eDljX1THfkt77Gq3lrC5/4O0iolVUY9fbpyy4Kptfba+
         ZnijuBdIpvRrrGRHYNuJOw5mu6ho6G/irg2E2UMsOa6cLaHBhzz16tblWRTswEtLc5
         80lPnkae7/onb6QiI9OSc54VEqLsqF8e24mTGFOI=
Date:   Mon, 4 Mar 2019 14:33:00 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] drm/bridge: tc358767: Simplify error check in
 tc_aux_linx_setup()
Message-ID: <20190304123300.GH6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-7-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-7-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch.

On Tue, Feb 26, 2019 at 11:36:06AM -0800, Andrey Smirnov wrote:
> Tc_poll_timeout() can only return -ETIMEDOUT, so checking for other
> errors is not necessary. Drop it. No functional change intended.

Is that true given patch 1/9 in this series ? regmap_read_poll_timeout()
can also return an error from regmap_read().

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index ea30cec4a0c3..54ff95f66e30 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -569,11 +569,10 @@ static int tc_aux_link_setup(struct tc_data *tc)
>  
>  	ret = tc_poll_timeout(tc->regmap, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1,
>  			      1000);
> -	if (ret == -ETIMEDOUT) {
> +	if (ret) {
>  		dev_err(tc->dev, "Timeout waiting for PHY to become ready");
>  		return ret;
> -	} else if (ret)
> -		goto err;
> +	}
>  
>  	/* Setup AUX link */
>  	tc_write(DP0_AUXCFG1, AUX_RX_FILTER_EN |

-- 
Regards,

Laurent Pinchart

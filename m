Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C8DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24D92070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="idExVj2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCDM2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:28:33 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36306 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCDM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:28:32 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 46644322;
        Mon,  4 Mar 2019 13:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551702511;
        bh=gedTTYtBj/0mK2KSn+Tf/CBiS+ftOQ7/VXozsTIs6W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idExVj2ldSfXzfniqvjRTKO6QZdTWeiKw+5m8zDkOdr4Lo70sAmew2wXnUg8gO4Q/
         W3zCbTqoNmk+Bnp10Xfx+5ISuZd0HpF6R/hNdVxgjLNwiIxNEnbFtkivrWkp3gonX8
         T6i5g7P19lrcmgGjMbWNJoDNLNcWCqiGQXwBiMjQ=
Date:   Mon, 4 Mar 2019 14:28:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] drm/bridge: tc358767: Simplify polling in
 tc_main_link_setup()
Message-ID: <20190304122825.GF6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-5-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-5-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:36:04AM -0800, Andrey Smirnov wrote:
> Replace explicit polling loop with equivalent call to
> regmap_read_poll_timeout() for simplicity. No functional change
> intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/tc358767.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index c85468fcc157..6455e6484722 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -882,15 +882,11 @@ static int tc_main_link_setup(struct tc_data *tc)
>  	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
>  	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
>  
> -	timeout = 1000;
> -	do {
> -		tc_read(DP_PHY_CTRL, &value);
> -		udelay(1);
> -	} while ((!(value & PHY_RDY)) && (--timeout));
> -
> -	if (timeout == 0) {
> +	ret = regmap_read_poll_timeout(tc->regmap, DP_PHY_CTRL, value,
> +				       value & PHY_RDY, 1, 1000);
> +	if (ret) {
>  		dev_err(dev, "timeout waiting for phy become ready");
> -		return -ETIMEDOUT;
> +		return ret;
>  	}
>  
>  	/* Set misc: 8 bits per color */

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330D62070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="J7mUOqZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCDMhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:37:19 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36468 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:37:18 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9786322;
        Mon,  4 Mar 2019 13:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551703037;
        bh=0CwMaXHKikupYrxPjsvvAuKamf0ZOpYVphqttWdfprA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7mUOqZJ6RetBN6HbgKiHXik82yRSnkbRdOllt7I1LQnRqtIZEymRErn0a1NtM6ir
         y+p+YxeSHohp9lgJN1QJjAg+Awi/7TJWGQdIK92AKW+G0emmx7i/3liGD8Dmj7efkC
         mrjWqu1UIrr/Qdda4qQLzOCXWlyZjxZgDt2zfEkw=
Date:   Mon, 4 Mar 2019 14:37:11 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
Message-ID: <20190304123711.GJ6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-9-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-9-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch.

On Tue, Feb 26, 2019 at 11:36:08AM -0800, Andrey Smirnov wrote:
> Tc_wait_pll_lock() is always called as a follow-up for updating

s/Tc/tc/

> PLLUPDATE and PLLEN bit of a given PLL control register. To simplify
> things, merge the two operation into a single helper function
> tc_pllupdate_pllen() and convert the rest of the code to use it. No
> functional change intended.
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
>  drivers/gpu/drm/bridge/tc358767.c | 36 +++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 227f14cd2d3d..239b3aaa255d 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -390,10 +390,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
>  	return reg;
>  }
>  
> -static void tc_wait_pll_lock(struct tc_data *tc)
> +static int tc_pllupdate_pllen(struct tc_data *tc, unsigned int pllctrl)
>  {
> +	int ret;
> +
> +	ret = regmap_write(tc->regmap, pllctrl, PLLUPDATE | PLLEN);
> +	if (ret)
> +		return ret;
> +
>  	/* Wait for PLL to lock: up to 2.09 ms, depending on refclk */
>  	usleep_range(3000, 6000);
> +
> +	return 0;
>  }
>  
>  static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
> @@ -487,11 +495,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
>  		 (best_mul << 0));		/* Multiplier for PLL */
>  
>  	/* Force PLL parameter update and disable bypass */
> -	tc_write(PXL_PLLCTRL, PLLUPDATE | PLLEN);
> -
> -	tc_wait_pll_lock(tc);
> -
> -	return 0;
> +	return tc_pllupdate_pllen(tc, PXL_PLLCTRL);
>  err:
>  	return ret;
>  }
> @@ -568,11 +572,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
>  	 * Initially PLLs are in bypass. Force PLL parameter update,
>  	 * disable PLL bypass, enable PLL
>  	 */
> -	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
> -	tc_wait_pll_lock(tc);
> +	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
> -	tc_wait_pll_lock(tc);
> +	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
> +	if (ret)
> +		return ret;
>  
>  	ret = tc_poll_timeout(tc->regmap, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1,
>  			      1000);
> @@ -846,11 +852,13 @@ static int tc_main_link_setup(struct tc_data *tc)
>  	msleep(100);
>  
>  	/* PLL setup */
> -	tc_write(DP0_PLLCTRL, PLLUPDATE | PLLEN);
> -	tc_wait_pll_lock(tc);
> +	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
> +	if (ret)
> +		return ret;
>  
> -	tc_write(DP1_PLLCTRL, PLLUPDATE | PLLEN);
> -	tc_wait_pll_lock(tc);
> +	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
> +	if (ret)
> +		return ret;
>  
>  	/* PXL PLL setup */
>  	if (tc_test_pattern) {

-- 
Regards,

Laurent Pinchart

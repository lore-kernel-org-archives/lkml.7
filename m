Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42981C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9132070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NxDe6Y4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCDMeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:34:44 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36408 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCDMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:34:44 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5E7E322;
        Mon,  4 Mar 2019 13:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551702882;
        bh=lw5+jiIqjW4Tc1qsS+fAZPZfZ8oZIp+Et7DLXneCmj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxDe6Y4Ycek/vOtG8feMPtDBpbgeHV7J7GVFiNUQrELBpFFtQ4YsDOorpDtq+LyFu
         kYbSQTBA09TP9caXezB3k46OK2889B5ph+QOFPND1qPfFzYI9x2HeG7VkcBLDiWohB
         3VJKsPI89RPRcBaNwtNPwhjtixFcEu4Kkzdxyr7A=
Date:   Mon, 4 Mar 2019 14:34:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] drm/bridge: tc358767: Introduce tc_set_syspllparam()
Message-ID: <20190304123436.GI6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-8-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-8-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch.

On Tue, Feb 26, 2019 at 11:36:07AM -0800, Andrey Smirnov wrote:
> Move common code converting clock rate to an appropriate constant and
> configuring SYS_PLLPARAM register into a separate routine and convert
> the rest of the code to use it. No functional change intended.
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
>  drivers/gpu/drm/bridge/tc358767.c | 50 +++++++++++++------------------
>  1 file changed, 20 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 54ff95f66e30..227f14cd2d3d 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -522,35 +522,42 @@ static int tc_stream_clock_calc(struct tc_data *tc)
>  	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
>  }
>  
> -static int tc_aux_link_setup(struct tc_data *tc)
> +static int tc_set_syspllparam(struct tc_data *tc)
>  {
>  	unsigned long rate;
> -	u32 value;
> -	int ret;
> -	u32 dp_phy_ctrl;
> +	u32 pllparam = SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
>  
>  	rate = clk_get_rate(tc->refclk);
>  	switch (rate) {
>  	case 38400000:
> -		value = REF_FREQ_38M4;
> +		pllparam |= REF_FREQ_38M4;
>  		break;
>  	case 26000000:
> -		value = REF_FREQ_26M;
> +		pllparam |= REF_FREQ_26M;
>  		break;
>  	case 19200000:
> -		value = REF_FREQ_19M2;
> +		pllparam |= REF_FREQ_19M2;
>  		break;
>  	case 13000000:
> -		value = REF_FREQ_13M;
> +		pllparam |= REF_FREQ_13M;
>  		break;
>  	default:
>  		dev_err(tc->dev, "Invalid refclk rate: %lu Hz\n", rate);
>  		return -EINVAL;
>  	}
>  
> +	return regmap_write(tc->regmap, SYS_PLLPARAM, pllparam);
> +}
> +
> +static int tc_aux_link_setup(struct tc_data *tc)
> +{
> +	int ret;
> +	u32 dp_phy_ctrl;
> +
>  	/* Setup DP-PHY / PLL */
> -	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
> -	tc_write(SYS_PLLPARAM, value);
> +	ret = tc_set_syspllparam(tc);
> +	if (ret)
> +		return ret;
>  
>  	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN;
>  	if (tc->link.base.num_lanes == 2)
> @@ -811,7 +818,6 @@ static int tc_main_link_setup(struct tc_data *tc)
>  {
>  	struct drm_dp_aux *aux = &tc->aux;
>  	struct device *dev = tc->dev;
> -	unsigned int rate;
>  	u32 dp_phy_ctrl;
>  	int timeout;
>  	u32 value;
> @@ -828,25 +834,9 @@ static int tc_main_link_setup(struct tc_data *tc)
>  		 (tc->link.spread ? DP0_SRCCTRL_SSCG : 0) |
>  		 ((tc->link.base.rate != 162000) ? DP0_SRCCTRL_BW27 : 0));
>  
> -	rate = clk_get_rate(tc->refclk);
> -	switch (rate) {
> -	case 38400000:
> -		value = REF_FREQ_38M4;
> -		break;
> -	case 26000000:
> -		value = REF_FREQ_26M;
> -		break;
> -	case 19200000:
> -		value = REF_FREQ_19M2;
> -		break;
> -	case 13000000:
> -		value = REF_FREQ_13M;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	value |= SYSCLK_SEL_LSCLK | LSCLK_DIV_2;
> -	tc_write(SYS_PLLPARAM, value);
> +	ret = tc_set_syspllparam(tc);
> +	if (ret)
> +		return ret;
>  
>  	/* Setup Main Link */
>  	dp_phy_ctrl = BGREN | PWR_SW_EN | PHY_A0_EN | PHY_M0_EN;
> -- 
> 2.20.1
> 

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4AA2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uBjx8V2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCDM0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:26:05 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36278 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCDM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:26:04 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62F66322;
        Mon,  4 Mar 2019 13:26:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551702361;
        bh=n3IPZd0Grftkon8Hd9xZtBKf9uazLnBA2edLk4j0gUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBjx8V2tvxHW7ZXw1w/ibolgg7NEONs0DwInwasRkvns6/ImK9gOJY6ps8gqwMpLS
         01oZaSHkBIv4kP17CJETFwOf4Nw619fDvIoAmlqXvDW7EtPK1b35UMZXxXtMhDmV7x
         XhfIByhWbB+Qq9/KthpV6ws3uWj4SGW06eW2tpOU=
Date:   Mon, 4 Mar 2019 14:25:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] drm/bridge: tc358767: Simplify tc_set_video_mode()
Message-ID: <20190304122556.GE6325@pendragon.ideasonboard.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226193609.9862-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Thank you for the patch.

On Tue, Feb 26, 2019 at 11:36:03AM -0800, Andrey Smirnov wrote:
> Simplify tc_set_video_mode() by replacing repreated calls to
> tc_write()/regmap_write() with a single call regmap_multi_reg_write().
> No functional change intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 125 ++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 86ebd49194b7..c85468fcc157 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -641,10 +641,6 @@ static int tc_get_display_props(struct tc_data *tc)
>  
>  static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
>  {
> -	int ret;
> -	int vid_sync_dly;
> -	int max_tu_symbol;
> -
>  	int left_margin = mode->htotal - mode->hsync_end;
>  	int right_margin = mode->hsync_start - mode->hdisplay;
>  	int hsync_len = mode->hsync_end - mode->hsync_start;
> @@ -653,76 +649,85 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
>  	int vsync_len = mode->vsync_end - mode->vsync_start;
>  
>  	/*
> -	 * Recommended maximum number of symbols transferred in a transfer unit:
> +	 * Recommended maximum number of symbols transferred in a
> +	 * transfer unit:
>  	 * DIV_ROUND_UP((input active video bandwidth in bytes) * tu_size,
>  	 *              (output active video bandwidth in bytes))
>  	 * Must be less than tu_size.
>  	 */
> -	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
> -
> -	dev_dbg(tc->dev, "set mode %dx%d\n",
> -		mode->hdisplay, mode->vdisplay);
> -	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
> -		left_margin, right_margin, hsync_len);
> -	dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
> -		upper_margin, lower_margin, vsync_len);
> -	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
> -
> +	int max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
>  
> +	/* DP Main Stream Attributes */
> +	int vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
>  	/*
>  	 * LCD Ctl Frame Size
>  	 * datasheet is not clear of vsdelay in case of DPI
>  	 * assume we do not need any delay when DPI is a source of
>  	 * sync signals
>  	 */
> -	tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
> -		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
> -	tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
> -			 (ALIGN(hsync_len, 2) << 0));	 /* Hsync */
> -	tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
> -			 (ALIGN(mode->hdisplay, 2) << 0)); /* width */
> -	tc_write(VTIM01, (upper_margin << 16) |		/* V back porch */
> -			 (vsync_len << 0));		/* Vsync */
> -	tc_write(VTIM02, (lower_margin << 16) |		/* V front porch */
> -			 (mode->vdisplay << 0));	/* height */
> -	tc_write(VFUEN0, VFUEN);		/* update settings */
> -
> +	u32 vpctrl0 = (0 << 20) /* VSDELAY */ |
> +		      OPXLFMT_RGB888 | FRMSYNC_DISABLED |
> +		      MSF_DISABLED;
> +	u32 htim01 = (ALIGN(left_margin, 2) << 16) | /* H back porch */
> +		     (ALIGN(hsync_len, 2) << 0); /* Hsync */
> +	u32 htim02 = (ALIGN(right_margin, 2) << 16) | /* H front porch */
> +		     (ALIGN(mode->hdisplay, 2) << 0); /* width */
> +	u32 vtim01 = (upper_margin << 16) | /* V back porch */
> +		     (vsync_len << 0); /* Vsync */
> +	u32 vtim02 = (lower_margin << 16) | /* V front porch */
> +		     (mode->vdisplay << 0); /* height */
>  	/* Test pattern settings */
> -	tc_write(TSTCTL,
> -		 (120 << 24) |	/* Red Color component value */
> -		 (20 << 16) |	/* Green Color component value */
> -		 (99 << 8) |	/* Blue Color component value */
> -		 (1 << 4) |	/* Enable I2C Filter */
> -		 (2 << 0) |	/* Color bar Mode */
> -		 0);
> -
> -	/* DP Main Stream Attributes */
> -	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
> -	tc_write(DP0_VIDSYNCDELAY,
> -		 (max_tu_symbol << 16) |	/* thresh_dly */
> -		 (vid_sync_dly << 0));
> +	u32 tstctl = (120 << 24) |  /* Red Color component value */
> +		     (20 << 16)  |  /* Green Color component value */
> +		     (99 <<  8)  |  /* Blue Color component value */
> +		     (1 <<  4)   |  /* Enable I2C Filter */
> +		     (2 <<  0);     /* Color bar Mode */
> +	u32 dp0_vidsyncdelay = (max_tu_symbol << 16) |	/* thresh_dly */
> +			       (vid_sync_dly << 0);
> +	u32 dp0_totalval = (mode->vtotal << 16) | (mode->htotal);
> +	u32 dp0_startval = ((upper_margin + vsync_len) << 16) |
> +			   ((left_margin + hsync_len) << 0);
> +	u32 dp0_activeval = (mode->vdisplay << 16) | (mode->hdisplay);
> +	u32 dp0_syncval = (vsync_len << 16) | (hsync_len << 0) |
> +			  (mode->flags & DRM_MODE_FLAG_NHSYNC) ?
> +			  SYNCVAL_HS_POL_ACTIVE_LOW : 0 |
> +			  (mode->flags & DRM_MODE_FLAG_NVSYNC) ?
> +			  SYNCVAL_VS_POL_ACTIVE_LOW : 0;
> +	u32 dpipxlfmt = VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> +			DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
> +			DPI_BPP_RGB888;
> +	u32 dp0_misc = (max_tu_symbol << 23) |
> +		       (TU_SIZE_RECOMMENDED << 16) |
> +		       BPC_8;
> +
> +	const struct reg_sequence video_mode_settings[] = {
> +		{ VPCTRL0, vpctrl0 },
> +		{ HTIM01, htim01 },
> +		{ HTIM02, htim02 },
> +		{ VTIM01, vtim01 },
> +		{ VTIM02, vtim02 },
> +		{ VFUEN0, VFUEN },  /* update settings */
> +		{ TSTCTL, tstctl },
> +		{ DP0_VIDSYNCDELAY, dp0_vidsyncdelay },
> +		{ DP0_TOTALVAL, dp0_totalval },
> +		{ DP0_STARTVAL, dp0_startval },
> +		{ DP0_ACTIVEVAL, dp0_activeval },
> +		{ DP0_SYNCVAL, dp0_syncval },
> +		{ DPIPXLFMT, dpipxlfmt },
> +		{ DP0_MISC, dp0_misc },
> +	};

I like the removal of the tc_write() macro, but slightly dislike the
need for this array. Another possible option to handle errors in a nicer
way would be

static int tc_write(struct tc_data *tc, unsigned int reg, unsigned int val,
		    int *status)
{
	if (!*status)
		*status = regmap_write(tc->regmap, reg, val);
	return *status;
}

...
	int err = 0;

	tc_write(tc, ..., ..., &err);
	tc_write(tc, ..., ..., &err);
	tc_write(tc, ..., ..., &err);
	tc_write(tc, ..., ..., &err);
	tc_write(tc, ..., ..., &err);

	return err;

I will let you and the driver author(s) device what would be best.

>  
> -	tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
> -
> -	tc_write(DP0_STARTVAL,
> -		 ((upper_margin + vsync_len) << 16) |
> -		 ((left_margin + hsync_len) << 0));
> -
> -	tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
> -
> -	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0) |
> -		 ((mode->flags & DRM_MODE_FLAG_NHSYNC) ? SYNCVAL_HS_POL_ACTIVE_LOW : 0) |
> -		 ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? SYNCVAL_VS_POL_ACTIVE_LOW : 0));
> -
> -	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
> -		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
> -
> -	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
> -			   BPC_8);
> +	dev_dbg(tc->dev, "set mode %dx%d\n",
> +		mode->hdisplay, mode->vdisplay);
> +	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
> +		left_margin, right_margin, hsync_len);
> +	dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
> +		upper_margin, lower_margin, vsync_len);
> +	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
>  
> -	return 0;
> -err:
> -	return ret;
> +	return regmap_multi_reg_write(tc->regmap,
> +				      video_mode_settings,
> +				      ARRAY_SIZE(video_mode_settings));
>  }
>  
>  static int tc_link_training(struct tc_data *tc, int pattern)

-- 
Regards,

Laurent Pinchart

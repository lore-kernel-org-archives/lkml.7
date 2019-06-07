Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04374C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0E520840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZO4rdF0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfFGNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:38:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41766 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfFGNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:38:40 -0400
Received: from pendragon.ideasonboard.com (unknown [IPv6:2a02:a03f:44f0:8500:ca05:8177:199c:fed4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F88E334;
        Fri,  7 Jun 2019 15:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1559914718;
        bh=cZWJM1dGWVBJvNXv07QLU66jY8fTal7gs4kQKfSyIAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZO4rdF0cZmRzSCRE2r/yzqMnESSU+RYfuDkWC5d0d9ZFpoTzj5PIr9xSnI0SsdqXl
         Qf7nRCBMJPzAk5ykLUE9R8QeUFQdvrXnyxb6Z46Nr4nBzNk2IX1NxzjZQDuCw8Mp3e
         mf5k1OAOoyidAQCAKMXgWF/m2rKG5dBXjLcyOnkU=
Date:   Fri, 7 Jun 2019 16:38:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, jernej.skrabec@siol.net,
        maxime.ripard@bootlin.com, jonas@kwiboo.se,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/5] drm/bridge: add encoder support to specify bridge
 input format
Message-ID: <20190607133818.GM7593@pendragon.ideasonboard.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com>
 <20190520133753.23871-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520133753.23871-3-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thank you for the patch.

On Mon, May 20, 2019 at 03:37:50PM +0200, Neil Armstrong wrote:
> This patch adds a new format_set() callback to the bridge ops permitting
> the encoder to specify the new input format and encoding.
> 
> This allows supporting the very specific HDMI2.0 YUV420 output mode
> when the bridge cannot convert from RGB or YUV444 to YUV420.
> 
> In this case, the encode must downsample before the bridge and must
> specify the bridge the new input bus format differs.
> 
> This will also help supporting the YUV420 mode where the bridge cannot
> downsample, and also support 10bit, 12bit and 16bit output modes
> when the bridge cannot convert between different bit depths.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 35 +++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     | 19 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 138b2711d389..33be74a977f7 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -307,6 +307,41 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
>  }
>  EXPORT_SYMBOL(drm_bridge_mode_set);
>  
> +/**
> + * drm_bridge_format_set - setup with proposed input format and encoding for
> + *			   all bridges in the encoder chain
> + * @bridge: bridge control structure
> + * @input_bus_format: proposed input bus format for the bridge
> + * @input_encoding: proposed input encoding for this bridge
> + *
> + * Calls &drm_bridge_funcs.format_set op for all the bridges in the
> + * encoder chain, starting from the first bridge to the last.
> + *
> + * Note: the bridge passed should be the one closest to the encoder
> + *
> + * RETURNS:
> + * true on success, false if one of the bridge cannot handle the format

I would return an int to propagate the failure reason upstream. It will
reach the commit tail handler in any case, so will be dropped there, but
could help debugging issues if we print it in the right place.

> + */
> +bool drm_bridge_format_set(struct drm_bridge *bridge,
> +			   const u32 input_bus_format,
> +			   const u32 input_encoding)

You don't need a const here.

> +{
> +	bool ret = true;
> +
> +	if (!bridge)
> +		return true;
> +
> +	if (bridge->funcs->format_set)
> +		ret = bridge->funcs->format_set(bridge, input_bus_format,
> +						input_encoding);
> +	if (!ret)
> +		return ret;
> +
> +	return drm_bridge_format_set(bridge->next, input_bus_format,
> +				     input_encoding);

I don't think this will scale. It's not that uncommon for bridges to
change the format (most likely converting from YUV to RGB or the other
way around, or reducing the number of bits per sample) and the encoding.
We thus can't propagate it from bridge to bridge and expect that to
work.

At the very least, the bridge should report its output bus format and
encoding, to be applied to the next bridge, but this won't allow
checking if the configuration can be applied ahead of time, resulting in
possible failures of a commit tail handler. I wonder if this wouldn't be
a good time to introduce bridge states...

> +}
> +EXPORT_SYMBOL(drm_bridge_format_set);
> +
>  /**
>   * drm_bridge_pre_enable - prepares for enabling all
>   *			   bridges in the encoder chain
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index d4428913a4e1..7a79e61b7825 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -198,6 +198,22 @@ struct drm_bridge_funcs {
>  	void (*mode_set)(struct drm_bridge *bridge,
>  			 const struct drm_display_mode *mode,
>  			 const struct drm_display_mode *adjusted_mode);
> +
> +	/**
> +	 * @format_set:
> +	 *
> +	 * This callback should configure the bridge for the given input bus
> +	 * format and encoding. It is called after the @format_set callback
> +	 * for the preceding element in the display pipeline has been called
> +	 * already. If the bridge is the first element then this would be
> +	 * &drm_encoder_helper_funcs.format_set. The display pipe (i.e.
> +	 * clocks and timing signals) is off when this function is called.
> +	 *
> +	 * @returns: true in success, false is a bridge refuses the format
> +	 */
> +	bool (*format_set)(struct drm_bridge *bridge,
> +			   const u32 input_bus_format,
> +			   const u32 input_encoding);
>  	/**
>  	 * @pre_enable:
>  	 *
> @@ -311,6 +327,9 @@ void drm_bridge_post_disable(struct drm_bridge *bridge);
>  void drm_bridge_mode_set(struct drm_bridge *bridge,
>  			 const struct drm_display_mode *mode,
>  			 const struct drm_display_mode *adjusted_mode);
> +bool drm_bridge_format_set(struct drm_bridge *bridge,
> +			   const u32 input_bus_format,
> +			   const u32 input_encoding);
>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>  void drm_bridge_enable(struct drm_bridge *bridge);
>  

-- 
Regards,

Laurent Pinchart

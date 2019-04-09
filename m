Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D10EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93F62133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZCY6TRVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDIJ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:29:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfDIJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:29:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so19934041wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dRJoK6WxAQ4AN7sy10Kd6x1SNaxMqIj/DPs3V2fUy1w=;
        b=ZCY6TRVVz78xBDAKmRYQFtVezjh7fCQw2HLgRsG5WNaN7FN9gcD05a6ESD6AzEstf7
         +pZtwM3aFov8T5eP/36ZhpylLJoo79kOu6soWfoOGw9dyPsY8pTBrKvO/FF6hBSqiihI
         gY/zKIbs5Mz3Gbk2KecJz9LuvdRJXu8YRNBt7f++fWDLQmDqdu+Jwf9zvAGnAmidPDa+
         XpkVp8Ny2BYoBMynltWLwzR/Gz+wJBaqwkvFXd2oqnWYpiPO0lWbVSwIwlsbKsFG8jPt
         t8EjLqQgCIxbPkDUC33DQzSBSkMMXkY70XyC/GixsLw5PLxxFijkVdEce6wiXcOEnOj4
         d58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dRJoK6WxAQ4AN7sy10Kd6x1SNaxMqIj/DPs3V2fUy1w=;
        b=klBEes7GhEbvl87UqiNY2NoS1IY7F0Ui/KMbddmpYIxbsZTKK0gpCVAP9FSR4QAGyr
         5tMV9wmVJoSjUN32G/B1gcRtVRfnWfBGzM3nHhgJ4nE5Ghij9zKWBcQb0ZbaF3lgNmqE
         DgbjYFCN00A4z+1glPMSdxKpVx3yb4/WJLcTFCrFciMeLjNXJmgxAF1kyK0jSD2D7Tbm
         HdYp8johmFSvFBmcG+TPzvJ5Yq3doPcgytJxlIOavUBuXrm8CkMzgpe4fR2fsTHBiBmB
         qJbkF+iRJ5hFrpcvYmBke+ze3D0VRNEV4bfx2sX/s0ccxdNuMcu70sJ4Tw1v6QMIDr5T
         +IpQ==
X-Gm-Message-State: APjAAAX7fTdt18DdyO/FJ59gihefeCs0uaaQfNnt3qkbqYDNoHj0wObR
        kt7Kw+bZWBI1te2WzBlWLT9RuHjLYBGmVQ==
X-Google-Smtp-Source: APXvYqzPR+d/etMZ2smSIsiuiS0qYqEHbxZTn9zdQQp9Fwanv+IwrCMkxKxT9Ymbjv7BhcJfvBwk0Q==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr20832873wra.226.1554802185102;
        Tue, 09 Apr 2019 02:29:45 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z11sm12090987wmf.12.2019.04.09.02.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:29:44 -0700 (PDT)
Subject: Re: [PATCH RFC 2/5] drm/bridge: add encoder support to specify bridge
 input format
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190329104240.29585-1-narmstrong@baylibre.com>
 <20190329104240.29585-3-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <0d04a59d-0254-10a0-f832-3dfbf3b2cfcb@baylibre.com>
Date:   Tue, 9 Apr 2019 11:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329104240.29585-3-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 29/03/2019 11:42, Neil Armstrong wrote:
> This patch adds a new format_set() callback to the bridge ops permitting
> the encoder to specify the new input format and encoding.

Is this something better ? This doesn't violate the layering anymore,
do you have any thoughts about this new API ?

Neil

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
> index 138b2711d389..b2ce2d3d070e 100644
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
> + */
> +bool drm_bridge_format_set(struct drm_bridge *bridge,
> +			   const u32 input_bus_format,
> +			   const u32 input_encoding)
> +{
> +	bool ret = true;
> +
> +	if (!bridge)
> +		return true;
> +
> +	if (bridge->funcs->format_set)
> +		ret = bridge->funcs->format_set(bridge, input_bus_format,
> +						input_encoding);
> +	if (ret)
> +		return ret;
> +
> +	return drm_bridge_format_set(bridge->next, input_bus_format,
> +				     input_encoding);
> +}
> +EXPORT_SYMBOL(drm_bridge_format_set);
> +
>  /**
>   * drm_bridge_pre_enable - prepares for enabling all
>   *			   bridges in the encoder chain
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 9da8c93f7976..223253b15763 100644
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
> @@ -312,6 +328,9 @@ void drm_bridge_post_disable(struct drm_bridge *bridge);
>  void drm_bridge_mode_set(struct drm_bridge *bridge,
>  			 const struct drm_display_mode *mode,
>  			 const struct drm_display_mode *adjusted_mode);
> +bool drm_bridge_format_set(struct drm_bridge *bridge,
> +			   const u32 input_bus_format,
> +			   const u32 input_encoding);
>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>  void drm_bridge_enable(struct drm_bridge *bridge);
>  
> 


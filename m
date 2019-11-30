Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764BC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 04:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A9020715
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 04:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9vy/S7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfK3EiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 23:38:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40151 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfK3EiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 23:38:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so15430499pgd.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 20:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QOcATAytYdAUYAj61d6IpYGu6sX7w+eDXWKXj+6FQJQ=;
        b=j9vy/S7L+YPvk/Jb7NxdDWzFdsJueZLTJ3U6EgdCpIk7hNzWDsues1GqszWHtonsMh
         90b+SsPYMPNrhmrTZ5ADJkEQvzZSWVLx2iPo8Lur7LbeKSGx1IiKBEOs2ARaZe/VAZN4
         W5ioSAgI1FEMGfkGprjvVZdnVtgdg32u4nhsR9PQ3FdBlaf0wZnG9toZUwDdtLx3+vTg
         UOYOTPGUio45KoPlbZDOV9L82I2ZLtyVKfLAX1SkamZjfwzQKUTaCH5WbmP3mz5LtCD5
         RYzB6/F3IXQvN0aIkUYGMHWFMAytc03Ws7fMsTS78uWy2PRvPwlgvq+tMvLsHoaFWrrs
         Ucpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOcATAytYdAUYAj61d6IpYGu6sX7w+eDXWKXj+6FQJQ=;
        b=TLcuToIVkRyH38dbEn4WGpmL2Np//1F6VVtkbBX+Qs5aSUvdv9if69xwXXi1lbO5di
         j4dR5gMIe2W4INHWbkzbHaSNAtjVCmvke6yM40qRxhqGCI9NEOUmneyZEpDFOBJaI1M9
         yr6f2eNYiZPasTo1fc/EppKkPRvkLXhOhUp0VKMedZNWoF/I2QIFhfJ8zCFZ+tWK0QiK
         HnYt0dOcS5XzHNaQYBNJLcLcgvn99YdY2NtezpPchevcuk46XXX1GB0IWlV/gvssitfl
         Wx3hIxqBYwGHT7rpKOGN+7lSUrBybXfrt0ZeNDC3rbRFpoqjbsFeGUK34s/AETx4YLvk
         Zbgw==
X-Gm-Message-State: APjAAAV5EypEMZjL9EocTBn9y//NcMTN6ReDNHiLsrf9xhSAQAab9eBD
        uEPV4HvBzeZlivjbnWnNMvUO3g==
X-Google-Smtp-Source: APXvYqzl0nI0zkWWC3GyKCb6vZsvk9rxrHliKFgB87oUCzOLq1iKPzZZGPQRAsp0IfRBsqcqrmHOmQ==
X-Received: by 2002:a63:2949:: with SMTP id p70mr20698711pgp.191.1575088686021;
        Fri, 29 Nov 2019 20:38:06 -0800 (PST)
Received: from google.com ([2620:0:1000:2511:b34b:87b6:d099:91b0])
        by smtp.gmail.com with ESMTPSA id em16sm15839604pjb.21.2019.11.29.20.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 20:38:05 -0800 (PST)
Date:   Fri, 29 Nov 2019 20:38:00 -0800
From:   Tom Anderson <thomasanderson@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Reduce HDMI pixel encoding if max clock
 is exceeded
Message-ID: <20191130043800.GA217968@google.com>
References: <20191123052900.77205-1-thomasanderson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123052900.77205-1-thomasanderson@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized that at 4:2:2, the pixel clock isn't actually decreased to 3/4
of it's value at 4:4:4. I'll send a revised patch on Monday.

On Fri, Nov 22, 2019 at 09:29:00PM -0800, Thomas Anderson wrote:
> For high-res (8K) or HFR (4K120) displays, using uncompressed pixel
> formats like YCbCr444 would exceed the bandwidth of HDMI 2.0, so the
> "interesting" modes would be disabled, leaving only low-res or low
> framerate modes.
> 
> This change lowers the pixel encoding to 4:2:2 or 4:2:0 if the max TMDS
> clock is exceeded. Verified that 8K30 and 4K120 are now available and
> working with a Samsung Q900R over an HDMI 2.0b link from a Radeon 5700.
> 
> Signed-off-by: Thomas Anderson <thomasanderson@google.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 ++++++++++++++-----
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4139f129eafb..a507a6f04c82 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3269,13 +3269,15 @@ static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
>  	timing_out->display_color_depth--;
>  }
>  
> -static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
> -						const struct drm_display_info *info)
> +static void adjust_timing_from_display_info(
> +	struct dc_crtc_timing *timing_out,
> +	const struct drm_display_info *info,
> +	const struct drm_display_mode *mode_in)
>  {
>  	int normalized_clk;
> -	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> +	if (timing_out->display_color_depth < COLOR_DEPTH_888)
>  		return;
> -	do {
> +	while (timing_out->display_color_depth > COLOR_DEPTH_888) {
>  		normalized_clk = timing_out->pix_clk_100hz / 10;
>  		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
>  		if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
> @@ -3297,9 +3299,23 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
>  		if (normalized_clk <= info->max_tmds_clock)
>  			return;
>  		reduce_mode_colour_depth(timing_out);
> +	}
>  
> -	} while (timing_out->display_color_depth > COLOR_DEPTH_888);
> -
> +	/* The color depth is 888 and cannot be reduced any further, but the
> +	 * clock would still exceed the max tmds clock. Try reducing the pixel
> +	 * encoding next.
> +	 */
> +	if (timing_out->pixel_encoding == PIXEL_ENCODING_RGB ||
> +	    timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
> +		/* YCBCR422 is always supported. */
> +		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
> +		normalized_clk = (timing_out->pix_clk_100hz * 3) / 40;
> +		if (normalized_clk <= info->max_tmds_clock)
> +			return;
> +	}
> +	/* YCBCR420 may only be supported on specific modes. */
> +	if (drm_mode_is_420_also(info, mode_in))
> +		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
>  }
>  
>  static void fill_stream_properties_from_drm_display_mode(
> @@ -3366,7 +3382,7 @@ static void fill_stream_properties_from_drm_display_mode(
>  	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
>  	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
>  	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> -		adjust_colour_depth_from_display_info(timing_out, info);
> +		adjust_timing_from_display_info(timing_out, info, mode_in);
>  }
>  
>  static void fill_audio_info(struct audio_info *audio_info,
> -- 
> 2.24.0.432.g9d3f5f5b63-goog
> 

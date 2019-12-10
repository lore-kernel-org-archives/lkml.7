Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59561C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E58F205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijSEvrc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLJS7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:59:32 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33207 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfLJS7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:59:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so7764297pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YK8B4LOHuvTcG7coycaZkR5egcK5nfpQxxhODKfbZLg=;
        b=ijSEvrc++psuwu0BcdGofpYVt6SA6g9P/PYtHoFzviSkQeT3eZrHukDgUknkGNJ3DT
         FE1DMTDhrb6k/PAMxRXwTCvUbdUZUJqm1GIyChSLtG/OsMvn2Mot4ey1yUqHCRUzxQK5
         kCOofTJjNHf5wnh/spYEYCRjgU0UYLPNyNT2D3WrVwXdxGkTZl0a38wdx5PBlIM+Qbdl
         s+s0mBvYxcMMjJCFk8h2wbZYFT/iG3pwrk2VmAyf7q8Ylz0Ou1D2GRViNo3gwdZzy+Cs
         iBFdqWEVLJ/RccFpExCIDkPkXTWEmrZWCbEBG77cX1BxZkxDWqLq2EmkkTSAdkgW24zl
         tOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YK8B4LOHuvTcG7coycaZkR5egcK5nfpQxxhODKfbZLg=;
        b=brU+FZJIrV+h1d1kpR58MdwTKhgtoPH3Z7PnBIAX0Re3tZ85aclYXkYJxBrWKTlunx
         l6nilrmwTiR85utHbW0YFp7AOWrPug/6NQmuw50VrfwNPMIX6Rpw3ctu3zp/rFTY49Qj
         0uNSwL/EOWfw4+9Ly0s6l6uGMJV4SuYCSlLFQ6KviEgTsdoA66lJ9nZ4uRgyD9WhV9uU
         KwsTjJi3YL5ipylauYyrMOArHty4jib2hpspA56kJMyS4R+/mMtjeEpMEijrs5C2K/a/
         J8WSnR9Nh3OnhFv2IPLud99aPk81hmDZ2uquxp3+pTtyz/dYDkuLru+bPbuq+KEW1pwp
         QDCA==
X-Gm-Message-State: APjAAAVuVnl+dLWYaeAIMd2DonJAgLRsQ0fBK3yZpYYKIU9yvmMne+S2
        X0g+nHIR5N1F3nSyjU8B4Qt0+w==
X-Google-Smtp-Source: APXvYqyMSS2ZStNvPegMPXX3bCRh5CWkvXLV717t/lL3ykiatYht/ib7ahCbwyty0jkIA2eloAxHaw==
X-Received: by 2002:a17:90a:1505:: with SMTP id l5mr430627pja.73.1576004370287;
        Tue, 10 Dec 2019 10:59:30 -0800 (PST)
Received: from google.com ([2620:0:1000:2511:b34b:87b6:d099:91b0])
        by smtp.gmail.com with ESMTPSA id r6sm4262658pfh.91.2019.12.10.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:59:29 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:59:24 -0800
From:   Tom Anderson <thomasanderson@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Anderson <thomasanderson@google.com>
Subject: Re: [PATCH v2] drm/amd/display: Reduce HDMI pixel encoding if max
 clock is exceeded
Message-ID: <20191210185924.GA20941@google.com>
References: <20191202214713.41001-1-thomasanderson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202214713.41001-1-thomasanderson@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

On Mon, Dec 02, 2019 at 01:47:13PM -0800, Thomas Anderson wrote:
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
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++---------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7aac9568d3be..803e59d97411 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3356,27 +3356,21 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
>  	return color_space;
>  }
>  
> -static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
> -{
> -	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> -		return;
> -
> -	timing_out->display_color_depth--;
> -}
> -
> -static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
> -						const struct drm_display_info *info)
> +static bool adjust_colour_depth_from_display_info(
> +	struct dc_crtc_timing *timing_out,
> +	const struct drm_display_info *info)
>  {
> +	enum dc_color_depth depth = timing_out->display_color_depth;
>  	int normalized_clk;
> -	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> -		return;
>  	do {
>  		normalized_clk = timing_out->pix_clk_100hz / 10;
>  		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
>  		if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
>  			normalized_clk /= 2;
>  		/* Adjusting pix clock following on HDMI spec based on colour depth */
> -		switch (timing_out->display_color_depth) {
> +		switch (depth) {
> +		case COLOR_DEPTH_888:
> +			break;
>  		case COLOR_DEPTH_101010:
>  			normalized_clk = (normalized_clk * 30) / 24;
>  			break;
> @@ -3387,14 +3381,15 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
>  			normalized_clk = (normalized_clk * 48) / 24;
>  			break;
>  		default:
> -			return;
> +			/* The above depths are the only ones valid for HDMI. */
> +			return false;
>  		}
> -		if (normalized_clk <= info->max_tmds_clock)
> -			return;
> -		reduce_mode_colour_depth(timing_out);
> -
> -	} while (timing_out->display_color_depth > COLOR_DEPTH_888);
> -
> +		if (normalized_clk <= info->max_tmds_clock) {
> +			timing_out->display_color_depth = depth;
> +			return true;
> +		}
> +	} while (--depth > COLOR_DEPTH_666);
> +	return false;
>  }
>  
>  static void fill_stream_properties_from_drm_display_mode(
> @@ -3474,8 +3469,14 @@ static void fill_stream_properties_from_drm_display_mode(
>  
>  	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
>  	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> -	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> -		adjust_colour_depth_from_display_info(timing_out, info);
> +	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> +		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
> +		    drm_mode_is_420_also(info, mode_in) &&
> +		    timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
> +			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> +			adjust_colour_depth_from_display_info(timing_out, info);
> +		}
> +	}
>  }
>  
>  static void fill_audio_info(struct audio_info *audio_info,
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 

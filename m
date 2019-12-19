Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63DBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C1E24676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 23:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7s7EMz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfLSXdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:33:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37309 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLSXdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:33:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so3277632plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 15:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XkA3Ag1xZNcaUv5ig0ncH6ge+8P8NEi38UXcVKQ4TwA=;
        b=v7s7EMz6F475uFm82JRnKzFk78aFoLCZTTy0lM2CD7qS8AEl4BTZvbneoYwwp8M172
         vc4HjkY8cmpGvuHwr2t41pbR2jPe1QEfPuzLfKZCH2XKKgUUL+qHWWZIDQX6oaf8kB75
         kJrTkXjhOrQOJ9MGd8R6vQ9MlLYc6pRa4uIBDZIt8/PT2srbkLVoAVkQr8GyUfbUDdVK
         zIsDPGbYRQoGdDBdvkti+ZCnBVR9snqyIpTYNMktXlZ+ZgrCNlwvFQNVl+w9q7u5SCbD
         8/xDDqU58LIHgs6RVvqmhgBepPUs0vy71OoYfF3Z3kfasK7bvisd+ClVa9hOHDozn+t+
         xO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XkA3Ag1xZNcaUv5ig0ncH6ge+8P8NEi38UXcVKQ4TwA=;
        b=sZJ3qjZsUo/Ta+yFTWITCa/lHnVBIhG/5S8NU5wXcOrSDdVBL7mC1RGYmvGVY3fZ2W
         1D7L/hw1MbNS8K7VRyREUn4WeYnG4bIb2i/H7wduGmW9ES1HLKzRNn733ht+yMCItlYN
         V8AVEIDyEzFpfol6+A7nR7F2s0aVp7/kDZKtNiN5QAEyqG+E6X62UOVKECJwWiha8apI
         Q3w7+flVcaarIvtvt8OMArqR/9Tl4l5eFjAUMV1il8Cr8IZvWGwUlqCkSqXVykVNUjia
         s4XH0DLe6Nfoze2ofE2IJ674xGMKAwgYKRvUxJtTq/YoNDzmabSFcLcDQSiksXRbCRyD
         htCw==
X-Gm-Message-State: APjAAAU6C4Xgkukj8cHWBkChBIrIF5LAt7wVHsZLwuW4xqfk54LpLG1y
        e7at0r9Y48yBZzJ0mqybagCHIQ==
X-Google-Smtp-Source: APXvYqzYlqJkLdvsbUJyp3YSGgiYAdhSq6nsa2U4gRA/0IO+8qtfsLKllFDDPsKVZabbpkR4Fom7ZQ==
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr11349464plk.273.1576798389633;
        Thu, 19 Dec 2019 15:33:09 -0800 (PST)
Received: from google.com ([2620:0:1000:2511:b34b:87b6:d099:91b0])
        by smtp.gmail.com with ESMTPSA id j21sm9239081pfe.175.2019.12.19.15.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:33:08 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:33:03 -0800
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/display: Reduce HDMI pixel encoding if max
 clock is exceeded
Message-ID: <20191219233303.GA131109@google.com>
References: <20191202214713.41001-1-thomasanderson@google.com>
 <20191210185924.GA20941@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210185924.GA20941@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.  Is there any action required to get this landed?

On Tue, Dec 10, 2019 at 10:59:24AM -0800, Tom Anderson wrote:
> Friendly ping.
> 
> On Mon, Dec 02, 2019 at 01:47:13PM -0800, Thomas Anderson wrote:
> > For high-res (8K) or HFR (4K120) displays, using uncompressed pixel
> > formats like YCbCr444 would exceed the bandwidth of HDMI 2.0, so the
> > "interesting" modes would be disabled, leaving only low-res or low
> > framerate modes.
> > 
> > This change lowers the pixel encoding to 4:2:2 or 4:2:0 if the max TMDS
> > clock is exceeded. Verified that 8K30 and 4K120 are now available and
> > working with a Samsung Q900R over an HDMI 2.0b link from a Radeon 5700.
> > 
> > Signed-off-by: Thomas Anderson <thomasanderson@google.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++---------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 7aac9568d3be..803e59d97411 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -3356,27 +3356,21 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
> >  	return color_space;
> >  }
> >  
> > -static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
> > -{
> > -	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > -		return;
> > -
> > -	timing_out->display_color_depth--;
> > -}
> > -
> > -static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
> > -						const struct drm_display_info *info)
> > +static bool adjust_colour_depth_from_display_info(
> > +	struct dc_crtc_timing *timing_out,
> > +	const struct drm_display_info *info)
> >  {
> > +	enum dc_color_depth depth = timing_out->display_color_depth;
> >  	int normalized_clk;
> > -	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > -		return;
> >  	do {
> >  		normalized_clk = timing_out->pix_clk_100hz / 10;
> >  		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
> >  		if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
> >  			normalized_clk /= 2;
> >  		/* Adjusting pix clock following on HDMI spec based on colour depth */
> > -		switch (timing_out->display_color_depth) {
> > +		switch (depth) {
> > +		case COLOR_DEPTH_888:
> > +			break;
> >  		case COLOR_DEPTH_101010:
> >  			normalized_clk = (normalized_clk * 30) / 24;
> >  			break;
> > @@ -3387,14 +3381,15 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
> >  			normalized_clk = (normalized_clk * 48) / 24;
> >  			break;
> >  		default:
> > -			return;
> > +			/* The above depths are the only ones valid for HDMI. */
> > +			return false;
> >  		}
> > -		if (normalized_clk <= info->max_tmds_clock)
> > -			return;
> > -		reduce_mode_colour_depth(timing_out);
> > -
> > -	} while (timing_out->display_color_depth > COLOR_DEPTH_888);
> > -
> > +		if (normalized_clk <= info->max_tmds_clock) {
> > +			timing_out->display_color_depth = depth;
> > +			return true;
> > +		}
> > +	} while (--depth > COLOR_DEPTH_666);
> > +	return false;
> >  }
> >  
> >  static void fill_stream_properties_from_drm_display_mode(
> > @@ -3474,8 +3469,14 @@ static void fill_stream_properties_from_drm_display_mode(
> >  
> >  	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
> >  	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> > -	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> > -		adjust_colour_depth_from_display_info(timing_out, info);
> > +	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> > +		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
> > +		    drm_mode_is_420_also(info, mode_in) &&
> > +		    timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
> > +			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> > +			adjust_colour_depth_from_display_info(timing_out, info);
> > +		}
> > +	}
> >  }
> >  
> >  static void fill_audio_info(struct audio_info *audio_info,
> > -- 
> > 2.24.0.393.g34dc348eaf-goog
> > 

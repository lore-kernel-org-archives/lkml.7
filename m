Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA212C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194C92083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JvFJGBll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfFFRQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:16:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39755 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfFFRQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:16:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so1723009pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=xnaB2870GZB3eebBLaFXdIrfqP4QtLP9AtgtNluS/2w=;
        b=JvFJGBllEIiVn10M5nTs1mgkkLBPu51n9nLenLTex4m91pcKEXxMcR8HgL38rDgxpt
         /7kpJqIJXpaRYIMqyI/IJUvNaDNLcGVNfYJUuuGPPdSPKPzZzAngwCjjezS7DWKqlvjG
         xfz6nAZrcalJOVS8eO8PMqMLkVwGjHE2VrZosDZ7wDGAb8ILHFHz6Oz5JEmqJtKBGssG
         pe0DO2MFLSTWPVGrQmVJZi1gOy0zRxzO//aBA2BLR80LRx4g6pss0bcRUjIE3B7eCI5e
         Q8YqCc7E9uk25MyirLfO3B3kl6rrVlQwLHZ67vz/C+iv0QEGnUYhzz0f0K2jdwGyFpST
         qutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xnaB2870GZB3eebBLaFXdIrfqP4QtLP9AtgtNluS/2w=;
        b=b5Ovp0ukmdWcRstXNtynKiTazdvPsA42/sZuUpxtp+dI2Xr4mjHtvGiTTIgLxncJu9
         EbmfoSzDH0BDKGbmbFFO19KCgW7UtiFpip2b7MCrfA6a1QmULSeTW/ejn15mJ8q3AxFI
         ZrjDFlU/dj52uQBaHYHBBKMkVeteAeBHs2UMc2NwfEsTXjtlPkkoEl69BdxfZ/UBOcr7
         mWghjmooB2pCQ3QjW4V1TDdgRqToXhjrXPpNezbIA7bVyhVgR9cZ+uafpEK2MmlvbVxk
         4owH/ZdMNoYJwa1/oCA0C/qAm6L5qP5eSCAeqh9acNDX/6VZ49/mPQbF9RjkUzjs3UP4
         FI5g==
X-Gm-Message-State: APjAAAVh+Q59zuN895rfTGjWqgxYABaNKued8LR4J9zSC56blkwTL69y
        Z1RuLCPMBUoNYM7DFM+cHVV5LQ==
X-Google-Smtp-Source: APXvYqyxt+I5fwIWa+rOJ3CMdaB+VSpYPzAApL3FPlNe9rZ6tKjDn2zuvoTOimphMtLb3sU0PFMQXQ==
X-Received: by 2002:aa7:82cd:: with SMTP id f13mr55621104pfn.203.1559841382186;
        Thu, 06 Jun 2019 10:16:22 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id o66sm2377363pje.8.2019.06.06.10.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 10:16:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     jernej.skrabec@siol.net, Neil Armstrong <narmstrong@baylibre.com>,
        maxime.ripard@bootlin.com, jonas@kwiboo.se,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 5/5] drm/meson: Output in YUV444 if sink supports it
In-Reply-To: <20190520133753.23871-6-narmstrong@baylibre.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com> <20190520133753.23871-6-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 10:16:20 -0700
Message-ID: <7hblzaeisb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> With the YUV420 handling, we can dynamically setup the HDMI output
> pixel format depending on the mode and connector info.
> So now, we can output in YUV444, which is the native video pipeline
> format, directly to the HDMI Sink if it's supported without
> necessarily involving the HDMI Controller CSC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 5d67e2beba58..8bf9db7f39a4 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -723,12 +723,23 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
>  	struct drm_display_mode *mode = &crtc_state->mode;
>  	bool is_hdmi2_sink =
>  		conn_state->connector->display_info.hdmi.scdc.supported;
> +	bool specify_out_format = false;
> +	u32 out_format;
>  
>  	if (drm_mode_is_420_only(info, mode) ||
>  	    (!is_hdmi2_sink && drm_mode_is_420_also(info, mode)))
>  		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
> -	else
> +	else {

nit: if the else has {} you should add to the 'if' (even if the if side
is a single statement): c.f. end of this section of CodingStyle:
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

>  		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444) {
> +			out_format = MEDIA_BUS_FMT_YUV8_1X24;
> +			specify_out_format = true;
> +		}
> +	}
> +
> +	/* Set a connector bus format if required */
> +	drm_display_info_set_bus_formats(info, &out_format,
> +					 (specify_out_format ? 1 : 0));
>  

Otherwise,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin


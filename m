Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7C9C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E471220652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RQX9Zmd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfFFRLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:11:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40757 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfFFRL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:11:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so1709749pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RCCjbZWfEuhDbIeAIpWgax0k0rY3XOyq9KErPV874w4=;
        b=RQX9Zmd7Ya0CO1A5hU/4D9dIT22w59V6XzJvApJdP+FGeMxmEJEUajaDdYMScR+7FO
         6LP+oX4K23otZ8pw7ZaTgHfdUR/5SJHAozY5T+vMbVjGkMDHyPA2AnInUTrZZUf2ZB6H
         cupN8da+xYoz7g+x6dd59J0XIsHg+n3XBqTaR4V0kdiiCWY1OXga6TBK3BXtYEuhU8Pv
         O9GZIp4WYP5U4nde+l06o1BLj3ygXyrVUai2+/y5FQajV4RbYQsu59UNEujIuLRUy5tB
         ss+g1KXATzztltf/6Iv8K3PUVFnDFu9bf/as33ism4ujknnqKSLf0DWR8qe8nPPMVx6C
         0Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RCCjbZWfEuhDbIeAIpWgax0k0rY3XOyq9KErPV874w4=;
        b=FYAIUgNooWC9lc/E3pVURJKyzz+pjjnK97unrqssHs+Q82qiXYWGvpPPTsY6Yl1TBs
         O6+uD7+bs0w93Fj5UBgOLsR34xO+kSRcAEZGr+MQ/McMqUg5r5MEQgFNhgqwt7KpCWle
         f9lTEcPUDWvrFCPirugqtCHiPDH7gozpXbZwf7ujNUo1XpE+LFV2yy1aUuqUrPwwlK9A
         gZ1bxtQxL+5kwZv4NcQjbD8E2m0/Tri1sSnB/V0VHAwGr+YotwA9dEyuK9sqdVHhk8Z3
         mtlFw/fsAfGqybocGxqsd163WukPNWnduUVav8+eVtXXN/9ZH7J3YKXSHEx7PZFUlTBg
         ivww==
X-Gm-Message-State: APjAAAXOnsPFx5ePwheB9JmfG0DuQGVNINvwE9DlvZASEPCLtRMPUtlI
        aPtGMZ5lhlmKYHnpOJXIS0SSfQ==
X-Google-Smtp-Source: APXvYqzDEcNItKsI90UQVxfUSnXTWlpL13u+ek16QryxLZB/K5zFkxlS5RhK+PwwS6ep3GViFH4ZCA==
X-Received: by 2002:a63:f10e:: with SMTP id f14mr4221110pgi.226.1559841088435;
        Thu, 06 Jun 2019 10:11:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 16sm2415912pfo.65.2019.06.06.10.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 10:11:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     jernej.skrabec@siol.net, Neil Armstrong <narmstrong@baylibre.com>,
        maxime.ripard@bootlin.com, jonas@kwiboo.se,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 4/5] drm/meson: Add YUV420 output support
In-Reply-To: <20190520133753.23871-5-narmstrong@baylibre.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com> <20190520133753.23871-5-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 10:11:26 -0700
Message-ID: <7hmuiuej0h.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch adds support for the YUV420 output from the Amlogic Meson SoCs
> Video Processing Unit to the HDMI Controller.
>
> The YUV420 is obtained by generating a YUV444 pixel stream like
> the classic HDMI display modes, but then the Video Encoder output
> can be configured to down-sample the YUV444 pixel stream to a YUV420
> stream.
> In addition if pixel stream down-sampling, the Y Cb Cr components must
> also be mapped differently to align with the HDMI2.0 specifications.
>
> This mode needs a different clock generation scheme since the TMDS PHY
> clock must match the 10x ration with the YUV420 pixel clock, but

s/ration/ratio/

> the video encoder must run at 2x the pixel clock.
>
> This patch adds the TMDS PHY clock value in all the video clock setup
> in order to better support these specific uses cases and switch
> to the Common Clock framework for clocks handling in the future.
>
> When 420 is needed, it calls drm_bridge_format_set() for notify the
> bridge the input format has changed to YUV420.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

with a couple very minor nits to cleanup below...

> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 100 +++++++++++++++++++-----
>  drivers/gpu/drm/meson/meson_vclk.c      |  93 ++++++++++++++++------
>  drivers/gpu/drm/meson/meson_vclk.h      |   7 +-
>  drivers/gpu/drm/meson/meson_venc.c      |   6 +-
>  drivers/gpu/drm/meson/meson_venc.h      |  11 +++
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |   3 +-
>  6 files changed, 174 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 779da21143b9..5d67e2beba58 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -159,6 +159,7 @@ struct meson_dw_hdmi {
>  	struct regulator *hdmi_supply;
>  	u32 irq_stat;
>  	struct dw_hdmi *hdmi;
> +	unsigned long input_bus_format;
>  };
>  #define encoder_to_meson_dw_hdmi(x) \
>  	container_of(x, struct meson_dw_hdmi, encoder)
> @@ -308,6 +309,10 @@ static void meson_hdmi_phy_setup_mode(struct meson_dw_hdmi *dw_hdmi,
>  	struct meson_drm *priv = dw_hdmi->priv;
>  	unsigned int pixel_clock = mode->clock;
>  
> +	/* For 420, pixel clock is half unlike venc clock */
> +	if (dw_hdmi->input_bus_format == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
> +		pixel_clock /= 2;
> +
>  	if (dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
>  	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi")) {
>  		if (pixel_clock >= 371250) {
> @@ -383,25 +388,36 @@ static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
>  {
>  	struct meson_drm *priv = dw_hdmi->priv;
>  	int vic = drm_match_cea_mode(mode);
> +	unsigned int phy_freq;
>  	unsigned int vclk_freq;
>  	unsigned int venc_freq;
>  	unsigned int hdmi_freq;
>  
>  	vclk_freq = mode->clock;
>  
> +	/* For 420, pixel clock is half unlike venc clock */

minor grammar nit: put a comma after "half" (here and several other
places in the patch)

[...]

> @@ -722,17 +773,29 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
>  	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
>  	struct meson_drm *priv = dw_hdmi->priv;
>  	int vic = drm_match_cea_mode(mode);
> +	unsigned int ycrcb_map = MESON_VENC_MAP_CB_Y_CR;
> +	bool yuv420_mode = false;
>  
>  	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
>  
> +	if (dw_hdmi->input_bus_format == MEDIA_BUS_FMT_UYYVYY8_0_5X24) {
> +		ycrcb_map = MESON_VENC_MAP_CR_Y_CB;
> +		yuv420_mode = true;
> +	}
> +
>  	/* VENC + VENC-DVI Mode setup */
> -	meson_venc_hdmi_mode_set(priv, vic, mode);
> +	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, yuv420_mode, mode);
>  
>  	/* VCLK Set clock */
>  	dw_hdmi_set_vclk(dw_hdmi, mode);
>  
> -	/* Setup YUV444 to HDMI-TX, no 10bit diphering */
> -	writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
> +	if (dw_hdmi->input_bus_format == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
> +		/* Setup YUV420 to HDMI-TX, no 10bit diphering */
> +		writel_relaxed(2 | (2 << 2),

nit: #define'd bitfields would be better, IIUC, I see these named as
"use average" and "Convert to 420" in the datasheet.

[...]

> @@ -1508,8 +1510,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
>  	writel_relaxed((use_enci ? 1 : 2) |
>  		       (mode->flags & DRM_MODE_FLAG_PHSYNC ? 1 << 2 : 0) |
>  		       (mode->flags & DRM_MODE_FLAG_PVSYNC ? 1 << 3 : 0) |
> -		       4 << 5 |
> -		       (venc_repeat ? 1 << 8 : 0) |
> +		       (ycrcb_map << 5) |
> +		       (venc_repeat || yuv420_mode ? 1 << 8 : 0) |

Lots of magic constants here, but I guess there's no new ones, so it's
just a(nother) reminder for a future readability cleanup.

>  		       (hdmi_repeat ? 1 << 12 : 0),
>  		       priv->io_base + _REG(VPU_HDMI_SETTING));
>  

Kevin

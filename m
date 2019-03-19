Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3946C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6874F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e6iJkLuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfCSKfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:35:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52525 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfCSKfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:35:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so2091301wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VU5Iewt29LxU+E6Gz65Vgx/F8lFV8UAkxK8E9VVAukQ=;
        b=e6iJkLuU0a59xu2ouKNTzTVBUrcI+MWAq0CkN/rB2rxoz57qoJjRBg+Y84SN6nuDKB
         x5p45oivBVd2O36xVOjH0H9UHKNgeuTE8lF0h696ZQhlDKiaUCQrAwOhQd6WRpQnUIrt
         HN/iCqLo3CiLnNsJkM3bbknYjZ8fswMDWoOIr8ZrUqeESjX5dGefCABaP73vZubUxAxk
         Mvd/iBpmxSP1Q8STxocyN3uVxXb5zyHChafZOYB0k87IVegzRYyK8i9TstQCDpgRscAI
         OcOFtOGs1UqpJLPuziltrqGYY8/9fmIrQ1QIZtZ7G6WQgl/JfVavfXiBGvzPKvWQ/uzp
         fcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VU5Iewt29LxU+E6Gz65Vgx/F8lFV8UAkxK8E9VVAukQ=;
        b=YcOtZWkAeCGAeaGmTKnP8pxnu1EUIjR0cSQX98FDbYBap16Hyf5+SXfVgJwh0H6d73
         y4MxE+ae0Ooch214vfn3MgdJzSER0nRjLzxoVUqobSKqqc/8XeeU2OOhcXt19WDMZf7C
         ZZlLzLNyVAukt6zKBrCDg2KOwegyFwH6U1Oy54GMLQ5vdEcvXnalYLsFaZL9LPsPygFl
         4HqHOrQCmCb9wiORFqhLoWJ6uhiyfOwtDSfNmsEogy3efECj/C55a6YynBta+QH8ARR8
         ybhgt1+F/MDUVrlyUn8V9dD/HrY6S7gM+4lCHOHy/rrbHlkw7N+QI9AhliM7CN/W5kyN
         rz4A==
X-Gm-Message-State: APjAAAWvDsxJtv+IbOGNTTS/TtWmSfCgf4u4HDr5QCVFDggIgciP1F4X
        g2lCBUymq6WHEApRGd2CQ+lZBytZoTi1BUNmj9Hg0A==
X-Google-Smtp-Source: APXvYqxmPoouj1fCb7SQdjrVtimD5Dqmz0LEKARejptDcu3fmvi+USXZvCN1U6Pafj3qo7PFciTAV3AnBexJopJGdZg=
X-Received: by 2002:a1c:2407:: with SMTP id k7mr2860702wmk.137.1552991730522;
 Tue, 19 Mar 2019 03:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com> <1549022873-40549-8-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1549022873-40549-8-git-send-email-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Tue, 19 Mar 2019 11:35:19 +0100
Message-ID: <CAMO6nayWKDfcsQtrPK7-Pki75F5tAYO-0B=D=TAbGvQmt=gwrw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] drm/meson: Add YUV420 output support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Feb 1, 2019 at 1:08 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
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
> the video encoder must run at 2x the pixel clock.
>
> This patch adds the TMDS PHY clock value in all the video clock setup
> in order to better support these specific uses cases and switch
> to the Common Clock framework for clocks handling in the future.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 110 ++++++++++++++++++++++++++------
>  drivers/gpu/drm/meson/meson_vclk.c      |  93 ++++++++++++++++++++-------
>  drivers/gpu/drm/meson/meson_vclk.h      |   7 +-
>  drivers/gpu/drm/meson/meson_venc.c      |   6 +-
>  drivers/gpu/drm/meson/meson_venc.h      |  11 ++++
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |   3 +-
>  6 files changed, 184 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index e28814f..540971a 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -141,6 +141,8 @@ struct meson_dw_hdmi {
>         struct regulator *hdmi_supply;
>         u32 irq_stat;
>         struct dw_hdmi *hdmi;
> +       unsigned long input_bus_format;
> +       unsigned long output_bus_format;
>  };
>  #define encoder_to_meson_dw_hdmi(x) \
>         container_of(x, struct meson_dw_hdmi, encoder)
> @@ -323,25 +325,36 @@ static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
>  {
>         struct meson_drm *priv = dw_hdmi->priv;
>         int vic = drm_match_cea_mode(mode);
> +       unsigned int phy_freq;
>         unsigned int vclk_freq;
>         unsigned int venc_freq;
>         unsigned int hdmi_freq;
>
>         vclk_freq = mode->clock;
>
> +       /* For 420, pixel clock is half unlike venc clock */
> +       if (dw_hdmi->input_bus_format == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
> +               vclk_freq /= 2;
> +
> +       /* TMDS clock is pixel_clock * 10 */
> +       phy_freq = vclk_freq * 10;
> +
>         if (!vic) {
> -               meson_vclk_setup(priv, MESON_VCLK_TARGET_DMT, vclk_freq,
> -                                vclk_freq, vclk_freq, false);
> +               meson_vclk_setup(priv, MESON_VCLK_TARGET_DMT, phy_freq,
> +                                vclk_freq, vclk_freq, vclk_freq, false);
>                 return;
>         }
>
> +       /* 480i/576i needs global pixel doubling */
>         if (mode->flags & DRM_MODE_FLAG_DBLCLK)
>                 vclk_freq *= 2;
>
>         venc_freq = vclk_freq;
>         hdmi_freq = vclk_freq;
>
> -       if (meson_venc_hdmi_venc_repeat(vic))
> +       /* VENC double pixels for 1080i, 720p and YUV420 modes */
> +       if (meson_venc_hdmi_venc_repeat(vic) ||
> +           dw_hdmi->input_bus_format == MEDIA_BUS_FMT_UYYVYY8_0_5X24)
>                 venc_freq *= 2;
>
>         vclk_freq = max(venc_freq, hdmi_freq);
> @@ -349,11 +362,11 @@ static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
>         if (mode->flags & DRM_MODE_FLAG_DBLCLK)
>                 venc_freq /= 2;
>
> -       DRM_DEBUG_DRIVER("vclk:%d venc=%d hdmi=%d enci=%d\n",
> -               vclk_freq, venc_freq, hdmi_freq,
> +       DRM_DEBUG_DRIVER("vclk:%d phy=%d venc=%d hdmi=%d enci=%d\n",
> +               phy_freq, vclk_freq, venc_freq, hdmi_freq,
>                 priv->venc.hdmi_use_enci);
>
> -       meson_vclk_setup(priv, MESON_VCLK_TARGET_HDMI, vclk_freq,
> +       meson_vclk_setup(priv, MESON_VCLK_TARGET_HDMI, phy_freq, vclk_freq,
>                          venc_freq, hdmi_freq, priv->venc.hdmi_use_enci);
>  }
>
> @@ -386,8 +399,9 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
>         /* Enable normal output to PHY */
>         dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
>
> -       /* TMDS pattern setup (TOFIX Handle the YUV420 case) */
> -       if (mode->clock > 340000) {
> +       /* TMDS pattern setup */
> +       if (mode->clock > 340000 &&
> +           dw_hdmi->input_bus_format == MEDIA_BUS_FMT_YUV8_1X24) {
>                 dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0);
>                 dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
>                                   0x03ff03ff);
> @@ -560,6 +574,8 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>                    const struct drm_display_mode *mode)
>  {
>         struct meson_drm *priv = connector->dev->dev_private;
> +       bool is_hdmi2_sink = connector->display_info.hdmi.scdc.supported;
> +       unsigned int phy_freq;
>         unsigned int vclk_freq;
>         unsigned int venc_freq;
>         unsigned int hdmi_freq;
> @@ -568,8 +584,10 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>
>         DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
>
> -       /* If sink max TMDS clock, we reject the mode */
> -       if (mode->clock > connector->display_info.max_tmds_clock)
> +       /* If sink does not support 540MHz, reject the non-420 HDMI2 modes */
> +       if (mode->clock > connector->display_info.max_tmds_clock &&
> +           !drm_mode_is_420_only(&connector->display_info, mode) &&
> +           !drm_mode_is_420_also(&connector->display_info, mode))
>                 return MODE_BAD;
>

This part makes all the modes identified as BAD on my TV, on G12A and
GXL, which in turn breaks HDMI output (no signal detected).

Here is the dmesg with drm debug: https://pastebin.com/t3XESC2w

Cheers,
Maxime

|snip]

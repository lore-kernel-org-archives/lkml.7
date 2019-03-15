Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE64C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD54218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552664718;
	bh=Bvuob3aBdY3fJSwQ9N7TrCmMqBOE9Jo7y/wVG2WYZ5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NwG45+Ymglk1yz1ttt2AWTpQJis7bLHkjlneXNLIl7gHDsVh251pTyWDZ5bI5U+ho
	 jH6QX5koFklzd4XGwUDVYeyGYM/ZbbV6/J+d7EucFHR/19QzONFRZDT3+DogMx3PrN
	 OiAwJ1Z4sRa3T+G07yznpPGf/CIOp1dKwhm9GIRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfCOPpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfCOPpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:45:17 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CB0218C3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552664715;
        bh=Bvuob3aBdY3fJSwQ9N7TrCmMqBOE9Jo7y/wVG2WYZ5Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zdbDsxmXCqXVRrPnVsJnhAH3vVcr3CoSOk/r1mUjFeCU785NzqXD62aNMgr41AQi0
         6nfbohXoo4IrcCW9xb0psdE8NTeY6Qe9tKRBoD1Ap1ekrCegwbshMHQ4nAm8yVKdw9
         WQV1bGPEddTonprgHvlOjQGt7c1M/WTxsJMgUpSE=
Received: by mail-qk1-f169.google.com with SMTP id c189so5770967qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:45:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVLo6AQl3ldMjZaFqzGgVrRMnZmsi/DD5lFWgC+NcczNOas91oT
        HM5miCTkpL6wN7nK9B56VvPbXO1jr2Iu5mpXgg==
X-Google-Smtp-Source: APXvYqwrlOTUWoFVXlcXfVIB4JA4jgMrwfdOxySg9vTNR3xP7KKIOldumKwT/x2Ced1rB/YzNIjlM/bO1AfoCy2aXYY=
X-Received: by 2002:a37:d285:: with SMTP id f127mr3346624qkj.147.1552664714936;
 Fri, 15 Mar 2019 08:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190315095414.28520-1-narmstrong@baylibre.com>
In-Reply-To: <20190315095414.28520-1-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Mar 2019 10:45:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ_+=h_Xpdm2RJd0mtHS1YxtxDwNxY19oAe4-+JNd8A7A@mail.gmail.com>
Message-ID: <CAL_JsqJ_+=h_Xpdm2RJd0mtHS1YxtxDwNxY19oAe4-+JNd8A7A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi: disable SCDC configuration for
 invalid setups
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-amlogic@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 4:54 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch is an attempt to limit HDMI 2.0 SCDC setup when :
> - the SoC embeds an HDMI 1.4 only controller
> - the EDID supports SCDC but not scrambling
> - the EDID supports SCDC scrambling but not for low TMDS bit rates,
>   while only supporting low TMDS bit rates
>
> This to avoid communicating with the SCDC DDC slave uncessary, and
> setting the DW-HDMI TMDS Scrambler setup when not supported by the
> underlying hardware.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>
> Rob,
>
> this patch should also solve your issue with your 11' display, could you
> test it ?

That works for me.

Tested-by: Rob Herring <robh@kernel.org>

Too answer your question on the other thread, there's not really any
model name for the panel I have. Probably what's in the EDID is the
best thing to go on.

Here's the panel on Amazon:

https://www.amazon.com/gp/product/B07GDDG3WJ/ref=ppx_yo_dt_b_asin_title_o00_s01?ie=UTF8&psc=1

> If this works, I will focus on the underlying issue where the RK3399 SoC
> freezes in your setup.
>
> Thanks,
> Neil
>
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 34 ++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a63e5f0dae56..db761329a1e3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1037,6 +1037,31 @@ void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_write);
>
> +/* Filter out invalid setups to avoid configuring SCDC and scrambling */
> +static bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi)
> +{
> +       struct drm_display_info *display = &hdmi->connector.display_info;
> +
> +       /* Completely disable SCDC support for older controllers */
> +       if (hdmi->version < 0x200a)
> +               return false;
> +
> +       /* Disable if SCDC is not supported, or if an HF-VSDB block is absent */
> +       if (!display->hdmi.scdc.supported ||
> +           !display->hdmi.scdc.scrambling.supported)
> +               return false;
> +
> +       /*
> +        * Disable if display only support low TMDS rates and scrambling
> +        * for low rates is not supported either
> +        */
> +       if (!display->hdmi.scdc.scrambling.low_rates &&
> +           display->max_tmds_clock <= 340000)
> +               return false;
> +
> +       return true;
> +}
> +
>  /*
>   * HDMI2.0 Specifies the following procedure for High TMDS Bit Rates:
>   * - The Source shall suspend transmission of the TMDS clock and data
> @@ -1055,7 +1080,7 @@ void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi)
>         unsigned long mtmdsclock = hdmi->hdmi_data.video_mode.mtmdsclock;
>
>         /* Control for TMDS Bit Period/TMDS Clock-Period Ratio */
> -       if (hdmi->connector.display_info.hdmi.scdc.supported) {
> +       if (dw_hdmi_support_scdc(hdmi)) {
>                 if (mtmdsclock > HDMI14_MAX_TMDSCLK)
>                         drm_scdc_set_high_tmds_clock_ratio(hdmi->ddc, 1);
>                 else
> @@ -1579,8 +1604,9 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>
>         /* Set up HDMI_FC_INVIDCONF */
>         inv_val = (hdmi->hdmi_data.hdcp_enable ||
> -                  vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> -                  hdmi_info->scdc.scrambling.low_rates ?
> +                  (dw_hdmi_support_scdc(hdmi) &&
> +                   (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
> +                    hdmi_info->scdc.scrambling.low_rates)) ?
>                 HDMI_FC_INVIDCONF_HDCP_KEEPOUT_ACTIVE :
>                 HDMI_FC_INVIDCONF_HDCP_KEEPOUT_INACTIVE);
>
> @@ -1646,7 +1672,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>         }
>
>         /* Scrambling Control */
> -       if (hdmi_info->scdc.supported) {
> +       if (dw_hdmi_support_scdc(hdmi)) {
>                 if (vmode->mtmdsclock > HDMI14_MAX_TMDSCLK ||
>                     hdmi_info->scdc.scrambling.low_rates) {
>                         /*
> --
> 2.20.1
>

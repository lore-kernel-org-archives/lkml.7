Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2BBC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E71721E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HaUYgNK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKLSWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:22:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42490 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKLSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:22:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id i185so15700844oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zuYDebMJ/okDBHwgQg9Ko+/yuHAItkCB5r+xtn/gVU=;
        b=HaUYgNK5z9hM0u3S5tvMsLOyHp+WxD02EoIo6ZwYeUW263957WAxFCCsBoFlM9UhzK
         +buTc7LtUro3bpc0TqG0u6Z6VeA/LlU1zEzpQukJQXqBNlaxMssvSwsGZW1czxmeFtIY
         S0A/fo2QfFxG79cDQoAviXaOQt8kwPVegBvWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zuYDebMJ/okDBHwgQg9Ko+/yuHAItkCB5r+xtn/gVU=;
        b=kiiXnTL0Ch4DMXMfc4PXzmBn+ixNPSIRle4Ltg+l9ZN1Pbhi3XYiu3YK4VDY9y+TKd
         BJignIY4zSaB5vUR6JSFvAxoXOk91dzbdHiGpcjzexepgJoZO8hQrPS/M4T22We8xETP
         KFtVMuDyz3kMMWafYhSFoQsDtuUaDvt06OhSVQx6lhs1SdcC+id2rutr3cJ5UDKh4Umx
         ARyguloaiUGJ09bN8d3Fy5i3EPLymyQXEnUkfLcqZFlY6ZzGr1XjGh6ZAmkddkdalejS
         VNbtRo0mPeWIQPilaZtlIGy3czJnb2nkIulHG4+8VC7eY2LMsuFn+KWsjdyYuK04IFBf
         61iA==
X-Gm-Message-State: APjAAAUmXaJpFb//kgdi3piTGY2dlK6zUlewQ+7GsJV5BV9VH1U+iyhR
        m1Qp0d6X9Wer6MW4U/g5k9Lh+mxMsKN0ngz7+WsD1Q==
X-Google-Smtp-Source: APXvYqxWyFwnVlRZzJ+e7TO6RyGTp8L2UIQfJV/REpyHFM3+xax+tNjNNAtMmM4kjxFbc20wLGXUy8mwcfSl9sfs8Gs=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr292992oih.128.1573582935361;
 Tue, 12 Nov 2019 10:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20191112175940.GA13539@lst.de>
In-Reply-To: <20191112175940.GA13539@lst.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 12 Nov 2019 19:22:01 +0100
Message-ID: <CAKMK7uGN4=b-aaymXhs8MaS6GeShy8KMuTYv2O2L0uZBatQJtA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: fix anx6345 compilation for v5.5
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 6:59 PM Torsten Duwe <duwe@lst.de> wrote:
>
>
> The anx6345 driver originally was copied from anx78xx.c, which has meanwhile
> seen a few changes. In particular, the removal of drm_dp_link helpers and the
> discontinuation to include drm_bridge.h from drm_crtc.h breaks compilation
> in linux-5.5. Apply equivalents of these changes to anx6345.c.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Wait ... Maxime pushed this and it never compiled? What's going on here?
-Daniel

>
> ---
>
> The commits in question are ff1e8fb68ea06 and ee68c743f8d07, but I guess the
> next rebase will change these. next-20191112 plus the anx6345-v5a series plus
> this patch compile cleanly on arm64.
>
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -19,6 +19,7 @@
>  #include <linux/types.h>
>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_dp_helper.h>
> @@ -49,7 +50,6 @@ struct anx6345 {
>         struct i2c_client *client;
>         struct edid *edid;
>         struct drm_connector connector;
> -       struct drm_dp_link link;
>         struct drm_panel *panel;
>         struct regulator *dvdd12;
>         struct regulator *dvdd25;
> @@ -96,7 +96,7 @@ static ssize_t anx6345_aux_transfer(stru
>  static int anx6345_dp_link_training(struct anx6345 *anx6345)
>  {
>         unsigned int value;
> -       u8 dp_bw;
> +       u8 dp_bw, dpcd[2];
>         int err;
>
>         err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM],
> @@ -144,18 +143,34 @@ static int anx6345_dp_link_training(stru
>         if (err)
>                 return err;
>
> -       /* Check link capabilities */
> -       err = drm_dp_link_probe(&anx6345->aux, &anx6345->link);
> -       if (err < 0) {
> -               DRM_ERROR("Failed to probe link capabilities: %d\n", err);
> -               return err;
> -       }
> +       /*
> +        * Power up the sink (DP_SET_POWER register is only available on DPCD
> +        * v1.1 and later).
> +        */
> +       if (anx6345->dpcd[DP_DPCD_REV] >= 0x11) {
> +               err = drm_dp_dpcd_readb(&anx6345->aux, DP_SET_POWER, &dpcd[0]);
> +               if (err < 0) {
> +                       DRM_ERROR("Failed to read DP_SET_POWER register: %d\n",
> +                                 err);
> +                       return err;
> +               }
> +
> +               dpcd[0] &= ~DP_SET_POWER_MASK;
> +               dpcd[0] |= DP_SET_POWER_D0;
> +
> +               err = drm_dp_dpcd_writeb(&anx6345->aux, DP_SET_POWER, dpcd[0]);
> +               if (err < 0) {
> +                       DRM_ERROR("Failed to power up DisplayPort link: %d\n",
> +                                 err);
> +                       return err;
> +               }
>
> -       /* Power up the sink */
> -       err = drm_dp_link_power_up(&anx6345->aux, &anx6345->link);
> -       if (err < 0) {
> -               DRM_ERROR("Failed to power up DisplayPort link: %d\n", err);
> -               return err;
> +               /*
> +                * According to the DP 1.1 specification, a "Sink Device must
> +                * exit the power saving state within 1 ms" (Section 2.5.3.1,
> +                * Table 5-52, "Sink Control Field" (register 0x600).
> +                */
> +               usleep_range(1000, 2000);
>         }
>
>         /* Possibly enable downspread on the sink */
> @@ -194,20 +209,28 @@ static int anx6345_dp_link_training(stru
>         if (err)
>                 return err;
>
> -       value = drm_dp_link_rate_to_bw_code(anx6345->link.rate);
> +       dpcd[0] = drm_dp_max_link_rate(anx6345->dpcd);
> +       dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
>         err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> -                          SP_DP_MAIN_LINK_BW_SET_REG, value);
> +                          SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
>         if (err)
>                 return err;
>
> +       dpcd[1] = drm_dp_max_lane_count(anx6345->dpcd);
> +
>         err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> -                          SP_DP_LANE_COUNT_SET_REG, anx6345->link.num_lanes);
> +                          SP_DP_LANE_COUNT_SET_REG, dpcd[1]);
>         if (err)
>                 return err;
>
> -       err = drm_dp_link_configure(&anx6345->aux, &anx6345->link);
> +       if (drm_dp_enhanced_frame_cap(anx6345->dpcd))
> +               dpcd[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
> +
> +       err = drm_dp_dpcd_write(&anx6345->aux, DP_LINK_BW_SET, dpcd,
> +                               sizeof(dpcd));
> +
>         if (err < 0) {
> -               DRM_ERROR("Failed to configure DisplayPort link: %d\n", err);
> +               DRM_ERROR("Failed to configure link: %d\n", err);
>                 return err;
>         }
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

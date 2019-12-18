Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7951C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CFF206D3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mTE1+RmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfLRAv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:51:57 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38730 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfLRAvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:51:54 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so188131ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FqIFbxNZ4ErowQaQntfHCdnij1EjI9liJnlLkiqWQc=;
        b=mTE1+RmVS47pn7wwx1YUwxOkfF6sMrc/6gDreEAiPH52c208VuOmECL0FxLsJiOeSj
         xd6GbfHO5uLaojmq7ftwHPw2eJ7dBFFX2kd4qTD4vF6V9bgGaznbDPFQJ6EcBm3DRuBu
         Sf9wkS0+HVSXl95nXlUBbglpe3Om87S4go9Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FqIFbxNZ4ErowQaQntfHCdnij1EjI9liJnlLkiqWQc=;
        b=nMbkBhBvSI3dPhhW+V07rBVtcHYE+K2jzjwrN07W1B8vJYbl3+lHElKm13dCNsVgz9
         AddKt87s7F5Nua+0oJNK8jmJPPoLqDGyMRZSjGGk073fcQB/GMOycgJ19J+Y9aDTPvVs
         Xn3GcAqB+mgkNs7OGFW54HFVEm98n5pkQf34JoFtsKGtYlLejOn3B25QXlE7Tacl4lln
         qa4tfpmRnfSXZ66DgN6HXJ94CAuPPHU9wuYoEdmsQFT+cuqzHdTEXyRXEnwmnCz7XLXQ
         nvc9P/1t2EQgwuDEVGhxRzzmqgDbRIw+WVHsMkVryNLI5pCuzzV3hoJD8fft+pyz/eNQ
         /yMA==
X-Gm-Message-State: APjAAAVkawcrIPDrwGts4ngfJCiDOrOnsLlrsG2QMwFC1ghBfgXuFI0R
        Bf8lAoHCkDnUBFPu9gwUrdBTLqc4RcY=
X-Google-Smtp-Source: APXvYqzRCPfm6J2ml81UwG+/SVU7NwfZnu0W0lLG1wflOtO9ZuFJ8HRMQcW0GzLiyOyjgHDu5IZd+g==
X-Received: by 2002:a92:9a56:: with SMTP id t83mr243868ili.200.1576630313190;
        Tue, 17 Dec 2019 16:51:53 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id e85sm122441ilk.78.2019.12.17.16.51.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 16:51:52 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id v3so155244ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:51:52 -0800 (PST)
X-Received: by 2002:a02:ba93:: with SMTP id g19mr919432jao.90.1576630311502;
 Tue, 17 Dec 2019 16:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20191022190120.25772-1-jeffrey.l.hugo@gmail.com>
In-Reply-To: <20191022190120.25772-1-jeffrey.l.hugo@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Dec 2019 16:51:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V7HvXPkdjq_WeX+gN3s_Lc2zvX2rapcXNNBeKq2W_rtQ@mail.gmail.com>
Message-ID: <CAD=FV=V7HvXPkdjq_WeX+gN3s_Lc2zvX2rapcXNNBeKq2W_rtQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: Decouple DP output lanes
 from DSI input lanes
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 22, 2019 at 12:01 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> Based on work by Bjorn Andersson <bjorn.andersson@linaro.org>
>
> The bridge can be configured to use 1, 2, or 4 DP lanes.  This
> configuration is independent of the input DSI lanes.  Right now, the
> driver assumes that there is 1:1 mapping of input lanes to output lanes
> which is not correct and does not work for manu devices such as the
> Lenovo Miix 630 and Lenovo Yoga C630 laptops.
>
> The bridge can also be configured to use one of a number of data rates on
> the DP lanes.  Currently any of the supported rates is considered valid,
> however the configured rate must also be supported by the connected panel,
> and not all rates are supported or even valid for any particular panel.
>
> Luckily, we can determine what we need at runtime by reading the DPCD from
> the attached panel.  DPCD will tell us the maximum number of supported
> lanes, and the supported data rates.
>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>
> Bjorn, I think this should address the issue you pointed out concerning
> the data rate glitch I missed in your origional work.  Would you kindly
> give this a test and let me know if it appears to address all of the
> issues you were working around?
>
> v2:
> -Use DPCD instead of DT to address the issue of some panels not
> supporting all the rates
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 97 ++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 3 deletions(-)

Overall I'm suggesting moving over to my series and I've taken the
best stuff from your patch and put it atop my series.  Please yell if
you disagree.  You can find the cover letter for my v2 at:

https://lore.kernel.org/r/20191218004741.102067-1-dianders@chromium.org

A few misc comments below in any case.


> @@ -444,10 +447,91 @@ static void ti_sn_bridge_set_dsi_dp_rate(struct ti_sn_bridge *pdata)
>         regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
>
>         /* set DP data rate */
> -       dp_rate_mhz = ((bit_rate_mhz / pdata->dsi->lanes) * DP_CLK_FUDGE_NUM) /
> +       dp_rate_mhz = ((bit_rate_mhz / pdata->dp_lanes) * DP_CLK_FUDGE_NUM) /
>                                                         DP_CLK_FUDGE_DEN;

One note is that "bit_rate_mhz" is still calculated using the MIPI
pixel format, which is wrong.  It happens that (at the moment) we have
24 bits per pixel for both cases, though.


> +       /* read the panel capabilities to determine valid supported rates */
> +       val = drm_dp_dpcd_readb(&pdata->aux, DP_MAX_LINK_RATE, &dpcd_val);
> +       if (!val) {
> +               DRM_ERROR("Reading max link rate from DPCD failed\n");
> +               return;
> +       }
> +
> +       if (dpcd_val) {

I think your patch is assuming that the only case you want to use the
table is if dpcd_val is 0.  This doesn't appear to be the case.  In
Table 4-24 of the spec it states that you can have a non-zero value
here and still provide a table.  That might be useful if you want to
be backward compatible with an eDP 1.3 source but also provide an
optimized rate for a eDP 1.4 source.

We should be checking the eDP revision first and always using the
table if it's eDP 1.4.


> +               /* cap to the max rate supported by the bridge */
> +               if (dpcd_val > 0x14)
> +                       dpcd_val = 0x14;
> +
> +               switch (dpcd_val) {
> +               case 0x14:

There are constants.  Like DP_LINK_BW_5_4


> @@ -505,7 +589,14 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
>                            CHA_DSI_LANES_MASK, val);
>
>         /* DP lane config */
> -       val = DP_NUM_LANES(pdata->dsi->lanes - 1);
> +       ret = drm_dp_dpcd_readb(&pdata->aux, DP_MAX_LANE_COUNT, (u8 *)&val);

This is an iffy cast.  The function is only guaranteed to set the
first byte of val which could be the most or least significant byte.
Other bytes will remain as-is.

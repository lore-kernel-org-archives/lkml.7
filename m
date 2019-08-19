Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA5FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6B822CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFf6UYDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfHSW1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:27:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42332 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfHSW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:27:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so10289909wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlFs68StZp/FlDFjgK3S4TtgEBjwfttj1hn8UAnEdNk=;
        b=JFf6UYDBIz3eQdakavVNYrNV28gG2igI4TT5dcEhWYI3TmDNl0Jx3eAjPxAfXPrOpv
         +7soWwTkKGu2jd6jMQrCUjXqTpoLB6eVJ4oXbYh034gqpKbUuJbp/7umPmGrqPgiY8l6
         hCs8iChqFyPwCBu6VRvWJ4XEvlX/2up18IJBur+wNV/fOtnNX802IYMhw29zCzA5zUcZ
         JNL3av4TavrBJyIbj8+BdyAdd76rO4Qj9G7csueFlnItaVWOz//e8AHqDxa+vghEhKFh
         WJz+X5d/TIESuNc5FNWBxeiyefWaVFJWmGt9tndII3WZ7ZCW4G69MjhM0auAG/NNPSKy
         Kbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlFs68StZp/FlDFjgK3S4TtgEBjwfttj1hn8UAnEdNk=;
        b=WsdTIDUc3Xm64hF6xrITY9sNcNdEw/9p5brEL6T3/ztHHaWyMIZGh5a9l2LpbLqSeI
         fJOBd6J2fSPli+E+wwQJffDwYOqUqK9IbuKhoo0wGNQBIJzH4KmsHpBQFI0loeCtb8EG
         G9GGO/WTcVHuB1xBHZrk/Yvq+mtbeVdZF9v6b37K6TmNIDovjKiDMl2sL8Glfl+Ng5Yt
         OWrGnb2tDE9Ra4PTVLhMhsNM7DwhZw8/kowOiFlUVo4RTO+SmwG0RxvZiBQB3bzc7MDY
         aPz9/JPpB3Njr7e0YUCTYo/CiIZc6bkWikh24zln2wcgJ+s2c7SnEiX8MsCzAxlTJuk0
         kLSA==
X-Gm-Message-State: APjAAAU5jp45aXlAwy56AgK0K5UC/AOOUpQOZJAXY4UhOC+mlxMid1rW
        P2TH2pNgIInk1QMESy9lo4vXCOA5ACcfM+p12MCJ4g==
X-Google-Smtp-Source: APXvYqygqv6v2iZm1cVwyDBlQ+YonnmpNvq5LOSM+RwWyksTu6fo0LiWJf+Hp8hdQV7XsRp7IXOFmv1nEUpFXADwYo8=
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr29495640wrq.208.1566253666052;
 Mon, 19 Aug 2019 15:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190627151740.2277-1-matt.redfearn@thinci.com>
In-Reply-To: <20190627151740.2277-1-matt.redfearn@thinci.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 19 Aug 2019 15:27:34 -0700
Message-ID: <CALAqxLUsf4HJBcAcd+qzycFC3d8XbKk9HyQ7FfCrH8Ewc3mzvw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: adv7511: Attach to DSI host at probe time
To:     Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Sean Paul <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 8:18 AM Matt Redfearn <matt.redfearn@thinci.com> wrote:
>
> In contrast to all of the DSI panel drivers in drivers/gpu/drm/panel
> which attach to the DSI host via mipi_dsi_attach() at probe time, the
> ADV7533 bridge device does not. Instead it defers this to the point that
> the upstream device connects to its bridge via drm_bridge_attach().
> The generic Synopsys MIPI DSI host driver does not register it's own
> drm_bridge until the MIPI DSI has attached. But it does not call
> drm_bridge_attach() on the downstream device until the upstream device
> has attached. This leads to a chicken and the egg failure and the DRM
> pipeline does not complete.
> Since all other mipi_dsi_device drivers call mipi_dsi_attach() in
> probe(), make the adv7533 mipi_dsi_device do the same. This ensures that
> the Synopsys MIPI DSI host registers it's bridge such that it is
> available for the upstream device to connect to.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
>
> ---
>
> Changes in v2:
> Cleanup if adv7533_attach_dsi fails.
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index e7ddd3e3db9..807827bd910 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -874,9 +874,6 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
>                                  &adv7511_connector_helper_funcs);
>         drm_connector_attach_encoder(&adv->connector, bridge->encoder);
>
> -       if (adv->type == ADV7533)
> -               ret = adv7533_attach_dsi(adv);
> -
>         if (adv->i2c_main->irq)
>                 regmap_write(adv->regmap, ADV7511_REG_INT_ENABLE(0),
>                              ADV7511_INT0_HPD);
> @@ -1222,8 +1219,17 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>         drm_bridge_add(&adv7511->bridge);
>
>         adv7511_audio_init(dev, adv7511);
> +
> +       if (adv7511->type == ADV7533) {
> +               ret = adv7533_attach_dsi(adv7511);
> +               if (ret)
> +                       goto err_remove_bridge;
> +       }
> +
>         return 0;
>
> +err_remove_bridge:
> +       drm_bridge_remove(&adv7511->bridge);
>  err_unregister_cec:
>         i2c_unregister_device(adv7511->i2c_cec);
>         if (adv7511->cec_clk)
> --

As a heads up, I just did some testing on drm-misc-next and this patch
seems to be breaking the HiKey board.  On bootup, I'm seeing:
[    4.209615] adv7511 2-0039: 2-0039 supply avdd not found, using
dummy regulator
[    4.217075] adv7511 2-0039: 2-0039 supply dvdd not found, using
dummy regulator
[    4.224453] adv7511 2-0039: 2-0039 supply pvdd not found, using
dummy regulator
[    4.231804] adv7511 2-0039: 2-0039 supply a2vdd not found, using
dummy regulator
[    4.239242] adv7511 2-0039: 2-0039 supply v3p3 not found, using
dummy regulator
[    4.246615] adv7511 2-0039: 2-0039 supply v1p2 not found, using
dummy regulator
[    4.272970] adv7511 2-0039: failed to find dsi host

over and over.  The dummy regulator messages are normal, but usually
[    4.444315] kirin-drm f4100000.ade: bound f4107800.dsi (ops dsi_ops)

Starts up right afterward.

Reverting the change above seems to get things working again.  I've
not had much time to dig as to whats going wrong, but will keep
looking and wanted to raise the issue in the meantime.

thanks
-john

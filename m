Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F400C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA4B2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGl12q3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfH2Rjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:39:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46397 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfH2Rjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:39:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id z51so4889302edz.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWvompOB9P3qSUAQt3RGkWbjvpOgrGjuuiR+hcj9nz0=;
        b=cGl12q3btanfNBIfBGgNS4OEaxSll4YH3jpxfoItAFYfLShzkFsQFe/Zi6WPHuCUB5
         wnyh5sS0NdIw2bhi5WjVqDWtlaWM4nwHwZVdfj8Z8tioAq3mf/HTivEIBFvf5kdpnqF9
         0GsDpqdOawZDOvghZj/hJnGZ7i/MFSS/bSEhts/OQRxp4Ms/cMPmgVnp6tZM1xFYuyIv
         AvvSPgY+DQ1TGxg/6BRJ18Eqvtdl+edRhgNbYBY02bS2c/qfSCApUwsbei9uNwuF0unj
         luOVI25PBjZDI6JTS0uJLaTBj2B4svdX5lXvscrozuHUU5EM9zJHkErLhJtn2eD/SlI7
         cnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWvompOB9P3qSUAQt3RGkWbjvpOgrGjuuiR+hcj9nz0=;
        b=o3NMIR7z/+yMjTj/It4TuKLeK3JX7y3zqYkDXOHbc5hSMcaXX1K1jR0jqWQs3HMI2Y
         9ldFCfBR1w2RUiOxPJ1FEkLkewVmKCFKDLsqat7RdfiV5izHlFKoAO5JhPvdwXJ9FxlH
         Y+Ld9C22M++6DxrHtakCrxG2Ej9YNn1I0jAdSRmxrEK3Wf+8hfNQH9+3VJw5oqW1U/XS
         /XVcuryXcfHNtCQOWxmYtZ7xQiLLccZvjJYwJ+tCOEa7XRv0Q8AsbCHCCtzy9EfOtmv5
         GDm40BcBNnCmnjjTyXZjqa9f7E4j/5I3f8zmUbSiZeEWcdM8qPCLuzZGg0ew+JCXjeR9
         SN5A==
X-Gm-Message-State: APjAAAWhQUGi1NwSWMVpeUBtANJDID+Z3oWedOAiCgx1YLuXCMeC41Hk
        wZ21a6F8mFkP1ar8JnE+tEgMctvtBY+SFkvmrdI=
X-Google-Smtp-Source: APXvYqw0dTgLE2E3lYLOddKp9RHLShKkrEGWc3qWj/KUwq93H6wlWpEC6wNZ/syjoFr1eFEB/Mfak6Emj2EJWOp1cOU=
X-Received: by 2002:a17:906:6bc4:: with SMTP id t4mr9666690ejs.256.1567100368758;
 Thu, 29 Aug 2019 10:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060550.62095-1-john.stultz@linaro.org>
In-Reply-To: <20190829060550.62095-1-john.stultz@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 29 Aug 2019 10:39:17 -0700
Message-ID: <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matt Redfearn <matt.redfearn@thinci.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:06 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Since commit 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI
> host at probe time") landed in -next the HiKey board would fail
> to boot, looping:

No, please revert 83f35bc3a852.. that is going in the *complete* wrong
direction.  We actually should be moving panels to not require dsi
host until attach time, similar to how bridges work, not the other way
around.

The problem is that, when dealing with bootloader enabled display, we
need to be really careful not to touch the hardware until the display
driver knows the bridge/panel is present.  If the bridge/panel probes
after the display driver, we could end up killing scanout
(efifb/simplefb).. if the bridge/panel is missing some dependency and
never probes, it is rather unpleasant to be stuck trying to debug what
went wrong with no display.

Sorry I didn't notice that adv7511 patch before it landed, but the
right thing to do now is to revert it.

BR,
-R

>   adv7511 2-0039: failed to find dsi host
>
> messages over and over. Andrzej Hajda suggested this is due to a
> circular dependency issue, and that the adv7511 change is
> correcting the improper order used earlier.
>
> Unfortunately this means the DSI drivers that use adv7511 need
> to also need to be updated to use the proper ordering to
> continue to work.
>
> This patch tries to reorder the initialization to register the
> dsi_host first, and then call component_add via dsi_host_attach,
> instead of doing that at probe time.
>
> This seems to resolve the issue with the HiKey board.
>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Matt Redfearn <matt.redfearn@thinci.com>
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: David Airlie <airlied@linux.ie>,
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
> Fixes: 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI host at probe time")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> Note: I'm really not super familiar with the DSI code here,
> and am mostly just trying to refactor the existing code in a
> similar fashion to the suggested dw-mipi-dsi-rockchip.c
> implementation. Careful review would be greatly appreciated!
>
> Also there is an outstanding regression on the db410c since it
> similarly uses the adv7511 and probably needs a similar rework.
> ---
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 111 ++++++++++---------
>  1 file changed, 56 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> index 5bf8138941de..696cee1a1219 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> @@ -79,6 +79,7 @@ struct dsi_hw_ctx {
>  };
>
>  struct dw_dsi {
> +       struct device *dev;
>         struct drm_encoder encoder;
>         struct drm_bridge *bridge;
>         struct mipi_dsi_host host;
> @@ -724,51 +725,6 @@ static int dw_drm_encoder_init(struct device *dev,
>         return 0;
>  }
>
> -static int dsi_host_attach(struct mipi_dsi_host *host,
> -                          struct mipi_dsi_device *mdsi)
> -{
> -       struct dw_dsi *dsi = host_to_dsi(host);
> -
> -       if (mdsi->lanes < 1 || mdsi->lanes > 4) {
> -               DRM_ERROR("dsi device params invalid\n");
> -               return -EINVAL;
> -       }
> -
> -       dsi->lanes = mdsi->lanes;
> -       dsi->format = mdsi->format;
> -       dsi->mode_flags = mdsi->mode_flags;
> -
> -       return 0;
> -}
> -
> -static int dsi_host_detach(struct mipi_dsi_host *host,
> -                          struct mipi_dsi_device *mdsi)
> -{
> -       /* do nothing */
> -       return 0;
> -}
> -
> -static const struct mipi_dsi_host_ops dsi_host_ops = {
> -       .attach = dsi_host_attach,
> -       .detach = dsi_host_detach,
> -};
> -
> -static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
> -{
> -       struct mipi_dsi_host *host = &dsi->host;
> -       int ret;
> -
> -       host->dev = dev;
> -       host->ops = &dsi_host_ops;
> -       ret = mipi_dsi_host_register(host);
> -       if (ret) {
> -               DRM_ERROR("failed to register dsi host\n");
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
>  static int dsi_bridge_init(struct drm_device *dev, struct dw_dsi *dsi)
>  {
>         struct drm_encoder *encoder = &dsi->encoder;
> @@ -796,10 +752,6 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
>         if (ret)
>                 return ret;
>
> -       ret = dsi_host_init(dev, dsi);
> -       if (ret)
> -               return ret;
> -
>         ret = dsi_bridge_init(drm_dev, dsi);
>         if (ret)
>                 return ret;
> @@ -817,13 +769,22 @@ static const struct component_ops dsi_ops = {
>         .unbind = dsi_unbind,
>  };
>
> -static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
> +static int dsi_host_attach(struct mipi_dsi_host *host,
> +                          struct mipi_dsi_device *mdsi)
>  {
> -       struct dsi_hw_ctx *ctx = dsi->ctx;
> -       struct device_node *np = pdev->dev.of_node;
> -       struct resource *res;
> +       struct dw_dsi *dsi = host_to_dsi(host);
> +       struct device_node *np = dsi->dev->of_node;
>         int ret;
>
> +       if (mdsi->lanes < 1 || mdsi->lanes > 4) {
> +               DRM_ERROR("dsi device params invalid\n");
> +               return -EINVAL;
> +       }
> +
> +       dsi->lanes = mdsi->lanes;
> +       dsi->format = mdsi->format;
> +       dsi->mode_flags = mdsi->mode_flags;
> +
>         /*
>          * Get the endpoint node. In our case, dsi has one output port1
>          * to which the external HDMI bridge is connected.
> @@ -832,6 +793,42 @@ static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
>         if (ret)
>                 return ret;
>
> +       return component_add(dsi->dev, &dsi_ops);
> +}
> +
> +static int dsi_host_detach(struct mipi_dsi_host *host,
> +                          struct mipi_dsi_device *mdsi)
> +{
> +       /* do nothing */
> +       return 0;
> +}
> +
> +static const struct mipi_dsi_host_ops dsi_host_ops = {
> +       .attach = dsi_host_attach,
> +       .detach = dsi_host_detach,
> +};
> +
> +static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
> +{
> +       struct mipi_dsi_host *host = &dsi->host;
> +       int ret;
> +
> +       host->dev = dev;
> +       host->ops = &dsi_host_ops;
> +       ret = mipi_dsi_host_register(host);
> +       if (ret) {
> +               DRM_ERROR("failed to register dsi host\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
> +{
> +       struct dsi_hw_ctx *ctx = dsi->ctx;
> +       struct resource *res;
> +
>         ctx->pclk = devm_clk_get(&pdev->dev, "pclk");
>         if (IS_ERR(ctx->pclk)) {
>                 DRM_ERROR("failed to get pclk clock\n");
> @@ -862,15 +859,19 @@ static int dsi_probe(struct platform_device *pdev)
>         }
>         dsi = &data->dsi;
>         ctx = &data->ctx;
> +       dsi->dev = &pdev->dev;
>         dsi->ctx = ctx;
>
>         ret = dsi_parse_dt(pdev, dsi);
>         if (ret)
>                 return ret;
>
> -       platform_set_drvdata(pdev, data);
> +       ret = dsi_host_init(&pdev->dev, dsi);
> +       if (ret)
> +               return ret;
>
> -       return component_add(&pdev->dev, &dsi_ops);
> +       platform_set_drvdata(pdev, data);
> +       return 0;
>  }
>
>  static int dsi_remove(struct platform_device *pdev)
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E936C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23A1222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJCG4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:56:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45927 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJCG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:56:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33so1367419edh.12;
        Wed, 02 Oct 2019 23:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1O/m2RHGnuqku3yr69v1puhEpk9yyZ7Bn2a9zyF0W0s=;
        b=Hu11fOYWmrM6h2PCR0swbkvcM+gjJlK7O/QNpCXjqQlIsYG+JBa5t+36muvOMRimEi
         +Qb3XRd8VKzy3a62D7D1oqQtsezweBrLaQd90BDoE2hDaKBH3HoMiGSfK7XpNSixoD+B
         eE+EqyWyCCqTpgCckXwSc6rAeJ/NIGhgpedOEoo0AIPPAaQq7L4yJo9zISH1dKw15i7L
         7mfUvKq3fd0pwHvHNvp3fzUbbzDtd/KwjXuAVPKk4mGFtsqN4idy5nymsKLIKpFmabta
         ELMwKDv7b6KPLcMRnBtm8D63ZbYnfS43BpxU+dWaWfji/a4PT2QrWzmmImT3vGHyJntf
         Wj/g==
X-Gm-Message-State: APjAAAW38/v6DY0pwGem/gDsP8ViHY/Me6+fT5M33lC/ayUIym1DCkOA
        4GiV63x6ymOoY2KFGFQH1WP742hjkGg=
X-Google-Smtp-Source: APXvYqyx9uGywft5jBrG//BLu5Uw3JtKzrV+JaGJvnTEanTlbJAcBt7tbfnZrD+VgyB16Z9pNqYjiA==
X-Received: by 2002:a50:c306:: with SMTP id a6mr8117199edb.108.1570085760331;
        Wed, 02 Oct 2019 23:56:00 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id j9sm296744edt.15.2019.10.02.23.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 23:56:00 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id p14so691157wro.4;
        Wed, 02 Oct 2019 23:55:59 -0700 (PDT)
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr858936wrw.142.1570085759470;
 Wed, 02 Oct 2019 23:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191003064527.15128-1-jagan@amarulasolutions.com> <20191003064527.15128-6-jagan@amarulasolutions.com>
In-Reply-To: <20191003064527.15128-6-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 3 Oct 2019 14:55:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v64RJeHXSDknPvH3RrDLqPzSvR-p2k2vA73Zt1xsOd5TSw@mail.gmail.com>
Message-ID: <CAGb2v64RJeHXSDknPvH3RrDLqPzSvR-p2k2vA73Zt1xsOd5TSw@mail.gmail.com>
Subject: Re: [PATCH v11 5/7] drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator support
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Allwinner MIPI DSI controllers are supplied with SoC
> DSI power rails via VCC-DSI pin.
>
> Add support for this supply pin by adding voltage
> regulator handling code to MIPI DSI driver.
>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 446dc56cc44b..fe9a3667f3a1 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -1110,6 +1110,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>                 return PTR_ERR(base);
>         }
>
> +       dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
> +       if (IS_ERR(dsi->regulator)) {
> +               dev_err(dev, "Couldn't get VCC-DSI supply\n");
> +               return PTR_ERR(dsi->regulator);
> +       }
> +
>         dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
>                                               &sun6i_dsi_regmap_config);
>         if (IS_ERR(dsi->regs)) {
> @@ -1183,6 +1189,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
>  static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
>  {
>         struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> +       int err;
> +
> +       err = regulator_enable(dsi->regulator);
> +       if (err) {
> +               dev_err(dsi->dev, "failed to enable VCC-DSI supply: %d\n", err);
> +               return err;
> +       }
>
>         reset_control_deassert(dsi->reset);
>         clk_prepare_enable(dsi->mod_clk);
> @@ -1215,6 +1228,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
>
>         clk_disable_unprepare(dsi->mod_clk);
>         reset_control_assert(dsi->reset);
> +       regulator_disable(dsi->regulator);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> index 5c3ad5be0690..a01d44e9e461 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
> @@ -12,6 +12,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_mipi_dsi.h>
> +#include <linux/regulator/consumer.h>

You don't need to include the header file since you are only
including a pointer to the struct, and nothing else.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>
>  #define SUN6I_DSI_TCON_DIV     4
>
> @@ -23,6 +24,7 @@ struct sun6i_dsi {
>         struct clk              *bus_clk;
>         struct clk              *mod_clk;
>         struct regmap           *regs;
> +       struct regulator        *regulator;
>         struct reset_control    *reset;
>         struct phy              *dphy;
>
> --
> 2.18.0.321.gffc6fa0e3
>

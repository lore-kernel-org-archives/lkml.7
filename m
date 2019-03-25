Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457F9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111DF20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmzVAIcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfCYN16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:27:58 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45321 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:27:56 -0400
Received: by mail-vk1-f195.google.com with SMTP id v187so1924998vkf.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAUJAYo6dFJMNB+20ayRFyVLng1BOJZiHuvdo7BGGLQ=;
        b=tmzVAIcHPytLxWUWrRzXCrw/9m8LPYTIGLTYy3KLm3NPPUsT+n81mtl/XIp9OYu+c2
         2gq8eZjfyGFoMFW1uNfCKV3KA5tp8MjcpNGRmPURjqRwU7AGFjD5mHJrpyLVpfs+Vhy2
         gTtNggcMVUIvpIMV0E9rD0Y4HE3MdLE1NAKjFtz/KLsFeTARrkPxun0fEFiwMK01B2qL
         gXi0rAJi9m1VjFqpNmqjZIwMq4ilmHNG61kvqpd1MlNBkOiCs0qobcqVhWshZTWDEgBA
         PE5NMW0XEgoP3Aiq0/I/zMZHfvAwCFz3Pt3+1B1zSgKFFPOf3Y7uIibpnJ0HZq1AzKOk
         6EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAUJAYo6dFJMNB+20ayRFyVLng1BOJZiHuvdo7BGGLQ=;
        b=cVDGly5hMcGxbD+wmYGwiEZMER/hcuPsp8wT1QK0vQNVccPHW5G8R9HFUEJM7BI0Ui
         E16jXIrtec276HaIOKlIbS4D2ugS80wcoyl8Qr9EVW85nuZwBSpgiAOvcqGDhaKMxp+J
         RKGDA62DigXpndukM2L1gB8e2TD8seYvKcsF6tsYuOZh28xQ0B5y6amrhXgK7HaKTlY2
         fBpJ+BL2rs5J2uRsU+yDwk4hA4nAh38flHASRTjsGAt5vDACARvSt9932v677A2IuuGF
         +qhMpmxX8p4D0xZwqRavDW06nxv20MXofjmupw1uV4TNppLTp5C4aBOvBrFy7mfnL2Rn
         ZdaQ==
X-Gm-Message-State: APjAAAWDC2X651aeFWhjCvOzh5XzIMrVHgTgQzZeDuW+xs2dQ5jnWr0J
        1/8nm0av5Fw2BeDdpyKNpbJuqF276dDcQTMTMI4AGQ==
X-Google-Smtp-Source: APXvYqzQv88VMgfVovi4ZhwPO4LjqKIr9bS5YUttrZSbLpVHjU72igCr303ShGrACrZnhqjFXftTHm48yp2T4wwx+8g=
X-Received: by 2002:a1f:6b49:: with SMTP id g70mr9924232vkc.17.1553520474854;
 Mon, 25 Mar 2019 06:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com> <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 14:27:18 +0100
Message-ID: <CAPDyKFrDq-zBsqqe23hj4ynfYnrGxAr0tWxvYEJu8Kvh0i=h9A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-of-arasan: Add DTS property to disable DCMDs.
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Randy Li <ayaka@soulik.info>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
<christoph.muellner@theobroma-systems.com> wrote:
>
> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
> which exposes a control register bit to enable the feature.
> The current implementation sets this bit unconditionally.
>
> This patch allows to suppress the feature activation,
> by specifying the property disable-cqe-dcmd.
>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Perhaps both patch1 and patch2 should be tagged for stable? Then
please tell me and I can add a tag.

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c9e3e050ccc8..88dc3f00a5be 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 host->mmc_host_ops.start_signal_voltage_switch =
>                                         sdhci_arasan_voltage_switch;
>                 sdhci_arasan->has_cqe = true;
> -               host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +               host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +               if (!of_property_read_bool(np, "disable-cqe-dcmd"))
> +                       host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>         }
>
>         ret = sdhci_arasan_add_host(sdhci_arasan);
> --
> 2.11.0
>

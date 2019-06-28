Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61FB20656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfF1Krn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:47:43 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42687 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfF1Krm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:47:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so5695649qtk.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVinKh98jKS9zokr8ydHNCBWzDAiTD09mu2we75eaLU=;
        b=b7KdH0dc4Kegrewx4iQlsF7V5+KS+w3WYFfgdL3OgeN1CdfHy7vhlsmZJ6QS9gLVVC
         vi9LUbHvH4sSwfET53TilG4LLvmDXzFDciSHsxzQCaq2SyHGPr3rRSyh3l/b9uEuzcse
         BqTKXBcaSqWR6BrwUzKDtMk0WOfTKsJYk7ax0QQ8m6RyoxfjRfEk+mgOD0lyMi3cLD/J
         aDiO7Tz+U8OU53ukxfkrdxELjwJvwBhMhF5nEy7b6+PD6cGd1FMiwWY8m1vXvEXC9x1i
         dX2EizKv8GhIo1o+KxxPXfsAKzYXiIv76a9qd1yu6fEaj6yBOCt0/1ZFd33kuP8t1vrC
         iZlQ==
X-Gm-Message-State: APjAAAVpj5bwilkz83iHGYYHJyMNIoyRNIURMNDnJzx6VJ8wW/bIGKbh
        JexUYeHxCRB84b1vvq9J7DWBuGcb430ujgzCcGiPXLLB
X-Google-Smtp-Source: APXvYqysF9BzxO+1TCPjWlwBt4glLmlNo2rduj1I87kx9rKzFs7FWUU0hg3HnQz1I0GfoEk0Btcv6dquQV2vbRxaxlw=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr7558111qvf.62.1561718861770;
 Fri, 28 Jun 2019 03:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190628104132.2791616-1-arnd@arndb.de>
In-Reply-To: <20190628104132.2791616-1-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Jun 2019 12:47:23 +0200
Message-ID: <CAK8P3a1CV-JUpBJ0pjixwXxxOzjQOX=+E3s-mKGAz_bMBc_Vuw@mail.gmail.com>
Subject: Re: [PATCH] mfd: davinci_voicecodec: remove pointless #include
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Richard Fontana <rfontana@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I missed the davinci maintainers on cc here, sorry]

On Fri, Jun 28, 2019 at 12:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When building davinci as multiplatform, we get a build error
> in this file:
>
> drivers/mfd/davinci_voicecodec.c:22:10: fatal error: 'mach/hardware.h' file not found
>
> The header is only used to access the io_v2p() macro, but the
> result is already known because that comes from the resource
> a little bit earlier.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/davinci_voicecodec.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
> index 13ca7203e193..e5c8bc998eb4 100644
> --- a/drivers/mfd/davinci_voicecodec.c
> +++ b/drivers/mfd/davinci_voicecodec.c
> @@ -19,7 +19,6 @@
>  #include <sound/pcm.h>
>
>  #include <linux/mfd/davinci_voicecodec.h>
> -#include <mach/hardware.h>
>
>  static const struct regmap_config davinci_vc_regmap = {
>         .reg_bits = 32,
> @@ -31,6 +30,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
>         struct davinci_vc *davinci_vc;
>         struct resource *res;
>         struct mfd_cell *cell = NULL;
> +       dma_addr_t fifo_base;
>         int ret;
>
>         davinci_vc = devm_kzalloc(&pdev->dev,
> @@ -48,6 +48,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> +       fifo_base = (dma_addr_t)res->start;
>         davinci_vc->base = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(davinci_vc->base)) {
>                 ret = PTR_ERR(davinci_vc->base);
> @@ -70,8 +71,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
>         }
>
>         davinci_vc->davinci_vcif.dma_tx_channel = res->start;
> -       davinci_vc->davinci_vcif.dma_tx_addr =
> -               (dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_WFIFO);
> +       davinci_vc->davinci_vcif.dma_tx_addr = fifo_base + DAVINCI_VC_WFIFO;
>
>         res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>         if (!res) {
> @@ -81,8 +81,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
>         }
>
>         davinci_vc->davinci_vcif.dma_rx_channel = res->start;
> -       davinci_vc->davinci_vcif.dma_rx_addr =
> -               (dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_RFIFO);
> +       davinci_vc->davinci_vcif.dma_rx_addr = fifo_base + DAVINCI_VC_RFIFO;
>
>         davinci_vc->dev = &pdev->dev;
>         davinci_vc->pdev = pdev;
> --
> 2.20.0
>

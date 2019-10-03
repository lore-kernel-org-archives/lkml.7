Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F8C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695E721A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNFS4WZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfJCKCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:02:25 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39706 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfJCKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:02:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id b14so696256uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOSpNy+f7VfEti+UMkQ6EpXD+06Um2caF49vqJkGTIU=;
        b=mNFS4WZ5+nNrYnXE1BleojBJ2+Rbdf9JROYEgt4+yTQ6sosZS+zXZ7jEQyr/21qOHo
         ZRca6pstZgoYwO9BQ0/ncegqwZbZUFaHeWkGiKx0arLsP5XWU3VfktsAcQBwl/+2OTM2
         T9fEF6txKviVOAZgqdT5cgh+OjZ1LTAVTWFvUUx3k/hAo3IVDbE644ZWgpBEWNJabXCm
         HmdLWMsm8FfT24M62fOYITbUDCYADpoBUhUrotqLgKqJ0MRVD4cY3KDvWH863ehV1Iow
         Qs0qP+hrlw6y63wOaXkYg+NNKTxg1wjNZojN4iHAc4C9OB9alV/dPJaeEnxrYlm+L9fj
         AWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOSpNy+f7VfEti+UMkQ6EpXD+06Um2caF49vqJkGTIU=;
        b=RlcUUzE/ztgFXF/xbsV6jnvBV9E/m3hCKFkI5W/fY8GCadLROFDl3p+VZoSlxuETcY
         HInjKh++1QKQmddxvEoNFHjVsAXOS93kjSxhDAYXiRLpnLW6XcB7R8BqpNFuk2HAzm1D
         ln94r8o6q7Dln4QRC9IiaJUulE1LXXKWWMsR1agbs8Ua99MeZn22T45LCw0jAv4fK1+P
         yO35ZsdbG8D1m0d8pyc4ZB0Q244BtVOtbvcT88pXpWziKio8+T1weiRNy7/bam+EO8N7
         yZ2mBQIGK1lg6iH30LOV+ZGJ4OwN2Hs+qokHpTMPcn5bvYsj4K+eqiQzAeFMXLi/2rCE
         5knQ==
X-Gm-Message-State: APjAAAXEAFOvP/ikRWV2mi7jKyxN1+klK99CU2/AJly0A8AvDQYeADkX
        2pj2R8lDCMWVI26ivEaU9wFrkIMe+4W6Otu2BtdYvg==
X-Google-Smtp-Source: APXvYqy1kKchXz+oPn0n/cgFca4K27JNgGB2h8SdeZvE8qZywL3z2hE+b/iLMb85HvQngCIZt5pFcC7UNWQtn0HAkug=
X-Received: by 2002:a9f:24c4:: with SMTP id 62mr4434046uar.104.1570096943050;
 Thu, 03 Oct 2019 03:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
In-Reply-To: <4ad4cdb5-3623-4416-d3d2-b3c048a42139@web.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:01:47 +0200
Message-ID: <CAPDyKFpHdOGqSTDd95m=NjcE+vkW_p=61UFFegJ9QX8j3UdB0g@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium-octeon: Use devm_platform_ioremap_resource()
 in octeon_mmc_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 at 14:28, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 14:20:34 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-octeon.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 22aded1065ae..916746c6c2c7 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -148,7 +148,6 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>  {
>         struct device_node *cn, *node = pdev->dev.of_node;
>         struct cvm_mmc_host *host;
> -       struct resource *res;
>         void __iomem *base;
>         int mmc_irq[9];
>         int i, ret = 0;
> @@ -205,23 +204,13 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>
>         host->last_slot = -1;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "Platform resource[0] is missing\n");
> -               return -ENXIO;
> -       }
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>         host->base = (void __iomem *)base;
>         host->reg_off = 0;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       if (!res) {
> -               dev_err(&pdev->dev, "Platform resource[1] is missing\n");
> -               return -EINVAL;
> -       }
> -       base = devm_ioremap_resource(&pdev->dev, res);
> +       base = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>         host->dma_base = (void __iomem *)base;
> --
> 2.23.0
>

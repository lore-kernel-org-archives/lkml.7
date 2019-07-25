Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96795C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572AE2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpD8rDzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfGYNXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:23:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47084 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGYNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:23:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id 65so37620284oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwM2+qYHt0UEBA6UJDkeQDcGwUyIPjkorh2VTV9IDzw=;
        b=UpD8rDzoKa7CF0RszwEp2yu+B1fDuQVKouFsCxQnA5dTxpou+Ba3K9lVpz2jMPqq/1
         sxeFNJK6Sf38cQGqrVLHeAQfBsqpgOTYVX12hsupalkh+KnDYymBDvqA/45etUsKBwvZ
         0Ab4Z822WfZQm+okMa5x6zu0rnY+sVZpRjGRLe4ekSilG1jJLTHwNCG57S00SQJ5TMeq
         FkIBGCDmkRRu2QfHuvfH0DHb8rHjKJn2RvtTKU2M76OnXw1kYCVoK5OQljlokqn7EnmN
         6P5kJri4WNNlZJ+Uj/pSGWD+8m6are5chNBp4JvdEWWOhAaKh9LZB24sZiuH7WT7DHK/
         kCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwM2+qYHt0UEBA6UJDkeQDcGwUyIPjkorh2VTV9IDzw=;
        b=m9gLTcsVv/IGOn1YWKQXSjHEOZ2k8bQx81SaoOdAT9SShvJ1CwXR66c5WL0o1DideF
         CE+nSLPujMYk9DmMftLfq5exe3dR/2uCJRNjSUnWr9lZd9+xCdUtkL3QRL+yICiRVFaD
         gynuPXERo9Ag/5ct/21RB/g4lvLElRutG40s+n0Fap4ber9/DGTToKocPW/d0ZPaO6ea
         rfNebM7hzw8Wz/JkNsZkCMDq1zZ9TV79brEobZeKvO6zrDGOKSXVHq1H/H3MHY46lEYU
         z8E30nZy47a2xEP6Ngwxf7PuOx/RMRtStbtz6dBtHWe7be5dDl5jFACipA7PuGdTtrHJ
         VI7w==
X-Gm-Message-State: APjAAAUzmFSYzJMs4ryZ95sNf//VF3G7QRMiRThYHl6iFE33QQtv+Nwl
        7fPnWUUgdR5zXkSyfMIabTjK2sYuZJD+rJKOJb+gB3m9
X-Google-Smtp-Source: APXvYqypjRf2awMQdztO7PYDu9Rw91aR4GcRmWVCqGbM344Dbhlb0mEkUpz8ySSDsEuabMZWkpRRW0tnWgt9tzqllw0=
X-Received: by 2002:ac5:c2d2:: with SMTP id i18mr33137975vkk.36.1564060526687;
 Thu, 25 Jul 2019 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190725151748.1a59b1ba@xhacker.debian>
In-Reply-To: <20190725151748.1a59b1ba@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Jul 2019 15:14:50 +0200
Message-ID: <CAPDyKFpwOaa-8GxkWnXoyoC8nLyGMGE8moyEJr4a7TVBSiw6mw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Use devm_platform_ioremap_resource() to
 simplify code
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 at 09:28, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> devm_platform_ioremap_resource() wraps platform_get_resource() and
> devm_ioremap_resource() in a single helper, let's use that helper to
> simplify the code.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pltfm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index d268b3b8850a..11ecff9e998d 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -118,12 +118,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>                                     size_t priv_size)
>  {
>         struct sdhci_host *host;
> -       struct resource *iomem;
>         void __iomem *ioaddr;
>         int irq, ret;
>
> -       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
> +       ioaddr = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ioaddr)) {
>                 ret = PTR_ERR(ioaddr);
>                 goto err;
> --
> 2.22.0
>

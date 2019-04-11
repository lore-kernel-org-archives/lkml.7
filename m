Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B007DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD24217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIrP9hh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKKnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:43:51 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33910 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKKnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:43:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id t78so3206459vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLOKfUksx4CoR+vUiDn8/P6m64a24gTDOgWcpsMihPs=;
        b=XIrP9hh9WndJnJg5Hu16WIWQQmql5H9f51UGF8Qlv8EWhNN2qiF/UwB4Gu1Ncmuy9m
         PigZOa0JSwIMEkF0z48NfNqFk1ik5WkEV3yUqJ96MAUnuHCgdW9ca3lEjETtQiHfqOSq
         jdW5K2xKy7ZDbwQfCoBUWJbTNVUbj3FLdctO/8LqRQhSupFAzF6TkVqfKsA2XnV48CQw
         TsIXFWHu1aiirFgF0+mNlrnIm5NASEUvt5IPk2JE3HxjKT6el0dnc3luZLfoOKbiHnxe
         TRjiqIBOyL/1xoNyfpQTr2jrzolOTTqPg6cEuaGkuUhY7rDKSvpbjhJO/U6OTsxIe5Hc
         M8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLOKfUksx4CoR+vUiDn8/P6m64a24gTDOgWcpsMihPs=;
        b=mSM7FrcVxCzlGQfbXuAtY1C6I4tiBZj0atrW1tdQD+vDMwJDIkttCiCrnET0j+/0HJ
         OKn4XG0qsKngXuYFJrlHHOyMnJPO9lWkTwD5JRrKd9oeN6jVZEjBMOxuGP/M9FAT67bZ
         G6mh6e3K6QZUbtkT93MyOTHqwkwVS2zxVJfSL1hHKL/VBJwIFyTml4hMQUnXoC4Rnc9u
         O8zhv4CFo7zVe1ACuAHVMBG5MmZZTK8hJ+1Uxu7N5wdhR2cqTgS50XYIDaQ99nv7u7zz
         IKgqFencaU8D4hQ+Qbx24llvYyfPCEjknDStKsD+373tW8QJ0YSBkNrkuhTLW+wof+Mu
         ZiRA==
X-Gm-Message-State: APjAAAXEuoqw8oayAAMpwuAAsj6srTl4+6qagLpm9zRPwU5CYv7c4Tx3
        2Aytc4rW3v/VLAk5MLyQtFvRSSy0wlxjAdhynpwLSg==
X-Google-Smtp-Source: APXvYqzYoMXg8O7xXM4xBHT5TPPkC6ZsCmbYw4e3cs/+O7DyQeDOnSPHGUj/kGrNrfBKFovE5iG1FdT68+SwjjgMbSk=
X-Received: by 2002:a67:fa04:: with SMTP id i4mr27531604vsq.18.1554979429381;
 Thu, 11 Apr 2019 03:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190403193050.22180-1-fparent@baylibre.com>
In-Reply-To: <20190403193050.22180-1-fparent@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 12:43:13 +0200
Message-ID: <CAPDyKFrKxGxp5K38P-AHrRpjOGjKhBv333HXAHPNKYWqLJmz+g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: check for valid optional memory resource
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jjian Zhou <jjian.zhou@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 at 21:31, Fabien Parent <fparent@baylibre.com> wrote:
>
> 'top_base' memory region is optional. Check that the resource is valid
> before using it. This avoid getting a "invalid resource" error message
> printed by the kernel.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> V2:
>         Fix invalid condition: check against 'res' variable instead of 'ret'.
>
> ---
>  drivers/mmc/host/mtk-sd.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 833ef0590af8..61bf8704491c 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2123,9 +2123,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         }
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       host->top_base = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(host->top_base))
> -               host->top_base = NULL;
> +       if (res) {
> +               host->top_base = devm_ioremap_resource(&pdev->dev, res);
> +               if (IS_ERR(host->top_base))
> +                       host->top_base = NULL;
> +       }
>
>         ret = mmc_regulator_get_supply(mmc);
>         if (ret)
> --
> 2.20.1
>

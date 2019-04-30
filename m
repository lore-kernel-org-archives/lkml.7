Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6640FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9E821655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsqMSj9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfD3CzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:55:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46040 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfD3CzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:55:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id a10so1788297otl.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 19:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bt+90qKJU51hc2zj+wyErRDhxM+YorzWX9KYuojMxOI=;
        b=jsqMSj9X3fRj0YFL5jSMd0EkQP21EHUJHAXMgNHmoL+P90pUJ5Sx5iIkYBdG9IbkdK
         N/lC8T5N51Scf9+lteOZqHg11GKw1Zw1YYZkwUh0XE6gQntOv49m/ZOnjnkjEK+RW4Qp
         tnmIetz6h7k7KLL9Wdf5/HtGtxljTzrhtdbO7E2Qr9Mg1BxBU+jVuNPahRgP/m8xLeCc
         2KlGk+efpxRx1HbWHj89P8m4xoTFNguyNsVSdGBmDnwIYot26G9zwYgYD2XnarsXbOib
         CPSFjAi1ahzmuZ8yTK+aPPgJIA5DsJa5OdrdOO+TDiwjuJ/0C8poIZNt+ZFf1l7Jiszz
         rgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bt+90qKJU51hc2zj+wyErRDhxM+YorzWX9KYuojMxOI=;
        b=Lr+VYLrmHPvSAwbK+XfAfH8/+UAqc1Ng/U715Tn4V3x0xMTLgmT2zz0drI9Du8BABG
         Ypmvmc6i4rQei00Ui5/PGsGzI3x/39hjU7XUkZIwHbc8IEun+XcjPEcVtJpFvphE570l
         +RSFPBpMt+Pqeiuhimeoe8lSMEvJe13/AOj8TL2GUa34u+imU+d/o2MauR5A7pJOD+YZ
         OWwjwvxzEShsmQQya5t5i7u2ETAJb+7a3H0t+vQBu+3FwgNKt8qkUBrcLSX8uboaO4O9
         1mQwpSzhC8ytr2Nc+QxcgidCOV/Z8KWCQgPxFVZwTtZUSMo3EzBv0JYa/szOfGURDrfg
         MNfg==
X-Gm-Message-State: APjAAAVY8t/MqrLhqJfp0Ied33o60OQPvqGvAh5qRhdVBxbPGQYluvzU
        KgyuXKe2Xt4ty2OfNje2aeO+CWErar5czT77b6mlPA==
X-Google-Smtp-Source: APXvYqza1fSMSoBvnt0Jo4oJAm75w947jdC8tfEOFgO4J39P16MQxMTnMDONNOU7uqQ8ZQ2JCrF+Y/d3FabU0N0gWDE=
X-Received: by 2002:a05:6830:b:: with SMTP id c11mr10056069otp.281.1556592903791;
 Mon, 29 Apr 2019 19:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190429122512.59242-1-weiyongjun1@huawei.com>
In-Reply-To: <20190429122512.59242-1-weiyongjun1@huawei.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 30 Apr 2019 10:54:51 +0800
Message-ID: <CAMz4kuJtMAyjbPR0Yf_FN1fhDwSi5=0WAgD_BNEuTB5GhcTYxQ@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: sprd: Fix return value check in sprd_mcdt_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 at 20:15, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Fixes: d7bff893e04f ("ASoC: sprd: Add Spreadtrum multi-channel data transfer support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks for fixing my mistake.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  sound/soc/sprd/sprd-mcdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
> index 28f5e649733d..e9318d7a4810 100644
> --- a/sound/soc/sprd/sprd-mcdt.c
> +++ b/sound/soc/sprd/sprd-mcdt.c
> @@ -951,8 +951,8 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         mcdt->base = devm_ioremap_resource(&pdev->dev, res);
> -       if (!mcdt->base)
> -               return -ENOMEM;
> +       if (IS_ERR(mcdt->base))
> +               return PTR_ERR(mcdt->base);
>
>         mcdt->dev = &pdev->dev;
>         spin_lock_init(&mcdt->lock);
>
>
>


-- 
Baolin Wang
Best Regards

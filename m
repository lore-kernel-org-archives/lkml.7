Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03079C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5DD21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmBlZ34b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfEUGiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:38:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45008 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfEUGiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:38:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id z65so11902400oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wKZ4IXB8g2hmXytMXYM1DsvOeazyNogr3S1uJhkvt8=;
        b=CmBlZ34bXv10h+yhn07EjFFpEQjD4NUwHDKPZoWFbMURqp+7pZXePDFmSLm/brCQlw
         /xntKPradmiH6HvMqrfgZrO90GeDa/l8EqnJB/0aZ8f6AbZTv7pheYmEyyNIIizn47Dx
         9jLmxAnoMh8gBm3uZr+KN3wMpAHkFHl1XEA1/7PIF1XTGH5I4Ue8iuNi9AnpJyw7shTE
         pgFk2pBKPyr6SQzVe1qznD1Ldngk6JpkNRjVp/14REDJmlOxH+d9eEk74r/TxekIuTAh
         E3IqFds4emnBnXzlrkSdY8OaPv3e5SUwwL0seOr2i5CWDWj7De02qes7DO1xu64zWWcb
         qo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wKZ4IXB8g2hmXytMXYM1DsvOeazyNogr3S1uJhkvt8=;
        b=QVdHEWTD0i1qCuTcRM6WRNuz9XOv2b2GiFvgZlasksF0+s7k6UQMD6hTxmZex+VT22
         Co+1F/6cSvCY9OLEqIfL9rvgUcri7SCOaSPcQVSFD+VjnotxGJfubJmbc2AWTXh1QTDM
         xGR7XOeOeuMyMi1zksuHYbFfxmFc+HX1f00GEVPqwZJ8vPIqpZsFcKRfRrA5wDLPUHTP
         vTIY9/Y6azwJBD+eGhhAyivFwiLi625yHEszsKc6awmFTv06MVQXZKu1V/OleKPndwvh
         9FTihuUbcC60hJp1H+0EfbxQ0LRk0QOtBlQKvyNycQqeMfKdfFgwaVK7M10zwbmTXcOv
         j8bA==
X-Gm-Message-State: APjAAAVgx7+CIRr6qy/suNj/K9K/iPUGHSGSxuWDRrQHkSRXcqUOfTgk
        Ec9QUiGO50SfA2YkKMB0nlTxBQEIc/RUtAGE917Hrg==
X-Google-Smtp-Source: APXvYqz5ONfmgeZhCETJDy5RkyHt8Hz11iWvnMNo1U8wZGPBXQTbvhNoXwoRMO5KcxIA9BeDiLrJBn1f6FoHMBqGwCE=
X-Received: by 2002:aca:61c3:: with SMTP id v186mr148825oib.27.1558420695476;
 Mon, 20 May 2019 23:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190521060952.2949-1-zhang.chunyan@linaro.org> <20190521060952.2949-2-zhang.chunyan@linaro.org>
In-Reply-To: <20190521060952.2949-2-zhang.chunyan@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 21 May 2019 14:38:03 +0800
Message-ID: <CAMz4kuLjOjKGXn7QtOO5Gizo-FZ7CDf2SiczTNPwDgjAKzm2pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On Tue, 21 May 2019 at 14:15, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>
> devm_ioremap_resources() automatically requests resources and devm_ wrappers
> do better error handling and unmapping of the I/O region when needed,
> that would make drivers more clean and simple.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/clk/sprd/common.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
> index e038b0447206..a5bdca1de5d0 100644
> --- a/drivers/clk/sprd/common.c
> +++ b/drivers/clk/sprd/common.c
> @@ -42,6 +42,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
>         void __iomem *base;
>         struct device_node *node = pdev->dev.of_node;
>         struct regmap *regmap;
> +       struct resource *res;
>
>         if (of_find_property(node, "sprd,syscon", NULL)) {
>                 regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
> @@ -50,10 +51,14 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
>                         return PTR_ERR(regmap);
>                 }
>         } else {
> -               base = of_iomap(node, 0);
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +               base = devm_ioremap_resource(&pdev->dev, res);
> +               if (IS_ERR(base))
> +                       return PTR_ERR(base);
> +
>                 regmap = devm_regmap_init_mmio(&pdev->dev, base,
>                                                &sprdclk_regmap_config);
> -               if (IS_ERR_OR_NULL(regmap)) {
> +               if (IS_ERR(regmap)) {

You did not mention this fix in your commit message, and it's better
to move into one separate patch.

>                         pr_err("failed to init regmap\n");
>                         return PTR_ERR(regmap);
>                 }
> --
> 2.17.1
>


-- 
Baolin Wang
Best Regards

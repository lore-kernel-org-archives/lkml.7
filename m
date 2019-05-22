Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B86C18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE4217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 02:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YENWXgYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfEVCHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 22:07:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33161 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfEVCHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:07:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id q186so429523oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 19:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PW2Ksp4dF+kCYGO2bVRBw5OwUH5NVUnvQm1hs6EDl6g=;
        b=YENWXgYBjKoO0LJUuXsbbL9ODcCAtlfjp9Zm6wsARsbNfeRLCI23TVVM3BF/uL00AM
         BLgVZdXe7kq0jzXclwNKvS1rTgULLOlEENmBV/Y+o/61bNq4aR4ywl/InH5pmMxoRgKG
         UtXhrd6Fnz0Fi0pKGBV9ETLvcd2AWAcO2iwPkx/iGFhiWPy/N7sHS56TY2e+5RkTzQqE
         7GQnhX7osJRKB6smAWzymNNMQ94E2QRgPyO1WcpHNM9CU0NXQUejAv8hGQXGTOV3qc5L
         5I10NNR7uYkWqWvEpZUQb6pE14tf+vHvR2c8doFRh8z1Rp+dVyi5zTfBZSVoLOPx6w8V
         iCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW2Ksp4dF+kCYGO2bVRBw5OwUH5NVUnvQm1hs6EDl6g=;
        b=bnnPct/GfFGAIXXrXMH7PFv0hopWdOopoVZIFS3rp0C6e1XxgTxsUi49kAUrzBeuDm
         J/P5TW8cQMWVdjEXgxNO5EWjDI9qth+iBP4xcuQaY+TTpUMOyw0gSVAFWqetu/ei6G1i
         H67KhtgDr7IR0upOuW4CQ6XKp6ojig+riefoRPkjdu5wDFC6DcakHC8S2ASq/15mNEo3
         dbAgodhNhNQLoQnAFu68lytK93R9Cs8WRjUMPo5R3Sb7wkzQyDZeNRuEAa2M/+BYTzy8
         aCynGAtXozT9Z3Dlkx/DFG04PDSnt1r/QC5jOKVtTs0i1pYRgDxoIR8AJDXjcXXpFrBh
         x/SA==
X-Gm-Message-State: APjAAAU3j+oNwXrOx7A2zyTHLIy0O1Cw5qyrOBzsIHOgP6uuhYnxyiCH
        0ERusOpVg2di99MkIMplHl4U1aY4ghqUp2ulmLgztQ==
X-Google-Smtp-Source: APXvYqxjqcRRR4xBTNMXgyICOQLiOPpbilh/rSzqCR3MbAtsroT4lNBzp+g7xdHt2NeHrKTxYN1cMbG6dh67ig9jpfY=
X-Received: by 2002:aca:d846:: with SMTP id p67mr2797618oig.6.1558490865822;
 Tue, 21 May 2019 19:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190522011504.19342-1-zhang.chunyan@linaro.org> <20190522011504.19342-2-zhang.chunyan@linaro.org>
In-Reply-To: <20190522011504.19342-2-zhang.chunyan@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 22 May 2019 10:07:33 +0800
Message-ID: <CAMz4kuKbw+HHbALGEJaoYvV435-RS7gMzWbmwZekLWdKT=GV7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
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

On Wed, 22 May 2019 at 09:15, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>
> devm_ioremap_resources() automatically requests resources and devm_ wrappers
> do better error handling and unmapping of the I/O region when needed,
> that would make drivers more clean and simple.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/clk/sprd/common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
> index e038b0447206..9ce690999eaa 100644
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
> @@ -50,7 +51,11 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
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
>                 if (IS_ERR_OR_NULL(regmap)) {
> --
> 2.17.1
>


-- 
Baolin Wang
Best Regards

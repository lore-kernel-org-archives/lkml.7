Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59670ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3054C2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izgh3XKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbfJPBfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:35:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33001 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbfJPBfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:35:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so16012432lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAK0ELSb5Txq6hlGzxUJ6nHkFu1g4zycq1EzpQGbhM4=;
        b=izgh3XKFqg2kZAGdfYdAfOhQQ6KpkjI8iTZ8c1Lr8PlQRMAZphydKFz78i+zSDlCSZ
         UT5jsT8AgO7FABZndi3SeybQJpocK1a8s1lx0ntSmyfA5Soy3hfSq5O/AYWB8RfrBOoz
         PAAu8kGYfbYEiDG+UJHdI8QtREm44JM2ifxHjZJZ5wxxDy4vPcnzczyggQaueoQWLuhV
         AB4yexBVZ/OavmFHVuFZ74e0CPoXPldOBKZZs2sCk6Ukpzf1+F4XOXgXbx4TkPv0TF0m
         FMGpa7XbKjTxEzdFnF0iIGulhptYSLodMrsV4MTy9cAcDDSWtSXkh9C1dybVb2KqIuQB
         Pa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAK0ELSb5Txq6hlGzxUJ6nHkFu1g4zycq1EzpQGbhM4=;
        b=akAOGLhAfBqZ0RHE99N03dGE1ab3wv7TGGoOZHyKke83sAK3xe+me8H1qfnc+M2hsA
         DbXgUq9yzWmN8NJuWEgokavkGFvoQ7TFrkUHSXcFSM234y+zach0Se7raTnlVKzTnoBZ
         vliVt6Jmu6FxvZ10ugQ9E8hbepW6FsYvL5MxMTabA/6aSsxn+VsgQoSIIjwybrI7PLlS
         f/uutcSew236qpf34sErCTygFe9qw2Vc8T9vr6u3EWx3f/mFMHzDWKcL+ney4MUgeeNk
         QCYs4VRXVP73PVW3iSCDYY5MXP2ODmAb6mZL0hqDgaGIiohY1Lek/EPu/JgAACWq0Uf0
         ZKFw==
X-Gm-Message-State: APjAAAXrtaQX44w6rqLGUF4TT1tDUzBd+hVkXsiGugm6s8n6Op+Jjtg1
        wVsUkA3VspeVSv/jjG3bJAwCF1ahS0VzQaaUyTFASQ==
X-Google-Smtp-Source: APXvYqyk7m5EdKuiBS0AO5QBu6Ah2Gie2qHdmwJJXHoDUDdkh8c5PFOLmOA8qr27FCuTD1k9eW+WcoN7UwYZBPgSNSA=
X-Received: by 2002:a19:ad4c:: with SMTP id s12mr24153597lfd.49.1571189742556;
 Tue, 15 Oct 2019 18:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191015142144.23544-1-yuehaibing@huawei.com>
In-Reply-To: <20191015142144.23544-1-yuehaibing@huawei.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 16 Oct 2019 09:35:30 +0800
Message-ID: <CAMz4kuKnu5NqeMjtsm3Cinx=FT8Q0BiCqpFaGWULEVXLj7Kk+A@mail.gmail.com>
Subject: Re: [PATCH -next] clk: sprd: use devm_platform_ioremap_resource() to
 simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Oct 2019 at 22:22, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

We already posted a patch to do this, thanks anyway.
https://lore.kernel.org/patchwork/patch/1136894/

> ---
>  drivers/clk/sprd/common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
> index 9d56eac..3718696 100644
> --- a/drivers/clk/sprd/common.c
> +++ b/drivers/clk/sprd/common.c
> @@ -42,7 +42,6 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
>         void __iomem *base;
>         struct device_node *node = pdev->dev.of_node;
>         struct regmap *regmap;
> -       struct resource *res;
>
>         if (of_find_property(node, "sprd,syscon", NULL)) {
>                 regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
> @@ -51,8 +50,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
>                         return PTR_ERR(regmap);
>                 }
>         } else {
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -               base = devm_ioremap_resource(&pdev->dev, res);
> +               base = devm_platform_ioremap_resource(pdev, 0);
>                 if (IS_ERR(base))
>                         return PTR_ERR(base);
>
> --
> 2.7.4
>
>


-- 
Baolin Wang
Best Regards

Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A7C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67168207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DK+uSure"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfFJIod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:44:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38326 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbfFJIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:44:32 -0400
Received: by mail-it1-f193.google.com with SMTP id e25so5713715itk.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VS+cgEF/QUrbLF7DuqoiP4P2XAG1E5uMf3M9NoVhDxc=;
        b=DK+uSuretD7HL2a7vsPPnfX+8oGDG1VU/1GW3bNgb2Ee3mlXI/EOFVpP71A1qCzXmV
         qdq2OtFbX/XHjAVPfppxUcaVS0NKqNSJGPnYsfBuj0fqOQ1QstV+o4rfTetA4URaJBQy
         uoooP6cJSJS5sWkHj/DxE98Nntg/SUyT37V1pSRlpNzgzDJW084gU7ULnySZeBZc0GiQ
         /UqxysPa4zWEXmNTK+aHxuxZEu0Lnx+tNdN7d4AcMHl6cN96/WolqeISR9Yt9qpROthj
         6rK86ggqQAlclsN6bGEHYdS7LfAnNh8jifGC0KHGOdoulTaGk6lNYT20ntnXk+DDjHF1
         /hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VS+cgEF/QUrbLF7DuqoiP4P2XAG1E5uMf3M9NoVhDxc=;
        b=fby5rv26avg/8FoeaAr0GYhNp/yEUs93xzQdQgF834ijwkmZYi7rcnKOEB8KDe+hiz
         OWg1DuWz9PK0dbu6BRaR25WXPhWra9vGqGkkV1xIKY1ic+1s8tCvLrewSsIibLlaRf1q
         2oyXpABAAFqXfXoJGRrdloLuW9F8TAOosNwXRY0t94m3t9JPJyaQNAVbxEW4XJrbK07X
         cws7EuOldYQK4MgY2VPH7nfJ0tO09oKrXiOXfJkOfbqlwBlXretLxirzjtL1rAAK9xeC
         0H3V1bmKB+VZl3PNSHqe8mStTKi7Hfun8ha9/+tszv/6kpIUWbokLhYK1B+KmnUZtLUp
         YO+g==
X-Gm-Message-State: APjAAAU7yF2B4k6bFcxfo19EIucsPO5UB7Lz87IxTmfdJk632Rpxk9sJ
        oUv4B7u1u4rphJQQIzVq830F1hE6u0ThqBAj7n8MmA==
X-Google-Smtp-Source: APXvYqyFs/Qz/+BC0ZDFUppIgbEfWY14++ciL9hJj1GnRU8+kHd3W+8xr8lU+QumsR1X+b0RC4Ha2EIH/Cvf+6SH3Ws=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr44208035jar.2.1560156271880;
 Mon, 10 Jun 2019 01:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190610084213.1052-1-lee.jones@linaro.org>
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Jun 2019 10:44:19 +0200
Message-ID: <CAKv+Gu9UYQmPS0UxYztNTiFLYA1kqtL4HxttqFQovc26hffwmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        wsa+renesas@sang-engineering.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 at 10:42, Lee Jones <lee.jones@linaro.org> wrote:
>
> Add a match table to allow automatic probing of ACPI device
> QCOM0220.  Ignore clock attainment errors.  Set default clock
> frequency value.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index db075bc0d952..9e3b8a98688d 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> @@ -483,6 +484,14 @@ static const struct i2c_algorithm geni_i2c_algo = {
>         .functionality  = geni_i2c_func,
>  };
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id geni_i2c_acpi_match[] = {
> +       { "QCOM0220"},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
> +#endif
> +
>  static int geni_i2c_probe(struct platform_device *pdev)
>  {
>         struct geni_i2c_dev *gi2c;
> @@ -502,7 +511,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                 return PTR_ERR(gi2c->se.base);
>
>         gi2c->se.clk = devm_clk_get(&pdev->dev, "se");
> -       if (IS_ERR(gi2c->se.clk)) {
> +       if (IS_ERR(gi2c->se.clk) && !has_acpi_companion(&pdev->dev)) {
>                 ret = PTR_ERR(gi2c->se.clk);
>                 dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
>                 return ret;
> @@ -516,6 +525,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
>                 gi2c->clk_freq_out = KHZ(100);
>         }
>
> +       if (has_acpi_companion(&pdev->dev))
> +               ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(&pdev->dev));
> +
>         gi2c->irq = platform_get_irq(pdev, 0);
>         if (gi2c->irq < 0) {
>                 dev_err(&pdev->dev, "IRQ error for i2c-geni\n");
> @@ -660,6 +672,7 @@ static struct platform_driver geni_i2c_driver = {
>                 .name = "geni_i2c",
>                 .pm = &geni_i2c_pm_ops,
>                 .of_match_table = geni_i2c_dt_match,
> +               .acpi_match_table = ACPI_PTR(geni_i2c_acpi_match),
>         },
>  };
>
> --
> 2.17.1
>

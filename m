Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945F921A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hq/EKDlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfJCKBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:01:42 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41517 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbfJCKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:01:40 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so1270255vsr.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6B+E5RivcC5owz7oFA9AYi1iwjoiCE7P7xcMi6UgLa0=;
        b=hq/EKDlVT66/mmZ8X58aU7DGkBtQoN38XbVyMTmedpHFhNBWSXRua2vJ8cs7mp0mXW
         TuFkXknq5YLy2qnKHYeEUDrqQg4f9De83VAASuIknveh1oV7kMa+kUGD6Pjh5Mf+l3ai
         0yG+gbXTjTu+xTj2AHaNQ54Ga5TBXI9v7l4CGR0xH23+KFgFwUzqN3EopiOH0ws4wrge
         lfigp/bs/NBuqwTWgcnwhrmB2VydJvzv9MXxC7OzhNL0JEdwf241/HE7pusy+9qgoWQP
         zOgNV8kWFOmDsqTzeSHfQkTbZ/B0NkUO/ywFMB0Lwoi3daYmW1bZGkXDEMJ3lm7jLZZ0
         vIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6B+E5RivcC5owz7oFA9AYi1iwjoiCE7P7xcMi6UgLa0=;
        b=bSNKwoJIQ2CQvnMEcIgtCcSUjXaDZeFGsytr3B7dcS3WHpFtTqivbx+iMrEjFkDsD4
         57pGbQWXPzeNEDUtFzI2sv9RDqyBuBJS3X/cC0acLa9/eJywKnbklLq2FHr2kKPQ1Nxh
         u0mWMo3M1DGkQkU5aLkQJ8JHviFYDVRCpja4mTnbLKbnZFKCg3UbdzHOPeAMNRhHwNDu
         IoFWPy6v3y/ceN3/qInCDdi9moQv2lSzXw7vbaOfTGC7K5NyA4PRbjxtWQ5mRimBvKxQ
         jzQ+TtHew/5zJayBaouCW7XVRM+inw5puDIN78yoNw1AUTeXyjCt+VsWJr4qF8yAVihX
         Ic+g==
X-Gm-Message-State: APjAAAXIS0tU1YIgYAySPZmaOmRY0Gyokm7erFWfRr+/dOfd8kpIBfsC
        Y9rPIEtl4WVlDw3S4j1aJMm+9qB/55MGvUMMyrqSZQ==
X-Google-Smtp-Source: APXvYqzlwi4amB7UdX5f2PKpwQatyFRQoBhnTFgxEQxEattFx/iQqKHcqAKAacBmYgLaUplhc/Bvnw0AfD5cC3bxSNI=
X-Received: by 2002:a67:eb84:: with SMTP id e4mr4472823vso.165.1570096899417;
 Thu, 03 Oct 2019 03:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:01:03 +0200
Message-ID: <CAPDyKFo3+uAYr-j_qmBMeqO9TsY8PFv2J0kzAi56LYWe+E-o9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019 at 17:46, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
> controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/owl-mmc.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> new file mode 100644
> index 000000000000..12b40213426d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/owl-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoCs SD/MMC/SDIO controller
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: actions,owl-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: mmc
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - dmas
> +  - dma-names
> +
> +examples:
> +  - |
> +    mmc0: mmc@e0330000 {
> +        compatible = "actions,owl-mmc";
> +        reg = <0x0 0xe0330000 0x0 0x4000>;
> +        interrupts = <0 42 4>;
> +        clocks = <&cmu 56>;
> +        resets = <&cmu 23>;
> +        dmas = <&dma 2>;
> +        dma-names = "mmc";
> +        bus-width = <4>;
> +    };
> +
> +...
> --
> 2.17.1
>

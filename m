Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B38C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA69B2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569596399;
	bh=4ZeYZF5rfbOcG858xzs2UwUFuWnyzoDXLMnGJ65sEOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iOD+mhUbna37WvBAiYIs6Us8dvOlyb3Mj6LfsNLmRqofhhT96CWuxzrqf2bJpckGD
	 JoCSSQmm1VeSJxucIY9NghaDQ0H3WY4wpTJPhPu/q+YHvdtC69qmxR0Rer6G2n3ms6
	 4hVlDHguPeIvJ5hQeZtjUxTCNiFf5T6gSkqOyAIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfI0O77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfI0O77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:59:59 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6829621850;
        Fri, 27 Sep 2019 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569596397;
        bh=4ZeYZF5rfbOcG858xzs2UwUFuWnyzoDXLMnGJ65sEOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eOebfeeBI4f0mYoksJW1Y9n3kCLeskoOArGkJBt8tBWzHKTGpdq3YXxTW645sqMdO
         DfBbu/KsaKFO0OEGtzThnSXQNYIhGWX+4Bt5+SCzTRm2nzvNLv56BYz9SG2trR4+9n
         m4zEeAH1bnMU+V0A4RkoEu394mYdEGuT7dH3Kt3c=
Received: by mail-lj1-f171.google.com with SMTP id m7so2836524lji.2;
        Fri, 27 Sep 2019 07:59:57 -0700 (PDT)
X-Gm-Message-State: APjAAAXn7iBCWhH/Jg/rqNtCIlPeUq++v5PE12xdSFUcG77F3rNEQYAQ
        kXiWrN5//SBocpDJIUxRsmmIReu/L7YsGBk9WhE=
X-Google-Smtp-Source: APXvYqyfR4W0pf9jJu2HbF52tES3d61o9HB32ILl9iSDh6Qefr/bZ3EwJ3A3TAx3XoN+Yim9v2KMdTelKqFcDQfA3zc=
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr3207763ljc.210.1569596395620;
 Fri, 27 Sep 2019 07:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190927143314eucas1p2d419866cd740207426cd37cb6fdff468@eucas1p2.samsung.com>
 <20190927143306.12133-1-m.szyprowski@samsung.com>
In-Reply-To: <20190927143306.12133-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 27 Sep 2019 16:59:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdbDropa0iL6YP4Fb4aFSEXQ87thOk5mN+cSCU=i+ZwUw@mail.gmail.com>
Message-ID: <CAJKOXPdbDropa0iL6YP4Fb4aFSEXQ87thOk5mN+cSCU=i+ZwUw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: gpu: Convert Samsung Image Scaler to dt-schema
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 at 16:33, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> From: Maciej Falkowski <m.falkowski@samsung.com>
>
> Convert Samsung Image Scaler to newer dt-schema format.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v3:
> - Fixed description of 'clocks' property:
> rather than 'mscl clock', 'pclk clock'
> - Added empty line within if-else statement
> - Added 'additionalProperties: false'
> - Listed all missing 'properties' in properties scope
>
> Best regards,
> Maciej Falkowski
> ---
>  .../bindings/gpu/samsung-scaler.txt           | 27 -------
>  .../bindings/gpu/samsung-scaler.yaml          | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
>
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt b/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> deleted file mode 100644
> index 9c3d98105dfd..000000000000
> --- a/Documentation/devicetree/bindings/gpu/samsung-scaler.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* Samsung Exynos Image Scaler
> -
> -Required properties:
> -  - compatible : value should be one of the following:
> -       (a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
> -       (b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
> -
> -  - reg : Physical base address of the IP registers and length of memory
> -         mapped region.
> -
> -  - interrupts : Interrupt specifier for scaler interrupt, according to format
> -                specific to interrupt parent.
> -
> -  - clocks : Clock specifier for scaler clock, according to generic clock
> -            bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
> -
> -  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
> -                 on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
> -
> -Example:
> -       scaler@12800000 {
> -               compatible = "samsung,exynos5420-scaler";
> -               reg = <0x12800000 0x1294>;
> -               interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&clock CLK_MSCL0>;
> -               clock-names = "mscl";
> -       };
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> new file mode 100644
> index 000000000000..5317ac64426a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/samsung-scaler.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC Image Scaler
> +
> +maintainers:
> +  - Inki Dae <inki.dae@samsung.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos5420-scaler
> +      - samsung,exynos5433-scaler
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks: {}
> +  clock-names: {}
> +  iommus: {}
> +  power-domains: {}
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: samsung,exynos5420-scaler
> +
> +then:
> +  properties:
> +    clocks:
> +      items:
> +        - description: mscl clock
> +
> +    clock-names:
> +      items:
> +        - const: mscl
> +
> +else:
> +  properties:
> +    clocks:
> +      items:
> +        - description: pclk clock
> +        - description: aclk clock
> +        - description: aclk_xiu clock
> +
> +    clock-names:
> +      items:
> +        - const: pclk
> +        - const: aclk
> +        - const: aclk_xiu
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos5420.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    scaler@12800000 {
> +        compatible = "samsung,exynos5420-scaler";
> +        reg = <0x12800000 0x1294>;
> +        interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clock CLK_MSCL0>;
> +        clock-names = "mscl";
> +    };
> +
> +...

You have some left-overs at the end. With cleaning them:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

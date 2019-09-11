Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED029ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67D6207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568183224;
	bh=psIls2uZnyD8aULtZ7ZdVGeCU/oXNQFs5fNTc8c37BA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nHHG79Rk8DuKZkyRabuoYtUyzDTtkD3rXm1ArBGV9lyLo/FrE2P+HFzyA8DF3CmKT
	 w/hFxsKa0ct4fgdOkrW1GqqtqUBjj1i8kLUmA/67sw++9daX8j8DVWLwa80hCc9LmB
	 MNubK6bFYsZ60/Uzu/5AYgRhNNAGABc2ZmXyaUVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfIKG1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfIKG1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:27:03 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A9E21A4C;
        Wed, 11 Sep 2019 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568183221;
        bh=psIls2uZnyD8aULtZ7ZdVGeCU/oXNQFs5fNTc8c37BA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0wMnm6NSoAMi4ZwyIgCyMisByOfANk0tvatkgryTmkxOSrv3jXOpXZLn7Ko3bPXf4
         6+JXVdbfmTTwqBLextfHlDBS37zoErULbbdXanfJn/J2AzeH0Az+4LqiIVakky+IG+
         IiGgPAaO9o1d2JwLCXsRmTkxzEwi/EHSxGSbZOK0=
Received: by mail-lj1-f180.google.com with SMTP id 7so18789245ljw.7;
        Tue, 10 Sep 2019 23:27:01 -0700 (PDT)
X-Gm-Message-State: APjAAAXA37AxumEwjNivVNVL/BoAbBW1tmxQa6oJe8prZ7KKguVi1Woc
        EuNxtLISdBSjnEnIRmjV93OhyUkOeBg+y/razeQ=
X-Google-Smtp-Source: APXvYqw0KGJTsVber/DyRaso03CZ5aKuQemCVWi2hKR4ZyaBju2pa7/7LE+9HaukTekenCqVV1/A8KN8u5yhz6EDxdM=
X-Received: by 2002:a2e:b4e3:: with SMTP id s3mr22848863ljm.143.1568183219643;
 Tue, 10 Sep 2019 23:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190910155240eucas1p26b343fd58e0f7b7fbe8dae06fe565de7@eucas1p2.samsung.com>
 <CAJKOXPf9zBSPnQgm0tVA_6N+mgR7xiCskf8JUOmQMG8C+jF8pA@mail.gmail.com> <20190910155207.6569-1-m.falkowski@samsung.com>
In-Reply-To: <20190910155207.6569-1-m.falkowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 11 Sep 2019 08:26:48 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
Message-ID: <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: arm: samsung: Convert Samsung Exynos
 IOMMU H/W, System MMU to dt-schema
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 at 17:52, Maciej Falkowski <m.falkowski@samsung.com> wrote:
>
> Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
> to newer dt-schema format.
>
> Update clock description.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi Krzysztof,
>
> Thank you for feedback.
>
> New changes:
> - style fixes including missing empty lines,
> deletion of unneeded descriptions
>
> - fix mistake where one example was split
> into two separete ones.
>
> There are some updates with clock description. I have spoken with
> Marek Szyprowski and the right setup for clocks seems to be two pairs:
> "sysmmu" with optional "master" or a pair of "aclk" + "pclk".
>
> The option: "aclk" + "pclk" + "master" was never used in any
> of device bindings and there are none compilation problems with that.
>
> In so, clock-names are rewritten to handle this version
> and maximal clock number is set to two.
>
> Best regards,
> Maciej Falkowski
> ---
>  .../bindings/iommu/samsung,sysmmu.txt         |  67 -----------
>  .../bindings/iommu/samsung,sysmmu.yaml        | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
>
> diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
> deleted file mode 100644
> index 525ec82615a6..000000000000
> --- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
> -
> -Samsung's Exynos architecture contains System MMUs that enables scattered
> -physical memory chunks visible as a contiguous region to DMA-capable peripheral
> -devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
> -
> -System MMU is an IOMMU and supports identical translation table format to
> -ARMv7 translation tables with minimum set of page properties including access
> -permissions, shareability and security protection. In addition, System MMU has
> -another capabilities like L2 TLB or block-fetch buffers to minimize translation
> -latency.
> -
> -System MMUs are in many to one relation with peripheral devices, i.e. single
> -peripheral device might have multiple System MMUs (usually one for each bus
> -master), but one System MMU can handle transactions from only one peripheral
> -device. The relation between a System MMU and the peripheral device needs to be
> -defined in device node of the peripheral device.
> -
> -MFC in all Exynos SoCs and FIMD, M2M Scalers and G2D in Exynos5420 has 2 System
> -MMUs.
> -* MFC has one System MMU on its left and right bus.
> -* FIMD in Exynos5420 has one System MMU for window 0 and 4, the other system MMU
> -  for window 1, 2 and 3.
> -* M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
> -  the other System MMU on the write channel.
> -
> -For information on assigning System MMU controller to its peripheral devices,
> -see generic IOMMU bindings.
> -
> -Required properties:
> -- compatible: Should be "samsung,exynos-sysmmu"
> -- reg: A tuple of base address and size of System MMU registers.
> -- #iommu-cells: Should be <0>.
> -- interrupts: An interrupt specifier for interrupt signal of System MMU,
> -             according to the format defined by a particular interrupt
> -             controller.
> -- clock-names: Should be "sysmmu" or a pair of "aclk" and "pclk" to gate
> -              SYSMMU core clocks.
> -              Optional "master" if the clock to the System MMU is gated by
> -              another gate clock other core  (usually main gate clock
> -              of peripheral device this SYSMMU belongs to).
> -- clocks: Phandles for respective clocks described by clock-names.
> -- power-domains: Required if the System MMU is needed to gate its power.
> -         Please refer to the following document:
> -         Documentation/devicetree/bindings/power/pd-samsung.txt
> -
> -Examples:
> -       gsc_0: gsc@13e00000 {
> -               compatible = "samsung,exynos5-gsc";
> -               reg = <0x13e00000 0x1000>;
> -               interrupts = <0 85 0>;
> -               power-domains = <&pd_gsc>;
> -               clocks = <&clock CLK_GSCL0>;
> -               clock-names = "gscl";
> -               iommus = <&sysmmu_gsc0>;
> -       };
> -
> -       sysmmu_gsc0: sysmmu@13e80000 {
> -               compatible = "samsung,exynos-sysmmu";
> -               reg = <0x13E80000 0x1000>;
> -               interrupt-parent = <&combiner>;
> -               interrupts = <2 0>;
> -               clock-names = "sysmmu", "master";
> -               clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
> -               power-domains = <&pd_gsc>;
> -               #iommu-cells = <0>;
> -       };
> diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
> new file mode 100644
> index 000000000000..85d1a251f2ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/samsung,sysmmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
> +
> +maintainers:
> +  - Marek Szyprowski <m.szyprowski@samsung.com>
> +
> +description: |+
> +  Samsung's Exynos architecture contains System MMUs that enables scattered
> +  physical memory chunks visible as a contiguous region to DMA-capable peripheral
> +  devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
> +
> +  System MMU is an IOMMU and supports identical translation table format to
> +  ARMv7 translation tables with minimum set of page properties including access
> +  permissions, shareability and security protection. In addition, System MMU has
> +  another capabilities like L2 TLB or block-fetch buffers to minimize translation
> +  latency.
> +
> +  System MMUs are in many to one relation with peripheral devices, i.e. single
> +  peripheral device might have multiple System MMUs (usually one for each bus
> +  master), but one System MMU can handle transactions from only one peripheral
> +  device. The relation between a System MMU and the peripheral device needs to be
> +  defined in device node of the peripheral device.
> +
> +  MFC in all Exynos SoCs and FIMD, M2M Scalers and G2D in Exynos5420 has 2 System
> +  MMUs.
> +  * MFC has one System MMU on its left and right bus.
> +  * FIMD in Exynos5420 has one System MMU for window 0 and 4, the other system MMU
> +    for window 1, 2 and 3.
> +  * M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
> +    the other System MMU on the write channel.
> +
> +  For information on assigning System MMU controller to its peripheral devices,
> +  see generic IOMMU bindings.
> +
> +properties:
> +  compatible:
> +    const: samsung,exynos-sysmmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      An interrupt specifier for interrupt signal of System MMU,
> +      according to the format defined by a particular interrupt
> +      controller.

You left this description and it is not needed - does not bring any information.
Add also maxItems as I believe there should be only one interrupt.

> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - contains:
> +          enum:
> +            - sysmmu
> +            - master

This is not specific enough, because it accepts:
clock-names = "master";
clock-names = "aclk";

Instead I think this could work:
oneOf:
  - items:
    - const: sysmmu
  - items:
    - const: sysmmu
    - const: master
  - items:
    - const: aclk
    - const: pclk

Best regards,
Krzysztof

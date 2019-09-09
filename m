Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D9C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A221920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568035159;
	bh=mQl8SFN7L25FSqXgnAwmU/zVUdVkvZll+y2qPF6NdBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sBiOD7Lv5Ap0Qgucu1Nts+Sl7rnqriL5xiVvbGqMEUItcD6l0/wf8V7SEd45k8+Cy
	 Fv7/NGWwS4qy7fIWCI1BLocVLH0zZCZO+tvYMiWmz8WZi4nFCHzN/Hppjppnf1hubb
	 ba6qNsRmX+7Bs48SbwLsBcOwfC0qHURy7pHtJcZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfIINTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbfIINTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:19:14 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45AA2196E;
        Mon,  9 Sep 2019 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568035153;
        bh=mQl8SFN7L25FSqXgnAwmU/zVUdVkvZll+y2qPF6NdBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tVWuIwN1HHBPbhQRDOkNbyTGqjr9PCGG/8TWAVt5GFvaYdo2xPISWwMjj1hS99H/f
         fOsnfKIDwOk10Dw51FUXe5N7uYSn2O5OkiIBRLSqIvyy61LJLtUhinGNPBKQU5/lqe
         /ECCYiehmD49BqJYA2JGacjXIhjEynMqwvAqeRfQ=
Received: by mail-lj1-f170.google.com with SMTP id h2so6197971ljk.1;
        Mon, 09 Sep 2019 06:19:12 -0700 (PDT)
X-Gm-Message-State: APjAAAUp5jwfWmFkmSQMBpIVPQuVU6L79OsqonL2RbWxStwnJL4/XS/+
        AHlcMBunwrAGPmz187JndSFRMOz4avpdJ0f1IDA=
X-Google-Smtp-Source: APXvYqzEm+lTCXudNJeDDxnMUEkTYI4V0epDPo2ZATZU5v3FzYVgDMbshH+KFpdzWIIs77UktbTu7RWqymvZFfBcWcc=
X-Received: by 2002:a2e:b4e3:: with SMTP id s3mr16524934ljm.143.1568035151088;
 Mon, 09 Sep 2019 06:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190909124206eucas1p13e4ffd50a3bbc6f390cb63f11034c34c@eucas1p1.samsung.com>
 <20190909124147.17510-1-m.falkowski@samsung.com>
In-Reply-To: <20190909124147.17510-1-m.falkowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 9 Sep 2019 15:18:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf9zBSPnQgm0tVA_6N+mgR7xiCskf8JUOmQMG8C+jF8pA@mail.gmail.com>
Message-ID: <CAJKOXPf9zBSPnQgm0tVA_6N+mgR7xiCskf8JUOmQMG8C+jF8pA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: samsung: Convert Samsung Exynos IOMMU
 H/W, System MMU to dt-schema
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

On Mon, 9 Sep 2019 at 14:42, Maciej Falkowski <m.falkowski@samsung.com> wrote:
>
> Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
> to newer dt-schema format.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Hi Maciej,

Thanks for the patch. Few comments below.

> ---
>  .../bindings/iommu/samsung,sysmmu.txt         |  67 ------------
>  .../bindings/iommu/samsung,sysmmu.yaml        | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 67 deletions(-)
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
> index 000000000000..6c40dfb86899
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
> @@ -0,0 +1,102 @@
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

Add empty line between properties. Makes it easier to read.

> +  reg:
> +    description: A tuple of base address and size of System MMU registers.

Description not needed.

> +    maxItems: 1
> +  interrupts:
> +    description: |
> +      An interrupt specifier for interrupt signal of System MMU,
> +      according to the format defined by a particular interrupt
> +      controller.

Description not needed.

> +  clocks:
> +    description: Phandles for respective clocks described by clock-names.

Description not needed but I think number of elements is.

> +  clock-names:
> +    description: |
> +      Should be "sysmmu" or a pair of "aclk" and "pclk" to gate
> +      SYSMMU core clocks.
> +      Optional "master" if the clock to the System MMU is gated by
> +      another gate clock other core  (usually main gate clock
> +      of peripheral device this SYSMMU belongs to).
> +    minItems: 1
> +    maxItems: 2

Based on the description this can be up to three clocks.

Please declare the exact items within each combination (so either
sysmmu or aclk+pclk, plus optional master?). If this does not depend
on compatible, then oneOf could work. Then number of items could be
removed.

> +  "#iommu-cells":
> +    const: 0
> +    description: Should be <0>.

Description not needed.

> +  power-domains:

$ref: /schemas/types.yaml#/definitions/phandle

> +    description: |
> +      Required if the System MMU is needed to gate its power.
> +      Please refer to the following document:
> +      Documentation/devicetree/bindings/power/pd-samsung.txt
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#iommu-cells"
> +
> +examples:
> +  - |
> +    gsc_0: gsc@13e00000 {
> +      compatible = "samsung,exynos5-gsc";
> +      reg = <0x13e00000 0x1000>;
> +      interrupts = <0 85 0>;
> +      power-domains = <&pd_gsc>;
> +      clocks = <&clock 0>; //CLK_GSCL0

Missing space after //

> +      clock-names = "gscl";
> +      iommus = <&sysmmu_gsc0>;
> +    };
> +  - |

This is one example, not two.

Best regards,
Krzysztof

> +    sysmmu_gsc0: sysmmu@13e80000 {
> +      compatible = "samsung,exynos-sysmmu";
> +      reg = <0x13E80000 0x1000>;
> +      interrupt-parent = <&combiner>;
> +      interrupts = <2 0>;
> +      clock-names = "sysmmu", "master";
> +      clocks = <&clock 0>, // CLK_SMMU_GSCL0
> +               <&clock 0>; // CLK_GSCL0
> +      power-domains = <&pd_gsc>;
> +      #iommu-cells = <0>;
> +    };
> +
> --
> 2.17.1
>

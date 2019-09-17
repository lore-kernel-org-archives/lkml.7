Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA9C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591EA20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568748080;
	bh=9O5/O/xdFiEJ+XAgP8KWNMcq+OJ+tHhyRsVKBp/1RJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DGHG8HSmlRNoNLkaSaTrtC0PA0rqkO2Z85v+RhO1OXXrQw3Bo4VA7Y+KwLq0RByx8
	 gGNjzQfQoDiO8OX5xBiS7dfX0AqbChX84UQ8Ro021PwKM45BlpvqekQ28I+L2Jpk/6
	 FV5Fd49T7ZuxqXc4uhlWmQ/fkm8Nemi6ULaJ+YSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfIQTVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:21:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36325 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQTVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:21:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so4125634oto.3;
        Tue, 17 Sep 2019 12:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Ds6nWlkJC97Nda/xH2S888/WsQPdCLqzuaXV2zwqb4=;
        b=nYiZOiWeyGEsQ4On1X4XyW8tIvsGiWwaBb2/mOZUqBvyDP0NvnySjB/tgsbeBe0h94
         OG/1Ngt1YnKzUwSi9Pz0aRNgPceevb229a3jLKdlwole0giLf0BDUdJVjfFBrJhytDUK
         umXkhlXvUpZ1T6VpaM1CJN6veIXd/AAIB/ZdY/y7aqXBpAc8fHPST6HgoSGNHCFcDuh3
         /j4+78vsDn0Sel8Ze812hYesiFx1+cCq+RX8IlM5T283hMC7APRgO06QLdW8D+MNqr/6
         +/xPUTQTdikGBQhNISQEeNJCPJBBWGY6B18uwmbOC6ZMyZ3j/2esAs3LgzRA/WPN1F6b
         XbmQ==
X-Gm-Message-State: APjAAAUHVl/jat35Q+H3186itmbNSKLvai0DfOEkuTjjdReGgFCORHy1
        uvh1D5R895d/JOjhk6srPg==
X-Google-Smtp-Source: APXvYqzswee2sX+bwR0NjZlxb8tP1hCswuxS1CiVafCjl79ua5B5TaN5ND7JBbjV1CcpX2drPxap9Q==
X-Received: by 2002:a05:6830:13d6:: with SMTP id e22mr405845otq.280.1568748075033;
        Tue, 17 Sep 2019 12:21:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j21sm956728otl.70.2019.09.17.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 12:21:14 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:21:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        mark.rutland@arm.com, m.szyprowski@samsung.com, a.hajda@samsung.com
Subject: Re: [PATCH v3] dt-bindings: arm: samsung: Convert Samsung Exynos
 IOMMU H/W, System MMU to dt-schema
Message-ID: <20190917192113.GA26604@bogus>
References: <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
 <CGME20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237@eucas1p2.samsung.com>
 <20190911110446.32058-1-m.falkowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911110446.32058-1-m.falkowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 01:04:46PM +0200, Maciej Falkowski wrote:
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
> v3:
> 
> - remove obsolete interrupts description and
> set its maxItems to one. There are some incompatible
> files which will be fixed with another patch.
> 
> - clock-names pattern is changed to your more precise 
> version. I also added option "pclk" + "aclk" as some
> bindings are also using it.
> 
> Best regards,
> Maciej Falkowski
> ---
>  .../bindings/iommu/samsung,sysmmu.txt         |  67 -----------
>  .../bindings/iommu/samsung,sysmmu.yaml        | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml


> diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.yaml
> new file mode 100644
> index 000000000000..a8141d6c326a
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
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +        - const: sysmmu
> +      - items:
> +        - const: sysmmu
> +        - const: master
> +      - items:
> +        - const: aclk
> +        - const: pclk
> +      - items:
> +        - const: pclk
> +        - const: aclk

Sigh. I'd prefer you fix the order in whichever case is less common.

> +    description: |
> +      Should be "sysmmu" with optional "master"
> +      or a pair "aclk" with "pclk".

No need to describe what the schema already says.

> +
> +  "#iommu-cells":
> +    const: 0
> +
> +  power-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle

No need to define common property types.

Just 'maxItems: 1' is enough.

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
> +      clocks = <&clock 0>; // CLK_GSCL0
> +      clock-names = "gscl";
> +      iommus = <&sysmmu_gsc0>;
> +    };
> +
> +    sysmmu_gsc0: sysmmu@13e80000 {

This should be:

iommu@...

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

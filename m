Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40850C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1121B2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569338041;
	bh=njnZUbW5nCHZlpdfKWu4f74vj7J2zRd+CgAgJGCk7uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o3B9HN0cZVK0lI28Gg1O3Q+G5s9/Q3gFmRfDZZC09DANXmPK7fum8FQmrgODjHd6w
	 UwIz6Gj/NnxzUAW1OTmXMiimkSYKeol2UjxxFa2ozvchPSHtSF91pI9TUzgWUVmYHb
	 cQAxuzXEWGeBYVtI6KDGXoOhQhXijHDqBlhMiNbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfIXPOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:14:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33281 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfIXPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:13:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so2405012wrs.0;
        Tue, 24 Sep 2019 08:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=coBOjUYllsgCSM3XkBr7tQiqGi8Er2n8uVoWjDntFHI=;
        b=RqMg7RjT7HKjb9msaYlh2zU7H/kbSpoUJdZtM/m8yFAhBJtHAdboUihcm4LYnD7Gto
         9exf6FL8drdxu8cyC2mdZ+ZqJ+O9stQAveKrdRPbHGKvAKES+yZ0pM3BDYz0NMaX8LXa
         wcCER6KW9aEe44CCrhhVlX/khGRqbq5QKUViY5p81VF8bHoVUMgmRfndNOMAfaylFchc
         r82kfCKyxDZbpAy0GymBKIvqMolwQLPADTh05aTjJBUon/pSCieg9ZkVzuOwX43NHl6V
         8R79kolE94PxA4UdxCwvK1HNjnrNNAwhSqv/NfUJ+pUYlrEdzqWjCUxR0ojmToINWdp/
         QOeQ==
X-Gm-Message-State: APjAAAWgQPW+AvwgcdZg6Vyy7klw4PJBSbT8qfZsa8S1dl/gxGJ65Fk8
        US3IuW1kgbuJbJpgvndvnb8=
X-Google-Smtp-Source: APXvYqwYAhT1KP4wwPFsQJ6D3DukTCnqvH+HD/vm3yBh0jAByvQCpK8OR6geDKG8e7OCSpW73nEaAA==
X-Received: by 2002:adf:f303:: with SMTP id i3mr2742770wro.242.1569338036499;
        Tue, 24 Sep 2019 08:13:56 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id x2sm3070208wrn.81.2019.09.24.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 08:13:55 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:13:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung 2D Graphics
 Accelerator to dt-schema
Message-ID: <20190924151351.GC9218@pi3>
References: <CGME20190924134628eucas1p1586ca3285dac6b5d5cd1026ea78c436e@eucas1p1.samsung.com>
 <20190924134614.13371-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924134614.13371-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 03:46:14PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung 2D Graphics Accelerator to newer dt-schema format
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - Added if-then statements for 'clocks' and 'clock-names'
> properties.
> 
> Best regards,
> Maciej Falkowski
> ---
>  .../devicetree/bindings/gpu/samsung-g2d.txt   | 27 -------
>  .../devicetree/bindings/gpu/samsung-g2d.yaml  | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt b/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
> deleted file mode 100644
> index 1e7959332dbc..000000000000
> --- a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* Samsung 2D Graphics Accelerator
> -
> -Required properties:
> -  - compatible : value should be one among the following:
> -	(a) "samsung,s5pv210-g2d" for G2D IP present in S5PV210 & Exynos4210 SoC
> -	(b) "samsung,exynos4212-g2d" for G2D IP present in Exynos4x12 SoCs
> -	(c) "samsung,exynos5250-g2d" for G2D IP present in Exynos5250 SoC
> -
> -  - reg : Physical base address of the IP registers and length of memory
> -	  mapped region.
> -
> -  - interrupts : G2D interrupt number to the CPU.
> -  - clocks : from common clock binding: handle to G2D clocks.
> -  - clock-names : names of clocks listed in clocks property, in the same
> -		  order, depending on SoC type:
> -		  - for S5PV210 and Exynos4 based SoCs: "fimg2d" and
> -		    "sclk_fimg2d"
> -		  - for Exynos5250 SoC: "fimg2d".
> -
> -Example:
> -	g2d@12800000 {
> -		compatible = "samsung,s5pv210-g2d";
> -		reg = <0x12800000 0x1000>;
> -		interrupts = <0 89 0>;
> -		clocks = <&clock 177>, <&clock 277>;
> -		clock-names = "sclk_fimg2d", "fimg2d";
> -	};
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> new file mode 100644
> index 000000000000..5e05e8ccc83f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/samsung-g2d.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC 2D Graphics Accelerator
> +
> +maintainers:
> +  - Inki Dae <inki.dae@samsung.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s5pv210-g2d    # in S5PV210 & Exynos4210 SoC
> +      - samsung,exynos4212-g2d # in Exynos4x12 SoCs
> +      - samsung,exynos5250-g2d
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +

I think it is worth to leave the clocks and clock-names here (could be
empty or with min/max values for number of items). This makes it easy to
find the properties by humans.

Midgard bindings could be used as example.

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos5250-g2d
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: fimg2d clock
> +        clock-names:
> +          items:
> +            - const: fimg2d
> +
> +  - if:

else:

Best regards,
Krzysztof

> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,s5pv210-g2d
> +              - samsung,exynos4212-g2d
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: sclk_fimg2d clock
> +            - description: fimg2d clock
> +        clock-names:
> +          items:
> +            - const: sclk_fimg2d
> +            - const: fimg2d
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    g2d@12800000 {
> +        compatible = "samsung,s5pv210-g2d";
> +        reg = <0x12800000 0x1000>;
> +        interrupts = <0 89 0>;
> +        clocks = <&clock 177>, <&clock 277>;
> +        clock-names = "sclk_fimg2d", "fimg2d";
> +    };
> +
> -- 
> 2.17.1
> 
> 
> 

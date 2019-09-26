Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F3BC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20746222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569506603;
	bh=o1dyQkkrr9e8ZHHJEYG+ymhUQycxWtpIZC6xQCuNjGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aD3uIhOb1GjQSFt0xqio7KY+87qEzOjOwfc3Y8v2WiAW0xcerkWuak5cE9o4aTqoA
	 k8/59u94naEN1mC96VlErSuapKkP+zSP27IYzBkvaa21nQMf+sJQAr1/yhZy3BSKut
	 KTelZ6Qt3rE1p6SjKBGFjTJ9ulaWU+HA2z7w2OAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfIZODW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:03:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51332 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfIZODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:03:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so2933323wme.1;
        Thu, 26 Sep 2019 07:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=whPrRyPjsEqHWkxa6+82YRMbs+ju315F0WTkmuF7zX0=;
        b=jabbRHfDsxfiZus/YT79T2RsfbL4uvDDHBQYq42FPVNxAtCsHrmVQhweCTPEiI/0kV
         U5TrrMRxVttNJAmTehh+UMhUflj7JHg3w97j6RKBTCDOdl8NBhlc8dFPHbIgxZLM8FZs
         Vcr9/EBsO6Zy8dQvxBPGJWrCDpYsZimlsGttNdOHPaC0rNSvJcfnAgFFOC9wfqwwuYDh
         m2Ww/Pg3SM9hSFAalJPytaQDGPCT+/wgKV5WW1s4BSzpwd358qA/fSa/lFCIl0wEiJtn
         h4xw99Q+D46vmwzuJ+uv97+Ttco7wXU3lX33UDuC14A0hwosWpnEnW9u4PLYU8EcmBBr
         1xrQ==
X-Gm-Message-State: APjAAAVEeJnDX8HrtvRFXMgIpMJAQ6JhG3F+iS0Nw1pnCeiginkA60BE
        EO9FOcgvpGctbbbddhuOvRY=
X-Google-Smtp-Source: APXvYqxutZ0PT8G8gSdQw4WLyXOS4Wq+Cx+VZuTbGEsy/pHe5AeTxJAfOIoBfUt9umTYCNT654tX3A==
X-Received: by 2002:a1c:9e0b:: with SMTP id h11mr3039065wme.144.1569506598528;
        Thu, 26 Sep 2019 07:03:18 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id y186sm4789915wmd.26.2019.09.26.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 07:03:17 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:03:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Scaler to
 dt-schema
Message-ID: <20190926140315.GA16002@pi3>
References: <CGME20190926125619eucas1p249ac149ef1e1a3eb975dae94b08cd7be@eucas1p2.samsung.com>
 <20190926125614.10408-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926125614.10408-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 02:56:14PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung Image Scaler to newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - Removed quotation marks from string in 'compatible' property
> - Added if-then statement for 'clocks' and 'clock-names' property
> - Added include directive to example
> - Added GIC_SPI macro to example
> 
> Best regards,
> Maciej Falkowski
> ---
>  .../bindings/gpu/samsung-scaler.txt           | 27 -------
>  .../bindings/gpu/samsung-scaler.yaml          | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 27 deletions(-)
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
> -	(a) "samsung,exynos5420-scaler" for Scaler IP in Exynos5420
> -	(b) "samsung,exynos5433-scaler" for Scaler IP in Exynos5433
> -
> -  - reg : Physical base address of the IP registers and length of memory
> -	  mapped region.
> -
> -  - interrupts : Interrupt specifier for scaler interrupt, according to format
> -		 specific to interrupt parent.
> -
> -  - clocks : Clock specifier for scaler clock, according to generic clock
> -	     bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
> -
> -  - clock-names : Names of clocks. For exynos scaler, it should be "mscl"
> -		  on 5420 and "pclk", "aclk" and "aclk_xiu" on 5433.
> -
> -Example:
> -	scaler@12800000 {
> -		compatible = "samsung,exynos5420-scaler";
> -		reg = <0x12800000 0x1294>;
> -		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&clock CLK_MSCL0>;
> -		clock-names = "mscl";
> -	};
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> new file mode 100644
> index 000000000000..af19930d052e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> @@ -0,0 +1,71 @@
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

I am repeating myself... leave the clocks and clock-names.

"I think it is worth to leave the clocks and clock-names here (could be
empty or with min/max values for number of items). This makes it easy to
find the properties by humans.

Midgard bindings could be used as example."

> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: samsung,exynos5420-scaler
> +then:
> +  properties:
> +    clocks:
> +      items:
> +        - description: mscl clock
> +
> +    clock-names:
> +      items:
> +        - const: mscl
> +else:
> +  properties:
> +    clocks:
> +      items:
> +        - description: mscl clock
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

Unneeded trailing line.

Best regards,
Krzysztof


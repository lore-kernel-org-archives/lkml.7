Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEECC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39A522CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yVsLm7ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfHUHM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:12:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33024 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfHUHM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:12:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so975970wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=elBvlvo8dX7CqSHYt4p3f0MBViCIJM8tOXmWVg0sLdM=;
        b=yVsLm7ad73L3wG1eKKxmWt/v3Q24RCzOmYmNlsndJr9radZcmScqnvWyTGt+Pbq65k
         47hwU6oUpA9kv8ip96mMhNHg7Iryj9GXfeO4GuogbtFkHCUhIWlHLRg0GNNQBFSpVSgz
         UFj553ZsKzHe8jIZvhSgdHfDewvc+juALmz2OcYT9ayfNdW+/YtMOsM17Sxl6fx+fs65
         r16xc/pcd6cdD17oJQWnC7efiy6BNdaXzEKrPOYh+xRYDuAYO07OUMBBAGD3U7fGmXzw
         YuLHaSJhtwLtgugMZEgGl885DlCW/BpI2VL3AVsfwNJkLdDNVP5OddbQ9Q+0p28+FdRQ
         PSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=elBvlvo8dX7CqSHYt4p3f0MBViCIJM8tOXmWVg0sLdM=;
        b=VE0qO9cqbVUav+gsidwyLY74imEYPNd0JpcqCtqD/Yxr0g8EJM3bw/K8eDP6mYq6Wl
         EzHo86gXUMMvQjhrf0a7O4WD+I2lC8nHTUk7f2og93p27vsUwMVyt5hDZ0QxZfwQEd+o
         SLYn67eCaajy5m23UYTmBFVduhD9l6eSjhnLO6C39MxsOwtIMYk71GzBk6WK/DPd5CZj
         Q870CaoMy+hLrS2G7HzfV69+9SrKQQDNQkMAP8VAJO2sNpL6T2dCwcbv8dV5ffj9AVWJ
         4FBdwvQ7fBZo2HciXOort+DFfpRc5s8g02p6sj8dpfHiupS2df/VavzS9jInF3d33juF
         JYSw==
X-Gm-Message-State: APjAAAUsV8Hlof4g7BrYmJ9GgaOJAyPtZ+Ql60w9cBgUbvXRZxXxzdjP
        hTEpygKsStR+W0G9DhU1pd8OIlxtKCsBHw==
X-Google-Smtp-Source: APXvYqxLbyplT821dmtYErwaOPzAm5WQU+VRxJZpU4EvBJxDCqYmyMNPTWmsCIj8YviVKXyUPH6KIQ==
X-Received: by 2002:a5d:460e:: with SMTP id t14mr40512674wrq.171.1566371571911;
        Wed, 21 Aug 2019 00:12:51 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a142sm2873635wme.2.2019.08.21.00.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 00:12:51 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: Convert Arm Mali Midgard GPU to DT
 schema
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
References: <20190820195959.6126-1-robh@kernel.org>
 <20190820195959.6126-2-robh@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <0ab5959e-fc6c-06c3-a3f1-ea5a1ebef87d@baylibre.com>
Date:   Wed, 21 Aug 2019 09:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820195959.6126-2-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 20/08/2019 21:59, Rob Herring wrote:
> Convert the Arm Midgard GPU binding to DT schema format.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/gpu/arm,mali-midgard.txt         | 119 -------------
>  .../bindings/gpu/arm,mali-midgard.yaml        | 165 ++++++++++++++++++
>  2 files changed, 165 insertions(+), 119 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> deleted file mode 100644
> index 9b298edec5b2..000000000000
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -ARM Mali Midgard GPU
> -====================
> -
> -Required properties:
> -
> -- compatible :
> -  * Must contain one of the following:
> -    + "arm,mali-t604"
> -    + "arm,mali-t624"
> -    + "arm,mali-t628"
> -    + "arm,mali-t720"
> -    + "arm,mali-t760"
> -    + "arm,mali-t820"
> -    + "arm,mali-t830"
> -    + "arm,mali-t860"
> -    + "arm,mali-t880"
> -  * which must be preceded by one of the following vendor specifics:
> -    + "allwinner,sun50i-h6-mali"
> -    + "amlogic,meson-gxm-mali"
> -    + "samsung,exynos5433-mali"
> -    + "rockchip,rk3288-mali"
> -    + "rockchip,rk3399-mali"
> -
> -- reg : Physical base address of the device and length of the register area.
> -
> -- interrupts : Contains the three IRQ lines required by Mali Midgard devices.
> -
> -- interrupt-names : Contains the names of IRQ resources in the order they were
> -  provided in the interrupts property. Must contain: "job", "mmu", "gpu".
> -
> -
> -Optional properties:
> -
> -- clocks : Phandle to clock for the Mali Midgard device.
> -
> -- clock-names : Specify the names of the clocks specified in clocks
> -  when multiple clocks are present.
> -    * core: clock driving the GPU itself (When only one clock is present,
> -      assume it's this clock.)
> -    * bus: bus clock for the GPU
> -
> -- mali-supply : Phandle to regulator for the Mali device. Refer to
> -  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> -
> -- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
> -  for details.
> -
> -- #cooling-cells: Refer to Documentation/devicetree/bindings/thermal/thermal.txt
> -  for details.
> -
> -- resets : Phandle of the GPU reset line.
> -
> -Vendor-specific bindings
> -------------------------
> -
> -The Mali GPU is integrated very differently from one SoC to
> -another. In order to accommodate those differences, you have the option
> -to specify one more vendor-specific compatible, among:
> -
> -- "allwinner,sun50i-h6-mali"
> -  Required properties:
> -  - clocks : phandles to core and bus clocks
> -  - clock-names : must contain "core" and "bus"
> -  - resets: phandle to GPU reset line
> -
> -- "amlogic,meson-gxm-mali"
> -  Required properties:
> -  - resets : Should contain phandles of :
> -    + GPU reset line
> -    + GPU APB glue reset line
> -
> -Example for a Mali-T760:
> -
> -gpu@ffa30000 {
> -	compatible = "rockchip,rk3288-mali", "arm,mali-t760";
> -	reg = <0xffa30000 0x10000>;
> -	interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -	interrupt-names = "job", "mmu", "gpu";
> -	clocks = <&cru ACLK_GPU>;
> -	mali-supply = <&vdd_gpu>;
> -	operating-points-v2 = <&gpu_opp_table>;
> -	power-domains = <&power RK3288_PD_GPU>;
> -	#cooling-cells = <2>;
> -};
> -
> -gpu_opp_table: opp_table0 {
> -	compatible = "operating-points-v2";
> -
> -	opp@533000000 {
> -		opp-hz = /bits/ 64 <533000000>;
> -		opp-microvolt = <1250000>;
> -	};
> -	opp@450000000 {
> -		opp-hz = /bits/ 64 <450000000>;
> -		opp-microvolt = <1150000>;
> -	};
> -	opp@400000000 {
> -		opp-hz = /bits/ 64 <400000000>;
> -		opp-microvolt = <1125000>;
> -	};
> -	opp@350000000 {
> -		opp-hz = /bits/ 64 <350000000>;
> -		opp-microvolt = <1075000>;
> -	};
> -	opp@266000000 {
> -		opp-hz = /bits/ 64 <266000000>;
> -		opp-microvolt = <1025000>;
> -	};
> -	opp@160000000 {
> -		opp-hz = /bits/ 64 <160000000>;
> -		opp-microvolt = <925000>;
> -	};
> -	opp@100000000 {
> -		opp-hz = /bits/ 64 <100000000>;
> -		opp-microvolt = <912500>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> new file mode 100644
> index 000000000000..24c4af74fb8d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/arm,mali-midgard.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Mali Midgard GPU
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  $nodename:
> +    pattern: '^gpu@[a-f0-9]+$'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +             - allwinner,sun50i-h6-mali
> +          - const: arm,mali-t720
> +      - items:
> +          - enum:
> +             - amlogic,meson-gxm-mali
> +          - const: arm,mali-t820
> +      - items:
> +          - enum:
> +             - rockchip,rk3288-mali
> +          - const: arm,mali-t760
> +      - items:
> +          - enum:
> +             - rockchip,rk3399-mali
> +          - const: arm,mali-t860
> +      - items:
> +          - enum:
> +             - samsung,exynos5433-mali
> +          - const: arm,mali-t760
> +
> +          # "arm,mali-t604"
> +          # "arm,mali-t624"
> +          # "arm,mali-t628"
> +          # "arm,mali-t830"
> +          # "arm,mali-t880"
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Job interrupt
> +      - description: MMU interrupt
> +      - description: GPU interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: job
> +      - const: mmu
> +      - const: gpu
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core
> +      - const: bus
> +
> +  mali-supply:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  operating-points-v2: true
> +
> +  "#cooling-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun50i-h6-mali
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +      required:
> +        - clocks
> +        - clock-names
> +        - resets
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,meson-gxm-mali
> +    then:
> +      properties:
> +        resets:
> +          minItems: 2
> +      required:
> +        - resets

The original bindings was wrong, In fact, clocks should be required here aswell.
Same for bifrost and utgard...

Should I send a fixup patch ?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gpu@ffa30000 {
> +      compatible = "rockchip,rk3288-mali", "arm,mali-t760";
> +      reg = <0xffa30000 0x10000>;
> +      interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +             <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +             <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "job", "mmu", "gpu";
> +      clocks = <&cru 0>;
> +      mali-supply = <&vdd_gpu>;
> +      operating-points-v2 = <&gpu_opp_table>;
> +      power-domains = <&power 0>;
> +      #cooling-cells = <2>;
> +    };
> +
> +    gpu_opp_table: opp_table0 {
> +      compatible = "operating-points-v2";
> +
> +      opp@533000000 {
> +        opp-hz = /bits/ 64 <533000000>;
> +        opp-microvolt = <1250000>;
> +      };
> +      opp@450000000 {
> +        opp-hz = /bits/ 64 <450000000>;
> +        opp-microvolt = <1150000>;
> +      };
> +      opp@400000000 {
> +        opp-hz = /bits/ 64 <400000000>;
> +        opp-microvolt = <1125000>;
> +      };
> +      opp@350000000 {
> +        opp-hz = /bits/ 64 <350000000>;
> +        opp-microvolt = <1075000>;
> +      };
> +      opp@266000000 {
> +        opp-hz = /bits/ 64 <266000000>;
> +        opp-microvolt = <1025000>;
> +      };
> +      opp@160000000 {
> +        opp-hz = /bits/ 64 <160000000>;
> +        opp-microvolt = <925000>;
> +      };
> +      opp@100000000 {
> +        opp-hz = /bits/ 64 <100000000>;
> +        opp-microvolt = <912500>;
> +      };
> +    };
> +
> +...
> 
Neil

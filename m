Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70757CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B41214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfJUQSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:18:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:32922 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJUQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:18:22 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iMaNr-0006nu-Mh; Mon, 21 Oct 2019 18:18:15 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 5/7] dt-bindings: sram: Merge Rockchip SRAM bindings into generic
Date:   Mon, 21 Oct 2019 18:18:14 +0200
Message-ID: <3101747.Dqu2aBfdh7@diego>
In-Reply-To: <20191021161351.20789-5-krzk@kernel.org>
References: <20191021161351.20789-1-krzk@kernel.org> <20191021161351.20789-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Oktober 2019, 18:13:49 CEST schrieb Krzysztof Kozlowski:
> The Rockchip SRAM bindings list only compatible so integrate them into
> generic SRAM bindings schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> 
> ---
> 
> Changes since v3:
> 1. New patch
> ---
>  .../bindings/sram/rockchip-smp-sram.txt       | 30 -------------------
>  .../devicetree/bindings/sram/sram.yaml        | 15 ++++++++++
>  2 files changed, 15 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
> 
> diff --git a/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
> deleted file mode 100644
> index 800701ecffca..000000000000
> --- a/Documentation/devicetree/bindings/sram/rockchip-smp-sram.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Rockchip SRAM for smp bringup:
> -------------------------------
> -
> -Rockchip's smp-capable SoCs use the first part of the sram for the bringup
> -of the cores. Once the core gets powered up it executes the code that is
> -residing at the very beginning of the sram.
> -
> -Therefore a reserved section sub-node has to be added to the mmio-sram
> -declaration.
> -
> -Required sub-node properties:
> -- compatible : should be "rockchip,rk3066-smp-sram"
> -
> -The rest of the properties should follow the generic mmio-sram discription
> -found in Documentation/devicetree/bindings/sram/sram.txt
> -
> -Example:
> -
> -	sram: sram@10080000 {
> -		compatible = "mmio-sram";
> -		reg = <0x10080000 0x10000>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		smp-sram@10080000 {
> -			compatible = "rockchip,rk3066-smp-sram";
> -			reg = <0x10080000 0x50>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> index b92e3e10fbfc..1c2d8b0408c0 100644
> --- a/Documentation/devicetree/bindings/sram/sram.yaml
> +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> @@ -68,6 +68,7 @@ patternProperties:
>            - amlogic,meson8-smp-sram
>            - amlogic,meson8b-smp-sram
>            - renesas,smp-sram
> +          - rockchip,rk3066-smp-sram
>            - samsung,exynos4210-sysram
>            - samsung,exynos4210-sysram-ns
>  
> @@ -201,3 +202,17 @@ examples:
>              reg = <0 0x10>;
>          };
>      };
> +
> +  - |
> +    sram@10080000 {
> +        compatible = "mmio-sram";
> +        reg = <0x10080000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        smp-sram@10080000 {
> +            compatible = "rockchip,rk3066-smp-sram";
> +            reg = <0x10080000 0x50>;
> +        };
> +    };
> 





Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0EAC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A23B214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569325467;
	bh=FNHOdKquX3IFa5mBM1mglazG55LFJ9TtI25PBKHKeaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TvbPFARhEyeBBeJ0tG+a2TeYF7PUejuTBkjpaHmRIwHnrKPUrgHaCF1J07NeEAYyu
	 qFUhuPbsDkHMKP8G+vcxa86kElwNGeAgzttuQlnW24TbPy6uII0WyclELvMFuAc2xP
	 MiKL0YCXnhIaFXZ+eNoFcaQJUHWWhUznJsv1ABkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504766AbfIXLo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:44:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51926 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfIXLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:44:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so1900817wme.1;
        Tue, 24 Sep 2019 04:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfE5HSIoy4bnw4tW0uvOE8G/Ux5CpKN6T9ph37iVZUY=;
        b=SmipKaBSMwrNl+MDWdtvDyxMlym+1q/mQ8pzTtrjMLJGQEo52eDglwHoMpkHrJQ8Jj
         ogkX7aX/fA3A/28hHxiB/ronYz/r+mik4NBfK1vlO9KgR2Umo1Pdk+UG3ttWPJisVKG9
         0iEh+7vimqQ5GjpISCvYTJhLjXRjYLyZ+4bKvQoPTISqQ6Q9eVfsppQbCGneJ7C1YAeL
         UGpMpkTWIrs0m+boCv83xhceLAGUWEq1ooIMgXACGEBcLA7kdu+owkQ/qtIUJtyIynCm
         oW34s3bOqU1fXqRP6cxH5cHBaWGL+1Ny/xuxpXeZ0YOoQIh29OUb4SZdwuiyd4l6FpCT
         zhNQ==
X-Gm-Message-State: APjAAAWkOwdIgf4aLHUJ/SzmelIbn8Dbs0ljenr9yfkwX4eIS6S31xhv
        WFK0wHA2JIEriRtAcg4cWl9rOSpi
X-Google-Smtp-Source: APXvYqzqFOsxB9TPB1cUrC0y7KpPMr4n+t9n/heL8MaG21Cbit3fJZ68Rk7z/b8D+BiiSUudc86+2g==
X-Received: by 2002:a05:600c:2311:: with SMTP id 17mr2302023wmo.39.1569325463690;
        Tue, 24 Sep 2019 04:44:23 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id b184sm2319180wmg.47.2019.09.24.04.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:44:22 -0700 (PDT)
Date:   Tue, 24 Sep 2019 13:44:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Inki Dae <inki.dae@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH] dt-bindings: gpu: Convert Samsung 2D Graphics
 Accelerator to dt-schema
Message-ID: <20190924114418.GA9157@pi3>
References: <CGME20190924113225eucas1p131429c7f7e0d520693b89bb2a7d9e211@eucas1p1.samsung.com>
 <20190924113159.24873-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924113159.24873-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 01:31:59PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung 2D Graphics Accelerator to newer dt-schema format
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../devicetree/bindings/gpu/samsung-g2d.txt   | 27 ----------
>  .../devicetree/bindings/gpu/samsung-g2d.yaml  | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 27 deletions(-)
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
>ss diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> new file mode 100644
> index 000000000000..bb0a4bf168cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> @@ -0,0 +1,53 @@
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
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - items: # for Exynos5250 SoC
> +          - const: fimg2d
> +      - items: # for S5PV210 and Exynos4 based SoCs
> +          - const: sclk_fimg2d
> +          - const: fimg2d

Just like in previous conversions ("dt-bindings: gpu: Convert Samsung
Image Scaler to dt-schem") - you need to add here proper if-else
constraints.


Best regards,
Krzysztof


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples
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

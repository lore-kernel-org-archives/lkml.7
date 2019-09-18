Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9E6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C1221906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568803995;
	bh=O/UvnMFn8YkjpKy9CUgVCFPtQ1p7llhMtTCerndVpDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=imBpDhaPrLg/AD/uoz7gzTu4yU6Ri+gBPGe9/WvX8cO2WcPs0OrhX2lhqMBof/j51
	 hhHhA2Iu5pwx1KR5uok4agE2Vz0178dKmMsUTPUf3LGAP3GleydX4SBAB3zRkuFc7O
	 BTdTbi20jxB5Y5aycMwVCu/HPPsfA9bqOH/bW1kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfIRKxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfIRKxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:53:13 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D2021924;
        Wed, 18 Sep 2019 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568803992;
        bh=O/UvnMFn8YkjpKy9CUgVCFPtQ1p7llhMtTCerndVpDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GzIBcwuX1dvo6+Pib7AeQw8CBUzIQPKX7uNfyw4hHGhEqegb49iD3QP7KKqDgIhJb
         H0mbtt+3dJxeu4aNw6rwQvLAf0a2UdPPOBU3dBTpP6C2EET6YLiFEO0S21+OFRQuz3
         +Dkr+xho6TvqN0tKlcAzModpSLrhyz2oPpTQPcl8=
Received: by mail-lj1-f175.google.com with SMTP id l21so5006866lje.4;
        Wed, 18 Sep 2019 03:53:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVgxFo6ybhKEG/59calrgIzER1uV4v15kZPC/T4foyKTOJ4Ksk4
        McHTfjwYvTLPRH6gI1J0Pd3Xx6VlRxXb9SSqGrw=
X-Google-Smtp-Source: APXvYqzmTpbs4iMQpuYHlKIv22TczIe3FZwf5lGn1IC17g2fsgJ8tEyfhDTtkZdvKFCSK1xWqaUtSieVDoazmPngEGY=
X-Received: by 2002:a2e:3806:: with SMTP id f6mr1870674lja.143.1568803990188;
 Wed, 18 Sep 2019 03:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190913094136eucas1p1fd424b5f5a6f0a97b31af54e55fe28c1@eucas1p1.samsung.com>
 <20190913094123.23169-1-m.falkowski@samsung.com>
In-Reply-To: <20190913094123.23169-1-m.falkowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Sep 2019 12:52:58 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcDWtT0RbqmpmjDAZw-gCWppSbZqAjOgcbZUaraT5ethA@mail.gmail.com>
Message-ID: <CAJKOXPcDWtT0RbqmpmjDAZw-gCWppSbZqAjOgcbZUaraT5ethA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpu: Convert Samsung Image Scaler to dt-schema
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, mark.rutland@arm.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 at 11:41, Maciej Falkowski <m.falkowski@samsung.com> wrote:
>
> Convert Samsung Image Scaler to newer dt-schema format.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/gpu/samsung-scaler.txt           | 27 ---------
>  .../bindings/gpu/samsung-scaler.yaml          | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 27 deletions(-)
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
> index 000000000000..ee2caab22977
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> @@ -0,0 +1,57 @@
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
> +      - "samsung,exynos5420-scaler"
> +      - "samsung,exynos5433-scaler"
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: mscl
> +      - items:
> +          - const: pclk
> +          - const: aclk
> +          - const: aclk_xiu
> +    description: |
> +      For exynos scaler it should be:
> +      - "mscl" on Exynos5420
> +      - "pclk", "aclk", "aclk_xiu" on Exynos5433

Hi,

This should be customized with proper if in allOf section.

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
> +examples:
> +  - |
> +    scaler@12800000 {
> +        compatible = "samsung,exynos5420-scaler";
> +        reg = <0x12800000 0x1294>;
> +        interrupts = <0 220 4>; // IRQ_TYPE_LEVEL_HIGH
> +        clocks = <&clock 0>; // CLK_MSCL0
> +        clock-names = "mscl";
> +    };
> +
> --
> 2.17.1
>

Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDA0C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBBD214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568356193;
	bh=QCfwLXArx+PBt2uAmHpq8Q+cTWOUQZK/UmpkuJYlH2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DeBZlHYAGQPfXVq0X/NuqzDBjGlHVZn0wOBcU40ktmNA2/Z7sPr4YXOc3b3SKxXy+
	 yEUCPd6A/2pV+AXJtAtB72Jb0UekCpkSfTKG0UegzFW9ZvlhQy7Z/eVFO9iIS5Vsmh
	 pDJFd8l4zw3h8NN0mHa0fDqlJa3VtPznxQi3lUQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfIMG3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 02:29:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40046 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfIMG3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 02:29:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id m3so1376359wmc.5;
        Thu, 12 Sep 2019 23:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pn2QgivTbeqtu2l0M3XS0fw7E3G3pQp+Hr7YG5Qb+oY=;
        b=GdfZdvmgclv3mS1AIMDO2YPvExh1AKQL0QK2mOrtQ/+0PEIff74k8J3Sivn6mTHIl0
         cURxcDw+VF1B4X0L2RMj8tXYW4m/k+OvhqVx9HTzoqgTOktB/66dbPvU/GXZe7QUIIi5
         yqO75QP7of8INDKE9OYeFs1mUsjigu7gxQQJMVNgIVt4blJt8uNTeccQMo3QgqcBXvrV
         wPBY9JL6A1ONoU1Ip6+xru+khk7m26gKGKEFekgIIzl4cqYxdvL87KTtBd6uSJfgSr5/
         N9pa/NIj3M+SnNESlrcgBl/ZZYoG5e/oKgAS1XIgkCF+kKCtYuK9QeBMMsaZO1cfbiki
         7bLw==
X-Gm-Message-State: APjAAAWuakpa3U5Pp7G8HYGyiCjIPck/pz8hEhQU1xRSFaisNcI1lA/G
        6/GF2aWdVdpUHL8X6QVRg+0=
X-Google-Smtp-Source: APXvYqxsmKCSOQkEnLH1A18YyjWgoTqq4r05C9UlLyHjOJchp4X8cPnGcavBcUQoam2wKeQuPwLPZQ==
X-Received: by 2002:a1c:2883:: with SMTP id o125mr1841777wmo.31.1568356189059;
        Thu, 12 Sep 2019 23:29:49 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id g3sm14751047wrq.64.2019.09.12.23.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 23:29:48 -0700 (PDT)
Date:   Fri, 13 Sep 2019 08:29:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, a.hajda@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v2] dt-bindings: gpu: Convert Samsung Image Rotator to
 dt-schema
Message-ID: <20190913062945.GA10283@pi3>
References: <20190912093315.5744-1-m.falkowski@samsung.com>
 <CGME20190912161550eucas1p2bdc813d46f337f3717bdbfd33bae8d4a@eucas1p2.samsung.com>
 <20190912161538.4321-1-m.falkowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912161538.4321-1-m.falkowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 06:15:38PM +0200, Maciej Falkowski wrote:
> Convert Samsung Image Rotator to newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Just to make it clear, Marek's signed-off should appear for one of
conditions:
 - he contributed some source code to your patch,
 - he took your patch, rebased, send by himself (not a case here, I
   think),
 - he contributed significant ideas, although for this there is a
   "Co-developed-by" tag.

If someone made just review - add Reviewed-by. If someone suggested the
patch - add Suggested-by.

> ---
> v2:
> - add required properties
> - add proper commit recipients
> ---
>  .../bindings/gpu/samsung-rotator.txt          | 28 ----------
>  .../bindings/gpu/samsung-rotator.yaml         | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> deleted file mode 100644
> index 3aca2578da0b..000000000000
> --- a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Samsung Image Rotator
> -
> -Required properties:
> -  - compatible : value should be one of the following:
> -	* "samsung,s5pv210-rotator" for Rotator IP in S5PV210
> -	* "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
> -	* "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
> -	* "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
> -
> -  - reg : Physical base address of the IP registers and length of memory
> -	  mapped region.
> -
> -  - interrupts : Interrupt specifier for rotator interrupt, according to format
> -		 specific to interrupt parent.
> -
> -  - clocks : Clock specifier for rotator clock, according to generic clock
> -	     bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
> -
> -  - clock-names : Names of clocks. For exynos rotator, it should be "rotator".
> -
> -Example:
> -	rotator@12810000 {
> -		compatible = "samsung,exynos4210-rotator";
> -		reg = <0x12810000 0x1000>;
> -		interrupts = <0 83 0>;
> -		clocks = <&clock 278>;
> -		clock-names = "rotator";
> -	};
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
> new file mode 100644
> index 000000000000..96afafe98388
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/samsung-rotator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Image Rotator

Thanks Maciej for working on this.

I am trying to make the names more consistent:
1. For Exynos bindings:
Samsung Exynos SoC xxx yyy zzz

2. For multiple SoCs (S3C, S5P, Exynos etc):
Samsung SoC xxx yyy zzz

Currently the names are mixture of legacy and new names. It is a
nit-pick but makes all bindings look like a part of bigger effort, not
bunch of patches done by random people. :)

If there are no objections, maybe you could change it to:
Samsung SoC Image Rotator

> +
> +maintainers:
> +  - Inki Dae <inki.dae@samsung.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "samsung,s5pv210-rotator"    # for Rotator IP in S5PV210
> +      - "samsung,exynos4210-rotator" # for Rotator IP in Exynos4210
> +      - "samsung,exynos4212-rotator" # for Rotator IP in Exynos4212/4412
> +      - "samsung,exynos5250-rotator" # for Rotator IP in Exynos5250

The comments are duplicating the compatible, so skip them.

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      Clock specifier for rotator clock according to generic clock
> +      bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)

Skip the description. Clocks property is a well-known binding.

> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +    - const: rotator
> +    maxItems: 1

I think there is no need to maxItems since all possible items are fixed.

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
> +    rotator@12810000 {
> +        compatible = "samsung,exynos4210-rotator";
> +        reg = <0x12810000 0x1000>;
> +        interrupts = <0 83 0>;
> +        clocks = <&clock 278>;
> +        clock-names = "rotator";
> +    };
> +
> -- 
> 2.17.1
> 

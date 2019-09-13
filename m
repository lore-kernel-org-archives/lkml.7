Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66022C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9702084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568385402;
	bh=OXaPfWTKm1xnvhvSCXpdaF/6UCxd83QHOh4eDe23oKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wBE4Dt/rD2s/luDHgysJUwSuUv9fAwW7aU7Xl9jOfgMfHtmNlNQXQ7NfjxSyq5NZu
	 H4Syo6XrnRcI4HMcXtH11PurkwDhzpNfCAoovQk3angW4Db0P97wrBvmkeZtrHgHxq
	 HYUtOf4jVb2JLJQWuF61AWe3e1YlKzEV92qWg1QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfIMOg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:36:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42982 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfIMOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:36:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id z6so2787212oix.9;
        Fri, 13 Sep 2019 07:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5lxB1SkamjYiGhernIFi0Hwph/keSNWsiTigjVm9FM=;
        b=m3F4kbNtTKUumlC46gEj7w7P5pe9BK/+Xr+p4HPsxkCXce4MMi6DEzoFWrSbhiieGB
         5qDX6J+QnBqrdxjBXd66TBd59K9Kne9fVshOGT/NRTt6S3GoojplcSGoflUkvVyjFGBo
         fZWQLt1zV8WyfewLnjwLe/d4GS0/+oTLKF/9A/FfFgdRo8k7hRx84/W9SHK5DGQHjL9h
         FYOtkq9LjX3gBhR6QORI+sULK2DTYn2Mstl5RuCJYSJ92Hnjl6qbQtKxwQI/E/HH1VIs
         CcqID5qwh6LG82vt679zBHRf/AFTMZ+TujSuSzE0IDDxV1/P9CA/NzUXspZrpNmgFcz3
         5Sng==
X-Gm-Message-State: APjAAAWL+OMGXScrbyk4+hrFD3F3PzwVO46nqfJBGKpthbr7XMgANWfr
        1T/TYbg/ONVnlHntr2Nx0Q==
X-Google-Smtp-Source: APXvYqzvDKYvYkB5ScZXsHQdE+uCr/W7Tj0azlbY+saF/1MssVoS4TV7Xd9yW33r1voWLmoeCea3dA==
X-Received: by 2002:aca:4c54:: with SMTP id z81mr3487645oia.0.1568385384572;
        Fri, 13 Sep 2019 07:36:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d38sm10985849otb.7.2019.09.13.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:23 -0700 (PDT)
Message-ID: <5d7ba967.1c69fb81.64b1c.ab06@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:23 +0100
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Convert Exynos MCT bindings to
 json-schema
References: <20190909162537.27635-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909162537.27635-1-krzk@kernel.org>
X-Mutt-References: <20190909162537.27635-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:25:37PM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos Soc Multi Core Timer bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/timer/samsung,exynos4210-mct.txt |  88 --------------
>  .../timer/samsung,exynos4210-mct.yaml         | 115 ++++++++++++++++++
>  2 files changed, 115 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml


> diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> new file mode 100644
> index 000000000000..b96d2877955f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/samsung,exynos4210-mct.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC Multi Core Timer (MCT)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +
> +description: |+
> +  The Samsung's Multi Core Timer (MCT) module includes two main blocks, the
> +  global timer and CPU local timers. The global timer is a 64-bit free running
> +  up-counter and can generate 4 interrupts when the counter reaches one of the
> +  four preset counter values. The CPU local timers are 32-bit free running
> +  down-counters and generate an interrupt when the counter expires. There is
> +  one CPU local timer instantiated in MCT for every CPU in the system.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,exynos4210-mct
> +      - samsung,exynos4412-mct
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Interrupts should be put in specific order. This is, the local timer
> +      interrupts should be specified after the four global timer interrupts
> +      have been specified:
> +      0: Global Timer Interrupt 0
> +      1: Global Timer Interrupt 1
> +      2: Global Timer Interrupt 2
> +      3: Global Timer Interrupt 3
> +      4: Local Timer Interrupt 0
> +      5: Local Timer Interrupt 1
> +      6: ..
> +      7: ..
> +      i: Local Timer Interrupt n
> +      For MCT block that uses a per-processor interrupt for local timers, such
> +      as ones compatible with "samsung,exynos4412-mct", only one local timer
> +      interrupt might be specified, meaning that all local timers use the same
> +      per processor interrupt.
> +    minItems: 5               # 4 Global + 1 local
> +    maxItems: 20              # 4 Global + 16 local
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reg
> +
> +examples:
> +  - |
> +    // In this example, the IP contains two local timers, using separate
> +    // interrupts, so two local timer interrupts have been specified,
> +    // in addition to four global timer interrupts.
> +      mct@10050000 {

Can we clean this up and use 'timer' here.

> +        compatible = "samsung,exynos4210-mct";
> +        reg = <0x10050000 0x800>;
> +        interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> +                     <0 42 0>, <0 48 0>;
> +      };
> +
> +  - |
> +    // In this example, the timer interrupts are connected to two separate
> +    // interrupt controllers. Hence, an interrupt-map is created to map
> +    // the interrupts to the respective interrupt controllers.
> +
> +    mct@101c0000 {
> +      compatible = "samsung,exynos4210-mct";
> +      reg = <0x101C0000 0x800>;
> +      interrupt-parent = <&mct_map>;
> +      interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
> +
> +      mct_map: mct-map {

This needs to be documented.

Note, I don't really see any reason this needs to be a child node.

> +        #interrupt-cells = <1>;
> +        #address-cells = <0>;
> +        #size-cells = <0>;
> +        interrupt-map = <0 &gic 0 57 0>,
> +                        <1 &gic 0 69 0>,
> +                        <2 &combiner 12 6>,
> +                        <3 &combiner 12 7>,
> +                        <4 &gic 0 42 0>,
> +                        <5 &gic 0 48 0>;
> +      };
> +    };
> +
> +  - |
> +    // In this example, the IP contains four local timers, but using
> +    // a per-processor interrupt to handle them. Only one first local
> +    // interrupt is specified.
> +
> +    mct@10050000 {
> +      compatible = "samsung,exynos4412-mct";
> +      reg = <0x10050000 0x800>;
> +
> +      interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> +                   <0 42 0>;
> +    };
> +
> +  - |
> +    // In this example, the IP contains four local timers, but using
> +    // a per-processor interrupt to handle them. All the local timer
> +    // interrupts are specified.
> +
> +    mct@10050000 {
> +      compatible = "samsung,exynos4412-mct";
> +      reg = <0x10050000 0x800>;
> +
> +      interrupts = <0 57 0>, <0 69 0>, <0 70 0>, <0 71 0>,
> +                   <0 42 0>, <0 42 0>, <0 42 0>, <0 42 0>;
> +    };
> -- 
> 2.17.1
> 


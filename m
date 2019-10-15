Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57458ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1989720663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571168411;
	bh=tM0AjEWhyx9R5ZiZRV/jBIEBRXP9ZXt7z9KPZ31rQdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NJa+llob2yL2kWSUqz/lWy820aVOAoWL+grvYpcWNODUpdBvzfDLrSXbDFQWQ8tr3
	 DP9qchMb7CG+PZiXBVr6MmOr1pGptYGxslE86UyveGM/NxEOiDkOhXmCuddmuZh5U9
	 HsM/vqCYwxwahC11vvP53LIgGOpIJGjFWQ007i6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfJOTkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:40:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40593 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfJOTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:40:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so17909546oib.7;
        Tue, 15 Oct 2019 12:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f5z1afL3zYQYcRyoERZzjsi7/SiRTHqNbFhLxSAuGLs=;
        b=nuIXrwVaKyb3aseG4ulaPJ5ugUB7/9Cg5YOcvHDimEcXKQlclj4XLD0VlPf8dMGpbl
         xoZOcdPdrcsKLrSoIgh9S2EAo5YKL+wm+Q+/D+6vflKJx/J2ml1VZotknGuYp6/L8eqG
         ZcAniBvTymC4x4vkNUUB+7t5epWzgYAM7NAmRe9b+79pCrYY9DXcRfsqs1IumEYQ9SWw
         6eFm+BGGcfRHDJFag+/0Y5hmiUgM7mN42wKfLO7Dl0Csaq4FatXk2oTbG4p0Ur+OO3Ym
         0pvl1TYvG/rdal+0V8kv3Nu3UrSdAvVKPf+OKtbrBNowdA/2oDri7NvMDRk/wpZiNnBQ
         dE7A==
X-Gm-Message-State: APjAAAVDc0L6qTMyq4cym8jLrjd8hD9Dh5Xd/XgtZQGCICRa79rO21aF
        engBSy1bxf+NJttjmXz3ww==
X-Google-Smtp-Source: APXvYqxhtUbYR837DFUipAtkBDduyyeI6vaqqhzSUmhgED4fPdNsTQT8GLSgnjNjdjHJLBDi7GG+5w==
X-Received: by 2002:a54:418c:: with SMTP id 12mr203382oiy.154.1571168407330;
        Tue, 15 Oct 2019 12:40:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b10sm1556470oic.55.2019.10.15.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:40:06 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:40:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: serial: Convert Samsung UART bindings
 to json-schema
Message-ID: <20191015194006.GA3540@bogus>
References: <20191004151414.8458-1-krzk@kernel.org>
 <20191004151414.8458-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004151414.8458-3-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 05:14:14PM +0200, Krzysztof Kozlowski wrote:
> Convert Samsung S3C/S5P/Exynos Serial/UART bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt |   2 +-
>  .../bindings/serial/samsung_uart.txt          |  58 -------
>  .../bindings/serial/samsung_uart.yaml         | 148 ++++++++++++++++++
>  3 files changed, 149 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> index d759da606f75..30ea27c3936d 100644
> --- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> +++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> @@ -18,7 +18,7 @@ an optional sub-node. For "samsung,exynos5433-lpass" compatible this includes:
>  UART, SLIMBUS, PCM, I2S, DMAC, Timers 0...4, VIC, WDT 0...1 devices.
>  
>  Bindings of the sub-nodes are described in:
> -  ../serial/samsung_uart.txt
> +  ../serial/samsung_uart.yaml
>    ../sound/samsung-i2s.txt
>    ../dma/arm-pl330.txt
>  
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
> deleted file mode 100644
> index e85f37ec33f0..000000000000
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -* Samsung's UART Controller
> -
> -The Samsung's UART controller is used for interfacing SoC with serial
> -communicaion devices.
> -
> -Required properties:
> -- compatible: should be one of following:
> -  - "samsung,exynos4210-uart" -  Exynos4210 SoC,
> -  - "samsung,s3c2410-uart" - compatible with ports present on S3C2410 SoC,
> -  - "samsung,s3c2412-uart" - compatible with ports present on S3C2412 SoC,
> -  - "samsung,s3c2440-uart" - compatible with ports present on S3C2440 SoC,
> -  - "samsung,s3c6400-uart" - compatible with ports present on S3C6400 SoC,
> -  - "samsung,s5pv210-uart" - compatible with ports present on S5PV210 SoC.
> -
> -- reg: base physical address of the controller and length of memory mapped
> -  region.
> -
> -- interrupts: a single interrupt signal to SoC interrupt controller,
> -  according to interrupt bindings documentation [1].
> -
> -- clock-names: input names of clocks used by the controller:
> -  - "uart" - controller bus clock,
> -  - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...),
> -    according to SoC User's Manual (only N = 0 is allowedfor SoCs without
> -    internal baud clock mux).
> -- clocks: phandles and specifiers for all clocks specified in "clock-names"
> -  property, in the same order, according to clock bindings documentation [2].
> -
> -[1] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Optional properties:
> -- samsung,uart-fifosize: The fifo size supported by the UART channel
> -
> -Note: Each Samsung UART should have an alias correctly numbered in the
> -"aliases" node, according to serialN format, where N is the port number
> -(non-negative decimal integer) as specified by User's Manual of respective
> -SoC.
> -
> -Example:
> -	aliases {
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -	};
> -
> -Example:
> -	uart1: serial@7f005400 {
> -		compatible = "samsung,s3c6400-uart";
> -		reg = <0x7f005400 0x100>;
> -		interrupt-parent = <&vic1>;
> -		interrupts = <6>;
> -		clock-names = "uart", "clk_uart_baud2",
> -				"clk_uart_baud3";
> -		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
> -				<&clocks SCLK_UART>;
> -		samsung,uart-fifosize = <16>;
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> new file mode 100644
> index 000000000000..276bea1c231a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/samsung_uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S3C, S5P and Exynos SoC UART Controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +
> +description: |+
> +  Each Samsung UART should have an alias correctly numbered in the "aliases"
> +  node, according to serialN format, where N is the port number (non-negative
> +  decimal integer) as specified by User's Manual of respective SoC.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - samsung,s3c2410-uart
> +          - samsung,s3c2412-uart
> +          - samsung,s3c2440-uart
> +          - samsung,s3c6400-uart
> +          - samsung,s5pv210-uart
> +          - samsung,exynos4210-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 5
> +
> +  clock-names:
> +    description: |
> +      List of clock names:
> +        - "uart" - controller bus clock,
> +        - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...).

Kind of redundant to list this here.

> +      N = 0 is allowed for SoCs without internal baud clock mux.

You can add a description with the item:

items:
  - pattern: '^clk_uart_baud[0-3]$'
    description: N = 0 is allowed for SoCs without internal baud clock mux.

Or leave it here is fine too.

> +    minItems: 2
> +    maxItems: 5
> +    allOf:
> +      - uniqueItems: true

You can drop this.

> +      - oneOf:
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +          - items:
> +              - const: uart
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'
> +              - pattern: '^clk_uart_baud[0-3]$'

You only need the last case. With 'minItems: 2', the additional items 
here will just be ignored.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

What is each item?

> +
> +  samsung,uart-fifosize:
> +    description: The fifo size supported by the UART channel
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [16, 64, 256]
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,s3c2410-uart
> +              - samsung,s5pv210-uart
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 3
> +        clock-names:
> +          minItems: 2
> +          maxItems: 3
> +          allOf:
> +            - uniqueItems: true
> +            - oneOf:
> +                - items:
> +                    - const: uart
> +                    - pattern: '^clk_uart_baud[0-1]$'
> +                - items:
> +                    - const: uart
> +                    - pattern: '^clk_uart_baud[0-1]$'
> +                    - pattern: '^clk_uart_baud[0-1]$'

Similar simplification can be done here.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos4210-uart
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          minItems: 2
> +          maxItems: 2
> +          allOf:
> +            - uniqueItems: true
> +            - items:
> +                - const: uart
> +                - const: clk_uart_baud0
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
> +
> +    aliases {
> +        serial0 = &uart0;
> +    };

Drop this. It will cause a warning if we enforce 'aliases' to be at the 
root node.

> +
> +    uart0: serial@7f005000 {
> +        compatible = "samsung,s3c6400-uart";
> +        reg = <0x7f005000 0x100>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <5>;
> +        clock-names = "uart", "clk_uart_baud2",
> +                      "clk_uart_baud3";
> +        clocks = <&clocks PCLK_UART0>, <&clocks PCLK_UART0>,
> +                 <&clocks SCLK_UART>;
> +        samsung,uart-fifosize = <16>;
> +    };
> -- 
> 2.17.1
> 

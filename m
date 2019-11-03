Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B356CA9EBB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94CC20578
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572796594;
	bh=wcm4WSq8nf1bPCFvvJdXoljIG1mzPOwPBgmMSlSJ1QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JoPUs8CXAjsa3MYvVemteBwh7FCv+Z/tonZSrfUlxY2lBGS/xAtDf8pf4Tlws33GP
	 W+QCViojtWPLGxzCO1CA67T28ElOwimx4B+HAidpy3WIYJEMR5gHXZ4CklrjkMOcwA
	 ohYWCZXAHFct+d5Sda+B96c2LNVbbdEjX+QnHdQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfKCP4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 10:56:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39561 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfKCP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 10:56:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id l25so11261569edt.6;
        Sun, 03 Nov 2019 07:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9GGwjavjQQOgINeeqgNFn5O1QAWzrjwrcfoPvqx32k=;
        b=Q5fPyCCBlp95NpOkcDqzhA1nQfsHW8XOTYs6V7NlryxE5DTIptGRy/R72Z812n77pB
         U7PZxEQEdpRzldeaBpotxrAm4sl43cTGRvtrFgo1MPglEc/PeeNoL2/dAXzS7eEaevh+
         B8hGkYL9ms0a8UqtzMaBCm4ybN/JxlneJjlgppxx2nbv+LuTlPnFYsVeyWXGMhXkcEjk
         f2Qpm0vy4eBm3e1C9/dIGBsMeUe9dETFEKeVU7KD8ivy7kHYxrgdUgxqhfTDqzNHU6mJ
         r9XRrbx24W2OsxU0W14K3/eOp7rg0p26blIUpQs6VbaF5nsee5Y7HZz0sGx35kXRuNwM
         yyDw==
X-Gm-Message-State: APjAAAVdsNOqx5M30W4e6MLhCOSllHPT2A4pG2b6cQvRFYmMhfRx0ixI
        YVNueAbJIQTDB6T04pXP2L4=
X-Google-Smtp-Source: APXvYqxNP7szQhet9sXBcDrshchvID9xPkCKOWKeMWmkHoP70A6OrX+tlJ1vbiRwjVFkcS0n8I+n3g==
X-Received: by 2002:a50:cc43:: with SMTP id n3mr24819628edi.287.1572796586774;
        Sun, 03 Nov 2019 07:56:26 -0800 (PST)
Received: from kozik-lap ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id s8sm759641edj.6.2019.11.03.07.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 07:56:26 -0800 (PST)
Date:   Sun, 3 Nov 2019 16:56:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <20191103155623.GA6960@kozik-lap>
References: <20191004151414.8458-1-krzk@kernel.org>
 <20191004151414.8458-3-krzk@kernel.org>
 <20191015194006.GA3540@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191015194006.GA3540@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 02:40:06PM -0500, Rob Herring wrote:
> On Fri, Oct 04, 2019 at 05:14:14PM +0200, Krzysztof Kozlowski wrote:
> > Convert Samsung S3C/S5P/Exynos Serial/UART bindings to DT schema format
> > using json-schema.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../bindings/mfd/samsung,exynos5433-lpass.txt |   2 +-
> >  .../bindings/serial/samsung_uart.txt          |  58 -------
> >  .../bindings/serial/samsung_uart.yaml         | 148 ++++++++++++++++++
> >  3 files changed, 149 insertions(+), 59 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
> >  create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> > index d759da606f75..30ea27c3936d 100644
> > --- a/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> > +++ b/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.txt
> > @@ -18,7 +18,7 @@ an optional sub-node. For "samsung,exynos5433-lpass" compatible this includes:
> >  UART, SLIMBUS, PCM, I2S, DMAC, Timers 0...4, VIC, WDT 0...1 devices.
> >  
> >  Bindings of the sub-nodes are described in:
> > -  ../serial/samsung_uart.txt
> > +  ../serial/samsung_uart.yaml
> >    ../sound/samsung-i2s.txt
> >    ../dma/arm-pl330.txt
> >  
> > diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
> > deleted file mode 100644
> > index e85f37ec33f0..000000000000
> > --- a/Documentation/devicetree/bindings/serial/samsung_uart.txt
> > +++ /dev/null
> > @@ -1,58 +0,0 @@
> > -* Samsung's UART Controller
> > -
> > -The Samsung's UART controller is used for interfacing SoC with serial
> > -communicaion devices.
> > -
> > -Required properties:
> > -- compatible: should be one of following:
> > -  - "samsung,exynos4210-uart" -  Exynos4210 SoC,
> > -  - "samsung,s3c2410-uart" - compatible with ports present on S3C2410 SoC,
> > -  - "samsung,s3c2412-uart" - compatible with ports present on S3C2412 SoC,
> > -  - "samsung,s3c2440-uart" - compatible with ports present on S3C2440 SoC,
> > -  - "samsung,s3c6400-uart" - compatible with ports present on S3C6400 SoC,
> > -  - "samsung,s5pv210-uart" - compatible with ports present on S5PV210 SoC.
> > -
> > -- reg: base physical address of the controller and length of memory mapped
> > -  region.
> > -
> > -- interrupts: a single interrupt signal to SoC interrupt controller,
> > -  according to interrupt bindings documentation [1].
> > -
> > -- clock-names: input names of clocks used by the controller:
> > -  - "uart" - controller bus clock,
> > -  - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...),
> > -    according to SoC User's Manual (only N = 0 is allowedfor SoCs without
> > -    internal baud clock mux).
> > -- clocks: phandles and specifiers for all clocks specified in "clock-names"
> > -  property, in the same order, according to clock bindings documentation [2].
> > -
> > -[1] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > -[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > -
> > -Optional properties:
> > -- samsung,uart-fifosize: The fifo size supported by the UART channel
> > -
> > -Note: Each Samsung UART should have an alias correctly numbered in the
> > -"aliases" node, according to serialN format, where N is the port number
> > -(non-negative decimal integer) as specified by User's Manual of respective
> > -SoC.
> > -
> > -Example:
> > -	aliases {
> > -		serial0 = &uart0;
> > -		serial1 = &uart1;
> > -		serial2 = &uart2;
> > -	};
> > -
> > -Example:
> > -	uart1: serial@7f005400 {
> > -		compatible = "samsung,s3c6400-uart";
> > -		reg = <0x7f005400 0x100>;
> > -		interrupt-parent = <&vic1>;
> > -		interrupts = <6>;
> > -		clock-names = "uart", "clk_uart_baud2",
> > -				"clk_uart_baud3";
> > -		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
> > -				<&clocks SCLK_UART>;
> > -		samsung,uart-fifosize = <16>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > new file mode 100644
> > index 000000000000..276bea1c231a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> > @@ -0,0 +1,148 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/samsung_uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Samsung S3C, S5P and Exynos SoC UART Controller
> > +
> > +maintainers:
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > +
> > +description: |+
> > +  Each Samsung UART should have an alias correctly numbered in the "aliases"
> > +  node, according to serialN format, where N is the port number (non-negative
> > +  decimal integer) as specified by User's Manual of respective SoC.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - samsung,s3c2410-uart
> > +          - samsung,s3c2412-uart
> > +          - samsung,s3c2440-uart
> > +          - samsung,s3c6400-uart
> > +          - samsung,s5pv210-uart
> > +          - samsung,exynos4210-uart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 2
> > +    maxItems: 5
> > +
> > +  clock-names:
> > +    description: |
> > +      List of clock names:
> > +        - "uart" - controller bus clock,
> > +        - "clk_uart_baudN" - Nth baud base clock input (N = 0, 1, ...).
> 
> Kind of redundant to list this here.
> 
> > +      N = 0 is allowed for SoCs without internal baud clock mux.
> 
> You can add a description with the item:
> 
> items:
>   - pattern: '^clk_uart_baud[0-3]$'
>     description: N = 0 is allowed for SoCs without internal baud clock mux.
> 

This caused error:
properties:clock-names:items:1: Additional properties are not allowed ('description' was unexpected)
../Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/serial/samsung_uart.example.dts' failed

I applied rest of comments. Thanks for review!

Best regards,
Krzysztof


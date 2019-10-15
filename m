Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C7ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9A320854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571179164;
	bh=hAVovort2JCsXfMx25ROErzRjEx4WfY00RUbBk1pWTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IYjHQ6FaP65mS5tpZLq1lXlQX00K5QCgmt0Qejqql8prbJ6tbwi4Ncb6JgyhaTA76
	 ck9sZgKll1wf6mGyZWyF+4r0i3PZBRGA+Aydr5r7MKvjJklLOHS/xuLdUCo13rWSKk
	 12cd2J+23esoFjcE6dU5N6GKX2j20vyGbcWUmH40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbfJOWjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:39:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34185 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbfJOWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:39:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id 83so18335888oii.1;
        Tue, 15 Oct 2019 15:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Egjzk0ycS6uGAiZgrL7dEKAam8R3Prs2rZCZ9pP9rt4=;
        b=MWPiqj59Ex8qFPp2oPzg4Ov7RKVg7IBui9nES4J6xI58frblkvGFCDazMi+bLJJV4O
         kX3sBdnXefGtx7QSuKq75CZMXXR+PBQ6Y2l8/dJAeu+5p8ZpEXJ24N7ZGwh0CU7zdBms
         RsI31dGTEkcyzRCe8Dls3N4PsOoNRZX/QfiCnrAte7QAXuGU4i4RTStldTNJFojj2syI
         csnfzgDxsy1h/W1JZppS5dhCugVoUiEAN7UwdNSdlvpTiL03r4YVl79pZtZDezffkqaV
         Orpuv8DuT0H3tn9EjU77oL7dyIz0RxveEw4w0whDpDg2+Moucw6c9cb8KOWxfnNmAw2J
         mLfQ==
X-Gm-Message-State: APjAAAURsuXkWIz/grB/JL0FKvjcJG8wXYamxPxbKJ/cI9zKhDCAA2Q3
        eDCeMHQu2KbZmxqRUyu2bg==
X-Google-Smtp-Source: APXvYqxm7a6bczSWgIPH0k7QKCRb1myMosLNn1AgIfZbHlkIYmgEaQQKFFbuGfrEfqHavxgerjgDQw==
X-Received: by 2002:aca:f492:: with SMTP id s140mr792180oih.83.1571179159904;
        Tue, 15 Oct 2019 15:39:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 23sm184295oir.50.2019.10.15.15.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:39:19 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:39:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: mfd: atmel-tcb: convert bindings to
 json-schema
Message-ID: <20191015223918.GA26590@bogus>
References: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
 <20191009224006.5021-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009224006.5021-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:39:59AM +0200, Alexandre Belloni wrote:
> Convert Atmel Timer Counter Blocks bindings to DT schema format using
> json-schema.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> 
>  .../bindings/mfd/atmel,at91rm9200-tcb.yaml    | 89 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-tcb.txt     | 56 ------------
>  2 files changed, 89 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml
> new file mode 100644
> index 000000000000..4d9247fc0593
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91rm9200-tcb.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mfd/atmel,at91rm9200-tcb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Atmel Timer Counter Block
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +description: |
> +  The Atmel (now Microchip) SoCs have timers named Timer Counter Block. Each
> +  timer has three channels with two counters each.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - atmel,at91rm9200-tcb
> +          - atmel,at91sam9x5-tcb
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      List of interrupts. One interrupt per TCB channel if available or one
> +      interrupt for the TC block
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    description:
> +      List of clock names. Always includes t0_clk and slow clk. Also includes
> +      t1_clk and t2_clk if a clock per channel is available.
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      enum:
> +        - t0_clk
> +        - t1_clk
> +        - t2_clk
> +        - slow_clk
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 4
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

What happened to the child nodes?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +examples:
> +  - |
> +    /* One interrupt per TC block: */
> +        tcb0: timer@fff7c000 {
> +                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0xfff7c000 0x100>;
> +                interrupts = <18 4>;
> +                clocks = <&tcb0_clk>, <&clk32k>;
> +                clock-names = "t0_clk", "slow_clk";
> +        };
> +
> +    /* One interrupt per TC channel in a TC block: */
> +        tcb1: timer@fffdc000 {
> +                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                reg = <0xfffdc000 0x100>;
> +                interrupts = <26 4>, <27 4>, <28 4>;
> +                clocks = <&tcb1_clk>, <&clk32k>;
> +                clock-names = "t0_clk", "slow_clk";
> +        };
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> deleted file mode 100644
> index c4a83e364cb6..000000000000
> --- a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -* Device tree bindings for Atmel Timer Counter Blocks
> -- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
> -  <chip> can be "at91rm9200" or "at91sam9x5"
> -- reg: Should contain registers location and length
> -- #address-cells: has to be 1
> -- #size-cells: has to be 0
> -- interrupts: Should contain all interrupts for the TC block
> -  Note that you can specify several interrupt cells if the TC
> -  block has one interrupt per channel.
> -- clock-names: tuple listing input clock names.
> -	Required elements: "t0_clk", "slow_clk"
> -	Optional elements: "t1_clk", "t2_clk"
> -- clocks: phandles to input clocks.
> -
> -The TCB can expose multiple subdevices:
> - * a timer
> -   - compatible: Should be "atmel,tcb-timer"
> -   - reg: Should contain the TCB channels to be used. If the
> -     counter width is 16 bits (at91rm9200-tcb), two consecutive
> -     channels are needed. Else, only one channel will be used.
> -
> -Examples:
> -
> -One interrupt per TC block:
> -	tcb0: timer@fff7c000 {
> -		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0xfff7c000 0x100>;
> -		interrupts = <18 4>;
> -		clocks = <&tcb0_clk>, <&clk32k>;
> -		clock-names = "t0_clk", "slow_clk";
> -
> -		timer@0 {
> -			compatible = "atmel,tcb-timer";
> -			reg = <0>, <1>;
> -		};
> -
> -		timer@2 {
> -			compatible = "atmel,tcb-timer";
> -			reg = <2>;
> -		};
> -	};
> -
> -One interrupt per TC channel in a TC block:
> -	tcb1: timer@fffdc000 {
> -		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0xfffdc000 0x100>;
> -		interrupts = <26 4>, <27 4>, <28 4>;
> -		clocks = <&tcb1_clk>, <&clk32k>;
> -		clock-names = "t0_clk", "slow_clk";
> -	};
> -
> -
> -- 
> 2.21.0
> 

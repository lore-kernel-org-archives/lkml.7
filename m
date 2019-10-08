Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD596C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0C82070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570538953;
	bh=l4QjoOoC1FPsBF/H8+vyqEeZBRWcMj5euRW3XBxAE98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GKZgVBBhMM1kF9FalJIDeAqwUFrRZFROS4upfjxD1AlZuZ4MCUarISoCJbsjTqqaD
	 bQZzM1HoLEt50eZgxtSACjnkzxz7pBWGOQ3TRoGWblNcmEnbfQnSkTpcXLmalvm+e4
	 88qlmKLkKeXJD64Q8w9JslesuTjGims5sr7ur+Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfJHMtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfJHMtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:49:12 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3EF120815;
        Tue,  8 Oct 2019 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570538951;
        bh=l4QjoOoC1FPsBF/H8+vyqEeZBRWcMj5euRW3XBxAE98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OEdAywYO6BHIh3JUKUWueff1vUkd8txFYMvRvT1WS5dhPMIw1bgC7i+gyvfKi8bk7
         NiNHdWJdyhegNol3yg8TiMAsc3UIYhZF8C3n13Z7YZAFUroIzk1NWttcAjTQrrFhj8
         mqKNKguQx+/phncGm9QOOr4PJ3Pd6arxycSm4mRw=
Received: by mail-qt1-f171.google.com with SMTP id e15so10190979qtr.4;
        Tue, 08 Oct 2019 05:49:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXlq/6IqG73Vxfo8VDbkZuUwvTfWCEwPt6gGCegLV43IM7StNzn
        RaqGWX3VM8uOi5/zADdYe1Equ7WXvABrQuJl5g==
X-Google-Smtp-Source: APXvYqxSaRgUqqni7RWikQ+zN1xMpYCgoo0IuuKMMlW4a/sVKwGL8eRTo+RXkXFsUSbAZ9vRNEtMOquOyCQzYMzABM4=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr35881979qtn.110.1570538949942;
 Tue, 08 Oct 2019 05:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191002151714.15813-1-benjamin.gaignard@st.com>
In-Reply-To: <20191002151714.15813-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Oct 2019 07:48:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJtHgAZvFbWOEwu7WsG2OHHugfB1RKSrxsaP3Exa5odGg@mail.gmail.com>
Message-ID: <CAL_JsqJtHgAZvFbWOEwu7WsG2OHHugfB1RKSrxsaP3Exa5odGg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Convert stm32 display bindings to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 10:17 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert the STM32 display binding to DT schema format using json-schema.
> Split the original bindings in two yaml files:
> - one for display controller (ltdc)
> - one for DSI controller
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/display/st,stm32-dsi.yaml  | 130 +++++++++++++++++++
>  .../devicetree/bindings/display/st,stm32-ltdc.txt  | 144 ---------------------
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml |  82 ++++++++++++
>  3 files changed, 212 insertions(+), 144 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> new file mode 100644
> index 000000000000..8143cf6f0ce7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: GPL-2.0

If all the authors are ST, can you relicense to (GPL-2.0-only OR BSD-2-Clause).

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/st,stm32-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 DSI host controller
> +
> +maintainers:
> +  - Philippe Cornu <philippe.cornu@st.com>
> +  - Yannick Fertre <yannick.fertre@st.com>
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    const: st,stm32-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Module Clock
> +      - description: DSI bus clock
> +      - description: Pixel clock
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: ref
> +      - const: px_clk
> +    minItems: 2
> +    maxItems: 3
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: apb
> +
> +  phy-dsi-supply:
> +    maxItems: 1
> +    description:
> +        Phandle of the regulator that provides the supply voltage.
> +
> +  ports:
> +    type: object
> +    description:
> +        A node containing DSI input & output port nodes with endpoint
> +        definitions as documented in
> +        Documentation/devicetree/bindings/media/video-interfaces.txt
> +        Documentation/devicetree/bindings/graph.txt
> +
> +  port:

This needs to be under 'properties' under 'ports'. And you need to
have 'port@0' and 'port@1' instead.

> +    type: object
> +    description:
> +      "A port node with endpoint definitions as defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt.
> +      port@0: DSI input port node, connected to the ltdc rgb output port.
> +      port@1: DSI output port node, connected to a panel or a bridge input port"
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - ports

Add an 'additionalProperties: false' here.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    dsi: dsi@5a000000 {
> +        compatible = "st,stm32-dsi";
> +        reg = <0x5a000000 0x800>;
> +        clocks = <&rcc DSI_K>, <&clk_hse>, <&rcc DSI_PX>;
> +        clock-names = "pclk", "ref", "px_clk";
> +        resets = <&rcc DSI_R>;
> +        reset-names = "apb";
> +        phy-dsi-supply = <&reg18>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                    reg = <0>;
> +                    dsi_in: endpoint {
> +                        remote-endpoint = <&ltdc_ep1_out>;
> +                    };
> +              };
> +
> +              port@1 {
> +                    reg = <1>;
> +                    dsi_out: endpoint {
> +                        remote-endpoint = <&panel_in>;
> +                    };
> +              };
> +        };
> +
> +        panel {

Not documented.

> +              compatible = "orisetech,otm8009a";
> +              reg = <0>;
> +              reset-gpios = <&gpioe 4 GPIO_ACTIVE_LOW>;
> +              power-supply = <&v3v3>;
> +
> +              port {
> +                    panel_in: endpoint {
> +                        remote-endpoint = <&dsi_out>;
> +                    };
> +              };
> +        };
> +    };
> +
> +...
> +
> +

[...]

> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> new file mode 100644
> index 000000000000..5d01c83234a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/st,stm32-ltdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 lcd-tft display controller
> +
> +maintainers:
> +  - Philippe Cornu <philippe.cornu@st.com>
> +  - Yannick Fertre <yannick.fertre@st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stm32-ltdc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clocks:
> +    items:
> +      - description: Module Clock

Just 'maxItems: 1' is sufficient with a single entry.

> +
> +  clock-names:
> +    items:
> +      - const: lcd
> +
> +  pinctrl-names: true
> +
> +  resets:
> +        maxItems: 1

Inconsistent indenting.

> +
> +  port:
> +    type: object
> +    description:
> +      "Video port for DPI RGB output.
> +      ltdc has one video port with up to 2 endpoints:
> +      - for external dpi rgb panel or bridge, using gpios.
> +      - for internal dpi input of the MIPI DSI host controller.
> +      Note: These 2 endpoints cannot be activated simultaneously.
> +      Please refer to the bindings defined in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt."
> +
> +patternProperties:
> +  "^pinctrl-[0-9]+$": true

No need for this, it gets added automatically.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - port

Add an 'additionalProperties: false' here.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    ltdc: display-controller@40016800 {
> +        compatible = "st,stm32-ltdc";
> +        reg = <0x5a001000 0x400>;
> +        interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&rcc LTDC_PX>;
> +        clock-names = "lcd";
> +        resets = <&rcc LTDC_R>;
> +
> +        port {
> +             ltdc_out_dsi: endpoint {
> +                     remote-endpoint = <&dsi_in>;
> +             };
> +        };
> +    };
> +
> +...
> +
> --
> 2.15.0
>

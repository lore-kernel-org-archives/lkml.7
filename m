Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C860EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B18621A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571061447;
	bh=LLH2uQ5gYg+SBXTksDYlU+T3+fs82qQa6ba8XCr/GLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y/Y7hG3zJXEF1P54jkLmo6alJEihjYs5JA5xh6gZsZpyhXXwBKFHX4RDR8P6ahR+K
	 cd9EDwRpZuyyGLk8iGPoLV40R8bWLaEHX0HAJNTv1JkXjaJlLDRfcW15UsCjluBjak
	 mNoSVt08zP9c4hiOaGHkC698HBjx5tLYIJTNsFRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfJNN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730477AbfJNN50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:57:26 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B2D21A4A;
        Mon, 14 Oct 2019 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571061444;
        bh=LLH2uQ5gYg+SBXTksDYlU+T3+fs82qQa6ba8XCr/GLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WhWA0Z26YBfhBAV8RCEZEMYp1v+sqt+colar2WnzuXDlL8iW6T6nbdwUUz7lR8xRD
         k0e4PvOQpMwHU+2BFSDNQzxl86uVe5XU5vttQ3NcDIoX47dI8JTqJVYmbE02q9jLiH
         nUhPVzxIyECh8oC7bBNWteH980agEaehLbva3a1w=
Received: by mail-qt1-f177.google.com with SMTP id w14so25522096qto.9;
        Mon, 14 Oct 2019 06:57:24 -0700 (PDT)
X-Gm-Message-State: APjAAAUVQuV76dR08KCLMQTH23BGbX7FB9mZsU9tnsOwYQ8kycto0+SB
        tzW383NdNFW3i8apbb9zfzaEA8sEQ3Py/znyEA==
X-Google-Smtp-Source: APXvYqwX1KUTrKD9PfICXLuavHN6lAAtm6esRog7N3VFNyl9RY+ZCu7FqNsYVhKlnuWqdkfPcoK1JtogLpjhrB86EEs=
X-Received: by 2002:ac8:6782:: with SMTP id b2mr32574382qtp.143.1571061443573;
 Mon, 14 Oct 2019 06:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191014091622.23562-1-benjamin.gaignard@st.com>
In-Reply-To: <20191014091622.23562-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 14 Oct 2019 08:57:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Z7G31vBhHn_csntOsBLnZoLFU0qZHk67kdC1kahd4kQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Z7G31vBhHn_csntOsBLnZoLFU0qZHk67kdC1kahd4kQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: display: Convert stm32 display bindings
 to json-schema
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

On Mon, Oct 14, 2019 at 4:16 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert the STM32 display binding to DT schema format using json-schema.
> Split the original bindings in two yaml files:
> - one for display controller (ltdc)
> - one for DSI controller
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in v3:
> - use (GPL-2.0-only OR BSD-2-Clause) license
>
> changes in v2:
> - use BSD-2-Clause license
> - add panel property
> - fix identation
> - remove pinctrl-names: true
> - remove pinctrl-[0-9]+: true
> - rework ports block to include port@0 and port@1
> - use const for #adress-cells and #size-cells
> - add additionalProperties: false
>
>  .../devicetree/bindings/display/st,stm32-dsi.yaml  | 151 +++++++++++++++++++++
>  .../devicetree/bindings/display/st,stm32-ltdc.txt  | 144 --------------------
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml |  81 +++++++++++
>  3 files changed, 232 insertions(+), 144 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> new file mode 100644
> index 000000000000..8dd727c7533e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +description:
> +  The STMicroelectronics STM32 DSI controller uses the Synopsys DesignWare MIPI-DSI host controller.
> +
> +properties:
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
> +      A node containing DSI input & output port nodes with endpoint
> +      definitions as documented in
> +      Documentation/devicetree/bindings/media/video-interfaces.txt
> +      Documentation/devicetree/bindings/graph.txt
> +    properties:
> +      port@0:
> +        type: object
> +        description:
> +          DSI input port node, connected to the ltdc rgb output port.
> +
> +      port@1:
> +        type: object
> +        description:
> +          DSI output port node, connected to a panel or a bridge input port"
> +
> +patternProperties:
> +  "^(panel|panel-dsi)@[0-9]$":
> +    type: object
> +    description:
> +      A node containing the panel or bridge description as documented in
> +      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
> +    properties:
> +      port@0:

You can drop this. The unit address for the panel port is decided by
the panel binding, not this one.

> +        type: object
> +        description:
> +          Panel or bridge port node, connected to the DSI output port (port@1)

[...]

> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> new file mode 100644
> index 000000000000..94a4137f7236
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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

Need to describe what each interrupt is.

items:
  - description: ...
  - description: ...

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lcd
> +
> +  resets:
> +    maxItems: 1
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
> +  dma-ranges:
> +    maxItems: 1

dma-ranges goes in bus nodes, not device nodes.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - port
> +
> +additionalProperties: false
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

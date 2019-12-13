Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E028CC00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB78D22527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576280354;
	bh=xAOv8Yl+JIw8pkC19DJUBRlJHa9Uj91UrEYE3upEFtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PZNt9zHDOTsA4MTaj8fLxrRMhl/Cwgsn6yCZRNZ02nY3R0xG5Hicl4DaXRALHuXCq
	 VAWD8OopnCaVnPtuFv48HKZpoOrZlV/nnChMzTZDewYhHt39MobfHTaVAJpTWAPlaH
	 ur89QVohkzJ129c8+6z549OlJRoH8SpCCen8VVLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLMXjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:39:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43345 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLMXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:39:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so1040812oth.10;
        Fri, 13 Dec 2019 15:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mq1TYwps803B5nZUOXXBPiLhiWAqlOlO3F5u2J7/OXo=;
        b=pgNoqIcO2KDPypgKZyc87Nfv/HW2xIPBb+orNsyRGJX3Lm3KaTnoKJ90jIG17c29EW
         Bot8hZo/LbVMU0A0uQMMzsKzGvAvL9JuEb1ww5d91Fq8XFhc5ncQz0wyF/9CDa13GqDq
         y+rnGL0G2vIKzEAgRhoNrG4fl38LYdZxWgYNWArFZv/by3Jm3MYiRls0+bnoGw8o4y26
         CPd8awNyhcZLaYupJZ8/wl2tw9DoT/AR0LGcN54YuzBXMeWjyBWvB9cM4PWNtzHa/BKH
         YlXojRheFntA0+HH0U9BYIU979a9IorlGLW5R6fCuGG04jWAYZvcgD7g7B/IhVDLsIcF
         NULQ==
X-Gm-Message-State: APjAAAXVmUwrG5Y9Yzx/3sSGvvusLZf8iT7YFjXjS9PnwOR1UHVNPO4i
        G6MMMPsWMjHJM9YiG7npgQ==
X-Google-Smtp-Source: APXvYqwsTPlVNmmuWh/jy0FcY+/JGCCiTNVGnBx0NSZDWLBN/Q5tOga0z2HBbu+kN45Zxu/2wQ8g+Q==
X-Received: by 2002:a9d:590b:: with SMTP id t11mr8684121oth.161.1576280352011;
        Fri, 13 Dec 2019 15:39:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v14sm3853828oto.16.2019.12.13.15.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:39:11 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:39:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com, Neil Armstrong <narmstrong@baylibre.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
Message-ID: <20191213233910.GA29037@bogus>
References: <20191202193359.703709-1-adrian.ratiu@collabora.com>
 <20191202193359.703709-5-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202193359.703709-5-adrian.ratiu@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:33:59PM +0200, Adrian Ratiu wrote:
> This provides an example DT binding for the MIPI DSI host controller
> present on the i.MX6 SoC based on Synopsis DesignWare v1.01 IP.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml

Run 'make dt_binding_check' and fix the errors. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> new file mode 100644
> index 000000000000..8c9603c28240
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/fsl,mipi-dsi-imx6.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX6 DW MIPI DSI Host Controller
> +
> +description:
> +  The DSI host controller is a Synopsys DesignWare MIPI DSI v1.01 IP with a companion PHY IP.
> +
> +  These DT bindings follow the Synopsys DW MIPI DSI bindings defined in
> +  Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt with
> +  the following device-specific properties.
> +
> +properties:
> +  compatible:
> +    const: [ "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi" ]

Not valid json-schema. You want 'items' with 2 'const' entries.
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Module Clock
> +      - description: DSI bus clock
> +    minItems: 2
> +    maxItems: 2

Don't need these. The min/max is implied by length of 'items'.

> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: ref
> +    minItems: 2
> +    maxItems: 2
> +
> +  fsl,gpr:
> +    description: Phandle to the iomuxc-gpr region containing the multiplexer control register.
> +    const: *gpr

Not a const. Should be a phandle type.

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

DSI virtual channels are 0-3 only.

Do you really need both node names?

> +    type: object
> +    description:
> +      A node containing the panel or bridge description as documented in
> +      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
> +    properties:
> +      port:
> +        type: object
> +        description:
> +          Panel or bridge port node, connected to the DSI output port (port@1)
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsi: dsi@21e0000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi";
> +        reg = <0x021e0000 0x4000>;
> +        interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
> +        fsl,gpr = <&gpr>;
> +        clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
> +                 <&clks IMX6QDL_CLK_MIPI_IPG>;
> +        clock-names = "ref", "pclk";
> +
> +        ports {
> +            port@0 {
> +                reg = <0>;
> +                dsi_in: endpoint {
> +                    remote-endpoint = <&ltdc_ep1_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                dsi_out: endpoint {
> +                    remote-endpoint = <&panel_in>;
> +                };
> +            };
> +        };
> +
> +        panel@0 {
> +            compatible = "sharp,ls032b3sx01";
> +            reg = <0>;
> +            reset-gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;
> +
> +            ports {
> +                port@0 {
> +                    panel_in: endpoint {
> +                        remote-endpoint = <&dsi_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.24.0
> 

Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E259AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD0121872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566907775;
	bh=fUcUeDsVMM74MJ34Ry+nmElbDrbiFBZpMPM2hzgixd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wDTyLMX4YhRbdiH81nuVtLT21YluFt911LOcomlomRAeFFA7rjgl+TCFBIEFW6lKX
	 qG748xxz4d2KcxYVyZiTlEtE6dmtib/6BPEl6kzN2hsOia+5nRED8h9fmcrlHJVWsl
	 2XPMBSxcnNz16FvZdaXcOHfpKxW4d2IiPKUNU6q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfH0MJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfH0MJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:09:34 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912AA23407;
        Tue, 27 Aug 2019 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566907772;
        bh=fUcUeDsVMM74MJ34Ry+nmElbDrbiFBZpMPM2hzgixd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a/HU21B1cyQ6s40aeFD4kglNlgx/8tu55rjKwGr1G3GYTZwUzCWGnPKMfw7u3icX6
         lg9PzWKcnnP3PvbousMWaYQLUOR4BFPYNU1XJ57UIy2rxgYRhPrRY3RZPAkCycs07A
         mZiI8mDd73MKcYwA2EC9W5/61ATgG6Q4muAxpEMM=
Received: by mail-qt1-f178.google.com with SMTP id y26so21024219qto.4;
        Tue, 27 Aug 2019 05:09:32 -0700 (PDT)
X-Gm-Message-State: APjAAAWSwajLxqZMq+KJxMH1hpiFeW+QPdOWQ7CsqddYqm2u4IV7cbR8
        E+CfDDoR762oHoIAdCKEppXxMots69Ab2rMTbg==
X-Google-Smtp-Source: APXvYqwITMYFg2CYFwhIyWqxLZ/aKw9ADPAqPzY//V2prhlPF7exrU3jWDce1/49wEhaqDxEIWNDGyMlSPrc6zzUzds=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr22702194qtc.110.1566907771556;
 Tue, 27 Aug 2019 05:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566470526.git.agx@sigxcpu.org> <36f62b431f32bc76e92d21e04dc48464aef43869.1566470526.git.agx@sigxcpu.org>
In-Reply-To: <36f62b431f32bc76e92d21e04dc48464aef43869.1566470526.git.agx@sigxcpu.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 07:09:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLOa9yg+oWHM4o8b8b=4DGYC40b3o7YB_pKHSOTBEuvTA@mail.gmail.com>
Message-ID: <CAL_JsqLOa9yg+oWHM4o8b8b=4DGYC40b3o7YB_pKHSOTBEuvTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display/bridge: Add binding for NWL
 mipi dsi host controller
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 5:44 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> ---
>  .../bindings/display/bridge/nwl-dsi.yaml      | 155 ++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-=
dsi.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yam=
l b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> new file mode 100644
> index 000000000000..24d17a6310dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) is preferred for new bindings.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/nwl-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Northwest Logic MIPI-DSI controller on i.MX SoCs
> +
> +maintainers:
> +  - Guido G=C3=BAnther <agx@sigxcpu.org>
> +  - Robert Chiras <robert.chiras@nxp.com>
> +
> +description: |
> +  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi b=
ridge for
> +  the SOCs NWL MIPI-DSI host controller.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8mq-nwl-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: DSI core clock
> +      - description: RX_ESC clock (used in escape mode)
> +      - description: TX_ESC clock (used in escape mode)
> +      - description: PHY_REF clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: rx_esc
> +      - const: tx_esc
> +      - const: phy_ref
> +
> +  mux-controls:
> +    description:
> +      mux controller node to use for operating the input mux
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      A phandle to the phy module representing the DPHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      A phandle to the power domain

Don't need a description for common properties unless you have
something specific about this device to say.

> +
> +  resets:
> +    description:
> +      phandles to the reset controller

Same here.

> +    items:
> +      - description: dsi byte reset line
> +      - description: dsi dpi reset line
> +      - description: dsi esc reset line
> +      - description: dsi pclk reset line
> +
> +  reset-names:
> +    items:
> +      - const: byte
> +      - const: dpi
> +      - const: esc
> +      - const: pclk
> +
> +  ports:
> +    type: object
> +    description:
> +      A node containing DSI input & output port nodes with endpoint
> +      definitions as documented in
> +      Documentation/devicetree/bindings/graph.txt.
> +
> +  port@0:

These are child nodes of ports. So under ports you need 'properties'
with these. And 'required'.

> +    type: object
> +    description:
> +      Input port node to receive pixel data from the
> +      display controller
> +
> +  port@1:
> +    type: object
> +    description:
> +      DSI output port node to the panel or the next bridge
> +      in the chain
> +
> +patternProperties:
> +  "^panel@[0-9]+$": true

This is a node, so:

type: object

> +
> +required:
> +  - clock-names
> +  - clocks
> +  - compatible
> +  - interrupts
> +  - mux-controls
> +  - phy-names
> +  - phys
> +  - ports
> +  - reg
> +  - reset-names
> +  - resets

Add a:

additionalProperties: false

> +
> +examples:
> + - |
> +
> +   mipi_dsi: mipi_dsi@30a00000 {
> +              #address-cells =3D <1>;
> +              #size-cells =3D <0>;

These need to be listed above.

> +              compatible =3D "fsl,imx8mq-nwl-dsi";
> +              reg =3D <0x30A00000 0x300>;
> +              clocks =3D <&clk 163>, <&clk 244>, <&clk 245>, <&clk 164>;
> +              clock-names =3D "core", "rx_esc", "tx_esc", "phy_ref";
> +              interrupts =3D <0 34 4>;
> +              mux-controls =3D <&mux 0>;
> +              power-domains =3D <&pgc_mipi>;
> +              resets =3D <&src 0>, <&src 1>, <&src 2>, <&src 3>;
> +              reset-names =3D "byte", "dpi", "esc", "pclk";
> +              phys =3D <&dphy>;
> +              phy-names =3D "dphy";
> +
> +              panel@0 {
> +                      compatible =3D "rocktech,jh057n00900";
> +                      reg =3D <0>;
> +                      port@0 {
> +                           panel_in: endpoint {
> +                                     remote-endpoint =3D <&mipi_dsi_out>=
;
> +                           };
> +                      };
> +              };
> +
> +              ports {
> +                    #address-cells =3D <1>;
> +                    #size-cells =3D <0>;
> +
> +                    port@0 {
> +                           reg =3D <0>;
> +                           mipi_dsi_in: endpoint {
> +                                        remote-endpoint =3D <&lcdif_mipi=
_dsi>;
> +                           };
> +                    };
> +                    port@1 {
> +                           reg =3D <1>;
> +                           mipi_dsi_out: endpoint {
> +                                         remote-endpoint =3D <&panel_in>=
;
> +                           };
> +                    };
> +              };
> +      };
> --
> 2.20.1
>

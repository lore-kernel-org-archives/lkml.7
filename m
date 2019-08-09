Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E046C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166972166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565383279;
	bh=jH76td/fjPbji37vUuoEOl0cAWi+FLQQq8X+Jvp5axk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lT6hg2htNg1Lz/GJLNc+dVQQV/flQw7RRs1X71OMLz3bRcbrxfx1X8dva9tt47Hdt
	 9z6/wZwPDNdEPIF2gfWWvLNsHcFdQehZeciNf3zrdMdcEnf9Z/e7yPMda1LAkRWSNa
	 O1zoGQ6eZra9xQuQNXlZH8AN3hI7HVA2BhmZ9iGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHIUlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfHIUlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:41:17 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFEF21773;
        Fri,  9 Aug 2019 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565383276;
        bh=jH76td/fjPbji37vUuoEOl0cAWi+FLQQq8X+Jvp5axk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NstuP3aD+IlthPjBC0yNZYVUqWRILTuyfQbSnLJJuj/pod7Veuf685tucddcbk4Sn
         6BR0ilf0Fu/absVLvAV5u/QXqD3uvA0p+xrFhMb2RzVZ7gcW2Si3AKjF+y6aCCn4e7
         Z6jnAOn+KKQIMq4nhDtS6Bs8XfO39zPwXJmJyf+4=
Received: by mail-qk1-f177.google.com with SMTP id s145so72710492qke.7;
        Fri, 09 Aug 2019 13:41:15 -0700 (PDT)
X-Gm-Message-State: APjAAAV1qZCMhXkwk6J4/ux3MD4cKKFKq56fxROaRc3Hnbop0ruDMkYq
        K/kll01xDXhDI2LMnJwiA/fkvB0/N/ul1C5ucw==
X-Google-Smtp-Source: APXvYqw63vyKep4tpTwbJMpFL4gA+OkZ6rgw4CjtZ8844b0OPY8solEom0vl1eN7fJ5bsvWFGTAptgVku0GyIwjQ9nA=
X-Received: by 2002:a37:a010:: with SMTP id j16mr20480818qke.152.1565383275104;
 Fri, 09 Aug 2019 13:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565367567.git.agx@sigxcpu.org> <9c906bb6592424acdb1a67447a482e010a113b49.1565367567.git.agx@sigxcpu.org>
In-Reply-To: <9c906bb6592424acdb1a67447a482e010a113b49.1565367567.git.agx@sigxcpu.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Aug 2019 14:41:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-5=WMZgNuJDTJ3Dm3YOJNw_9QCrPOOSe7MQzMV26pHw@mail.gmail.com>
Message-ID: <CAL_JsqK-5=WMZgNuJDTJ3Dm3YOJNw_9QCrPOOSe7MQzMV26pHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display/bridge: Add binding for NWL
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
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 10:24 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
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
> index 000000000000..5ed8bc4a4d18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/imx-nwl-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Northwest Logic MIPI-DSI on imx SoCs
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
> +    oneOf:
> +      - items:
> +        - const: fsl,imx8mq-nwl-dsi

Don't need oneOf nor items here for a single possible value:

compatible:
  const: fsl,imx8mq-nwl-dsi

Or go ahead and add other compatibles because the 'if' below seems to
indicate you'll have more.

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
> +
> +  resets:
> +    maxItems: 4
> +    description:
> +      A phandle to the reset controller

Sounds like 4 phandles... This should look similar to 'clocks'.

> +
> +  reset-names:
> +    items:
> +      - const: byte
> +      - const: dpi
> +      - const: esc
> +      - const: pclk
> +
> +  mux-sel:

Needs a vendor prefix and will need a $ref to the type.

> +    maxItems: 1
> +    description:
> +      A phandle to the MUX register set
> +
> +  port:
> +    type: object
> +    description:
> +      A input put or output port node.
> +
> +  ports:
> +    type: object
> +    description:
> +      A node containing DSI input & output port nodes with endpoint
> +      definitions as documented in
> +      Documentation/devicetree/bindings/graph.txt.

You need to define what port@0 and port@1 are.

> +
> +patternProperties:
> +  "^panel@[0-9]+$": true
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mq-nwl-dsi

This conditional isn't needed until you have more than one compatible.

> +      required:
> +        - resets
> +        - reset-names
> +        - mux-sel
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names

ports should be required.

> +
> +examples:
> + - |
> +
> +   mipi_dsi: mipi_dsi@30a00000 {
> +              #address-cells =3D <1>;
> +              #size-cells =3D <0>;
> +              compatible =3D "fsl,imx8mq-nwl-dsi";
> +              reg =3D <0x30A00000 0x300>;
> +              clocks =3D <&clk 163>, <&clk 244>, <&clk 245>, <&clk 164>;
> +              clock-names =3D "core", "rx_esc", "tx_esc", "phy_ref";
> +              interrupts =3D <0 34 4>;
> +              power-domains =3D <&pgc_mipi>;
> +              resets =3D <&src 0>, <&src 1>, <&src 2>, <&src 3>;
> +              reset-names =3D "byte", "dpi", "esc", "pclk";
> +              mux-sel =3D <&iomuxc_gpr>;
> +              phys =3D <&dphy>;
> +              phy-names =3D "dphy";
> +
> +              panel@0 {
> +                      compatible =3D "...";

Needs to be a valid compatible. Also need 'reg' here or drop the unit-addre=
ss.


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

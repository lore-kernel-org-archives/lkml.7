Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E984C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D87C2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KkIlznEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406842AbfIWI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:59:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55459 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405374AbfIWI7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:59:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190923085936euoutp029b0dcb7836f285c30a7ed08def0a96c9~HBZ8efFVl1648816488euoutp02R
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 08:59:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190923085936euoutp029b0dcb7836f285c30a7ed08def0a96c9~HBZ8efFVl1648816488euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569229176;
        bh=n+Pp880jnFM0iccPSEpCzg0MYcWPdHFdFFri+tpf0lM=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=KkIlznElKejS+tX5d1yixx6cNrABgP345VNLnatqjT+iikeG8pifVQU+HKhHybtA/
         jPSD+fkfiKs1Ynujbvhxl8WN70en4Imixgd1v60R1uOE3BC88pTz4wm5dHeVRr7wVK
         aWNm6rO0BKrTxVu3UKdYgSrLSph3h59klnCQNXYA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190923085935eucas1p26db86ed226166527103fa2ed9270dbc9~HBZ79qrSS0371203712eucas1p2I;
        Mon, 23 Sep 2019 08:59:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.99.04309.779888D5; Mon, 23
        Sep 2019 09:59:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190923085935eucas1p262d0484a4fc9b6b174c382c8d4a4e942~HBZ7rmCZb1673316733eucas1p2O;
        Mon, 23 Sep 2019 08:59:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190923085935eusmtrp29652c30fa5a7bbcfebcd61d7c8f5a423~HBZ7osPBg0328103281eusmtrp2-;
        Mon, 23 Sep 2019 08:59:35 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-72-5d8889772ca0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.38.04166.779888D5; Mon, 23
        Sep 2019 09:59:35 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190923085934eusmtip29debb2717068212c94470229fe6850d7~HBZ6k5Ncz1176911769eusmtip2z;
        Mon, 23 Sep 2019 08:59:33 +0000 (GMT)
Subject: Re: [PATCH v6 1/2] dt-bindings: display/bridge: Add binding for NWL
 mipi dsi host controller
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <18619804-ffe8-f3a5-aa54-ab590b3a83c0@samsung.com>
Date:   Mon, 23 Sep 2019 10:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3bef8eb6a7dd32406e31c68f39ccde3accb58222.1569170717.git.agx@sigxcpu.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0yTZxTm/W79aFb28YHrCZohTbZMjOjUH28y08zEH2/iD8UfxAzZ7OAL
        OGkhrYhoNl0mt+IFaphQmuEaiOUyhUqLgGyxIIgCDpCbYStEfwAZwuRiQCvafhj595znOec8
        z3nz8rTo4CL4Y4YTktGgS9VwSsbdsdy7LTM/L2HH3IUo/P/PEyy+2NtFYZ+lQ4FX3UU0Lm/v
        ZfHjxVkOTwwewIMvp2jc9d8gg6uLmxicX1ShwN7Fewg7nw6x2LxSReOBZhuHK4f7KOy5FI/v
        lntYnN3arsC+RieDHcsuhCcb1F9/Qmp/q0Xk1YoFkdmRbAVpXbrGkCbrPwpSllfKEmd1Pkfu
        F/ZTZGzoDkcal8ZZ4i3opMitirOk/vltilz27SAVvw5yxFrgRgfFb5R7kqTUYycl43btUWXK
        4mUzk96z7ZSvYZ47h2Y3mRHPg7AbSuwfm5GSFwUHgm7HFCUXCwiuT71h5GIewchYP2tGwYGJ
        K7nDnCxcR5D9uBnJxQyCpar7Cn9XmJAMDy2vA7vChS4OiuxWxi9wwhbw3Rrl/OYqQQslud/6
        aUb4DEYHagItG4TD8GK8LeCmEkKhq/RZgA8W4qB7tJvyY1qIhF9cZbSM1fDkWXnAC4RxHjrq
        hxk56j6orqnjZBwG050NChlvgtWmckrGZ8HrOE/Lw3kIXHVNtCx8BW2dfaw/KP0u9M3m7TK9
        F9wtTxXy44XAyEyonCEELO6rtEyrIC9HlLujwNvjWluohsq/F9fSEKhY/oMtRFHWdVda111m
        XXeZ9UOGa4ipRmopw6RPlkw7DVJmjEmnN2UYkmMS0/RO9O7/PnzTuXAbNb/+3oMEHmk+Us3V
        5yaIrO6kKUvvQcDTmnCVMzonQVQl6bJOS8a074wZqZLJgzbyjEatOhM0Hi8KyboT0nFJSpeM
        71WKD444hyJbW0ZnJqMnlUFpG2d+HEiy9fXHaLN6/qK36Ob/fTG9YN8ctvWHT+fO1Ec+2rP7
        J1v8xJOyUP3prZmndi0kWsTKtpslhQ9u3F39gjC//xl3sbhBtA2NaY947LGxRbsi7BN3XFXa
        OEPdfg17xfucPZhme9nvceYcCiqotMZ8vk+70q5hTCm6L6Npo0n3Fhn686m7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsVy+t/xe7rlnR2xBp8ecFt8bHzIatF77iST
        xd9Jx9gt/m+byGwx/8g5VosrX9+zWTy86m9x9ftLZouTb66yWKyaupPFonPiEnaL+1+PMlps
        enyN1aLr10pmi8u75rBZLL1+kcniUF+0xcH5h1gtWvceYbf4u30Ti8WKn1sZLV5sEXcQ81gz
        bw2jx+9fkxg93t9oZffY+20Bi8fOWXfZPWZ3zGT12LSqk83jxIRLTB53ru1h89j+7QGrx/3u
        40wem5fUe2x8t4PJo/+vgceSaVfZPGZ1b2MMEIrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMy
        sdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/ja38VScFa34u+Wz2wNjO9luhg5OSQETCQmt19n
        62Lk4hASWMooMbvjMwtEQlxi9/y3zBC2sMSfa11QRa8ZJfa1PGEESQgLpEucnvSHCSQhInCa
        TeJf726oqkuMEp0TD4O1swloSvzdfBMowcHBK2AnMaM9DiTMIqAqcfPyarBtogIREod3zAIb
        yisgKHFy5hOwOKdAmMSZm2eYQGxmAXWJP/MuMUPY8hLNW2dD2eISt57MZ5rAKDgLSfssJC2z
        kLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmBq2Xbs5+YdjJc2Bh9iFOBgVOLh
        /bCxPVaINbGsuDL3EKMEB7OSCO8mrbZYId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4Hpr28
        knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M07x830kKJrpsMdm2
        4lZqUrAGR41UpPj2TyYHlfgT9q/+WRXGvCS117W7z6jEZZNae4df3smTEdah5z0bMruO7Uh2
        u8xy0GBrrqOXYMv+RkfrwL95c2/M5mVZfPOv+oJ0psRJLYr7e9871AuH7p3R/n+J8GlNGQ7e
        vqM3sqe+FbgiotnN26jEUpyRaKjFXFScCACmq0OKQwMAAA==
X-CMS-MailID: 20190923085935eucas1p262d0484a4fc9b6b174c382c8d4a4e942
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190922164722epcas3p2c44bddf9e6fd86cae5ab72ca078296b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190922164722epcas3p2c44bddf9e6fd86cae5ab72ca078296b8
References: <cover.1569170717.git.agx@sigxcpu.org>
        <CGME20190922164722epcas3p2c44bddf9e6fd86cae5ab72ca078296b8@epcas3p2.samsung.com>
        <3bef8eb6a7dd32406e31c68f39ccde3accb58222.1569170717.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.2019 18:47, Guido Günther wrote:
> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Tested-by: Robert Chiras <robert.chiras@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/bridge/nwl-dsi.yaml      | 176 ++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> new file mode 100644
> index 000000000000..31119c7885ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/url?k=7c9397fbdbbe3fd5.7c921cb4-87fc4542b5f41502&u=http://devicetree.org/schemas/display/bridge/nwl-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Northwest Logic MIPI-DSI controller on i.MX SoCs
> +
> +maintainers:
> +  - Guido Gúnther <agx@sigxcpu.org>
> +  - Robert Chiras <robert.chiras@nxp.com>
> +
> +description: |
> +  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
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
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
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
> +
> +  resets:
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
> +    properties:
> +      port@0:
> +        type: object
> +        description:
> +          Input port node to receive pixel data from the
> +          display controller
> +
> +      port@1:
> +        type: object
> +        description:
> +          DSI output port node to the panel or the next bridge
> +          in the chain
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +      - port@0
> +      - port@1
> +
> +    additionalProperties: false
> +
> +patternProperties:
> +  "^panel@[0-9]+$":
> +    type: object
> +
> +required:
> +  - '#address-cells'
> +  - '#size-cells'
> +  - clock-names
> +  - clocks
> +  - compatible
> +  - interrupts
> +  - mux-controls


As I understand mux is not a part of the device, so maybe would be safer
to make it optional.


Regards

Andrzej


> +  - phy-names
> +  - phys
> +  - ports
> +  - reg
> +  - reset-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> + - |
> +
> +   mipi_dsi: mipi_dsi@30a00000 {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +              compatible = "fsl,imx8mq-nwl-dsi";
> +              reg = <0x30A00000 0x300>;
> +              clocks = <&clk 163>, <&clk 244>, <&clk 245>, <&clk 164>;
> +              clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
> +              interrupts = <0 34 4>;
> +              mux-controls = <&mux 0>;
> +              power-domains = <&pgc_mipi>;
> +              resets = <&src 0>, <&src 1>, <&src 2>, <&src 3>;
> +              reset-names = "byte", "dpi", "esc", "pclk";
> +              phys = <&dphy>;
> +              phy-names = "dphy";
> +
> +              panel@0 {
> +                      compatible = "rocktech,jh057n00900";
> +                      reg = <0>;
> +                      port@0 {
> +                           panel_in: endpoint {
> +                                     remote-endpoint = <&mipi_dsi_out>;
> +                           };
> +                      };
> +              };
> +
> +              ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                           reg = <0>;
> +                           mipi_dsi_in: endpoint {
> +                                        remote-endpoint = <&lcdif_mipi_dsi>;
> +                           };
> +                    };
> +                    port@1 {
> +                           reg = <1>;
> +                           mipi_dsi_out: endpoint {
> +                                         remote-endpoint = <&panel_in>;
> +                           };
> +                    };
> +              };
> +      };



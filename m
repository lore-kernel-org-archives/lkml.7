Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7CDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3247208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Lu8pZWub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437950AbfITJqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:46:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46842 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405677AbfITJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:46:43 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 670A62F9;
        Fri, 20 Sep 2019 11:46:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1568972800;
        bh=bRLmjbhnSSP0moxtZ17hSqVSQInW7dHhJDatUnBMgi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lu8pZWubSJdCU1gSJfa5CiuZFmhlKfyPIWdZXnvUfksOgqDWy4/CeHnJJwnhIrY1a
         xkvLkVlfDzJhf7sbvbgvVp/IvsKQwAvECXx0yn+nFDRR+ZiDwC1r8+kKrqdQIHtmk8
         6AAo75lBu2Qz8cMrrrGJPh1kPK4cFPCqtHktqoRc=
Date:   Fri, 20 Sep 2019 12:46:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Message-ID: <20190920094621.GA12950@pendragon.ideasonboard.com>
References: <cover.1568957788.git.xji@analogixsemi.com>
 <606dba07640f0c9aba930e1dfb5d6a797f393ecc.1568957789.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <606dba07640f0c9aba930e1dfb5d6a797f393ecc.1568957789.git.xji@analogixsemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xin Ji,

Thank you for the patch.

On Fri, Sep 20, 2019 at 06:05:03AM +0000, Xin Ji wrote:
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI to DisplayPort 1.3 4K.

I assume you meant MIPI DSI ? MIPI has released more standards than DSI,
so it doesn't hurt to specify this explicitly.

According to
https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_ProductBrief_0.pdf,
the ANX7625 supports for MIPI DSI and DPI on the input side.
Furthermore, it seems to output DisplayPort on USB Type-C. Should this
be documented ?

> You can add support to your board with binding.
> 
> Example:
> 	anx_bridge: anx7625@58 {
> 		compatible = "analogix,anx7625";
> 		reg = <0x58>;
> 		low-power-mode = <1>;
> 		dsi-supported = <1>;
> 		dsi-channel-id = <1>;
> 		dsi-lanes-num = <4>;
> 		internal-pannel-supported = <1>;
> 		pon-gpios = <&gpio0 45 GPIO_ACTIVE_LOW>;
> 		reset-gpios = <&gpio0 73 GPIO_ACTIVE_LOW>;
> 		status = "okay";
> 		port {
> 			anx7625_1_in: endpoint {
> 				remote-endpoint = <&mipi_dsi_bridge_1>;
> 			};
> 		};
> 	};
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/anx7625.yaml           | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> new file mode 100644
> index 0000000..95fe18b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Analogix Semiconductor, Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/anx7625.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
> +
> +maintainers:
> +  - Xin Ji <xji@analogixsemi.com>
> +
> +description: |
> +  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> +  designed for portable devices.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: analogix,anx7625
> +
> +  reg:
> +    maxItems: 1
> +
> +  low-power-gpios:
> +    description: Low power mode support feature
> +    maxItems: 1
> +
> +  hpd-gpios:
> +    description: used for HPD interrupt
> +    maxItems: 1
> +
> +  pon-gpios:
> +    description: used for power on chip control
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: used for reset chip control
> +    maxItems: 1

How about mentioning which pin of the ANX7625 each GPIO refers to ? For
the low-power, pon and reset GPIOs I assume they directly control the
chip. We have standard names for some GPIOs, such as reset or enable. Is
there one of the low-power and pon GPIOs that would qualify as an enable
signal ?

What is the HPD GPIO for ? Does the chip output and HPD signal ?

> +
> +  extcon-supported:
> +    description: external connector interface support flag
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  internal-pannel-supported:
> +    description: indicate does internal pannel exist or not
> +    $ref: /schemas/types.yaml#/definitions/uint32

s/pannel/panel/

Are those two properties mutually exclusive ? If so you should combine
them in a single required property with two values. My feeling is that
they should be dropped though, please see below.

> +
> +  dsi-supported:
> +    description: support MIPI DSI or DPI
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  dsi-channel-id:
> +    description: dsi channel index
> +    $ref: /schemas/types.yaml#/definitions/uint32

This does not belong to DT, the virtual channel used by the DSI source
should be queried at runtime by communicating between drivers.

> +
> +  dsi-lanes-num:
> +    description: dsi lanes used num
> +    $ref: /schemas/types.yaml#/definitions/uint32

Please use the standard data-lanes property as defined in
video-interface.txt. It should be specified in the DSI endpoints.

> +
> +  port@0:
> +    type: object
> +    description:
> +      A port node pointing to MIPI DSI host port node.

You need at least 3 ports:

- a DPI input port
- a DSI input port
- an output port

The dsi-supported property should be dropped, detecting the type of
input should be done based on which of the DPI or DSI input port is
connected.

Assuming the ANX7625 can also output DisplayPort directly without going
through USB Type-C (I can't verify that without the datasheet), I think
you should use two output ports, one for USB Type-C and one for
DisplayPort. The extcon-supported and internal-pannel-supported
properties should be removed, and deduced from the connect output port.

> +
> +required:
> +  - compatible
> +  - reg
> +  - dsi-channel-id
> +  - dsi-lanes-num
> +  - port@0
> +
> +example:
> +  - |
> +    anx_bridge: anx7625@58 {
> +        compatible = "analogix,anx7625";
> +        reg = <0x58>;
> +        low-power-gpios = <0>;
> +        dsi-supported = <1>;
> +        dsi-channel-id = <1>;
> +        dsi-lanes-num = <4>;
> +        hpd-gpios = <&gpio1 19 IRQ_TYPE_LEVEL_LOW>;
> +        status = "okay";
> +    };

You mention the port@0 node as being required, but it's missing from the
example.

-- 
Regards,

Laurent Pinchart

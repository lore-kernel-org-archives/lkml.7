Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CF8ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7A9206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s/OAY4zK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfJIMKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:10:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36602 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfJIMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:10:07 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D67CC4FF;
        Wed,  9 Oct 2019 14:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1570623005;
        bh=PhDy22LrAQFV8Qw9nKo9Fl2O0XPBZ7UF53kHk9fNHd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/OAY4zKq9Khyr4jLxDi3B11juGmESo3MpIm8kqWoJMxRl6UqddUXbz8eJ6PeqIRr
         JSXDUg9LnCqIiqr+PEW9E5W6nOe6rtry1XJ7FehyW8AoInJep7rwxyht1DGFvEiDxJ
         cwIbpMyTXLI1/0JA3Frqj5A4Hz8RmmN8tyj41ig0=
Date:   Wed, 9 Oct 2019 15:10:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Message-ID: <20191009121003.GM22998@pendragon.ideasonboard.com>
References: <cover.1570588741.git.xji@analogixsemi.com>
 <82d9e3d505699da8f32069844b3cfe7c9fbfd0f1.1570588741.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82d9e3d505699da8f32069844b3cfe7c9fbfd0f1.1570588741.git.xji@analogixsemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin Ji,

Thank you for the patch.

On Wed, Oct 09, 2019 at 09:27:07AM +0000, Xin Ji wrote:
> The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> for portable device. It converts MIPI to DisplayPort 1.3 4K.
> 
> You can add support to your board with binding.
> 
> Example:
> 	anx_bridge: anx7625@58 {
> 		compatible = "analogix,anx7625";
> 		reg = <0x58>;
> 		enable-gpios = <&gpio0 45 GPIO_ACTIVE_LOW>;
> 		reset-gpios = <&gpio0 73 GPIO_ACTIVE_LOW>;
> 		status = "okay";
> 		port@0 {
> 			reg = <0>;
> 			anx7625_1_in: endpoint {
> 				remote-endpoint = <&mipi_dsi_bridge_1>;
> 			};
> 		};
> 	};
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/anx7625.yaml           | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> new file mode 100644
> index 0000000..0ef6271
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> @@ -0,0 +1,79 @@
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
> +  hpd-gpios:
> +    description: used for HPD interrupt
> +    maxItems: 1

You explained in your reply to v1 review that this describes the
interrupt generated by the ANX7625. It should be replaced by an
interrupts property.

> +
> +  enable-gpios:
> +    description: used for power on chip control
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: used for reset chip control
> +    maxItems: 1

Could you please mention the exact name of the corresponding pins on the
chip for enable and reset ?

> +
> +  port@0:
> +    type: object
> +    description:
> +      A port node pointing to MIPI DSI host port node.
> +
> +  port@1:
> +    type: object
> +    description:
> +      A port node pointing to MIPI DPI host port node.
> +
> +  port@2:
> +    type: object
> +    description:
> +      A port node pointing to external connector port node.
> +
> +  port@3:
> +    type: object
> +    description:
> +      A port node pointing to internal panel port node.
> +
> +  port@4:
> +    type: object
> +    description:
> +      A port node pointing to normal eDP port node.

I don't think three output ports is correct. Ports 3 and 4 are really
the same. I'm even unsure about port 2 and 3, someone with better
knowledge of USB-C and DisplayPort would be in a better position to
comment.

> +

You're missing the #address-cells and #size-cells properties required
for the ports. As the device is an I2C device we're lucky that the
parent will specify compatible address and size cells numbers, but I'm
not sure we should rely on that luck.

Rob, how does yaml schema handle this ?

> +required:
> +  - compatible
> +  - reg
> +  - port@0 | port@1
> +
> +example:
> +  - |
> +    anx_bridge: anx7625@58 {

The node name should describe the device's function. How about
encoder@58 ?

> +        compatible = "analogix,anx7625";
> +        reg = <0x58>;
> +        status = "okay";
> +        port@0 {
> +          reg = <0>;
> +          anx7625_1_in: endpoint {
> +            remote-endpoint = <&mipi_dsi_bridge_1>;
> +          };
> +        };
> +    };

-- 
Regards,

Laurent Pinchart

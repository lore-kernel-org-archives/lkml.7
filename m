Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D3EC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EAA206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ie61FfgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfJKMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:54:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36298 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfJKMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:54:23 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9342E33A;
        Fri, 11 Oct 2019 14:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1570798460;
        bh=na56nwT81kmZAQn4N6ZkIrQhhyjZQWOLU7e1j5mpmBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ie61FfgLthUz7cPPIMrWn//FPuV8ni004oXZwZUs9TmXAD5EOKer+TRjmhr+4jEkP
         JnusZknG7fUyQT9ey0usVjg95TzG1VuSb/y1IrfSJt61ZzjRZbAMbOX0y0buxw34Au
         3XlVsF26O84xhZEKQaerlgyz5f5Vd1/+dv24MoUA=
Date:   Fri, 11 Oct 2019 15:54:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Xin Ji <xji@analogixsemi.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
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
Message-ID: <20191011125418.GE4882@pendragon.ideasonboard.com>
References: <cover.1570760115.git.xji@analogixsemi.com>
 <CGME20191011022154epcas3p1a719423a23f8bf193b6136e853e66b04@epcas3p1.samsung.com>
 <75bb8a47d2c3c1f979c6d62158c21988b846e79b.1570760115.git.xji@analogixsemi.com>
 <3c6067de-9f3c-b93c-f263-fa5dd09c3270@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c6067de-9f3c-b93c-f263-fa5dd09c3270@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Fri, Oct 11, 2019 at 01:21:43PM +0200, Andrzej Hajda wrote:
> On 11.10.2019 04:21, Xin Ji wrote:
> > The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
> > for portable device. It converts MIPI to DisplayPort 1.3 4K.
> >
> > You can add support to your board with binding.
> >
> > Example:
> > 	anx7625_bridge: encoder@58 {
> > 		compatible = "analogix,anx7625";
> > 		reg = <0x58>;
> > 		status = "okay";
> > 		panel-flags = <1>;
> > 		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> > 		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> >
> > 		port@0 {
> > 		  reg = <0>;
> > 		  anx_1_in: endpoint {
> > 		    remote-endpoint = <&mipi_dsi>;
> > 		  };
> > 		};
> >
> > 		port@3 {
> > 		  reg = <3>;
> > 		  anx_1_out: endpoint {
> > 		    remote-endpoint = <&panel_in>;
> > 		  };
> > 		};
> > 	};
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  .../bindings/display/bridge/anx7625.yaml           | 96 ++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> > new file mode 100644
> > index 0000000..fc84683
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2019 Analogix Semiconductor, Inc.
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/display/bridge/anx7625.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
> > +
> > +maintainers:
> > +  - Xin Ji <xji@analogixsemi.com>
> > +
> > +description: |
> > +  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> > +  designed for portable devices.
> > +
> > +properties:
> > +  "#address-cells": true
> > +  "#size-cells": true
> > +
> > +  compatible:
> > +    items:
> > +      - const: analogix,anx7625
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  panel-flags:
> > +    description: indicate the panel is internal or external
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description: used for power on chip control, POWER_EN pin D2.
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description: used for reset chip control, RESET_N pin B7.
> > +    maxItems: 1
> > +
> > +  port@0:
> > +    type: object
> > +    description:
> > +      A port node pointing to MIPI DSI host port node.
> > +
> > +  port@1:
> > +    type: object
> > +    description:
> > +      A port node pointing to MIPI DPI host port node.
> > +
> > +  port@2:
> > +    type: object
> > +    description:
> > +      A port node pointing to external connector port node.
> > +
> > +  port@3:
> > +    type: object
> > +    description:
> > +      A port node pointing to eDP port node.
> 
> 
> Decrypting available product brief[1], there are following physical lines:
> 
> Input:
> 
> - MIPI DSI/DPI - video data, are DSI and DPI lines shared?

It would be much easier if we could have access to more complete
information. I believe the DSI and DPI pins could be muxed, but there
should be more DPI pins than DSI pins.

> 
> - I2S - audio data,
> 
> - I2C - control line,
> 
> - ALERT/INTP - interrupt,
> 
> - USB 3.1 SSRc/Tx - for USB forwarding,
> 
> Output:
> 
> - SS1, SS2,
> 
> - SBU/AUX,
> 
> - CC1/2.
> 
> 
> Having this information I try to understand ports defined by you:
> 
> - port@2 you have defined as pointing to external port, but here the
> port should be rather subnode of ANX7625 - the chip has CC lines, see
> beginning of [2].
> 
> - port@3 describes SS1, SS2 and SBU/AUX lines together, am I right? In
> USB-C binding SBU and SS lines are represented by different ports,
> different approach, but maybe better in this case.

I believe that, when connected to a DP display (either DP or eDP), the
DisplayPort signals are output on SS1 and/or SS2. I this really wonder
if we need two separate ports for this, it seems that port@2 and port@3
should be merged.

> Maybe it would be good to add 2nd example with USB-C port.

That would help with the discussion, yes.

> [1]:
> https://www.analogix.com/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf
> 
> [2]: Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> > +
> > +required:
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - compatible
> > +  - reg
> > +  - port@0
> > +  - port@3
> > +
> > +example:
> > +  - |
> > +    anx7625_bridge: encoder@58 {
> > +        compatible = "analogix,anx7625";
> > +        reg = <0x58>;
> > +        status = "okay";
> > +        panel-flags = <1>;
> > +        enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> > +        reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        port@0 {
> > +          reg = <0>;
> > +          anx_1_in: endpoint {
> > +            remote-endpoint = <&mipi_dsi>;
> > +          };
> > +        };
> > +
> > +        port@3 {
> > +          reg = <3>;
> > +          anx_1_out: endpoint {
> > +            remote-endpoint = <&panel_in>;
> > +          };
> > +        };
> > +    };

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A30DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2086D2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFTGzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:55:17 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:35388 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTGzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:55:16 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7462F80635;
        Thu, 20 Jun 2019 08:55:10 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:55:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: display: Convert common panel
 bindings to DT schema
Message-ID: <20190620065508.GA24739@ravnborg.org>
References: <20190619215156.27795-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619215156.27795-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=7gkXJVJtAAAA:8 a=P-IC7800AAAA:8 a=P1BnusSwAAAA:8 a=e5mUnYsNAAAA:8
        a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=TU7F6JjL0PMMwWEaOtoA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=d3PnA9EDa4IxuAV0gXij:22
        a=D0XLA9XvdZm18NrgonBM:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=AjGcO6oz07-iQ99wixmX:22 a=sptkURWiP4Gy88Gu7hUp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob.

Thanks for starting the conversion of panel bindings to yaml.

On Wed, Jun 19, 2019 at 03:51:53PM -0600, Rob Herring wrote:
> Convert the common panel bindings to DT schema consolidating scattered
> definitions to a single schema file.
> 
> The 'simple-panel' binding just a collection of properties and not a
> complete binding itself. All of the 'simple-panel' properties are
> covered by the panel-common.txt binding with the exception of the
> 'no-hpd' property, so add that to the schema.
> 
> As there are lots of references to simple-panel.txt, just keep the file
> with a reference to panel-common.yaml for now until all the bindings are
> converted.
Good idea.

> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note there's still some references to panel-common.txt that I need to 
> update or just go ahead and convert to schema.
Better let it point to the .yaml variant, so this patchset does not
depend on too much other bindings to be converted.
Then we can start the conversion of the remaining panel bindings.
Any tooling that helps the conversions?

When this hits upstream I assume all future panel bindings shall be yaml
based - so we have a few pending contributions that need to do something.

For the actual conversion below:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
> 
>  .../bindings/display/panel/panel-common.txt   | 101 -------------
>  .../bindings/display/panel/panel-common.yaml  | 143 ++++++++++++++++++
>  .../bindings/display/panel/panel.txt          |   4 -
>  .../bindings/display/panel/simple-panel.txt   |  29 +---
>  4 files changed, 144 insertions(+), 133 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/panel.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> deleted file mode 100644
> index 5d2519af4bb5..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> +++ /dev/null
> @@ -1,101 +0,0 @@
> -Common Properties for Display Panel
> -===================================
> -
> -This document defines device tree properties common to several classes of
> -display panels. It doesn't constitue a device tree binding specification by
> -itself but is meant to be referenced by device tree bindings.
> -
> -When referenced from panel device tree bindings the properties defined in this
> -document are defined as follows. The panel device tree bindings are
> -responsible for defining whether each property is required or optional.
> -
> -
> -Descriptive Properties
> -----------------------
> -
> -- width-mm,
> -- height-mm: The width-mm and height-mm specify the width and height of the
> -  physical area where images are displayed. These properties are expressed in
> -  millimeters and rounded to the closest unit.
> -
> -- label: The label property specifies a symbolic name for the panel as a
> -  string suitable for use by humans. It typically contains a name inscribed on
> -  the system (e.g. as an affixed label) or specified in the system's
> -  documentation (e.g. in the user's manual).
> -
> -  If no such name exists, and unless the property is mandatory according to
> -  device tree bindings, it shall rather be omitted than constructed of
> -  non-descriptive information. For instance an LCD panel in a system that
> -  contains a single panel shall not be labelled "LCD" if that name is not
> -  inscribed on the system or used in a descriptive fashion in system
> -  documentation.
> -
> -
> -Display Timings
> ----------------
> -
> -- panel-timing: Most display panels are restricted to a single resolution and
> -  require specific display timings. The panel-timing subnode expresses those
> -  timings as specified in the timing subnode section of the display timing
> -  bindings defined in
> -  Documentation/devicetree/bindings/display/panel/display-timing.txt.
> -
> -
> -Connectivity
> -------------
> -
> -- ports: Panels receive video data through one or multiple connections. While
> -  the nature of those connections is specific to the panel type, the
> -  connectivity is expressed in a standard fashion using ports as specified in
> -  the device graph bindings defined in
> -  Documentation/devicetree/bindings/graph.txt.
> -
> -- ddc-i2c-bus: Some panels expose EDID information through an I2C-compatible
> -  bus such as DDC2 or E-DDC. For such panels the ddc-i2c-bus contains a
> -  phandle to the system I2C controller connected to that bus.
> -
> -
> -Control I/Os
> -------------
> -
> -Many display panels can be controlled through pins driven by GPIOs. The nature
> -and timing of those control signals are device-specific and left for panel
> -device tree bindings to specify. The following GPIO specifiers can however be
> -used for panels that implement compatible control signals.
> -
> -- enable-gpios: Specifier for a GPIO connected to the panel enable control
> -  signal. The enable signal is active high and enables operation of the panel.
> -  This property can also be used for panels implementing an active low power
> -  down signal, which is a negated version of the enable signal. Active low
> -  enable signals (or active high power down signals) can be supported by
> -  inverting the GPIO specifier polarity flag.
> -
> -  Note that the enable signal control panel operation only and must not be
> -  confused with a backlight enable signal.
> -
> -- reset-gpios: Specifier for a GPIO coonnected to the panel reset control
> -  signal. The reset signal is active low and resets the panel internal logic
> -  while active. Active high reset signals can be supported by inverting the
> -  GPIO specifier polarity flag.
> -
> -Power
> ------
> -
> -- power-supply: display panels require power to be supplied. While several
> -  panels need more than one power supply with panel-specific constraints
> -  governing the order and timings of the power supplies, in many cases a single
> -  power supply is sufficient, either because the panel has a single power rail,
> -  or because all its power rails can be driven by the same supply. In that case
> -  the power-supply property specifies the supply powering the panel as a phandle
> -  to a regulator.
> -
> -Backlight
> ----------
> -
> -Most display panels include a backlight. Some of them also include a backlight
> -controller exposed through a control bus such as I2C or DSI. Others expose
> -backlight control through GPIO, PWM or other signals connected to an external
> -backlight controller.
> -
> -- backlight: For panels whose backlight is controlled by an external backlight
> -  controller, this property contains a phandle that references the controller.
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> new file mode 100644
> index 000000000000..6fe87254edad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for Display Panels
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> +
> +description: |
> +  This document defines device tree properties common to several classes of
> +  display panels. It doesn't constitue a device tree binding specification by
> +  itself but is meant to be referenced by device tree bindings.
> +
> +  When referenced from panel device tree bindings the properties defined in this
> +  document are defined as follows. The panel device tree bindings are
> +  responsible for defining whether each property is required or optional.
> +
> +
> +properties:
> +  # Descriptive Properties
> +  width-mm:
> +    description: The width-mm and height-mm specify the width and height of the
> +      physical area where images are displayed. These properties are expressed
> +      in millimeters and rounded to the closest unit.
> +
> +  height-mm:
> +    description: The width-mm and height-mm specify the width and height of the
> +      physical area where images are displayed. These properties are expressed
> +      in millimeters and rounded to the closest unit.
> +
> +  label:
> +    description: |
> +      The label property specifies a symbolic name for the panel as a
> +      string suitable for use by humans. It typically contains a name inscribed
> +      on the system (e.g. as an affixed label) or specified in the system's
> +      documentation (e.g. in the user's manual).
> +
> +      If no such name exists, and unless the property is mandatory according to
> +      device tree bindings, it shall rather be omitted than constructed of
> +      non-descriptive information. For instance an LCD panel in a system that
> +      contains a single panel shall not be labelled "LCD" if that name is not
> +      inscribed on the system or used in a descriptive fashion in system
> +      documentation.
> +
> +  rotation:
> +    description:
> +      Display rotation in degrees counter clockwise (0,90,180,270)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [ 0, 90, 180, 270 ]
> +
> +  # Display Timings
> +  panel-timing:
> +    type: object
> +    description:
> +      Most display panels are restricted to a single resolution and
> +      require specific display timings. The panel-timing subnode expresses those
> +      timings as specified in the timing subnode section of the display timing
> +      bindings defined in
> +      Documentation/devicetree/bindings/display/panel/display-timing.txt.
> +
> +  # Connectivity
> +  ports:
> +    type: object
> +    description:
> +      Panels receive video data through one or multiple connections. While
> +      the nature of those connections is specific to the panel type, the
> +      connectivity is expressed in a standard fashion using ports as specified
> +      in the device graph bindings defined in
> +      Documentation/devicetree/bindings/graph.txt.
> +
> +  ddc-i2c-bus:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Some panels expose EDID information through an I2C-compatible
> +      bus such as DDC2 or E-DDC. For such panels the ddc-i2c-bus contains a
> +      phandle to the system I2C controller connected to that bus.
> +
> +  no-hpd:
> +    type: boolean
> +    description:
> +      This panel is supposed to communicate that it's ready via HPD
> +      (hot plug detect) signal, but the signal isn't hooked up so we should
> +      hardcode the max delay from the panel spec when powering up the panel.
> +
> +  # Control I/Os
> +
> +  # Many display panels can be controlled through pins driven by GPIOs. The nature
> +  # and timing of those control signals are device-specific and left for panel
> +  # device tree bindings to specify. The following GPIO specifiers can however be
> +  # used for panels that implement compatible control signals.
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: |
> +      Specifier for a GPIO connected to the panel enable control signal. The
> +      enable signal is active high and enables operation of the panel. This
> +      property can also be used for panels implementing an active low power down
> +      signal, which is a negated version of the enable signal. Active low enable
> +      signals (or active high power down signals) can be supported by inverting
> +      the GPIO specifier polarity flag.
> +
> +      Note that the enable signal control panel operation only and must not be
> +      confused with a backlight enable signal.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Specifier for a GPIO coonnected to the panel reset control signal.
> +      The reset signal is active low and resets the panel internal logic
> +      while active. Active high reset signals can be supported by inverting the
> +      GPIO specifier polarity flag.
> +
> +  # Power
> +  power-supply:
> +    description:
> +      Display panels require power to be supplied. While several panels need
> +      more than one power supply with panel-specific constraints governing the
> +      order and timings of the power supplies, in many cases a single power
> +      supply is sufficient, either because the panel has a single power rail, or
> +      because all its power rails can be driven by the same supply. In that case
> +      the power-supply property specifies the supply powering the panel as a
> +      phandle to a regulator.
> +
> +  # Backlight
> +
> +  # Most display panels include a backlight. Some of them also include a backlight
> +  # controller exposed through a control bus such as I2C or DSI. Others expose
> +  # backlight control through GPIO, PWM or other signals connected to an external
> +  # backlight controller.
> +
> +  backlight:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      For panels whose backlight is controlled by an external backlight
> +      controller, this property contains a phandle that references the
> +      controller.
> +
> +...
> diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
> deleted file mode 100644
> index e2e6867852b8..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/panel.txt
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -Common display properties
> --------------------------
> -
> -- rotation:	Display rotation in degrees counter clockwise (0,90,180,270)
> diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> index b2b872c710f2..e11208fb7da8 100644
> --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> @@ -1,28 +1 @@
> -Simple display panel
> -====================
> -
> -panel node
> -----------
> -
> -Required properties:
> -- power-supply: See panel-common.txt
> -
> -Optional properties:
> -- ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
> -- enable-gpios: GPIO pin to enable or disable the panel
> -- backlight: phandle of the backlight device attached to the panel
> -- no-hpd: This panel is supposed to communicate that it's ready via HPD
> -  (hot plug detect) signal, but the signal isn't hooked up so we should
> -  hardcode the max delay from the panel spec when powering up the panel.
> -
> -Example:
> -
> -	panel: panel {
> -		compatible = "cptt,claa101wb01";
> -		ddc-i2c-bus = <&panelddc>;
> -
> -		power-supply = <&vdd_pnl_reg>;
> -		enable-gpios = <&gpio 90 0>;
> -
> -		backlight = <&backlight>;
> -	};
> +See panel-common.yaml in this directory.
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

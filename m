Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB7C28CC3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 21:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E338F27798
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 21:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFAVk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 17:40:59 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37413 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfFAVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 17:40:58 -0400
X-Originating-IP: 82.246.155.60
Received: from localhost (hy283-1-82-246-155-60.fbx.proxad.net [82.246.155.60])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 23A16C0004;
        Sat,  1 Jun 2019 21:40:51 +0000 (UTC)
Date:   Sat, 1 Jun 2019 23:40:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Atmel board/soc bindings to
 json-schema
Message-ID: <20190601214050.GG3558@piout.net>
References: <20190517153911.19545-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517153911.19545-1-robh@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2019 10:39:11-0500, Rob Herring wrote:
> Convert Atmel SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v3:
> - correct maintainers
> 
>  .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
>  .../devicetree/bindings/arm/atmel-at91.yaml   | 133 ++++++++++++++++++
>  2 files changed, 133 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> deleted file mode 100644
> index 4bf1b4da7659..000000000000
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -Atmel AT91 device tree bindings.
> -================================
> -
> -Boards with a SoC of the Atmel AT91 or SMART family shall have the following
> -properties:
> -
> -Required root node properties:
> -compatible: must be one of:
> - * "atmel,at91rm9200"
> -
> - * "atmel,at91sam9" for SoCs using an ARM926EJ-S core, shall be extended with
> -   the specific SoC family or compatible:
> -    o "atmel,at91sam9260"
> -    o "atmel,at91sam9261"
> -    o "atmel,at91sam9263"
> -    o "atmel,at91sam9x5" for the 5 series, shall be extended with the specific
> -      SoC compatible:
> -       - "atmel,at91sam9g15"
> -       - "atmel,at91sam9g25"
> -       - "atmel,at91sam9g35"
> -       - "atmel,at91sam9x25"
> -       - "atmel,at91sam9x35"
> -    o "atmel,at91sam9g20"
> -    o "atmel,at91sam9g45"
> -    o "atmel,at91sam9n12"
> -    o "atmel,at91sam9rl"
> -    o "atmel,at91sam9xe"
> - * "atmel,sama5" for SoCs using a Cortex-A5, shall be extended with the specific
> -   SoC family:
> -    o "atmel,sama5d2" shall be extended with the specific SoC compatible:
> -       - "atmel,sama5d27"
> -    o "atmel,sama5d3" shall be extended with the specific SoC compatible:
> -       - "atmel,sama5d31"
> -       - "atmel,sama5d33"
> -       - "atmel,sama5d34"
> -       - "atmel,sama5d35"
> -       - "atmel,sama5d36"
> -    o "atmel,sama5d4" shall be extended with the specific SoC compatible:
> -       - "atmel,sama5d41"
> -       - "atmel,sama5d42"
> -       - "atmel,sama5d43"
> -       - "atmel,sama5d44"
> -
> - * "atmel,samv7" for MCUs using a Cortex-M7, shall be extended with the specific
> -   SoC family:
> -    o "atmel,sams70" shall be extended with the specific MCU compatible:
> -       - "atmel,sams70j19"
> -       - "atmel,sams70j20"
> -       - "atmel,sams70j21"
> -       - "atmel,sams70n19"
> -       - "atmel,sams70n20"
> -       - "atmel,sams70n21"
> -       - "atmel,sams70q19"
> -       - "atmel,sams70q20"
> -       - "atmel,sams70q21"
> -    o "atmel,samv70" shall be extended with the specific MCU compatible:
> -       - "atmel,samv70j19"
> -       - "atmel,samv70j20"
> -       - "atmel,samv70n19"
> -       - "atmel,samv70n20"
> -       - "atmel,samv70q19"
> -       - "atmel,samv70q20"
> -    o "atmel,samv71" shall be extended with the specific MCU compatible:
> -       - "atmel,samv71j19"
> -       - "atmel,samv71j20"
> -       - "atmel,samv71j21"
> -       - "atmel,samv71n19"
> -       - "atmel,samv71n20"
> -       - "atmel,samv71n21"
> -       - "atmel,samv71q19"
> -       - "atmel,samv71q20"
> -       - "atmel,samv71q21"
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> new file mode 100644
> index 000000000000..7cc1d6c7af55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel AT91 device tree bindings.
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Ludovic Desroches <ludovic.desroches@microchip.com>
> +
> +description: |
> +  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91rm9200
> +      - items:
> +          - enum:
> +              - olimex,sam9-l9260
> +          - enum:
> +              - atmel,at91sam9260
> +              - atmel,at91sam9261
> +              - atmel,at91sam9263
> +              - atmel,at91sam9g20
> +              - atmel,at91sam9g45
> +              - atmel,at91sam9n12
> +              - atmel,at91sam9rl
> +              - atmel,at91sam9xe
> +          - const: atmel,at91sam9
> +
> +      - items:
> +          - enum:
> +              - atmel,at91sam9g15
> +              - atmel,at91sam9g25
> +              - atmel,at91sam9g35
> +              - atmel,at91sam9x25
> +              - atmel,at91sam9x35
> +          - const: atmel,at91sam9x5
> +          - const: atmel,at91sam9
> +
> +      - items:
> +          - const: atmel,sama5d27
> +          - const: atmel,sama5d2
> +          - const: atmel,sama5
> +
> +      - description: Nattis v2 board with Natte v2 power board
> +        items:
> +          - const: axentia,nattis-2
> +          - const: axentia,natte-2
> +          - const: axentia,linea
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - description: TSE-850 v3 board
> +        items:
> +          - const: axentia,tse850v3
> +          - const: axentia,linea
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - items:
> +          - const: axentia,linea
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - items:
> +          - enum:
> +              - atmel,sama5d31
> +              - atmel,sama5d33
> +              - atmel,sama5d34
> +              - atmel,sama5d35
> +              - atmel,sama5d36
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - items:
> +          - enum:
> +              - atmel,sama5d41
> +              - atmel,sama5d42
> +              - atmel,sama5d43
> +              - atmel,sama5d44
> +          - const: atmel,sama5d4
> +          - const: atmel,sama5
> +
> +      - items:
> +          - enum:
> +              - atmel,sams70j19
> +              - atmel,sams70j20
> +              - atmel,sams70j21
> +              - atmel,sams70n19
> +              - atmel,sams70n20
> +              - atmel,sams70n21
> +              - atmel,sams70q19
> +              - atmel,sams70q20
> +              - atmel,sams70q21
> +          - const: atmel,sams70
> +          - const: atmel,samv7
> +
> +      - items:
> +          - enum:
> +              - atmel,samv70j19
> +              - atmel,samv70j20
> +              - atmel,samv70n19
> +              - atmel,samv70n20
> +              - atmel,samv70q19
> +              - atmel,samv70q20
> +          - const: atmel,samv70
> +          - const: atmel,samv7
> +
> +      - items:
> +          - enum:
> +              - atmel,samv71j19
> +              - atmel,samv71j20
> +              - atmel,samv71j21
> +              - atmel,samv71n19
> +              - atmel,samv71n20
> +              - atmel,samv71n21
> +              - atmel,samv71q19
> +              - atmel,samv71q20
> +              - atmel,samv71q21
> +          - const: atmel,samv71
> +          - const: atmel,samv7
> +
> +...
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

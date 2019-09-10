Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A4FC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FC42089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbfIJPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:15:19 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43787 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfIJPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:15:18 -0400
Received: from localhost (unknown [148.69.85.38])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DDB17240006;
        Tue, 10 Sep 2019 15:15:15 +0000 (UTC)
Date:   Tue, 10 Sep 2019 17:15:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sandeep Sheriker Mallikarjun 
        <sandeepsheriker.mallikarjun@microchip.com>
Subject: Re: [PATCH] irqchip/atmel-aic5: add support for sam9x60 irqchip
Message-ID: <20190910151513.GY21254@piout.net>
References: <1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2019 14:00:35+0300, Claudiu Beznea wrote:
> From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> 
> Add support for SAM9X60 irqchip.
> 
> Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> [claudiu.beznea@microchip.com: update aic5_irq_fixups[], update
>  documentation]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  .../devicetree/bindings/interrupt-controller/atmel,aic.txt     |  7 +++++--
>  drivers/irqchip/irq-atmel-aic5.c                               | 10 ++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
> index f4c5d34c4111..7079d44bf3ba 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
> @@ -1,8 +1,11 @@
>  * Advanced Interrupt Controller (AIC)
>  
>  Required properties:
> -- compatible: Should be "atmel,<chip>-aic"
> -  <chip> can be "at91rm9200", "sama5d2", "sama5d3" or "sama5d4"
> +- compatible: Should be:
> +    - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
> +      "sama5d3" or "sama5d4"
> +    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
> +
>  - interrupt-controller: Identifies the node as an interrupt controller.
>  - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
>    The first cell is the IRQ number (aka "Peripheral IDentifier" on datasheet).
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index 6acad2ea0fb3..29333497ba10 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -313,6 +313,7 @@ static void __init sama5d3_aic_irq_fixup(void)
>  static const struct of_device_id aic5_irq_fixups[] __initconst = {
>  	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
>  	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
> +	{ .compatible = "microchip,sam9x60", .data = sama5d3_aic_irq_fixup },
>  	{ /* sentinel */ },
>  };
>  
> @@ -390,3 +391,12 @@ static int __init sama5d4_aic5_of_init(struct device_node *node,
>  	return aic5_of_init(node, parent, NR_SAMA5D4_IRQS);
>  }
>  IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
> +
> +#define NR_SAM9X60_IRQS		50
> +
> +static int __init sam9x60_aic5_of_init(struct device_node *node,
> +				       struct device_node *parent)
> +{
> +	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
> +}
> +IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

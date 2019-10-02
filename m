Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7CECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4FC218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfJBJ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:56:54 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43081 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:56:54 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id ED5F9240015;
        Wed,  2 Oct 2019 09:56:51 +0000 (UTC)
Date:   Wed, 2 Oct 2019 11:56:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas.Ferre@microchip.com
Subject: Re: [PATCH 1/3] dt-bindings: watchdog: sam9x60_wdt: add bindings
Message-ID: <20191002095627.GK4106@piout.net>
References: <1570001371-8174-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570001371-8174-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 07:35:23+0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Add bindings for Microchip SAM9X60 Watchdog Timer
> 
> It has the same bindings as
> Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
> except the compatible.
> 

Maybe it can then use the same documentation file. However, I think you
should already use the yaml dt bindings schema instead of a simple text
file.

> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  .../devicetree/bindings/watchdog/sam9x60-wdt.txt   | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sam9x60-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sam9x60-wdt.txt b/Documentation/devicetree/bindings/watchdog/sam9x60-wdt.txt
> new file mode 100644
> index 00000000..74b4e2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sam9x60-wdt.txt
> @@ -0,0 +1,34 @@
> +* Microchip SAM9X60 Watchdog Timer (WDT) Controller
> +
> +Required properties:
> +- compatible: "microchip,sam9x60-wdt"
> +- reg: base physical address and length of memory mapped region.
> +
> +Optional properties:
> +- timeout-sec: watchdog timeout value (in seconds).
> +- interrupts: interrupt number to the CPU.
> +- atmel,watchdog-type: should be "hardware" or "software".
> +	"hardware": enable watchdog fault reset. A watchdog fault triggers
> +		    watchdog reset.
> +	"software": enable watchdog fault interrupt. A watchdog fault asserts
> +		    watchdog interrupt.
> +- atmel,idle-halt: present if you want to stop the watchdog when the CPU is
> +		   in idle state.
> +	CAUTION: This property should be used with care, it actually makes the
> +	watchdog not counting when the CPU is in idle state, therefore the
> +	watchdog reset time depends on mean CPU usage and will not reset at all
> +	if the CPU stop working while it is in idle state, which is probably
> +	not what you want.
> +- atmel,dbg-halt: present if you want to stop the watchdog when the CPU is
> +		  in debug state.
> +
> +Example:
> +	watchdog@ffffff80 {
> +		compatible = "microchip,sam9x60-wdt";
> +		reg = <0xffffff80 0x24>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 5>;
> +		timeout-sec = <10>;
> +		atmel,watchdog-type = "hardware";
> +		atmel,dbg-halt;
> +		atmel,idle-halt;
> +	};
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DEC48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024D72070D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfGGTLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:11:10 -0400
Received: from foss.arm.com ([217.140.110.172]:57062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfGGTLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:11:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13DCD360;
        Sun,  7 Jul 2019 12:11:09 -0700 (PDT)
Received: from why (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FA503F738;
        Sun,  7 Jul 2019 12:11:07 -0700 (PDT)
Date:   Sun, 7 Jul 2019 20:10:59 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Aleix Roca Nonell <kernelrocks@gmail.com>
Cc:     Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: Document RTD129x
Message-ID: <20190707201059.0e86dc71@why>
In-Reply-To: <20190707132246.GB13340@arks.localdomain>
References: <20190707132246.GB13340@arks.localdomain>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2019 15:22:46 +0200
Aleix Roca Nonell <kernelrocks@gmail.com> wrote:

> Add binding for Realtek RTD129x interrupt controller.
> 
> Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> ---
>  .../realtek,rtd129x-intc.txt                  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
> new file mode 100644
> index 000000000000..3ebb7c02afe5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
> @@ -0,0 +1,24 @@
> +Realtek RTD129x IRQ Interrupt Controller
> +=======================================
> +
> +Required properties:
> +
> +- compatible           :  Should be one of the following:
> +                          - "realtek,rtd129x-intc-misc"
> +                          - "realtek,rtd129x-intc-iso"

What does 'iso' mean in this context?

> +- reg                  :  Specifies the address of the ISR, IER and Unmask
> +                          register in couples of "address length".

Are these registers actually interleaved with other stuff? What else it
in between?

> +- interrupts           :  Specifies the interrupt line which is mux'ed.
> +- interrupt-controller :  Presence indicates the node as interrupt controller.
> +- #interrupt-cells     :  Shall be 1. See common bindings in interrupt.txt.

So I guess this is level only, with an unspecified polarity? No edge
interrupts?

> +
> +
> +Example:
> +
> +	interrupt-controller@98007000 {
> +		compatible = "realtek,rtd129x-iso-irq-mux";

It'd be good if the the example matched the rest of the documentation.

> +		reg = <0x98007000 0x4 0x98007040 0x4 0x98007004 0x4>;
> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

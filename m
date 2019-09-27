Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CCBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820C721850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569600683;
	bh=fBkDjac4jlJYMvUs0Dc+PKuW+pRNCpGpra805ixcEUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ng5R/tua4efE95Dc090+EybFcIZm+7o7Yc8zScuW6+Cg22dD+2s91T3PRYt5TWNgN
	 sEfswY1xwI2x+qPbG63jx8UW4ZQ8n/VosmoMXg78tfZMlm9opuFcP1sxCF7pcukw08
	 2nixSGhbwPPNSgumEBeDOxZl6sfRrmrRzE58AAdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfI0QLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:11:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35214 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfI0QLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:11:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id z6so2725523otb.2;
        Fri, 27 Sep 2019 09:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X3psm7pGYecaR7OkJEumX87W65GK4kSG3NWHyS2qiTE=;
        b=r43PAhduF3KjjdjLsEKqRjwC3U6VP2X2Oimesstu3qcxlO4DNUYgLciWZM31vG/zj5
         edfiSUd0h0yOuiP234LSx7IZdcjdID2HX8/KpAhIg6v2HuqUGBpNVMOqTL/pa552XZS5
         tsErxZ43+DiXbwlp4PoBbj78OdpmxqjlptZrRuojD+btwlcrJvJ+9oex3LbXo1+J8VzV
         zp81MWu6LvqQIkIuWma1qGLLdiGQm+cVKSlEfAL3ycVSnklF1OtSq2K3OozSeef3T6qj
         Kz/1HaY8Cea7/q82M74Yhjfd7URWpc8IWUCPJwzL02KDw2IAmvu5PyuC6HhDy94rYxCc
         qQmQ==
X-Gm-Message-State: APjAAAVnDYAIc/cnFZvh6blc0vAZOwA4OszSRFPCrmslOICXfyrOidM2
        1HxzhZUlkKuZoPveiIkUUg==
X-Google-Smtp-Source: APXvYqx0O6aVdbfcDbCuLSszWiQ1sdG/x54on6BSIouX78Hf7vhKRounNeFyG5WUapqkzKVQbu4fpw==
X-Received: by 2002:a05:6830:17d8:: with SMTP id p24mr3932919ota.72.1569600679834;
        Fri, 27 Sep 2019 09:11:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm1011131otk.5.2019.09.27.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 09:11:19 -0700 (PDT)
Date:   Fri, 27 Sep 2019 11:11:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
Message-ID: <20190927161118.GA19333@bogus>
References: <20190923101513.32719-1-kurt@linutronix.de>
 <20190923101513.32719-3-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923101513.32719-3-kurt@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:15:13PM +0200, Kurt Kanzenbach wrote:
> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 
> This adds Device Tree binding documentation for the external interrupt
> lines with configurable polarity present on some Layerscape SOCs.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> 
> Changes since v5:
> 
>  - Add #address-cells and #size-cells to parent
>  - Mention LS2088A and the ISC unit

Repeating some of my lost comments from v2 2 years ago...

> 
> .../interrupt-controller/fsl,ls-extirq.txt    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> new file mode 100644
> index 000000000000..7b53f9cc8019
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> @@ -0,0 +1,47 @@
> +* Freescale Layerscape external IRQs
> +
> +Some Layerscape SOCs (LS1021A, LS1043A, LS1046A, LS2088A) support
> +inverting the polarity of certain external interrupt lines.
> +
> +The device node must be a child of the node representing the
> +Supplemental Configuration Unit (SCFG) or the Interrupt Sampling
> +Control (ISC) Unit.
> +
> +Required properties:
> +- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
> +- interrupt-controller: Identifies the node as an interrupt controller
> +- #interrupt-cells: Must be 2. The first element is the index of the
> +  external interrupt line. The second element is the trigger type.
> +- interrupt-parent: phandle of GIC.
> +- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in the SCFG.
> +- fsl,extirq-map: Specifies the mapping to interrupt numbers in the parent
> +  interrupt controller. Interrupts are mapped one-to-one to parent
> +  interrupts.

This should be an 'interrupt-map' instead.

> +
> +Optional properties:
> +- fsl,bit-reverse: This boolean property should be set on the LS1021A
> +  if the SCFGREVCR register has been set to all-ones (which is usually
> +  the case), meaning that all reads and writes of SCFG registers are
> +  implicitly bit-reversed. Other compatible platforms do not have such
> +  a register.

Couldn't you just read that register and tell?

Does this apply to only the extirq register or all of scfg?

> +
> +Example:
> +	scfg: scfg@1570000 {
> +		compatible = "fsl,ls1021a-scfg", "syscon";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

As the child node(s) are memory mapped, this should not be 0. And you 
need 'ranges'.

> +		...
> +		extirq: interrupt-controller {
> +			compatible = "fsl,ls1021a-extirq";
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic>;
> +			reg = <0x1ac>;
> +			fsl,extirq-map = <163 164 165 167 168 169>;
> +			fsl,bit-reverse;
> +		};
> +	};
> +
> +
> +	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
> -- 
> 2.20.1
> 

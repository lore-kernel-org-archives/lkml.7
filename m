Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C626AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB62088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574281598;
	bh=AEVIorR6/VAlI4BJXRw6tPbken7vkQ0aTtyblIbcMdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OeJbX90DTRdFswK7I6SUJFx9Q0UdlBvzAhm2N4/JmCPgAe15V8Fvgeb2dux+bxlOq
	 QF9/dWWjMnV5G87xiAPHubl66Tq0Egq85ue/nL9IBm+KqArIEDtmzSplYUoa/pcOia
	 1/wPshHYHZkh5ggwnIY52CBX10CjHMCwdhVOQGgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKTU0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfKTU0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:26:37 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3EAE20895;
        Wed, 20 Nov 2019 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574281595;
        bh=AEVIorR6/VAlI4BJXRw6tPbken7vkQ0aTtyblIbcMdo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YsO2Djb3qDyV5DUI+gOfSBEoyXrLr4bGjbyQsw4ZyMIjgrbsGPYPzv+oYJneg+R/Q
         lBr2gXtZLDWn8l/hjcPNRxT8TShMH2IIMvdXNP3uImH3y+gg4xiIQvklZTexnD3O2v
         ZO3RzynVtL7N12dcNqyMglcvuVYYyjb/NP0T1OEA=
Received: by mail-qt1-f171.google.com with SMTP id o49so983011qta.7;
        Wed, 20 Nov 2019 12:26:35 -0800 (PST)
X-Gm-Message-State: APjAAAV/hE7nnTDjwEIFj4q2dYeif7r2NRjpmnzSWCkyFXbXx22Kq66w
        3E8B32HpluVdELdL0TBEnyngA0qXuaIUCETGsQ==
X-Google-Smtp-Source: APXvYqx7fnGdtnkeuRvwWhsOVISMRdUYUIw3lX6FCbHTqaZSFv6tvBQHF5T6swA1/jBii4Jde8nmZdXen76KVGu+rkc=
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr4714242qtp.136.1574281594774;
 Wed, 20 Nov 2019 12:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20191118101420.23610-1-arnaud.pouliquen@st.com>
In-Reply-To: <20191118101420.23610-1-arnaud.pouliquen@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Nov 2019 14:26:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+42wx1AJO=jXXBhmaKMkBq-RtoF+kxVjS2z9fSwhcaEQ@mail.gmail.com>
Message-ID: <CAL_Jsq+42wx1AJO=jXXBhmaKMkBq-RtoF+kxVjS2z9fSwhcaEQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mailbox: convert stm32-ipcc to json-schema
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 4:15 AM Arnaud Pouliquen
<arnaud.pouliquen@st.com> wrote:
>
> Convert the STM32 IPCC bindings to DT schema format using
> json-schema
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  .../bindings/mailbox/st,stm32-ipcc.yaml       | 91 +++++++++++++++++++
>  .../bindings/mailbox/stm32-ipcc.txt           | 47 ----------
>  2 files changed, 91 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt

Thanks for helping me find 2 meta-schema errors. :) Please update
dt-schema and re-run 'make dt_binding_check'.

> diff --git a/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
> new file mode 100644
> index 000000000000..90157d4deac1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/st,stm32-ipcc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: STMicroelectronics STM32 IPC controller bindings
> +
> +description:
> +  The IPCC block provides a non blocking signaling mechanism to post and
> +  retrieve messages in an atomic way between two processors.
> +  It provides the signaling for N bidirectionnal channels. The number of
> +  channels (N) can be read from a dedicated register.
> +
> +maintainers:
> +  - Fabien Dessenne <fabien.dessenne@st.com>
> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp1-ipcc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +     maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: rx channel occupied
> +      - description: tx channel free
> +      - description: wakeup source
> +    minItems: 2
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      enums: [ rx, tx, wakeup ]

'enums' is not a valid keyword. 'enum' is valid, but his should be in
a defined order (so a list of items).

> +    minItems: 2
> +    maxItems: 3
> +
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enables wake up of host system on wakeup IRQ assertion.

Just 'true' is enough here. Assume we have a common definition.

> +
> +  "#mbox-cells":
> +    const: 1
> +
> +  st,proc-id:
> +    description: Processor id using the mailbox (0 or 1)
> +    allOf:
> +      - minimum: 0
> +      - maximum: 1

'enum: [ 0, 1 ]' is more concise.

Also, needs a $ref to the type.

> +      - default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - st,proc-id
> +  - clocks
> +  - interrupt-names
> +  - "#mbox-cells"
> +
> +oneOf:
> +  - required:
> +      - interrupts
> +  - required:
> +      - interrupts-extended

The tooling takes care of this for you. Just list 'interrupts' as required.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    ipcc: mailbox@4c001000 {
> +      compatible = "st,stm32mp1-ipcc";
> +      #mbox-cells = <1>;
> +      reg = <0x4c001000 0x400>;
> +      st,proc-id = <0>;
> +      interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
> +                     <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
> +                     <&aiec 62 1>;
> +      interrupt-names = "rx", "tx", "wakeup";
> +      clocks = <&rcc_clk IPCC>;
> +      wakeup-source;
> +    };
> +
> +...

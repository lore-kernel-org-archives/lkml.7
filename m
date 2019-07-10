Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613EC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F21A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562773801;
	bh=f3705MLDMz7ZVRIZ/2mbpGAvk6+s8V0oHG6b0/yE9pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OCIkzRBKnumCI+TQT2jQ1UPUZgbNALZWmejPn9U0DB8N7h1g4IU++SI0JzoLMSk9m
	 zo3QYHH+/Lz+KIl7lTyuSzbFLAnLGbqEGQqh9vNe5g0IL6vtdahgDJMoEf7daMX7Gr
	 n6ItdxPcU56Hkewxc2X10sVIv7EzlR4DydBgDBQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfGJPuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbfGJPt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:49:59 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE5E21473;
        Wed, 10 Jul 2019 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562773799;
        bh=f3705MLDMz7ZVRIZ/2mbpGAvk6+s8V0oHG6b0/yE9pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dNr4F5HawxLIUhCtkX+gOEjtuf9BGR0CEIsliRqZH2O9ZtsdBVaq2kRHWU6Hi1+fo
         XRZwgaoUmOgituexlwOZw6yF+zL0fvnshjkK4ofv79S4KQTO3bO3TnB7b8CachtiCF
         KS0ZkAhzVzVQnnkBbUi8ZqjFD274etLB6JypO9QY=
Received: by mail-qt1-f169.google.com with SMTP id n11so2948349qtl.5;
        Wed, 10 Jul 2019 08:49:58 -0700 (PDT)
X-Gm-Message-State: APjAAAWrcwvR9UpUlCeNMPJCVSE8VsdGFQEhmZHf8U4qvuKWJOrtWGvG
        ciR3kcFKYWRp+/Mh+DpumQmy3ylLAIcuujOaow==
X-Google-Smtp-Source: APXvYqz6I/p/hMSsLLeh44Lioj37XHZzwUteYHfVHSa7jufX40UundN85FK+bOouu15+3Q3HfQJkSkXH5cMd8kt4WyU=
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr25025832qtc.300.1562773798149;
 Wed, 10 Jul 2019 08:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190710141611.21159-1-andrew@aj.id.au> <20190710141611.21159-2-andrew@aj.id.au>
In-Reply-To: <20190710141611.21159-2-andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Jul 2019 09:49:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrYcUbn_02z9GQO6U4rz7k=p3kB7_G0tKmv25MMZZNQg@mail.gmail.com>
Message-ID: <CAL_JsqKrYcUbn_02z9GQO6U4rz7k=p3kB7_G0tKmv25MMZZNQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ryanchen.aspeed@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 8:16 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../bindings/mmc/sdhci-of-aspeed.yaml         | 91 +++++++++++++++++++

aspeed,sdhci.yaml

>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> new file mode 100644
> index 000000000000..e98a2ac4d46d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

The preferred license is (GPL-2.0 OR BSD-2-Clause) if that is okay with you.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sdhci-of-aspeed.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED SD/SDIO/eMMC Controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@aj.id.au>
> +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> +
> +description: |+
> +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> +  only a single slot is enabled.
> +
> +  The two slots are supported by a common configuration area. As the SDHCIs for
> +  the slots are dependent on the common configuration area, they are described
> +  as child nodes.
> +
> +properties:
> +  compatible:
> +    enum: [ aspeed,ast2400-sdc, aspeed,ast2500-sdc ]
> +  reg:
> +    description: Common configuration registers

This should have a 'maxItems: 1'. Same for the child reg.

> +  ranges: true
> +  clocks:
> +    maxItems: 1
> +    description: The SD/SDIO controller clock gate
> +  sdhci:

This needs to be a pattern (under patternProperties) as these have
unit-addresses.

> +    type: object
> +    properties:
> +      compatible:
> +        allOf:
> +          - enum: [ aspeed,ast2400-sdhci, aspeed,ast2500-sdhci ]
> +          - const: sdhci

This condition can never be true. What you need is s/allOf/items/.
However, 'sdhci' is not really a useful compatible because every
implementation has quirks, so I'd drop it.

> +      reg:
> +        description: The SDHCI registers
> +      clocks:
> +        maxItems: 1
> +        description: The SD bus clock
> +      slot:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [0, 1]

Is this really needed? Offset 0x100 is slot 0 and offset 0x200 is slot
1. Does that ever change?

> +      interrupts:
> +        maxItems: 1
> +        description: The SD interrupt shared between both slots
> +    required:
> +      - compatible
> +      - reg
> +      - clocks
> +      - slot
> +      - interrupts
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - clocks

#address-cells and #size-cells are required too.

You should also add 'additionalProperties: false' here so other random
properties can't be present.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    sdc@1e740000 {
> +            compatible = "aspeed,ast2500-sdc";
> +            reg = <0x1e740000 0x100>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;

It's preferred to limit the range here and then the child addresses
are 0x100 and 0x200.

> +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> +
> +            sdhci0: sdhci@1e740100 {
> +                    compatible = "aspeed,ast2500-sdhci", "sdhci";
> +                    reg = <0x1e740100 0x100>;
> +                    slot = <0>;
> +                    interrupts = <26>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +            };
> +
> +            sdhci1: sdhci@1e740200 {
> +                    compatible = "aspeed,ast2500-sdhci", "sdhci";
> +                    reg = <0x1e740200 0x100>;
> +                    slot = <1>;
> +                    interrupts = <26>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +            };
> +    };
> --
> 2.20.1
>

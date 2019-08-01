Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741D0C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3503A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564700359;
	bh=kASyP8PGtZ0rL4jNIcUKrCyx7pYnuPev55DZJBaSklM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HKK/quMy/Bzthv8eix5aHXnDABT54r7+mszcF+iRKPQn/Lh004W+MLnqFWp4kzgsk
	 JbOPZjxdd06XerIkfhT6wDh+Z1JOIDnIWDZpe72Di7b6eKLnG/RtNvjNqyRF91KZ0j
	 AL5hdafpLMX8edwwNqRQLbw4xdA5FoEKzsZ5pkvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbfHAW7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbfHAW7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:59:17 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FB32080C;
        Thu,  1 Aug 2019 22:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564700356;
        bh=kASyP8PGtZ0rL4jNIcUKrCyx7pYnuPev55DZJBaSklM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ROPgtKq1KfpdkUQ/WwkuPZRlwKqXTl1UN7SM2HkqlXAf4hBAf34AxZLKGFbw4ZZ2J
         Uc27k6aqlqJJcItuknCk0YjdoQ5+l3aRVFpB/S+S3eE1o1tMYWccEuM7PbSu/SAS3d
         ld0XgBlBhhkxkSUs+J+EeCsS0vdcL9RptovKV4Ts=
Received: by mail-qt1-f182.google.com with SMTP id l9so72000765qtu.6;
        Thu, 01 Aug 2019 15:59:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXTpWd0mBBPtic+ylHNhFlyAqJAnz0BnOFmwqvjFPvilyK2bLGt
        1oWNsGF2DFHzb6TAIPoSXj2J/9VodaytCmH5JQ==
X-Google-Smtp-Source: APXvYqx7WFIk+rochGPuukRrKofUEOPYVHhKW5sYMVeD23Voa28zVM0mZV9ERrGM3Tnt9e7Ssjzs/qZQDedTHVoiqog=
X-Received: by 2002:a0c:b627:: with SMTP id f39mr96371146qve.72.1564700355781;
 Thu, 01 Aug 2019 15:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190730062316.32037-1-andrew@aj.id.au> <20190730062316.32037-2-andrew@aj.id.au>
In-Reply-To: <20190730062316.32037-2-andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Aug 2019 16:59:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+oZRREV=VjYUxT3WphOa5tBaF1pvS_JKSphBY=3XB5MA@mail.gmail.com>
Message-ID: <CAL_Jsq+oZRREV=VjYUxT3WphOa5tBaF1pvS_JKSphBY=3XB5MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Document Aspeed SD controller
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
        Ryan Chen <ryanchen.aspeed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:23 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>
> ---
> v3:
> * Fix compatible enums
> * Add AST2600 compatibles
> * Describe #address-cells / #size-cells
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> new file mode 100644
> index 000000000000..dd2a00c59641
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
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
> +    enum:
> +      - aspeed,ast2400-sd-controller
> +      - aspeed,ast2500-sd-controller
> +      - aspeed,ast2600-sd-controller
> +  reg:
> +    maxItems: 1
> +    description: Common configuration registers
> +  "#address-cells":
> +    const: 1
> +  "#size-cells":
> +    const: 1
> +  ranges: true
> +  clocks:
> +    maxItems: 1
> +    description: The SD/SDIO controller clock gate
> +
> +patternProperties:
> +  "^sdhci@[0-9a-f]+$":

This should probably have:

allOf:
  - $ref: mmc-controller.yaml

Another new thing in 5.3. :)

> +    type: object
> +    properties:
> +      compatible:
> +        enum:
> +          - aspeed,ast2400-sdhci
> +          - aspeed,ast2500-sdhci
> +          - aspeed,ast2600-sdhci
> +      reg:
> +        maxItems: 1
> +        description: The SDHCI registers
> +      clocks:
> +        maxItems: 1
> +        description: The SD bus clock
> +      interrupts:
> +        maxItems: 1
> +        description: The SD interrupt shared between both slots
> +    required:
> +      - compatible
> +      - reg
> +      - clocks
> +      - interrupts
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +  - clocks
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    sdc@1e740000 {
> +            compatible = "aspeed,ast2500-sd-controller";
> +            reg = <0x1e740000 0x100>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x1e740000 0x10000>;
> +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> +
> +            sdhci0: sdhci@100 {
> +                    compatible = "aspeed,ast2500-sdhci";
> +                    reg = <0x100 0x100>;
> +                    interrupts = <26>;
> +                    sdhci,auto-cmd12;

Not documented. Maybe should be common, but there's only a few users.

> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +            };
> +
> +            sdhci1: sdhci@200 {
> +                    compatible = "aspeed,ast2500-sdhci";
> +                    reg = <0x200 0x100>;
> +                    interrupts = <26>;
> +                    sdhci,auto-cmd12;
> +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> +            };
> +    };
> --
> 2.20.1
>

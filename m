Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF2FC19759
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2A320644
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 02:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mcNcSbS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAhkIWjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfHECJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 22:09:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:54179 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbfHECJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 22:09:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 252C41A49;
        Sun,  4 Aug 2019 22:09:55 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 04 Aug 2019 22:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=XBfRrOQ28Bn+dCVbtL/ZXEglGYrMofD
        3T7NHTUbCGus=; b=mcNcSbS3jqoT+fARV0rhU/KYGsg1XoJzD6O0EzyD0fEeohG
        Qn0ybiF/rgmUvgYm7rx9hLHJutnSr/dlBpTAo1mkdEIgE9oPY17ZOXiCanAwHx8V
        FdHtCRu++VLAqm+TXZJC/GsddLiWKHMByiMMnXzDUNHrO6AKLGlXJV+UNWq+cQ75
        FjTgsYe65CM+tZ+RytZpaudBtKVxNc1XSmuZwRSfTHdxuA7qhvwC+1M03HwwfukU
        FDGYvN0w9u/VO5JtBFc7/p0P7WbmDm3Muz1XC77HM+lHVtRJ0tW1IfkGq0znccik
        +ZowCe3p948n9SNIeURdEik60jg+syqn5x5Rh6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XBfRrO
        Q28Bn+dCVbtL/ZXEglGYrMofD3T7NHTUbCGus=; b=XAhkIWjraQDNfj8Ln4XOn0
        krfY0KMrL/WoxaX9h4DdGNeOTMkx9/nOV8LpP9AvcJmwGmPbsxevW+b+5pFhM8ND
        +P00XNZvUiFNiGqffV2UcEUAje9ZoSkX8Ibp2pC63SWA1w4gycTGGAQPjegidwHL
        3FH5dctwQldUwCpHc0aEdgh+auckc/yjDv083un0IODk8uq9+HvlPRknPVRmGwl6
        34BzJl5B1nC5vQMSS7ooU8goSyhbYztyrGgfXKzTx5W5Cfhxcwfy/oRuO+XiGwh0
        +oSc3rrGYSS2ybFnPgjCX4AgoxvoY/PvGXWW1rVvkoFO1gJFJiRjd6c3f3qY/stg
        ==
X-ME-Sender: <xms:8Y9HXYb7l6c3PoV6udmqdX-5qwVreBaDUpLuz8ujd_gORaw7hx1LXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddtiedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomh
    grihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:8Y9HXcdxp1TCjdVnT84ZgR3Q6xoxj1Oosqj2ja9cMoSFnIpQrGwJQw>
    <xmx:8Y9HXcCYZPX61iQHG4psCd9kqFlGT53FhzDxWp3NjlnlkNo5WnCzdQ>
    <xmx:8Y9HXeYI9E4bCPmueGXR8dy2XGmodPJW_NoTAm6qS5pjqTdN8SnsZw>
    <xmx:849HXdgizRiGKNWOzJOr02dYh8SsEubJJJ5mgGfYO-9us33ezf2t7A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D405E00A2; Sun,  4 Aug 2019 22:09:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-799-g925e343-fmstable-20190729v1
Mime-Version: 1.0
Message-Id: <35aaa5a4-1e0d-4f64-8985-36e2c01ccc05@www.fastmail.com>
In-Reply-To: <CAL_Jsq+oZRREV=VjYUxT3WphOa5tBaF1pvS_JKSphBY=3XB5MA@mail.gmail.com>
References: <20190730062316.32037-1-andrew@aj.id.au>
 <20190730062316.32037-2-andrew@aj.id.au>
 <CAL_Jsq+oZRREV=VjYUxT3WphOa5tBaF1pvS_JKSphBY=3XB5MA@mail.gmail.com>
Date:   Mon, 05 Aug 2019 11:40:17 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Rob Herring" <robh+dt@kernel.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: Document Aspeed SD controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2019, at 08:29, Rob Herring wrote:
> On Tue, Jul 30, 2019 at 12:23 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > data bus if only a single slot is enabled.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > ---
> > v3:
> > * Fix compatible enums
> > * Add AST2600 compatibles
> > * Describe #address-cells / #size-cells
> > ---
> >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 100 ++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > new file mode 100644
> > index 000000000000..dd2a00c59641
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -0,0 +1,100 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED SD/SDIO/eMMC Controller
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@aj.id.au>
> > +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> > +
> > +description: |+
> > +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> > +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> > +  only a single slot is enabled.
> > +
> > +  The two slots are supported by a common configuration area. As the SDHCIs for
> > +  the slots are dependent on the common configuration area, they are described
> > +  as child nodes.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-sd-controller
> > +      - aspeed,ast2500-sd-controller
> > +      - aspeed,ast2600-sd-controller
> > +  reg:
> > +    maxItems: 1
> > +    description: Common configuration registers
> > +  "#address-cells":
> > +    const: 1
> > +  "#size-cells":
> > +    const: 1
> > +  ranges: true
> > +  clocks:
> > +    maxItems: 1
> > +    description: The SD/SDIO controller clock gate
> > +
> > +patternProperties:
> > +  "^sdhci@[0-9a-f]+$":
> 
> This should probably have:
> 
> allOf:
>   - $ref: mmc-controller.yaml
> 
> Another new thing in 5.3. :)

Ack.

> 
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        enum:
> > +          - aspeed,ast2400-sdhci
> > +          - aspeed,ast2500-sdhci
> > +          - aspeed,ast2600-sdhci
> > +      reg:
> > +        maxItems: 1
> > +        description: The SDHCI registers
> > +      clocks:
> > +        maxItems: 1
> > +        description: The SD bus clock
> > +      interrupts:
> > +        maxItems: 1
> > +        description: The SD interrupt shared between both slots
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +      - interrupts
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +  - clocks
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/aspeed-clock.h>
> > +    sdc@1e740000 {
> > +            compatible = "aspeed,ast2500-sd-controller";
> > +            reg = <0x1e740000 0x100>;
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            ranges = <0 0x1e740000 0x10000>;
> > +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> > +
> > +            sdhci0: sdhci@100 {
> > +                    compatible = "aspeed,ast2500-sdhci";
> > +                    reg = <0x100 0x100>;
> > +                    interrupts = <26>;
> > +                    sdhci,auto-cmd12;
> 
> Not documented. Maybe should be common, but there's only a few users.

I'll document it locally for the moment.

Cheers,

Andrew

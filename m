Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6ECC74A3F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955721019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="aHdt9kG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/65hYuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGKA4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 20:56:39 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33031 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727659AbfGKA4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:56:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C158EBA1;
        Wed, 10 Jul 2019 20:56:34 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 20:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=oNe9eio8XYT1BZ4ZF/+0zEh/gS2//e+
        l2qNxRtVLoLs=; b=aHdt9kG3CNNk/uJNVaKK+zTZTYd4G2PBndNMU3gfzXo3K8a
        H793vKvHpSsnsJAc2+SKuNPiw+aOx+rfHrSZXKLZD1C30e+EbB10RphqxX0mM0p7
        SWHCucYCRZQH3lcTXVq1C0V5JdOP6jhe6GN38FQiBfZCYTNaO/wJOElWgQ26lMoP
        Vjuq4NX70Cc0ihAB5bD93RD3o84lCTNPB2wrytWuqOfH7XcoojwrjAF8yrEhK30q
        60fJqLau8FubRMml3YZiWGSlqtunOHSy6b12Lk3eQubDHrz46VGNKQYmwX1YxSV+
        450qZDGvD9Q0dcvxKpalpkFkE+SXeHiAp2WBL4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oNe9ei
        o8XYT1BZ4ZF/+0zEh/gS2//e+l2qNxRtVLoLs=; b=I/65hYuq2zmn5keq+6C8PH
        NxwdkOpfvf1nyNERs9UJOWKby6CQftNAf4LvRRAnnWhaXBoCrHzlrCi1GUjTv9XH
        0OTvkchXsDFEo2zz0spJWg0hmKRr0qyqSlNlKNZqIkAN0kC5zCiVPzWaDVo88KMp
        WzvkSivVALoHRvU1/MkAZtYbr/T8nRw6xRpBHJahFqlAxtfAE6agadB6hoorcXvh
        J77GmLUM/FCzPx8XMJV8HgrnSGdZJPR2O4hWf2mVhjhHXQFUlBorVE4rbarjRBkF
        1yjwPtcAuViFAVQDdUhBTAfJWWCzYh4TpytmwFrZILcWU893ypf1k87dCJYelFaA
        ==
X-ME-Sender: <xms:QYkmXR8lZT_adM_lv3N9h5gHa0sVr9t71HeQW5r_VtHynhQ44X3RpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepuggvvhhitggvthhrvggvrdhorhhgnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    nhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QYkmXZ-dI5mb9WW_DtQ7ayc-IDbLdgupyOdtfYdKdxcwThFCQcC4Tw>
    <xmx:QYkmXaDjBSZiQd2_f78ntiAjohRf-ODs9K0mhJsgmBdCop1P17LjZQ>
    <xmx:QYkmXZy0giH8SK5oBoAtC5Ynbt3J9YMxpvD5u9L32f9cmjteRwnlkg>
    <xmx:QokmXU5ofQenOuvHGAvTquwCH-_TqDcub4tzkQ7aKa6kmVdoIA-wKA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 925B3E0162; Wed, 10 Jul 2019 20:56:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-731-g19d3b16-fmstable-20190627v1
Mime-Version: 1.0
Message-Id: <3b0788cf-eee4-48b2-901d-d2ab6716ab1b@www.fastmail.com>
In-Reply-To: <CAL_JsqKrYcUbn_02z9GQO6U4rz7k=p3kB7_G0tKmv25MMZZNQg@mail.gmail.com>
References: <20190710141611.21159-1-andrew@aj.id.au>
 <20190710141611.21159-2-andrew@aj.id.au>
 <CAL_JsqKrYcUbn_02z9GQO6U4rz7k=p3kB7_G0tKmv25MMZZNQg@mail.gmail.com>
Date:   Thu, 11 Jul 2019 10:26:39 +0930
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
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Document Aspeed SD controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jul 2019, at 01:20, Rob Herring wrote:
> On Wed, Jul 10, 2019 at 8:16 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > data bus if only a single slot is enabled.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  .../bindings/mmc/sdhci-of-aspeed.yaml         | 91 +++++++++++++++++++
> 
> aspeed,sdhci.yaml

Ack. Previously I had separate documents for different compatibles, wasn't sure
how to tackle name one document covering multiple compatibles.

> 
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > new file mode 100644
> > index 000000000000..e98a2ac4d46d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> 
> The preferred license is (GPL-2.0 OR BSD-2-Clause) if that is okay with you.

I should poke people internally again, I had asked, just haven't got a clear
answer. What was the justification for the preference (just so I can pass that
on)?

> 
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/sdhci-of-aspeed.yaml#
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
> > +    enum: [ aspeed,ast2400-sdc, aspeed,ast2500-sdc ]
> > +  reg:
> > +    description: Common configuration registers
> 
> This should have a 'maxItems: 1'. Same for the child reg.

Ack.

> 
> > +  ranges: true
> > +  clocks:
> > +    maxItems: 1
> > +    description: The SD/SDIO controller clock gate
> > +  sdhci:
> 
> This needs to be a pattern (under patternProperties) as these have
> unit-addresses.

Ah, I didn't think about that.

> 
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        allOf:
> > +          - enum: [ aspeed,ast2400-sdhci, aspeed,ast2500-sdhci ]
> > +          - const: sdhci
> 
> This condition can never be true. What you need is s/allOf/items/.
> However, 'sdhci' is not really a useful compatible because every
> implementation has quirks, so I'd drop it.

Yeah, I was tossing up whether to include "sdhci". I'll drop it as you
suggest.

Pity the shorthand doesn't work how I expected. Might explain
some of the behaviour I was seeing with the bindings make targets
though.

> 
> > +      reg:
> > +        description: The SDHCI registers
> > +      clocks:
> > +        maxItems: 1
> > +        description: The SD bus clock
> > +      slot:
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32
> > +          - enum: [0, 1]
> 
> Is this really needed? Offset 0x100 is slot 0 and offset 0x200 is slot
> 1. Does that ever change?

It doesn't in the SoCs at hand, but the downstream impact (driver
implementation) is that you need to derive the slot index from the
address and I was trying to avoid that. The slot index influences
some bit index calculations.

> 
> > +      interrupts:
> > +        maxItems: 1
> > +        description: The SD interrupt shared between both slots
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - clocks
> > +      - slot
> > +      - interrupts
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ranges
> > +  - clocks
> 
> #address-cells and #size-cells are required too.

Ack.

> 
> You should also add 'additionalProperties: false' here so other random
> properties can't be present.

Ah yes. Will fix.

> 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/aspeed-clock.h>
> > +    sdc@1e740000 {
> > +            compatible = "aspeed,ast2500-sdc";
> > +            reg = <0x1e740000 0x100>;
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            ranges;
> 
> It's preferred to limit the range here and then the child addresses
> are 0x100 and 0x200.

Okay. Was just trying to dodge mental arithmetic where I could, but
if that's the preference then I'll fix it up.

Thanks for the review!

Andrew

> 
> > +            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
> > +
> > +            sdhci0: sdhci@1e740100 {
> > +                    compatible = "aspeed,ast2500-sdhci", "sdhci";
> > +                    reg = <0x1e740100 0x100>;
> > +                    slot = <0>;
> > +                    interrupts = <26>;
> > +                    sdhci,auto-cmd12;
> > +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> > +            };
> > +
> > +            sdhci1: sdhci@1e740200 {
> > +                    compatible = "aspeed,ast2500-sdhci", "sdhci";
> > +                    reg = <0x1e740200 0x100>;
> > +                    slot = <1>;
> > +                    interrupts = <26>;
> > +                    sdhci,auto-cmd12;
> > +                    clocks = <&syscon ASPEED_CLK_SDIO>;
> > +            };
> > +    };
> > --
> > 2.20.1
> >
>

Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E66DC73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B1320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 02:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Zn7MMKTG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKUWpvyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfGOCaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 22:30:46 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41513 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfGOCap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 22:30:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4827F2438;
        Sun, 14 Jul 2019 22:30:44 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 14 Jul 2019 22:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=8PAqwlgjdusJcJsV/ER++KrpN/QjUb2
        C+McWIpc95aI=; b=Zn7MMKTG/N0hIAqpr6U2P3rR8uuih0dpktX5UP23GxBiqKb
        IGq6Mu5YcLnJIAxNsYZg9fpMdKVLX+4jPgNpSdRiy3o4M8EQAtl5MaIWyDuF9QAm
        kntRmYY9LydzG3kOyRDebZN1ZSzwoCDcCtAtfHb/ersKcB5W3g/maymJRiWgqrB9
        X3IpJtQ8Z35klRtN+fJvZbpRgyoq7Q9IFt97ATA733OvBC9xM2Gi7k32JUKfTW9q
        3YjnMoizzpTHg8FCvruuV4rTF9AQrmuqAbZVCKLZfHkZfbNWDvJJUjO+/Xi6ExX0
        uid+AiW5y/M933n5uasEL/a6Il8L2svkaKomZtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8PAqwl
        gjdusJcJsV/ER++KrpN/QjUb2C+McWIpc95aI=; b=HKUWpvyhh5HjlEXQ6PnAt9
        LpFcYzeykPSA7yiyLihVw0GUoc1aQ/2A49XiPxOwMs3Bc0x2H6NFz0ThyafkXPMf
        caJazejBSLzCMzPqNduLp31hniMgl5zeuqozHCoRNWUfSe8KbejWB/cFbhsezkI4
        iNJXN7gHsZD2vo4xNuItJtf56p9+nAbtqrvDuCG5b0Sk92ZAmrBJzXvKVnwqsJVk
        URBX/iCM7gjyeb1t21TcKLzLInPCXisGHtRJzpa967X4ZxLj53iErveQkzsOj4ij
        sVQe8Zm2yIQRihKjDSqjqLUS70IPCOInjC5R+JU5+fy/Ui1uGCCFpkNTpjxGp/yg
        ==
X-ME-Sender: <xms:UuUrXZQIHtCvu8L0EFuL5VK5wZkueralwqJ-7qRNZyaCQlnCkqkQWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrheejgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepsghoohhtlhhinhdrtghomhdpuggvvhhitggvthhrvggvrdhorhhgnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrh
    fuihiivgeptd
X-ME-Proxy: <xmx:UuUrXc2p2HFO4fIvPUthNItjF-iEv3Uw-kOVSQPdOo5PVgHJp7BzOQ>
    <xmx:UuUrXTzGdH5Ae_5p9EwuNR1Hs46Ks1guoCO3vHcyUJhJLxxYkkMGmw>
    <xmx:UuUrXYwyEAMIvev_3xEU_XwF0jr81pklcAWuDkexuZeAdG54yw9VAQ>
    <xmx:VOUrXcfV9pE5yGkvpr2ppxUq4JYI9NYjE2gYtsssTyY_CiEak84BLg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 495A7E00CC; Sun, 14 Jul 2019 22:30:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-731-g19d3b16-fmstable-20190627v1
Mime-Version: 1.0
Message-Id: <5c831fd3-d0e2-474b-8a6e-8f51f92fbdf8@www.fastmail.com>
In-Reply-To: <20190712131028.ba4d4jetg4btsx4u@flea>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-2-andrew@aj.id.au>
 <20190712131028.ba4d4jetg4btsx4u@flea>
Date:   Mon, 15 Jul 2019 12:00:51 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Maxime Ripard" <maxime.ripard@bootlin.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jul 2019, at 22:41, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Jul 12, 2019 at 01:02:13PM +0930, Andrew Jeffery wrote:
> > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > data bus if only a single slot is enabled.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > In v2:
> >
> > * Rename to aspeed,sdhci.yaml
> > * Rename sd-controller compatible
> > * Add `maxItems: 1` for reg properties
> > * Move sdhci subnode description to patternProperties
> > * Drop sdhci compatible requirement
> > * #address-cells and #size-cells are required
> > * Prevent additional properties
> > * Implement explicit ranges in example
> > * Remove slot property
> >
> >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > new file mode 100644
> > index 000000000000..67a691c3348c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -0,0 +1,90 @@
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
> > +    enum: [ aspeed,ast2400-sd-controller, aspeed,ast2500-sd-controller ]
> > +  reg:
> > +    maxItems: 1
> > +    description: Common configuration registers
> > +  ranges: true
> > +  clocks:
> > +    maxItems: 1
> > +    description: The SD/SDIO controller clock gate
> 
> #address-cells and #size-cells have not been described here.
> 
> > +patternProperties:
> > +  "^sdhci@[0-9a-f]+$":
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        enum: [ aspeed,ast2400-sdhci, aspeed,ast2500-sdhci ]
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
> 
> But that means that it will generate a warning in your DT if you ever
> use them.
> 
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
> 
> Starting with your example.

Heh, right. Thanks. I was inspecting the output of the `dt_binding_check` and
`dtbs_check` make targets, though maybe I overlooked this. The aspeed dtsis
do generate a quite a number of warnings which make it hard to parse, so I'm
going to send a series to clean that up too.

Andrew

> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> Attachments:
> * signature.asc

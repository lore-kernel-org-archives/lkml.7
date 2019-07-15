Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E072081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563197231;
	bh=GxnhC/Ih/eTne4sAYFx1uwwKG/I5gMIwXQArnlAPCUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dXayQs46c9zno+oYwYx/c9wWaF9BuE9eEzKnBE0HL5Oa+IBbudSVZ6FenOmuHe1QL
	 sn+acWLOOKsmA5vtXUoxTGmolZsIztnczcfy8hQTDG2K5LFjRqeBIterYqF5axxSwO
	 AEHHSwFXfL/qvcESZtr6EwOAeIyLaZ0FP1ZwF5lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfGON1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbfGON1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:27:10 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363CF2083D;
        Mon, 15 Jul 2019 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563197229;
        bh=GxnhC/Ih/eTne4sAYFx1uwwKG/I5gMIwXQArnlAPCUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NLvzd1fskhQwU1pIotSqBV89rbfMbVYWIngSGmpeuEsPxyKyJnFQ8pXKBNWzMEjxg
         D3ZoCNenBJ/ixDifgar+e716Ela2R+/V7T8rYIsf7M9DlVgKO3dZHd/aFNgOg05S+q
         IBso2tRwQXwTgPA9bnI/MYh0VNhzV0kjKVeP+6Yk=
Received: by mail-qt1-f169.google.com with SMTP id r6so11358151qtt.0;
        Mon, 15 Jul 2019 06:27:09 -0700 (PDT)
X-Gm-Message-State: APjAAAUXac+UE18PFVdZzA1AfHWHXVbNlsEiueNbh4FSk/ZYHGgJgJU2
        4dbdvLlHphvA8ZPmQlXUKuRW4U0GxNvboQLYNQ==
X-Google-Smtp-Source: APXvYqwvshJ20th9zSr6jf5QHFCKYj9JX7MhdNWF2Jwas5AFsAL8CZaYemA4OyF7S4hIa5OiVvjidb5D3A9mE6urluU=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr18044197qtc.143.1563197228400;
 Mon, 15 Jul 2019 06:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190712033214.24713-1-andrew@aj.id.au> <20190712033214.24713-2-andrew@aj.id.au>
 <20190712131028.ba4d4jetg4btsx4u@flea> <5c831fd3-d0e2-474b-8a6e-8f51f92fbdf8@www.fastmail.com>
In-Reply-To: <5c831fd3-d0e2-474b-8a6e-8f51f92fbdf8@www.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Jul 2019 07:26:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+oLFZof1zpvUs_Siek=+Rc+CPYL-_oE0KuiXwunr0vA@mail.gmail.com>
Message-ID: <CAL_JsqK+oLFZof1zpvUs_Siek=+Rc+CPYL-_oE0KuiXwunr0vA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
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

On Sun, Jul 14, 2019 at 8:30 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 12 Jul 2019, at 22:41, Maxime Ripard wrote:
> > Hi,
> >
> > On Fri, Jul 12, 2019 at 01:02:13PM +0930, Andrew Jeffery wrote:
> > > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > data bus if only a single slot is enabled.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > > In v2:
> > >
> > > * Rename to aspeed,sdhci.yaml
> > > * Rename sd-controller compatible
> > > * Add `maxItems: 1` for reg properties
> > > * Move sdhci subnode description to patternProperties
> > > * Drop sdhci compatible requirement
> > > * #address-cells and #size-cells are required
> > > * Prevent additional properties
> > > * Implement explicit ranges in example
> > > * Remove slot property
> > >
> > >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > new file mode 100644
> > > index 000000000000..67a691c3348c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > @@ -0,0 +1,90 @@
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ASPEED SD/SDIO/eMMC Controller
> > > +
> > > +maintainers:
> > > +  - Andrew Jeffery <andrew@aj.id.au>
> > > +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> > > +
> > > +description: |+
> > > +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> > > +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> > > +  only a single slot is enabled.
> > > +
> > > +  The two slots are supported by a common configuration area. As the SDHCIs for
> > > +  the slots are dependent on the common configuration area, they are described
> > > +  as child nodes.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum: [ aspeed,ast2400-sd-controller, aspeed,ast2500-sd-controller ]
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: Common configuration registers
> > > +  ranges: true
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description: The SD/SDIO controller clock gate
> >
> > #address-cells and #size-cells have not been described here.
> >
> > > +patternProperties:
> > > +  "^sdhci@[0-9a-f]+$":
> > > +    type: object
> > > +    properties:
> > > +      compatible:
> > > +        enum: [ aspeed,ast2400-sdhci, aspeed,ast2500-sdhci ]
> > > +      reg:
> > > +        maxItems: 1
> > > +        description: The SDHCI registers
> > > +      clocks:
> > > +        maxItems: 1
> > > +        description: The SD bus clock
> > > +      interrupts:
> > > +        maxItems: 1
> > > +        description: The SD interrupt shared between both slots
> > > +    required:
> > > +      - compatible
> > > +      - reg
> > > +      - clocks
> > > +      - interrupts
> > > +
> > > +additionalProperties: false
> >
> > But that means that it will generate a warning in your DT if you ever
> > use them.
> >
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - ranges
> > > +  - clocks
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > +    sdc@1e740000 {
> > > +            compatible = "aspeed,ast2500-sd-controller";
> > > +            reg = <0x1e740000 0x100>;
> > > +            #address-cells = <1>;
> > > +            #size-cells = <1>;
> >
> > Starting with your example.
>
> Heh, right. Thanks. I was inspecting the output of the `dt_binding_check` and
> `dtbs_check` make targets, though maybe I overlooked this. The aspeed dtsis
> do generate a quite a number of warnings which make it hard to parse, so I'm
> going to send a series to clean that up too.

FYI, This will run checks with only the schema file you specify:

make dtbs_check DT_SCHEMA_FILES=path/to/schema/file

Rob

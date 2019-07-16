Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DEFC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BA420693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="CYq86GPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJub+36u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfGPAgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:36:07 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33339 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730383AbfGPAgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:36:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7747D24B2;
        Mon, 15 Jul 2019 20:36:03 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 15 Jul 2019 20:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=lu8e+uCpgbaeLhKrGOVG0g/dTSb7gKM
        npkRfxw4hnDQ=; b=CYq86GPnRvAbQqnT2FQI3ZjJn7JEKJ6/kCZGW6/rVpaKIx0
        6tIja+Q+ZIuxE5X44URf7fyZ3rUL4CtvEWzufsQjebuEEbtx2NrMZwh3g8HRKb6l
        l3/72gv/btltkUQw/Fp5NX2XavEPhwsP2c+imP2mEnA7elhaTvbdJaJlU/AMpwH0
        eOM66D9yG3aB1le5GlPQylnCkrq72DsGbf0VO7nTxx43ApABa3PLxLiXhmoJCJ9l
        X3Ufau7GXlGsukGNQPR3JSaLdmSemnKF22exKUAlJXlj7Q8fp1kBVMo0dGmAKVtD
        xY+ealemevz/uXhvgjF+FF8WJi7xOXNRFJDjo5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lu8e+u
        CpgbaeLhKrGOVG0g/dTSb7gKMnpkRfxw4hnDQ=; b=kJub+36ucMMFuieARDasOv
        lsAgmPBfaMZ4Wc57Q6fKdhHHT9Wmi49Z1p5ujybwhDI6o0RK9VXtjrKyifLk4zgw
        LdQpoQtpJv/YchjSDQ6fWMzRPEWHliUhGl+Cb8+BCDk/WDL/U11qfB3KmTM+P4X1
        RF3cYrAdlVFNnvrxaqA5RWwiGkl3AvO80MmNnmVNngPCTMmquEqh6brv3VARppJv
        x8uDsF6342/PGf8w5IwTegVp68jvyWL3YXO7h4Jl4DxLTtI/JkCPxbc242oznut2
        BdActXPVesaGfTK/LX8zr5JPQ/avgZg1jeTAiU6pqeftTqLLwVWGYdRyP11AHiYA
        ==
X-ME-Sender: <xms:8RstXbjUkbDEu6j9WWlg6myxUP9fREb4cOApbg4gAALYd2Qct0eaMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepuggvvhhitggvthhrvggvrdhorhhgnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    nhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8RstXZRWqojCpwkGqjHuSrQ_imrsnMcNF1PXhMvKeMU8jfiicGMSXg>
    <xmx:8RstXYIy0v0wBG8DskTXa26bDwW9UX_Cy8UvFvpICHADvmCKVKSFAw>
    <xmx:8RstXbRP3ApibNVpb_MEzmkgh8GWXVhVDZDaDFzNUT084jBMN6NBog>
    <xmx:8xstXdgtSACnczm7UywOQVm9o6iC8wpf4sNneKB1XIPEszck4oB3Sg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8ED2AE01C8; Mon, 15 Jul 2019 20:36:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-731-g19d3b16-fmstable-20190627v1
Mime-Version: 1.0
Message-Id: <3fe55ea9-b949-48a0-9eab-90ad3bc1ee2a@www.fastmail.com>
In-Reply-To: <CAL_JsqLkOtsAxj9NvNB=EEkH00k-dtNedNY042uuntSmcjhDhA@mail.gmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-2-andrew@aj.id.au>
 <CAL_JsqLkOtsAxj9NvNB=EEkH00k-dtNedNY042uuntSmcjhDhA@mail.gmail.com>
Date:   Tue, 16 Jul 2019 10:06:11 +0930
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
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jul 2019, at 07:47, Rob Herring wrote:
> On Thu, Jul 11, 2019 at 9:32 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
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
> 
> This is actually a list of 4 strings. Please reformat to 1 per line.

On reflection that's obvious, but also a somewhat subtle interaction with the
preference for no quotes (the obvious caveat being "except where required").

Thanks for pointing it out.

I have been running `make dt_binding_check` and `make dtbs_check` over
these, looks like I need to up my game a bit though. Do you do additional things
in your workflow?

Andrew

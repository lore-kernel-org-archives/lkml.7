Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D750C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085F62184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Xcm/YHBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lMuDHEXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbfGRBtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:49:32 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48613 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729988AbfGRBtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:49:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7A770260F;
        Wed, 17 Jul 2019 21:49:30 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 17 Jul 2019 21:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=9Rjxs3ybdXD97njl51L/lenQ/wepI2j
        gkiQSvZwds3s=; b=Xcm/YHByppopAK35/zTpmNQeD96EbG8sbIV0aGGuJtzigLD
        VLcegeMSPa+8DzFZPjCBAMGIFNvtwWlb4CXm0Yyvg2DIAIiH7904aT3AkzzVltzU
        c/zjd0f8Busrit7edtg+Mu28pgq9BREB/m9zjMK955r32M8SX0tpArywQM4DVwzr
        H0OsvbOkLCaTjkOzu5m+Tjp+9Tj7GWiyj2gnusUg+sTDs+UBhzYmKTK7zTfGXMqf
        zly0Ch0mGKoeCi3ZB7iePQjzSPWluh6R1+HBOqvpWWpBhxPFar7B5WZIgPIJrOzA
        Z0Bpi60BpvOJPIZOpOE6ox+DJZs2eHnJDOqwYRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9Rjxs3
        ybdXD97njl51L/lenQ/wepI2jgkiQSvZwds3s=; b=lMuDHEXfjp6pWBOr7n9F+W
        Vtm0pSIKcPfRgRonhx+Llt/HU/pUcNTPXYy6/DqFq/llMh4/VFsDLQ27qt1yuoSn
        Pyqs65Vo/H9B8N9FY+kGWRBs1FcVvDBs3drQlLBMwbn9UE4xzPT1svrzMRh0qVwc
        mIHuJGG3k0CpfW9SFnU9EAEZKKkr7C73bDuP6SmFS+pOjR/XmEgPTT26SfmdZeXO
        opyeNY9VP/gianUENE5oUg8S4SI9Lz0JUDMru2GliYEGcFK0sAxMeT8LGTTgJY0C
        7bqhLDwAmL02S8J9/JJmKMo9NH6putOw/ehaO/b5GKdDihPuIOiWMTvqNvSiTD0Q
        ==
X-ME-Sender: <xms:KtAvXdGyvuxqYwQcPZLS3AcoM9p3IP9B4GrPGIV8oNsJB3tkvEjerw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrieeggdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepuggvvhhitggvthhrvggvrdhorhhgpdifrhhithhinhhgqdhstghhvghmrgdrmhgu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuve
    hluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:KtAvXXnyhEfoBshOhcwqIde0B1wR8JDybt3_h35SCMN2mIeUakHLpA>
    <xmx:KtAvXQ2TkzMreHtrcSLFQfwdDc-fjkldzFFPIl9YMkvpvn0NrSeYeA>
    <xmx:KtAvXbRAOJauPvD8sMNF_lvXhsQQdriZUPuQsKADtn3MXyF35OmeYg>
    <xmx:KtAvXfvuD7BqrNAJQyWrivPFY5gdi2b0Q2QOzZJvg5XkfBAjdA4NqA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 11AABE03EA; Wed, 17 Jul 2019 21:49:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-731-g19d3b16-fmstable-20190627v1
Mime-Version: 1.0
Message-Id: <e93c02e3-c855-4f29-aa20-535dd53d9321@www.fastmail.com>
In-Reply-To: <CAL_JsqKYL5yv8E=aKD1fJwXx1LLdUAs_ZFrc5k1dHsB9u+2ing@mail.gmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-2-andrew@aj.id.au>
 <CAL_JsqLkOtsAxj9NvNB=EEkH00k-dtNedNY042uuntSmcjhDhA@mail.gmail.com>
 <3fe55ea9-b949-48a0-9eab-90ad3bc1ee2a@www.fastmail.com>
 <CAL_JsqKMo_uv4Ur-D4NaUXk94hGJeRt5fg+0998dDjJCTgumGg@mail.gmail.com>
 <e7b472a8-73ae-4f39-a3e4-9e2d9dbcd01e@www.fastmail.com>
 <CAL_JsqKYL5yv8E=aKD1fJwXx1LLdUAs_ZFrc5k1dHsB9u+2ing@mail.gmail.com>
Date:   Thu, 18 Jul 2019 11:19:40 +0930
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



On Wed, 17 Jul 2019, at 23:13, Rob Herring wrote:
> On Tue, Jul 16, 2019 at 9:58 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Wed, 17 Jul 2019, at 00:27, Rob Herring wrote:
> > > On Mon, Jul 15, 2019 at 6:36 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > >
> > > >
> > > > On Tue, 16 Jul 2019, at 07:47, Rob Herring wrote:
> > > > > On Thu, Jul 11, 2019 at 9:32 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > > >
> > > > > > The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> > > > > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > > > > data bus if only a single slot is enabled.
> > > > > >
> > > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > > > > ---
> > > > > > In v2:
> > > > > >
> > > > > > * Rename to aspeed,sdhci.yaml
> > > > > > * Rename sd-controller compatible
> > > > > > * Add `maxItems: 1` for reg properties
> > > > > > * Move sdhci subnode description to patternProperties
> > > > > > * Drop sdhci compatible requirement
> > > > > > * #address-cells and #size-cells are required
> > > > > > * Prevent additional properties
> > > > > > * Implement explicit ranges in example
> > > > > > * Remove slot property
> > > > > >
> > > > > >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
> > > > > >  1 file changed, 90 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..67a691c3348c
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > > > @@ -0,0 +1,90 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: ASPEED SD/SDIO/eMMC Controller
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Andrew Jeffery <andrew@aj.id.au>
> > > > > > +  - Ryan Chen <ryanchen.aspeed@gmail.com>
> > > > > > +
> > > > > > +description: |+
> > > > > > +  The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the SDIO
> > > > > > +  Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit data bus if
> > > > > > +  only a single slot is enabled.
> > > > > > +
> > > > > > +  The two slots are supported by a common configuration area. As the SDHCIs for
> > > > > > +  the slots are dependent on the common configuration area, they are described
> > > > > > +  as child nodes.
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum: [ aspeed,ast2400-sd-controller, aspeed,ast2500-sd-controller ]
> > > > >
> > > > > This is actually a list of 4 strings. Please reformat to 1 per line.
> > > >
> > > > On reflection that's obvious, but also a somewhat subtle interaction with the
> > > > preference for no quotes (the obvious caveat being "except where required").
> > >
> > > It wasn't something I'd run into before. I'm working on a check, but
> > > unfortunately we can only check for quotes not needed and can't check
> > > for missing quotes.
> > >
> > > > Thanks for pointing it out.
> > > >
> > > > I have been running `make dt_binding_check` and `make dtbs_check` over
> > > > these, looks like I need to up my game a bit though. Do you do additional things
> > > > in your workflow?
> > >
> > > That should have thrown the warnings. If you aren't seeing those, do
> > > you have dtschema package installed (see
> > > Documentation/devicetree/writing-schema.md)?
> >
> > I do have it installed, but as mentioned previously there's a fair few
> > warnings emitted currently by the Aspeed devicetrees, so it might have
> > got lost in the noise. I've started to clean that up, though probably need
> > some direction there too.
> >
> > Separately I'm currently trying to track down an issue where I get errors
> > on the Aspeed dts cpu nodes about failing to match the riscv CPU
> > compatibles, it seems dt-validate isn't finding the ARM CPU compatible
> > strings. It feels more annoying to track down that I'd like.
> 
> There's a fix in today's linux-next for that and it should be in
> Linus' tree in a few days.
> 

Thanks, I'll take a look.

Andrew

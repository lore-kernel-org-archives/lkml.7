Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E14C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6BB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563289056;
	bh=U42z2e4tCTHxP6Wr6zzHqfiVLXBTEYPAOO2p1lSrZNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y8yja/jpiTJBXHjKNYc164If+btfd3Sj2u1Q2jpCvQrceap5d94dHTlKilsR99xC8
	 QzWzm+VBuYqN9WW1+pquhXiCej3+UoWSNULr1sbcuTrAoAPCS5Mk3ClEXRs0B8XoGO
	 xXURxHtRQQXUT5sf5UtyT5Ubfu5vrF3ApAPc/4WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfGPO5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfGPO5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:57:34 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F5C217F4;
        Tue, 16 Jul 2019 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563289053;
        bh=U42z2e4tCTHxP6Wr6zzHqfiVLXBTEYPAOO2p1lSrZNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iV98308aMsPTi2CN5VG60zRBK3FK0hKYQIfxuEKr6pRSABb4hhBER0nxiB4/wv/ji
         dFzv62BnXedW7Ul8okOD+YZ5ldMqOMeNL6egrQ1jdnnZE0t0zmbmdGtvYSH3wje4+o
         pI0xt0K10YfTC8rD42wOq+BCOGeW/slQFZYNf4PU=
Received: by mail-qk1-f169.google.com with SMTP id t8so14830385qkt.1;
        Tue, 16 Jul 2019 07:57:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUyBPvIf3393+TM108nZFCD+HXiKTvEXEKDb8Q8b8anTauXAvYl
        yE9MVd7BL0dMK5+SZS8xnShblbymJsm/EUKQkw==
X-Google-Smtp-Source: APXvYqyE4Fk9jDy25Hb1UFb/TR0uJK2FJa0lq9CraTzQ97i00y46wdPQlFv5huCO4g3lu9C2h82sx7IiaEkwujJxStU=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr22288549qkl.254.1563289052931;
 Tue, 16 Jul 2019 07:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190712033214.24713-1-andrew@aj.id.au> <20190712033214.24713-2-andrew@aj.id.au>
 <CAL_JsqLkOtsAxj9NvNB=EEkH00k-dtNedNY042uuntSmcjhDhA@mail.gmail.com> <3fe55ea9-b949-48a0-9eab-90ad3bc1ee2a@www.fastmail.com>
In-Reply-To: <3fe55ea9-b949-48a0-9eab-90ad3bc1ee2a@www.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Jul 2019 08:57:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMo_uv4Ur-D4NaUXk94hGJeRt5fg+0998dDjJCTgumGg@mail.gmail.com>
Message-ID: <CAL_JsqKMo_uv4Ur-D4NaUXk94hGJeRt5fg+0998dDjJCTgumGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
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

On Mon, Jul 15, 2019 at 6:36 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Tue, 16 Jul 2019, at 07:47, Rob Herring wrote:
> > On Thu, Jul 11, 2019 at 9:32 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
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
> >
> > This is actually a list of 4 strings. Please reformat to 1 per line.
>
> On reflection that's obvious, but also a somewhat subtle interaction with the
> preference for no quotes (the obvious caveat being "except where required").

It wasn't something I'd run into before. I'm working on a check, but
unfortunately we can only check for quotes not needed and can't check
for missing quotes.

> Thanks for pointing it out.
>
> I have been running `make dt_binding_check` and `make dtbs_check` over
> these, looks like I need to up my game a bit though. Do you do additional things
> in your workflow?

That should have thrown the warnings. If you aren't seeing those, do
you have dtschema package installed (see
Documentation/devicetree/writing-schema.md)? Or it could be erroring
out on something else first. There's a few breakages that I'm trying
to fix.

Rob

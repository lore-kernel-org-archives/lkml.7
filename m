Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E5BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B46521848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBGmCN2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbfHVMOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:14:54 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37798 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbfHVMOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:14:54 -0400
Received: by mail-vk1-f194.google.com with SMTP id b144so1495556vkf.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=001ZjFQMxb/zCLk3zcyFqNqBIiCvp+5VqdO2trNiRjw=;
        b=rBGmCN2TSFf+woRq1U6/8fgdOQP55ndxj6XdO2EdMKOeGV2MrzU8rvwexXqn72Xj03
         3I8c//L8dMyqiq7nE5jvcTkI4B0Rx7q0EtsmX/2Txly9jCIZd67IEQR3P8FwpE8V6W7z
         mwvCR8G9OPcGTa1Ajb3KI7CPl5HDZbPsyHblwWWMZlR920QJ1MQiljgf68A6WiMzYKL5
         ZWH+8SZqMK3Z3Z8weGjBTh1dxKZVJpQB00Y1CPBOii/AhCl4uzkCyBotPMpyvY8X0PJ+
         uWvN0QpzLt2ack1QdKqeFGY5rKmZfI65PQ16PC1MYg/rHNriK/R+nUSHHC/SbdEksOn1
         y2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=001ZjFQMxb/zCLk3zcyFqNqBIiCvp+5VqdO2trNiRjw=;
        b=UvozwfxXgDgyEyAzFWtSfySYYH7WgVhRkF/vrPhka70xJDJA35QzrSVNj7U5O/Pac4
         1692lTEeVzRbFG5EVuLz5WhfnJHqgKzeVe4K9b9Au+IuBIxm4+ohA7PmnuaiY4SVwkys
         VZKd4bqTj8jx0a/xgMeJoJj32m/bW9VwyJwMNMFjhHXTap90mANwgOANKNw7MN9lEcf8
         kJWqnvk/QhBJUfW349UvyrEwNjs6Rs4eEKwz2slBRc4ET/uhHaOX/MQFyruIG6Wo3uqB
         mtI07U5QyV4/VgnocSTYZ1SYb61cXwsqwQlZ9umdvnMcK+Ic/wyPpCaBrZcgHaOuwGFM
         k6ow==
X-Gm-Message-State: APjAAAX8VJDxXHM7oAZKmN1x5q8T5erokV6YT7enNB47kwZ7j3HY7v2a
        4IynTEB4OgfclZeApC2OolEpPJTAeD83ccjfyAB74Q==
X-Google-Smtp-Source: APXvYqwOUeGGRRhaJGbVZ+SG70B06PdKeEzkxHgHaunrpKDQKwl27GuCbI2yR22beKWFZus69SGWNY0cH93dmwthMeg=
X-Received: by 2002:a1f:5602:: with SMTP id k2mr9999325vkb.36.1566476093048;
 Thu, 22 Aug 2019 05:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190807003629.2974-1-andrew@aj.id.au> <20190807003629.2974-2-andrew@aj.id.au>
 <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com>
 <6c94aada-9c4a-4f55-9a43-349282ad12af@www.fastmail.com> <CAPDyKFrDPxFMm710Z25i-euOT2rrgCNXVa4na-fye0xamMXq_A@mail.gmail.com>
 <c78d4c45-477b-4078-b269-aec72571c8cd@www.fastmail.com>
In-Reply-To: <c78d4c45-477b-4078-b269-aec72571c8cd@www.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:14:16 +0200
Message-ID: <CAPDyKFrWMjaqv8z6HnmDn12c2SsjU6fEzjZesxj=nwbP9YRiPw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryanchen.aspeed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 at 13:55, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 22 Aug 2019, at 21:15, Ulf Hansson wrote:
> > On Thu, 15 Aug 2019 at 07:37, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > >
> > >
> > > On Thu, 15 Aug 2019, at 15:06, Joel Stanley wrote:
> > > > On Wed, 7 Aug 2019 at 00:38, Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > >
> > > > > The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> > > > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > > > data bus if only a single slot is enabled.
> > > > >
> > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > >
> > > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > >
> > > > Two minor comments below.
> > > >
> > > > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > > @@ -0,0 +1,105 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > >
> > > > No "Copyright IBM" ?
> > >
> > > I'm going rogue.
> > >
> > > That reminds me I should chase up where we got to with the binding
> > > licensing.
> > >
> > > >
> > > > > +%YAML 1.2
> > > > > +---
> > > >
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > > > +    sdc@1e740000 {
> > > > > +            compatible = "aspeed,ast2500-sd-controller";
> > > > > +            reg = <0x1e740000 0x100>;
> > > > > +            #address-cells = <1>;
> > > > > +            #size-cells = <1>;
> > > > > +            ranges = <0 0x1e740000 0x10000>;
> > > >
> > > > According to the datasheet this could be 0x20000. It does not matter
> > > > though, as there's nothing in it past 0x300.
> > >
> > > Good catch.
> > >
> >
> > Are you planning on sending a v6 or you want me to apply this and you
> > can post a patch on top?
>
> Yeah, sorry, I wasn't very clear there. I was hoping just to do a follow-up
> patch with the cleanups if you're okay with that?

That's fine. V5 applied for next, thanks!

Kind regards
Uffe

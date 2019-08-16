Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCBAC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781E92173E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+RGjsXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfHPL54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:57:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36025 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfHPL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:57:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so1305702wrt.3;
        Fri, 16 Aug 2019 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3owt7CIcSpc8cBZykFrs5XYNVBKRHnGIaWwBA3IAOUg=;
        b=n+RGjsXkn7qujRTwk8aiu8/bBhtBcZVb/be6IIAS5tuj2MIO/85uX4jq+zNdIjO/8t
         PmrK2Au1oQGF1N7EmhiyitWkXjrebzls+6qiEUcOmAzaYVnolRiZqcmkhkbhhZZI1M1C
         J/56uGjaQGmHyPBVeOZ5ie9Zb1wmUBMIp7TQCv8twj5jTx7X68e0SfgHJyS63hVsVFUn
         wgKACA86RZg89Lvt2WsJBOAmV52zl63pbTFpqHn90pZZpyZMmiygdDj4pDfRvU7ExiZz
         RHzQBU8lfuTBKjOiSJRAzmI2/dNyxNeaJtE0TPFB2WV4XYuM+/jklpHDu7ygWiqKkq3y
         0O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3owt7CIcSpc8cBZykFrs5XYNVBKRHnGIaWwBA3IAOUg=;
        b=KP/4Eb0AGotntVsynrxtBMaqd3kvLR0BYfuYt2wc+RA1mjDsZTIBnZwdN3C5fYBkHF
         5rJbmPi0akRiiWzicbDZ3hPdTmiMI0Ic9ZL9xuyDcdcTJIRmAxnMrRXMfR5cEw+4JwaE
         QVmzgYV8P9nmMzXZci58QjjoNQoNpyBWxorL4ifWFJIC8RjQ9HI02sqL4wfJXkrJ6Ege
         A7hv3iEMdyPgL194IuKidQ0rH3hJ/zJX6F9MjvkjfaADVbF2v9iDWFL0xHvtoqG4KedF
         XGCW5uE42wSie0xghmm4QCwYaVILQuT3emW3upB05JZn4vnCKWUFEt7GDS2LcEoFoGJO
         Fe9g==
X-Gm-Message-State: APjAAAWaksIHgTPyB4goEq3K7yHtKmFGhZAhQ9a6fjjAhZV6hogD1xvv
        D8297rizw3xTeAisUZcuARw=
X-Google-Smtp-Source: APXvYqxTNqwHq0WVu2D09lrdzA/RLQGrmdozZ6J5eBdQXu18+f9N8PeAwHj98h+nMUCQawcD2DuQ6Q==
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr10864468wrt.259.1565956673248;
        Fri, 16 Aug 2019 04:57:53 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id m23sm7291053wml.41.2019.08.16.04.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 04:57:52 -0700 (PDT)
Date:   Fri, 16 Aug 2019 13:57:50 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM64: dts: allwinner: Add devicetree for pine H64
 modelA evaluation board
Message-ID: <20190816115750.GA24545@Red>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
 <20190812094000.ebdmhyxx7xzbevef@flea>
 <20190814131741.GB24324@Red>
 <20190814133322.dawzv3ityakxtqs4@flea>
 <20190816093513.GA25042@Red>
 <20190816113650.hstbi5ntstx3wh4a@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816113650.hstbi5ntstx3wh4a@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:36:50PM +0200, Maxime Ripard wrote:
> On Fri, Aug 16, 2019 at 11:35:13AM +0200, Corentin Labbe wrote:
> > On Wed, Aug 14, 2019 at 03:33:22PM +0200, Maxime Ripard wrote:
> > > On Wed, Aug 14, 2019 at 03:17:41PM +0200, Corentin Labbe wrote:
> > > > On Mon, Aug 12, 2019 at 11:40:00AM +0200, Maxime Ripard wrote:
> > > > > On Thu, Aug 08, 2019 at 10:42:53AM +0200, Corentin Labbe wrote:
> > > > > > This patch adds the evaluation variant of the model A of the PineH64.
> > > > > > The model A has the same size of the pine64 and has a PCIE slot.
> > > > > >
> > > > > > The only devicetree difference with current pineH64, is the PHY
> > > > > > regulator.
> > > > > >
> > > > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> > > > > >  .../sun50i-h6-pine-h64-modelA-eval.dts        | 26 +++++++++++++++++++
> > > > > >  2 files changed, 27 insertions(+)
> > > > > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > > > > > index f6db0611cb85..9a02166cbf72 100644
> > > > > > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > > > > > @@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
> > > > > >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> > > > > > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelA-eval.dtb
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > > > > > new file mode 100644
> > > > > > index 000000000000..d8ff02747efe
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > > > > > @@ -0,0 +1,26 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > > > > +/*
> > > > > > + * Copyright (C) 2019 Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > > > + */
> > > > > > +
> > > > > > +#include "sun50i-h6-pine-h64.dts"
> > > > > > +
> > > > > > +/ {
> > > > > > +	model = "Pine H64 model A evaluation board";
> > > > > > +	compatible = "pine64,pine-h64-modelA-eval", "allwinner,sun50i-h6";
> > > > > > +
> > > > > > +	reg_gmac_3v3: gmac-3v3 {
> > > > > > +		compatible = "regulator-fixed";
> > > > > > +		regulator-name = "vcc-gmac-3v3";
> > > > > > +		regulator-min-microvolt = <3300000>;
> > > > > > +		regulator-max-microvolt = <3300000>;
> > > > > > +		startup-delay-us = <100000>;
> > > > > > +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
> > > > > > +		enable-active-high;
> > > > > > +	};
> > > > > > +
> > > > > > +};
> > > > > > +
> > > > > > +&emac {
> > > > > > +	phy-supply = <&reg_gmac_3v3>;
> > > > > > +};
> > > > >
> > > > > I might be missing some context here, but I'm pretty sure that the
> > > > > initial intent of the pine h64 DTS was to support the model A all
> > > > > along.
> > > > >
> > > >
> > > > The regulator changed between modelA and B.
> > > > See this old patchset (supporting modelA) https://patchwork.kernel.org/patch/10539149/ for example.
> > >
> > > I'm not sure what your point is, but mine is that everything about the
> > > model A should be in sun50i-h6-pine-h64.dts.
> > >
> >
> > model A and B are different enough for distinct dtb, (see sub-thread
> > on HDMI difference for an other difference than PHY regulator)
> 
> I don't mind having separate DTBs for model A and model B.
> 
> > And clearly, the current dtb is for model B.
> 
> That DTS was added almost a year before the model B was announced, and
> no commit to that file mention the model B, so it's definitely not
> clear.

Normal it was added for model A (without any ethernet/HDMI support, so nothing distinct from model B), and the modelB ethernet/HDMI support cames after.

> 
> > So do you mean that we need to create a new dtb for model B ? (and
> > hack the current back to model A ?)
> 
> I'd prefer not to hack anything, but yes
> 

Since model A is not public (only evaluations boards exists), the probability of a production model A is low and the current dtb is perfect for model B , could you reconsider this ?


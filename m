Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE894C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB132054F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zstxc6VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfHNNRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:17:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54587 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHNNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:17:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so4579246wme.4;
        Wed, 14 Aug 2019 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nS6Loe3dK2UTdjVnUqv6CIxQZ7HLkH2zfcjivNgRpLI=;
        b=Zstxc6VWuoKtV4f2t4/yQqpkkiSpCt0jCdEjaNorkg6qw5woV6qyP9v8JWsyA8ZuOt
         /WnDUf0dSeDEWj/PAKCDrJ8IoJSSykuqSCLdfb6w9WCGGaxWLchVQuhxFZkIskUQlYQb
         T5RrK+coEHnYcGUOVF/rvrQ9OaKvZgnrcRgqkD9pYV1LRsLuT6sGAcK0QMqPBiFI8w2E
         /RWCFVO6rkHW2TLCb7OtOIsO0ml1bZipVmxg80XptSy4wMtejdVqliL+5td8y9pLuLzZ
         WjJAZGt1oQw8l+tn2qd8VdYcb5N5Y6tyBDIngHHjnvdICkIG0MGTV9RE+i1ekBVvfcle
         bNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nS6Loe3dK2UTdjVnUqv6CIxQZ7HLkH2zfcjivNgRpLI=;
        b=D3pEjO2sOaGvKCZmkyDcLRrFm7L/Pl442KY6O6dtKpnQWzbdlvhQRN2QfiQCGLp/sY
         4arpK0p1REP/KwRzvkN0Wo/rBi43nzhqx6pgxUEcV6is2IOmWTwYWHlzpx7MrxDfLNEK
         h/qt7JYdaTLC3S6wnhfN+rYNe8N+B5rICvbsSx/I+AG0+6ydI6mQwZ9fLB9IwYv+XZG4
         V/gb4ECtSIQQq4h3RheU2nFdz+uqLKkqc5Tolr/rXRX9rnyENy/F0C7UUm8/nAeBI4VT
         k47bIoeGloQMym+4c918MAQrklPUFU5SP24lMUGJ/UaRBc0JMX+C+k/ZHTu7sEMovXz+
         bf/g==
X-Gm-Message-State: APjAAAWr4Ez3vL4sPGsO/zMt1vi59p/21uJemFhzxau3Nz6zhRRdVnK2
        4thaUlQJ1+mV4d8PqPkINgw=
X-Google-Smtp-Source: APXvYqxEJnurre1B5JoWb8cf3F3YIYMlaRMIrlAd55zm6bKAjBTJgzAROO6F0J1wzlQqcLA0Kev2zA==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr8525569wmg.120.1565788664121;
        Wed, 14 Aug 2019 06:17:44 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k124sm10155041wmk.47.2019.08.14.06.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:17:43 -0700 (PDT)
Date:   Wed, 14 Aug 2019 15:17:41 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM64: dts: allwinner: Add devicetree for pine H64
 modelA evaluation board
Message-ID: <20190814131741.GB24324@Red>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
 <20190812094000.ebdmhyxx7xzbevef@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812094000.ebdmhyxx7xzbevef@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:40:00AM +0200, Maxime Ripard wrote:
> On Thu, Aug 08, 2019 at 10:42:53AM +0200, Corentin Labbe wrote:
> > This patch adds the evaluation variant of the model A of the PineH64.
> > The model A has the same size of the pine64 and has a PCIE slot.
> >
> > The only devicetree difference with current pineH64, is the PHY
> > regulator.
> >
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >  .../sun50i-h6-pine-h64-modelA-eval.dts        | 26 +++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > index f6db0611cb85..9a02166cbf72 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelA-eval.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > new file mode 100644
> > index 000000000000..d8ff02747efe
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2019 Corentin Labbe <clabbe.montjoie@gmail.com>
> > + */
> > +
> > +#include "sun50i-h6-pine-h64.dts"
> > +
> > +/ {
> > +	model = "Pine H64 model A evaluation board";
> > +	compatible = "pine64,pine-h64-modelA-eval", "allwinner,sun50i-h6";
> > +
> > +	reg_gmac_3v3: gmac-3v3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc-gmac-3v3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		startup-delay-us = <100000>;
> > +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +};
> > +
> > +&emac {
> > +	phy-supply = <&reg_gmac_3v3>;
> > +};
> 
> I might be missing some context here, but I'm pretty sure that the
> initial intent of the pine h64 DTS was to support the model A all
> along.
> 

The regulator changed between modelA and B.
See this old patchset (supporting modelA) https://patchwork.kernel.org/patch/10539149/ for example.

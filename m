Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94EAC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E83208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bl3VdEFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfFGVEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:04:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37777 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbfFGVEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:04:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so2913072ljf.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkU0CLA4zd7U+4w/MeYB7MsnfkDi0Po4BQ8jWMFBUjo=;
        b=Bl3VdEFDNRcw68lQN2+iAhPiWw5DQMPXg2SfOdO0jMkLGnBZ+uzq2sVjmQ4vaHAbG4
         yNaYAP/1r/yIlm+Vay8Wsve+dfOIcTk28G0cVRmtAwbrROgC3Dyj8uSlyUDJNpKeM1wL
         EBMTqw5WMOWJKdh3wSd10dvEDiZK+z1gGAbKjQrBjE6N7MCrUY9X5KM/bZYvdjcRZ424
         gdJXbrG19WOm+xi1E8pcpR2k4g5NwCTXuPQO1pXeFt8zefmVKfKGIXKgKIHsdyV+XrUH
         AIsp1mw/e21lcxOHA2q/t59+syFLF30vm0Vl1BbVgLnQG/sILfmw0yuI/keT7LFF3F9f
         Ghqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkU0CLA4zd7U+4w/MeYB7MsnfkDi0Po4BQ8jWMFBUjo=;
        b=VbXRg63EtvvrysNZ8a8y70bCE40ViGzKSoGq+Mwu2GaZpWXK1cvvCvB2CwBKaNzDcF
         H373OBu4HgaWPq0vKg2L7kwWdnZ4h4a1OLUZ0qAko9pUFbKaOwQIf4odkEPbOuGRo0It
         GO07w8euYCRviNzBbcDLStqj1DvaYZNaeN0LtWd88lBPbNi/wl/GkvZ3YtqaHYxF8h8j
         ZVzZAnm/6yMgxTGw3eaK6CqT1qzvAHDLrY+mQ+RZvUwpEfJ1nbVO5gCDfBGfJtCmgcXG
         HC8Ybly/8nldmAtdnlZGA7nNy4xxYDZW60umIo6n+hAD6QdudEGnpdy1Chm2UdCOdjoB
         qHMA==
X-Gm-Message-State: APjAAAU/y8npl3objfBEU7HsdgAB0ZiVQpC3cEtFNAdkdxF0GCog8Sft
        d33w39t3GtshHaRBa2X3R7IONWQQSkf6+JtP4kG/Zg==
X-Google-Smtp-Source: APXvYqyCQqq/sYVcHyrozCmhdkems9DE56UaaALAZIcDJuvLRmL+KVL12nZblAfJci6jVwnq/iR/eVswn8WPsSelqws=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr19782540lje.46.1559941473627;
 Fri, 07 Jun 2019 14:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190530030546.9224-1-Anson.Huang@nxp.com>
In-Reply-To: <20190530030546.9224-1-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jun 2019 23:04:25 +0200
Message-ID: <CACRpkdY-35o378Ka+4bgeSPjmq6P8DM872sgTxq2X3dDP9XZHQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: imx: Add pinctrl binding doc for i.MX8MN
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 5:04 AM <Anson.Huang@nxp.com> wrote:

> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add binding doc for i.MX8MN pinctrl driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks mostly OK to me, but I'd like the maintainers to review,
so Dong et al please look at this!

> +Required properties:
> +- compatible: "fsl,imx8mn-iomuxc"

So should this not be "nxp,imx8mn-iomuxc"
or "nxp,freescale-imx8mn-iomuxc" or something these
days? The vendor name is nxp is it not.

I was complaining to the DT maintainers at one point that
these companies seem to buy each other left and right
so this vendor nomenclature is dubious, but I guess at least
it should reflect the vendor that produced the chip or something.

If everyone is happy with "fsl,*" I will not complain though.
(i.e. if the maintainers ACK it.)

Yours,
Linus Walleij

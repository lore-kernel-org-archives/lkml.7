Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C1C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC042084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAQW+cdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDCESc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:18:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36114 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:18:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id d18so10623097lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HC6posQV5j5NZ9mW39YFdgBU2oXDfxs147tyhLk/fAM=;
        b=SAQW+cdy+wchRwVRFd7KpYRCWgspAErMDZ9tBU1rrcT5lVFxpH1gy4sZFm+fvPr+Sl
         giHa1oXfPxoEa/BQRCStOkz/sAoTf45nCOnimjvQwQ/MXVYbgWNqn3/fjiTnbCJj8mks
         lht/XriHBiqpswodItgaxBDmgdz2c16Tk20ekK3LN47Oc8yTxb6kDncbLFjQ/2DmwZWM
         Q5wi+zZoU5Vwd5b9kvpF14CtNDMh1pXsbrVFxvvKZllXJhXOk0vZffTfGyox49syHrYl
         9b34/opOufhXPpJ0+HhcsZ9eIb0tLByyGuQs99faiAFFXqoLHbtjeUipxgfzTuIAgBPC
         Vokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HC6posQV5j5NZ9mW39YFdgBU2oXDfxs147tyhLk/fAM=;
        b=asAyQsqNfbd42OI/o7JhOqDDf3bhI0E7IhiRgWx2gBHbQNFzT2KfAp1+GR1JhEtj4D
         sVEOZEG7mUvLy3dLwPsO9Wp9Q6PLestiQsNhp3PouH3JNIK29k/CcDn9OGCdGNpuy22f
         sa0QfrxcBSDhywkcryb9lqplNCyre0bX/pEmAoc3WGB0/aJMAAeJIz4Q80746GIgCBJc
         yBg6gVVBb+/A5UX8cuJiHxYMF9d5rrk71dgQF/DZ2b45wRoJvxi/vjddkKkd1SW+Ooia
         iMDJ1AqQ04ZfSAZBknDsm3xnwXqXu0n9WFXekIVDI4PNHcYfaej9nx2uelkaAjpMiv79
         LDAQ==
X-Gm-Message-State: APjAAAWcLUj6tobWUMMK1/uXFmU4JKx4RzT07yNEFAPWrHhrRUA7h9Gd
        mJ/C04E+5togZMmpzAAp2rsQ/g8Aze8umewiSUPk/A==
X-Google-Smtp-Source: APXvYqzcFGi8a+D72/Q3EgLiCjezNzm1fvsFlFEjyl4dU83XWmqJRD1MIPJG9B6amyVPOIyAqpZt9tCN/l5wEx4c5XI=
X-Received: by 2002:ac2:5479:: with SMTP id e25mr1815363lfn.121.1554265110207;
 Tue, 02 Apr 2019 21:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 11:18:18 +0700
Message-ID: <CACRpkdbGCoXGNOveo3GR9OwRgLC_DYEaCXUqthpcojEzbdbN0g@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 2:02 AM Guenter Roeck <linux@roeck-us.net> wrote:

> Use devm_platform_ioremap_resource to reduce source code size,
> improve readability, and reduce the likelyhood of bugs.
>
> The conversion was done automatically with coccinelle using the
> following semantic patch.
>
> @r@
> identifier res, pdev;
> expression a;
> expression index;
> expression e;
> @@
>
> <+...
> - res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> - a = devm_ioremap_resource(e, res);
> + a = devm_platform_ioremap_resource(pdev, index);
> ...+>
>
> @depends on r@
> identifier r.res;
> @@
> - struct resource *res;
>   ... when != res
>
> @@
> identifier res, pdev;
> expression index;
> expression a;
> @@
> - struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> - a = devm_ioremap_resource(&pdev->dev, res);
> + a = devm_platform_ioremap_resource(pdev, index);
>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Nice Cocinelle work!!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C716AC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24892084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDCGIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:08:20 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44399 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfDCGIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:08:19 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E8A8C20008;
        Wed,  3 Apr 2019 06:08:11 +0000 (UTC)
Date:   Wed, 3 Apr 2019 08:08:11 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
Message-ID: <20190403060811.kiqs2oalrgtyqvhw@flea>
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="emfhmtqlgf4nplp2"
Content-Disposition: inline
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--emfhmtqlgf4nplp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 12:01:53PM -0700, Guenter Roeck wrote:
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

For sunxi_wdt

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--emfhmtqlgf4nplp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKRNywAKCRDj7w1vZxhR
xcC5AQDMGPYZqqPoZylFVzhnRPywu3+uyDRgp+bVOSzCVPhQngD+ODZkVk+C1UOh
0qPnCjSWX69QasS5K3P3LVpHtB2jJgs=
=+Kfj
-----END PGP SIGNATURE-----

--emfhmtqlgf4nplp2--

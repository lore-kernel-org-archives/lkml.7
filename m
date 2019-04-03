Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BFC2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i41MgARA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfDCIrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:47:19 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34632 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfDCIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:47:17 -0400
Received: by mail-wr1-f49.google.com with SMTP id p10so20211999wrq.1;
        Wed, 03 Apr 2019 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tFRNnaPfxgsd7kdjbcp3Ak2bhf4Ex75awlMXNJiGe/c=;
        b=i41MgARAGLQthq8ZW76BAjsuhYJPxmH1fkQRBPGDZEBxLdKJoP8gM97vmaO5MRS6jH
         u4lwnSYvR03ONRRWtPjVpc4SULpd0j7Bfn93dEj+uwyZfLKvT/IL1bnYWB0Lb+K2gWiF
         tY0gVV92BGIiYj8E6YXnUMRPBGfgCL5arxZ53Khezx0l/fzH034tVNSDaQ61347T7kq+
         6jAKn3x8o5znaOipbxVZG1ui7j7ENFKDdu7iDUiF5nuF+pm+kNfvLMXzhkqM2V6H0jsD
         I+5Ul+CnUdMahLUIc4SHjGPJRCDEiKP2NJk9TiETAkvaKez4HTxBz3d4xvVCUIxgzSYm
         kVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tFRNnaPfxgsd7kdjbcp3Ak2bhf4Ex75awlMXNJiGe/c=;
        b=qwUhkwnNgQ0KNaTv0eTcGyIriGCH3oZi0wuCqJAMoJhKjS7ldOIcQkwO+amU4kCBsj
         4B/LaXhMB6Br5oV7rDriJJ1cmXwMPDrhgPLz0xZinRD5Wj+uDCRuZriKnw1TUcmyKoDr
         zEwCobsflW34+tYiE7vpxK0fe/RNS13iIdAOlzXkiu0WpbfHX4U6leFWqv3+Xqvfaknj
         z0+6mVYYVXgwJ7owwl4pi3I/tIP709Y4iT4qy26DGaVPh+gKHTZ/uy6bJ7t8nzEXXeW8
         nPNR7H9rm6YW4Swa6N+GtZ72HVH4PEtZy0NAakRrIxN1M2W6KRnNq1DGyX+9t407lcTt
         jnUA==
X-Gm-Message-State: APjAAAUeiIITo1WXX3zmwWsI5MXBCwA82rlUEmr1281Tg5c/hmUh13et
        61Ipi8qbHjVG2yqQSYx34XY=
X-Google-Smtp-Source: APXvYqwS6h31kQVYl4p2j5ppv6uLHcB+v8UtPbZrYDj3R/YAbXgM5o0XUjvjqKppQVN8cYPJDJwHWQ==
X-Received: by 2002:adf:dc88:: with SMTP id r8mr42348832wrj.28.1554281235105;
        Wed, 03 Apr 2019 01:47:15 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id f1sm505707wml.28.2019.04.03.01.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:47:14 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:47:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
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
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
Message-ID: <20190403084713.GD5238@ulmo>
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 12:01:53PM -0700, Guenter Roeck wrote:
[...]
>  drivers/watchdog/tegra_wdt.c      | 4 +---

Acked-by: Thierry Reding <treding@nvidia.com>

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykcxEACgkQ3SOs138+
s6E2RRAAoT043id64ord0O28U5hcmx0fHiMg9zmloWTkycYSG1MQK4kQ0JAEdPet
x1JnF2eTEQocqgHGHtk2k/saFXvtO63qBaNxorWhGBgfPNWyR5UAy1WijFE90eOs
Bu3fldZY+ZZ64Xo2TxtPXc9yXzZ7A7l0dg0l+oV2Wo1MrvBBJtdF0pFPBClz1dXc
c5fx5ow1vRq5zUd5FB7bUmlM1pmYzh6EhKugrreqQd3TRSMm/+j3BfLI+bDDan7y
9FOxbZ3GSObFld3bcLNsSk4efJT4SVfIx7MOhHtKtdG4Vn/diFwU8YfOrdS8Wb6u
IXllxOVVx006HibFXKwnbgS+RWaX22Eg6Av/hd8ZJ0Ud+UbT0Im7W8Zog/k0H3BQ
ecjhGtfGtIMV2PLMEUY2nyh3xJnTj6UvzdVHQz6X+RXfUJDDrTs/oPZAXm2BzWKZ
eETYQxga8pRU/eayMnRE8C84YYFx2+y0lOyTkFw8XKch51MfMIGSZJHfpGNSYAvx
LOS3PwsR9TSozumi5zntfti7wuMvKSUcYk9hLUg4xmGEDPn0zYkCVrXDWroIq4xr
mwrzg/gZ/jCcfH3MTYo+aps9VRVuzqkjfX6eUJU3caHEXla2zrhngQ29xP0anC+Y
ldNlM/VhDj1JQfsbbwXMsGlM1kaHxJBArY/8ZvCLSOZdCJav118=
=vq6o
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61541C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224672073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/n5VgPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfDQIzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:55:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41491 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:55:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so30808361wrq.8;
        Wed, 17 Apr 2019 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MAxWaR0Vw9779BbsAuwcguguveEgfbrg7TtYAp3PlB0=;
        b=W/n5VgPNiBIkWvtGuIjagNvvKYGeS5N7bbl1iBc8oZpwHaQhZITtFIQbiWzOQzChzx
         XBxw7z9nyqDzpb1ansSQjP7xOt6QyNcphgCpQmQaLPbfbXcMHq+UL5yFub51RA6cAx8/
         IBlMWRKeR5JPdcfAl3IdbD2rBHlxW3Do8MPFBQLckv/R0Ka33x19Oxnd1yWmsVqr6DqM
         j3Eyep/isp/aQ+nF3BO1/0InrsCfIhMWZm6iHNi3g5JHPkZEm1bzSSpXFvAW1tMT7Q2E
         uCOCkeGx1rJ0FqAHMGPP92zYLBpJVHEd7mSocb94z5QAihRKqAvBhxnBHOFUUyS0Oca4
         ERWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MAxWaR0Vw9779BbsAuwcguguveEgfbrg7TtYAp3PlB0=;
        b=XheJMYWotAzLCvurNL67ELhzVum2qiOv/F51C8bm/xTyBMqSaTIwLRsYZMPDX3x2RL
         mhoBjUv0oZR3jn6pN8cHXaLJSK0+Go235bnpZwZJtVI0irmoDMHJogKSCRd8yfALvZua
         9KEKoMEloK72fnvdPo5fOilQz/zV8FyuOQjkwer1+1FMTIp+6W0l6dmop3EqaxMH3ovo
         4qQ6Dliops1d0g+Ve7N2kYmU7FBghPKBOoAicbVmDxxsPWay0Dp3VtsRiGjXL7/DFrpk
         K7rmvtdf4LtU52LYthN+qxBLoJ2D4Oi5uu8yyPx7KE9GchGBMe+Ht+YGbjIXHVulHcjj
         OG4Q==
X-Gm-Message-State: APjAAAVa7mwRSg/US/jS2hkSAzJ/NCNijszg29QVymjocm099sfSINJX
        v56NDggRE2WOhO4tmf8I3bwdaFur
X-Google-Smtp-Source: APXvYqyHm8Wd7+UQxyMUfOFte/gpzpNmTz3zsvZJFmODd3pEfG5KjRjeR3LeCVR0kPbOz8aYKE1lLA==
X-Received: by 2002:adf:b612:: with SMTP id f18mr45631436wre.236.1555491296727;
        Wed, 17 Apr 2019 01:54:56 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id 11sm1710384wmk.17.2019.04.17.01.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 01:54:55 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:54:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-imx@nxp.com, jonathanh@nvidia.com, festevam@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        marcel.ziswiler@toradex.com, stefan@agner.ch
Subject: Re: [PATCH v2 2/2] ARM: dts: tegra124-apalis: convert to SPDX
 license tags
Message-ID: <20190417085454.GD26626@ulmo>
References: <20190410071007.13276-1-igor.opaniuk@toradex.com>
 <20190410071007.13276-2-igor.opaniuk@toradex.com>
 <D9979557-09AE-4EEB-8524-437E630E339C@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <D9979557-09AE-4EEB-8524-437E630E339C@ziswiler.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 08:13:51AM +0200, Marcel Ziswiler wrote:
> +// SPDX-License-Identifier: (GPL-2.0 OR X11)
>=20
> I believe the parentheses don't really server any purpose here. With that:
>=20
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> On April 10, 2019 9:10:07 AM GMT+02:00, Igor Opaniuk <igor.opaniuk@torade=
x.com> wrote:
> >Replace boiler plate licenses texts with the SPDX license
> >identifiers in Colibri/Apalis DTS files.
> >
> >Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> >---
> > arch/arm/boot/dts/tegra124-apalis-emc.dtsi | 39 ++-------------------
> > arch/arm/boot/dts/tegra124-apalis-eval.dts | 40 ++--------------------
> > arch/arm/boot/dts/tegra124-apalis.dtsi     | 40 ++--------------------
> > 3 files changed, 6 insertions(+), 113 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> >b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> >index ca2c3a557895..36211f876e33 100644
> >--- a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> >+++ b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
> >@@ -1,42 +1,7 @@
> >+// SPDX-License-Identifier: GPL-2.0 OR MIT

The old text below says that this was supposed to be GPL-2.0 OR X11. Do
you want me to fix that while applying?

Thierry

> > /*
> >- * Copyright 2016 Toradex AG
> >+ * Copyright 2016-2019 Toradex AG
> >  *
> >- * This file is dual-licensed: you can use it either under the terms
> >- * of the GPL or the X11 license, at your option. Note that this dual
> >- * licensing only applies to this file, and not this project as a
> >- * whole.
> >- *
> >- *  a) This file is free software; you can redistribute it and/or
> >- *     modify it under the terms of the GNU General Public License
> >- *     version 2 as published by the Free Software Foundation.
> >- *
> >- *     This file is distributed in the hope that it will be useful
> >- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >- *     GNU General Public License for more details.
> >- *
> >- * Or, alternatively
> >- *
> >- *  b) Permission is hereby granted, free of charge, to any person
> >- *     obtaining a copy of this software and associated documentation
> >- *     files (the "Software"), to deal in the Software without
> >- *     restriction, including without limitation the rights to use
> >- *     copy, modify, merge, publish, distribute, sublicense, and/or
> >- *     sell copies of the Software, and to permit persons to whom the
> >- *     Software is furnished to do so, subject to the following
> >- *     conditions:
> >- *
> >- *     The above copyright notice and this permission notice shall be
> >- *     included in all copies or substantial portions of the Software.
> >- *
> >- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> >- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> >- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >- *     OTHER DEALINGS IN THE SOFTWARE.
> >  */
> >=20
> > / {
> >diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts
> >b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> >index eaee10ef6512..e2388368d635 100644
> >--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
> >+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> >@@ -1,42 +1,6 @@
> >+// SPDX-License-Identifier: (GPL-2.0 OR X11)
> > /*
> >- * Copyright 2016-2018 Toradex AG
> >- *
> >- * This file is dual-licensed: you can use it either under the terms
> >- * of the GPL or the X11 license, at your option. Note that this dual
> >- * licensing only applies to this file, and not this project as a
> >- * whole.
> >- *
> >- *  a) This file is free software; you can redistribute it and/or
> >- *     modify it under the terms of the GNU General Public License
> >- *     version 2 as published by the Free Software Foundation.
> >- *
> >- *     This file is distributed in the hope that it will be useful
> >- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >- *     GNU General Public License for more details.
> >- *
> >- * Or, alternatively
> >- *
> >- *  b) Permission is hereby granted, free of charge, to any person
> >- *     obtaining a copy of this software and associated documentation
> >- *     files (the "Software"), to deal in the Software without
> >- *     restriction, including without limitation the rights to use
> >- *     copy, modify, merge, publish, distribute, sublicense, and/or
> >- *     sell copies of the Software, and to permit persons to whom the
> >- *     Software is furnished to do so, subject to the following
> >- *     conditions:
> >- *
> >- *     The above copyright notice and this permission notice shall be
> >- *     included in all copies or substantial portions of the Software.
> >- *
> >- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> >- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> >- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >- *     OTHER DEALINGS IN THE SOFTWARE.
> >+ * Copyright 2016-2019 Toradex AG
> >  */
> >=20
> > /dts-v1/;
> >diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi
> >b/arch/arm/boot/dts/tegra124-apalis.dtsi
> >index 13c93cd507d8..690f881ea9cb 100644
> >--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
> >+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
> >@@ -1,42 +1,6 @@
> >+// SPDX-License-Identifier: (GPL-2.0 OR X11)
> > /*
> >- * Copyright 2016-2018 Toradex AG
> >- *
> >- * This file is dual-licensed: you can use it either under the terms
> >- * of the GPL or the X11 license, at your option. Note that this dual
> >- * licensing only applies to this file, and not this project as a
> >- * whole.
> >- *
> >- *  a) This file is free software; you can redistribute it and/or
> >- *     modify it under the terms of the GNU General Public License
> >- *     version 2 as published by the Free Software Foundation.
> >- *
> >- *     This file is distributed in the hope that it will be useful
> >- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >- *     GNU General Public License for more details.
> >- *
> >- * Or, alternatively
> >- *
> >- *  b) Permission is hereby granted, free of charge, to any person
> >- *     obtaining a copy of this software and associated documentation
> >- *     files (the "Software"), to deal in the Software without
> >- *     restriction, including without limitation the rights to use
> >- *     copy, modify, merge, publish, distribute, sublicense, and/or
> >- *     sell copies of the Software, and to permit persons to whom the
> >- *     Software is furnished to do so, subject to the following
> >- *     conditions:
> >- *
> >- *     The above copyright notice and this permission notice shall be
> >- *     included in all copies or substantial portions of the Software.
> >- *
> >- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> >- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> >- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >- *     OTHER DEALINGS IN THE SOFTWARE.
> >+ * Copyright 2016-2019 Toradex AG
> >  */
> >=20
> > #include "tegra124.dtsi"
> >--=20
> >2.17.1
>=20
> --=20
> Sent from my Android device with K-9 Mail. Please excuse my brevity.

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly26dwACgkQ3SOs138+
s6Hjaw//VG5dO76fAP66j5JbWJnbPXfN6C9z+QIQpJhh1PhFbdYIaFgCIjog/u30
gnwtJDr3xdNTjTFFcpwbTc+Nkg1S1wvNy6IuUEuJ/sY3JwMSMynD35dIpIjhK7FK
xcJvXU9NQWRW+dPj0rcXgWzBoDqd7Z4V6hegLoI5+MfZa7yBFtnAf7TvCG92Fr46
OOoQb9QhuWUoKSAztR2TVAp11uv/4Ebg/cz3XukWZSiS3vf6a86mOuNIFiIz/wHB
W5xs7nNnQvOYj39ZtoKNVzw3zu7oPzrrtJXehelZNLX5WWZ0ww4zm5RbsM5ZVmwI
ETb5wjTTldM9lJm1ZcH0+udWllb1b8zZOYVCzTQHemy0UKMHphzq8kUqzmJGGx/5
/V8mH7QkhTfeScHvm/8xH4NMs+XEiy8dmxNzM4VHA5UR6kPnjh4P9vRgef7HGgHF
hu6/EOcPlTAJ8y802adopPr20MIMg2Yxi0xSbbqfhPfbmTuypAQP/Izr9vfxUP0A
9lx/IST5liVY4ajuALQhgPNKBakTs6fAe+Bh4NmQ7ow6QyNmN0VquTJrpKagWKmD
/cgTl1jULKz/cQwL/TWd9zRXlClDRfHeaLiZRvQvxPxAp/Ckz/HiyatEh7bsERP1
fUZfCRxxELiD+uVuGXIppM6LUKFTNGjxMDViEGb1Ys5pQyJ/OoU=
=KySC
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--

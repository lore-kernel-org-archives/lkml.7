Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC9C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396F2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfGaSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:19:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46280 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbfGaST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:19:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 520CD80292; Wed, 31 Jul 2019 20:19:12 +0200 (CEST)
Date:   Wed, 31 Jul 2019 20:19:23 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 038/113] serial: mctrl_gpio: Check if GPIO property
 exisits before requesting it
Message-ID: <20190731181923.GB821@amd>
References: <20190729190655.455345569@linuxfoundation.org>
 <20190729190704.872773204@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20190729190704.872773204@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch implements the fix suggested by Mika in his statement above.

> @@ -12,6 +12,7 @@
>  #include <linux/termios.h>
>  #include <linux/serial_core.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
> =20
>  #include "serial_mctrl_gpio.h"
> =20
> @@ -115,6 +116,19 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct de=
vice *dev, unsigned int idx)
> =20
>  	for (i =3D 0; i < UART_GPIO_MAX; i++) {
>  		enum gpiod_flags flags;
> +		char *gpio_str;
> +		bool present;
> +
> +		/* Check if GPIO property exists and continue if not */
> +		gpio_str =3D kasprintf(GFP_KERNEL, "%s-gpios",
> +				     mctrl_gpios_desc[i].name);
> +		if (!gpio_str)
> +			continue;

So if this fails, we'll let the system boot in different configuration
than usual. I guess GFP_KERNEL allocation failures are really rare,
but would it be worth a message? Or maybe buffer on the stack so we
don't do allocations in a loop, and so that allocation can't fail?

Thanks,
								Pavel

> +		present =3D device_property_present(dev, gpio_str);
> +		kfree(gpio_str);
> +		if (!present)
> +			continue;
> =20
>  		if (mctrl_gpios_desc[i].dir_out)
>  			flags =3D GPIOD_OUT_LOW;

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1B26sACgkQMOfwapXb+vLWFgCcCNHawpwrqsLf+elAJ+kA2obE
/5gAn0iAV/T/H4ZF/gX+eIC1/2NLLYiE
=nyr/
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

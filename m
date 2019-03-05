Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADDB2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCEKjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:39:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:48752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbfCEKjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:39:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 654B6ACD0;
        Tue,  5 Mar 2019 10:39:44 +0000 (UTC)
Message-ID: <87a8108f573e04d5c2eaaaa23be0f3a58bd45eb1.camel@suse.de>
Subject: Re: [PATCH] Input: raspberrypi-ts: select CONFIG_INPUT_POLLDEV
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Zhu Yi <yi.zhu5@cn.bosch.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Mar 2019 11:39:42 +0100
In-Reply-To: <20190304195845.1096214-1-arnd@arndb.de>
References: <20190304195845.1096214-1-arnd@arndb.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WemAnIj4qWz8ckr1MW2z"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WemAnIj4qWz8ckr1MW2z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-03-04 at 20:57 +0100, Arnd Bergmann wrote:
> When CONFIG_INPUT_POLLDEV is disabled, we get a link error:
>=20
> drivers/input/touchscreen/raspberrypi-ts.o: In function `rpi_ts_probe':
> raspberrypi-ts.c:(.text+0xec): undefined reference to
> `devm_input_allocate_polled_device'
> raspberrypi-ts.c:(.text+0xec): relocation truncated to fit: R_AARCH64_CAL=
L26
> against undefined symbol `devm_input_allocate_polled_device'
> raspberrypi-ts.c:(.text+0x19c): undefined reference to
> `input_register_polled_device'
> raspberrypi-ts.c:(.text+0x19c): relocation truncated to fit: R_AARCH64_CA=
LL26
> against undefined symbol `input_register_polled_device'
>=20
> Select that symbol like we do from the other similar drivers.
>=20
> Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driv=
er")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/input/touchscreen/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> index 7c597a49c265..7a4884ad198b 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -699,6 +699,7 @@ config TOUCHSCREEN_EDT_FT5X06
>  config TOUCHSCREEN_RASPBERRYPI_FW
>  	tristate "Raspberry Pi's firmware base touch screen support"
>  	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=3Dn &&
> COMPILE_TEST)
> +	select INPUT_POLLDEV
>  	help
>  	  Say Y here if you have the official Raspberry Pi 7 inch screen on
>  	  your system.

Thanks!
Looks good to me.

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-WemAnIj4qWz8ckr1MW2z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlx+Ue8ACgkQlfZmHno8
x/59Twf/TLxpOWUqV46ZAxxiS1B7mQB+GB+MVuiQFreCAeHEmm8/nq6emJcSb6TB
INpToHGrCFKAE/PClzcXomD7X+ziKzYPr5hsFiylAuPlMgr/ybeJQ9p2grAJfwx4
rppOupjRECwh6ADtItswvfj934ewVtX18vjcdXZqt2RBUxajmpl4P/9Dw2EdZ18M
LDn+ldiXINJcryqLR4+Gx3eLJ+wJMzR1g+ZBbFnbOnvFeZ2+SLbluJTqcK5WjXPh
EYWqU15bn0DYepISJigF75lsODRdmKIRDYmyrzkERBs1rb+0tuAZLmoR6znzx8vV
uLi7AYhFttJVvaMrs6p0q/exyw7SOg==
=7s70
-----END PGP SIGNATURE-----

--=-WemAnIj4qWz8ckr1MW2z--


Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14EDC28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10F0206E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfFFLom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:44:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48354 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfFFLol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:44:41 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 24ABD80238; Thu,  6 Jun 2019 13:44:30 +0200 (CEST)
Date:   Thu, 6 Jun 2019 13:44:39 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 262/276] media: saa7146: avoid high stack usage with
 clang
Message-ID: <20190606114439.GA27432@amd>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030541.589347419@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20190530030541.589347419@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Two saa7146/hexium files contain a construct that causes a warning
> when built with clang:
>=20
> drivers/media/pci/saa7146/hexium_orion.c:210:12: error: stack frame size =
of 2272 bytes in function 'hexium_probe'
>       [-Werror,-Wframe-larger-than=3D]
> static int hexium_probe(struct saa7146_dev *dev)
>            ^
> drivers/media/pci/saa7146/hexium_gemini.c:257:12: error: stack frame size=
 of 2304 bytes in function 'hexium_attach'
>       [-Werror,-Wframe-larger-than=3D]
> static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_exte=
nsion_data *info)
>            ^
>=20
> This one happens regardless of KASAN, and the problem is that a
> constructor to initialize a dynamically allocated structure leads
> to a copy of that structure on the stack, whereas gcc initializes
> it in place.
>=20
> Link: https://bugs.llvm.org/show_bug.cgi?id=3D40776

> --- a/drivers/media/pci/saa7146/hexium_gemini.c
> +++ b/drivers/media/pci/saa7146/hexium_gemini.c
> @@ -270,9 +270,8 @@ static int hexium_attach(struct saa7146_dev *dev, str=
uct saa7146_pci_extension_d
>  	/* enable i2c-port pins */
>  	saa7146_write(dev, MC1, (MASK_08 | MASK_24 | MASK_10 | MASK_26));
> =20
> -	hexium->i2c_adapter =3D (struct i2c_adapter) {
> -		.name =3D "hexium gemini",
> -	};
> +	strscpy(hexium->i2c_adapter.name, "hexium gemini",
> +		sizeof(hexium->i2c_adapter.name));
>  	saa7146_i2c_adapter_prepare(dev, &hexium->i2c_adapter, SAA7146_I2C_BUS_=
BIT_RATE_480);
>  	if (i2c_add_adapter(&hexium->i2c_adapter) < 0) {
>  		DEB_S("cannot register i2c-device. skipping.\n");

As a sideeffect, this removes zero-initialization from
hexium->i2c_adapter.

Is that intended / correct?

[I tried looked at saa7146_i2c_adapter_prepare(), and that does not
initialize all the fields, either.]

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz4/KcACgkQMOfwapXb+vJG7wCdHGx8wDKp0FUCK2ZhbPtRF8in
mRwAn3tACATCrLateDJTUNcqDmzymziv
=SRoZ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

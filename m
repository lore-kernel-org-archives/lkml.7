Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A103EC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835BF20714
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUKRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:17:53 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:38616 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfKUKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:17:52 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CA4F71C1B52; Thu, 21 Nov 2019 11:17:50 +0100 (CET)
Date:   Thu, 21 Nov 2019 11:17:50 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 070/422] pinctrl: ingenic: Probe driver at
 subsys_initcall
Message-ID: <20191121101750.GB26882@amd>
References: <20191119051400.261610025@linuxfoundation.org>
 <20191119051404.162474836@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20191119051404.162474836@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-11-19 06:14:27, Greg Kroah-Hartman wrote:
> From: Paul Cercueil <paul@crapouillou.net>
>=20
> [ Upstream commit 556a36a71ed80e17ade49225b58513ea3c9e4558 ]
>=20
> Using postcore_initcall() makes the driver try to initialize way too
> early.

Does it fix concrete bug / would you say it is suitable for -stable?

> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -847,4 +847,4 @@ static int __init ingenic_pinctrl_drv_register(void)
>  {
>  	return platform_driver_register(&ingenic_pinctrl_driver);
>  }
> -postcore_initcall(ingenic_pinctrl_drv_register);
> +subsys_initcall(ingenic_pinctrl_drv_register);

There are other pinctrl drivers initialized very early, do they need
fixing, too?

Best regards,
								Pavel

pavel@amd:~/cip/k$ grep _initcall drivers/pinctrl/pinctrl-*.c
drivers/pinctrl/pinctrl-artpec6.c:arch_initcall(artpec6_pmx_init);
drivers/pinctrl/pinctrl-at91.c:arch_initcall(at91_pinctrl_init);
drivers/pinctrl/pinctrl-coh901.c:arch_initcall(u300_gpio_init);
drivers/pinctrl/pinctrl-falcon.c:core_initcall_sync(pinctrl_falcon_init);
drivers/pinctrl/pinctrl-gemini.c:arch_initcall(gemini_pmx_init);
drivers/pinctrl/pinctrl-ingenic.c:postcore_initcall(ingenic_pinctrl_drv_reg=
ister);
drivers/pinctrl/pinctrl-mcp23s08.c:subsys_initcall(mcp23s08_init);
drivers/pinctrl/pinctrl-oxnas.c:arch_initcall(oxnas_gpio_register);
drivers/pinctrl/pinctrl-oxnas.c:arch_initcall(oxnas_pinctrl_register);
drivers/pinctrl/pinctrl-pic32.c:arch_initcall(pic32_gpio_register);
drivers/pinctrl/pinctrl-pic32.c:arch_initcall(pic32_pinctrl_register);
drivers/pinctrl/pinctrl-pistachio.c:arch_initcall(pistachio_pinctrl_registe=
r);
drivers/pinctrl/pinctrl-rockchip.c:postcore_initcall(rockchip_pinctrl_drv_r=
egister);
drivers/pinctrl/pinctrl-rza1.c:core_initcall(rza1_pinctrl_init);
drivers/pinctrl/pinctrl-st.c:arch_initcall(st_pctl_init);
drivers/pinctrl/pinctrl-sx150x.c:subsys_initcall(sx150x_init);
drivers/pinctrl/pinctrl-u300.c:arch_initcall(u300_pmx_init);
drivers/pinctrl/pinctrl-xway.c:core_initcall_sync(pinmux_xway_init);
drivers/pinctrl/pinctrl-zynq.c:arch_initcall(zynq_pinctrl_init);


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3WZE0ACgkQMOfwapXb+vL5mACbBj3tNHrHKrlOMv9UzJAyBrY9
qZ0Anjx91B7Ocm4dgdbKAStYIEJkDsdr
=NoOf
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

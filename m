Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474F0ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A01C218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfJHMUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:20:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40190 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:20:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C2B588039E; Tue,  8 Oct 2019 14:19:46 +0200 (CEST)
Date:   Tue, 8 Oct 2019 14:20:01 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 018/106] clk: actions: Dont reference clk_init_data
 after registration
Message-ID: <20191008122001.GD608@amd>
References: <20191006171124.641144086@linuxfoundation.org>
 <20191006171132.803572044@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <20191006171132.803572044@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-10-06 19:20:24, Greg Kroah-Hartman wrote:
> From: Stephen Boyd <sboyd@kernel.org>
>=20
> [ Upstream commit cf9ec1fc6d7cceb73e7f1efd079d2eae173fdf57 ]
>=20
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.

18,19,20,21: I see the patches make sense for mainline, but why were
they selected for stable?

								Pavel


> +++ b/drivers/clk/actions/owl-common.c
> @@ -67,16 +67,17 @@ int owl_clk_probe(struct device *dev, struct clk_hw_o=
necell_data *hw_clks)
>  	struct clk_hw *hw;
> =20
>  	for (i =3D 0; i < hw_clks->num; i++) {
> +		const char *name;
> =20
>  		hw =3D hw_clks->hws[i];
> -
>  		if (IS_ERR_OR_NULL(hw))
>  			continue;
> =20
> +		name =3D hw->init->name;
>  		ret =3D devm_clk_hw_register(dev, hw);
>  		if (ret) {
>  			dev_err(dev, "Couldn't register clock %d - %s\n",
> -				i, hw->init->name);
> +				i, name);
>  			return ret;
>  		}
>  	}

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2cfvEACgkQMOfwapXb+vJyuQCgk/YWyTypT/1mZP1qUfsMPV92
ZGsAoLJ8l/niXr2y2E0biDeag/lEu9M+
=31KL
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--

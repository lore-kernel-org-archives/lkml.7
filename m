Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C447C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79832251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfKTMbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:31:17 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:59044 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfKTMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:31:16 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EEDC81C1A4E; Wed, 20 Nov 2019 13:31:14 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:31:13 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 352/422] slimbus: ngd: register ngd driver only once.
Message-ID: <20191120123113.GD4495@amd>
References: <20191119051400.261610025@linuxfoundation.org>
 <20191119051421.826714842@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <20191119051421.826714842@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-11-19 06:19:09, Greg Kroah-Hartman wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> [ Upstream commit 1830dad34c070161fda2ff1db77b39ffa78aa380 ]
>=20
> Move ngd platform driver out of loop so that it registers only once.

AFAICT driver_register is immediately followed by "return", so it was
already registered only once before you patched it.

I don't think this should be in stable.

Best regards,
								Pavel

> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1346,7 +1346,6 @@ static int of_qcom_slim_ngd_register(struct device =
*parent,
>  		ngd->base =3D ctrl->base + ngd->id * data->offset +
>  					(ngd->id - 1) * data->size;
>  		ctrl->ngd =3D ngd;
> -		platform_driver_register(&qcom_slim_ngd_driver);
> =20
>  		return 0;
>  	}
> @@ -1445,6 +1444,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform=
_device *pdev)
>  	init_completion(&ctrl->reconf);
>  	init_completion(&ctrl->qmi.qmi_comp);
> =20
> +	platform_driver_register(&qcom_slim_ngd_driver);
>  	return of_qcom_slim_ngd_register(dev, ctrl);
>  }
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3VMhEACgkQMOfwapXb+vKdTACdHnh4BoDWn+9U1B2RAiAFdS29
SVoAn3l20Braw6MSlLwvz96UOc0h5lNc
=5ihl
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--

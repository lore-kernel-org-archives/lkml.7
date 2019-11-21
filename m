Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45958C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD4020872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUKfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:35:07 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40252 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:35:06 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D8DEA1C1B56; Thu, 21 Nov 2019 11:35:04 +0100 (CET)
Date:   Thu, 21 Nov 2019 11:35:04 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mitch Williams <mitch.a.williams@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 079/422] i40e: use correct length for strncpy
Message-ID: <20191121103504.GC26882@amd>
References: <20191119051400.261610025@linuxfoundation.org>
 <20191119051404.622986351@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline
In-Reply-To: <20191119051404.622986351@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Mitch Williams <mitch.a.williams@intel.com>
>=20
> [ Upstream commit 7eb74ff891b4e94b8bac48f648a21e4b94ddee64 ]
>=20
> Caught by GCC 8. When we provide a length for strncpy, we should not
> include the terminating null. So we must tell it one less than the size
> of the destination buffer.

> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -694,7 +694,8 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
>  	if (!IS_ERR_OR_NULL(pf->ptp_clock))
>  		return 0;
> =20
> -	strncpy(pf->ptp_caps.name, i40e_driver_name, sizeof(pf->ptp_caps.name));
> +	strncpy(pf->ptp_caps.name, i40e_driver_name,
> +		sizeof(pf->ptp_caps.name) - 1);
>  	pf->ptp_caps.owner =3D THIS_MODULE;
>  	pf->ptp_caps.max_adj =3D 999999999;
>  	pf->ptp_caps.n_ext_ts =3D 0;

So... pf is allocated with kzalloc, which will provide the null
termination... so the code is okay.

On the other hand, the =3D 0 below is unneeded by the same logic, so
this is a bit confusing.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3WaFcACgkQMOfwapXb+vJJHACfRuY88Hc7nM5FRo+hzyQlowfF
DrQAoLdm0t9gzcVpQk4tJRuS1vLYgHbO
=ZNgA
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--

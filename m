Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253EC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1168A20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFZH4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:56:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54846 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZH4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:56:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3F43180761; Wed, 26 Jun 2019 09:56:09 +0200 (CEST)
Date:   Wed, 26 Jun 2019 09:56:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 55/90] drm/arm/mali-dp: Add a loop around the second
 set CVAL and try 5 times
Message-ID: <20190626075619.GB32248@amd>
References: <20190624092313.788773607@linuxfoundation.org>
 <20190624092317.745033085@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20190624092317.745033085@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon 2019-06-24 17:56:45, Greg Kroah-Hartman wrote:
> [ Upstream commit 6a88e0c14813d00f8520d0e16cd4136c6cf8b4d4 ]
>=20
> This patch trying to fix monitor freeze issue caused by drm error
> 'flip_done timed out' on LS1028A platform. this set try is make a loop
> around the second setting CVAL and try like 5 times before giveing up.


> @@ -204,8 +205,18 @@ static void malidp_atomic_commit_hw_done(struct drm_=
atomic_state *state)
>  			drm_crtc_vblank_get(&malidp->crtc);
> =20
>  		/* only set config_valid if the CRTC is enabled */
> -		if (malidp_set_and_wait_config_valid(drm) < 0)
> +		if (malidp_set_and_wait_config_valid(drm) < 0) {
> +			/*
> +			 * make a loop around the second CVAL setting and
> +			 * try 5 times before giving up.
> +			 */
> +			while (loop--) {
> +				if (!malidp_set_and_wait_config_valid(drm))
> +					break;
> +			}
>  			DRM_DEBUG_DRIVER("timed out waiting for updated configuration\n");
> +		}
> +

We'll still get the debug message even if
malidp_set_and_wait_config_valid() suceeded. That does not sound
right.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0TJSMACgkQMOfwapXb+vKtAgCeNGi0nFBLE7uq6SZwhkH941Op
Fj0AoL5ZjsmX3Egg89O5I9S77t+0Ye5Z
=xD1u
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

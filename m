Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3333C48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831AA2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfFYVvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:51:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35172 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFYVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:51:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E749580792; Tue, 25 Jun 2019 23:51:25 +0200 (CEST)
Date:   Tue, 25 Jun 2019 23:51:36 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 4.19 84/90] cfg80211: fix memory leak of wiphy device name
Message-ID: <20190625215135.GA32248@amd>
References: <20190624092313.788773607@linuxfoundation.org>
 <20190624092319.410368076@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20190624092319.410368076@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Eric Biggers <ebiggers@google.com>
>=20
> commit 4f488fbca2a86cc7714a128952eead92cac279ab upstream.
>=20
> In wiphy_new_nm(), if an error occurs after dev_set_name() and
> device_initialize() have already been called, it's necessary to call
> put_device() (via wiphy_free()) to avoid a memory leak.
=2E...
> --- a/net/wireless/core.c
> +++ b/net/wireless/core.c
> @@ -498,7 +498,7 @@ use_default_name:
>  				   &rdev->rfkill_ops, rdev);
> =20
>  	if (!rdev->rfkill) {
> -		kfree(rdev);
> +		wiphy_free(&rdev->wiphy);
>  		return NULL;
>  	}

Is kfree(rdev) still neccessary?
drivers/net/wireless/marvell/libertas/cfg.c seems to suggest so.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0Sl2cACgkQMOfwapXb+vLhTwCglgF6Ac1EPb3f4Ml0x9RvA0e/
TwcAn35frZye+nut7S+KbBU6lPQZWLqb
=WN88
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

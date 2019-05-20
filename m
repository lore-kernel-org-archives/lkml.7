Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98EFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7C82177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfETVAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:00:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40629 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfETVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:00:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1167980472; Mon, 20 May 2019 23:00:03 +0200 (CEST)
Date:   Mon, 20 May 2019 23:00:12 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Pavel Machek <pavel@denx.de>,
        stable@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        davem@davemloft.net
Subject: Re: net: atm: Spectre v1 fix introduced bug in bcb964012d1b in
 -stable
Message-ID: <20190520210012.GA18021@amd>
References: <20190520124014.GA5205@amd>
 <20190520140007.GA6397@kroah.com>
 <101e123e-9dfa-7c98-b182-e4ef277560f9@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <101e123e-9dfa-7c98-b182-e4ef277560f9@embeddedor.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-05-20 09:26:45, Gustavo A. R. Silva wrote:
>=20
>=20
> On 5/20/19 9:00 AM, Greg KH wrote:
> > On Mon, May 20, 2019 at 02:40:14PM +0200, Pavel Machek wrote:
> >>
> >> In lecd_attach, if arg is < 0, it was treated as 0. Spectre v1 fix
> >> changed that. Bug does not exist in mainline AFAICT.
> >>
> >> Signed-off-by: Pavel Machek <pavel@denx.de>
> >> # for 4.19.y
> >>
> >> diff --git a/net/atm/lec.c b/net/atm/lec.c
> >> index ad4f829193f0..ed279cd912f4 100644
> >> --- a/net/atm/lec.c
> >> +++ b/net/atm/lec.c
> >> @@ -731,7 +731,7 @@ static int lecd_attach(struct atm_vcc *vcc, int ar=
g)
> >>  		i =3D arg;
> >>  	if (arg >=3D MAX_LEC_ITF)
> >>  		return -EINVAL;
> >> -	i =3D array_index_nospec(arg, MAX_LEC_ITF);
> >> +	i =3D array_index_nospec(i, MAX_LEC_ITF);
> >>  	if (!dev_lec[i]) {
> >>  		int size;
> >> =20
> >=20
> > Why is this only for 4.19.y?  What is different in Linus's tree that
> > makes this not needed there?
> >=20
>=20
> The only difference is this clean up:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dfdd1a8103a6df50bdeacd8bb04c3f6976cb9ae41
>=20
> As Dan says, the code works fine, but the *i* value wasn't being used
> anymore, so that piece of code was a bit confusing.

Yep, you are right, code managed to confused me: array_index_nospec
really returns 0 if it is out of bounds,

(typeof(_i)) (_i & _mask);

because _mask is always 0 or ~0.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzjFVsACgkQMOfwapXb+vIOdACdFJ1200MBtPQjoH/vzXDK2uDA
uIMAn0Fu7hzFkA9vMdpWxvRqEjO0FusR
=nUkY
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

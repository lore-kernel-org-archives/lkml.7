Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7765C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3020815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392559AbfETQPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:15:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60409 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbfETQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:15:45 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AA3638030A; Mon, 20 May 2019 18:15:33 +0200 (CEST)
Date:   Mon, 20 May 2019 18:15:42 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, stable@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        gustavo@embeddedor.com, davem@davemloft.net
Subject: Re: net: atm: Spectre v1 fix introduced bug in bcb964012d1b in
 -stable
Message-ID: <20190520161541.GA25789@amd>
References: <20190520124014.GA5205@amd>
 <20190520140007.GA6397@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20190520140007.GA6397@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-05-20 16:00:07, Greg KH wrote:
> On Mon, May 20, 2019 at 02:40:14PM +0200, Pavel Machek wrote:
> >=20
> > In lecd_attach, if arg is < 0, it was treated as 0. Spectre v1 fix
> > changed that. Bug does not exist in mainline AFAICT.
> >=20
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > # for 4.19.y
> >=20
> > diff --git a/net/atm/lec.c b/net/atm/lec.c
> > index ad4f829193f0..ed279cd912f4 100644
> > --- a/net/atm/lec.c
> > +++ b/net/atm/lec.c
> > @@ -731,7 +731,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
> >  		i =3D arg;
> >  	if (arg >=3D MAX_LEC_ITF)
> >  		return -EINVAL;
> > -	i =3D array_index_nospec(arg, MAX_LEC_ITF);
> > +	i =3D array_index_nospec(i, MAX_LEC_ITF);
> >  	if (!dev_lec[i]) {
> >  		int size;
> > =20
>=20
> Why is this only for 4.19.y?  What is different in Linus's tree that
> makes this not needed there?

Mainline sanitizes "arg", 4.19 copies "arg" into "i" then sanitizes
it. Take a look, it is local to the function.
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzi0q0ACgkQMOfwapXb+vKZVwCffrLAL1fsKniYetB78IRoEws8
6GsAoKDwmPs6toXPFZOsagRpdw5x9UqY
=Bci+
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

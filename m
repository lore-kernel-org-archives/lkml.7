Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C54C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942F620643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKROdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:33:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:57906 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKROdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:33:55 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 82E901C17F7; Mon, 18 Nov 2019 15:33:53 +0100 (CET)
Date:   Mon, 18 Nov 2019 15:33:52 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4.19 062/125] ALSA: usb-audio: Fix possible NULL
 dereference at create_yamaha_midi_quirk()
Message-ID: <20191118143352.GA22736@duo.ucw.cz>
References: <20191111181438.945353076@linuxfoundation.org>
 <20191111181448.565879068@linuxfoundation.org>
 <20191113101954.GA32553@amd>
 <s5hmud0njx7.wl-tiwai@suse.de>
 <s5hlfsknjuq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <s5hlfsknjuq.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Clearly code wants to allow at most one of them to be NULL.
> > >=20
> > > > -	if (!snd_usb_validate_midi_desc(injd) ||
> > > > -	    !snd_usb_validate_midi_desc(outjd))
> > > > +	if (!(injd && snd_usb_validate_midi_desc(injd)) ||
> > > > +	    !(outjd && snd_usb_validate_midi_desc(outjd)))
> > > >  		return -ENODEV;
> > >=20
> > > Yet it will return here if it is. Correct check would be
> > >=20
> > > +     if (!(!injd || snd_usb_validate_midi_desc(injd)) ||
> > > +         !(!outjd || snd_usb_validate_midi_desc(outjd)))
> > >=20
> > > AFAICT.
> >=20
> > Erm, right, but a better representation is:
> >=20
> > 	if ((injd && !snd_usb_validate_midi_desc(injd)) ||
> > 	    (outjd && !snd_usb_validate_midi_desc(injd)))
>=20
> Of course, another typo:
>=20
>  	if ((injd && !snd_usb_validate_midi_desc(injd)) ||
>  	    (outjd && !snd_usb_validate_midi_desc(outjd)))

Agreed, that is better. I was focusing on boolean algebra too much.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXdKr0AAKCRAw5/Bqldv6
8gDNAJ4kJ+tyf4ZdegDGEovZiMQyBRmp/gCZAXSedY7aqWTdApLn62hibFLQeh8=
=9w70
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

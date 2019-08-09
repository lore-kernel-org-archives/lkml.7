Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92ACC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348A208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436796AbfHIPlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:41:06 -0400
Received: from sauhun.de ([88.99.104.3]:39226 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:41:06 -0400
Received: from localhost (p54B333D4.dip0.t-ipconnect.de [84.179.51.212])
        by pokefinder.org (Postfix) with ESMTPSA id D59B82C3014;
        Fri,  9 Aug 2019 17:41:03 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:41:03 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] i2c: replace i2c_new_secondary_device with an ERR_PTR
 variant
Message-ID: <20190809154103.GC5099@ninjato>
References: <20190722172600.3452-1-wsa+renesas@sang-engineering.com>
 <9b71c556-bd70-4d29-dba5-fbeaefb5f3b4@ideasonboard.com>
 <20190808155709.GA1316@ninjato>
 <20190808160434.GT6055@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20190808160434.GT6055@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

> > > > +		if (IS_ERR(state->i2c_clients[i])) {
> > > > +			err =3D PTR_ERR(state->i2c_clients[i]);
> > > >  			v4l2_err(sd, "failed to create i2c client %u\n", i);
> > > >  			goto err_i2c;
>=20
> This will call adv76xx_unregister_clients(), which will try to
> i2c_unregister_device() all non-NULL i2c_clients entries. You need to

Uh, right! Sorry for missing this :(

> either set the entry to NULL here, or update
> adv76xx_unregister_clients() to skip IS_ERR() entries. My preference
> would be to store the return value of adv76xx_dummy_client() in a local
> variable here, and set state->i2c_clients[i] after the error check.

I implemented your preference and simplified
adv76xx_unregister_clients() because i2c_unregister_device is NULL
pointer aware. New patch coming in a minute.

Thanks for the review,

   Wolfram


--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1NlAsACgkQFA3kzBSg
KbYrtw//eax3sE64XT5D8MkAUjtfesOD/GYUTnTU9ceRn7IEMMJBWCSuw24W6t5i
tESvfnVngDidODNAHxiAxTLt1fIKkjEPcwE3WVviODWS0vx2nqCidralMM1VsX1y
4qZB6Ux1ESqmQe8DPFobbu2wCxXnPvqPz11BQyXb4DIlCVVyT5aQXSAtTc9+B8MU
lZHU9yDBIkVneB6yIVp0H3nxxnXOsstFIQEHUbbIkMklgegyaqFWpzNLYSOtR1OZ
RGBo9TrmK2abSXSIA3j2+TGhdO8EXrAtchoYa/PZMeR9npMCrdlraa7x8vXBMBji
fTxZ2NuMbzPi5MWMvSxp6MILBK3MdO9Ph56VZs/RYAqDqkfvfvAbo8htSHglwxcY
Qk2VxXKqUYs/vTOMwz4Zw45yR0ub1XGix+uxxmxq5P4rKRP7neHI5dq8cxMb5MfF
YWBYdxzT3zbY2iMrx1QBRzgZZSPaR1aUuolkeo8qAyiyNz4yBG6A7gZqILGnx4Xq
BEk69WTMCepDKrLiWB2m3G8m49e7StEaBF2D0F+RvV9jPu6CJ6p6tYGNT/Tqcop4
t8RDnxY5nSpxz3VdWTLsKLvPUcMSKltb4yoTnj82Rpx/mc3sl0k2tldYsdk0/4rK
op46MBBe0WNEEkbOEgyycC/x3iT/YOX15X9wTdYqM5idUUEdQ/Q=
=Tjl7
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

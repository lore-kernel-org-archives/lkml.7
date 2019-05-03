Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D62C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4CB206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfECIcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:32:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50528 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:32:15 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ED0A480376; Fri,  3 May 2019 10:32:03 +0200 (CEST)
Date:   Fri, 3 May 2019 10:32:14 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kangjie Lu <kjlu@umn.edu>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: Re: [PATCH 4.19 09/72] net: ieee802154: fix a potential NULL pointer
 dereference
Message-ID: <20190503083213.GB5834@amd>
References: <20190502143333.437607839@linuxfoundation.org>
 <20190502143334.240377603@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20190502143334.240377603@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-02 17:20:31, Greg Kroah-Hartman wrote:
> [ Upstream commit 2795e8c251614ac0784c9d41008551109f665716 ]
>=20
> In case alloc_ordered_workqueue fails, the fix releases
> sources and returns -ENOMEM to avoid NULL pointer dereference.
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>

> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/ad=
f7242.c
> index cd1d8faccca5..cd6b95e673a5 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
>  	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
>  	lp->wqueue =3D alloc_ordered_workqueue(dev_name(&spi->dev),
>  					     WQ_MEM_RECLAIM);
> +	if (unlikely(!lp->wqueue)) {
> +		ret =3D -ENOMEM;
> +		goto err_hw_init;
> +	}
>

This does ieee802154_free_hw(lp->hw) before adf7242_hw_init(). I don't
think that's correct.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzL/I0ACgkQMOfwapXb+vJjvQCfZgzVG4aw7F9lyttv5J6laO/3
diUAoIk2C2O662Re/lTiqoMkWvxog/Kn
=pTKU
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

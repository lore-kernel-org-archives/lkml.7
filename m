Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B881BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946BB2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMH4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:56:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfLMH4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:56:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 278DFAC4D;
        Fri, 13 Dec 2019 07:56:17 +0000 (UTC)
Message-ID: <8b5f4ed5fd341d279a25e4ad94b751c61cd3a4de.camel@suse.de>
Subject: Re: [PATCH v3] bluetooth: hci_bcm: enable IRQ capability from node
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     guillaume La Roque <glaroque@baylibre.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, khilman@baylibre.com,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Fri, 13 Dec 2019 08:56:16 +0100
In-Reply-To: <3f4aaa42-59fb-b7d2-0e5d-d799d90cab0a@baylibre.com>
References: <20191211094923.20220-1-glaroque@baylibre.com>
         <cf77eec5df92b1845f0bf7cc8eb53edd4af9e1bf.camel@suse.de>
         <0CF02341-CF69-4680-B61F-DC5C0702F1A2@holtmann.org>
         <3f4aaa42-59fb-b7d2-0e5d-d799d90cab0a@baylibre.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2Fr8xhQBje9kaHYBFIhM"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Fr8xhQBje9kaHYBFIhM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bc=
m.c
> > > > index f8f5c593a05c..9f52d57c56de 100644
> > > > --- a/drivers/bluetooth/hci_bcm.c
> > > > +++ b/drivers/bluetooth/hci_bcm.c
> > > > @@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_dev=
ice
> > > > *serdev)
> > > > {
> > > > 	struct bcm_device *bcmdev;
> > > > 	const struct bcm_device_data *data;
> > > > +	struct platform_device *pdev;
> > > > 	int err;
> > > >=20
> > > > 	bcmdev =3D devm_kzalloc(&serdev->dev, sizeof(*bcmdev),
> > > > GFP_KERNEL);
> > > > @@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_dev=
ice
> > > > *serdev)
> > > > #endif
> > > > 	bcmdev->serdev_hu.serdev =3D serdev;
> > > > 	serdev_device_set_drvdata(serdev, bcmdev);
> > > > +	pdev =3D to_platform_device(bcmdev->dev);
> > > Ultimately bcmdev->dev here comes from a serdev device not a platform
> > > device,
> > > right?
> > I was afraid of this, but then nobody spoke up. Can we fix this or shou=
ld I
> > just revert the patch?
>=20
> sorry about that, i will provide a fix as soon as possible but i have no =
pi4
> to validate on it so i will add no in cc nicolas and if you can give me a
> feedback i will appreciate .

Thanks, I will :)

Regards,
Nicolas


--=-2Fr8xhQBje9kaHYBFIhM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3zRCAACgkQlfZmHno8
x/4O5wf/S3T5ZtghqcIHN9ZUNBqo4r2BMbKhz5gQKmqgnQYQzvnkZ6j4o267rTD2
JVT5KeL91NHcqlw/SOFG4x7JbChz8uX6JjDQ1djXG4K4vOi1KssJKMKb8x3RmCWJ
QUOzLwPSSlT9ZkTRp/b0rOyeLDVrT3ZwCcU4U0QVl9F/M5D53i0oDc9/beEZuNWG
4yqMsSN5uGkI0rjw/iv/Tg8ZI+kmCNID7cbi0WzkYtjDvQmrNDBnaZqp/e7vKGRn
lM4PMkzGCEAd8EO9PJ4Ur2NA7unX08m0bFUFhV7/srAQAmf8kzwA5TonU5J+mKMS
patEbFtwpznGBM8QFnXji1deXIqqtQ==
=efmf
-----END PGP SIGNATURE-----

--=-2Fr8xhQBje9kaHYBFIhM--


Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D7CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEFA214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfKDRTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:19:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:37642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbfKDRTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:19:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55381B190;
        Mon,  4 Nov 2019 17:19:48 +0000 (UTC)
Message-ID: <34bd65923697528b5ee540ef30b31542cfc5ba8e.camel@suse.de>
Subject: Re: [PATCH 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 04 Nov 2019 18:19:45 +0100
In-Reply-To: <588d05b4-e66c-4aa0-436e-12d244a6efd8@gmx.net>
References: <20191104135412.32118-1-nsaenzjulienne@suse.de>
         <20191104135412.32118-2-nsaenzjulienne@suse.de>
         <588d05b4-e66c-4aa0-436e-12d244a6efd8@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ILh2Kn6IzlMFXja+veOK"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ILh2Kn6IzlMFXja+veOK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-04 at 18:09 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 04.11.19 um 14:54 schrieb Nicolas Saenz Julienne:
> > arm64 places the CMA in ZONE_DMA32, which is not good enough for the
> > Raspberry Pi 4 since it contains peripherals that can only address the
> > first GB of memory. Explicitly place the CMA into that area.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> do you want this in Linux 5.5 via devicetree/fixes? In this case please
> add an fixes tag.

This has to go into v5.5 if the second patch is accepted. That said I can't=
 add
a fixes tag as the code being fixed isn't yet in linus' tree.

Any suggestions? Maybe go through Catalin's tree?

> Otherwise this will be queued for Linux 5.6.
>=20
> > ---
> >  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > index cccc1ccd19be..3c7833e9005a 100644
> > --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> > @@ -19,6 +19,25 @@
> >  		reg =3D <0 0 0>;
> >  	};
> >=20
> > +	reserved-memory {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <1>;
> > +		ranges;
> > +
> > +		/*
> > +		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
> > +		 * that's not good enough for the Raspberry Pi 4 as some
> > +		 * devices can only address the lower 1G of memory (ZONE_DMA).
> > +		 */
> > +		linux,cma {
> > +			compatible =3D "shared-dma-pool";
> > +			size =3D <0x2000000>; /* 32MB */
> > +			alloc-ranges =3D <0x0 0x00000000 0x40000000>;
> > +			reusable;
> > +			linux,cma-default;
> > +		};
> > +	};
> > +
>=20
> i think this is a SoC-specific issue not a board specifc one. Please
> move this to bcm2711.dtsi

Noted, thanks!

Regards,
Nicolas


--=-ILh2Kn6IzlMFXja+veOK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3AXbIACgkQlfZmHno8
x/5bNQf+Pcwr9fITGn9iaLSMaqlCHQzeOM1OgDs4kXXqGotT/PNltTgdxEJIhFIp
5DAU9kQRHwIG/69W9dXmUngZQe7seTMSBvS2ZrSKxgU45h/O/L1dQbWePZrl1PEF
k4eXAWFJhwKQrFxBnT6F2IlCfoY5CrMikuhV+uSBP0UhLiAoWQ1h1fl0qnU57ODL
cFz0GYgNS45rFhQ1GNfb5daGUXxgJyjMwRokrBS7dT+fnC7BqmXGBRwAWT7n+MC1
9wyrMaWXVWpkrVCkKkhXsKjK9MBnqC+FIGIo06F/cttUQr24QOD8Xkcho+OXzKgP
HzfSwcMdLuACsoS8BonBZgS1YIzAOA==
=AtDb
-----END PGP SIGNATURE-----

--=-ILh2Kn6IzlMFXja+veOK--


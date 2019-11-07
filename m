Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69BAC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8A22084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfKGJme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:42:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:36004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfKGJme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:42:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71C67B1B8;
        Thu,  7 Nov 2019 09:42:32 +0000 (UTC)
Message-ID: <b63a382c72bec9e52ea10f9d41aa45c6b1147eba.camel@suse.de>
Subject: Re: [PATCH v2 1/2] ARM: dts: bcm2711: force CMA into first GB of
 memory
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 07 Nov 2019 10:42:30 +0100
In-Reply-To: <09138a9d-40a5-4c5f-0cf4-1cb73579c600@gmx.net>
References: <20191106095945.22933-1-nsaenzjulienne@suse.de>
         <20191106095945.22933-2-nsaenzjulienne@suse.de>
         <09138a9d-40a5-4c5f-0cf4-1cb73579c600@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kpHq0CYDmXDh0eqViyTB"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kpHq0CYDmXDh0eqViyTB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-07 at 07:23 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 06.11.19 um 10:59 schrieb Nicolas Saenz Julienne:
> > arm64 places the CMA in ZONE_DMA32, which is not good enough for the
> > Raspberry Pi 4 since it contains peripherals that can only address the
> > first GB of memory. Explicitly place the CMA into that area.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> >   - Move into bcm2711.dtsi
> >=20
> >  arch/arm/boot/dts/bcm2711.dtsi | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711=
.dtsi
> > index 1f3acd3363ea..6000a01652fa 100644
> > --- a/arch/arm/boot/dts/bcm2711.dtsi
> > +++ b/arch/arm/boot/dts/bcm2711.dtsi
> > @@ -12,6 +12,26 @@
> >=20
> >  	interrupt-parent =3D <&gicv2>;
> >=20
> > +	reserved-memory {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <1>;
> > +		ranges;
> > +
> > +		/*
> > +		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
> > +		 * that's not good enough for the Raspberry Pi 4 as some
>=20
> sorry for the nitpicking but i hope the Raspberry Pi 4 B wont be the
> only user of BCM2711.

No worries :)

It's better that way anyway.

>=20
> So please s/Raspberry Pi 4/BCM2711/
>=20
> Beside that:
>=20
> Acked-by: Stefan Wahren <wahrenst@gmx.net>

Thanks!

>=20
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
> > +
> >  	soc {
> >  		/*
> >  		 * Defined ranges:
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


--=-kpHq0CYDmXDh0eqViyTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3D5wYACgkQlfZmHno8
x/6Z9wf+Ix7scgFz+3M7rFkw5LPO3vRxZIa27azCPt/YhruRqYjIFxhJRtvND+Bj
aA7Lv1P9AayPq9Wzf+9SXpe8kV9075JIwkePxHpSxYRKQO2OxY9PyK79qgi/lEZG
uFX3nwYBQL28v2DF+Sg12VLrtKuZI+azxLxiv936jZKV58RO+gfCHWulheO+MSiL
8chl+ZRp0dUehw2squNSbwtcZnr/IcFLx5vDW+EaJdYwNqq+N07LlSeTqxNsPK9a
RUkOOpOqjv6V8va7RVy4I07aAlRBHrCX34+hvTcZPJkXk3ev5XCGzPZBUPjlklYW
V4IwN6QZQWEaEO0X/W+lryiJzePQ+w==
=1rN1
-----END PGP SIGNATURE-----

--=-kpHq0CYDmXDh0eqViyTB--


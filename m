Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726FECA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531B12080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfKDSxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:53:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:34674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728502AbfKDSxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:53:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 300D5B26B;
        Mon,  4 Nov 2019 18:53:43 +0000 (UTC)
Message-ID: <95359117f4f14f296db1cabc6fa68fbfcf78b2f5.camel@suse.de>
Subject: Re: [PATCH 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 04 Nov 2019 19:53:39 +0100
In-Reply-To: <05f00d57-6151-45df-67ee-b49a18a611c7@gmail.com>
References: <20191104135412.32118-1-nsaenzjulienne@suse.de>
         <20191104135412.32118-2-nsaenzjulienne@suse.de>
         <588d05b4-e66c-4aa0-436e-12d244a6efd8@gmx.net>
         <05f00d57-6151-45df-67ee-b49a18a611c7@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-e3thndAXgfBLu9QjwnR4"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-e3thndAXgfBLu9QjwnR4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-04 at 09:51 -0800, Florian Fainelli wrote:
> On 11/4/19 9:09 AM, Stefan Wahren wrote:
>=20
> [snip]
>=20
> > > +	reserved-memory {
> > > +		#address-cells =3D <2>;
> > > +		#size-cells =3D <1>;
> > > +		ranges;
> > > +
> > > +		/*
> > > +		 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
> > > +		 * that's not good enough for the Raspberry Pi 4 as some
> > > +		 * devices can only address the lower 1G of memory (ZONE_DMA).
> > > +		 */
> > > +		linux,cma {
> > > +			compatible =3D "shared-dma-pool";
> > > +			size =3D <0x2000000>; /* 32MB */
> > > +			alloc-ranges =3D <0x0 0x00000000 0x40000000>;
> > > +			reusable;
> > > +			linux,cma-default;
> > > +		};
> > > +	};
> > > +
> >=20
> > i think this is a SoC-specific issue not a board specifc one. Please
> > move this to bcm2711.dtsi
>=20
> This sounds like a possibly fragile solution if someone changes
> CONFIG_CMA_SIZE_MBYTES to a value greater than 32MB no?

I agree it's not the most flexible solution in the world. It also bypasses =
the
command line interface. But I can't see any alternatives as of today.

Overall, I suggest that we set CMA's size to whatever is needed for a sensi=
ble
desktop use. And let odd users with custom HW modify it trough overlays (wh=
ich
they will most likely be forced to do anyway).

That said I'm open to suggestions.

Regards,
Nicolas


--=-e3thndAXgfBLu9QjwnR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3Ac7QACgkQlfZmHno8
x/7dgQf+KKHvYx6jBZi1K73PiGBWn2BOWGIQhxgKf2zuOoGEIPWIdft+iR+7QqfT
AteKjVlETbdYvyjxZm+k0YI7ngTvy1vC/xoHmz4tyxIKoxM89PjLeEudUI7UtBxT
O5EOdCfEbJ4hFBrHk9u141lq2i+D2BJXKfK9m/jM6SbgGQGlznafVowiEw1A/n9i
V3QPFNEiibV/wUQxsPMZ44KbCb0P+L48N76fmyBmH5uAgQnenTgStw31HCdXxYrN
V7QQa/3QKU2msgZZXT3beRih+dM4mnSdwokKH3RSr11/2/8KGOeVJ022+pMl+Swe
Nan0j4uEsyir/r4g0b0pKXrONC8HAg==
=iJ8o
-----END PGP SIGNATURE-----

--=-e3thndAXgfBLu9QjwnR4--


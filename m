Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2857C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38E02087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfHAQlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:41:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732035AbfHAQlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:41:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E44E3AFA1;
        Thu,  1 Aug 2019 16:41:07 +0000 (UTC)
Message-ID: <4027201b6128b3f2b0ab941dc473ab143da64be2.camel@suse.de>
Subject: Re: [PATCH 5/8] arm64: use ZONE_DMA on DMA addressing limited
 devices
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     phill@raspberryi.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, linux-mm@kvack.org, marc.zyngier@arm.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        eric@anholt.net, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
        mbrugger@suse.com, akpm@linux-foundation.org,
        m.szyprowski@samsung.com, frowand.list@gmail.com, hch@lst.de,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Thu, 01 Aug 2019 18:40:50 +0200
In-Reply-To: <e35dd4a5-281b-d281-59c9-3fc7108eb8be@arm.com>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
         <20190731154752.16557-6-nsaenzjulienne@suse.de>
         <20190731170742.GC17773@arrakis.emea.arm.com>
         <d8b4a7cb9c06824ca88a0602a5bf38b6324b43c0.camel@suse.de>
         <e35dd4a5-281b-d281-59c9-3fc7108eb8be@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qAJVJtco/gH4l0Ax6g8O"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qAJVJtco/gH4l0Ax6g8O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 17:07 +0100, Robin Murphy wrote:
> On 2019-08-01 4:44 pm, Nicolas Saenz Julienne wrote:
> > On Wed, 2019-07-31 at 18:07 +0100, Catalin Marinas wrote:
> > > On Wed, Jul 31, 2019 at 05:47:48PM +0200, Nicolas Saenz Julienne wrot=
e:
> > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > index 1c4ffabbe1cb..f5279ef85756 100644
> > > > --- a/arch/arm64/mm/init.c
> > > > +++ b/arch/arm64/mm/init.c
> > > > @@ -50,6 +50,13 @@
> > > >   s64 memstart_addr __ro_after_init =3D -1;
> > > >   EXPORT_SYMBOL(memstart_addr);
> > > >  =20
> > > > +/*
> > > > + * We might create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA is nee=
ded
> > > > if
> > > > there
> > > > + * are periferals unable to address the first naturally aligned 4G=
B of
> > > > ram.
> > > > + * ZONE_DMA32 will be expanded to cover the rest of that memory. I=
f
> > > > such
> > > > + * limitations doesn't exist only ZONE_DMA32 is created.
> > > > + */
> > >=20
> > > Shouldn't we instead only create ZONE_DMA to cover the whole 32-bit
> > > range and leave ZONE_DMA32 empty? Can__GFP_DMA allocations fall back
> > > onto ZONE_DMA32?
> >=20
> > Hi Catalin, thanks for the review.
> >=20
> > You're right, the GFP_DMA page allocation will fail with a nasty dmesg =
error
> > if
> > ZONE_DMA is configured but empty. Unsurprisingly the opposite situation=
 is
> > fine
> > (GFP_DMA32 with an empty ZONE_DMA32).
>=20
> Was that tested on something other than RPi4 with more than 4GB of RAM?=
=20
> (i.e. with a non-empty ZONE_NORMAL either way)

No, all I did is play around with RPi4's memory size (1 GB vs 4 GB).

I'll see If I can get access to a dts based board with more than 4 GB, If n=
ot
I'll try to fake it. It's not ideal but I can set the limit on 3 GB and hav=
e
the 3 areas created (with and witouth an empty ZONE_DMA32).

On top of that, now that you ask, I realise I neglected all the ACPI based
servers. I have access to some so I'll make sure I test everything on them =
too
for the next series.

Regards,
Nicolas


--=-qAJVJtco/gH4l0Ax6g8O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1DFhIACgkQlfZmHno8
x/5YnAf/aih3gNCdpPnk9CDn+WHuChefMegomFiKPy7KLWGYmB9OrtzlXlYit3VU
z2zffpz7+B+tFBZWLyxyQfJ8sT8uogFFJR+HNsvucEC2z4cDMksEkCgYQRHcv5iq
4CDSPUrd5zuESxZjq3ne7sLGx0G41aVs7o+iKAaUls/WAhq7MbYiq8B/r9HPnS1/
qAxsHlnX0PASFIN3BCnr+1VSy+xbwpFNSNVfqLYtWRQZvI8ww3Epx/AbWcTKy3YC
3YbXITPMlA4Mf+0ROrmU4sf0dj/mdQkC6SYqPjTMqVYyzON4rJ/MvOChQDmEGPs6
WiNr9ZnC1GXA4QfwFXcRrfK85+Y0vw==
=e240
-----END PGP SIGNATURE-----

--=-qAJVJtco/gH4l0Ax6g8O--


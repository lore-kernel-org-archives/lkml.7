Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4807C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E8D2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfHAPov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:44:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:42190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbfHAPov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:44:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 222CDAC9A;
        Thu,  1 Aug 2019 15:44:50 +0000 (UTC)
Message-ID: <d8b4a7cb9c06824ca88a0602a5bf38b6324b43c0.camel@suse.de>
Subject: Re: [PATCH 5/8] arm64: use ZONE_DMA on DMA addressing limited
 devices
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     phill@raspberryi.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        frowand.list@gmail.com, eric@anholt.net, marc.zyngier@arm.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, wahrenst@gmx.net, mbrugger@suse.com,
        akpm@linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
        hch@lst.de, linux-arm-kernel@lists.infradead.org,
        m.szyprowski@samsung.com
Date:   Thu, 01 Aug 2019 17:44:09 +0200
In-Reply-To: <20190731170742.GC17773@arrakis.emea.arm.com>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
         <20190731154752.16557-6-nsaenzjulienne@suse.de>
         <20190731170742.GC17773@arrakis.emea.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Jl/nDcfVAied7u8Yssfo"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jl/nDcfVAied7u8Yssfo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 18:07 +0100, Catalin Marinas wrote:
> On Wed, Jul 31, 2019 at 05:47:48PM +0200, Nicolas Saenz Julienne wrote:
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 1c4ffabbe1cb..f5279ef85756 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -50,6 +50,13 @@
> >  s64 memstart_addr __ro_after_init =3D -1;
> >  EXPORT_SYMBOL(memstart_addr);
> > =20
> > +/*
> > + * We might create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA is needed =
if
> > there
> > + * are periferals unable to address the first naturally aligned 4GB of=
 ram.
> > + * ZONE_DMA32 will be expanded to cover the rest of that memory. If su=
ch
> > + * limitations doesn't exist only ZONE_DMA32 is created.
> > + */
>=20
> Shouldn't we instead only create ZONE_DMA to cover the whole 32-bit
> range and leave ZONE_DMA32 empty? Can__GFP_DMA allocations fall back
> onto ZONE_DMA32?

Hi Catalin, thanks for the review.

You're right, the GFP_DMA page allocation will fail with a nasty dmesg erro=
r if
ZONE_DMA is configured but empty. Unsurprisingly the opposite situation is =
fine
(GFP_DMA32 with an empty ZONE_DMA32).

I switched to the scheme you're suggesting for the next version of the seri=
es.
The comment will be something the likes of this:

/*
 * We create both a ZONE_DMA and ZONE_DMA32. ZONE_DMA's size is decided bas=
ed
 * on whether the SoC's peripherals are able to address the first naturally
 * aligned 4 GB of ram.
 *
 * If limited, ZONE_DMA covers that area and ZONE_DMA32 the rest of that 32=
 bit
 * addressable memory.
 *
 * If not ZONE_DMA is expanded to cover the whole 32 bit addressable memory=
 and
 * ZONE_DMA32 is left empty.
 */

 Regards,
 Nicolas



--=-Jl/nDcfVAied7u8Yssfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1DCMkACgkQlfZmHno8
x/724wgAlBvY4KUvCY6AbQ4IkNYytX+x49CEh/vxpdWWXLjrWRTBCg2SwWhZ4y9G
OjuuZe9BBgQBgnZBR0lC8MlCFN7w4Ce5aByypx2pzGLefZKqc4pesvda/gC8Jmo8
csbQ988GLPt6V35DcX3N81FjYrdsZGCcJ1XrtpUVlx6YfIPLx4ZRc/6OfV3yXXBc
XiD/luxNVqjDtvy7RnR2so9hSWet0hM4Wv5TDwI+xt1RviR4Tpdd+jNqtjxH+LcV
2uruy3yUhTGeNaiyZsPt/Bj1Mlg+Wab940ahUDn3a1KBkd4BkFZIoqfjQxBgLaal
iZB+n9PmIhCkaHygfxOy1H+xVYO/AA==
=Opde
-----END PGP SIGNATURE-----

--=-Jl/nDcfVAied7u8Yssfo--


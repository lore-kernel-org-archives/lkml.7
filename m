Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695CCC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4802A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfGSNI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:08:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfGSNI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:08:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A20CAF8A;
        Fri, 19 Jul 2019 13:08:55 +0000 (UTC)
Message-ID: <58753252bd7964e3b9e9558b633bd325c4a898a1.camel@suse.de>
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, phil@raspberrypi.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, mbrugger@suse.com,
        Jisheng.Zhang@synaptics.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Jul 2019 15:08:52 +0200
In-Reply-To: <13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
         <20190717153135.15507-4-nsaenzjulienne@suse.de>
         <20190718091526.GA25321@lst.de>
         <13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yHJZ8oknJEb7FX+m0jvD"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yHJZ8oknJEb7FX+m0jvD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 13:18 +0200, Nicolas Saenz Julienne wrote:
> On Thu, 2019-07-18 at 11:15 +0200, Christoph Hellwig wrote:
> > On Wed, Jul 17, 2019 at 05:31:34PM +0200, Nicolas Saenz Julienne wrote:
> > > Historically devices with ZONE_DMA32 have been assumed to be able to
> > > address at least the lower 4GB of ram for DMA. This is still the defu=
alt
> > > behavior yet the Raspberry Pi 4 is limited to the first GB of memory.
> > > This has been observed to trigger failures in dma_direct_supported() =
as
> > > the 'min_mask' isn't properly set.
> > >=20
> > > We create 'dma_direct_min_mask' in order for the arch init code to be
> > > able to fine-tune dma direct's 'min_dma' mask.
> >=20
> > Normally we use ZONE_DMA for that case.
>=20
> Fair enough, I didn't think of that possibility.
>=20
> So would the arm64 maintainers be happy with something like this:
>=20
> - ZONE_DMA: Follows standard definition, 16MB in size. ARCH_ZONE_DMA_BITS=
 is
> 	    left as is.
> - ZONE_DMA32: Will honor the most constraining 'dma-ranges'. Which so far=
 for
> 	      most devices is 4G, except for RPi4.
> - ZONE_NORMAL: The rest of the memory.

Never mind this suggestion, I don't think it makes any sense. If anything a=
rm64
seems to fit the ZONE_DMA usage pattern of arm and powerpc: where ZONE_DMA'=
s
size is decided based on ram size and/or board configuration. It was actual=
ly
set-up like this until Christoph's ad67f5a6545f7 ("arm64: replace ZONE_DMA =
with
ZONE_DMA32").

So the easy solution would be to simply revert that commit. On one hand I f=
eel
it would be a step backwards as most 64 bit architectures have been moving =
to
use ZONE_DMA32. On the other, current ZONE_DMA32 usage seems to be heavily
rooted on having a 32 bit DMA mask*, which will no longer be the case on ar=
m64
if we want to support the RPi 4.

So the way I see it and lacking a better solution, the argument is stronger=
 on
moving back arm64 to using ZONE_DMA. Any comments/opinions?

Note that I've been looking at all the DMA/CMA/swiotlb code to see if this
would break anything or change behaviors and couldn't find anything obvious=
. I
also tested the revert on my RPi4 and nothing seems to fail.

* A good example is dma-direct's implementation.


--=-yHJZ8oknJEb7FX+m0jvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0xwOQACgkQlfZmHno8
x/4SeAf+MwPSVWf/ID6jt6VrnWUTSIi5Z+nZtH48wv+4/USMxGds1Kd+TeULaZEf
xYq9ukgZgipmxlQ6AX01EmJvtV3h6RhMaiq0EMckFyh2H1U3LfLJ56hgmlXcef9m
ktws/JY7JeK2ygPKynPRqgY4H1v1dmFlsjSU6szy4QKEEfx2ET1Yukvl8Zs9eSpa
hdhddrM5AG53/SILdrQacParrMb2NXl1r6WRQqmOURLzV274d0ut3bjDPa6pv/Yd
xRekzhU6SIHJ4mmPTxC4fBbtslGmh3+RwCczC9UaefCVJ5lZsGkNfsMocTUfakqO
hv1LXHuOi2kbBY9/aaRmhHBEajVEog==
=bSz/
-----END PGP SIGNATURE-----

--=-yHJZ8oknJEb7FX+m0jvD--


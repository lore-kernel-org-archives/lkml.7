Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F206ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6B520873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfJaQEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:04:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:44768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJaQEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:04:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7552B232;
        Thu, 31 Oct 2019 16:04:35 +0000 (UTC)
Message-ID: <6fd539b82cbbb2ae307a67a76eb4c2ead0bd5d4a.camel@suse.de>
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     f.fainelli@gmail.com, wahrenst@gmx.net, marc.zyngier@arm.com,
        will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mm@kvack.org,
        mbrugger@suse.com, Qian Cai <cai@lca.pw>,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        Robin Murphy <Robin.Murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Date:   Thu, 31 Oct 2019 17:04:34 +0100
In-Reply-To: <20191031155145.GF39590@arrakis.emea.arm.com>
References: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
         <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
         <9208de061fe2b9ee7b74206b3cd52cc116e43ac0.camel@suse.de>
         <AA6D37F1-A1B3-4EC4-8620-007095168BC7@lca.pw>
         <1956a2c8f4911b2a7e2ba3c53506c0f06efb93f8.camel@suse.de>
         <20191031155145.GF39590@arrakis.emea.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-exV1eg95rhXTf/heN52G"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-exV1eg95rhXTf/heN52G
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-31 at 15:51 +0000, Catalin Marinas wrote:
> (sorry, I've been away last week and only now caught up with emails)
>=20
> On Tue, Oct 22, 2019 at 01:23:32PM +0200, Nicolas Saenz Julienne wrote:
> > On Mon, 2019-10-21 at 16:36 -0400, Qian Cai wrote:
> > > I managed to get more information here,
> > >=20
> > > [    0.000000] cma: dma_contiguous_reserve(limit c0000000)
> > > [    0.000000] cma: dma_contiguous_reserve: reserving 64 MiB for glob=
al
> > > area
> > > [    0.000000] cma: cma_declare_contiguous(size 0x0000000004000000, b=
ase
> > > 0x0000000000000000, limit 0x00000000c0000000 alignment 0x000000000000=
0000)
> > > [    0.000000] cma: Failed to reserve 512 MiB
> > >=20
> > > Full dmesg:
> > >=20
> > > https://cailca.github.io/files/dmesg.txt
> >=20
> > OK I got it, reproduced it too.
> >=20
> > Here are the relevant logs:
> >=20
> > 	[    0.000000]   DMA      [mem 0x00000000802f0000-0x00000000bfffffff]
> > 	[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
> > 	[    0.000000]   Normal   [mem 0x0000000100000000-0x00000097fcffffff]
> >=20
> > As you can see ZONE_DMA spans from 0x00000000802f0000-0x00000000bffffff=
f
> > which
> > is slightly smaller than 1GB.
> >=20
> > 	[    0.000000] crashkernel reserved: 0x000000009fe00000 -
> > 0x00000000bfe00000 (512 MB)
> >=20
> > Here crashkernel reserved 512M in ZONE_DMA.
> >=20
> > 	[    0.000000] cma: Failed to reserve 512 MiB
> >=20
> > CMA tried to allocate 512M in ZONE_DMA which fails as there is no enoug=
h
> > space.
> > Makes sense.
> >=20
> > A fix could be moving crashkernel reservations after CMA and then if un=
able
> > to
> > fit in ZONE_DMA try ZONE_DMA32 before bailing out. Maybe it's a little =
over
> > the
> > top, yet although most devices will be fine with ZONE_DMA32, the RPi4 n=
eeds
> > crashkernel to be reserved in ZONE_DMA.
>=20
> Does RPi4 need CMA in ZONE_DMA? If not, I'd rather reserve the CMA from
> ZONE_DMA32.

Yes, CMA is imperatively to be reserved in ZONE_DMA.

> Even if you moved the crash kernel, someone else might complain that
> they had 2GB of CMA and it no longer works.

I have yet to look into it, but I've been told that on x86/x64 they have a
'high' flag to be set alongside with crashkernel that forces the allocation
into ZONE_DMA32. We could mimic this behavior for big servers that don't de=
pend
on ZONE_DMA but need to reserve big chunks of memory.

Regards,
Nicolas


--=-exV1eg95rhXTf/heN52G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl27BhIACgkQlfZmHno8
x/6ytQgAr4/GCUbLvqyD7pRmUlkzRlZj0aJHXFHEsX8ng2CM60HUWp5PPXvp74YZ
gIbWndJ96KHhR79C2lG2TcpWJl4nSAtCEJohIE5vFr5//a2uhWy0PiJbYrWnLTwh
ZJqmJwSdcBXQ8EQ25bakapXsJdF9Ny2IPe+9Hz/LTJEzC+VYXd8yvuQw3dfHLmGw
kgNH0I8mV/fqIxezMhFIOfT5GubP9BNZJL1Kb3iKr1eh9pNpGEDM02xJI02vIElm
GzA8KlEBcS5fRvtvInU5vKdBHQy1uVlYHgT5lKArcYCI7wFCkD+sP7NBw1ngHkmT
BNmYX1jtM3jEaI2otTOL07aUoQlZsA==
=AKNQ
-----END PGP SIGNATURE-----

--=-exV1eg95rhXTf/heN52G--


Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9931CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46A220640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfJUOf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:35:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUOf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:35:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98FCAAE65;
        Mon, 21 Oct 2019 14:35:27 +0000 (UTC)
Message-ID: <78caa5bcfc0d59e8ec5d6b7060df76896d25248b.camel@suse.de>
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     f.fainelli@gmail.com, mbrugger@suse.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rob Herring <robh+dt@kernel.org>, wahrenst@gmx.net,
        m.szyprowski@samsung.com, phill@raspberrypi.org, will@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Mon, 21 Oct 2019 16:34:58 +0200
In-Reply-To: <3956E54B-6C7A-4C47-B9B6-75F556EFD3F5@lca.pw>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
         <20190911182546.17094-4-nsaenzjulienne@suse.de>
         <3956E54B-6C7A-4C47-B9B6-75F556EFD3F5@lca.pw>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-h82UrL74CNp2lRPKbz+/"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h82UrL74CNp2lRPKbz+/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-21 at 10:15 -0400, Qian Cai wrote:
> > On Sep 11, 2019, at 2:25 PM, Nicolas Saenz Julienne <nsaenzjulienne@sus=
e.de>
> > wrote:
> >=20
> > So far all arm64 devices have supported 32 bit DMA masks for their
> > peripherals. This is not true anymore for the Raspberry Pi 4 as most of
> > it's peripherals can only address the first GB of memory on a total of
> > up to 4 GB.
> >=20
> > This goes against ZONE_DMA32's intent, as it's expected for ZONE_DMA32
> > to be addressable with a 32 bit mask. So it was decided to re-introduce
> > ZONE_DMA in arm64.
> >=20
> > ZONE_DMA will contain the lower 1G of memory, which is currently the
> > memory area addressable by any peripheral on an arm64 device.
> > ZONE_DMA32 will contain the rest of the 32 bit addressable memory.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >=20
> > ---
>=20
> With ZONE_DMA=3Dy, this config will fail to reserve 512M CMA on a server,
>=20
> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
>=20
> CONFIG_DMA_CMA=3Dy
> CONFIG_CMA_SIZE_MBYTES=3D64
> CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
> CONFIG_CMA_ALIGNMENT=3D8
> CONFIG_CMA=3Dy
> CONFIG_CMA_DEBUGFS=3Dy
> CONFIG_CMA_AREAS=3D7
>=20
> Is this expected?

Not really, just tested cma=3D512M on a Raspberry Pi4, and it went well. Th=
e only
thing on my build that differs from your config is CONFIG_CMA_DEBUGFS.

Could you post more information on the device you're experiencing this on? =
Also
some logs.

Regards,
Nicolas


--=-h82UrL74CNp2lRPKbz+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2twhIACgkQlfZmHno8
x/4U7Qf/ZdG/T1u3Mhd7QimbgwhtDy+7HOxKrFVl2JndkuRooQ8OQlTx7pwRnOow
auWVm83R9XgT9N2n6+0ZHYUWcgjmqoSkGurnJPeZjONQdFmEZDvcB/mgTb4u/a1N
QC79LCo67Gk2V7jdkVdsijNirVn4JfZQ+mFUDSd9CJkVsbdFLq00q/3z30xoiPNm
m1GVAN9xvxKouoYtmKJ50IZ87keEjg2+Fqvxubu2Kzjf2Vsfyl6IjJ2opV10JqmL
baHrRu5QJteP3WS/MIHp2VbGAz0wNaEJ7f7cHeow4vnWrKRPPHk80b0nyMXzCr8d
RjT2ZFo/VrFpdG8Ik6gtKmn2VdAeug==
=V9f2
-----END PGP SIGNATURE-----

--=-h82UrL74CNp2lRPKbz+/--


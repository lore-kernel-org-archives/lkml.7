Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A50BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F9421848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfJONHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbfJONHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5344B300;
        Tue, 15 Oct 2019 13:07:12 +0000 (UTC)
Message-ID: <d57feba7e3956136a5d77cebbbf2807c2950d6df.camel@suse.de>
Subject: Re: [PATCH RFC 4/5] dma/direct: check for overflows in ARM's
 dma_capable()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mbrugger@suse.com, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        iommu@lists.linux-foundation.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Tue, 15 Oct 2019 15:07:08 +0200
In-Reply-To: <20191015102346.GA9071@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
         <20191014183108.24804-5-nsaenzjulienne@suse.de>
         <20191015102346.GA9071@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QilbOjg9rL1IFStaY+t4"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QilbOjg9rL1IFStaY+t4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 03:23 -0700, Christoph Hellwig wrote:
> On Mon, Oct 14, 2019 at 08:31:06PM +0200, Nicolas Saenz Julienne wrote:
> > The Raspberry Pi 4 has a 1GB ZONE_DMA area starting at address
> > 0x00000000 and a mapping between physical and DMA memory offset by
> > 0xc0000000.  It transpires that, on non LPAE systems, any attempt to
> > translate physical addresses outside of ZONE_DMA will result in an
> > overflow. The resulting DMA addresses will not be detected by arm's
> > dma_capable() as they still fit in the device's DMA mask.
> >=20
> > Fix this by failing to validate a DMA address smaller than the lowest
> > possible DMA address.
>=20
> I think the main problem here is that arm doesn't respect the
> bus_dma_mask.  If you replace the arm version of dma_capable with
> the generic one, does that fi the issue for you as well?

Yeah, that was my fist thought too, but it doesn't help.

So with RPi4's DMA mapping:

soc {
	dma-ranges =3D <0xc0000000  0x0 0x00000000  0x3c000000>;
	[...]
};

You'll get a 32bit bus dma map (log2i(0xc0000000 + 0x3c000000) + 1 =3D 32).

Trouble is, taking into account arm's multi_v7_defconfig uses 32bit address=
es,
most phys_to_dma() translations are likely to overflow. For example phys
0x60000000 will be translated to DMA 0x20000000, which is no good.

No mask is going to catch this, and both dma_capable() implementations will
fail.

> We need to untangle the various macros arm uses for the direct mapping
> and eventually we should be able to use the linux/dma-direct.h helpers
> directly.  Here is a branch with some simple preps I had.  Freshly
> rebased, not actually tested:
>=20
>=20
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-generic=
-dma-preps

Noted, looks good to me.

Actually, an alternative to this patch would be to kill all custom
dma_capable() implementations, which are mostly redundant, and add these ex=
tra
checks conditional to the DMA address size in the generic version. I'll try=
 to
respin this if I manage to understand what's going on with x86/sta211-fixup=
.c.


--=-QilbOjg9rL1IFStaY+t4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2lxHwACgkQlfZmHno8
x/5Qcgf9EYUZQRbilIK5s8eKqWcMhlpK7Df2P6SPXLkx+Vmkt2iYDyTfPLwB0Avl
I9aSjwDP/vRSkR7DgiKGQkh2PtdHWFDUoCerdQnJb69v+DiObndKo5Zd0XCtbYx+
+gPtyf43YhEGosmXi6aTI7pEh7HBYqu8ORrFJrdWaff3K5LJ8p4Phkkckup0NjHH
Ddq96VamoZdnKmA171GZ6HNgUdYn8cOjUBA5DLOWK5LAX2rAd1g6bNCgs/GcUL4l
sjoBu3utxJ9O9oe5reVU2XYfmX65xZqHqd1KkwN51Qo/w483+Hn0eSEclTVqT3hm
8tkxAlJWOPwPdLB8706dF6mwsGp2Lw==
=CUJl
-----END PGP SIGNATURE-----

--=-QilbOjg9rL1IFStaY+t4--


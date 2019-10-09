Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E808ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0132C20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfJIPZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:25:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729471AbfJIPZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:25:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52561AD07;
        Wed,  9 Oct 2019 15:25:12 +0000 (UTC)
Message-ID: <930cb2d2d47e2785711bab59d80e8ad188bd882d.camel@suse.de>
Subject: Re: [PATCH v2] of: Make of_dma_get_range() work on bus nodes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 09 Oct 2019 17:24:33 +0200
In-Reply-To: <CAL_Jsq+RjC0b1ZXzgmMdn5Gd1=3zkN62Jdq_QKeZ8-X4pCiDPw@mail.gmail.com>
References: <20191008195239.12852-1-robh@kernel.org>
         <4f6b26f8779a4fd98712b966bff3491dc31e26c2.camel@suse.de>
         <CAL_Jsq+RjC0b1ZXzgmMdn5Gd1=3zkN62Jdq_QKeZ8-X4pCiDPw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gkzPvU3MSN8O+PY+3B0Z"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gkzPvU3MSN8O+PY+3B0Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-08 at 20:03 -0500, Rob Herring wrote:
> On Tue, Oct 8, 2019 at 3:52 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Hi Rob/Robin,
> >=20
> > On Tue, 2019-10-08 at 14:52 -0500, Rob Herring wrote:
> > > From: Robin Murphy <robin.murphy@arm.com>
> > >=20
> > > Since the "dma-ranges" property is only valid for a node representing=
 a
> > > bus, of_dma_get_range() currently assumes the node passed in is a lea=
f
> > > representing a device, and starts the walk from its parent. In cases
> > > like PCI host controllers on typical FDT systems, however, where the =
PCI
> > > endpoints are probed dynamically the initial leaf node represents the
> > > 'bus' itself, and this logic means we fail to consider any "dma-range=
s"
> > > describing the host bridge itself. Rework the logic such that
> > > of_dma_get_range() also works correctly starting from a bus node
> > > containing "dma-ranges".
> > >=20
> > > While this does mean "dma-ranges" could incorrectly be in a device le=
af
> > > node, there isn't really any way in this function to ensure that a le=
af
> > > node is or isn't a bus node.
> >=20
> > Sorry, I'm not totally sure if this is what you're pointing out with th=
e
> > last
> > sentence. But, what about the case of a bus configuring a device which =
also
> > happens to be a memory mapped bus (say a PCI platform device). It'll ge=
t
> > it's
> > dma config based on its own dma-ranges which is not what we want.
>=20
> What I was trying to say is we just can't tell if we should be looking
> in the current node or the parent. 'dma-ranges' in a leaf node can be
> correct or incorrect.
>=20
> Your example is a bit different. I'm not sure that case is valid or
> can ever work if it is. It's certainly valid that a PCI bridge's
> parent has dma-ranges and now we'll actually handle any translation.
> The bridge itself is not a DMA-capable device, but just passing thru
> DMA.

Yes, you're right, I hadn't thought of it from that perspective. Thanks!

> Do we ever need to know the parent's dma-ranges in that case? Or
> to put it another way, is looking at anything other than leaf
> dma-ranges useful?

There is no need at all indeed.

With that,

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

and

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

On a Raspberry Pi 4 with pcie-brcmstb.c which is still work in progress but
depends on this.

Regards,
Nicolas


--=-gkzPvU3MSN8O+PY+3B0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2d+7EACgkQlfZmHno8
x/6Ougf/Vf8gS9pV6sHacKH3tBVDLky7gMGKrkyw4QWRDU3aKrGLrWgJg+5xuKcC
fzVafJIYqaU3FkYrBVWO7NRS8juguj17xOcSplJal0y1yHuu8hbTt3E8GUh5ut26
GZsicybI8VcxF0JEhyHAV6foKA2ZsYkPxG93XsnR7FobzIgTI84KxTlNnrZs5Ejt
zjgjxaR1yrcT5YamAIRKy/DpmfHx3Hpf7jMsHZFKqTmSbNlyUBevpH2ok9B45+ec
rtSa6TmEQyRrklJuXEJV4Yg1NccFffrQm3sD8AxSw+1P1nfNzVLm0NVcJjchKp11
RawTR+PF/Z4eXnNVywKxieHo/Js+yg==
=KQ2V
-----END PGP SIGNATURE-----

--=-gkzPvU3MSN8O+PY+3B0Z--


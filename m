Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0E9CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA602086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfJaQXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:23:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727580AbfJaQXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:23:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60797B833;
        Thu, 31 Oct 2019 16:23:01 +0000 (UTC)
Message-ID: <6726a651c12d91ca22b9d8984745d90db5d507ec.camel@suse.de>
Subject: Re: [PATCH] dma/direct: turn ARCH_ZONE_DMA_BITS into a variable
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org
Date:   Thu, 31 Oct 2019 17:22:59 +0100
In-Reply-To: <20191031155750.GA7394@lst.de>
References: <20191031152837.15253-1-nsaenzjulienne@suse.de>
         <20191031154759.GA7162@lst.de>
         <40d06d463c05d36968e8b64924d78f7794f8de50.camel@suse.de>
         <20191031155750.GA7394@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-geumnkbETQYdG1ZUMwUA"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-geumnkbETQYdG1ZUMwUA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-31 at 16:57 +0100, Christoph Hellwig wrote:
> On Thu, Oct 31, 2019 at 04:53:13PM +0100, Nicolas Saenz Julienne wrote:
> > > > +#define ARM64_ZONE_DMA_BITS	30
> > > > +
> > > >  /*
> > > >   * We need to be able to catch inadvertent references to memstart_=
addr
> > > >   * that occur (potentially in generic code) before
> > > > arm64_memblock_init()
> > > > @@ -424,6 +427,8 @@ void __init arm64_memblock_init(void)
> > > >  	else
> > > >  		arm64_dma_phys_limit =3D PHYS_MASK + 1;
> > > > =20
> > > > +	zone_dma_bits =3D ARM64_ZONE_DMA_BITS;
> > > > +
> > > >  	reserve_crashkernel();
> > >=20
> > > This actually adds a new limit, as there wasn't one before for arm64.
> >=20
> > Well, as zone_dma_bits is only relevant in dma/direct when ZONE_DMA is
> > defined
> > I figured it doesn't matter if the variable is set conditionally to ZON=
E_DMA
> > or
> > not.
>=20
> I'd much prefer that to do separately.

OK, I see what you mean now. It's wrong indeed.

The trouble is the ZONE_DMA series[1] in arm64, also due for v5.5, will be
affected by this patch. I don't know the right way to approach this problem
since depending on the merge order, this patch should be updated or the arm=
64
ZONE_DMA series fixed.

Maybe it's easier to just wait for v5.6.

Regards,
Nicolas

[1] https://lkml.org/lkml/2019/9/11/734


--=-geumnkbETQYdG1ZUMwUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl27CmMACgkQlfZmHno8
x/4b+AgAoH8wv9sfGomdszgwev9YRlMzey4HKe8HTYaOtmPwv+9I5u2Q1L0Hll8U
oOvfmsMi3/GCphnYxgVI15TV3gT23I4f+e1sVmHtdJwOja145qdVYeN0eVrJBGlW
gllgXNWdKSeomR5jQYRo6/r/e4b2DFreMuJMYO5Ac0Jmp4lqqbZ9tXDqMvKt0VcB
4olZERu99fJIT8AxzUVXOG9cft6l18Fio1WtXJLzXgVrjxEKnxGLAq1GxY5o8VF7
mf5621L1pvp/rNs/CBhehPADNaJqYwdS+nm7md9u/My8zRvp2OqT8O9a4e7RxcQi
QPdhGBoQVaeZdUmbRgLmr2hq8cGTqw==
=2ip7
-----END PGP SIGNATURE-----

--=-geumnkbETQYdG1ZUMwUA--


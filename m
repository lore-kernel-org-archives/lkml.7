Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA10CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D6620862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfJaKoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:44:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbfJaKoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:44:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46A14AC44;
        Thu, 31 Oct 2019 10:44:52 +0000 (UTC)
Message-ID: <cc8dd3f3261c75db44ebe991212b2b501b95fe5f.camel@suse.de>
Subject: Re: [PATCH v2 1/2] dma-direct: check for overflows on 32 bit DMA
 addresses
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     rubini@gnudd.com, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, helgaas@kernel.org,
        iommu@lists.linux-foundation.org
Date:   Thu, 31 Oct 2019 11:44:50 +0100
In-Reply-To: <20191030214140.GB25515@infradead.org>
References: <20191018110044.22062-1-nsaenzjulienne@suse.de>
         <20191018110044.22062-2-nsaenzjulienne@suse.de>
         <20191030214140.GB25515@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8na/vhjgey3dmGswifWc"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8na/vhjgey3dmGswifWc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-30 at 14:41 -0700, Christoph Hellwig wrote:
> On Fri, Oct 18, 2019 at 01:00:43PM +0200, Nicolas Saenz Julienne wrote:
> > +#ifndef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +	/* Check if DMA address overflowed */
> > +	if (min(addr, addr + size - 1) <
> > +		__phys_to_dma(dev, (phys_addr_t)(min_low_pfn << PAGE_SHIFT)))
> > +		return false;
> > +#endif
>=20
> Would be nice to use IS_ENABLED and PFN_PHYS here, and I also think we
> need to use phys_to_dma to take care of the encryption bit.  If you then
> also introduce an end variable we can make the whole thing actually look
> nice:
>=20
> static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_=
t
> size)
> {
> 	dma_addr_t end =3D addr + size - 1;
>=20
>         if (!dev->dma_mask)
>                 return false;
>=20
> 	if (!IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
> 	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
> 		return false;
>=20
>         return end <=3D min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
> }
>=20
> Otherwise this looks sensible to me.

Thanks, noted.


--=-8na/vhjgey3dmGswifWc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl26uyIACgkQlfZmHno8
x/6faggAkUu1xkZr5yxkCdu+LrePqzvMc6UA2N3H3DznZz6FCuJuxEz7RvASAKYr
HDGjjBTtzbzxrdlhuEANucWhVE+WfFj18aWeSH2BL67ogVrNFIUeYKejhylBwj2U
19sS0FIdk1iSM6FYdDBH0g937Qo8tToyoiNfq3lpy/DvDF5Ge4oVGbURGl+0ARRu
UxX2wCOxPO1MM9RqjI5vc75o5bxxnmxSOVGZCbqSO2PDtqJSGcNjIPZMEIV2uVD+
P3CWcXOChiLXpppitNT5zdhzAN/tw57uP4xg7FYOQYNwn+SGyHq40CxhnbIRmC6V
KY+nFhWbVlJx+m7KgsbvpF6VuCPQ7Q==
=r3RJ
-----END PGP SIGNATURE-----

--=-8na/vhjgey3dmGswifWc--


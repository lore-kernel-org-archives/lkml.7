Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88730C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E6C217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfK1VUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:20:12 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40702 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1VUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:20:12 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EA3B31C23A6; Thu, 28 Nov 2019 22:20:09 +0100 (CET)
Date:   Thu, 28 Nov 2019 22:20:08 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 105/306] swiotlb: do not panic on mapping failures
Message-ID: <20191128212008.GA17610@amd>
References: <20191127203114.766709977@linuxfoundation.org>
 <20191127203123.013432076@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20191127203123.013432076@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-11-27 21:29:15, Greg Kroah-Hartman wrote:
> From: Christoph Hellwig <hch@lst.de>
>=20
> [ Upstream commit 8088546832aa2c0d8f99dd56edf6384f8a9b63b3 ]
>=20
> All properly written drivers now have error handling in the
> dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> prints a useful warning when running out of swiotlb pool space we can
> also remove swiotlb_full entirely as it serves no purpose now.

Umm. I trust you that is true in mainline, but is it also true for
-stable kernels?

Does this fix anything for -stable users?

Best regards,
							Pavel

> +++ b/kernel/dma/swiotlb.c
> @@ -761,34 +761,6 @@ static bool swiotlb_free_buffer(struct device *dev, =
size_t size,
>  	return true;
>  }
> =20
> -static void
> -swiotlb_full(struct device *dev, size_t size, enum dma_data_direction di=
r,
> -	     int do_panic)
> -{
> -	if (swiotlb_force =3D=3D SWIOTLB_NO_FORCE)
> -		return;
> -
> -	/*
> -	 * Ran out of IOMMU space for this operation. This is very bad.
> -	 * Unfortunately the drivers cannot handle this operation properly.
> -	 * unless they check for dma_mapping_error (most don't)
> -	 * When the mapping is small enough return a static buffer to limit
> -	 * the damage, or panic when the transfer is too big.
> -	 */
> -	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
> -			    size);
> -
> -	if (size <=3D io_tlb_overflow || !do_panic)
> -		return;
> -
> -	if (dir =3D=3D DMA_BIDIRECTIONAL)
> -		panic("DMA: Random memory could be DMA accessed\n");
> -	if (dir =3D=3D DMA_FROM_DEVICE)
> -		panic("DMA: Random memory could be DMA written\n");
> -	if (dir =3D=3D DMA_TO_DEVICE)
> -		panic("DMA: Random memory could be DMA read\n");
> -}
> -
>  /*
>   * Map a single buffer of the indicated size for DMA in streaming mode. =
 The
>   * physical address to use is returned.
> @@ -817,10 +789,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, stru=
ct page *page,
> =20
>  	/* Oh well, have to allocate and map a bounce buffer. */
>  	map =3D map_single(dev, phys, size, dir, attrs);
> -	if (map =3D=3D SWIOTLB_MAP_ERROR) {
> -		swiotlb_full(dev, size, dir, 1);
> +	if (map =3D=3D SWIOTLB_MAP_ERROR)
>  		return __phys_to_dma(dev, io_tlb_overflow_buffer);
> -	}
> =20
>  	dev_addr =3D __phys_to_dma(dev, map);
> =20
> @@ -954,7 +924,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct sca=
tterlist *sgl, int nelems,
>  			if (map =3D=3D SWIOTLB_MAP_ERROR) {
>  				/* Don't panic here, we expect map_sg users
>  				   to do proper error handling. */
> -				swiotlb_full(hwdev, sg->length, dir, 0);
>  				attrs |=3D DMA_ATTR_SKIP_CPU_SYNC;
>  				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
>  						       attrs);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3gOggACgkQMOfwapXb+vJz1wCfXxVz3tOcsHSLZFBV+HSHI+es
aZ8An3n7whPXhZqZwaxHs/JEO+QFTB0T
=VoQy
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

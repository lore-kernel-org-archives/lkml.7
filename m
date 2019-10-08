Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE6AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBD6206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfJHUwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:52:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730523AbfJHUwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:52:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0F39AF9F;
        Tue,  8 Oct 2019 20:52:04 +0000 (UTC)
Message-ID: <4f6b26f8779a4fd98712b966bff3491dc31e26c2.camel@suse.de>
Subject: Re: [PATCH v2] of: Make of_dma_get_range() work on bus nodes
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms+renesas@verge.net.au>,
        Robin Murphy <robin.murphy@arm.com>,
        Stefan Wahren <wahrenst@gmx.net>
Date:   Tue, 08 Oct 2019 22:51:36 +0200
In-Reply-To: <20191008195239.12852-1-robh@kernel.org>
References: <20191008195239.12852-1-robh@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8hI66HT9gbTxUxyjGifb"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8hI66HT9gbTxUxyjGifb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob/Robin,

On Tue, 2019-10-08 at 14:52 -0500, Rob Herring wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>=20
> Since the "dma-ranges" property is only valid for a node representing a
> bus, of_dma_get_range() currently assumes the node passed in is a leaf
> representing a device, and starts the walk from its parent. In cases
> like PCI host controllers on typical FDT systems, however, where the PCI
> endpoints are probed dynamically the initial leaf node represents the
> 'bus' itself, and this logic means we fail to consider any "dma-ranges"
> describing the host bridge itself. Rework the logic such that
> of_dma_get_range() also works correctly starting from a bus node
> containing "dma-ranges".
>=20
> While this does mean "dma-ranges" could incorrectly be in a device leaf
> node, there isn't really any way in this function to ensure that a leaf
> node is or isn't a bus node.

Sorry, I'm not totally sure if this is what you're pointing out with the la=
st
sentence. But, what about the case of a bus configuring a device which also
happens to be a memory mapped bus (say a PCI platform device). It'll get it=
's
dma config based on its own dma-ranges which is not what we want.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [robh: Allow for the bus child node to still be passed in]
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Resending, hit send too quickly.
>=20
> v2:
>  - Ensure once we find dma-ranges, every parent has it.

I like this new approach.

Regards,
Nicolas

>  - Only get the #{size,address}-cells after we find non-empty dma-ranges
>  - Add a check on the 'dma-ranges' length
>=20
> This is all that remains of the dma-ranges series. I've applied the rest=
=20
> of the series prep and fixes. I dropped "of: Ratify of_dma_configure()=
=20
> interface" as the assertions that the node pointer being the parent only=
=20
> when struct device doesn't have a DT node pointer is not always=20
> true.
>=20
> I didn't include any tested-bys as this has changed a bit. A git branch=
=20
> is here[1].
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dma-mask=
s-v2
>=20
>  drivers/of/address.c | 44 ++++++++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 5ce69d026584..99c1b8058559 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -930,47 +930,39 @@ int of_dma_get_range(struct device_node *np, u64
> *dma_addr, u64 *paddr, u64 *siz
>  	const __be32 *ranges =3D NULL;
>  	int len, naddr, nsize, pna;
>  	int ret =3D 0;
> +	bool found_dma_ranges =3D false;
>  	u64 dmaaddr;
> =20
> -	if (!node)
> -		return -EINVAL;
> -
> -	while (1) {
> -		struct device_node *parent;
> -
> -		naddr =3D of_n_addr_cells(node);
> -		nsize =3D of_n_size_cells(node);
> -
> -		parent =3D __of_get_dma_parent(node);
> -		of_node_put(node);
> -
> -		node =3D parent;
> -		if (!node)
> -			break;
> -
> +	while (node) {
>  		ranges =3D of_get_property(node, "dma-ranges", &len);
> =20
>  		/* Ignore empty ranges, they imply no translation required */
>  		if (ranges && len > 0)
>  			break;
> =20
> -		/*
> -		 * At least empty ranges has to be defined for parent node if
> -		 * DMA is supported
> -		 */
> -		if (!ranges)
> -			break;
> +		/* Once we find 'dma-ranges', then a missing one is an error */
> +		if (found_dma_ranges && !ranges) {
> +			ret =3D -ENODEV;
> +			goto out;
> +		}
> +		found_dma_ranges =3D true;
> +
> +		node =3D of_get_next_dma_parent(node);
>  	}
> =20
> -	if (!ranges) {
> +	if (!node || !ranges) {
>  		pr_debug("no dma-ranges found for node(%pOF)\n", np);
>  		ret =3D -ENODEV;
>  		goto out;
>  	}
> =20
> -	len /=3D sizeof(u32);
> -
> +	naddr =3D of_bus_n_addr_cells(node);
> +	nsize =3D of_bus_n_size_cells(node);
>  	pna =3D of_n_addr_cells(node);
> +	if ((len / sizeof(__be32)) % (pna + naddr + nsize)) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> =20
>  	/* dma-ranges format:
>  	 * DMA addr	: naddr cells
> @@ -978,7 +970,7 @@ int of_dma_get_range(struct device_node *np, u64
> *dma_addr, u64 *paddr, u64 *siz
>  	 * size		: nsize cells
>  	 */
>  	dmaaddr =3D of_read_number(ranges, naddr);
> -	*paddr =3D of_translate_dma_address(np, ranges);
> +	*paddr =3D of_translate_dma_address(node, ranges + naddr);
>  	if (*paddr =3D=3D OF_BAD_ADDR) {
>  		pr_err("translation of DMA address(%llx) to CPU address failed
> node(%pOF)\n",
>  		       dmaaddr, np);


--=-8hI66HT9gbTxUxyjGifb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2c9tgACgkQlfZmHno8
x/62BQf/U0QT3ADqFU/ndfwRPioobN9ONdnh6CLT03TDkJM3U4WxCXne9c5e359z
go9HveWafv35Jy0use3A54V0HRtUpEGiIE5TIZiZxTx/erBny0QQb9P8o/tM2Dyc
3t0TW2FuAKLPsp5VbIJr66Afb1sUHRBsFfPrL3WFgSB1884tB75BLRaE5uX7hJ0h
cBY2nBlQHaa+77esbmMhxgbJ8hhV4sBY4V7hbGm1WNB1HMSKfwCBifEMc/3+2iKa
Z3trR/cfRxpPWSUAEyLQ807kvmkZyoHmIOjQr9cUB5gnxGpwA/B97OSmMCLq2RnT
sQ/cjASfdJZbBCLCEIITZv/ZzlEOBw==
=eTic
-----END PGP SIGNATURE-----

--=-8hI66HT9gbTxUxyjGifb--


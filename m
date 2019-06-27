Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79561C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0420815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W7K9i2pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfF0ABT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:01:19 -0400
Received: from ozlabs.org ([203.11.71.1]:60479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF0ABS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:01:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Z0Rb1Hfbz9s3l;
        Thu, 27 Jun 2019 10:01:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561593675;
        bh=1lE9AUF6MyOky71wFSDxHTgjZyRnH5kKDXEGsh2PNMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W7K9i2prjefws8sFIpZesIkplSmvPM27jioPoWN4t2FpUQH5MCEXwq/Ycue9xyNWI
         TanvuBp9XouwFzA2vbteP29Lf9Nccr4aZPXiV842jDugOEtSOvTTibb6nz9zqqo5ru
         sDZd/twnKNDFaNEgFgiGDBfaIrL0VNadNktcCyTqJiInJbRhg0F5gVcbA8S3nb32Ux
         Q2c6VsmYZDiUkXqAo9f2vXK1/6TvXjHeqqOGqkGyG7o7HIzK95yANM91TojqjZzr4+
         i78FbsozZ8smC3RdcuIPmDFUDTFi7/VMGs8LB4hq9sXhlGyCPo7lTjgktEAHB1QDAn
         S0LETTsgkwqKA==
Date:   Thu, 27 Jun 2019 10:01:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190627100114.3eda815f@canb.auug.org.au>
In-Reply-To: <20190626131318.GA5101@lst.de>
References: <20190626225807.205f1382@canb.auug.org.au>
        <20190626131318.GA5101@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TmVpELSjnXhVlpZ+rR=WhJA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TmVpELSjnXhVlpZ+rR=WhJA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 26 Jun 2019 15:13:18 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> As that function is in code only there to provide compile coverage
> something like this should fix the problem:
>=20
>=20
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm=
/pgtable_64.h
> index 547ff96fb228..1599de730532 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -861,10 +861,12 @@ static inline unsigned long pud_page_vaddr(pud_t pu=
d)
>  #define pud_clear(pudp)			(pud_val(*(pudp)) =3D 0UL)
>  #define pgd_page_vaddr(pgd)		\
>  	((unsigned long) __va(pgd_val(pgd)))
> -#define pgd_page(pgd)			pfn_to_page(pgd_pfn(pgd))
>  #define pgd_present(pgd)		(pgd_val(pgd) !=3D 0U)
>  #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) =3D 0UL)
> =20
> +/* only used by the stubbed out hugetlb gup code, should never be called=
 */
> +#define pgd_page(pgd)			NULL
> +
>  static inline unsigned long pud_large(pud_t pud)
>  {
>  	pte_t pte =3D __pte(pud_val(pud));

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/TmVpELSjnXhVlpZ+rR=WhJA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UB0oACgkQAVBC80lX
0GxIZwgAhEu9RAp1zw7pbbiYTJSgyEfJ+NiUbwBPJBdW898jCXDYggkQdOge4hID
9ycFIIX9NcWqFPEp4aZIs7WoAh+d6IhOR4AEd61u0x2l9r4JsydkQ95K0EruOQtQ
VexF4aPCCNbFwOxRADrkHZ/ZOQIUZ/9MQCCLg1Zm3kJXITjsnm7TqSFfGJXsR1+V
w+ekwkxnB0EYzJPhk/1mZRoXvijX+9cOdLX+G4orCEqPCLFl4/y1Z2Cse8CmAnzS
ArQsJI3xn7BUUHdXMeE3o5kJWeAa53pgC0rwTxbnysGtXq5uJmyGb6mRnkKOf+tk
3MM/gznYCyCM66+sWmjLLu4xb8cN2g==
=ERSj
-----END PGP SIGNATURE-----

--Sig_/TmVpELSjnXhVlpZ+rR=WhJA--

Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7852C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F75C20815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g9H0EqGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfF0AGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:06:22 -0400
Received: from ozlabs.org ([203.11.71.1]:57061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF0AGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:06:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Z0YP74Bsz9s3l;
        Thu, 27 Jun 2019 10:06:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561593978;
        bh=8Hr8+8sV64MiYrtvdI2lrD9HaUyy8PmtsfdtCacMw54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g9H0EqGdNbqlbtj25nvoH/11hrDm8DuMaOp1WI2LIIcnmMWaYtU7IDhdzf63mWfUi
         ol8nRp003otS79GiD1mz9pfHW9SYHi3ndgpmfqmIom1GKo6YfExsGeJet7CdAxlst1
         d4jYVioAs9+LNVT8/+zGe17hND8oy9RK9Dp3LI124Qgkjbj5CD+UuWerqnY5wnxZUT
         4b/BFhZvU464RccRBcYJ7lOjjTWMNoSKec3cK7S++SCAWsOq45UdHKwwRijv3mLgpA
         IqvHH2J76vNfh2Jt23VRpL/IiYb/CQBVft3fZm6oXSh4kKzbCzYiZhAkco0w2mowg9
         FMfDj5RvPZK9w==
Date:   Thu, 27 Jun 2019 10:06:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s/radix: Define arch_ioremap_p4d_supported()
Message-ID: <20190627100617.74c74e79@canb.auug.org.au>
In-Reply-To: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
References: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n9_h8L+fKQmZXfOCydxkhZu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n9_h8L+fKQmZXfOCydxkhZu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

On Wed, 26 Jun 2019 18:51:00 +0530 Anshuman Khandual <anshuman.khandual@arm=
.com> wrote:
>
> Recent core ioremap changes require HAVE_ARCH_HUGE_VMAP subscribing archs
> provide arch_ioremap_p4d_supported() failing which will result in a build
> failure like the following.
>=20
> ld: lib/ioremap.o: in function `.ioremap_huge_init':
> ioremap.c:(.init.text+0x3c): undefined reference to
> `.arch_ioremap_p4d_supported'
>=20
> This defines a stub implementation for arch_ioremap_p4d_supported() keepi=
ng
> it disabled for now to fix the build problem.
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-next@vger.kernel.org
>=20
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This has been just build tested and fixes the problem reported earlier.
>=20
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/b=
ook3s64/radix_pgtable.c
> index 8904aa1..c81da88 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1124,6 +1124,11 @@ void radix__ptep_modify_prot_commit(struct vm_area=
_struct *vma,
>  	set_pte_at(mm, addr, ptep, pte);
>  }
> =20
> +int __init arch_ioremap_p4d_supported(void)
> +{
> +	return 0;
> +}
> +
>  int __init arch_ioremap_pud_supported(void)
>  {
>  	/* HPT does not cope with large pages in the vmalloc area */
> --=20
> 2.7.4
>=20

I will add that as a merge resolution patch for the akpm-current tree
merge today.

--=20
Cheers,
Stephen Rothwell

--Sig_/n9_h8L+fKQmZXfOCydxkhZu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0UCHkACgkQAVBC80lX
0GzSRwf7BzDnZme1lz1V4QMONN1IuVY+pZX1QXKrRyb02gfpevX+bps5fVXU900w
Ba2QoMMkdVL042M4+W390SZxydX+BTcEfgxSgEFxQNKNv+3qolu6YKdQGszWhl5y
8I6VTUln4K3U+5QrEsx2GOfr+TP1ktGlrDQRvn58tkfr0GBy8eu5VvKMM+3zyh/L
iYqND4uA2ufFY550R3KI9uCh2y7nbaOIm6GWqIiBmwEQBiRctcL1EQMuKqQii938
bFS8SbP7WHkdRGB9L6AMACbjEPGLPwWodrMd0oA1yhcfYz38wkIJPVrI1cTmltS0
jmhRFG6gblzMWAbvnlBmbS3Zrs33bg==
=UR4X
-----END PGP SIGNATURE-----

--Sig_/n9_h8L+fKQmZXfOCydxkhZu--

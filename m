Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83ACC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831D6216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tUAsgxzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfGIAGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:06:50 -0400
Received: from ozlabs.org ([203.11.71.1]:51069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfGIAGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:06:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN0P65sjz9s7T;
        Tue,  9 Jul 2019 10:06:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630806;
        bh=sxQZ27c64rSd+o49p5iREDQujCubWTwdGrTLN+/uOhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tUAsgxzs3KF9Pmd729LAo1wKz1W3Ytjv3Iv8QEQN6vh9hk04rU2hcqzhe4vx0vSY9
         k5ezuEw9xrOWYMftHo2TodhKqb8bXejx19O22D2aMMq2hxRp9IBOdV13I7JjAw1rUJ
         pv3HfGQtAD9QQRjc78HVWKOHOm9Fe0HaipuGX7x8qDLSmOXwW6KqRtqssjKfxtuf1t
         x6twSf+Svw2eV4jBUtndfE1/n8y5t5XfBxcLtj6ApWf6YHzFkGBIRXUp6hJolKyHtp
         sotbrKjczZaCusoADkj1xTTLHMGaX/enD38pLZ1tgArvI0I71X41c3vGu75kRLexPC
         QHLW0MgsT94iw==
Date:   Tue, 9 Jul 2019 10:06:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the drm
 tree
Message-ID: <20190709100645.5302a5c9@canb.auug.org.au>
In-Reply-To: <20190624210659.152a20bb@canb.auug.org.au>
References: <20190624204908.64a33862@canb.auug.org.au>
        <20190624210659.152a20bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wnTM.VeYJ+JlENcDNWjJAZU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wnTM.VeYJ+JlENcDNWjJAZU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 24 Jun 2019 21:06:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 24 Jun 2019 20:49:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the akpm-current tree got a conflict in:
> >=20
> >   mm/memory.c
> >=20
> > between commit:
> >=20
> >   29875a52915e ("mm: Add an apply_to_pfn_range interface")
> >=20
> > from the drm tree and commit:
> >=20
> >   e972cea08fb3 ("mm/pgtable: drop pgtable_t variable from pte_fn_t func=
tions")
> >=20
> > from the akpm-current tree.
> >=20
> > I fixed it up (see below my signature, then added the following merge
> > resolution patch as well) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 24 Jun 2019 20:40:46 +1000
> > Subject: [PATCH] merge fixup for "mm: Add an apply_to_pfn_range interfa=
ce"
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  include/linux/mm.h    | 2 +-
> >  mm/as_dirty_helpers.c | 8 ++------
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 87d53de3dee4..4404e18443ef 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2673,7 +2673,7 @@ extern int apply_to_page_range(struct mm_struct *=
mm, unsigned long address,
> >  			       unsigned long size, pte_fn_t fn, void *data);
> > =20
> >  struct pfn_range_apply;
> > -typedef int (*pter_fn_t)(pte_t *pte, pgtable_t token, unsigned long ad=
dr,
> > +typedef int (*pter_fn_t)(pte_t *pte, unsigned long addr,
> >  			 struct pfn_range_apply *closure);
> >  struct pfn_range_apply {
> >  	struct mm_struct *mm;
> > diff --git a/mm/as_dirty_helpers.c b/mm/as_dirty_helpers.c
> > index f600e31534fb..7c863626c2a4 100644
> > --- a/mm/as_dirty_helpers.c
> > +++ b/mm/as_dirty_helpers.c
> > @@ -26,7 +26,6 @@ struct apply_as {
> >  /**
> >   * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
> >   * @pte: Pointer to the pte
> > - * @token: Page table token, see apply_to_pfn_range()
> >   * @addr: The virtual page address
> >   * @closure: Pointer to a struct pfn_range_apply embedded in a
> >   * struct apply_as
> > @@ -36,8 +35,7 @@ struct apply_as {
> >   *
> >   * Return: Always zero.
> >   */
> > -static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
> > -			      unsigned long addr,
> > +static int apply_pt_wrprotect(pte_t *pte, unsigned long addr,
> >  			      struct pfn_range_apply *closure)
> >  {
> >  	struct apply_as *aas =3D container_of(closure, typeof(*aas), base);
> > @@ -78,7 +76,6 @@ struct apply_as_clean {
> >  /**
> >   * apply_pt_clean - Leaf pte callback to clean a pte
> >   * @pte: Pointer to the pte
> > - * @token: Page table token, see apply_to_pfn_range()
> >   * @addr: The virtual page address
> >   * @closure: Pointer to a struct pfn_range_apply embedded in a
> >   * struct apply_as_clean
> > @@ -91,8 +88,7 @@ struct apply_as_clean {
> >   *
> >   * Return: Always zero.
> >   */
> > -static int apply_pt_clean(pte_t *pte, pgtable_t token,
> > -			  unsigned long addr,
> > +static int apply_pt_clean(pte_t *pte, unsigned long addr,
> >  			  struct pfn_range_apply *closure)
> >  {
> >  	struct apply_as *aas =3D container_of(closure, typeof(*aas), base);
> > --=20
> > 2.20.1
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc mm/memory.c
> > index 462aa47f8878,f8a75528658a..e7e37fcbd687
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@@ -2037,12 -2036,11 +2035,11 @@@ static int apply_to_pte_range(struct=
 pf
> >   {
> >   	pte_t *pte;
> >   	int err;
> > - 	pgtable_t token;
> >   	spinlock_t *uninitialized_var(ptl);
> >  =20
> >  -	pte =3D (mm =3D=3D &init_mm) ?
> >  +	pte =3D (closure->mm =3D=3D &init_mm) ?
> >   		pte_alloc_kernel(pmd, addr) :
> >  -		pte_alloc_map_lock(mm, pmd, addr, &ptl);
> >  +		pte_alloc_map_lock(closure->mm, pmd, addr, &ptl);
> >   	if (!pte)
> >   		return -ENOMEM;
> >  =20
> > @@@ -2050,10 -2048,8 +2047,8 @@@
> >  =20
> >   	arch_enter_lazy_mmu_mode();
> >  =20
> > - 	token =3D pmd_pgtable(*pmd);
> > -=20
> >   	do {
> > - 		err =3D closure->ptefn(pte++, token, addr, closure);
> >  -		err =3D fn(pte++, addr, data);
> > ++		err =3D closure->ptefn(pte++, addr, closure);
> >   		if (err)
> >   			break;
> >   	} while (addr +=3D PAGE_SIZE, addr !=3D end); =20
>=20
> I also needed this:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 24 Jun 2019 21:04:14 +1000
> Subject: [PATCH] another fixup for "mm: Add an apply_to_pfn_range interfa=
ce"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  mm/memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/memory.c b/mm/memory.c
> index e7e37fcbd687..81d71fbfca5a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2189,14 +2189,13 @@ struct page_range_apply {
>   * Callback wrapper to enable use of apply_to_pfn_range for
>   * the apply_to_page_range interface
>   */
> -static int apply_to_page_range_wrapper(pte_t *pte, pgtable_t token,
> -				       unsigned long addr,
> +static int apply_to_page_range_wrapper(pte_t *pte, unsigned long addr,
>  				       struct pfn_range_apply *pter)
>  {
>  	struct page_range_apply *pra =3D
>  		container_of(pter, typeof(*pra), pter);
> =20
> -	return pra->fn(pte, token, addr, pra->data);
> +	return pra->fn(pte, addr, pra->data);
>  }
> =20
>  /*
> --=20
> 2.20.1

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/wnTM.VeYJ+JlENcDNWjJAZU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j2pUACgkQAVBC80lX
0GznIwgAid2lKuAKiZv3Jxj6tSB5AlzON3Kk0ddV9tOjlTlSd2FYyfcqMRef+ODR
u3434Xlzi57pvjpE9wNB6SZFqEPOq3jcHevewAvey/nIjnyetI1PtYrPmv2w6PYb
B8Tr7FYP5lLd49YO2malsuD+Ft//JZxXQEYmC7JM3ezehrXERZ46ofUJpZMUCu4G
QaW1QU/GNIjBJl+ykouXP7HYZdSf0I5SwjJu7Q3j1Y1CxJq/v5Hk6vtWUKhZMA7m
o4EdB9CiVzlZgjDkttKho3jJHdvTE9onYf5s2nfy9XYAD6DvaOZZQFC1TAZIdTLA
AivxJhXTSYBPf/V9yyPJUOuba+Kd/g==
=5V4t
-----END PGP SIGNATURE-----

--Sig_/wnTM.VeYJ+JlENcDNWjJAZU--

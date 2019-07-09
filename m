Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F248C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31F92166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GvWy18xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGIAVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:21:42 -0400
Received: from ozlabs.org ([203.11.71.1]:60739 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIAVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:21:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jNKZ5DTHz9s7T;
        Tue,  9 Jul 2019 10:21:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562631699;
        bh=BeM+WnpHQZ++djgkGKnXdl8TZo6yDQkhgtGOEWV3R5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GvWy18xe4sepIubWmDqrv5O1gIXhVUx4HrSl6rHE+stIdVJL3E64Zx2W1L0I28otT
         TSa3XXP/mVjuTDMKvxCpCHW5bzOdnleU060efKSqRO9dNymTmb4mQRxdPHiTKawvU/
         MMB8aPqTavqb/AfW5SE9D/GrVsvW9GWiUDMrskRGcGQvj5EFxClHpu6tuecGIqCXlq
         AqluRAui2whMlFkaZoRBPqmUgaCqZnqKmCJfzeeakVgqSBV4AbAtbJ4GTADna3DDTX
         luLELirdDwk16jt+bsR44KApeiNvchmkTg2+l8PkmnHfM/PNFBy3qnjRpgxmyJQZgX
         JDM2wKOa+FVvg==
Date:   Tue, 9 Jul 2019 10:21:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the hmm tree
Message-ID: <20190709102137.421d1dd1@canb.auug.org.au>
In-Reply-To: <20190701210853.0c72240b@canb.auug.org.au>
References: <20190701210853.0c72240b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/94y5l8fndW+yjD7YmlNI+mO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/94y5l8fndW+yjD7YmlNI+mO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 1 Jul 2019 21:08:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the hmm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> mm/hmm.c: In function 'hmm_get_or_create':
> mm/hmm.c:50:2: error: implicit declaration of function 'lockdep_assert_he=
ld_exclusive'; did you mean 'lockdep_assert_held_once'? [-Werror=3Dimplicit=
-function-declaration]
>   lockdep_assert_held_exclusive(&mm->mmap_sem);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   lockdep_assert_held_once
>=20
> Caused by commit
>=20
>   8a9320b7ec5d ("mm/hmm: Simplify hmm_get_or_create and make it reliable")
>=20
> interacting with commit
>=20
>   9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() =
-> lockdep_assert_held_write()")
>=20
> from the tip tree.
>=20
> I have added the following merge fix.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 1 Jul 2019 21:05:59 +1000
> Subject: [PATCH] mm/hmm: fixup for "locking/lockdep: Rename
>  lockdep_assert_held_exclusive() -> lockdep_assert_held_write()"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  mm/hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c1bdcef403ee..2ddbd589b207 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -47,7 +47,7 @@ static struct hmm *hmm_get_or_create(struct mm_struct *=
mm)
>  {
>  	struct hmm *hmm;
> =20
> -	lockdep_assert_held_exclusive(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_sem);
> =20
>  	/* Abuse the page_table_lock to also protect mm->hmm. */
>  	spin_lock(&mm->page_table_lock);
> @@ -248,7 +248,7 @@ static const struct mmu_notifier_ops hmm_mmu_notifier=
_ops =3D {
>   */
>  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
>  {
> -	lockdep_assert_held_exclusive(&mm->mmap_sem);
> +	lockdep_assert_held_write(&mm->mmap_sem);
> =20
>  	/* Sanity check */
>  	if (!mm || !mirror || !mirror->ops)

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/94y5l8fndW+yjD7YmlNI+mO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j3hEACgkQAVBC80lX
0GxaywgAmENSm1MjVA5kG/Vfcjl6o2QoPYrf+yWfylPVSHBC8neY9OJebPQ0BIXW
M6L8KulNiV4rPHm1aDsv3/5APubVT3jXfHWptm41IvGCfHnsxNLcxXqN+OEw9RvI
YgXZaBrJbgO86LUiuXXhNMqb5UTvTbp8qoMoQbz1N3U7DdV2pLqLxqF8FRlh1Yom
n2+ZmXdExBCWGiwzB2oYvbPuEVvM305n36YDLAWaCXEsHR+hrkkBjXEQqyC2YB05
/uTTu3OpjkoUpfMMjkt8VdPVT3V8nJ1F/WzU9Y16T1szF9gDf9yDowFgQshojiYc
/oREqeQzYlzapW6X32Vox0YFsrFnCA==
=kCFW
-----END PGP SIGNATURE-----

--Sig_/94y5l8fndW+yjD7YmlNI+mO--

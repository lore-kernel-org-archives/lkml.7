Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED57BC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8635F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dHc9jCZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfDWJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:06:12 -0400
Received: from ozlabs.org ([203.11.71.1]:45819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfDWJGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:06:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pHcH5mJ4z9s55;
        Tue, 23 Apr 2019 19:06:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556010368;
        bh=7daiUbHa2DM+A9nbyjPQuiabgz+O0lQU5fPntgGJv1M=;
        h=Date:From:To:Cc:Subject:From;
        b=dHc9jCZYkZcrEy7P3ou/0p8zIpyzpmxy3j+iqmyGuML0+yBeeyZb1pEpyZ83/zYmb
         onMOq1+NcSORoY0bLqwTnYsmUJEl/V+6xGyidsgtpOZJ+uAJJtpZyvJVSfkMPas7EC
         SKgAil3AOylBwhPZLV8Kg6sutS8y4hDPyr1b74DmJoG0djHhVcKZ7she9yKaNnCBgj
         HuPlMcnhnnJ3HjmvW7VZw5UtacHeMx5PRc6GwdCKAztXf1WWA3RtGz7oE7p+N1ovEM
         56DoqVBfVwe+W/WA+RXvHhKZuXuqM3LA5+Br/R3argBuki88X6b+V2ZNCgG+JoywVm
         kCakc2EbHcs9g==
Date:   Tue, 23 Apr 2019 19:06:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Ira Weiny <ira.weiny@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 powerpc-fixes tree
Message-ID: <20190423190606.0fefb856@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2ARaGh/=BsU+UGXvuPb+u_l"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2ARaGh/=BsU+UGXvuPb+u_l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/mm/mmu_context_iommu.c

between commits:

  eb9d7a62c386 ("powerpc/mm_iommu: Fix potential deadlock")
  7a3a4d763837 ("powerpc/mm_iommu: Allow pinning large regions")

from the powerpc-fixes tree and commit:

  02f506bad7af ("mm/gup: replace get_user_pages_longterm() with FOLL_LONGTE=
RM")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/mm/mmu_context_iommu.c
index 8330f135294f,755fe7adc0d8..000000000000
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@@ -135,27 -144,18 +131,28 @@@ static long mm_iommu_do_alloc(struct mm
  	}
 =20
  	down_read(&mm->mmap_sem);
 -	ret =3D get_user_pages(ua, entries, FOLL_WRITE | FOLL_LONGTERM,
 -			     mem->hpages, NULL);
 +	chunk =3D (1UL << (PAGE_SHIFT + MAX_ORDER - 1)) /
 +			sizeof(struct vm_area_struct *);
 +	chunk =3D min(chunk, entries);
 +	for (entry =3D 0; entry < entries; entry +=3D chunk) {
 +		unsigned long n =3D min(entries - entry, chunk);
 +
- 		ret =3D get_user_pages_longterm(ua + (entry << PAGE_SHIFT), n,
- 				FOLL_WRITE, mem->hpages + entry, NULL);
++		ret =3D get_user_pages(ua + (entry << PAGE_SHIFT), n,
++				     FOLL_WRITE | FOLL_LONGTERM,
++				     mem->hpages + entry, NULL);
 +		if (ret =3D=3D n) {
 +			pinned +=3D n;
 +			continue;
 +		}
 +		if (ret > 0)
 +			pinned +=3D ret;
 +		break;
 +	}
  	up_read(&mm->mmap_sem);
 -	if (ret !=3D entries) {
 -		/* free the reference taken */
 -		for (i =3D 0; i < ret; i++)
 -			put_page(mem->hpages[i]);
 -
 -		vfree(mem->hpas);
 -		kfree(mem);
 -		ret =3D -EFAULT;
 -		goto unlock_exit;
 +	if (pinned !=3D entries) {
 +		if (!ret)
 +			ret =3D -EFAULT;
 +		goto free_exit;
  	}
 =20
  	pageshift =3D PAGE_SHIFT;

--Sig_/2ARaGh/=BsU+UGXvuPb+u_l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+1X4ACgkQAVBC80lX
0GzKPwf/eFaYcP4HXH0SSp2FFkj7xchpF5DtNJfmEvjnf230qoH/ZqNgTpSV9hBK
Yonl18q1M7BNr13j+CNeKVr6iZOSDNPqSHCvB83cqIS7XcH8UzJEbuhpIfbAcI9f
B06JwSs4eFhhpAINXRGbE492Jl5DGB8Rxl2+KWRjXRBqYD7Q5V9d5pzj0HAt8N8/
zRvIEfDRxcCspk+x5LakeyiOh90fJC70+E72PhEtKHSYvjoLZ9pYtUARUVFaLfQG
p7RTS+px69y4nCYuQp4zCAMpzRaTBSSGHAatg+W7G+SIAtfd/wbCgkrG3Y9f9SGk
V9thHtcPP8+1j/HhkIipX9Fh0Skyow==
=OJEv
-----END PGP SIGNATURE-----

--Sig_/2ARaGh/=BsU+UGXvuPb+u_l--

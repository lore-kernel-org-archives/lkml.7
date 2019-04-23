Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A21C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CB920674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L6gdShw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfDWI5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:57:36 -0400
Received: from ozlabs.org ([203.11.71.1]:37541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWI5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:57:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pHQN27vwz9sNF;
        Tue, 23 Apr 2019 18:57:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556009852;
        bh=WToU+0B8dub+LYRfCUVi3KWI6mDmLU3QRxuAN0m9xFA=;
        h=Date:From:To:Cc:Subject:From;
        b=L6gdShw3PwGEXtYUQfGNMtQWbPuM6a2n/GcECm43ZOfNEhyitqAtS4KvbceC105zV
         yyLwDHf7YmqCKLugD69EwF5PfDeYPggUXWqAe8z6Rww1DWwiWqF4ylgIT7cO77BxRo
         vAO91ObnRoUE/wHwOCYhLYDydETZW22XRM40BaWzIOhoCqyMwR1XWF/EOBd2YgI8CF
         dwgZOakN7cAS+Efb6hczhbt/G5RY0Lg1GNYU85W6N1kID11rKTyRy9RGpTFdia2Hma
         SQSkde3mi4GyFPSEsCQc7APycu37OuaOP4z+O6/AeuFVblVKL9eoPT1FwoUxbUypjT
         YaExuiMFHHp/w==
Date:   Tue, 23 Apr 2019 18:57:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Laurent Vivier <lvivier@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: linux-next: manual merge of the akpm-current tree with the powerpc
 tree
Message-ID: <20190423185730.401f8676@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Nk6HokKlb1IQryWefgKDJ2M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nk6HokKlb1IQryWefgKDJ2M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/powerpc/mm/mem.c

between commit:

  f172acbfae1a ("powerpc/mm: move warning from resize_hpt_for_hotplug()")
  26ad26718dfa ("powerpc/mm: Fix section mismatch warning")

from the powerpc tree and commit:

  fc6a586376ab ("mm, memory_hotplug: provide a more generic restrictions fo=
r memory hotplug")
  e8b6bc564e97 ("mm/memory_hotplug: make __remove_pages() and arch_remove_m=
emory() never fail")

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

diff --cc arch/powerpc/mm/mem.c
index e12bec98366f,cc9425fb9056..000000000000
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@@ -109,8 -109,8 +109,8 @@@ int __weak remove_section_mapping(unsig
  	return -ENODEV;
  }
 =20
- int __ref arch_add_memory(int nid, u64 start, u64 size, struct vmem_altma=
p *altmap,
- 			  bool want_memblock)
 -int __meminit arch_add_memory(int nid, u64 start, u64 size,
 -			struct mhp_restrictions *restrictions)
++int __ref arch_add_memory(int nid, u64 start, u64 size,
++			  struct mhp_restrictions *restrictions)
  {
  	unsigned long start_pfn =3D start >> PAGE_SHIFT;
  	unsigned long nr_pages =3D size >> PAGE_SHIFT;
@@@ -131,8 -131,8 +131,8 @@@
  }
 =20
  #ifdef CONFIG_MEMORY_HOTREMOVE
- int __ref arch_remove_memory(int nid, u64 start, u64 size,
- 			     struct vmem_altmap *altmap)
 -void __meminit arch_remove_memory(int nid, u64 start, u64 size,
 -				  struct vmem_altmap *altmap)
++void __ref arch_remove_memory(int nid, u64 start, u64 size,
++			      struct vmem_altmap *altmap)
  {
  	unsigned long start_pfn =3D start >> PAGE_SHIFT;
  	unsigned long nr_pages =3D size >> PAGE_SHIFT;
@@@ -161,10 -160,7 +160,8 @@@
  	 */
  	vm_unmap_aliases();
 =20
 -	resize_hpt_for_hotplug(memblock_phys_mem_size());
 +	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) =3D=3D -ENOSPC)
 +		pr_warn("Hash collision while resizing HPT\n");
-=20
- 	return ret;
  }
  #endif
  #endif /* CONFIG_MEMORY_HOTPLUG */

--Sig_/Nk6HokKlb1IQryWefgKDJ2M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+03oACgkQAVBC80lX
0Gz8lgf/UMh08pAMMuEi1HXki2uwBPjULYkkOB7hT/sBlTNIsKj8PLg+HzB5AzS+
3KLroeGactSUQPGdrOywqyE6E9dVlBulJwsWjLda5D1tVPmN4aDYkKG0eXaK7ATX
sBRdb+AXlw4d4giNYySbvEkvUNNnOo/dd6jsdp/3jxuZVe/sq2U0s6Yfrh7hmUiN
+pvaEiHEVZdkOiAW7ToD1ksbB56ubAz1zy4Ii9KAkAl+p80c69C8cufbOYhFASws
83ItvUqxFfTSIehfHasJZybU1VUzAelZ5TfU460IC2addI9Q2cAAmxGiYWy8QTS3
roYa+gqqyGScJwQmcHLnPXzSpe8Iew==
=r82g
-----END PGP SIGNATURE-----

--Sig_/Nk6HokKlb1IQryWefgKDJ2M--

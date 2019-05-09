Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2698C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A081A20863
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dxhKYLmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEIFeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 01:34:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40959 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfEIFeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:34:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45028636KSz9s9T;
        Thu,  9 May 2019 15:33:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557380038;
        bh=6wGTfafiPBzIjK2iBvjzHAaCadWb3RMqMCS14ESH39I=;
        h=Date:From:To:Cc:Subject:From;
        b=dxhKYLmLjvN2yqbYjX9GdWlqhc2OKe6R2l+HyJHEDVOZ0PppdsRvNW6dNhGJF+bPn
         AxG39fsvv3qbnWTSNlLjtgzHd2fpdkVjk8/CI0SoJgjrGEnM4ad4GMNBPWsJOjQZ0Z
         z0JKHYjpq4Vave+QRExYHNeI6SZ3pxuPx2szJiZfk61QbBADj3UBmotAIoAuEtu1u9
         17RMTPDbZ+1WAw6FIZn9kOBv86l1AFTB8pe7uYCf+Aa3LYj2QwdoECgtWRzr4jhATw
         DsOVCUu6x4Pk+uXh1g4gAhHxHq+HGxqwVtzHTUQuhn1g26KzgITldVSboBqA1KKDXs
         wPMemjFtRDpTA==
Date:   Thu, 9 May 2019 15:33:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the akpm-current tree with the
 parisc-hd tree
Message-ID: <20190509153356.2b70fd73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QjPicI=x3mHS9imXhZXvRJN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QjPicI=x3mHS9imXhZXvRJN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/parisc/mm/init.c

between commit:

  98429dded340 ("parisc: Enable SPARSEMEM_VMEMMAP")

from the parisc-hd tree and commit:

  2e5adbd9e97a ("initramfs: provide a generic free_initrd_mem implementatio=
n")

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

diff --cc arch/parisc/mm/init.c
index 6fa6d3b1d3f4,437d4c35c562..000000000000
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@@ -928,18 -921,3 +928,11 @@@ void flush_tlb_all(void
  	spin_unlock(&sid_lock);
  }
  #endif
 +
- #ifdef CONFIG_BLK_DEV_INITRD
- void free_initrd_mem(unsigned long start, unsigned long end)
- {
- 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
- }
- #endif
-=20
 +#if defined(CONFIG_SPARSEMEM) && defined(CONFIG_SPARSEMEM_VMEMMAP)
 +int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 +			       int node, struct vmem_altmap *altmap)
 +{
 +	return vmemmap_populate_basepages(vstart, vend, node);
 +}
 +#endif

--Sig_/QjPicI=x3mHS9imXhZXvRJN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzTu8QACgkQAVBC80lX
0GwSLwf+NA/WKMZENE+LkwTWsh+yMyZ4yH/WElavw9yW1CNQBR4+n2UPoCV3VWb+
VGw37VOcUtK3R8ho7mvnq8UY7qXLU8J9UQrui6B4VpG2+na9LgPK/Bva4xvJVUm5
u0CKTuwxG4VyOrWH2zJR8YmocnIn4yu+1MXKQ+SSBOdNoGihDLb6hUF5OVVj5Sna
3P7uP3lDEZVbs1I68414MzMfZkFeTjsdDmRMWnD4fzwZeNXT5hIjOg3ZktqcIXgO
Y+ZkBNH5SLY5mJmTdrvitZnAE9v0Xbg04D51dCNBenAD4by7z4pUUSRFod3C1mcs
wLawNhPu7QU3Q6oDj+JNHdULuGGneQ==
=rE2q
-----END PGP SIGNATURE-----

--Sig_/QjPicI=x3mHS9imXhZXvRJN--

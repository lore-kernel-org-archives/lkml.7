Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D742C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D621C208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bhc+KLrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfFTGjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:39:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfFTGjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:39:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Tsck3gDBz9s5c;
        Thu, 20 Jun 2019 16:39:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561012790;
        bh=2GFOGkgGbiLZECffsT8YZZyzO0l3qx/sbv+hYZz1p38=;
        h=Date:From:To:Cc:Subject:From;
        b=bhc+KLrN3RyDfztjatZqYzycUVaARoAZ1XMhGpyj494NCVu7AsWcP9aQBVxcbCOYe
         wg53YVxgeckXsaj/GvV/8GW7A/5Af652RfO7azdYvomIxJSYth0kH75+h2qWN1j4Ij
         3OAf9WQZEkH32lL18Jht5jtqmmvIXMnpDz4SUT+o3/1G09gfn2KinMVY/Z4RV4d5c1
         73/OePN9eWOgwMcLN/d1dFaYJZxa3MF65uP1zltdFgroL5+Cnxm/tCercqo4cTbEuC
         QyA+KHcrst3AWgyY/qmkRLU+WuM8ZPi2BMBWdM5zpb6Hf/xU5GXdm1GYOHpmdgLJvM
         F5xKLjLq5qDeA==
Date:   Thu, 20 Jun 2019 16:39:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Pankaj Gupta <pagupta@redhat.com>
Subject: linux-next: manual merge of the nvdimm tree with the vhost tree
Message-ID: <20190620163948.0cfdc7c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nExES/9MyiZFREjqxRg_dJg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nExES/9MyiZFREjqxRg_dJg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Today's linux-next merge of the nvdimm tree got a conflict in:

  include/uapi/linux/virtio_ids.h

between commit:

  edcd69ab9a32 ("iommu: Add virtio-iommu driver")

from the vhost tree and commit:

  5990fce9c50e ("virtio-pmem: Add virtio pmem driver")

from the nvdimm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/virtio_ids.h
index cfe47c5d9a56,32b2f94d1f58..000000000000
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@@ -43,6 -43,6 +43,7 @@@
  #define VIRTIO_ID_INPUT        18 /* virtio input */
  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
 +#define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
+ #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 =20
  #endif /* _LINUX_VIRTIO_IDS_H */

--Sig_/nExES/9MyiZFREjqxRg_dJg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LKjQACgkQAVBC80lX
0Gzv3AgAkbqCtQ1tex3/mg4AWhSVb60nLI6AMLsfCvvhwCluPyyNPamZB7vgrZkg
b7J32SkWdZ2//ol0mzHBB/UhPe+6dYQX31b6u7Oupy6BR+/7FIbpyZ3EJra6n/mo
4ttNkaXZzcGdz8zu7qs7HxeW2dzbDUcxAh+X3X9kcgW17terEl7LQ2DXL0jqNsBv
dA3wWRkcpU/TWtlLYryuBUFX0BNaYp0CrbXzTaa0VxQK9ik68DctRdChbFgesBKw
RjXO4S9CFMSICcMxZoxuM0CZMn3WPOoQkdfiMMadO4nVsXHI0X7sBi7F/OMe5qhf
38iqBEQKe0rG78vkyXPTdk6M3LyFSw==
=hcK+
-----END PGP SIGNATURE-----

--Sig_/nExES/9MyiZFREjqxRg_dJg--

Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4ABC31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C3921E6D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lxJl1/4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFQIOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:14:54 -0400
Received: from ozlabs.org ([203.11.71.1]:48631 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfFQIOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:14:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45S3sf5Mzkz9s3l;
        Mon, 17 Jun 2019 18:14:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560759291;
        bh=eCah9jn4ZXZd31HrXgaN6CvPmGXQOXGpA2ZTxYuMOcc=;
        h=Date:From:To:Cc:Subject:From;
        b=lxJl1/4zxk3ATyi8vGhUzHqBeo8sxHPoZTD/tq+8krAhZcFLHwzzAinhddj1U6aC8
         xBMSg3+VWhZkaS5cfmNUQDuHJmCpkjdFL7UjaOm9WfCbr6eZQqubb1yddongefSwPt
         PmczqRe8vGBDL76PEbJFS3Pb42wVSIcubH5y+Ghyi+syC5EwcrHP5clu1hhZa/q1pm
         KAvmJ7Y5fyRVIr1aXASD5VeWnig4K0LNDpHBRCdi3YLSXYXJVVh/Dplq/4YVY5+ufX
         VgoYLwJbC3+Wlqq5GX8TDZOXcGdw3w12u1vkwnWBiTeAXNPNpM6vGNPvVoARWm3raJ
         fPem3IynlStLA==
Date:   Mon, 17 Jun 2019 18:14:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: linux-next: manual merge of the akpm-current tree with the
 dma-mapping tree
Message-ID: <20190617181439.42cf10e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JegpVCHMBOKvMjwseZEQqqB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JegpVCHMBOKvMjwseZEQqqB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  kernel/dma/remap.c

between commit:

  4b4b077cbd0a ("dma-remap: Avoid de-referencing NULL atomic_pool")

from the dma-mapping tree and commit:

  14de8ba3fa2e ("lib/genalloc.c: rename addr_in_gen_pool to gen_pool_has_ad=
dr")

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

diff --cc kernel/dma/remap.c
index 0207e3764d52,2b750f13bc8f..000000000000
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@@ -158,10 -158,7 +158,10 @@@ out
 =20
  bool dma_in_atomic_pool(void *start, size_t size)
  {
 +	if (unlikely(!atomic_pool))
 +		return false;
 +
- 	return addr_in_gen_pool(atomic_pool, (unsigned long)start, size);
+ 	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
  }
 =20
  void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flag=
s)

--Sig_/JegpVCHMBOKvMjwseZEQqqB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0HS+8ACgkQAVBC80lX
0GxB4wgAmIX4pW4toAMIJ0wifOaZBv0y87hpBJ8oM2eONzf1NC9UatfQP242hhTL
yzt0DgidtipnnF8Pqr6+LBU4ch1P5QtF9YjWBmjEZL0wEsAjJnRcY1NB4f8t7seW
E2twvddO0oQwVpQ8qKrOzQ6nhI4VXdTS7847zPkLQZqqGHm0M9nVebJZ1gZEl12t
4RHQjlDBnmLnEPQOzyMCjf3/JAaj7YRkaeUsomIAaeuCDVpyFViaZ7OgcIFAvrp0
/MjYd8DnwnzXsJA0e1hDMYwrrwu8noNJNi+z6LGkI8fYJYQoH4VgpO6hDeXOdQzl
UZrmIhwcHr8CkEl37yFE1NoeIRfqnA==
=RsdI
-----END PGP SIGNATURE-----

--Sig_/JegpVCHMBOKvMjwseZEQqqB--

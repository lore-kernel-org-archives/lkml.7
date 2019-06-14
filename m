Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEA8C31E4A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B417E20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JOAyb+WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFNDAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:00:48 -0400
Received: from ozlabs.org ([203.11.71.1]:57793 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfFNDAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:00:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Q52f6kgHz9sBb;
        Fri, 14 Jun 2019 13:00:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560481243;
        bh=m5X7GsQjj0dXlpKQUTPtE8A9eyH0F52zKw87lwG2hI0=;
        h=Date:From:To:Cc:Subject:From;
        b=JOAyb+WXUCCeOFSBUbYupotwV4ebSFtNAJP3Wvps6OvboKnaHVVleHJzuln+m7a1e
         4pzzLz2JhxPeTqEU+H6LpkTm6BHMh+DD34SpjTWhFSkMvfGY5O8A6WjEvYgcclp26L
         DEkz3NiewpNG+N7txc4rnZDab9Erz6p+1rG3STWgSC2AP+0q5rv2n6NCu7BKPijBMg
         t1i4x7Dg85m4qD6RXenlVSr7WsIjsQKscG+z877difF3dIX7JwMbxDHk9a0ddLf8zG
         vNRFhX+I0loruqPjOPJEJx9p19zgca0dRcxRnlTy+uoX4rczE+TjktGkm91kSpt4h7
         uYBzOxyi2D7mQ==
Date:   Fri, 14 Jun 2019 13:00:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>
Subject: linux-next: manual merge of the rdma tree with Linus' tree
Message-ID: <20190614130033.2d50bc2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EPAqQI1YF8isUvvVdnEK_20"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EPAqQI1YF8isUvvVdnEK_20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got conflicts in:

  drivers/infiniband/core/uverbs_cmd.c
  drivers/infiniband/core/uverbs_std_types_cq.c

between commit:

  6876aaedc8a1 ("RDMA/uverbs: Pass udata on uverbs error unwind")

from Linus' tree and commit:

  e39afe3d6dbd ("RDMA: Convert CQ allocations to be under core responsibili=
ty")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/core/uverbs_cmd.c
index 63fe14c7c68f,5c00d9a5698a..000000000000
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@@ -1053,8 -1045,10 +1056,10 @@@ static struct ib_ucq_object *create_cq(
  	return obj;
 =20
  err_cb:
 -	ib_destroy_cq(cq);
 +	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
-=20
+ 	cq =3D NULL;
+ err_free:
+ 	kfree(cq);
  err_file:
  	if (ev_file)
  		ib_uverbs_release_ucq(attrs->ufile, ev_file, obj);
diff --cc drivers/infiniband/core/uverbs_std_types_cq.c
index 07ea4e3c4566,06b8c7d017b7..000000000000
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@@ -135,8 -140,10 +140,10 @@@ static int UVERBS_HANDLER(UVERBS_METHOD
 =20
  	return 0;
  err_cq:
 -	ib_destroy_cq(cq);
 +	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
-=20
+ 	cq =3D NULL;
+ err_free:
+ 	kfree(cq);
  err_event_file:
  	if (ev_file)
  		uverbs_uobject_put(ev_file_uobj);

--Sig_/EPAqQI1YF8isUvvVdnEK_20
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0DDdEACgkQAVBC80lX
0GzZrwgAoJBhYFviY55t2R8SCHHVHhCeQeA16nGse9fCe1xU1qZpGg3eNPHd+IJ4
Q/+HGWrCL+99CG8cLl6jZoH7E3OCx2x0drlwIXGbLH+Gg7WN66r7DJpkDD6yBGpu
cNeZbH3DD7DBZRN5M6YSyyzQgMVPwOvHcob4XKCTyoYqudM7OQMcj9vl5ZeytkcF
9QgQv5gG7M9wt3up4RKytL8xSkIZuq2skhlFAzRlTSYuvhupyyiPq5U9AGJavVk1
u0hat8mkpOMY7CkvXWQmOQN4ksNj2nIgT6F/fGl1YZsuD13i1O9PooaIE6zjtqqs
QHYCA3CIS0k4d6Ii7x+d8b2Mp+8Tiw==
=fwNT
-----END PGP SIGNATURE-----

--Sig_/EPAqQI1YF8isUvvVdnEK_20--

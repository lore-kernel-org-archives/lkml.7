Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F58C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFA3216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lT61xPdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGIDaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:30:23 -0400
Received: from ozlabs.org ([203.11.71.1]:42495 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIDaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:30:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jSWJ2P1hz9sBt;
        Tue,  9 Jul 2019 13:30:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562643020;
        bh=dI3cbrreY/pe91HvhaAdQmzhXmces8JK6j4ZY+4UmBs=;
        h=Date:From:To:Cc:Subject:From;
        b=lT61xPdwS+lf7ohs+0KdHaeBL3GGjAAEyjy84kwPI/mK38Ntuc2gds7/At5FQdVQc
         +C4q8k2pH38h7ZMS4igmfZH0uN/0h923tR6tNvOl1Fb9v+fuSqRVdRjnKq+qlhBi67
         xH5Z+MfPtnex/MQ0l9KQGx9XuaVFC/MT8uvTPCPPkqFvJ5e4+uhhV3TRXJpJyf9PTJ
         Y8pbYnHZm7PaeIxJtjPJJJlmTI+ZVqg7ZRoGS+hNNRrLU7v5q3NC0+lf6NmwRz05ps
         2xVbJepD2aIT/jNN1el2wxN49jYGLdZDsdzaZ4HZ3vTcjTjim1JEXtETf0Bmybqfhh
         eEomFxjr2gLCg==
Date:   Tue, 9 Jul 2019 13:30:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        asahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: build failure after merge of the rdma tree
Message-ID: <20190709133019.25a8cd27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dHZ61SP4nfg2f27kLX5QSWg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dHZ61SP4nfg2f27kLX5QSWg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rdma tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from /home/sfr/next/next/include/rdma/rdma_counter.h:12,
                 from <command-line>:
/home/sfr/next/next/include/rdma/ib_verbs.h:2126:27: error: field 'port_cou=
nter' has incomplete type
  struct rdma_port_counter port_counter;
                           ^~~~~~~~~~~~

Caused by commit

  413d3347503b ("RDMA/counter: Add set/clear per-port auto mode support")

rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
from rdma_counter.h, but it is not defined yet :-(

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 9 Jul 2019 13:17:49 +1000
Subject: [PATCH] RDMA: don't try to build rdma_counter.h for now

rdma_counter.h include ib_verbs.h which in turn needs rdma_port_counter
from rdma_counter.h, but it is not defined yet :-(

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/Kbuild b/include/Kbuild
index 78434c59701f..8dab85cdf4f4 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -939,6 +939,7 @@ header-test-			+=3D rdma/ib.h
 header-test-			+=3D rdma/iw_portmap.h
 header-test-			+=3D rdma/opa_port_info.h
 header-test-			+=3D rdma/rdmavt_cq.h
+header-test-			+=3D rdma/rdma_counter.h
 header-test-			+=3D rdma/restrack.h
 header-test-			+=3D rdma/signature.h
 header-test-			+=3D rdma/tid_rdma_defs.h
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/dHZ61SP4nfg2f27kLX5QSWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kCksACgkQAVBC80lX
0GyA6Qf+P1ofM482Lg/qG/3VmyWW9WbsLIZZyT7Y3fsxL8oyCCQDhfLficQ8RXkO
K2DkUtJ9SmpyaDZgz0k8k69PSy1mcHrOUcWb97d7RVnS/+5U/mMvLf6BrHivFla2
U3/zRz+aSYPmKbOCMkuIGcXt7EqxN9UXB28pR6oMx0ZWzH/wbTeen4aGjV2VG4hC
OcOGL0zolz0s9W/gu48qP2rtnS0H1tT8jUwoOyq+rF29FMk5ibsKXx1QX1n/oe7z
QPtDhJMu75ykJ+hON7wt1d/DA5vFcvBVFXUprTDEbrM5idAD8hVbDrBNqCUZ8RLM
sOK/xo9RZC0xKcg0gdDJLFDbaIasUQ==
=k7wb
-----END PGP SIGNATURE-----

--Sig_/dHZ61SP4nfg2f27kLX5QSWg--

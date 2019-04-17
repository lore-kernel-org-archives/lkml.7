Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD5C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FE4206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RsbKzmNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfDQGn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:43:29 -0400
Received: from ozlabs.org ([203.11.71.1]:59073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfDQGn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:43:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kXkM0ky5z9s3l;
        Wed, 17 Apr 2019 16:43:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555483406;
        bh=nQMn0ADDxUez1Q8NZEeVVQ543pRr80qCQpJAewSbLBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RsbKzmNkfekBbFCJH1f/s/m5U9Iabb7PC9i3Pi+Xm6ubMdINLnwNA3kSvyB6jmyww
         4RlYZRFF8kuP6+Km81vzZ8YkZCraEzVBKpaHnYA9ey/vlh3GwBZ8NdhroAJInfZil6
         qfRdMfJAY7ttlRtev1eFN8ZLILC9BAfW3D7DDvpSWEKmEzxMzCbUQBOTrUq4sD/Z5b
         8uh/xBac0g1wTop2PnCQ2ChKmbIJ4ossTEhKHvZIq4I8Awng+uD/THCsv/q0osASvA
         FT/eKBw0HL9MNaNocIMxzYRtqwbAOEein8IXY3Yu5cOwk/opvetQHjL87jm8txadDf
         VTrxnd0ydEAvQ==
Date:   Wed, 17 Apr 2019 16:43:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190417164317.3b9cd9e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tzk/XQ9FMReknp.btOTZ+sf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tzk/XQ9FMReknp.btOTZ+sf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

mm/vmscan.c: In function 'snapshot_refaults':
mm/vmscan.c:2969:14: error: implicit declaration of function 'lruvec_page_s=
tate_local'; did you mean 'lruvec_page_state'? [-Werror=3Dimplicit-function=
-declaration]
   refaults =3D lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
              ^~~~~~~~~~~~~~~~~~~~~~~
              lruvec_page_state

Caused by commit

  3c1fea8fbdf7 ("mm: fix inactive list balancing between NUMA nodes and cgr=
oups")

I applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Apr 2019 16:40:02 +1000
Subject: [PATCH] fix "mm: fix inactive list balancing between NUMA nodes an=
d cgroups"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b828aae50d37..d545ace5e177 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2966,7 +2966,7 @@ static void snapshot_refaults(struct mem_cgroup *root=
_memcg, pg_data_t *pgdat)
 		struct lruvec *lruvec;
=20
 		lruvec =3D mem_cgroup_lruvec(pgdat, memcg);
-		refaults =3D lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
+		refaults =3D lruvec_page_state(lruvec, WORKINGSET_ACTIVATE);
 		lruvec->refaults =3D refaults;
 	} while ((memcg =3D mem_cgroup_iter(root_memcg, memcg, NULL)));
 }
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/tzk/XQ9FMReknp.btOTZ+sf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly2ywUACgkQAVBC80lX
0GyyHAf8CK1k86+gh7EQuFkSbJeHDMfyyEqt1D8iU0d3HlEIy2ohewAjsFa2vfa7
YwfEwlJDScqggKIRI03wgSNiy+XkUBG8dFg1Gx4PCbKJdTx+oI40JtCCEkgamAh+
AD5kvT/GfDCZRJdOFFOsifwUQcmDOiEKwCCDdtzvQ4v02J1Klh5VgMJA3TE2eBEw
R5FIHimuCBVJ2utJKbC0qLGYcZKql1BUYzbg3LmZe/jeasSQEIZ0eMHWj7N0l7gg
ip41fvNdNvIVLlkfq85ISBkIz720wZH/mRw1daFwdkEjv7iDeZrLyLuKm3dC+0lJ
KqX3uDqjB17J7sGIZzZ/BumLtzrwHw==
=mPmR
-----END PGP SIGNATURE-----

--Sig_/tzk/XQ9FMReknp.btOTZ+sf--

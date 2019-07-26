Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23276C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC2E22C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i0R1S6iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfGZE2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:28:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53263 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfGZE2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 00:28:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vwzw0JYCz9s3l;
        Fri, 26 Jul 2019 14:27:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564115277;
        bh=eznFIvIPYA4X4efAisKJ54XEx47EMDOidAgKAGE6htk=;
        h=Date:From:To:Cc:Subject:From;
        b=i0R1S6iALT/spEdUnRsehgoskeZLjArAzeyxlyaUuEOohNiDzmnw2hyJ/FxHLJBoL
         NNbUURMemRUc/mBPK9iYEZNPxWpjH432cKmAl1Tl5pRmzaskvU81UTPm+L2BKuVrzF
         RBfc8oEROOn8A5dO6LpkYJzMNZasKx3F/TMG6A+LRgt+zaXy8wecIRwVTRzckN0Etr
         BURiSoGU0E8ibqq58dOwtm5xX1iAPH3e5KTUXGGlDHyF+v0xmIHZ4wsZZMcdOlWJNa
         LGan46fn5v7rBT/FDSdqs5O359Svz3Rxqr7VVrS6z/lT0uFCA5uPSLthzg+soUhziI
         ooiwr3IqRJbjA==
Date:   Fri, 26 Jul 2019 14:27:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190726142753.452375e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wMjnqamB0BbHipDk_HXzVTy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wMjnqamB0BbHipDk_HXzVTy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

mm/madvise.c: In function 'madvise_cold_or_pageout_pte_range':
mm/madvise.c:346:7: error: implicit declaration of function 'is_huge_zero_p=
md'; did you mean 'is_huge_zero_pud'? [-Werror=3Dimplicit-function-declarat=
ion]
   if (is_huge_zero_pmd(orig_pmd))
       ^~~~~~~~~~~~~~~~
       is_huge_zero_pud
mm/madvise.c:373:7: error: implicit declaration of function 'pmd_young'; di=
d you mean 'pte_young'? [-Werror=3Dimplicit-function-declaration]
   if (pmd_young(orig_pmd)) {
       ^~~~~~~~~
       pte_young
mm/madvise.c:375:15: error: implicit declaration of function 'pmd_mkold'; d=
id you mean 'pte_mkold'? [-Werror=3Dimplicit-function-declaration]
    orig_pmd =3D pmd_mkold(orig_pmd);
               ^~~~~~~~~
               pte_mkold
mm/madvise.c:377:4: error: implicit declaration of function 'set_pmd_at'; d=
id you mean 'set_pte_at'? [-Werror=3Dimplicit-function-declaration]
    set_pmd_at(mm, addr, pmd, orig_pmd);
    ^~~~~~~~~~
    set_pte_at

Caused by commit

  d6d92199f211 ("mm, madvise: introduce MADV_COLD")

I have reverted (I assume the first four depend on the last):

  674db9810e45 ("mm, madvise: factor out common parts between MADV_COLD and=
 MADV_PAGEOUT")
  5bd341efe8f1 ("mm, madvise: introduce MADV_PAGEOUT")
  c487c618dcf1 ("mm, madvise: account nr_isolated_xxx in [isolate|putback]_=
lru_page")
  1ef762b1c799 ("mm, madvise: change PAGEREF_RECLAIM_CLEAN with PAGE_REFREC=
LAIM")
  d6d92199f211 ("mm, madvise: introduce MADV_COLD")

for today (as - I just noticed - is suggested in another email).

--=20
Cheers,
Stephen Rothwell

--Sig_/wMjnqamB0BbHipDk_HXzVTy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl06gUkACgkQAVBC80lX
0GwmXwf+NZDtexWwtKCnv5EVOtaQgzzfUx4jd15WSCLC/tuKeM2Lj0n6JBOXM1mz
pvOpVc9tutNJktghtdo1Yqzf5RsK/ebaLW+x2msgMLRlxaUc7kNaPvITrc0BqHK6
aeX1HMf31y2Rj697vTUFYYNa7Zcz+FOwoRCY23KhLySeaygjg45p+2lyBNDMQ/7T
Tv9MHXP1xCLAkbnGRIdS61QRzM7+7b8wguQk/DND83lQwxT7onD7TRazlQdhurol
WVoh8nGaOuJQH++EeWXw9TYuBvjP0cPoa6kO6xwXPkvC4U+fNrx2aM2ze0eTFW7x
j+70m9T4C1rnJY0XRUNUIeDltGT6YA==
=aWB+
-----END PGP SIGNATURE-----

--Sig_/wMjnqamB0BbHipDk_HXzVTy--

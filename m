Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDDAC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C419720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CO/mKSBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfG2DsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:48:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfG2DsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:48:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xlym5739z9s3l;
        Mon, 29 Jul 2019 13:48:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564372096;
        bh=cmM63/7lK54E3ACi1o07jmlKAFIfgPMeQr3s68YCImo=;
        h=Date:From:To:Cc:Subject:From;
        b=CO/mKSBpC586w5dX9nCV+WiPH+BtkscrI7zy63mgqzwLhH1dnQrRcqSkcXLhDAtdy
         vMfu1Uv+CBR9sNXcEA8oTwoPUAQdSeDeKSoJXQk+MKV3TQwi0MCxWQA/rpceEcv04j
         BZkY/tnNTUuqAyyNQKKk7l0tlSysmkrpT+MydWShslh/61jXsDfL/ERVPjHtZNFaU9
         k2Pj4k3luLHioNKMlvNESM3vfCsm8jpDYktyEXxas0likrIuMUf7SN0BFd/zChz0iM
         5U61cd411CrhiOr/nlcLsm9oMWl/MvydZYoPeDkItjZ/5b1tsF3jdmITOxr7yOMT4S
         9urSWkvJSiR6A==
Date:   Mon, 29 Jul 2019 13:48:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190729134816.605ff6d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HS1=9Lb1rBLiOXqtGdl+4Uy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HS1=9Lb1rBLiOXqtGdl+4Uy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/infiniband/sw/siw/siw_mem.c: In function 'siw_free_plist':
drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused variable 'p' [-W=
unused-variable]
  struct page **p =3D chunk->plist;
                ^

Introduced by commit

  63630f9a8d72 ("mm/gup: add make_dirty arg to put_user_pages_dirty_lock()")

--=20
Cheers,
Stephen Rothwell

--Sig_/HS1=9Lb1rBLiOXqtGdl+4Uy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+bIAACgkQAVBC80lX
0GxIRwgAhvQSTAktG/+8HkyBrP7E5e1K/hKmwNC8I73HcqFshHmLrRWGmkDf1st1
81B41pvjWDMbqEOPcpUCR9mFF/uJ1mTusVgmP/05xQzF74/JV0Zp/nDcsNhJOwWW
NWt17WOwAF8/TlmT+4gis5wIj6ZbK/UsTYoKW61JQH1+eVOD7269SPByb5YH62sE
5NX3zYt+/nqyzaVSPBX3v03RA1dFtM82Jb2CFzLMbEHiBnbXqTsdJ4hJyQ3p7haP
GXq2jii1pqiYl/Js0tQ0J2galrIrV/DTALKrY95wouUK5cTe6YkrtZFVO26nzfY0
fEUsAEg0NjS+lW4MIw8daD3wQubQzA==
=AjZl
-----END PGP SIGNATURE-----

--Sig_/HS1=9Lb1rBLiOXqtGdl+4Uy--

Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8925DC48BDF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCE6214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GWJtBALX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfFTBlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:41:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfFTBlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:41:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Tl0R43Rpz9s5c;
        Thu, 20 Jun 2019 11:41:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560994887;
        bh=WGOTRMBeLBmilogT0tIxAInw7Nr8PQY7ILBf8vwykm8=;
        h=Date:From:To:Cc:Subject:From;
        b=GWJtBALXVOruaEH4fhJt870lXQSSdBxlNSmRpYwTzc3YoAxihz+BACTpZV5jYjTY3
         lnc7TPILbA8hs5zMx1pa+O3IX9cOrxlkSK9YYWkzndGZ75Ltz/yPapB7dnJFBDP/yj
         2N99Xm9eG2XmNlNXl+xe9xSnhaE0i08yzNiZiBOZn+YDlMV9a3qmVs/6CdrIngPlBM
         ZlGueeupZBj/WNZ9wFA8tl858tE1rRHf6fpISofvj82JP6d0SAocJcT4XD85ITLhpV
         5iCTWwkv63St7uQeqL41l9NTfNuLs9ZrMS4o3XJ/WVU/9uIdtwkcCNBahne66s36zK
         wen89ka/be5oA==
Date:   Thu, 20 Jun 2019 11:41:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: linux-next: build failure after merge of the fbdev tree
Message-ID: <20190620114126.2f13ab9c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d82EgSM/EAI_ZmuqNlG4tHm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d82EgSM/EAI_ZmuqNlG4tHm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fbdev tree, today's linux-next build (x86_64
allmodconfig) failed like this:

x86_64-linux-gnu-ld: drivers/gpu/vga/vga_switcheroo.o: in function `vga_swi=
tchto_stage2':
vga_switcheroo.c:(.text+0x997): undefined reference to `fbcon_remap_all'

Caused by commit

  1cd51b5d200d ("vgaswitcheroo: call fbcon_remap_all directly")

I have used the version of the fbdev tree from next-20190619 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/d82EgSM/EAI_ZmuqNlG4tHm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0K5EYACgkQAVBC80lX
0GwMDgf+PY58cbMSpretI0KZAamybNU96+QSAj9P6Ah5dZgzJTREF0w3mrvb9+Gq
HCYLQGPIaaoZJyVE4xUGfKaUJfeFavUGTHLfqeRBNjrHNMWERA3az7p97KTNcmNU
kKLzeIJ/bSWki+9a6VQ8ebrjr0R7it/f1EU8obNqL0rc5xLYlm8NnEtvvg8famwS
TuPlpXvOkyb94/E/sJjelWRnt4S7Db1FJXeuUHRDBdCk40gkR/eYsppOU6SxKMDf
NZSMFcumB1RiE38d9e9fASIAyCr7mw8b+J0btLNG0hn/EKK3A2iCyZRh3ksKmADI
OUTdvEK1tXjUMM0ccCrO/lUB6InSHA==
=etdo
-----END PGP SIGNATURE-----

--Sig_/d82EgSM/EAI_ZmuqNlG4tHm--

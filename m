Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F4C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB3220880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 04:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FOCz9PUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfGPEbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 00:31:25 -0400
Received: from ozlabs.org ([203.11.71.1]:54243 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfGPEbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 00:31:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nnXW1hQVz9sDQ;
        Tue, 16 Jul 2019 14:31:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563251483;
        bh=pTcKZ8WGITRcN7hoLC31zCeTJhydGo5fa6HBdaxi/WQ=;
        h=Date:From:To:Cc:Subject:From;
        b=FOCz9PUSJRTSnzKm0/k/0rW5Tnx87LL9JevtSgRLEtdLfS9wOe2NxMzNfL958SZAF
         hUjpiN60hORwWhyqak6zHMUwId+GhxUThnIxilNaGQ6Kc5DFUWV4n7PJtFjNoW77if
         wkJmPPS2ocm3VtUM0Zf2dlCMZgVjP6SBEwZXCzs+wse0G1DnD/BRSf/Gfd7aBNjcBO
         OsdrfobOcqYwUOeTPnT10gSMEw4Rqy5WKNgATt2S2JTlAsWin0kba8d+ZRF9cmg+uU
         UcKN7vlgTiqkbspGUPE/bUarPh05aFkgGO8UJHDVb8YJY/tYkAUTxOlbvmYRvFmImo
         Kczt4qa5GVtCg==
Date:   Tue, 16 Jul 2019 14:31:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190716143121.3027ef58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B2rQDOIA2FwcxfwTX_Z_HSw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B2rQDOIA2FwcxfwTX_Z_HSw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (x86_64
allnoconfig) failed like this:

make[1]: *** No rule to make target 'modules.order', needed by 'autoksyms_r=
ecursive'.  Stop.

Starting with commit

  656c0ac3cb4b ("kbuild: modpost: read modules.order instead of $(MODVERDIR=
)/*.mod")

i.e. after reverting just:

25a55e249bc0 Revert "kbuild: create *.mod with full directory path and remo=
ve MODVERDIR"
15657d9eceb6 Revert "kbuild: remove the first line of *.mod files"
8c21f4122839 Revert "kbuild: remove 'prepare1' target"
35bc41d44d2d Revert "kbuild: split out *.mod out of {single,multi}-used-m r=
ules"

I get

cat: modules.order: No such file or directory

near the end of the allnoconfig build (but it does not fail).

and when I remove 25a55e249bc0 i.e. stop reverting

  0539f970a842 ("kbuild: create *.mod with full directory path and remove M=
ODVERDIR")

the build fails.

So, for today I have reverted these 4 commits:

  56dce8121e97 ("kbuild: split out *.mod out of {single,multi}-used-m rules=
")
  fbe0b5eb7890 ("kbuild: remove 'prepare1' target")
  008fa222d268 ("kbuild: remove the first line of *.mod files")
  0539f970a842 ("kbuild: create *.mod with full directory path and remove M=
ODVERDIR")

--=20
Cheers,
Stephen Rothwell

--Sig_/B2rQDOIA2FwcxfwTX_Z_HSw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0tUxkACgkQAVBC80lX
0GxWUQf+PfOOmG278suiqMlQn3x6BuBZoupmKmMHMF3J/rkYUEtmO+yJDMz6hbph
luK+9DY5QJJf1dCkCg3z2AuXhJktof5lLME/a6D4eKnYg19s9x/FCw+hMUvFad3/
rv73ojQIBZxlBVGWx0ZuzqGZWtuSNlXYuywWxVwmN5rTzb1YeJ50VsjjbUNz7G58
V9gieh/dLKa5wfZSljHKrW4GQl7KNL7VZf3fRO4Xll4mnoH/EjOsLMRnU0nKhEhC
HnrzZeiNqGue7fquYPKnmzZZPjNELyC7B2ibBDTbt7kbgX1BfUAczwmM8pOGzzPv
CDWLTIkwhdXTv6ebkl3gx3HSxddo+Q==
=+L0I
-----END PGP SIGNATURE-----

--Sig_/B2rQDOIA2FwcxfwTX_Z_HSw--

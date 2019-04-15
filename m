Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C60C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 04:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C540D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 04:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A/XIP1DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfDOEZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 00:25:18 -0400
Received: from ozlabs.org ([203.11.71.1]:34903 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfDOEZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 00:25:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jFlv1bvkz9s4V;
        Mon, 15 Apr 2019 14:25:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555302315;
        bh=jIGDOzcg1VknLsp1W9gQh8oPM0ykbt5wqZL2oYrPQtM=;
        h=Date:From:To:Cc:Subject:From;
        b=A/XIP1DKKB3QWNnGYcgxPIKL69FuLlWTivRF26AyWJ+Qln06VlaNvuU4g7jGhxCda
         29b7Q0NWGU6zHSymZKapeybkWWo/eBp6wz//GF5JSAiJ7bNd30AHiwqMMUnmkSlZnE
         Q+YSTI/h9PBvjpLH91nz5auvab5iS1k0s0+ocW1OqkuAE8z9EVu4ceEwzf1M8SeyoW
         IhgVvRN7itdfETEd+XReLbFQOqK8NXZYCco8O4Rjh9VhnoeE24xE2EYQ9y4j5m94zV
         OozJHV+PlJtoBUCKRw/n9tEiHJzes5y+mwPM29Y6WnF1YxYgu0aSFp2113V5bSAJ8J
         AXK0FNGemUF7A==
Date:   Mon, 15 Apr 2019 14:25:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@lst.de>
Subject: linux-next: manual merge of the tip tree with the arm64 tree
Message-ID: <20190415142514.6ca10bb5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wX+6k_R044lb2vPVfl5Eeod"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wX+6k_R044lb2vPVfl5Eeod
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  mm/kasan/Makefile

between commit:

  e2092740b723 ("kasan: Makefile: Replace -pg with CC_FLAGS_FTRACE")

from the arm64 tree and commit:

  57b78a62e7f2 ("x86/uaccess, kasan: Fix KASAN vs SMAP")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/kasan/Makefile
index f06ee820d356,613dfe681e9f..000000000000
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@@ -5,9 -6,10 +6,10 @@@ UBSAN_SANITIZE_generic_report.o :=3D=20
  UBSAN_SANITIZE_tags.o :=3D n
  KCOV_INSTRUMENT :=3D n
 =20
 -CFLAGS_REMOVE_common.o =3D -pg
 -CFLAGS_REMOVE_generic.o =3D -pg
 -CFLAGS_REMOVE_generic_report.o =3D -pg
 -CFLAGS_REMOVE_tags.o =3D -pg
 +CFLAGS_REMOVE_common.o =3D $(CC_FLAGS_FTRACE)
 +CFLAGS_REMOVE_generic.o =3D $(CC_FLAGS_FTRACE)
++CFLAGS_REMOVE_generic_report.o =3D $(CC_FLAGS_FTRACE)
 +CFLAGS_REMOVE_tags.o =3D $(CC_FLAGS_FTRACE)
 =20
  # Function splitter causes unnecessary splits in __asan_load1/__asan_stor=
e1
  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63533

--Sig_/wX+6k_R044lb2vPVfl5Eeod
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly0B6oACgkQAVBC80lX
0GyX2gf9Ezi7gad1MlJbVog/pBu5QtRlNTm0FQ3wCKyxWAaRzzZ+Yi10e9eC/QDi
N/GLwmBmNAchgFpXBEn3rOyZZVRVuIH831aeFQKCesOwbQ6IFxY5LUzRlE48Ciov
d01NeWpszocpH/eEsHd7+LdMGqtd3j+1GO9hZkE5U0mCdGe4SekEutdzTIPiPxa+
UGlbhV9v+1D9vwB5kGrd7dyY+EMvGeO18VwiEvh0aPgPwOAqCLTj+HWumwLJB2of
gwQLAi0eZvytYYvjdD/rhsrz1vllglN+MU4aSwDTkNP50kHch0XlePXNfctmt7hi
ZO0WUKvQr1pu5oK9uxSjmMUfxeewfg==
=Ybqa
-----END PGP SIGNATURE-----

--Sig_/wX+6k_R044lb2vPVfl5Eeod--

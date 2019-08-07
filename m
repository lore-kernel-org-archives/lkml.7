Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE2C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E4421BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P3QXnbnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbfHGHZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:25:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48951 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbfHGHZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:25:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463NLv5B9Wz9s7T;
        Wed,  7 Aug 2019 17:25:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565162711;
        bh=vVaulL6R8jTRIZm2zjrx7VPWh+61oTTSny6ytagxAb8=;
        h=Date:From:To:Cc:Subject:From;
        b=P3QXnbnC0AcEo+jwRQ+3JGeIZakTjqJw5j63nn3apCZfU5HQwGWO/gADh2LJZHeHb
         n80aWNrUAk7plVwcpRPQYU2H3k8jR20abrky8aG6/LqGvh/WUVfgWSFJaRFjWtfkSJ
         MZ1D894y9SVb8baJILV+BCJzW6lOWNrGi1DIFGU9cqVhNmOxHY5DDmoFxCHY19F/zX
         7VAN0Oy5N5ymH0Nsxm8bvOo2gwyeERamRVeOicQNy/TeQ6891gohHFaKX7dLepA+IY
         x0qVjrfoEtwrbg0y87Pj2Tw5K/6aPj7faiqxXMueZ55HT2rz6/kzMkTJf/O4JNTf6q
         /uzr+A6ahilGg==
Date:   Wed, 7 Aug 2019 17:24:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190807172454.2e887f7c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2+3v=MCwWHizqxvpKYivTlY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2+3v=MCwWHizqxvpKYivTlY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/kernel.h:11,
                 from kernel/events/uprobes.c:12:
kernel/events/uprobes.c: In function 'uprobe_write_opcode':
include/linux/compiler.h:350:38: error: call to '__compiletime_assert_557' =
declared with attribute error: BUILD_BUG failed
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:331:4: note: in definition of macro '__compiletime=
_assert'
    prefix ## suffix();    \
    ^~~~~~
include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_a=
ssert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_=
MSG'
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^~~~~~~~~~~~~~~~
include/linux/huge_mm.h:272:27: note: in expansion of macro 'BUILD_BUG'
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
                           ^~~~~~~~~
kernel/events/uprobes.c:557:39: note: in expansion of macro 'HPAGE_PMD_MASK'
   collapse_pte_mapped_thp(mm, vaddr & HPAGE_PMD_MASK);
                                       ^~~~~~~~~~~~~~

Caused by commit

  9cc0b998b380 ("uprobe: collapse THP pmd after removing all uprobes")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/2+3v=MCwWHizqxvpKYivTlY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KfMYACgkQAVBC80lX
0GzHKwf8DoHJy2/O8OaqyNqoVhJoRgbm4E/xCgjFzmzlhlEM49WVrZaswYNWWPar
pLGdBeojZq8fqQ0cY5RtxpJz/ETwWy780VNYhUKqtK7R8IIgbxFUlV7skspFo+4d
plkJclGSSR0v4IpW+b+fVkhesncryry6VsT4vJgIt2ufsUhQIxI8oLi5lkNasq87
kQskCnPwP+fRzfoJeWBGD0UynIT7VpnA1k8qG1f/4UXKyoLxBnVkXOzqfCgAkF8Q
9dMT0DMYu3JHq4OrJtI0KcEmdr5ytTmLeIT6wR5+dJaXIhODWoR1qTpYzaCYfLqB
y6fQCYV4KU+DdvbMYp4ocyUykcdKBA==
=uh5O
-----END PGP SIGNATURE-----

--Sig_/2+3v=MCwWHizqxvpKYivTlY--

Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4304DCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173112086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R87V6UQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfJUVHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:07:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUVHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:07:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46xq3C3xCSz9sP3;
        Tue, 22 Oct 2019 08:07:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571692056;
        bh=pWe9VsFRQMV5crZi/BoRRCzFy5+IboAIVfcQQ7DGp6I=;
        h=Date:From:To:Cc:Subject:From;
        b=R87V6UQ5J80OIucGaxPcct/zIiRHB+oJ9qkCTXaR//sKBknUHeiz3UQEnYY6cycLn
         jeSO2Wi75FKTeB70cbBai93HvgZBmdgyWhNnuN9z1oB87kamQIKUZCE3cniN3p1gnk
         A8Dg2TZkakoPgYXYJcyF/sFi1LMmYhV+4djbYokQtti/Ksur/Qwi4Id8Al0ChQ/Yi4
         6aJmLG115oV26NwrUkkHpTl07RXlxg7HWColy41iLpSAk9vOaTwZW0U9qDCXgYd4So
         2GZXT5f02+QVKeCpyv7vPZ9LtSIcrwDvht8T73xVowfjsPVYiteUH0oR+5v1kZvHXS
         FY8UjJcS2YdVw==
Date:   Tue, 22 Oct 2019 08:07:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guillem Jover <guillem@hadrons.org>
Subject: linux-next: build warning after merge of the drm-misc-fixes tree
Message-ID: <20191022080734.41955464@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7+Mx3FL7wh_1DROrLXtWV4P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7+Mx3FL7wh_1DROrLXtWV4P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc-fixes tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/limits.h:6,
                 from include/linux/kernel.h:7,
                 from fs/aio.c:14:
fs/aio.c: In function '__do_compat_sys_io_pgetevents':
include/linux/stddef.h:8:14: warning: initialization of 'unsigned int' from=
 'void *' makes integer from pointer without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^
fs/aio.c:2196:38: note: in expansion of macro 'NULL'
 2196 |  struct __compat_aio_sigset ksig =3D { NULL, };
      |                                      ^~~~
include/linux/stddef.h:8:14: note: (near initialization for 'ksig.sigmask')
    8 | #define NULL ((void *)0)
      |              ^
fs/aio.c:2196:38: note: in expansion of macro 'NULL'
 2196 |  struct __compat_aio_sigset ksig =3D { NULL, };
      |                                      ^~~~
fs/aio.c: In function '__do_compat_sys_io_pgetevents_time64':
include/linux/stddef.h:8:14: warning: initialization of 'unsigned int' from=
 'void *' makes integer from pointer without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^
fs/aio.c:2231:38: note: in expansion of macro 'NULL'
 2231 |  struct __compat_aio_sigset ksig =3D { NULL, };
      |                                      ^~~~
include/linux/stddef.h:8:14: note: (near initialization for 'ksig.sigmask')
    8 | #define NULL ((void *)0)
      |              ^
fs/aio.c:2231:38: note: in expansion of macro 'NULL'
 2231 |  struct __compat_aio_sigset ksig =3D { NULL, };
      |                                      ^~~~

Introduced by commit

  de80166a573d ("aio: Fix io_pgetevents() struct __compat_aio_sigset layout=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/7+Mx3FL7wh_1DROrLXtWV4P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2uHhYACgkQAVBC80lX
0GzAWQgAghqJx0OCN3Zexk2nGXPMhdOhx7kvE/o/p1ktaIlP5yR3YCiVvvBxr66I
FPnka6qfPHPwHSiDi8364tABAyezb+YpKKGMk1DkFjhmHPo8ST0/WloTYz3+PjF8
JpXpii+n/Z7/lp1oLh8ZeXxxyng9DS0viDC0Xctr2H6Hp5efXTcJIFBATfCtAcaa
ewlckCUY4T3e2J/BUVRzwY5ZzgkJZ02u8Whkm0r2KXG+XJmSEgA5Y6KrU6YN0BoR
SJ0i8tkFCTD1i3oBdFbROWlEyEH482mbJX7Uo5JIUs64VTyhopYPIH+WR2EmqQ02
Vs+ulLLAiuz7RUXQRTPEKEWehG1QKg==
=gXoK
-----END PGP SIGNATURE-----

--Sig_/7+Mx3FL7wh_1DROrLXtWV4P--

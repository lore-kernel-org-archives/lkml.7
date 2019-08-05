Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C86C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AE82086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfHEJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:47:22 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39898 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:47:21 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B586772CCE6;
        Mon,  5 Aug 2019 12:47:19 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id A4B0E7CCE4F; Mon,  5 Aug 2019 12:47:19 +0300 (MSK)
Date:   Mon, 5 Aug 2019 12:47:19 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ptrace] 201766a20e: kernel_selftests.seccomp.make_fail
Message-ID: <20190805094719.GA1693@altlinux.org>
References: <20190729093530.GL22106@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20190729093530.GL22106@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 05:35:30PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: 201766a20e30f982ccfe36bebfad9602c3ff574a ("ptrace: add PTRACE_GET=
_SYSCALL_INFO request")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>=20
> in testcase: kernel_selftests
> with following parameters:
>=20
> 	group: kselftests-02
>=20
> test-description: The kernel contains a set of "self tests" under the too=
ls/testing/selftests/ directory. These are intended to be small unit tests =
to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt

The URL above also says: "Tests are intended to be run after building,
installing and booting a kernel".

Please build selftests with installed kernel headers corresponding to the
installed kernel.

Alternatively, tools/testing/selftests/lib.mk could be extended
to include uapi headers from the kernel tree into CPPFLAGS, e.g.

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..b5f4f0fb8eeb 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -10,6 +10,9 @@ ifeq (0,$(MAKELEVEL))
 endif
 selfdir =3D $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
=20
+uapi_dir =3D $(realpath $(selfdir)/../../../include/uapi)
+CPPFLAGS +=3D -I$(uapi_dir)
+
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
 # custom build rule and prevent common build rule use.


--=20
ldv

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdR/snAAoJEAVFT+BVnCUIs7sP/jUhARY/W13htwepsa3f2+cS
oGnLOyONvRN5qgEJKRFn1o/5FtTaEuc7Ym0V2zWZJBtPMWrzkYaulI279TS1iTkm
WKTbm6FDyPDLdXQh9zN1qt/UV/aLiRlBNjGZIuEKQ1RMWuaniTo8syAsS2Ooocpp
ahF/+0Xj+TS69hlhdjHMvJmn3pxVwgavU96ddejufZJi+OAt/KsZPQlNUjcefn4M
y9riqyajRwW5eRV8Fm5SRKhF481JW6i6Z4ej4ro38Hk+33BbJ21W/I1rR/aI5y3J
1uKiy+Eb08dmMpDVWtGKVEEHxbxpbd2Esc+mL9OWX2LJ+JwKR9ZYx0XYW5mxbsjL
UsshRoPTnADVUzc3olDAZQ9W1Gy01LIzNYLGHhfaOKL7vGZmAdzZ94Wl1Co7m16v
OvIX1sru+E2AnWjxnTa1BHCIA0puiImnYBfbvRV5F6kH42POdiZMnYfBKmgBHwom
Pa/WNRC4fSfHmjcreTPlh2WMuFSj7RdN030Tpbb7ypigL1O4FcbDMdbzwjK5Dzw9
ms9+06jx8pET2FiPmJ+ivvpqMzKowA/jgbsN0M6bY0ERqIY7uPQv47YWznH6JOIE
NAO3LvhyDOtj4ixI3qaI85uCMyRVttbS5mWMcnDJXMVxneWzv5ZOpmbHgdl1PpKy
4jUMo9ST6VEFtKzrq/5V
=F9r9
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

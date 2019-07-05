Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EECC4649A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501FE218BC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RGGuau4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfGEIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:31:38 -0400
Received: from ozlabs.org ([203.11.71.1]:35597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfGEIbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:31:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45g7Nh68pjz9sN4;
        Fri,  5 Jul 2019 18:31:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562315494;
        bh=+8dEVa9QNOdvFUEq8sFcyzUwGBanjYLMkbOx+A36zCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RGGuau4cyOx+l8fccQPOYrb5TKG7k/c0H3bvVb0An2ye43Alf1h/ahqsHqDVMk3Ur
         hhzFh/DiLLySEmGofyqzAF/AGVQ91ZzhHw/1Ha1Sanb+Pv72Wl9T0ej3JeZ+W7LxjK
         ht0yDwi962p07TA1R3l/tTY2iYNIXQiFkHpjrBDrWxffpcMS/pQuvIaLTiDgjIb1he
         RDj2OL3a5g0FMESvya7Z2v7TCpIqHlgdmg/Ji4bQHr+C7aW8DB6GCxhDO9cKXR505j
         hItiD02spqNJudOaMCQOHoxPC8zEcrnVAmLTMubX3Pu1uvsKz7ch5zluGGDbuqgFaj
         XAnLEOBkatIbA==
Date:   Fri, 5 Jul 2019 18:31:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190705183104.6fb50bd0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ny3WjfBqFeBWAOFWZ7JQBF8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ny3WjfBqFeBWAOFWZ7JQBF8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (powerpc
allyesconfig) failed like this:

In file included from <command-line>:
include/clocksource/hyperv_timer.h:18:10: fatal error: asm/mshyperv.h: No s=
uch file or directory
 #include <asm/mshyperv.h>
          ^~~~~~~~~~~~~~~~

Caused by commit

  34085aeb5816 ("kbuild: compile-test kernel headers to ensure they are sel=
f-contained")

interacting with commit

  dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource I=
SA agnostic")

from the tip tree.

I have added the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Jul 2019 18:17:44 +1000
Subject: [PATCH] kbuild: only compile test clocksource/hyperv_timer.h on X86

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/Kbuild b/include/Kbuild
index 4f9524d92a75..a7ab060552c2 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -29,6 +29,7 @@ header-test-			+=3D acpi/platform/acintel.h
 header-test-			+=3D acpi/platform/aclinux.h
 header-test-			+=3D acpi/platform/aclinuxex.h
 header-test-			+=3D acpi/processor.h
+header-test-$(CONFIG_X86)	+=3D clocksource/hyperv_timer.h
 header-test-			+=3D clocksource/timer-sp804.h
 header-test-			+=3D crypto/cast_common.h
 header-test-			+=3D crypto/internal/cryptouser.h
--=20
2.20.1



--=20
Cheers,
Stephen Rothwell

--Sig_/Ny3WjfBqFeBWAOFWZ7JQBF8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0fCsgACgkQAVBC80lX
0GzP7gf+IhRYREYoLbajvJ0eJP6dSNxtX7JAt/glEA3NMG4vgp3sxcfYMbLueOhJ
z6tXnVCZE1UTvSti8dZMLfr4fAtyhnYxxdXHvim5nJXfku47A8vHPHeXWhyClKdl
wj601UvGNQw7TagngFshKfhzculu0YMDAc4RPOdd+dubhuiUvMzzIVXK/DvWyzB2
1seRp1jT1cCzjUOLXTzGv9UR3lF2hDPwnh9X37m+JmxxzzZ3PB/wBoxSD7vmVVzv
N0H5VU7NB6ZUmgHeU9/c8O6I18OHF06R3OulUq2Y0HhHGGzRcJT0TVG7atbNFAZ+
xTCFATmEb8fT99a5/7/OXnXSq0WEGA==
=nxCx
-----END PGP SIGNATURE-----

--Sig_/Ny3WjfBqFeBWAOFWZ7JQBF8--

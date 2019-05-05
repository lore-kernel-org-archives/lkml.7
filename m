Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE92C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F46206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BTAfr/Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfEEWkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 18:40:43 -0400
Received: from ozlabs.org ([203.11.71.1]:59239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfEEWkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 18:40:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44y16b4Prlz9s4Y;
        Mon,  6 May 2019 08:40:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557096040;
        bh=VsNBxC9WW9P/x5YaMgRvsuVTWQiQsb7AYnmIvAb6hVY=;
        h=Date:From:To:Cc:Subject:From;
        b=BTAfr/Y6H6Le9EVnumuOGl65RqSh0Vizu3Wl0LPKEjbtKVokRitcbJigjJeyGyaDz
         ipe7QhspM0gQnz3nTEfxKv/gyN51ZSn1ZyQIjkJQawLef6N6iW6PGXjHkTx7lbkgZi
         IH0WYkGJaxmxciCryETOjcxxN9jKyDTTbwFXQ4SzA8Oays2wfCr03Sg1kq1Jy+xuxV
         zfbYmoNbgWE2YaEtFZRvq4y/mzm3JK+s7WtxLztmfgv6IviXC3Z/0Ra/j8e70vwftC
         28wbD0kDDBXp3QvhEEv4F1S69/cDPhSgPv0TcVrrBWFEdyRMAECO/p94fGUXCA0vZF
         IznuHSYEcLpmA==
Date:   Mon, 6 May 2019 08:40:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        "G, Manjunath Kondaiah" <manjugk@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190506084036.5b6f9118@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NzQYtNnh15ga6P8Xh8q/xgA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NzQYtNnh15ga6P8Xh8q/xgA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

After merging the kbuild tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/module.h:18,
                 from arch/arm/plat-omap/dma.c:28:
arch/arm/plat-omap/dma.c:1452:26: error: expected ',' or ';' before 'DRIVER=
_NAME'
 MODULE_ALIAS("platform:" DRIVER_NAME);
                          ^~~~~~~~~~~
include/linux/moduleparam.h:26:47: note: in definition of macro '__MODULE_I=
NFO'
   =3D __MODULE_INFO_PREFIX __stringify(tag) "=3D" info
                                               ^~~~
include/linux/module.h:164:30: note: in expansion of macro 'MODULE_INFO'
 #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
                              ^~~~~~~~~~~
arch/arm/plat-omap/dma.c:1452:1: note: in expansion of macro 'MODULE_ALIAS'
 MODULE_ALIAS("platform:" DRIVER_NAME);
 ^~~~~~~~~~~~

Presumably caused by commit

  6a26793a7891 ("moduleparam: Save information about built-in modules in se=
parate file")

(since that is the only change from Friday, I thnk)

DRIVER_NAME is not defined and this kbuild tree change has exposed it.  It =
has been this way since commit

  f31cc9622d75 ("OMAP: DMA: Convert DMA library into platform driver")

=46rom v2.6.38-rc1 in 2012.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 May 2019 08:35:02 +1000
Subject: [PATCH] arm: omap: remove unused MODULE_ALIAS from dma.c

DRIVER_NAME has nevern been defined, so this cannot have ever been used.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/plat-omap/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index d4012d6c0dcb..4c6d9f4b43b7 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1449,7 +1449,7 @@ static void __exit omap_system_dma_exit(void)
=20
 MODULE_DESCRIPTION("OMAP SYSTEM DMA DRIVER");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
+// MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
=20
 /*
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/NzQYtNnh15ga6P8Xh8q/xgA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzPZmQACgkQAVBC80lX
0GyDwAf/SgYmPrtTF8+iUUauV0KdwI6l+a4qYYskl9tAgfH/axW6hQVf26j0aIic
55u/4T7IXQjAec6jxmv7XDxr2DVxh2P5T3SdSXk8cK8lwCRhSMsVi+IewcHerYaN
4Ckfh+oXYu90R9I+CjduPY8hKerB+90BUPHcW9fbNHO24iiuI+K+rYGzV1q5RuJV
AhYau2ZgLUg+yUcc6g7waN4LDdiop1yClQP8oF5wwavQk8jaIQGGJDO6cmejJ8U6
AUlYQePyun88mHa8Sk55h5NOxA1YWkygNHYEn+coQnjtGiVDc9pvbqK6Y0w7UeIo
H7kh7+4X7CJf3wQ9QpGpq8mA8OtuTw==
=k50I
-----END PGP SIGNATURE-----

--Sig_/NzQYtNnh15ga6P8Xh8q/xgA--

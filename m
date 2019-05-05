Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0603AC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19DE20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ijoH7YkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfEEXqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 19:46:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfEEXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 19:46:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44y2ZC2TmPz9s4V;
        Mon,  6 May 2019 09:46:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557099971;
        bh=hTFT0Y6e+s4SkN+Q2xznUmlp5g+w9Ave5x0gF5ycBbw=;
        h=Date:From:To:Cc:Subject:From;
        b=ijoH7YkEFIWEcXMBfMl2cv1GqU18jvbnYNyTID6TJ+BhX8cojMJ82q8r+SVggNyOK
         nZUJ0qLq6DoFK0Y/g2CUwyZOMcH0DxRdzPEwJt+q4o6QX8vvPmJMVfoG4hyUiqB+p/
         Bk5CuFW5KWt/f1b2Divvs0bUo7ZYoWYjE6PEf79oNsoiidnwMYuYNzMYpjU8vXcluv
         ddP5ZmJF81lyjqAyTi8xHF2CeDqHz+8Jn3HBXM1SOqzpGmC3ETGz2/V7u9f7qU3xPs
         Sj8jns6K0SqPOhIjHT9tCtxIUNYi0AIMivzHVljdmqxzOF1xojoSZW5Zcu20YKHbXa
         DmH+K88Xe58hQ==
Date:   Mon, 6 May 2019 09:46:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Keshava Munegowda <keshava_mgowda@ti.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190506094609.08e930f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CR4+aiKReV8EW1m/Ae3tHph"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CR4+aiKReV8EW1m/Ae3tHph
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

After merging the kbuild tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/module.h:18,
                 from drivers/mfd/omap-usb-tll.c:21:
drivers/mfd/omap-usb-tll.c:462:26: error: expected ',' or ';' before 'USBHS=
_DRIVER_NAME'
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
                          ^~~~~~~~~~~~~~~~~
include/linux/moduleparam.h:26:47: note: in definition of macro '__MODULE_I=
NFO'
   =3D __MODULE_INFO_PREFIX __stringify(tag) "=3D" info
                                               ^~~~
include/linux/module.h:164:30: note: in expansion of macro 'MODULE_INFO'
 #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
                              ^~~~~~~~~~~
drivers/mfd/omap-usb-tll.c:462:1: note: in expansion of macro 'MODULE_ALIAS'
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 ^~~~~~~~~~~~

Caused by commit

  6a26793a7891 ("moduleparam: Save information about built-in modules in se=
parate file")

USBHS_DRIVER_NAME is not defined and this kbuild tree change has
exposed it. It has been this way since commit

  16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")

=46rom v3.7-rc1 in 2012.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 May 2019 09:39:14 +1000
Subject: [PATCH] mfd: omap: remove unused MODULE_ALIAS from omap-usb-tll.c

USBHS_DRIVER_NAME has never been defined, so this cannot have ever
been used.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mfd/omap-usb-tll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 446713dbee27..1cc8937e8bec 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -459,7 +459,7 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);
=20
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
-MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
+// MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/CR4+aiKReV8EW1m/Ae3tHph
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzPdcEACgkQAVBC80lX
0GxRtgf/e4cAutpXCFPWNpdmLJnz0yR+k9CtPgawB6u1/5hoPk0nFrY6BSHplimw
R86/j8j4hVk03/XwtcaSFisjnzUgiNIM8+yVUMVYGtom+3xK/4yEn6PlWwYrl0HQ
lnizluSirfMH8ud7QqWxm2MqlCnVRSWJb3u+3JsiIcJCbKr723Us3HIKJZKh+S/u
+qw9zlpc9sU97BAY0nTxtUQTUuALqxPf/jyWz9gGOyvauumswYCos1JkUxs3ihj6
ha+ZIrygWOufUqtlaD5soxj1lGMvJayvv+tznMpA3EPlP0cQNl1GQHlT/ZUNLbxm
VjXqChR6XiteulrDomTgyTyIiI3ZeA==
=R5xM
-----END PGP SIGNATURE-----

--Sig_/CR4+aiKReV8EW1m/Ae3tHph--

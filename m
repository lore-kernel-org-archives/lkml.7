Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DBCC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11DA20B7C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 23:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BlVrgAae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfEEXgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 19:36:17 -0400
Received: from ozlabs.org ([203.11.71.1]:59403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfEEXgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 19:36:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44y2Lj0pyRz9s4V;
        Mon,  6 May 2019 09:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557099373;
        bh=2eo3/udFwFVXzB0YToq6HBtLtJk/Mqr/teWpVUnKI8c=;
        h=Date:From:To:Cc:Subject:From;
        b=BlVrgAaejFJs3m+ljd/B/QBlwIPz8UHhYOhzK9RXwFx92/khfjnhklyPm2QYvlnKD
         jchf9XHkyBnHQfl4bcL8zNoBh6nWvnA5tmNzh7cdzoYZZCbuaOpBhpEDQqyY6kuH2j
         pnxsXQF7GVGiWEw7DmtlhupcG+CVqf6sqpkxunzDvtXg3E+Z+KuB+hfAUGQ5TazxpM
         ijqNYgdJkGoPubJKGJpDd3BvCHeyCXb/5B9FRiSkISQPfzalvqNOpcoU+ZgXfYcKj5
         m//snEMuSV81b7H7qEMarRmPMxwh+FQ03S9WTpRcKpmnPw/YHBEBXHG8bmK27OHGh8
         n9GQoSgU3sLWw==
Date:   Mon, 6 May 2019 09:35:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Tarun Kanti DebBarma <tarun.kanti@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190506093553.29bae34c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dKOG3wgtOe87O4AvhMc3+p0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dKOG3wgtOe87O4AvhMc3+p0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

After merging the kbuild tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/module.h:18,
                 from drivers/clocksource/timer-ti-dm.c:40:
drivers/clocksource/timer-ti-dm.c:973:26: error: expected ',' or ';' before=
 'DRIVER_NAME'
 MODULE_ALIAS("platform:" DRIVER_NAME);
                          ^~~~~~~~~~~
include/linux/moduleparam.h:26:47: note: in definition of macro '__MODULE_I=
NFO'
   =3D __MODULE_INFO_PREFIX __stringify(tag) "=3D" info
                                               ^~~~
include/linux/module.h:164:30: note: in expansion of macro 'MODULE_INFO'
 #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
                              ^~~~~~~~~~~
drivers/clocksource/timer-ti-dm.c:973:1: note: in expansion of macro 'MODUL=
E_ALIAS'
 MODULE_ALIAS("platform:" DRIVER_NAME);
 ^~~~~~~~~~~~

Caused by commit

  6a26793a7891 ("moduleparam: Save information about built-in modules in se=
parate file")

DRIVER_NAME is not defined and this kbuild tree change has exposed it.
It has been this way since commit

  df28472a1b28 ("ARM: OMAP: dmtimer: platform driver")

=46rom v3.2-rc1 in 2011.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 May 2019 09:26:24 +1000
Subject: [PATCH] arm: omap: remove unused MODULE_ALIAS from timer-ti-dm.c

DRIVER_NAME has never been defined, so this cannot have ever been used.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-=
ti-dm.c
index ee8ec5a8cb16..b357bd56ba63 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -970,5 +970,5 @@ module_platform_driver(omap_dm_timer_driver);
=20
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
+// MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/dKOG3wgtOe87O4AvhMc3+p0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzPc1kACgkQAVBC80lX
0Gxr1Af8DKZ9JrIfv7exUvhT8Rcv4g4bDS9JEsr7MXHdqV9DckXWJWm1AKuUtdtr
mV4dDMj/P9xuQ6eJJWxXC9VM8nA5Z/GCgj/+BJaSZdQrcZjE3Q+keaef/yZH9bNG
BpCn2dtVLqXtMphYL5gCR3AZ/MZMr+/pZVcLH5P048In7Y/4nvSUCuuIzOnDJSJ1
cKbDrOaBC4zzfYemVRvUOFMfxgvC2NnZDtfnAuK9tUxLDCe+ROzVl7s4ABoMTm1X
IsLDl65ver+SXOsSp3AXtx6xdGXAdeGl9Mv+uamTsOEEQSYhgAwh68cG2Ag5MBKD
E0KSY5kgeu5BPcnSvK7h2BvFRuSmZQ==
=1jHs
-----END PGP SIGNATURE-----

--Sig_/dKOG3wgtOe87O4AvhMc3+p0--

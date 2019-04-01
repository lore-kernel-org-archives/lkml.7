Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA22020856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JCRx2uuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfDAXOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:14:35 -0400
Received: from ozlabs.org ([203.11.71.1]:35205 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfDAXOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:14:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Y7TM1t7sz9sSV;
        Tue,  2 Apr 2019 10:14:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554160471;
        bh=BJO2HAEuMHoZIX8nXsD4H5+LM40u4YlXGcSvEIkf9Rs=;
        h=Date:From:To:Cc:Subject:From;
        b=JCRx2uukqq0SBwEWjFFD6A15yMb5XtrBH/IQK+U2Kz0inWKD2XAWmzVRgoEnswX4P
         Ky2vfOGD1CSZZYmAwMKGxpBhzrrrlqreXQI/IjxAw7+ZEizPtDvadz2x4Tc7L6zxQu
         tN/QuDIELNNXpN5f8eINMfWUsX73XDb2G8NTFknR91Lg5BqK3C1wKfO0L7/3tjxyqO
         zfHIrSXOYJyaR0JBo5z0Dv5gGlWSFiDMY019wbqUgFaRg8ShyzE8brK6z5fEHnAqej
         UzvblmeQeBRiipSSye1Xq9zGhX3QUPeTiLvmnGVEW6PeBvRjzMxmoK8KUXIasvG3af
         Tq+CkCGZ+P+7g==
Date:   Tue, 2 Apr 2019 10:14:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: linux-next: build failure after merge of the nand tree
Message-ID: <20190402101431.6708cb70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SM73UD2MzyaV1d/mseq/PqO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SM73UD2MzyaV1d/mseq/PqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nand tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:26:5: error: redefinition of 'in=
genic_ecc_calculate'
 int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
     ^~~~~~~~~~~~~~~~~~~~~
In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: note: previous definition =
of 'ingenic_ecc_calculate' was here
 int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
     ^~~~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:47:5: error: redefinition of 'in=
genic_ecc_correct'
 int ingenic_ecc_correct(struct ingenic_ecc *ecc,
     ^~~~~~~~~~~~~~~~~~~
In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: note: previous definition =
of 'ingenic_ecc_correct' was here
 int ingenic_ecc_correct(struct ingenic_ecc *ecc,
     ^~~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:93:21: error: redefinition of 'o=
f_ingenic_ecc_get'
 struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *of_node)
                     ^~~~~~~~~~~~~~~~~~
In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: note: previous definition=
 of 'of_ingenic_ecc_get' was here
 struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
                     ^~~~~~~~~~~~~~~~~~
drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:119:6: error: redefinition of 'i=
ngenic_ecc_release'
 void ingenic_ecc_release(struct ingenic_ecc *ecc)
      ^~~~~~~~~~~~~~~~~~~
In file included from drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:14:
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: note: previous definition =
of 'ingenic_ecc_release' was here
 void ingenic_ecc_release(struct ingenic_ecc *ecc)
      ^~~~~~~~~~~~~~~~~~~

Caused by commit

  8278ad0d709a ("mtd: rawnand: ingenic: Separate top-level and SoC specific=
 code")

I have used the nand tree from next-20190401 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/SM73UD2MzyaV1d/mseq/PqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyim1cACgkQAVBC80lX
0Gxc7Qf7BDBnlFq4x0Gl/qDEcR1JZXDwErU+hl/CpawP7jzDIkej3XshiflwD3kb
csiQjVgZfRepy7ekZfGHHF9x1SPp6sYXZ+pOHzSbdzQYaTtyW+ubAdiu0G7asc2r
jVTABrp7BdrDlJVxopWl/hlSuV7rcIf2OYKTZIcr4q4ka6ZVe0LwJzphYF25GseU
nDGCLuaQvZQuZ1mHdAdrFiKsfGchrtnNBfMCRiBfWwWLFMO2OhOfEoZkRPCJyruh
xj3YlagoQuzA3bi+EAs+YvNUQ3MhkK+n6/p3qTeRIMFDK0ZMO/rY/bGKYmyXECeu
bg8+trV2gJUGkqoD6vUT3nPOzqTQkw==
=RsTs
-----END PGP SIGNATURE-----

--Sig_/SM73UD2MzyaV1d/mseq/PqO--

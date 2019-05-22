Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053EC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26E021773
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Dz6r/nx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfEVBBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:01:20 -0400
Received: from ozlabs.org ([203.11.71.1]:36947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfEVBBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:01:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457vTS2fZMz9s7h;
        Wed, 22 May 2019 11:01:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558486876;
        bh=lAww5DxAQLnInFkdZGsqPapfsSAWA2CdCh234+8lFuI=;
        h=Date:From:To:Cc:Subject:From;
        b=Dz6r/nx2h8yRsX/Kjer4WQH+rtSBD/v92zlS9KBUXjapxPgFyqfEWxd6hcUFVte4O
         pUqYUx/gvkeWiI2N0qLAZjtS/eqFMfFw0H6JzFYSg98r2bMThY05bjU34Hk/bcgMRv
         GJVRp2V58HWiTGiox1KdLSUHA4MhNdXIKfqkhwoEmKL5rrXzcFsji0VpZfXPLgcPBr
         qh31aQWvewR5SP3nSEn/CUON6gPhOq1R4tDuoOs+xoJlxP//T1D5ZNhhMnXnLtAUwA
         AdEJfb5h+C84rOL7YQjIQ0WrSniiJRPlHXFixoFATm+AVlPh58JVHC6epl9nNcO2MK
         pYJGqoN8tUYfA==
Date:   Wed, 22 May 2019 11:01:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190522110115.7350be3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9FpqtZ5yD8iO3LD4WECjyjC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9FpqtZ5yD8iO3LD4WECjyjC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pidfd tree got a conflict in:

  tools/testing/selftests/pidfd/Makefile

between commit:

  ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")

from Linus' tree and commit:

  233ad92edbea ("pidfd: add polling selftests")

from the pidfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/pidfd/Makefile
index 443fedbd6231,8d97cb35fca4..000000000000
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@@ -1,7 -1,6 +1,7 @@@
 +# SPDX-License-Identifier: GPL-2.0-only
- CFLAGS +=3D -g -I../../../../usr/include/
+ CFLAGS +=3D -g -I../../../../usr/include/ -lpthread
 =20
- TEST_GEN_PROGS :=3D pidfd_test
+ TEST_GEN_PROGS :=3D pidfd_test pidfd_open_test
 =20
  include ../lib.mk
 =20

--Sig_/9FpqtZ5yD8iO3LD4WECjyjC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzkn1sACgkQAVBC80lX
0Gzw9Af9E8+ptOFJWEcj9CvgKhaBwlug3cjhqiEcxYdTnLmbKU6B9vlyYvSEnnn+
hVm4Z0TZnXThT3bQcUo+euYoa5zXiTckwjjFW4zHwM0VXO/hhmI74d6d8RiVGzqQ
2tOn0X+wN+MagiE/E/tSh7aKBiQtX4r80Bq2u+hbZccRcI191QtdH6QsMPl7usYY
wVNP/fWo9iQaqOw4QRJ8aoTo9eqGQU/QEaUaXRaHJ6HW+MoclVfBCvxbZm22EhgI
u7tWOYAsxH7dQmUIRHi7TmzLLpJ2ULJd8e4E8tyA23Ro5FW4xpgPhdSVo/lUpmVf
Vros2xs/BUn1i0OivT2cNIRbKxvOiw==
=4Q4U
-----END PGP SIGNATURE-----

--Sig_/9FpqtZ5yD8iO3LD4WECjyjC--

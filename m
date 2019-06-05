Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBFC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617CE2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ExUde0tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFEWan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:30:43 -0400
Received: from ozlabs.org ([203.11.71.1]:35291 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEWam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:30:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45K3Ql4H9Bz9s9y;
        Thu,  6 Jun 2019 08:30:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559773840;
        bh=fVAWUh+vPwz016H2tMSV2aVqis7jv1k6eHlFiaW+ubY=;
        h=Date:From:To:Cc:Subject:From;
        b=ExUde0tg6gOt71oZjQHBUrViKft1hEu1XV3k+Wg2Rz+VQkmjZB2DZlF1u5vFKspYf
         RiYst/klMw02BdlQzb4FWrI/APL9xliHQyqomPs/mlXclrDIygjqPFp9zOagtwBWp9
         vbY4Nxtcy4CU/ZQ9WG+JmJ+4eTKhcdfWf+S087jx7qqEBLTIlsO3SeOjx2+uyEw1kI
         bMB5XCuaNIp0Q4LGKZ7IBPBZIqI2VY0TEivHphvoS/zBzYs1dZNIDABP8UJlLiKgVj
         AEIrpRyGQHOkDDFgvI2zPmuffYPHEYHR6jU3n7fKWjKormFP7fUkRuILg3Tfkq8Jh0
         O0M7yJZmHh/Jw==
Date:   Thu, 6 Jun 2019 08:30:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: linux-next: build failure after merge of the hwmon-fixes tree
Message-ID: <20190606083034.196219f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m0o70mjk2qUo7JMK./TCke/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m0o70mjk2qUo7JMK./TCke/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

After merging the hwmon-fixes tree, today's linux-next build
(x86_64 allmodconfig) failed like this:

In file included from include/linux/notifier.h:14,
                 from arch/x86/include/asm/uprobes.h:13,
                 from include/linux/uprobes.h:49,
                 from include/linux/mm_types.h:14,
                 from include/linux/mmzone.h:21,
                 from include/linux/gfp.h:6,
                 from include/linux/xarray.h:14,
                 from include/linux/radix-tree.h:18,
                 from include/linux/fs.h:15,
                 from include/linux/debugfs.h:15,
                 from drivers/hwmon/pmbus/pmbus_core.c:9:
drivers/hwmon/pmbus/pmbus_core.c: In function 'pmbus_set_samples':
drivers/hwmon/pmbus/pmbus_core.c:1975:14: error: 'data' undeclared (first u=
se in this function); did you mean '_data'?
  mutex_lock(&data->update_lock);
              ^~~~
include/linux/mutex.h:166:44: note: in definition of macro 'mutex_lock'
 #define mutex_lock(lock) mutex_lock_nested(lock, 0)
                                            ^~~~
drivers/hwmon/pmbus/pmbus_core.c:1975:14: note: each undeclared identifier =
is reported only once for each function it appears in
  mutex_lock(&data->update_lock);
              ^~~~
include/linux/mutex.h:166:44: note: in definition of macro 'mutex_lock'
 #define mutex_lock(lock) mutex_lock_nested(lock, 0)
                                            ^~~~

Caused by commit

  8d719d6f3e97 ("hwmon: (pmbus/core) mutex_lock write in pmbus_set_samples")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/m0o70mjk2qUo7JMK./TCke/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4QooACgkQAVBC80lX
0GySfQgAkiwS8dok8dNR3tdhI222YRvfJ+hSHENnT7bHokekA14PlpW6Nskfb13B
1uRx31U7RUHssowIB+PueZyaBnfJuPx1DpI0wwyhB+I5NRFoL9ixsRmJNUmLoxDf
rtWmTNIY+J8S8nCd5Qt573kXNMG6i1uUISe/RVVnNJ/lCEtsoX/Nwlx2FRYGjSjI
kj7QgToOYRPd/D44HHEXVO+GdRCn0JEhsL7NevmqJ67o3iBwL4x8SwN6ZIgHTIFS
FPMcdahwLGgA9eF20ISRbilYS8TnUrxNy9Rjhi+hN47V9E59XZhUCrTR6gwTRGkh
7Ic6tgWDCTJuqmKPV/VPW8WhzFWu0g==
=hq3o
-----END PGP SIGNATURE-----

--Sig_/m0o70mjk2qUo7JMK./TCke/--

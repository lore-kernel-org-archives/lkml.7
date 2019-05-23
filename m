Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DCC2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QSC/OXGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbfEWWYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:24:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387605AbfEWWYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:24:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4593w01HMgz9sBr;
        Fri, 24 May 2019 08:24:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558650288;
        bh=FC/yX9Du2izCkSvm2l2eAViEDqA0LyixxLltmRSO3zQ=;
        h=Date:From:To:Cc:Subject:From;
        b=QSC/OXGE5+B6DzC9ftJjhiFK0DV3MXJZHok08CctOiJGqSR9lFXLgBdZurPMx/TrJ
         hevlwYIEMR1ifl88hSfxV+54krWSajecGdzLKAXHdaTWH2mvssyj93asLWhJOaxy3X
         Pp4VX+cbMpx/wHubYtc/NKTaJveY8uMngJvPCsD63Oc/E/00aBk4b6h2k9tMQN3q0p
         17J5+0ti0meYBkqcHfD+QVWVKn61GxnFdpztKOWO6IC9lrYTEvaF22qhOItP7dbr/U
         NHink3lGi5vAY/tUustwTzyiSysSnG4UK784wFx3GZv4gcOYNwUcAREORleqKU0iYI
         1rVcY4LfK6fhA==
Date:   Fri, 24 May 2019 08:24:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Subject: linux-next: build failure after merge of the input-current tree
Message-ID: <20190524082446.7d5bc21c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WvNaPxBP.9jG1=fIdjJghOb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WvNaPxBP.9jG1=fIdjJghOb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the input-current tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/input/keyboard/mtk-pmic-keys.c:21:10: fatal error: linux/mfd/mt6392=
/registers.h: No such file or directory
 #include <linux/mfd/mt6392/registers.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  78094276ca6a ("Input: mtk-pmic-keys - add support for MT6392")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WvNaPxBP.9jG1=fIdjJghOb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznHa4ACgkQAVBC80lX
0GyAAAf+ITPFpdEirtGjI/PW7tChV+qRMezXoxrPUc8tmETKVvPdt5mmm5ETsEZi
+/lxqsqyHbsEmiueUYUca7+yNWlnFEww/b63W+jiPooYCZYTx3Df4gAy1j/hTbOu
O0jtcPm1IWNDXqz5xXryBS1KqmURDWvQelcxbSjORjnAaCOtoQtWUQchIos94qbm
gKPajbOWk5wZrc5YnVzc2br0BmnOD75UekJqv2jK3Jjvz0jMvdJ/otfqAVeNaDfk
EfxM4q7WJeSCMkyycFTc8+5iZbjW63tbof9/7iIhYlwmIulnU0oE5URbuhzFlnTk
oqmguu/6TGPdPPb6rj1cQprAGCpEVw==
=hr3u
-----END PGP SIGNATURE-----

--Sig_/WvNaPxBP.9jG1=fIdjJghOb--

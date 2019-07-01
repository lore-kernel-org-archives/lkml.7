Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD44AC06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CCF208CA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LfGT9tIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfGAC1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 22:27:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfGAC1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 22:27:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cWTv5Xc1z9s00;
        Mon,  1 Jul 2019 12:26:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561948020;
        bh=zYeGVm+QfOpq4f0m7r1SVlPZPSvW3pDTk4uFnEP7Odo=;
        h=Date:From:To:Cc:Subject:From;
        b=LfGT9tIgocWzkx9EBHaqVy6YgBqakUP0Y8+tXXMql0+8smIwKub99fjFQD+B/5CPp
         9ZWDFKdDpUQFM8nr7xaDHpT577zu94r0/A2rzBuwe2QL6hMQtzR+fPaEN73oGPnZ4U
         FaAmskHX39OSZ9JrgclS5H2ti+79uFxGA8Nabx+oTqcpm/bFDJWQMvb0IisQHpRSIv
         DWt1W8oJawR24CaRoLoJ8kgVzK7DM/Sbwp4B5RHR8l9VGIpPnrFyCX8kRpgIjML/W5
         ACriHlJIZiNBb4lgrJuWzUHzhjsnGvQor0DAUoGaw76KQj60P3UDjjCGuIKFAQV9lx
         fhGxZykTWoVxw==
Date:   Mon, 1 Jul 2019 12:26:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boyang Yu <byu@arista.com>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20190701122658.03970c9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zuXy+y.BezYQa6yA70cmACh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zuXy+y.BezYQa6yA70cmACh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/hwmon/lm90.c: In function 'lm90_write_convrate':
drivers/hwmon/lm90.c:597:42: warning: 'config_stop' may be used uninitializ=
ed in this function [-Wmaybe-uninitialized]
  if (data->flags & LM90_PAUSE_FOR_CONFIG && config_orig !=3D config_stop)
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/hwmon/lm90.c:598:3: warning: 'config_orig' may be used uninitialize=
d in this function [-Wmaybe-uninitialized]
   i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        config_orig);
        ~~~~~~~~~~~~

Introduced by commit

  479a503fa073 ("hwmon: (lm90) Fix max6658 sporadic wrong temperature readi=
ng")

--=20
Cheers,
Stephen Rothwell

--Sig_/zuXy+y.BezYQa6yA70cmACh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Zb3IACgkQAVBC80lX
0GwURQf/VRm8XALMTVzPiuZ8UmmsPIjVbwHWAS5qxW1CIVNY+MeCCF1/tfawkNLi
ZR+E546Gxpq4dGsGBx2EnB22BkyZaBaatdrWBFHDlnp1E2th8jnnOBeB1nUP1LbN
1wnVAH2N+IvHZ7P/u4tb7HCVWRkIyAGFeHzECmgKadI4A94bHkI4w4jJ477329ZU
8ndtzC/M6CYJhOwIcX4jSUa+hqNhfsZdsoN9KzlZLBVhDjTfteC6ztU6b1qNePfD
A20KOYrVOEJbviroTFFc6k4PAqZB5qut/EPKbCj7EUlodEZiPY8XVLYSWNRpAUWu
vFEcUPc3WyQXu+rcWYBMPrq+oCTm7g==
=wUfV
-----END PGP SIGNATURE-----

--Sig_/zuXy+y.BezYQa6yA70cmACh--

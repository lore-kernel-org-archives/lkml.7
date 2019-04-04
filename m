Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F02C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDAF2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PHN7iNFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfDDWP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:15:27 -0400
Received: from ozlabs.org ([203.11.71.1]:37347 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbfDDWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:15:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Zy1k298Rz9sPn;
        Fri,  5 Apr 2019 09:15:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554416124;
        bh=OESjim0I8EHOow7ccfA4cYvldzgj1d24KA5KSvZDXy0=;
        h=Date:From:To:Cc:Subject:From;
        b=PHN7iNFLZy3PX8SR2R/RA/zIPdNt/bZIR+prN93a4dq4A/n0tzQMZySB7YXdCM1mY
         HF/v6H8n3bF94R60Ui1ui4IAO5a8G5rG848RmEOWOA0MBR79NPvyp8aQyGmXaGd6/B
         oyDmC09OlRGQ7c+QwjgVQUP3mc+5HD5HEEWJMDryoSHfmppm26bgyEZIpY5fDBX7wk
         I++0+t8fIDxyuWcYKmitXQpfhUYzMIbpqA7eUrqvRVuRqcQlRf/R9pY875iPdGprN8
         34r0RnILgal+LRoN15k5iMga4SYKRC97PAns050wJRxqzq5z7JfGs+MlBy1/1rQ4hX
         2f4oJUMZfuJdQ==
Date:   Fri, 5 Apr 2019 09:15:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: linux-next: manual merge of the at91 tree with the at91-fixes tree
Message-ID: <20190405091519.48aa4098@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bS0DsbD3k/Dgz/eh1700zt+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bS0DsbD3k/Dgz/eh1700zt+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the at91 tree got a conflict in:

  arch/arm/mach-at91/pm.c

between commit:

  ba5e60c9b75d ("arm/mach-at91/pm : fix possible object reference leak")

from the at91-fixes tree and commit:

  c3f5b8fde71f ("ARM: at91: pm: introduce at91_soc_pm structure")

from the at91 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-at91/pm.c
index 2a757dcaa1a5,5571658b3c46..000000000000
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@@ -620,10 -676,8 +676,10 @@@ static int __init at91_pm_backup_init(v
  	return 0;
 =20
  securam_fail:
 +	put_device(&pdev->dev);
 +securam_fail_no_ref_dev:
- 	iounmap(pm_data.sfrbu);
- 	pm_data.sfrbu =3D NULL;
+ 	iounmap(soc_pm.data.sfrbu);
+ 	soc_pm.data.sfrbu =3D NULL;
  	return ret;
  }
 =20

--Sig_/bS0DsbD3k/Dgz/eh1700zt+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlymgfcACgkQAVBC80lX
0GyPowgAhuq7czn+9VRhS9GwHQlBbt0Ko0+qKjQKfc4Czbi97g+DYoO8cZqUnrIm
u52MSWHJ8DIXq/2fu24Fk2za3WsUwp6GmXAiCma1UBhftY0zDoc9hOd9G/S3vORV
9DiYLuvO949odXaQyufRJHeMdS20OY2Gb2BENgSB8p0R/xjssmLwbQdLow3KPrli
zKEvMZP5LEKn8pkR8E252yQmYhHFtAucw2n00iNDJGz/aLYI/8zOCEl03W4AXSmj
D+F95JSWbrm2ReIvpixVN9GfiQSm2V2+Jxnyx1ijlAiweVJ4ZVKPYT2jRbznbaIt
tHm0+iJS0a/fYLWrDJ0MFBW8pUaVUg==
=GQmp
-----END PGP SIGNATURE-----

--Sig_/bS0DsbD3k/Dgz/eh1700zt+--

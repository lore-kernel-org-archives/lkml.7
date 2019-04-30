Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF732C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E0020835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tLDOi4y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfD3HlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:41:14 -0400
Received: from ozlabs.org ([203.11.71.1]:56441 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3HlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:41:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tYP037VSz9s7T;
        Tue, 30 Apr 2019 17:41:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556610071;
        bh=DaaFAoPL5nbu+X5DMwZs1bYyG461/fqfOUODuvUM6cM=;
        h=Date:From:To:Cc:Subject:From;
        b=tLDOi4y4DhceYBf6Rmn4Ep/ep9zStJFMKT1881P+gEmSMj1iOxEUoBuVQ55QDMjoY
         ueLhEAsgT/55Mj7f2amnP7tT3QlW/Q61NdtIKadGrVxMF28W0Vlmb662843uH9mw9b
         DdPsgUMwHskLt4jH1Q+DVLvzEfhid0QL6b7rYKALKL9sDmUO1Nr9hzOYnvb2Ya2AH4
         uq2kL1i2muGP4wzL7OmQPm0AHA4xX1sqlhWMQiQ2aRRPuPfLBoKT2rubxuj8crLH0D
         3kxeLkEmxE9EjcP8U23tZPIhWsi5J73JOj+FJ9EsjyINYZl//AoVuQQ1KRpUjWgmlS
         PFKqAsHg+SnPw==
Date:   Tue, 30 Apr 2019 17:40:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Venture <venture@google.com>
Subject: linux-next: manual merge of the char-misc tree with the arm-soc
 tree
Message-ID: <20190430174051.038c77c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ny_5=Hqp3mTDaEmmISm8Ays"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ny_5=Hqp3mTDaEmmISm8Ays
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got conflicts in:

  drivers/misc/Kconfig
  drivers/misc/Makefile

between commit:

  524feb799408 ("soc: add aspeed folder and misc drivers")

from the arm-soc tree and commit:

  01c60dcea9f7 ("drivers/misc: Add Aspeed P2A control driver")

from the char-misc tree.

I fixed it up (see below - though the additions probably want to be
moved as in the arm-soc commit) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non
trivial conflicts should be mentioned to your upstream maintainer when
your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/misc/Kconfig
index b80cb6af0cb4,3209ee020b15..000000000000
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@@ -496,6 -496,30 +496,14 @@@ config VEXPRESS_SYSCF
  	  bus. System Configuration interface is one of the possible means
  	  of generating transactions on this bus.
 =20
+ config ASPEED_P2A_CTRL
+ 	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
+ 	tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
+ 	help
+ 	  Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings through
+ 	  ioctl()s, the driver also provides an interface for userspace mappings=
 to
+ 	  a pre-defined region.
+=20
 -config ASPEED_LPC_CTRL
 -	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
 -	tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
 -	---help---
 -	  Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
 -	  ioctl()s, the driver also provides a read/write interface to a BMC ram
 -	  region where the host LPC read/write region can be buffered.
 -
 -config ASPEED_LPC_SNOOP
 -	tristate "Aspeed ast2500 HOST LPC snoop support"
 -	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
 -	help
 -	  Provides a driver to control the LPC snoop interface which
 -	  allows the BMC to listen on and save the data written by
 -	  the host to an arbitrary LPC I/O port.
 -
  config PCI_ENDPOINT_TEST
  	depends on PCI
  	select CRC32
diff --cc drivers/misc/Makefile
index b9affcdaa3d6,c36239573a5c..000000000000
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@@ -54,6 -54,9 +54,7 @@@ obj-$(CONFIG_GENWQE)		+=3D genwqe
  obj-$(CONFIG_ECHO)		+=3D echo/
  obj-$(CONFIG_VEXPRESS_SYSCFG)	+=3D vexpress-syscfg.o
  obj-$(CONFIG_CXL_BASE)		+=3D cxl/
 -obj-$(CONFIG_ASPEED_LPC_CTRL)	+=3D aspeed-lpc-ctrl.o
 -obj-$(CONFIG_ASPEED_LPC_SNOOP)	+=3D aspeed-lpc-snoop.o
+ obj-$(CONFIG_ASPEED_P2A_CTRL)	+=3D aspeed-p2a-ctrl.o
  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+=3D pci_endpoint_test.o
  obj-$(CONFIG_OCXL)		+=3D ocxl/
  obj-y				+=3D cardreader/

--Sig_/Ny_5=Hqp3mTDaEmmISm8Ays
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzH/AMACgkQAVBC80lX
0Gxkrwf+KnscYdJuNJYRWeKxKXVoNBpZRmZMxj9BqOiQ5SeV5k443b22uXfrYHkT
X5jRMJe0zGgRdu/1swgOQjVq02Vm7wpNMjvqU1dwOoTsD//zpSdypiAAsMDbz/gJ
/3h/kp7/Wrj1QvwCCS9NItlQGNDy1ETwh0gVkeuLEw1LObxsr11B5bTYUN4Xm8QN
9MipYy/MSjIIR3dQG7YjvaYHk6cY4+hItm7bwYgF1Z5BbXwVB96Ae16kHrHnPt7v
qV2OvSLTgYsws3NwXQr6/zYg2PgM6pozMQrBhwDRjK3fjQhyXFBp7VRju2bfcDy8
tOc0KEqsSUIkQRgnJYnZXgCTXcez7g==
=9oiN
-----END PGP SIGNATURE-----

--Sig_/Ny_5=Hqp3mTDaEmmISm8Ays--

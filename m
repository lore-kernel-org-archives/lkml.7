Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4193C606D7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD80221537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WZknx/Sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGIIWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:22:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIIWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:22:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jZzz5zb8z9sN1;
        Tue,  9 Jul 2019 18:22:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562660529;
        bh=0E4mbQbXSeBh+V/gm/m6xxRJWGDNOPL5eLSQYqqllzA=;
        h=Date:From:To:Cc:Subject:From;
        b=WZknx/SrW2PSNbeKjCs/cc1gz3yjJ67iwppccmqrxniqn7XUSOAV/5wOIbF4TRSZN
         gF9zL+aPVQ6+yeDX48WLHG17zlafSg6PX6aMKB+w7tket/hjYhNJpFC+L5ymzaNac6
         FWrBINwmDTixQfjzjRvq3W7QgXuPlGBK/y4tUDBYKiYXUMYOE5YAdD11ao+Dd/gsej
         WBOVZoUsIL4Y01BdjeCcv3iK6hxC2zJ02FZyhLg/senddC89iDH+QeCyb744kVJI1E
         UJ25v+9XY9Os4OIjjMwFvAL+Qzua6DSi2kv9AqyrNssgO/1w5LnEvxTlVmaqGGWJaL
         4fj+hSaAN35Jw==
Date:   Tue, 9 Jul 2019 18:21:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: linux-next: manual merge of the char-misc tree with the watchdog
 tree
Message-ID: <20190709182153.4ee49f62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RbsQDjixmUr_A0ZOBpiPoum"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RbsQDjixmUr_A0ZOBpiPoum
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt

between commit:

  8c21ead3ea5d ("dt-bindings: watchdog: move i.MX system controller watchdo=
g binding to SCU")

from the watchdog tree and commit:

  c2a6ea23a401 ("dt-bindings: fsl: scu: add ocotp binding")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 1b56557df521,f378922906f6..000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@@ -133,16 -133,18 +133,28 @@@ RTC bindings based on SCU Message Proto
  Required properties:
  - compatible: should be "fsl,imx8qxp-sc-rtc";
 =20
 +Watchdog bindings based on SCU Message Protocol
 +------------------------------------------------------------
 +
 +Required properties:
 +- compatible: should be:
 +              "fsl,imx8qxp-sc-wdt"
 +              followed by "fsl,imx-sc-wdt";
 +Optional properties:
 +- timeout-sec: contains the watchdog timeout in seconds.
 +
+ OCOTP bindings based on SCU Message Protocol
+ ------------------------------------------------------------
+ Required properties:
+ - compatible:		Should be "fsl,imx8qxp-scu-ocotp"
+ - #address-cells:	Must be 1. Contains byte index
+ - #size-cells:		Must be 1. Contains byte length
+=20
+ Optional Child nodes:
+=20
+ - Data cells of ocotp:
+   Detailed bindings are described in bindings/nvmem/nvmem.txt
+=20
  Example (imx8qxp):
  -------------
  aliases {

--Sig_/RbsQDjixmUr_A0ZOBpiPoum
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kTqEACgkQAVBC80lX
0GzMiQf+L6LmHyXul5iEqcecvgRhkKD7R6qABepAqQOIwGLck9KI1lCX0dT/dg3H
OTK75OYa5LViz1739eYPfqVhnS0WM3KEqhFqD4TY1QiNUQ6Et0ZXqB2t2zKGbxnl
e7iIHV1QQT8sWtw5yIc29AVbrfIfsndN6Fp5gMg7RRf3JTnVxtFLgj34bCAf8gBG
mlbwZC/5oAOb22MPTUp6QjbooI7ouBgGfWMblN9bsz9EiZ++9nwQCP1rY9Y1Lt7w
nwiOHlqQe3hyofQjSFAojOkxYBDM+Voa5G0ixBuMeV9FaezqmkFo44OT6ye0mvbo
tuEAu88qtnndlxA5OKwyczX+hvW83Q==
=JcnW
-----END PGP SIGNATURE-----

--Sig_/RbsQDjixmUr_A0ZOBpiPoum--

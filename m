Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA71DC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161CF20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 00:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nc4pmpgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFFAZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 20:25:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfFFAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:25:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45K5zB4dCkz9s3l;
        Thu,  6 Jun 2019 10:25:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559780727;
        bh=gMTY/hHP0jUp9SBk5eV2Bu/Da+hdTEZtxivGrCs08fo=;
        h=Date:From:To:Cc:Subject:From;
        b=Nc4pmpgK+GvwPaOabYqYyKt4RItE7s8VixLsyNIIsT6M/wfYMz83B+6n1X7XpcUDF
         C1mSwoHpW+5wNPMExw8M+SMuJgLr13H4EUFS7aKPT6h1JEyZxWr2ahBhTlkAkiCRqn
         DeUIoZchTK8N4wla1bFiutankZEU1JqxwBWWsTBUDcJ2kziGDqjDyb5VC+UjBSe/pg
         mbZeydHHHU/h4WCXhaTv+u+nB9oQYD9tusgU1PQ4NjK1CgoPiiJgAn6MqDyRD34cAr
         wy1qjOpA8J9E0oUBoeyP0H27lXk5dcgQEMLL9FedJ0cWSC0tRCIVWeTsImeX+wx24p
         ozBilGQG5+ZkQ==
Date:   Thu, 6 Jun 2019 10:25:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "amy.shih" <amy.shih@advantech.com.tw>
Subject: linux-next: manual merge of the hwmon-staging tree with Linus' tree
Message-ID: <20190606102506.1c282b9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=VdmdnMjiu6kW+BZHgPX0gx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=VdmdnMjiu6kW+BZHgPX0gx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hwmon-staging tree got a conflict in:

  drivers/hwmon/nct7904.c

between commit:

  c942fddf8793 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 157")

from Linus' tree and commit:

  7394ec51cf51 ("hwmon: (nct7904) Fix the incorrect value of tcpu_mask in n=
ct7904_data struct.")

from the hwmon-staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/hwmon/nct7904.c
index 58a957445484,91d1eb822707..000000000000
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@@ -4,6 -3,19 +4,9 @@@
   *
   * Copyright (c) 2015 Kontron
   * Author: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
+  *
+  * Copyright (c) 2019 Advantech
+  * Author: Amy.Shih <amy.shih@advantech.com.tw>
 - *
 - * This program is free software; you can redistribute it and/or modify
 - * it under the terms of the GNU General Public License as published by
 - * the Free Software Foundation; either version 2 of the License, or
 - * (at your option) any later version.
 - *
 - * This program is distributed in the hope that it will be useful,
 - * but WITHOUT ANY WARRANTY; without even the implied warranty of
 - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 - * GNU General Public License for more details.
   */
 =20
  #include <linux/module.h>

--Sig_/=VdmdnMjiu6kW+BZHgPX0gx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4XWIACgkQAVBC80lX
0Gyn7ggAgW2GKvePdG00SrnsyWfR0jx3d3zKPZkOGy6F7qxnC/gJoWTorUl3u5ub
WBjCnardgQZCTLuThWNO7atZQLGSCdV3uv9UT7XB1otqZ2ty45f8w5wG5x9N2QA4
oeoPpz6KssKpswEXTT5t78pzSjFb2mAlKWGjzLEG3ucxjpTV20F9gQpPS5HV/YZ4
E3iK0TtSwIu6qIHz7vdZU/6Lky4AVhK3kkuJvUo4R51XPqwTmmm8qg3/4NMmkcjC
Ej+5Xn9to1Kjz52T2WXLhUFCwjdHUVvQpVyx7Ye+OMciJB3iWbNVlehEu5+gWY37
/rDzZglL38r6U9Dyt2zj2BuArHEQPQ==
=05w+
-----END PGP SIGNATURE-----

--Sig_/=VdmdnMjiu6kW+BZHgPX0gx--

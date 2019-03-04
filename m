Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A28C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35152082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j821gtN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfCDDhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:37:40 -0500
Received: from ozlabs.org ([203.11.71.1]:52759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDDhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:37:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CQhJ2vRmz9s5R;
        Mon,  4 Mar 2019 14:37:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551670657;
        bh=PgAJDeIIdJ9STuA1hEym8xMcCYqavJgKJli6LKStZnQ=;
        h=Date:From:To:Cc:Subject:From;
        b=j821gtN12IQJG+AR6+106UvCsGC/Y3kauL0gypV1IR05OIzYXm87vFiUmwPCTuiO2
         dTxoDp3rdQ2L7o7w0v1M5X7OBuN3rUNqKhCLUT3zpU6n0UPIEEGHHvUjYHw9Kz837t
         +Xp/rz+tf01T6VPksRpRkAM2LltfvQ1YfusmY5BEyiayFM+fPKycuKpnjeUsxdZUcK
         XKrSpmcknG6kgnL7XQwSq7A9VBbX+tSvuzKdXoZUoEQVRwMOvToOiPGwI/0LnOZfyB
         5lBiwZmiZPMuoSj9Xc7Oj4/9aXjZvv+eNIVxpq1dCYlPV97juJQ0WqVzbAS/TGSdaQ
         0CR8J6T1sROQg==
Date:   Mon, 4 Mar 2019 14:37:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Shych <michaelsh@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: linux-next: manual merge of the drivers-x86 tree with the watchdog
 tree
Message-ID: <20190304143735.308edd1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/22xVno_WMun1/gOIgWBEiZn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/22xVno_WMun1/gOIgWBEiZn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  include/linux/platform_data/mlxreg.h

between commit:

  9f03161a1bd8 ("platform_data/mlxreg: additions for Mellanox watchdog driv=
er.")

from the watchdog tree and commit:

  9b28aa1d0eae ("platform_data/mlxreg: Document fixes for core platform dat=
a")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/platform_data/mlxreg.h
index 31f7c25a44da,1b2f86f96743..000000000000
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@@ -120,12 -109,9 +122,12 @@@ struct mlxreg_core_item=20
  /**
   * struct mlxreg_core_platform_data - platform data:
   *
-  * @led_data: led private data;
+  * @data: instance private data;
   * @regmap: register map of parent device;
-  * @counter: number of led instances;
+  * @counter: number of instances;
 + * @features: supported features of device;
 + * @version: implementation version;
 + * @identity: device identity name;
   */
  struct mlxreg_core_platform_data {
  	struct mlxreg_core_data *data;

--Sig_/22xVno_WMun1/gOIgWBEiZn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx8nX8ACgkQAVBC80lX
0Gxv8wf/eZZGiNqsMFy4QgB0xzyZ0zDoLXsi7rJHrpTTJwTn94QopWOaWWUxvXel
/8IJhwyMrX3fs2561HhzAbhuFw/fdnz02zFsN4TATz23tKZeIMLqWLArEMWyxe3B
KPS0VPdy2NDB8sWtf0hfhROWCXYcrbj/7bMXZlMNl/uB/AOYWFTCTqGDjfCngj4Y
2EKO4gAeeR9BSQHKV6/2GchRf/LmB+KpGEZqO1d2dxeQVIRT/pN3Tmd2OBiEHMwg
OQKtVsIPUnPLIQCA3SyzA2msa5UFOksFK498+eytcN/8Kju7DHoeGJPnhV6jh/74
BytgW6gYJbcpPBVXgfUgAb+weW8ALg==
=C2Cp
-----END PGP SIGNATURE-----

--Sig_/22xVno_WMun1/gOIgWBEiZn--

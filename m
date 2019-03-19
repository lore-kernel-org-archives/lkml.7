Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765E620989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NHNDHQH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfCSC6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:58:38 -0400
Received: from ozlabs.org ([203.11.71.1]:46405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfCSC6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:58:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Nd6L6FCJz9ryj;
        Tue, 19 Mar 2019 13:58:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552964315;
        bh=lp42dTeXY0QWn1fEOJMDORtyQ592cd9NBLx4thdDCgw=;
        h=Date:From:To:Cc:Subject:From;
        b=NHNDHQH2AXlgAGFJnRQQQ3mp9Wq7xnKp3WNYeEGtRTu554GS1LBxKKl0C8T5oM6Nr
         9vcvr7uRQcKK8bNX1f+6XRQK5/hKBnEyejib8mHrBK5St9FZM7Lc869S5OW6aWisFO
         N4tA4dLX4vS9FzNFkUvfJikygU4X21i2E3sowZ81EIjWGQUMDVweZ/7qViEH5ElN7m
         gFNOe3NphTjZrgUmzG0m0lUjFXsY+gRIX/+FOTEfT7zBGQeYVRkntDWKcO9/sw5y68
         kaCMVHh/n+Ur9tXRx5l9MIq8c3HsoQfNh6C4UwJi5solwUI5/EXxDSHOmTbRxmNhts
         8eDz0r9g4C7Bw==
Date:   Tue, 19 Mar 2019 13:58:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Subject: linux-next: build warning after merge of the leds tree
Message-ID: <20190319135833.64ad30b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o2dvWC9DrisrNsricRIrHid"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o2dvWC9DrisrNsricRIrHid
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the leds tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/leds/leds-pca9532.c: In function 'pca9532_probe':
drivers/leds/leds-pca9532.c:536:11: warning: cast from pointer to integer o=
f different size [-Wpointer-to-int-cast]
   devid =3D (int)of_id->data;
           ^

Introduced by commit

  6b788fae618c ("leds: fix a potential NULL pointer dereference")

--=20
Cheers,
Stephen Rothwell

--Sig_/o2dvWC9DrisrNsricRIrHid
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQWtkACgkQAVBC80lX
0GzDDQf8CyTqf8Wutu88gxXhsR80cbHvKXmFwz9Akd1oCwDGEQi6lCEHAnjjg9KN
37Q5bMojkFLVxHYOL0j5DJilQZ6nHd6OEzabnA8wKHzSTrPWF+NL2Yh6u0ruFaIZ
nUd8zGuI2S0mdCUDF+k3dVaFusfRH8Aj/q/RcTRdoEfoL+QmwWWT8rWcjPWDJ/EO
67cm9tlPykueWvj1//jlds9rgMrq0rlG9bIsP3sAUcXxItMeOB/8LXtcTTW93FiB
+klXweaweZFbMaV5QzfQmdKbLpjZkccSwtaRg8GX81rbytM7VxfMQUf5oQ+oDQv1
lZCGFd24C3zBHl3ndjmgzH0YbFDTVg==
=p/x6
-----END PGP SIGNATURE-----

--Sig_/o2dvWC9DrisrNsricRIrHid--

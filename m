Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9153320868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ozZ7mZGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDPEaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:30:35 -0400
Received: from ozlabs.org ([203.11.71.1]:56165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfDPEaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:30:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jsqX4xsmz9s4V;
        Tue, 16 Apr 2019 14:30:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555389033;
        bh=dOGvMzw1kLKOsu9CzHvx2d4cUfbU0gqkaLv452qKDiU=;
        h=Date:From:To:Cc:Subject:From;
        b=ozZ7mZGsttCOm6svA5oLb8si9yZQkcJiiwrLzpdxAlRRj3evNY/g0JZzB6uLT+SMS
         jhkU9juxJxs/jeyZSLF1kw9tg7Hr+qVQ8EUEEh2ztPV3t3u6d6fIzv2BU14Hz+I1Vd
         xQytDBmXiIkmINbzXMB0I4foMUfkGzFnFk/THuovV1vGBMOZfgBymwxnnx4GF34ebs
         xQx2ZO/Em4bXU1qER9Bk0ijdg3xfJuE5H1SNAJTY2scgCzDUjhfQ9OZE/wofHzcTHs
         X2MiUMrM1DFDJULNpVGN0ker6G4Z91u/8pI2+6h42Xla7uWrMMlonnWfQVvOe5Q0Qg
         6Xu+V28UYs/Ig==
Date:   Tue, 16 Apr 2019 14:30:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>
Subject: linux-next: build warning after merge of the chrome-platform tree
Message-ID: <20190416143030.07537982@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//BOQKd8ymmpCrPnrqxk/2FO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//BOQKd8ymmpCrPnrqxk/2FO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the chrome-platform tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from drivers/platform/chrome/wilco_ec/debugfs.c:11:
drivers/platform/chrome/wilco_ec/debugfs.c: In function 'fops_h1_gpio_open':
drivers/platform/chrome/wilco_ec/debugfs.c:210:59: warning: format '%x' exp=
ects argument of type 'unsigned int', but argument 2 has type 'long long un=
signed int' [-Wformat=3D]
 DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02x\n");
                                                           ^~~~~~~~~~
include/linux/debugfs.h:45:29: note: in definition of macro 'DEFINE_DEBUGFS=
_ATTRIBUTE'
  __simple_attr_check_format(__fmt, 0ull);   \
                             ^~~~~

Introduced by commit

  db6c540a0018 ("platform/chrome: wilco_ec: Add h1_gpio status to debugfs")

--=20
Cheers,
Stephen Rothwell

--Sig_//BOQKd8ymmpCrPnrqxk/2FO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1WmYACgkQAVBC80lX
0GzrawgAoPvOqwI2AdlKc0GxmhLUlOjQejEBgooTENhIFcmLetwcWkxEDKeLuafT
IQMPJ/yaBhqIR8AxKZT5HBT59mdusNqMHFodslqHFvIDQihbLIQMAA4IsWju7VD/
M/K4H/u3qox6jbu+gM1m9Vc29kwA9WA31ycnEjG+2P3VSycszZH8tBedZT3EpABD
kN+4k06xAn3LseU07Ja9TzEntQaUOZU0WEIwGi3obrIf5E/9lV82wYt1Y6rPcn/X
Nap3GnX6n24j3Gc2v6mDinT7D/MRkBqtnD4Fa/ExA65zljjqM/OP2AOVXT/YDSTL
ZClEi+rY3sZ5+8ZejPsQ7rBFW1OaHw==
=9j2L
-----END PGP SIGNATURE-----

--Sig_//BOQKd8ymmpCrPnrqxk/2FO--

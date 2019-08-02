Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EDBC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307CE206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="soKLvqi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfHBDV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:21:29 -0400
Received: from ozlabs.org ([203.11.71.1]:42595 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbfHBDV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:21:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 460C9x40Krz9sBF;
        Fri,  2 Aug 2019 13:21:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564716086;
        bh=c0IT9plBnekDV3FBF4JgbaCWu5qpsMQyv6Ht34zq+6U=;
        h=Date:From:To:Cc:Subject:From;
        b=soKLvqi4D0RrZ/LFc/VRLFajZnHHPzpWVgTV6wNO06eIyxSXiXGvFdyczLGKQw77p
         XnXN8p43K2/gpOkgfwY4ijO+EE8QF9y+tDT1G8AFwwIjFDNjUmiX+QrKgnp+M8HTwM
         V7W1a1K15exHnonlSYYISvXc0OynzJZEaMA3tVN50oMYGgE8Ut2vaSNkIW0eb0ZycE
         It90FLvfTNRhIFRTIP7WiiMvj53tAbX7Q7609MUHm/7aczRt+3lwbXwyyLzamZ3E7q
         G0tg1QTk2sI+aagUP4aZTAxX1tnSNMpmfaTeBxHsyUXpYc/sIzIQNoAfOj6Z0Xp9ex
         0DFWo1HuFMMbQ==
Date:   Fri, 2 Aug 2019 13:21:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <uwe@kleine-koenig.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: linux-next: build warning after merge of the i2c tree
Message-ID: <20190802132123.6eabf3b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pSTusmkKzKkBd72podNMiaK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pSTusmkKzKkBd72podNMiaK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/i2c/busses/i2c-designware-master.c: In function 'i2c_dw_init_recove=
ry_info':
drivers/i2c/busses/i2c-designware-master.c:658:6: warning: unused variable =
'r' [-Wunused-variable]
  int r;
      ^

Introduced by commit

  33eb09a02e8d ("i2c: designware: make use of devm_gpiod_get_optional")

--=20
Cheers,
Stephen Rothwell

--Sig_/pSTusmkKzKkBd72podNMiaK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DrDMACgkQAVBC80lX
0GxfqAf/QmQf4oJCnvp5qQRFOt7+LA8r4sN/Zezn4P0Prtx/vfhd6iR9U04NuOiT
nYXKZjhES1PFoMKh6rF3jJaJwqdXxywujIlcFDQSXB8hSpO4xouDcN29Wb+Oe7QV
x75lsFnHaou5BRL50CsK0FatbjmCvps2xzf1JkMDbxxqSzjaTD5cvmvYDwnlhvH9
stb3FcwhJgNtVPnFXQt0p7S0gRnLOoyEI8pUcze0UB47iEAmAsPDB+xW/84jFBoj
BjObTY8BZ4GfEKVZf6MplJ+5cmIjc12SC3q5tRjPZ6i+q0MTXOdtipfIVbKGu/Rb
WU7OTOVGrWz6yit9ao1YDtA2MGmDRQ==
=mMt8
-----END PGP SIGNATURE-----

--Sig_/pSTusmkKzKkBd72podNMiaK--

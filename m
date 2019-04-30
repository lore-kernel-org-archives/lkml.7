Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF109C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8687121670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LSj/1n9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfD3ATo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:19:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbfD3ATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:19:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tMbc5fnSz9sB8;
        Tue, 30 Apr 2019 10:19:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556583581;
        bh=NUwQVYBQE22YW6CGZJVo3bT2J7uENgCqt+bTSOs1sGc=;
        h=Date:From:To:Cc:Subject:From;
        b=LSj/1n9LG7hEvcnKBiuH3JddMCQD9YlmWJEr5QnT/hHtxA4uAbXpP0fIcigEe7/Kt
         31wOJC41n6rhXbsb7zj4nO4cGkfIkD6kzrIpGp4HkX4pF4+g0JYlQDdPx4Gl7HbGCl
         gbT1rg1b6hUn+fC5iCG7d9Q6JAcrZwIXVCco2mHMHiPhHx16gwQnUiCS/qfqtQJNbV
         kl3nxlZVptHNo7TfzimghpdUWOnlcMEB6UxdI5Skd7JNFD3QW0+IIDWfK0sq6fJN3S
         wVTVZYS8vpT/AfdmOIL/UeeZxsYUl9Q/ibP9xYyffIADDIh4ny0vOI3+9LDgLO0pM2
         +lPQw+fVHsH6g==
Date:   Tue, 30 Apr 2019 10:19:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the clk tree
Message-ID: <20190430101939.76dc077c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/O_CCSv_ik.J=.msdHR8HWg8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O_CCSv_ik.J=.msdHR8HWg8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/clk/imx/clk-pllv3.c:453:21: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
   pll->denom_offset =3D PLL_IMX7_DENOM_OFFSET;
                     ^
drivers/clk/imx/clk-pllv3.c:454:2: note: here
  case IMX_PLLV3_AV:
  ^~~~

Introduced by commit

  01d0a541ff4b ("clk: imx: correct i.MX7D AV PLL num/denom offset")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/O_CCSv_ik.J=.msdHR8HWg8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHlJsACgkQAVBC80lX
0GwcmQf8DQm/+a+825CRo/z9YbTfzFrH7k1fA68yg/EKjTDMMsXeZcdPfpLEZQrT
/t+OF0ZCKTT/WEESDmmJHaViC7wGbqUzpKGKj9Z4JNC6mGBQbhGNXRt3aIUWUCBr
NpA8DebUbaUciq1iu+j3w1jrUYzmsqEB7tDfeetdPE75kCy6NZVHKNvSoINtOzE/
j/lpMl5Uv4UYQLgXmchiYgSO41iRz3xUSOZwRnuLvx0Be1i2PWBf/+SyMu9Qw9kw
WsqSKhqldIpG9EeHb4MrSYQYSeUlXqaOUvwb3HuXYyKir7qoqtAu33U1p2KUXRHn
rVOI5AteR8+bnJoo8sByoKStI6Ptsw==
=Dwx1
-----END PGP SIGNATURE-----

--Sig_/O_CCSv_ik.J=.msdHR8HWg8--

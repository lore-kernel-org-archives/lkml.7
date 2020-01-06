Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D71C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562A024650
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rAkrJkBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgAFChU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 21:37:20 -0500
Received: from ozlabs.org ([203.11.71.1]:35677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFChU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:37:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47rfmZ0KPFz9sQp;
        Mon,  6 Jan 2020 13:37:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578278238;
        bh=RUzwMRldX9X4rgLYxtAezWR+csUjDKpJtEZycnfNdFE=;
        h=Date:From:To:Cc:Subject:From;
        b=rAkrJkBfoQPx2lUelT8GxtQqyHYJJdcgN0Wqb5Nfd6Y2NPA8reDzc97mrA75urNen
         SIJuES4Sx5B1CCDCRkhCNa9PS3Kp5oJSclKlXWwJ95gQJkjJMne1P7oIXzGhSof74U
         jWdT1q6EXJ5gxZ3txENg90PdBqqTGI5BQMfbnBwfZE776LfPLPraK9DSt7Xwn8B1Ha
         sUgNggl2TSgtub63KmF2nL264TUa5OphbmVlhJD2yvkrc9jO/1r5t8ig96nmHhoOPD
         BUiHzoH89nkm5j/7F6TeFOSs4TMNGWr0ieP5aXVrLfW8iS2s6l0GvaKxch4MD2fnfT
         FqRjw9S7LNqPQ==
Date:   Mon, 6 Jan 2020 13:37:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: linux-next: build warning after merge of the clockevents tree
Message-ID: <20200106133716.62ea3548@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3_+B1LpcOVJvofiDIF59YQp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3_+B1LpcOVJvofiDIF59YQp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clockevents tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used unin=
itialized in this function [-Wmaybe-uninitialized]
  798 |  timer->irq =3D platform_get_irq(pdev, 0);
      |  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to platform_get_ir=
q")

This is not a false positive ...

--=20
Cheers,
Stephen Rothwell

--Sig_/3_+B1LpcOVJvofiDIF59YQp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4SnVwACgkQAVBC80lX
0GyrcAgAm9T+XVKx9m+wlIi9VONAtYiA4jhdLY1q4ulOTDn1ZRWH0kzeGTwtaEvn
Eq0Q6kJT9sXr7JV3XFz6duO/o2yaDu/aILXNOj1kbPTX5d5aneJfqtMScZHVnJgU
r6x1fwNVxS0VjfbwZHhwq+hPWD6H+jAxguht9CwmTPP7xznd38nu7T1Ux1SHZYo5
kozFe/ysp5311KQOZ/r38upfBOE5UybGp4EaEu4EJU30/iB3E7oaKJzS+DO+1Bok
4nOhFpcYYFg+uaPKHlsRj+BWwnWf8H8nHK0bh7JO/vZUXWJCMmW/6nEuB2BCg4eu
9cDcnfLWkJP0xUGK7DAgf/h2x+Ep6g==
=6saW
-----END PGP SIGNATURE-----

--Sig_/3_+B1LpcOVJvofiDIF59YQp--

Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D3C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDED2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="leJoLHrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfGSAtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:49:05 -0400
Received: from ozlabs.org ([203.11.71.1]:35333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfGSAtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:49:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45qXSZ0H8xz9s00;
        Fri, 19 Jul 2019 10:48:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563497342;
        bh=8BedKWYpKSSoZ6D7fwbvtLXJw97uraAskO6DkZ6NhX8=;
        h=Date:From:To:Cc:Subject:From;
        b=leJoLHrPD8wZCRd5M1MWcfcXU6NvoxIU7wjbvQFqKe6re+RQUBHeaA/gbuHrwL1Ge
         frqccsHzO0A4pT7L3tBGx02ryGlKf/jwh/fNnC+FVYmSX9Mej56slMZG1AoDwwhzuL
         r2EWOZimYhd8vM6Xj5cvRhmlBWsIb9UB7VcOAgIFpYjFfpm6hhDa+61hnvsNhJA1By
         +V0Pgn+g650b2eDx9sK8GEwZNS3jZaRCIL9PrYqT9Pjqs7m5fnayO4LspzGII5Akie
         gwYe3DMR30QUWUbPLc8CNSCyx+IkzW7BNGzOVnkgPHWpQ4dQu3xjLincf8x6qyH7bO
         p5At/yPz1QdRg==
Date:   Fri, 19 Jul 2019 10:48:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build failure after merge of the extcon tree
Message-ID: <20190719104859.0846f6ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9bm/uJQy0H9RyoVGo.cM+c0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9bm/uJQy0H9RyoVGo.cM+c0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the extcon tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/extcon/extcon-gpio.c: In function 'gpio_extcon_probe':
drivers/extcon/extcon-gpio.c:83:11: error: 'struct gpio_extcon_data' has no=
 member named 'irq_flags'
  if (!data->irq_flags || data->extcon_id > EXTCON_NONE)
           ^~

Caused by commit

  e49d583d1df7 ("extcon: gpio: Request reasonable interrupts")

I have used the extcon tree from next-20190718 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9bm/uJQy0H9RyoVGo.cM+c0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0xE3sACgkQAVBC80lX
0GxnGwf/SnVac3SnoSeM0X/aPdPbCXibF7UpA35UrsNeA9RMFzD0+lq3369QFzfz
HwvLbxEPZDPhKshoPXoY/+1fFpGQFWF3vzwZnb7ZqfdzMKLOWE3m38lIA+4vzBtY
xaoavpaqSESV0yQ+8VMvfm+fwhPSMyOJbWrhfBTCQlEjzJEoFLKK25mDT6LD4Bsc
Iz5NaLEt4aINnwnvIT4ZX64tUf2+nIASt1kskpCNVgJq/yc6qS42oiimojCJLvze
ScgXNp9QIIVfUOOnd7HCvvGk0+LcWv+j6JrbmgWWe+DqAlJ5MUTlVEHxu1i516sp
P3wY2fAHHtaVIF5xnSK764p56ZuYeQ==
=HNBN
-----END PGP SIGNATURE-----

--Sig_/9bm/uJQy0H9RyoVGo.cM+c0--

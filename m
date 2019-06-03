Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DF7C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FE527AC3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="agocnF72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfFCCNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:13:54 -0400
Received: from ozlabs.org ([203.11.71.1]:55781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfFCCNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:13:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HJWf5wY7z9s4V;
        Mon,  3 Jun 2019 12:13:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559528031;
        bh=1JH94ZmSjHKzYZuTkVY19kUsmtuB9Vtpca9qYs/ZATw=;
        h=Date:From:To:Cc:Subject:From;
        b=agocnF72J/hJERlp06QXvBe/LUaaiHz24Js2nS+4YnJCySpMsXRXwjYCN5i0VkWNE
         6Htmt/yXEChMzL2sv5V0sCzumKPohN08FDaAcqcnAv3lp9+OBQH3MLugA1HyHUG5UX
         a9HG8DWyrfRPbR6a/Orknhu0e2xvzL8YWYGlJQpBWC448+o8ipWt3wsK7u+/faALlf
         HwDMPGLU+U+L27vH3tZezgQWnOZQriY7jGz6z5GOvFH/fNI9XcLqtIkwS0LGR5fAc5
         7A9MfSqBIE7WQuppawM2K+I6+4jpC+Z+dx33DDDUsepCNvP7NeBTBAfFBjIAenY3gV
         r4ofKcXH4OJ8Q==
Date:   Mon, 3 Jun 2019 12:13:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: linux-next: build failure after merge of the clockevents tree
Message-ID: <20190603121350.653cacce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uiNiVsT1gh9W9UsmKqw3sG."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uiNiVsT1gh9W9UsmKqw3sG.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

After merging the clockevents tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/clocksource/timer-atmel-tcb.c: In function 'tcb_clksrc_init':
drivers/clocksource/timer-atmel-tcb.c:448:17: error: invalid use of undefin=
ed type 'struct delay_timer'
   tc_delay_timer.read_current_timer =3D tc_delay_timer_read32;
                 ^
drivers/clocksource/timer-atmel-tcb.c:461:17: error: invalid use of undefin=
ed type 'struct delay_timer'
   tc_delay_timer.read_current_timer =3D tc_delay_timer_read;
                 ^
drivers/clocksource/timer-atmel-tcb.c:476:16: error: invalid use of undefin=
ed type 'struct delay_timer'
  tc_delay_timer.freq =3D divided_rate;
                ^
drivers/clocksource/timer-atmel-tcb.c:477:2: error: implicit declaration of=
 function 'register_current_timer_delay'; did you mean 'read_current_timer'=
? [-Werror=3Dimplicit-function-declaration]
  register_current_timer_delay(&tc_delay_timer);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  read_current_timer
drivers/clocksource/timer-atmel-tcb.c: At top level:
drivers/clocksource/timer-atmel-tcb.c:129:27: error: storage size of 'tc_de=
lay_timer' isn't known
 static struct delay_timer tc_delay_timer;
                           ^~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  dd40f5020581 ("clocksource/drivers/tcb_clksrc: Register delay timer")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/uiNiVsT1gh9W9UsmKqw3sG.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz0gl4ACgkQAVBC80lX
0GymIAf6Am/0TmqRiFkcEGVXjoVYebQ0q9Oufbjgztq39uLYcVx/l/k4lZigNAMG
RFHwh+Q9M4qZ7Zo/6E5Fo3LUqGMVQehgcd2oQRRCel4Sh3PrVCCvGWPiCoctQ7HQ
jftHQr1u89MPuv0kHkh/bcpQBJRj0d7JTvPnyzBvcWQGxL70eBtRMX1SyIoFtFus
z4GsO/sir6pY92ef0UWmhIiFOPm5HFtW5qu6zDOjhorLlaVwTfdz21U1++GyVydU
tgQoij4cNnUa5zPj7sVsifFpGucTRhejpIlq/mpWdGVmcrHyELCjLphjKuk+KuW+
IibTnBJbpeUaEJjcRr+1LMqY+RMhQQ==
=69wL
-----END PGP SIGNATURE-----

--Sig_/uiNiVsT1gh9W9UsmKqw3sG.--

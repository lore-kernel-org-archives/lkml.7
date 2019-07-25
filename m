Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D671DC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E821734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WVoAOy8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfGYCba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:31:30 -0400
Received: from ozlabs.org ([203.11.71.1]:35559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388525AbfGYCba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:31:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vGRz1SVtz9s00;
        Thu, 25 Jul 2019 12:31:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564021887;
        bh=fGSuBCeypp34E2NiCYSbcZpIny6NTqpcpaPHZ1wGKx4=;
        h=Date:From:To:Cc:Subject:From;
        b=WVoAOy8a6FjdDQD8p/SNOW6qghI97FPIFkaFATX5IkfOjEKxy0Sj6pieG4bXOp0wq
         0lI2mg+DI80LqsFiRQ9YgMhD61vu6nZZJ9fd5CRPovBup20qFrhqf/Aldoy6ljH4Ob
         72dzkapCzgKezLhYjRwb9YfO82eA3BnMcSnEtK2ydwo+2QA5aIiJdJu20uDipaYoLN
         s7dapRv6+dYOJ7AHw1Lc3pKcJ1FmetDhYFfg/64cdCiVEUO6UPjjRYHJyhN3OyJL6P
         x+5Qsr+eG9Uj46Kuufm+EsHKKh/puyPrpPtQ2FJ2HupOjds5EkKrul3u4+ylo+TOEK
         Iwz1JIGZQE0uQ==
Date:   Thu, 25 Jul 2019 12:31:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: linux-next: build failure after merge of the leds tree
Message-ID: <20190725123126.725c77c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8_VVWf/7.doNQSjImMQe.Bq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8_VVWf/7.doNQSjImMQe.Bq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the leds tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/leds/leds-max77650.c: In function 'max77650_led_probe':
drivers/leds/leds-max77650.c:121:8: error: implicit declaration of function=
 'devm_of_led_classdev_register'; did you mean 'devm_led_classdev_register'=
? [-Werror=3Dimplicit-function-declaration]
   rv =3D devm_of_led_classdev_register(dev, child, &led->cdev);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        devm_led_classdev_register

Caused by commit

  4eba5b82096e ("leds: class: Improve LED and LED flash class registration =
API")

interacting with commit

  5be102eb161a ("leds: max77650: Add LEDs support")

I have used the leds tree from next-20190724 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/8_VVWf/7.doNQSjImMQe.Bq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl05FH4ACgkQAVBC80lX
0Gwxqgf/TAfUqalagcT4Xd9/W3PV4mTStwIBcWoeqn0gaCm/7GH8DzNKVIF79MKe
4tlS2vrmhBBnGfNSoXRzhGGJ8SOKXGhbFm3wutv8ZYVxSsmfmavMk0Sz2m9tgXTN
ZZ4c4vhy/mGkgbnQ/a42/Bjc7wHVpWCXI5FTwZpq+j9dUNJ8Ma+Xf8Oa8a1pNbev
Mxh3c1rAExzN//K9JbA/s5jqhxRLA5PGmS5OtUL2Rt9vkBJEBvrQK6ggH55sS2vj
eRMGg8xOmltZET8CStz15Sogv5m+85WBiYMbENNQMJ2VQq89SwFjN0/f6bMrarI+
pXmrTTkoUIkYUysvcREThY+yH7dF6Q==
=Gb3x
-----END PGP SIGNATURE-----

--Sig_/8_VVWf/7.doNQSjImMQe.Bq--

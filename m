Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4049C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7C420896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hse6Mnlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfFKAZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:25:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389362AbfFKAZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:25:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45N9l05HPNz9s4V;
        Tue, 11 Jun 2019 10:25:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560212734;
        bh=+pjp9tVwLHzqbgYi/uUfHPvnEWCcuFtRtQJA6NxxeN8=;
        h=Date:From:To:Cc:Subject:From;
        b=hse6MnlkUZ2KuXzFjV5185JJSPaPhPPaAgEa+BCb+a0KYtOWxrLyInOZFDDxJamvE
         P7snWhty1w9s7cZICncoKbbrZ/JwxOtUKdgIMKoQHIfTtFbt6EKBODU3qDdqbDLaN2
         zJP7PpALgSUEsNhOFAJHTdr2LFZiS7/OGdjhz3w6hZEVtwD+tjUxB1uV2sYRnPNGu1
         QJ3dN40a9UKRZ8+sRUYe1KlN7r965VXxG/zYydFAPqcOmIk+fzp97m9ILreif5KBhP
         5XMxYl4fyHHvV6nXYroGstu2JibYI+SOYK/7T5s49iw3djcpeAS7l5WowWZ4LuSQmH
         wjWzPuju9tAhQ==
Date:   Tue, 11 Jun 2019 10:25:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: linux-next: build warning after merge of the i2c tree
Message-ID: <20190611102528.44ad5783@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rcpwq3iNIji=dyHbg3r+3Dg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rcpwq3iNIji=dyHbg3r+3Dg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/media/dvb-frontends/tua6100.c: In function 'tua6100_set_params':
drivers/media/dvb-frontends/tua6100.c:71: warning: "_P" redefined
 #define _P 32
=20
In file included from include/acpi/platform/aclinux.h:54,
                 from include/acpi/platform/acenv.h:152,
                 from include/acpi/acpi.h:22,
                 from include/linux/acpi.h:21,
                 from include/linux/i2c.h:17,
                 from drivers/media/dvb-frontends/tua6100.h:22,
                 from drivers/media/dvb-frontends/tua6100.c:24:
include/linux/ctype.h:14: note: this is the location of the previous defini=
tion
 #define _P 0x10 /* punct */

Exposed by commit

  5213d7efc8ec ("i2c: acpi: export i2c_acpi_find_adapter_by_handle")

Since that included <linux/acpi.h> from <linux/i2c.h>

Originally introduced by commit

  00be2e7c6415 ("V4L/DVB (4606): Add driver for TUA6100")

The _P in <linux/ctype.h> has existed since before git.
--=20
Cheers,
Stephen Rothwell

--Sig_/rcpwq3iNIji=dyHbg3r+3Dg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz+9PgACgkQAVBC80lX
0GxZxQf7BUg/1oUdaJ2UcGAlyvb+0s7mMxJApFnoLBA9sC/ao2awXCbuyGy8BA7k
Ff4AhQoHu5q/FOaUquOBftuRZ0JZVbhw6dVOY5ulmUXnUcdlNFFroKUfVD4UU3g1
F8U9xYGeQ4ewGMzPsrMjPL5e9CAg7J0pfY7V7f/IjF48aJ/EFi4uA2rz4sCc2aoG
Co2QQXHbsJ8fG/MrL6cyTYIWg8trHh5if6fukFHJeSS73DOH/2nDn9e6MquzCnSG
daYXFeiJNyJDKOudw32+zbSQU4qH38p1hPvhUIpoKGKAHILAD20DK4gjd9It+nw9
6c2JsRZSBau1PNnWSrAUHAgGrzTREQ==
=u22Y
-----END PGP SIGNATURE-----

--Sig_/rcpwq3iNIji=dyHbg3r+3Dg--

Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B03AC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE63C2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dnFPVfJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEOFX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:23:56 -0400
Received: from ozlabs.org ([203.11.71.1]:47843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOFX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:23:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 453jdj3H7kz9s3q;
        Wed, 15 May 2019 15:23:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557897833;
        bh=HKtRqT95fMWpgGUEtteCItQk0zAydtyXJGGCafMscX0=;
        h=Date:From:To:Cc:Subject:From;
        b=dnFPVfJQbzRfXlUg7ATgT+BOW9lbkra54pAKTFukx3atJlEaG196IA8ZZs0WVkxE1
         qpeeWFHqcbAZUs7SjDOhiW5pu2UP/6sC99ea4RhRoiJg0jPombZev5kHxd2CxL1bpF
         uyiLFFIR13ZvT65eeHjtrlsnvNzQXOFdmnEfj5DwlmPu5VUvBquSP8jk2km09wHu5z
         ne9+nhAh+REz/4EaQkAidbsfnQ7QdyyAKawgzAx/8VOiUOeiHpJXqkxBtjKBwpbN/w
         9UTTz1ZP/3xnruamWL6LRyqgHIsy2CsrYFU0vhCvCp4Gik8gVmu27OH5TQhXjJljNe
         WiGv5Jcw+AzLw==
Date:   Wed, 15 May 2019 15:23:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/compat.c: mark expected switch fall-throughs
Message-ID: <20190515152352.26dac479@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o=5Dr.yTyRmquu8K7bXatxC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o=5Dr.yTyRmquu8K7bXatxC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch aims to suppress 3 missing-break-in-switch false positives
on some architectures.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/compat.c | 3 +++
 1 file changed, 3 insertions(+)

Hi Linus,

This has been sitting in my fixes tree in linux-next for quite some
time.  It silences some warnings that irritated me in my builds since I
am building with -Wimplicit-fallthrough to help Gustavo catch new
additions.

diff --git a/kernel/compat.c b/kernel/compat.c
index d8a36c6ad7c9..b5f7063c0db6 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -346,8 +346,11 @@ get_compat_sigset(sigset_t *set, const compat_sigset_t=
 __user *compat)
 		return -EFAULT;
 	switch (_NSIG_WORDS) {
 	case 4: set->sig[3] =3D v.sig[6] | (((long)v.sig[7]) << 32 );
+		/* fall through */
 	case 3: set->sig[2] =3D v.sig[4] | (((long)v.sig[5]) << 32 );
+		/* fall through */
 	case 2: set->sig[1] =3D v.sig[2] | (((long)v.sig[3]) << 32 );
+		/* fall through */
 	case 1: set->sig[0] =3D v.sig[0] | (((long)v.sig[1]) << 32 );
 	}
 #else
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/o=5Dr.yTyRmquu8K7bXatxC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzbomgACgkQAVBC80lX
0GzjMgf+KB+cFxudcloxl70eUYKsHDk/IQkVO5qgPeQgW5wIcoxQEnf595I8IYUh
7UktGpfs7pRpS6L3pHuLorMA7/ZVFoz9YTXJv8S6tv1aTNJNcW4Zs0hLgkiRSKl+
uCM9ydXEjtN6P2FMYJnn1dxaPaZezxaOycpVFffXr1XT0h6uSiEwYKT7BkOBILZC
LxsoUEtG5PKlR700QgkAaIPZSGf00IrkHxz4G9lu4gRG4jXTYASZRPzTR5X9cu6R
X4hNxJALHlFo9dYyC2ni1pB/LX0ekim/055Z9TyjYVvPDhAIRxThWbuJR2nLI29Q
GHFIBsa6nlqMqP/n/0Sc6kXUgzwXTQ==
=HenF
-----END PGP SIGNATURE-----

--Sig_/o=5Dr.yTyRmquu8K7bXatxC--

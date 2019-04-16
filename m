Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC0FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A517820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KhU4NPQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfDPH3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:29:40 -0400
Received: from ozlabs.org ([203.11.71.1]:35819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPH3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:29:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jxp96NRRz9s4V;
        Tue, 16 Apr 2019 17:29:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555399778;
        bh=caDODhw99/IFszsvF0UFY5mNkDhIxcv8gE9mO4tui8w=;
        h=Date:From:To:Cc:Subject:From;
        b=KhU4NPQ6qap+/nvFD7YizA2rsvCUlaP7c7OcKujLuohnIsUvVf/Io+McLxz3jz+aT
         LMe7Fs9DK4Fu7JufEVtT8rxWptuv+AK0YckhHj6lsxD1Fmy52Ml/gbr3V8u77J8A+k
         +X+G9q+AMTQaJAUZS/5a0UPTq6gB9kBli+CYYxH2CcoGZiKS0ow2okeiyANR+yuI1n
         gzLEF5JvxokT+En7Xwm8LJk2M9LMHw0P8CSjHH3yEiqaIn8BBgDLDZ1A84C5Iv5e2L
         Nf2l4bkqATDWt8J7QFdnzn6toCq0nPhefVffuxk5hlLbrrdcZKXVHh8osFGD/3IkwI
         300fpQImNUxmw==
Date:   Tue, 16 Apr 2019 17:29:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: [PATCH] kernel/compat.c: mark expected switch fall-throughs
Message-ID: <20190416172937.6a7621f7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m7Z=8Z55fmMr=gQhbzr6GTP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m7Z=8Z55fmMr=gQhbzr6GTP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch aims to suppress up to 3 missing-break-in-switch false
positives on some architectures.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/compat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

I know that this makes the lines longer than 80 characters, but I
though that this was better than adding new lines.

Build tested on PowerPC.

diff --git a/kernel/compat.c b/kernel/compat.c
index d8a36c6ad7c9..b61f75df188d 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -345,9 +345,9 @@ get_compat_sigset(sigset_t *set, const compat_sigset_t =
__user *compat)
 	if (copy_from_user(&v, compat, sizeof(compat_sigset_t)))
 		return -EFAULT;
 	switch (_NSIG_WORDS) {
-	case 4: set->sig[3] =3D v.sig[6] | (((long)v.sig[7]) << 32 );
-	case 3: set->sig[2] =3D v.sig[4] | (((long)v.sig[5]) << 32 );
-	case 2: set->sig[1] =3D v.sig[2] | (((long)v.sig[3]) << 32 );
+	case 4: set->sig[3] =3D v.sig[6] | (((long)v.sig[7]) << 32 ); /* fall thr=
ough */
+	case 3: set->sig[2] =3D v.sig[4] | (((long)v.sig[5]) << 32 ); /* fall thr=
ough */
+	case 2: set->sig[1] =3D v.sig[2] | (((long)v.sig[3]) << 32 ); /* fall thr=
ough */
 	case 1: set->sig[0] =3D v.sig[0] | (((long)v.sig[1]) << 32 );
 	}
 #else
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/m7Z=8Z55fmMr=gQhbzr6GTP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1hGEACgkQAVBC80lX
0GxexQf9EJWXNPyvOiEDZrTcqQT86pMzKVlCtRJe1qNQyNPnJNXPDW93807Ckw0l
hWbxj9Gp3QcyVQ217eXZlT1alLYM89WD+UkMAfYaD4GHGGIGpYlhnCsLFc3V8O84
f4xqq413X6gxziZwVwHCUhRBQt+Vg//6yTcddF6jy38jc45olvkxod4fiGoeHsRt
dxA14k7oCDndVVQTPFOfr0EdkTXkWUvJAPQSyU2VVcbA9nMRRWGsobmdDkhO+MBk
LYcXuRo7MA9gZN096VVxFQyQ1rljHuLBDyDphK/SEOETkKA0Eb5EufDf7wESqaho
KuEpsER8ZkncZykr3GDNZm49VWcqOw==
=QPy1
-----END PGP SIGNATURE-----

--Sig_/m7Z=8Z55fmMr=gQhbzr6GTP--

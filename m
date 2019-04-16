Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C850AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ED920684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hkWSChtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfDPJuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:50:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36349 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfDPJue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:50:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44k0wl6VLFz9s00;
        Tue, 16 Apr 2019 19:50:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555408232;
        bh=FhaAi/UdIsuMVIMyShMCKj8q2XBVunudT8LzXWzosUI=;
        h=Date:From:To:Cc:Subject:From;
        b=hkWSChtLwt93z+1Sf+lQ+n0fx2jXPPhwgSr/qBNhJzXyxhuF6HHFknFRE8j0KxKIV
         FyLhzpdv3nvBmdheZw26WcAIoEM4IYg0Lb16jAhd5rWF2UW5ODRN92dGcuKyH2wzPB
         qmuDd9iw3Ll5rkHoT0IztNSFbxRtq2f1+2XG23LCwpbkQbxJTMqrISKcMUzBD0BWUD
         mCl7H58tnGWN8p0WKSvJUmSlDkqdS/Nu3OQSSQqs0dDY6V3VXakjxfdbbTW/D8Qt7+
         VHpsrsCTbs31c166lGNUMjPMlTmI/HyB274GUGOjlwIudLuELT61SJHwnW1sifEK01
         fI0lCCPuV7YCw==
Date:   Tue, 16 Apr 2019 19:50:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: [PATCH v2] kernel/compat.c: mark expected switch fall-throughs
Message-ID: <20190416195029.004b7ab4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9ZAiCiAxpMGP9lVgOhjImwf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9ZAiCiAxpMGP9lVgOhjImwf
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

  v2 - split the comments on to new lines to match commit 89976005536c
("include/linux/compat.h: mark expected switch fall-throughs").  (Arnd
Bergmann)

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

--Sig_/9ZAiCiAxpMGP9lVgOhjImwf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1pWUACgkQAVBC80lX
0GwWhwgAo4C/AGvlYBHX9bzhV9/DelOpVkiLbCsR3zMJeqaRt7qLW2EgxM5x4hfE
vyS7NdU+O55BlmDHW1n48kMe9MzcHCfjzEMxiAp0ZIgrG7vLuQrBp7Ofk8DebVmV
3FHSX0+ck4+aOE+FlcMLhkGhG+ynATfIzo9zPc1a3N/4u5E+VkyB3mPV0RpG3uje
usvk9G+rO0Oeqy26uK4mXGHafPWqTSwox2hBU4xJ5ls5qoH2bxu898DuO79k4a6B
SsxoeuHtXshr5ZEDy5YyJjDGHGdwcFN4xJyZ4jGs9LoUZ7OBkZrsV4X2d9lPeNSA
A5ylhB6z9TLtA3qE0/Lz9mVgTMJRnw==
=Fb9G
-----END PGP SIGNATURE-----

--Sig_/9ZAiCiAxpMGP9lVgOhjImwf--

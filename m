Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15FEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D90920675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JP2Pnu4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfDPH1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:27:25 -0400
Received: from ozlabs.org ([203.11.71.1]:53491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfDPH1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:27:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jxlY37bPz9s3q;
        Tue, 16 Apr 2019 17:27:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555399641;
        bh=ySBSmcn1rdVSiCXo1fcDhh/RmSKw7YxqJLMjHc7CfPE=;
        h=Date:From:To:Cc:Subject:From;
        b=JP2Pnu4OuX9WWKDrG5tL1ReFcIa6gZQ5eODWmDOAfkYgbb+lDkCpOMexDadvyrjbz
         yuN90Viz0Skjoa3wVA4+gxOGZnTmvCIG5cAUmid2JxhqItfW8LtNuP9i+0JsUoY2ws
         sWHDNDg80ulCSuNA1HQ1Gri4trhFabk+Q/vHbB8MO/4B7FE1ZYNsNo/f9imhxWSwvW
         7cu/7tD19kZIqJG3aiIKigTS5vjy5n8Ag0ijHJ6KE/ZpdAZtmrceD6DZDsI4ukkwga
         OqK8ARoDJscFzxTfsU9Sr4E2t2lF/abMopKQ8yMNRcXRHUITTUYpJk3EnstHu0fUJT
         XoXJOo7D9d0Hg==
Date:   Tue, 16 Apr 2019 17:27:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib/siphash.c: mark expected switch fall-throughs
Message-ID: <20190416172720.68e8b95f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Qn.XaSU2md=eAMclBSozIV5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qn.XaSU2md=eAMclBSozIV5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch aims to suppress up to 18 missing-break-in-switch false
positives on some architectures.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/siphash.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

Build tested on PowerPC.

diff --git a/lib/siphash.c b/lib/siphash.c
index 3ae58b4edad6..c47bb6ff2149 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -68,11 +68,11 @@ u64 __siphash_aligned(const void *data, size_t len, con=
st siphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |=3D ((u64)end[6]) << 48;
-	case 6: b |=3D ((u64)end[5]) << 40;
-	case 5: b |=3D ((u64)end[4]) << 32;
+	case 7: b |=3D ((u64)end[6]) << 48; /* fall through */
+	case 6: b |=3D ((u64)end[5]) << 40; /* fall through */
+	case 5: b |=3D ((u64)end[4]) << 32; /* fall through */
 	case 4: b |=3D le32_to_cpup(data); break;
-	case 3: b |=3D ((u64)end[2]) << 16;
+	case 3: b |=3D ((u64)end[2]) << 16; /* fall through */
 	case 2: b |=3D le16_to_cpup(data); break;
 	case 1: b |=3D end[0];
 	}
@@ -101,11 +101,11 @@ u64 __siphash_unaligned(const void *data, size_t len,=
 const siphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |=3D ((u64)end[6]) << 48;
-	case 6: b |=3D ((u64)end[5]) << 40;
-	case 5: b |=3D ((u64)end[4]) << 32;
+	case 7: b |=3D ((u64)end[6]) << 48; /* fall through */
+	case 6: b |=3D ((u64)end[5]) << 40; /* fall through */
+	case 5: b |=3D ((u64)end[4]) << 32; /* fall through */
 	case 4: b |=3D get_unaligned_le32(end); break;
-	case 3: b |=3D ((u64)end[2]) << 16;
+	case 3: b |=3D ((u64)end[2]) << 16; /* fall through */
 	case 2: b |=3D get_unaligned_le16(end); break;
 	case 1: b |=3D end[0];
 	}
@@ -268,11 +268,11 @@ u32 __hsiphash_aligned(const void *data, size_t len, =
const hsiphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |=3D ((u64)end[6]) << 48;
-	case 6: b |=3D ((u64)end[5]) << 40;
-	case 5: b |=3D ((u64)end[4]) << 32;
+	case 7: b |=3D ((u64)end[6]) << 48; /* fall through */
+	case 6: b |=3D ((u64)end[5]) << 40; /* fall through */
+	case 5: b |=3D ((u64)end[4]) << 32; /* fall through */
 	case 4: b |=3D le32_to_cpup(data); break;
-	case 3: b |=3D ((u64)end[2]) << 16;
+	case 3: b |=3D ((u64)end[2]) << 16; /* fall through */
 	case 2: b |=3D le16_to_cpup(data); break;
 	case 1: b |=3D end[0];
 	}
@@ -301,11 +301,11 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |=3D ((u64)end[6]) << 48;
-	case 6: b |=3D ((u64)end[5]) << 40;
-	case 5: b |=3D ((u64)end[4]) << 32;
+	case 7: b |=3D ((u64)end[6]) << 48; /* fall through */
+	case 6: b |=3D ((u64)end[5]) << 40; /* fall through */
+	case 5: b |=3D ((u64)end[4]) << 32; /* fall through */
 	case 4: b |=3D get_unaligned_le32(end); break;
-	case 3: b |=3D ((u64)end[2]) << 16;
+	case 3: b |=3D ((u64)end[2]) << 16; /* fall through */
 	case 2: b |=3D get_unaligned_le16(end); break;
 	case 1: b |=3D end[0];
 	}
@@ -431,7 +431,7 @@ u32 __hsiphash_aligned(const void *data, size_t len, co=
nst hsiphash_key_t *key)
 		v0 ^=3D m;
 	}
 	switch (left) {
-	case 3: b |=3D ((u32)end[2]) << 16;
+	case 3: b |=3D ((u32)end[2]) << 16; /* fall through */
 	case 2: b |=3D le16_to_cpup(data); break;
 	case 1: b |=3D end[0];
 	}
@@ -454,7 +454,7 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 		v0 ^=3D m;
 	}
 	switch (left) {
-	case 3: b |=3D ((u32)end[2]) << 16;
+	case 3: b |=3D ((u32)end[2]) << 16; /* fall through */
 	case 2: b |=3D get_unaligned_le16(end); break;
 	case 1: b |=3D end[0];
 	}
--=20
2.20.1



--=20
Cheers,
Stephen Rothwell

--Sig_/Qn.XaSU2md=eAMclBSozIV5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1g9gACgkQAVBC80lX
0Gz0EAf/X/HZk/WV5b0f9yiLnB4QmA89JQDL8FDxH0g4xqfFETSJejmC3dcoZKaI
G5HoMrIcKYEJwPbZQJsdTZ4T9CBg9NLumml7LGLBihLwKLTg/xBMt9w3i8RiRgW1
K6UQgKvF654Jt/Wyt7zhjNQO0nlnLEQ3nqacS1bsv1ZqLHVEj8jvzm4OO1K+AjYP
UlA+TzMq+rArZY6Bqlgtlf6AOCP44kEVdkPoMZ71dq1zpkDl6o9Zoas14XrdtI6A
AAERKeG+GpGSJuzFuZMDNzT/soF9M8ZAkn/YemHs9Eip4heZHtBkg25poNngkE/v
8zsRyXQPmSIf8rHWoraiWQ27SqBi/g==
=wsb6
-----END PGP SIGNATURE-----

--Sig_/Qn.XaSU2md=eAMclBSozIV5--

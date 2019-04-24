Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87751C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480F72064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127672;
	bh=feOwiJ8ESn2URnBYrx0fsPm/RYYXylGKEoOmoT2lWxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0gByDpVBK7oIpkK2sP1XEOYSaszc72iiXcOiKlWDLYB5PmIx3WxboNLUa2nhEMWv
	 kOaHgikivhWntih600e/LK/Ts5HAsbbKa7rnm+wcBcDeaUMP50wQITnHxB77KnGFE9
	 te57Q3PT/LtrU/TP9Li7QnENlc7YA216nuxwwBq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392265AbfDXRlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392190AbfDXRg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:57 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A2021915;
        Wed, 24 Apr 2019 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127416;
        bh=feOwiJ8ESn2URnBYrx0fsPm/RYYXylGKEoOmoT2lWxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTJbfMMzSrQa3WQkyT9LcoZnJhUTYugi0qft52jkixKzJDnSvTVIsqN3on01z50+E
         2X72cqk061vWxrmAwQRkyPluimQjAdH59uiPG9rVEjc5MzYvITQ4aV1yRgdKSTPg4t
         qJ7lDzFmay12D/UMZS6izZTbOOSFVQXLxqFr3jl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 084/115] crypto: x86/poly1305 - fix overflow during partial reduction
Date:   Wed, 24 Apr 2019 19:10:20 +0200
Message-Id: <20190424170929.837946597@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 678cce4019d746da6c680c48ba9e6d417803e127 upstream.

The x86_64 implementation of Poly1305 produces the wrong result on some
inputs because poly1305_4block_avx2() incorrectly assumes that when
partially reducing the accumulator, the bits carried from limb 'd4' to
limb 'h0' fit in a 32-bit integer.  This is true for poly1305-generic
which processes only one block at a time.  However, it's not true for
the AVX2 implementation, which processes 4 blocks at a time and
therefore can produce intermediate limbs about 4x larger.

Fix it by making the relevant calculations use 64-bit arithmetic rather
than 32-bit.  Note that most of the carries already used 64-bit
arithmetic, but the d4 -> h0 carry was different for some reason.

To be safe I also made the same change to the corresponding SSE2 code,
though that only operates on 1 or 2 blocks at a time.  I don't think
it's really needed for poly1305_block_sse2(), but it doesn't hurt
because it's already x86_64 code.  It *might* be needed for
poly1305_2block_sse2(), but overflows aren't easy to reproduce there.

This bug was originally detected by my patches that improve testmgr to
fuzz algorithms against their generic implementation.  But also add a
test vector which reproduces it directly (in the AVX2 case).

Fixes: b1ccc8f4b631 ("crypto: poly1305 - Add a four block AVX2 variant for x86_64")
Fixes: c70f4abef07a ("crypto: poly1305 - Add a SSE2 SIMD variant for x86_64")
Cc: <stable@vger.kernel.org> # v4.3+
Cc: Martin Willi <martin@strongswan.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/poly1305-avx2-x86_64.S |   14 +++++++---
 arch/x86/crypto/poly1305-sse2-x86_64.S |   22 ++++++++++------
 crypto/testmgr.h                       |   44 ++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 13 deletions(-)

--- a/arch/x86/crypto/poly1305-avx2-x86_64.S
+++ b/arch/x86/crypto/poly1305-avx2-x86_64.S
@@ -323,6 +323,12 @@ ENTRY(poly1305_4block_avx2)
 	vpaddq		t2,t1,t1
 	vmovq		t1x,d4
 
+	# Now do a partial reduction mod (2^130)-5, carrying h0 -> h1 -> h2 ->
+	# h3 -> h4 -> h0 -> h1 to get h0,h2,h3,h4 < 2^26 and h1 < 2^26 + a small
+	# amount.  Careful: we must not assume the carry bits 'd0 >> 26',
+	# 'd1 >> 26', 'd2 >> 26', 'd3 >> 26', and '(d4 >> 26) * 5' fit in 32-bit
+	# integers.  It's true in a single-block implementation, but not here.
+
 	# d1 += d0 >> 26
 	mov		d0,%rax
 	shr		$26,%rax
@@ -361,16 +367,16 @@ ENTRY(poly1305_4block_avx2)
 	# h0 += (d4 >> 26) * 5
 	mov		d4,%rax
 	shr		$26,%rax
-	lea		(%eax,%eax,4),%eax
-	add		%eax,%ebx
+	lea		(%rax,%rax,4),%rax
+	add		%rax,%rbx
 	# h4 = d4 & 0x3ffffff
 	mov		d4,%rax
 	and		$0x3ffffff,%eax
 	mov		%eax,h4
 
 	# h1 += h0 >> 26
-	mov		%ebx,%eax
-	shr		$26,%eax
+	mov		%rbx,%rax
+	shr		$26,%rax
 	add		%eax,h1
 	# h0 = h0 & 0x3ffffff
 	andl		$0x3ffffff,%ebx
--- a/arch/x86/crypto/poly1305-sse2-x86_64.S
+++ b/arch/x86/crypto/poly1305-sse2-x86_64.S
@@ -253,16 +253,16 @@ ENTRY(poly1305_block_sse2)
 	# h0 += (d4 >> 26) * 5
 	mov		d4,%rax
 	shr		$26,%rax
-	lea		(%eax,%eax,4),%eax
-	add		%eax,%ebx
+	lea		(%rax,%rax,4),%rax
+	add		%rax,%rbx
 	# h4 = d4 & 0x3ffffff
 	mov		d4,%rax
 	and		$0x3ffffff,%eax
 	mov		%eax,h4
 
 	# h1 += h0 >> 26
-	mov		%ebx,%eax
-	shr		$26,%eax
+	mov		%rbx,%rax
+	shr		$26,%rax
 	add		%eax,h1
 	# h0 = h0 & 0x3ffffff
 	andl		$0x3ffffff,%ebx
@@ -520,6 +520,12 @@ ENTRY(poly1305_2block_sse2)
 	paddq		t2,t1
 	movq		t1,d4
 
+	# Now do a partial reduction mod (2^130)-5, carrying h0 -> h1 -> h2 ->
+	# h3 -> h4 -> h0 -> h1 to get h0,h2,h3,h4 < 2^26 and h1 < 2^26 + a small
+	# amount.  Careful: we must not assume the carry bits 'd0 >> 26',
+	# 'd1 >> 26', 'd2 >> 26', 'd3 >> 26', and '(d4 >> 26) * 5' fit in 32-bit
+	# integers.  It's true in a single-block implementation, but not here.
+
 	# d1 += d0 >> 26
 	mov		d0,%rax
 	shr		$26,%rax
@@ -558,16 +564,16 @@ ENTRY(poly1305_2block_sse2)
 	# h0 += (d4 >> 26) * 5
 	mov		d4,%rax
 	shr		$26,%rax
-	lea		(%eax,%eax,4),%eax
-	add		%eax,%ebx
+	lea		(%rax,%rax,4),%rax
+	add		%rax,%rbx
 	# h4 = d4 & 0x3ffffff
 	mov		d4,%rax
 	and		$0x3ffffff,%eax
 	mov		%eax,h4
 
 	# h1 += h0 >> 26
-	mov		%ebx,%eax
-	shr		$26,%eax
+	mov		%rbx,%rax
+	shr		$26,%rax
 	add		%eax,h1
 	# h0 = h0 & 0x3ffffff
 	andl		$0x3ffffff,%ebx
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -5706,7 +5706,49 @@ static const struct hash_testvec poly130
 		.psize		= 80,
 		.digest		= "\x13\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
-	},
+	}, { /* Regression test for overflow in AVX2 implementation */
+		.plaintext	= "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff",
+		.psize		= 300,
+		.digest		= "\xfb\x5e\x96\xd8\x61\xd5\xc7\xc8"
+				  "\x78\xe5\x87\xcc\x2d\x5a\x22\xe1",
+	}
 };
 
 /* NHPoly1305 test vectors from https://github.com/google/adiantum */



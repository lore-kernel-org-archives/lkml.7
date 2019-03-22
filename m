Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8537204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256187;
	bh=Coz5JRkHZhxkRwu4/Y5gofM4WFI0cWoargxD6sv1M0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gYjxRAY16iUSvm3/P2u1c36agsuNHpW6yhjznAuVXPJSx44A8YxYGljpa7BrS87G5
	 j0CBbh2n8WNHzMFgOxbu2QFQdBtyHlK5B0evviMZZ6Cf7US2tIYWkk0NHtQrw9rtc7
	 Gca51X7iCAlM1XSiczo/j5PX88L/imRS33AEeip8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbfCVMDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388446AbfCVMC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44A321B24;
        Fri, 22 Mar 2019 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256178;
        bh=Coz5JRkHZhxkRwu4/Y5gofM4WFI0cWoargxD6sv1M0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+ajLYTctsE6+494Z58RuzSMXhQRUS8IkDyC6DcYSy4bp3ENP5L/zq+hOCnkXmbW2
         8kU2jkY8JxcNHXEtuQEhgUgkXOwqqmjjWfUvxHLmzgh4Mw6x7hOcEiB/mFe9tyMavH
         lue3vljFHGHMrANbyzhEOuPEITQxggB2K/0x5E8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 132/280] crypto: x86/aegis - fix handling chunked inputs and MAY_SLEEP
Date:   Fri, 22 Mar 2019 12:14:45 +0100
Message-Id: <20190322111316.835283946@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit ba6771c0a0bc2fac9d6a8759bab8493bd1cffe3b upstream.

The x86 AEGIS implementations all fail the improved AEAD tests because
they produce the wrong result with some data layouts.  The issue is that
they assume that if the skcipher_walk API gives 'nbytes' not aligned to
the walksize (a.k.a. walk.stride), then it is the end of the data.  In
fact, this can happen before the end.

Also, when the CRYPTO_TFM_REQ_MAY_SLEEP flag is given, they can
incorrectly sleep in the skcipher_walk_*() functions while preemption
has been disabled by kernel_fpu_begin().

Fix these bugs.

Fixes: 1d373d4e8e15 ("crypto: x86 - Add optimized AEGIS implementations")
Cc: <stable@vger.kernel.org> # v4.18+
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aegis128-aesni-glue.c  |   38 +++++++++++++--------------------
 arch/x86/crypto/aegis128l-aesni-glue.c |   38 +++++++++++++--------------------
 arch/x86/crypto/aegis256-aesni-glue.c  |   38 +++++++++++++--------------------
 3 files changed, 45 insertions(+), 69 deletions(-)

--- a/arch/x86/crypto/aegis128-aesni-glue.c
+++ b/arch/x86/crypto/aegis128-aesni-glue.c
@@ -119,31 +119,20 @@ static void crypto_aegis128_aesni_proces
 }
 
 static void crypto_aegis128_aesni_process_crypt(
-		struct aegis_state *state, struct aead_request *req,
+		struct aegis_state *state, struct skcipher_walk *walk,
 		const struct aegis_crypt_ops *ops)
 {
-	struct skcipher_walk walk;
-	u8 *src, *dst;
-	unsigned int chunksize, base;
-
-	ops->skcipher_walk_init(&walk, req, false);
-
-	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
-
-		ops->crypt_blocks(state, chunksize, src, dst);
-
-		base = chunksize & ~(AEGIS128_BLOCK_SIZE - 1);
-		src += base;
-		dst += base;
-		chunksize &= AEGIS128_BLOCK_SIZE - 1;
-
-		if (chunksize > 0)
-			ops->crypt_tail(state, chunksize, src, dst);
+	while (walk->nbytes >= AEGIS128_BLOCK_SIZE) {
+		ops->crypt_blocks(state,
+				  round_down(walk->nbytes, AEGIS128_BLOCK_SIZE),
+				  walk->src.virt.addr, walk->dst.virt.addr);
+		skcipher_walk_done(walk, walk->nbytes % AEGIS128_BLOCK_SIZE);
+	}
 
-		skcipher_walk_done(&walk, 0);
+	if (walk->nbytes) {
+		ops->crypt_tail(state, walk->nbytes, walk->src.virt.addr,
+				walk->dst.virt.addr);
+		skcipher_walk_done(walk, 0);
 	}
 }
 
@@ -186,13 +175,16 @@ static void crypto_aegis128_aesni_crypt(
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aegis_ctx *ctx = crypto_aegis128_aesni_ctx(tfm);
+	struct skcipher_walk walk;
 	struct aegis_state state;
 
+	ops->skcipher_walk_init(&walk, req, true);
+
 	kernel_fpu_begin();
 
 	crypto_aegis128_aesni_init(&state, ctx->key.bytes, req->iv);
 	crypto_aegis128_aesni_process_ad(&state, req->src, req->assoclen);
-	crypto_aegis128_aesni_process_crypt(&state, req, ops);
+	crypto_aegis128_aesni_process_crypt(&state, &walk, ops);
 	crypto_aegis128_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
 
 	kernel_fpu_end();
--- a/arch/x86/crypto/aegis128l-aesni-glue.c
+++ b/arch/x86/crypto/aegis128l-aesni-glue.c
@@ -119,31 +119,20 @@ static void crypto_aegis128l_aesni_proce
 }
 
 static void crypto_aegis128l_aesni_process_crypt(
-		struct aegis_state *state, struct aead_request *req,
+		struct aegis_state *state, struct skcipher_walk *walk,
 		const struct aegis_crypt_ops *ops)
 {
-	struct skcipher_walk walk;
-	u8 *src, *dst;
-	unsigned int chunksize, base;
-
-	ops->skcipher_walk_init(&walk, req, false);
-
-	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
-
-		ops->crypt_blocks(state, chunksize, src, dst);
-
-		base = chunksize & ~(AEGIS128L_BLOCK_SIZE - 1);
-		src += base;
-		dst += base;
-		chunksize &= AEGIS128L_BLOCK_SIZE - 1;
-
-		if (chunksize > 0)
-			ops->crypt_tail(state, chunksize, src, dst);
+	while (walk->nbytes >= AEGIS128L_BLOCK_SIZE) {
+		ops->crypt_blocks(state, round_down(walk->nbytes,
+						    AEGIS128L_BLOCK_SIZE),
+				  walk->src.virt.addr, walk->dst.virt.addr);
+		skcipher_walk_done(walk, walk->nbytes % AEGIS128L_BLOCK_SIZE);
+	}
 
-		skcipher_walk_done(&walk, 0);
+	if (walk->nbytes) {
+		ops->crypt_tail(state, walk->nbytes, walk->src.virt.addr,
+				walk->dst.virt.addr);
+		skcipher_walk_done(walk, 0);
 	}
 }
 
@@ -186,13 +175,16 @@ static void crypto_aegis128l_aesni_crypt
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aegis_ctx *ctx = crypto_aegis128l_aesni_ctx(tfm);
+	struct skcipher_walk walk;
 	struct aegis_state state;
 
+	ops->skcipher_walk_init(&walk, req, true);
+
 	kernel_fpu_begin();
 
 	crypto_aegis128l_aesni_init(&state, ctx->key.bytes, req->iv);
 	crypto_aegis128l_aesni_process_ad(&state, req->src, req->assoclen);
-	crypto_aegis128l_aesni_process_crypt(&state, req, ops);
+	crypto_aegis128l_aesni_process_crypt(&state, &walk, ops);
 	crypto_aegis128l_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
 
 	kernel_fpu_end();
--- a/arch/x86/crypto/aegis256-aesni-glue.c
+++ b/arch/x86/crypto/aegis256-aesni-glue.c
@@ -119,31 +119,20 @@ static void crypto_aegis256_aesni_proces
 }
 
 static void crypto_aegis256_aesni_process_crypt(
-		struct aegis_state *state, struct aead_request *req,
+		struct aegis_state *state, struct skcipher_walk *walk,
 		const struct aegis_crypt_ops *ops)
 {
-	struct skcipher_walk walk;
-	u8 *src, *dst;
-	unsigned int chunksize, base;
-
-	ops->skcipher_walk_init(&walk, req, false);
-
-	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
-
-		ops->crypt_blocks(state, chunksize, src, dst);
-
-		base = chunksize & ~(AEGIS256_BLOCK_SIZE - 1);
-		src += base;
-		dst += base;
-		chunksize &= AEGIS256_BLOCK_SIZE - 1;
-
-		if (chunksize > 0)
-			ops->crypt_tail(state, chunksize, src, dst);
+	while (walk->nbytes >= AEGIS256_BLOCK_SIZE) {
+		ops->crypt_blocks(state,
+				  round_down(walk->nbytes, AEGIS256_BLOCK_SIZE),
+				  walk->src.virt.addr, walk->dst.virt.addr);
+		skcipher_walk_done(walk, walk->nbytes % AEGIS256_BLOCK_SIZE);
+	}
 
-		skcipher_walk_done(&walk, 0);
+	if (walk->nbytes) {
+		ops->crypt_tail(state, walk->nbytes, walk->src.virt.addr,
+				walk->dst.virt.addr);
+		skcipher_walk_done(walk, 0);
 	}
 }
 
@@ -186,13 +175,16 @@ static void crypto_aegis256_aesni_crypt(
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct aegis_ctx *ctx = crypto_aegis256_aesni_ctx(tfm);
+	struct skcipher_walk walk;
 	struct aegis_state state;
 
+	ops->skcipher_walk_init(&walk, req, true);
+
 	kernel_fpu_begin();
 
 	crypto_aegis256_aesni_init(&state, ctx->key, req->iv);
 	crypto_aegis256_aesni_process_ad(&state, req->src, req->assoclen);
-	crypto_aegis256_aesni_process_crypt(&state, req, ops);
+	crypto_aegis256_aesni_process_crypt(&state, &walk, ops);
 	crypto_aegis256_aesni_final(&state, tag_xor, req->assoclen, cryptlen);
 
 	kernel_fpu_end();



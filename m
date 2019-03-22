Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFBAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F17920830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256800;
	bh=5UNtJZjwprzDjSdcbXs8J/nuzwpGpbrTzK2eupkEAcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kc+hpA4va7WF709TZkPRlOcRKvzUS+8KGUxBUO/1/+ymDYg71cTg1k++fNEHUOIzc
	 K6+gmkkFFleb3b8YZn/+PVeLEq8hLxenSX+dz9fWNgEjjinOO4NtGB8XKpTwMWIRrT
	 XTvxpYwBHYHoKG6RRrWXEMZTyG1aL2boc49wELyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbfCVMNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389446AbfCVMNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6042082C;
        Fri, 22 Mar 2019 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256792;
        bh=5UNtJZjwprzDjSdcbXs8J/nuzwpGpbrTzK2eupkEAcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBc4BAdmI9owCopxLP41tLHkoikLH8EuCHf3+prwI0jfKKQc5gnNqnHH73VO2EvR7
         xIkOg71HM6IliRUYCrLsgPhtK9pbvFkmroTkh+YbRV6YxekXVJSou0qY4zXX23EAZV
         /74NRW/2R78QB14W1/Q/4oL5LR3YmhCbPGPASNtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 021/238] crypto: ofb - fix handling partial blocks and make thread-safe
Date:   Fri, 22 Mar 2019 12:14:00 +0100
Message-Id: <20190322111259.405478019@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit b3e3e2db7de4a1ffe8845876c3520b866cd48de1 upstream.

Fix multiple bugs in the OFB implementation:

1. It stored the per-request state 'cnt' in the tfm context, which can be
   used by multiple threads concurrently (e.g. via AF_ALG).
2. It didn't support messages not a multiple of the block cipher size,
   despite being a stream cipher.
3. It didn't set cra_blocksize to 1 to indicate it is a stream cipher.

To fix these, set the 'chunksize' property to the cipher block size to
guarantee that when walking through the scatterlist, a partial block can
only occur at the end.  Then change the implementation to XOR a block at
a time at first, then XOR the partial block at the end if needed.  This
is the same way CTR and CFB are implemented.  As a bonus, this also
improves performance in most cases over the current approach.

Fixes: e497c51896b3 ("crypto: ofb - add output feedback mode")
Cc: <stable@vger.kernel.org> # v4.20+
Cc: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ofb.c     |   91 ++++++++++++++++++++++---------------------------------
 crypto/testmgr.h |   28 +++++++++++++++-
 2 files changed, 63 insertions(+), 56 deletions(-)

--- a/crypto/ofb.c
+++ b/crypto/ofb.c
@@ -5,9 +5,6 @@
  *
  * Copyright (C) 2018 ARM Limited or its affiliates.
  * All rights reserved.
- *
- * Based loosely on public domain code gleaned from libtomcrypt
- * (https://github.com/libtom/libtomcrypt).
  */
 
 #include <crypto/algapi.h>
@@ -21,7 +18,6 @@
 
 struct crypto_ofb_ctx {
 	struct crypto_cipher *child;
-	int cnt;
 };
 
 
@@ -41,58 +37,40 @@ static int crypto_ofb_setkey(struct cryp
 	return err;
 }
 
-static int crypto_ofb_encrypt_segment(struct crypto_ofb_ctx *ctx,
-				      struct skcipher_walk *walk,
-				      struct crypto_cipher *tfm)
-{
-	int bsize = crypto_cipher_blocksize(tfm);
-	int nbytes = walk->nbytes;
-
-	u8 *src = walk->src.virt.addr;
-	u8 *dst = walk->dst.virt.addr;
-	u8 *iv = walk->iv;
-
-	do {
-		if (ctx->cnt == bsize) {
-			if (nbytes < bsize)
-				break;
-			crypto_cipher_encrypt_one(tfm, iv, iv);
-			ctx->cnt = 0;
-		}
-		*dst = *src ^ iv[ctx->cnt];
-		src++;
-		dst++;
-		ctx->cnt++;
-	} while (--nbytes);
-	return nbytes;
-}
-
-static int crypto_ofb_encrypt(struct skcipher_request *req)
+static int crypto_ofb_crypt(struct skcipher_request *req)
 {
-	struct skcipher_walk walk;
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	unsigned int bsize;
 	struct crypto_ofb_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct crypto_cipher *child = ctx->child;
-	int ret = 0;
+	struct crypto_cipher *cipher = ctx->child;
+	const unsigned int bsize = crypto_cipher_blocksize(cipher);
+	struct skcipher_walk walk;
+	int err;
 
-	bsize =  crypto_cipher_blocksize(child);
-	ctx->cnt = bsize;
+	err = skcipher_walk_virt(&walk, req, false);
 
-	ret = skcipher_walk_virt(&walk, req, false);
+	while (walk.nbytes >= bsize) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+		u8 * const iv = walk.iv;
+		unsigned int nbytes = walk.nbytes;
+
+		do {
+			crypto_cipher_encrypt_one(cipher, iv, iv);
+			crypto_xor_cpy(dst, src, iv, bsize);
+			dst += bsize;
+			src += bsize;
+		} while ((nbytes -= bsize) >= bsize);
 
-	while (walk.nbytes) {
-		ret = crypto_ofb_encrypt_segment(ctx, &walk, child);
-		ret = skcipher_walk_done(&walk, ret);
+		err = skcipher_walk_done(&walk, nbytes);
 	}
 
-	return ret;
-}
-
-/* OFB encrypt and decrypt are identical */
-static int crypto_ofb_decrypt(struct skcipher_request *req)
-{
-	return crypto_ofb_encrypt(req);
+	if (walk.nbytes) {
+		crypto_cipher_encrypt_one(cipher, walk.iv, walk.iv);
+		crypto_xor_cpy(walk.dst.virt.addr, walk.src.virt.addr, walk.iv,
+			       walk.nbytes);
+		err = skcipher_walk_done(&walk, 0);
+	}
+	return err;
 }
 
 static int crypto_ofb_init_tfm(struct crypto_skcipher *tfm)
@@ -165,13 +143,18 @@ static int crypto_ofb_create(struct cryp
 	if (err)
 		goto err_drop_spawn;
 
+	/* OFB mode is a stream cipher. */
+	inst->alg.base.cra_blocksize = 1;
+
+	/*
+	 * To simplify the implementation, configure the skcipher walk to only
+	 * give a partial block at the very end, never earlier.
+	 */
+	inst->alg.chunksize = alg->cra_blocksize;
+
 	inst->alg.base.cra_priority = alg->cra_priority;
-	inst->alg.base.cra_blocksize = alg->cra_blocksize;
 	inst->alg.base.cra_alignmask = alg->cra_alignmask;
 
-	/* We access the data as u32s when xoring. */
-	inst->alg.base.cra_alignmask |= __alignof__(u32) - 1;
-
 	inst->alg.ivsize = alg->cra_blocksize;
 	inst->alg.min_keysize = alg->cra_cipher.cia_min_keysize;
 	inst->alg.max_keysize = alg->cra_cipher.cia_max_keysize;
@@ -182,8 +165,8 @@ static int crypto_ofb_create(struct cryp
 	inst->alg.exit = crypto_ofb_exit_tfm;
 
 	inst->alg.setkey = crypto_ofb_setkey;
-	inst->alg.encrypt = crypto_ofb_encrypt;
-	inst->alg.decrypt = crypto_ofb_decrypt;
+	inst->alg.encrypt = crypto_ofb_crypt;
+	inst->alg.decrypt = crypto_ofb_crypt;
 
 	inst->free = crypto_ofb_free;
 
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -16681,8 +16681,7 @@ static const struct cipher_testvec aes_c
 };
 
 static const struct cipher_testvec aes_ofb_tv_template[] = {
-	 /* From NIST Special Publication 800-38A, Appendix F.5 */
-	{
+	{ /* From NIST Special Publication 800-38A, Appendix F.5 */
 		.key	= "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
 			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
 		.klen	= 16,
@@ -16705,6 +16704,31 @@ static const struct cipher_testvec aes_o
 			  "\x30\x4c\x65\x28\xf6\x59\xc7\x78"
 			  "\x66\xa5\x10\xd9\xc1\xd6\xae\x5e",
 		.len	= 64,
+		.also_non_np = 1,
+		.np	= 2,
+		.tap	= { 31, 33 },
+	}, { /* > 16 bytes, not a multiple of 16 bytes */
+		.key	= "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.klen	= 16,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
+			  "\xe9\x3d\x7e\x11\x73\x93\x17\x2a"
+			  "\xae",
+		.ctext	= "\x3b\x3f\xd9\x2e\xb7\x2d\xad\x20"
+			  "\x33\x34\x49\xf8\xe8\x3c\xfb\x4a"
+			  "\x77",
+		.len	= 17,
+	}, { /* < 16 bytes */
+		.key	= "\x2b\x7e\x15\x16\x28\xae\xd2\xa6"
+			  "\xab\xf7\x15\x88\x09\xcf\x4f\x3c",
+		.klen	= 16,
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f",
+		.ptext	= "\x6b\xc1\xbe\xe2\x2e\x40\x9f",
+		.ctext	= "\x3b\x3f\xd9\x2e\xb7\x2d\xad",
+		.len	= 7,
 	}
 };
 



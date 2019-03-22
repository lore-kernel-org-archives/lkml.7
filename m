Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DEBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258049;
	bh=9Jctmm5+BIvXzDNxS51eYe+c8Mn1wHB/aNy+PNMtbQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mgOwLR14Dt/ZczSVJZB56KI3vTZ5ZyOBl1Vp6y7yBtKOweZFV64rxlyeGSD6Nc90o
	 TLWMU/yhEGalJTRm1FfJm2lIBE+828jl/Jvnm52YmMv4AjRRUvuO1zSAVxJ2/UKJww
	 0zR2jmoTgBdFYRpyhy+ceOjk/houI3pSEt1dxVtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbfCVMNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389807AbfCVMNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE26B20830;
        Fri, 22 Mar 2019 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256825;
        bh=9Jctmm5+BIvXzDNxS51eYe+c8Mn1wHB/aNy+PNMtbQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILvjnYaRZ+TiBxvcKqkZAqBk00LU8HwFhz+LS9XtONEZKDdxaj1sZZZALfxLbDtm7
         4XS2adbjiTP0jp939bOv9mPPxp1tKeFbVOEVJZDdIlkQ8DYd04Lva/VYXIteD1kmnX
         O+4ezK384SDaOIcLKnCh36bKVO43KT+2IzZ+4BXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 048/238] crypto: x86/morus - fix handling chunked inputs and MAY_SLEEP
Date:   Fri, 22 Mar 2019 12:14:27 +0100
Message-Id: <20190322111301.231522715@linuxfoundation.org>
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

commit 2060e284e9595fc3baed6e035903c05b93266555 upstream.

The x86 MORUS implementations all fail the improved AEAD tests because
they produce the wrong result with some data layouts.  The issue is that
they assume that if the skcipher_walk API gives 'nbytes' not aligned to
the walksize (a.k.a. walk.stride), then it is the end of the data.  In
fact, this can happen before the end.

Also, when the CRYPTO_TFM_REQ_MAY_SLEEP flag is given, they can
incorrectly sleep in the skcipher_walk_*() functions while preemption
has been disabled by kernel_fpu_begin().

Fix these bugs.

Fixes: 56e8e57fc3a7 ("crypto: morus - Add common SIMD glue code for MORUS")
Cc: <stable@vger.kernel.org> # v4.18+
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/morus1280_glue.c |   40 +++++++++++++++------------------------
 arch/x86/crypto/morus640_glue.c  |   39 ++++++++++++++------------------------
 2 files changed, 31 insertions(+), 48 deletions(-)

--- a/arch/x86/crypto/morus1280_glue.c
+++ b/arch/x86/crypto/morus1280_glue.c
@@ -85,31 +85,20 @@ static void crypto_morus1280_glue_proces
 
 static void crypto_morus1280_glue_process_crypt(struct morus1280_state *state,
 						struct morus1280_ops ops,
-						struct aead_request *req)
+						struct skcipher_walk *walk)
 {
-	struct skcipher_walk walk;
-	u8 *cursor_src, *cursor_dst;
-	unsigned int chunksize, base;
-
-	ops.skcipher_walk_init(&walk, req, false);
-
-	while (walk.nbytes) {
-		cursor_src = walk.src.virt.addr;
-		cursor_dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
-
-		ops.crypt_blocks(state, cursor_src, cursor_dst, chunksize);
-
-		base = chunksize & ~(MORUS1280_BLOCK_SIZE - 1);
-		cursor_src += base;
-		cursor_dst += base;
-		chunksize &= MORUS1280_BLOCK_SIZE - 1;
-
-		if (chunksize > 0)
-			ops.crypt_tail(state, cursor_src, cursor_dst,
-				       chunksize);
+	while (walk->nbytes >= MORUS1280_BLOCK_SIZE) {
+		ops.crypt_blocks(state, walk->src.virt.addr,
+				 walk->dst.virt.addr,
+				 round_down(walk->nbytes,
+					    MORUS1280_BLOCK_SIZE));
+		skcipher_walk_done(walk, walk->nbytes % MORUS1280_BLOCK_SIZE);
+	}
 
-		skcipher_walk_done(&walk, 0);
+	if (walk->nbytes) {
+		ops.crypt_tail(state, walk->src.virt.addr, walk->dst.virt.addr,
+			       walk->nbytes);
+		skcipher_walk_done(walk, 0);
 	}
 }
 
@@ -147,12 +136,15 @@ static void crypto_morus1280_glue_crypt(
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct morus1280_ctx *ctx = crypto_aead_ctx(tfm);
 	struct morus1280_state state;
+	struct skcipher_walk walk;
+
+	ops.skcipher_walk_init(&walk, req, true);
 
 	kernel_fpu_begin();
 
 	ctx->ops->init(&state, &ctx->key, req->iv);
 	crypto_morus1280_glue_process_ad(&state, ctx->ops, req->src, req->assoclen);
-	crypto_morus1280_glue_process_crypt(&state, ops, req);
+	crypto_morus1280_glue_process_crypt(&state, ops, &walk);
 	ctx->ops->final(&state, tag_xor, req->assoclen, cryptlen);
 
 	kernel_fpu_end();
--- a/arch/x86/crypto/morus640_glue.c
+++ b/arch/x86/crypto/morus640_glue.c
@@ -85,31 +85,19 @@ static void crypto_morus640_glue_process
 
 static void crypto_morus640_glue_process_crypt(struct morus640_state *state,
 					       struct morus640_ops ops,
-					       struct aead_request *req)
+					       struct skcipher_walk *walk)
 {
-	struct skcipher_walk walk;
-	u8 *cursor_src, *cursor_dst;
-	unsigned int chunksize, base;
-
-	ops.skcipher_walk_init(&walk, req, false);
-
-	while (walk.nbytes) {
-		cursor_src = walk.src.virt.addr;
-		cursor_dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
-
-		ops.crypt_blocks(state, cursor_src, cursor_dst, chunksize);
-
-		base = chunksize & ~(MORUS640_BLOCK_SIZE - 1);
-		cursor_src += base;
-		cursor_dst += base;
-		chunksize &= MORUS640_BLOCK_SIZE - 1;
-
-		if (chunksize > 0)
-			ops.crypt_tail(state, cursor_src, cursor_dst,
-				       chunksize);
+	while (walk->nbytes >= MORUS640_BLOCK_SIZE) {
+		ops.crypt_blocks(state, walk->src.virt.addr,
+				 walk->dst.virt.addr,
+				 round_down(walk->nbytes, MORUS640_BLOCK_SIZE));
+		skcipher_walk_done(walk, walk->nbytes % MORUS640_BLOCK_SIZE);
+	}
 
-		skcipher_walk_done(&walk, 0);
+	if (walk->nbytes) {
+		ops.crypt_tail(state, walk->src.virt.addr, walk->dst.virt.addr,
+			       walk->nbytes);
+		skcipher_walk_done(walk, 0);
 	}
 }
 
@@ -143,12 +131,15 @@ static void crypto_morus640_glue_crypt(s
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct morus640_ctx *ctx = crypto_aead_ctx(tfm);
 	struct morus640_state state;
+	struct skcipher_walk walk;
+
+	ops.skcipher_walk_init(&walk, req, true);
 
 	kernel_fpu_begin();
 
 	ctx->ops->init(&state, &ctx->key, req->iv);
 	crypto_morus640_glue_process_ad(&state, ctx->ops, req->src, req->assoclen);
-	crypto_morus640_glue_process_crypt(&state, ops, req);
+	crypto_morus640_glue_process_crypt(&state, ops, &walk);
 	ctx->ops->final(&state, tag_xor, req->assoclen, cryptlen);
 
 	kernel_fpu_end();



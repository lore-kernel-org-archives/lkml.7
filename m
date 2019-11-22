Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D2EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D71204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4iCzz9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKVBD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:03:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36483 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKVBDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id d7so2385560pls.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnG/RUn8EnOEityzgFXONbz2nAhUU1/ML+u+G/jsaJU=;
        b=f4iCzz9jYtDR90Z2HKcL9LSpYiZX3Cki44FWZfOb+2c+T5StaN9kvuqJ1uw2W2dP66
         n63pn5NnGMBAgmDXY0cA4L+7NcFVk1tSHIZakNQqelGzIy1W7wHpgs8Blyc3btb0XMkh
         19tcbfWrYa7QYa/5tuWdPC2R2jcVhvg/p3G10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnG/RUn8EnOEityzgFXONbz2nAhUU1/ML+u+G/jsaJU=;
        b=BkVoTQ2W15vxNdSvfzSYiM224tTMjRTbQ+slHClHmVivh69aQQZde2bYRMN7ARvMLa
         iG9E4XBMfKPSbf6AWjrjt+ftCubFfTg4vqo6mmqofENR+RG1lxbtjQ7ZpVVum0YoxOF5
         JQo/IdZ21hDh5okkIOMtoGVRF5/5Sa63ind0n4dpLb54zmoPhp0FFDoViT7JUwATICCx
         G2MyKtbvYpJYaDWV5e7a8kYf5MO9NfoTuOqtPt7ZPsGlH+7dbgR01w5yAVlUhfNqBdkQ
         cMm023B2auvcJCIk8NqMBdg9+j8EVUUBg3/tbogdSaFXEh0bFevew00ugox0a4mZJXqX
         2JkA==
X-Gm-Message-State: APjAAAW3jNB8AbJjoH8tCoEanhJuodEv0GkuXcHvp7v6JC+xMWXoFfUv
        roOfVIlk8z4XoECNeg4s2yoPBI8kDBM=
X-Google-Smtp-Source: APXvYqx7Rzq5Q10dP4ByH3G9imFqZ3hhXIl9I6zwU/D46pZTJRr57b5vbwMUMhLxhrA4camtKvtkFA==
X-Received: by 2002:a17:902:aa8a:: with SMTP id d10mr11241874plr.273.1574384626718;
        Thu, 21 Nov 2019 17:03:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x9sm1774990pgt.66.2019.11.21.17.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 5/8] crypto: x86/cast6: Remove glue function macro usage
Date:   Thu, 21 Nov 2019 17:03:31 -0800
Message-Id: <20191122010334.12081-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122010334.12081-1-keescook@chromium.org>
References: <20191122010334.12081-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the callsite function casts, regularize the function
prototypes for helpers to avoid triggering Control-Flow Integrity checks
during indirect function calls. Where needed, to avoid changes to
pointer math, u8 pointers are internally cast back to u128 pointers.

Co-developed-by: João Moreira <joao.moreira@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/cast6_avx_glue.c | 68 +++++++++++++++-----------------
 crypto/cast6_generic.c           | 18 +++++----
 include/crypto/cast6.h           |  4 +-
 3 files changed, 43 insertions(+), 47 deletions(-)

diff --git a/arch/x86/crypto/cast6_avx_glue.c b/arch/x86/crypto/cast6_avx_glue.c
index a8a38fffb4a9..da5297475f9e 100644
--- a/arch/x86/crypto/cast6_avx_glue.c
+++ b/arch/x86/crypto/cast6_avx_glue.c
@@ -20,20 +20,17 @@
 
 #define CAST6_PARALLEL_BLOCKS 8
 
-asmlinkage void cast6_ecb_enc_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src);
-asmlinkage void cast6_ecb_dec_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src);
-
-asmlinkage void cast6_cbc_dec_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src);
-asmlinkage void cast6_ctr_8way(struct cast6_ctx *ctx, u8 *dst, const u8 *src,
+asmlinkage void cast6_ecb_enc_8way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void cast6_ecb_dec_8way(const void *ctx, u8 *dst, const u8 *src);
+
+asmlinkage void cast6_cbc_dec_8way(const void *ctx, u8 *dst, const u8 *src);
+asmlinkage void cast6_ctr_8way(const void *ctx, u8 *dst, const u8 *src,
 			       le128 *iv);
 
-asmlinkage void cast6_xts_enc_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src, le128 *iv);
-asmlinkage void cast6_xts_dec_8way(struct cast6_ctx *ctx, u8 *dst,
-				   const u8 *src, le128 *iv);
+asmlinkage void cast6_xts_enc_8way(const void *ctx, u8 *dst, const u8 *src,
+				   le128 *iv);
+asmlinkage void cast6_xts_dec_8way(const void *ctx, u8 *dst, const u8 *src,
+				   le128 *iv);
 
 static int cast6_setkey_skcipher(struct crypto_skcipher *tfm,
 				 const u8 *key, unsigned int keylen)
@@ -41,21 +38,21 @@ static int cast6_setkey_skcipher(struct crypto_skcipher *tfm,
 	return cast6_setkey(&tfm->base, key, keylen);
 }
 
-static void cast6_xts_enc(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void cast6_xts_enc(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(__cast6_encrypt));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, __cast6_encrypt);
 }
 
-static void cast6_xts_dec(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void cast6_xts_dec(const void *ctx, u8 *dst, const u8 *src, le128 *iv)
 {
-	glue_xts_crypt_128bit_one(ctx, dst, src, iv,
-				  GLUE_FUNC_CAST(__cast6_decrypt));
+	glue_xts_crypt_128bit_one(ctx, dst, src, iv, __cast6_decrypt);
 }
 
-static void cast6_crypt_ctr(void *ctx, u128 *dst, const u128 *src, le128 *iv)
+static void cast6_crypt_ctr(const void *ctx, u8 *d, const u8 *s, le128 *iv)
 {
 	be128 ctrblk;
+	u128 *dst = (u128 *)d;
+	const u128 *src = (const u128 *)s;
 
 	le128_to_be128(&ctrblk, iv);
 	le128_inc(iv);
@@ -70,10 +67,10 @@ static const struct common_glue_ctx cast6_enc = {
 
 	.funcs = { {
 		.num_blocks = CAST6_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(cast6_ecb_enc_8way) }
+		.fn_u = { .ecb = cast6_ecb_enc_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(__cast6_encrypt) }
+		.fn_u = { .ecb = __cast6_encrypt }
 	} }
 };
 
@@ -83,10 +80,10 @@ static const struct common_glue_ctx cast6_ctr = {
 
 	.funcs = { {
 		.num_blocks = CAST6_PARALLEL_BLOCKS,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(cast6_ctr_8way) }
+		.fn_u = { .ctr = cast6_ctr_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ctr = GLUE_CTR_FUNC_CAST(cast6_crypt_ctr) }
+		.fn_u = { .ctr = cast6_crypt_ctr }
 	} }
 };
 
@@ -96,10 +93,10 @@ static const struct common_glue_ctx cast6_enc_xts = {
 
 	.funcs = { {
 		.num_blocks = CAST6_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(cast6_xts_enc_8way) }
+		.fn_u = { .xts = cast6_xts_enc_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(cast6_xts_enc) }
+		.fn_u = { .xts = cast6_xts_enc }
 	} }
 };
 
@@ -109,10 +106,10 @@ static const struct common_glue_ctx cast6_dec = {
 
 	.funcs = { {
 		.num_blocks = CAST6_PARALLEL_BLOCKS,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(cast6_ecb_dec_8way) }
+		.fn_u = { .ecb = cast6_ecb_dec_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .ecb = GLUE_FUNC_CAST(__cast6_decrypt) }
+		.fn_u = { .ecb = __cast6_decrypt }
 	} }
 };
 
@@ -122,10 +119,10 @@ static const struct common_glue_ctx cast6_dec_cbc = {
 
 	.funcs = { {
 		.num_blocks = CAST6_PARALLEL_BLOCKS,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(cast6_cbc_dec_8way) }
+		.fn_u = { .cbc = cast6_cbc_dec_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .cbc = GLUE_CBC_FUNC_CAST(__cast6_decrypt) }
+		.fn_u = { .cbc = __cast6_decrypt }
 	} }
 };
 
@@ -135,10 +132,10 @@ static const struct common_glue_ctx cast6_dec_xts = {
 
 	.funcs = { {
 		.num_blocks = CAST6_PARALLEL_BLOCKS,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(cast6_xts_dec_8way) }
+		.fn_u = { .xts = cast6_xts_dec_8way }
 	}, {
 		.num_blocks = 1,
-		.fn_u = { .xts = GLUE_XTS_FUNC_CAST(cast6_xts_dec) }
+		.fn_u = { .xts = cast6_xts_dec }
 	} }
 };
 
@@ -154,8 +151,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 
 static int cbc_encrypt(struct skcipher_request *req)
 {
-	return glue_cbc_encrypt_req_128bit(GLUE_FUNC_CAST(__cast6_encrypt),
-					   req);
+	return glue_cbc_encrypt_req_128bit(__cast6_encrypt, req);
 }
 
 static int cbc_decrypt(struct skcipher_request *req)
@@ -199,8 +195,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct cast6_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&cast6_enc_xts, req,
-				   XTS_TWEAK_CAST(__cast6_encrypt),
+	return glue_xts_req_128bit(&cast6_enc_xts, req, __cast6_encrypt,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, false);
 }
 
@@ -209,8 +204,7 @@ static int xts_decrypt(struct skcipher_request *req)
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct cast6_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	return glue_xts_req_128bit(&cast6_dec_xts, req,
-				   XTS_TWEAK_CAST(__cast6_encrypt),
+	return glue_xts_req_128bit(&cast6_dec_xts, req, __cast6_encrypt,
 				   &ctx->tweak_ctx, &ctx->crypt_ctx, true);
 }
 
diff --git a/crypto/cast6_generic.c b/crypto/cast6_generic.c
index a8248f8e2777..85328522c5ca 100644
--- a/crypto/cast6_generic.c
+++ b/crypto/cast6_generic.c
@@ -154,7 +154,7 @@ int cast6_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 EXPORT_SYMBOL_GPL(cast6_setkey);
 
 /*forward quad round*/
-static inline void Q(u32 *block, u8 *Kr, u32 *Km)
+static inline void Q(u32 *block, const u8 *Kr, const u32 *Km)
 {
 	u32 I;
 	block[2] ^= F1(block[3], Kr[0], Km[0]);
@@ -164,7 +164,7 @@ static inline void Q(u32 *block, u8 *Kr, u32 *Km)
 }
 
 /*reverse quad round*/
-static inline void QBAR(u32 *block, u8 *Kr, u32 *Km)
+static inline void QBAR(u32 *block, const u8 *Kr, const u32 *Km)
 {
 	u32 I;
 	block[3] ^= F1(block[0], Kr[3], Km[3]);
@@ -173,13 +173,14 @@ static inline void QBAR(u32 *block, u8 *Kr, u32 *Km)
 	block[2] ^= F1(block[3], Kr[0], Km[0]);
 }
 
-void __cast6_encrypt(struct cast6_ctx *c, u8 *outbuf, const u8 *inbuf)
+void __cast6_encrypt(const void *ctx, u8 *outbuf, const u8 *inbuf)
 {
+	const struct cast6_ctx *c = ctx;
 	const __be32 *src = (const __be32 *)inbuf;
 	__be32 *dst = (__be32 *)outbuf;
 	u32 block[4];
-	u32 *Km;
-	u8 *Kr;
+	const u32 *Km;
+	const u8 *Kr;
 
 	block[0] = be32_to_cpu(src[0]);
 	block[1] = be32_to_cpu(src[1]);
@@ -211,13 +212,14 @@ static void cast6_encrypt(struct crypto_tfm *tfm, u8 *outbuf, const u8 *inbuf)
 	__cast6_encrypt(crypto_tfm_ctx(tfm), outbuf, inbuf);
 }
 
-void __cast6_decrypt(struct cast6_ctx *c, u8 *outbuf, const u8 *inbuf)
+void __cast6_decrypt(const void *ctx, u8 *outbuf, const u8 *inbuf)
 {
+	const struct cast6_ctx *c = ctx;
 	const __be32 *src = (const __be32 *)inbuf;
 	__be32 *dst = (__be32 *)outbuf;
 	u32 block[4];
-	u32 *Km;
-	u8 *Kr;
+	const u32 *Km;
+	const u8 *Kr;
 
 	block[0] = be32_to_cpu(src[0]);
 	block[1] = be32_to_cpu(src[1]);
diff --git a/include/crypto/cast6.h b/include/crypto/cast6.h
index c71f6ef47f0f..4c8d0c72f78d 100644
--- a/include/crypto/cast6.h
+++ b/include/crypto/cast6.h
@@ -19,7 +19,7 @@ int __cast6_setkey(struct cast6_ctx *ctx, const u8 *key,
 		   unsigned int keylen, u32 *flags);
 int cast6_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen);
 
-void __cast6_encrypt(struct cast6_ctx *ctx, u8 *dst, const u8 *src);
-void __cast6_decrypt(struct cast6_ctx *ctx, u8 *dst, const u8 *src);
+void __cast6_encrypt(const void *ctx, u8 *dst, const u8 *src);
+void __cast6_decrypt(const void *ctx, u8 *dst, const u8 *src);
 
 #endif
-- 
2.17.1


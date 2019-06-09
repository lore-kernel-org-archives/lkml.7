Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2459C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEBD205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099390;
	bh=axExf595skG1+ov6blaPXmY0p2pKJwPWh/ky42dZzeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WctGW8eJxOZ8lpjpyz7jnh4BMGEONwrHMqKQ3U3jcga+oaBMTVeJ+NJ8htK+z9qs9
	 rPh1l88FLk4mcWr80RlVj0NcfF5mChfn7mwaN46Zq8upOJb0x2qwFo97kfqEWvIc+n
	 zjRrbOZzWYv7ebyrIKMrg0Zp++CQNl0/PotQNxOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfFIQ43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732571AbfFIQ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:56:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78655206BB;
        Sun,  9 Jun 2019 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099383;
        bh=axExf595skG1+ov6blaPXmY0p2pKJwPWh/ky42dZzeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIC7ta5bXoG/2bGSrM29wqssA95YdiKZd1nQlFop2DKpLc4mYm8dctL6R62rGW0t9
         T6RDfzwgKznaXY3T/gmWztbAmRmn/ei5YFJuw9bBqI9xmIr0BF1CbAa7rTE+c2X60D
         UFZYvWZJhpRw0KXIhL8IP3RdUrgtes3ZZQJDuFIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 023/241] crypto: gcm - fix incompatibility between "gcm" and "gcm_base"
Date:   Sun,  9 Jun 2019 18:39:25 +0200
Message-Id: <20190609164148.449347091@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit f699594d436960160f6d5ba84ed4a222f20d11cd upstream.

GCM instances can be created by either the "gcm" template, which only
allows choosing the block cipher, e.g. "gcm(aes)"; or by "gcm_base",
which allows choosing the ctr and ghash implementations, e.g.
"gcm_base(ctr(aes-generic),ghash-generic)".

However, a "gcm_base" instance prevents a "gcm" instance from being
registered using the same implementations.  Nor will the instance be
found by lookups of "gcm".  This can be used as a denial of service.
Moreover, "gcm_base" instances are never tested by the crypto
self-tests, even if there are compatible "gcm" tests.

The root cause of these problems is that instances of the two templates
use different cra_names.  Therefore, fix these problems by making
"gcm_base" instances set the same cra_name as "gcm" instances, e.g.
"gcm(aes)" instead of "gcm_base(ctr(aes-generic),ghash-generic)".

This requires extracting the block cipher name from the name of the ctr
algorithm.  It also requires starting to verify that the algorithms are
really ctr and ghash, not something else entirely.  But it would be
bizarre if anyone were actually using non-gcm-compatible algorithms with
gcm_base, so this shouldn't break anyone in practice.

Fixes: d00aa19b507b ("[CRYPTO] gcm: Allow block cipher parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 crypto/gcm.c |   34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

--- a/crypto/gcm.c
+++ b/crypto/gcm.c
@@ -616,7 +616,6 @@ static void crypto_gcm_free(struct aead_
 
 static int crypto_gcm_create_common(struct crypto_template *tmpl,
 				    struct rtattr **tb,
-				    const char *full_name,
 				    const char *ctr_name,
 				    const char *ghash_name)
 {
@@ -657,7 +656,8 @@ static int crypto_gcm_create_common(stru
 		goto err_free_inst;
 
 	err = -EINVAL;
-	if (ghash->digestsize != 16)
+	if (strcmp(ghash->base.cra_name, "ghash") != 0 ||
+	    ghash->digestsize != 16)
 		goto err_drop_ghash;
 
 	crypto_set_skcipher_spawn(&ctx->ctr, aead_crypto_instance(inst));
@@ -669,24 +669,24 @@ static int crypto_gcm_create_common(stru
 
 	ctr = crypto_skcipher_spawn_alg(&ctx->ctr);
 
-	/* We only support 16-byte blocks. */
+	/* The skcipher algorithm must be CTR mode, using 16-byte blocks. */
 	err = -EINVAL;
-	if (ctr->cra_ablkcipher.ivsize != 16)
+	if (strncmp(ctr->cra_name, "ctr(", 4) != 0 ||
+	    ctr->cra_ablkcipher.ivsize != 16 ||
+	    ctr->cra_blocksize != 1)
 		goto out_put_ctr;
 
-	/* Not a stream cipher? */
-	if (ctr->cra_blocksize != 1)
+	err = -ENAMETOOLONG;
+	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
+		     "gcm(%s", ctr->cra_name + 4) >= CRYPTO_MAX_ALG_NAME)
 		goto out_put_ctr;
 
-	err = -ENAMETOOLONG;
 	if (snprintf(inst->alg.base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
 		     "gcm_base(%s,%s)", ctr->cra_driver_name,
 		     ghash_alg->cra_driver_name) >=
 	    CRYPTO_MAX_ALG_NAME)
 		goto out_put_ctr;
 
-	memcpy(inst->alg.base.cra_name, full_name, CRYPTO_MAX_ALG_NAME);
-
 	inst->alg.base.cra_flags = (ghash->base.cra_flags | ctr->cra_flags) &
 				   CRYPTO_ALG_ASYNC;
 	inst->alg.base.cra_priority = (ghash->base.cra_priority +
@@ -727,7 +727,6 @@ static int crypto_gcm_create(struct cryp
 {
 	const char *cipher_name;
 	char ctr_name[CRYPTO_MAX_ALG_NAME];
-	char full_name[CRYPTO_MAX_ALG_NAME];
 
 	cipher_name = crypto_attr_alg_name(tb[1]);
 	if (IS_ERR(cipher_name))
@@ -737,12 +736,7 @@ static int crypto_gcm_create(struct cryp
 	    CRYPTO_MAX_ALG_NAME)
 		return -ENAMETOOLONG;
 
-	if (snprintf(full_name, CRYPTO_MAX_ALG_NAME, "gcm(%s)", cipher_name) >=
-	    CRYPTO_MAX_ALG_NAME)
-		return -ENAMETOOLONG;
-
-	return crypto_gcm_create_common(tmpl, tb, full_name,
-					ctr_name, "ghash");
+	return crypto_gcm_create_common(tmpl, tb, ctr_name, "ghash");
 }
 
 static struct crypto_template crypto_gcm_tmpl = {
@@ -756,7 +750,6 @@ static int crypto_gcm_base_create(struct
 {
 	const char *ctr_name;
 	const char *ghash_name;
-	char full_name[CRYPTO_MAX_ALG_NAME];
 
 	ctr_name = crypto_attr_alg_name(tb[1]);
 	if (IS_ERR(ctr_name))
@@ -766,12 +759,7 @@ static int crypto_gcm_base_create(struct
 	if (IS_ERR(ghash_name))
 		return PTR_ERR(ghash_name);
 
-	if (snprintf(full_name, CRYPTO_MAX_ALG_NAME, "gcm_base(%s,%s)",
-		     ctr_name, ghash_name) >= CRYPTO_MAX_ALG_NAME)
-		return -ENAMETOOLONG;
-
-	return crypto_gcm_create_common(tmpl, tb, full_name,
-					ctr_name, ghash_name);
+	return crypto_gcm_create_common(tmpl, tb, ctr_name, ghash_name);
 }
 
 static struct crypto_template crypto_gcm_base_tmpl = {



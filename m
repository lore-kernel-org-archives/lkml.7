Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C50E20830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256818;
	bh=3G89iVRL/cRyx4cpNBf/i/egoSOlvEoehkY2wUogK0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0LESRIpvaYYz5yvTFXltPynRQrsfTSAVnz3YfO7wycwdQE/fXLpClA/OUZvQkVHm
	 qRgGUiRXYy44GGcxyZVmj0+UtPBysQmjugNhoBDJEOqX5c1I1PeJRFJOyt5jzJJpHe
	 UlKpo7kwEhHxVZNzDEBtV+CK499WRo6Ha3WP+rLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbfCVMNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389770AbfCVMNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6CC20830;
        Fri, 22 Mar 2019 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256812;
        bh=3G89iVRL/cRyx4cpNBf/i/egoSOlvEoehkY2wUogK0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXEFelXYVJprwHoa1VfhH05eQx/y8FJwBkrEqBqNvdUTJ5Uol7QkRTahCXO6ospLJ
         +90RuUX45cs/SZ5RsfDM7eI30wP8msWJ7G0bXxARSpH0kjy6iVrOOtf83NuRagY+00
         32MSGdoANO8Q4u9lU3oiKZPfKBGejx8JSMse8KzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 044/238] crypto: skcipher - set CRYPTO_TFM_NEED_KEY if ->setkey() fails
Date:   Fri, 22 Mar 2019 12:14:23 +0100
Message-Id: <20190322111301.005594456@linuxfoundation.org>
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

commit b1f6b4bf416b49f00f3abc49c639371cdecaaad1 upstream.

Some algorithms have a ->setkey() method that is not atomic, in the
sense that setting a key can fail after changes were already made to the
tfm context.  In this case, if a key was already set the tfm can end up
in a state that corresponds to neither the old key nor the new key.

For example, in lrw.c, if gf128mul_init_64k_bbe() fails due to lack of
memory, then priv::table will be left NULL.  After that, encryption with
that tfm will cause a NULL pointer dereference.

It's not feasible to make all ->setkey() methods atomic, especially ones
that have to key multiple sub-tfms.  Therefore, make the crypto API set
CRYPTO_TFM_NEED_KEY if ->setkey() fails and the algorithm requires a
key, to prevent the tfm from being used until a new key is set.

[Cc stable mainly because when introducing the NEED_KEY flag I changed
 AF_ALG to rely on it; and unlike in-kernel crypto API users, AF_ALG
 previously didn't have this problem.  So these "incompletely keyed"
 states became theoretically accessible via AF_ALG -- though, the
 opportunities for causing real mischief seem pretty limited.]

Fixes: f8d33fac8480 ("crypto: skcipher - prevent using skciphers without setting key")
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/skcipher.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -585,6 +585,12 @@ static unsigned int crypto_skcipher_exts
 	return crypto_alg_extsize(alg);
 }
 
+static void skcipher_set_needkey(struct crypto_skcipher *tfm)
+{
+	if (tfm->keysize)
+		crypto_skcipher_set_flags(tfm, CRYPTO_TFM_NEED_KEY);
+}
+
 static int skcipher_setkey_blkcipher(struct crypto_skcipher *tfm,
 				     const u8 *key, unsigned int keylen)
 {
@@ -598,8 +604,10 @@ static int skcipher_setkey_blkcipher(str
 	err = crypto_blkcipher_setkey(blkcipher, key, keylen);
 	crypto_skcipher_set_flags(tfm, crypto_blkcipher_get_flags(blkcipher) &
 				       CRYPTO_TFM_RES_MASK);
-	if (err)
+	if (unlikely(err)) {
+		skcipher_set_needkey(tfm);
 		return err;
+	}
 
 	crypto_skcipher_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
 	return 0;
@@ -677,8 +685,7 @@ static int crypto_init_skcipher_ops_blkc
 	skcipher->ivsize = crypto_blkcipher_ivsize(blkcipher);
 	skcipher->keysize = calg->cra_blkcipher.max_keysize;
 
-	if (skcipher->keysize)
-		crypto_skcipher_set_flags(skcipher, CRYPTO_TFM_NEED_KEY);
+	skcipher_set_needkey(skcipher);
 
 	return 0;
 }
@@ -698,8 +705,10 @@ static int skcipher_setkey_ablkcipher(st
 	crypto_skcipher_set_flags(tfm,
 				  crypto_ablkcipher_get_flags(ablkcipher) &
 				  CRYPTO_TFM_RES_MASK);
-	if (err)
+	if (unlikely(err)) {
+		skcipher_set_needkey(tfm);
 		return err;
+	}
 
 	crypto_skcipher_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
 	return 0;
@@ -776,8 +785,7 @@ static int crypto_init_skcipher_ops_ablk
 			    sizeof(struct ablkcipher_request);
 	skcipher->keysize = calg->cra_ablkcipher.max_keysize;
 
-	if (skcipher->keysize)
-		crypto_skcipher_set_flags(skcipher, CRYPTO_TFM_NEED_KEY);
+	skcipher_set_needkey(skcipher);
 
 	return 0;
 }
@@ -820,8 +828,10 @@ static int skcipher_setkey(struct crypto
 	else
 		err = cipher->setkey(tfm, key, keylen);
 
-	if (err)
+	if (unlikely(err)) {
+		skcipher_set_needkey(tfm);
 		return err;
+	}
 
 	crypto_skcipher_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
 	return 0;
@@ -852,8 +862,7 @@ static int crypto_skcipher_init_tfm(stru
 	skcipher->ivsize = alg->ivsize;
 	skcipher->keysize = alg->max_keysize;
 
-	if (skcipher->keysize)
-		crypto_skcipher_set_flags(skcipher, CRYPTO_TFM_NEED_KEY);
+	skcipher_set_needkey(skcipher);
 
 	if (alg->exit)
 		skcipher->base.exit = crypto_skcipher_exit_tfm;



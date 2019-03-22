Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEC3204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256227;
	bh=+IlQUVDdmNfq1zPpcT9MTqFPNvdV6Vy9gA8odiB2GWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XcHqUuS4xWU/AVmRCuYx2fWemV32ugeOGoopENSs1SR6MU2MtbFB1IdmW6itAcR7R
	 mbRrWlK6VClN8XtTQD+zNrd4+h+17cWHObO3xYhN9Md6EZETFlnugs8HKfMwv2RFQ6
	 FO74QpWrFa3PxQ3T8pvz+5RxcGdD0QFDbO84iSQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfCVMDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388266AbfCVMDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91AE9204FD;
        Fri, 22 Mar 2019 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256222;
        bh=+IlQUVDdmNfq1zPpcT9MTqFPNvdV6Vy9gA8odiB2GWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UH1DYHugQGta63z4EO1TTRlrZn1qopK8hCK4iVH83inH2FNfHveKZ1mhQYeTKrTVm
         P6C49Ui0iRKcG1BrSUZFSOYuHI+6nxAWPsyLCqdJjQzVd0Vcs92qujJJeLtO3eFLdv
         EmIWttEGPdsWN2pon5keonQSD7y1FPkO3yA20K3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 127/280] crypto: hash - set CRYPTO_TFM_NEED_KEY if ->setkey() fails
Date:   Fri, 22 Mar 2019 12:14:40 +0100
Message-Id: <20190322111316.028499012@linuxfoundation.org>
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

commit ba7d7433a0e998c902132bd47330e355a1eaa894 upstream.

Some algorithms have a ->setkey() method that is not atomic, in the
sense that setting a key can fail after changes were already made to the
tfm context.  In this case, if a key was already set the tfm can end up
in a state that corresponds to neither the old key nor the new key.

It's not feasible to make all ->setkey() methods atomic, especially ones
that have to key multiple sub-tfms.  Therefore, make the crypto API set
CRYPTO_TFM_NEED_KEY if ->setkey() fails and the algorithm requires a
key, to prevent the tfm from being used until a new key is set.

Note: we can't set CRYPTO_TFM_NEED_KEY for OPTIONAL_KEY algorithms, so
->setkey() for those must nevertheless be atomic.  That's fine for now
since only the crc32 and crc32c algorithms set OPTIONAL_KEY, and it's
not intended that OPTIONAL_KEY be used much.

[Cc stable mainly because when introducing the NEED_KEY flag I changed
 AF_ALG to rely on it; and unlike in-kernel crypto API users, AF_ALG
 previously didn't have this problem.  So these "incompletely keyed"
 states became theoretically accessible via AF_ALG -- though, the
 opportunities for causing real mischief seem pretty limited.]

Fixes: 9fa68f620041 ("crypto: hash - prevent using keyed hashes without setting key")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ahash.c |   28 +++++++++++++++++++---------
 crypto/shash.c |   18 +++++++++++++-----
 2 files changed, 32 insertions(+), 14 deletions(-)

--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -190,6 +190,21 @@ static int ahash_setkey_unaligned(struct
 	return ret;
 }
 
+static int ahash_nosetkey(struct crypto_ahash *tfm, const u8 *key,
+			  unsigned int keylen)
+{
+	return -ENOSYS;
+}
+
+static void ahash_set_needkey(struct crypto_ahash *tfm)
+{
+	const struct hash_alg_common *alg = crypto_hash_alg_common(tfm);
+
+	if (tfm->setkey != ahash_nosetkey &&
+	    !(alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
+		crypto_ahash_set_flags(tfm, CRYPTO_TFM_NEED_KEY);
+}
+
 int crypto_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 			unsigned int keylen)
 {
@@ -201,20 +216,16 @@ int crypto_ahash_setkey(struct crypto_ah
 	else
 		err = tfm->setkey(tfm, key, keylen);
 
-	if (err)
+	if (unlikely(err)) {
+		ahash_set_needkey(tfm);
 		return err;
+	}
 
 	crypto_ahash_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_setkey);
 
-static int ahash_nosetkey(struct crypto_ahash *tfm, const u8 *key,
-			  unsigned int keylen)
-{
-	return -ENOSYS;
-}
-
 static inline unsigned int ahash_align_buffer_size(unsigned len,
 						   unsigned long mask)
 {
@@ -467,8 +478,7 @@ static int crypto_ahash_init_tfm(struct
 
 	if (alg->setkey) {
 		hash->setkey = alg->setkey;
-		if (!(alg->halg.base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
-			crypto_ahash_set_flags(hash, CRYPTO_TFM_NEED_KEY);
+		ahash_set_needkey(hash);
 	}
 
 	return 0;
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -53,6 +53,13 @@ static int shash_setkey_unaligned(struct
 	return err;
 }
 
+static void shash_set_needkey(struct crypto_shash *tfm, struct shash_alg *alg)
+{
+	if (crypto_shash_alg_has_setkey(alg) &&
+	    !(alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
+		crypto_shash_set_flags(tfm, CRYPTO_TFM_NEED_KEY);
+}
+
 int crypto_shash_setkey(struct crypto_shash *tfm, const u8 *key,
 			unsigned int keylen)
 {
@@ -65,8 +72,10 @@ int crypto_shash_setkey(struct crypto_sh
 	else
 		err = shash->setkey(tfm, key, keylen);
 
-	if (err)
+	if (unlikely(err)) {
+		shash_set_needkey(tfm, shash);
 		return err;
+	}
 
 	crypto_shash_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
 	return 0;
@@ -368,7 +377,8 @@ int crypto_init_shash_ops_async(struct c
 	crt->final = shash_async_final;
 	crt->finup = shash_async_finup;
 	crt->digest = shash_async_digest;
-	crt->setkey = shash_async_setkey;
+	if (crypto_shash_alg_has_setkey(alg))
+		crt->setkey = shash_async_setkey;
 
 	crypto_ahash_set_flags(crt, crypto_shash_get_flags(shash) &
 				    CRYPTO_TFM_NEED_KEY);
@@ -390,9 +400,7 @@ static int crypto_shash_init_tfm(struct
 
 	hash->descsize = alg->descsize;
 
-	if (crypto_shash_alg_has_setkey(alg) &&
-	    !(alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
-		crypto_shash_set_flags(hash, CRYPTO_TFM_NEED_KEY);
+	shash_set_needkey(hash, alg);
 
 	return 0;
 }



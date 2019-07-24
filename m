Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE5EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C68229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996934;
	bh=EHcCKHRk1eOz+b0bwItEjZPMk5Rvwz+Yhh/TuND2V/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yb8Q6puDF7kPWq1uY52ZY2vkB8v7VaHTlRYi/eoDWZN4QI7Vhutq9atUnlP7gAW+Q
	 v88gsdR0qYrilPgE90E3dNNVi2D3t5GeD1D2Hldmxq+9Qeg2IlVpBSSajdsapPZL05
	 9J2Iy9AUHz5rV/uFirRPi/MEqsAEBNiUtEUSZ67o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbfGXTfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389195AbfGXTfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:35:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C97B20659;
        Wed, 24 Jul 2019 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996922;
        bh=EHcCKHRk1eOz+b0bwItEjZPMk5Rvwz+Yhh/TuND2V/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzWkfbU/qHk+plhqJQyXSotj36WByvz+AvMxC9SV3tpFoFsecEfnUZR7rJfL+vNoR
         sCqUe4u1bmsKRhFYUgsuHZFE+2wiv+LLRpiArbwGpjq7+hAtosHilJHjmctFN9p4lZ
         2olAQ/MEBkfae3AD3Qv+EaoJmz9m9qTWz0j+E9B0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.2 263/413] crypto: ghash - fix unaligned memory access in ghash_setkey()
Date:   Wed, 24 Jul 2019 21:19:14 +0200
Message-Id: <20190724191754.964857112@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 5c6bc4dfa515738149998bb0db2481a4fdead979 upstream.

Changing ghash_mod_init() to be subsys_initcall made it start running
before the alignment fault handler has been installed on ARM.  In kernel
builds where the keys in the ghash test vectors happened to be
misaligned in the kernel image, this exposed the longstanding bug that
ghash_setkey() is incorrectly casting the key buffer (which can have any
alignment) to be128 for passing to gf128mul_init_4k_lle().

Fix this by memcpy()ing the key to a temporary buffer.

Don't fix it by setting an alignmask on the algorithm instead because
that would unnecessarily force alignment of the data too.

Fixes: 2cdc6899a88e ("crypto: ghash - Add GHASH digest algorithm for GCM")
Reported-by: Peter Robinson <pbrobinson@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ghash-generic.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/crypto/ghash-generic.c
+++ b/crypto/ghash-generic.c
@@ -31,6 +31,7 @@ static int ghash_setkey(struct crypto_sh
 			const u8 *key, unsigned int keylen)
 {
 	struct ghash_ctx *ctx = crypto_shash_ctx(tfm);
+	be128 k;
 
 	if (keylen != GHASH_BLOCK_SIZE) {
 		crypto_shash_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
@@ -39,7 +40,12 @@ static int ghash_setkey(struct crypto_sh
 
 	if (ctx->gf128)
 		gf128mul_free_4k(ctx->gf128);
-	ctx->gf128 = gf128mul_init_4k_lle((be128 *)key);
+
+	BUILD_BUG_ON(sizeof(k) != GHASH_BLOCK_SIZE);
+	memcpy(&k, key, GHASH_BLOCK_SIZE); /* avoid violating alignment rules */
+	ctx->gf128 = gf128mul_init_4k_lle(&k);
+	memzero_explicit(&k, GHASH_BLOCK_SIZE);
+
 	if (!ctx->gf128)
 		return -ENOMEM;
 



Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E22221929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256764;
	bh=0V0c+/1w+jRKUyNBBFtpMgr5s6ZlfKq8NnweGIyQW04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oz3UVqKCAS5gMIbNdXzGAaBMV6U0owMLY83tPOku7UbBxHyWTj+HzXCqCOW/kSSOl
	 kBJSQ3KEOnvrP2AGADMxe7JJUJa+tn6w+G54IeX0Kaeqf53IXjR6wHmrm/IV9mBCTe
	 YQ1kw739uZn/YjUukfFGFwDWEal9yIVLOpMXQLCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbfCVMMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389635AbfCVMMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4922082C;
        Fri, 22 Mar 2019 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256756;
        bh=0V0c+/1w+jRKUyNBBFtpMgr5s6ZlfKq8NnweGIyQW04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7g9yY0AEEhHPVrbYjQ0QKmgQ7MZHKmy3Nykly39Y9Q+YKhbEtumqhDvhr9HVIbd4
         UYzgn7XG+qs+eIa7mlGZHHkKwh8BzgtrVHwjAiDlbK+oyvesCMT6DEVqQ/SA4kWJ+E
         RaJXuh193RaYdAXt3bkbwkkATL2lMxd0YwkYJG3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 020/238] crypto: cfb - remove bogus memcpy() with src == dest
Date:   Fri, 22 Mar 2019 12:13:59 +0100
Message-Id: <20190322111259.357936764@linuxfoundation.org>
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

commit 6c2e322b3621dc8be72e5c86d4fdb587434ba625 upstream.

The memcpy() in crypto_cfb_decrypt_inplace() uses walk->iv as both the
source and destination, which has undefined behavior.  It is unneeded
because walk->iv is already used to hold the previous ciphertext block;
thus, walk->iv is already updated to its final value.  So, remove it.

Also, note that in-place decryption is the only case where the previous
ciphertext block is not directly available.  Therefore, as a related
cleanup I also updated crypto_cfb_encrypt_segment() to directly use the
previous ciphertext block rather than save it into walk->iv.  This makes
it consistent with in-place encryption and out-of-place decryption; now
only in-place decryption is different, because it has to be.

Fixes: a7d85e06ed80 ("crypto: cfb - add support for Cipher FeedBack mode")
Cc: <stable@vger.kernel.org> # v4.17+
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/cfb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/crypto/cfb.c
+++ b/crypto/cfb.c
@@ -77,12 +77,14 @@ static int crypto_cfb_encrypt_segment(st
 	do {
 		crypto_cfb_encrypt_one(tfm, iv, dst);
 		crypto_xor(dst, src, bsize);
-		memcpy(iv, dst, bsize);
+		iv = dst;
 
 		src += bsize;
 		dst += bsize;
 	} while ((nbytes -= bsize) >= bsize);
 
+	memcpy(walk->iv, iv, bsize);
+
 	return nbytes;
 }
 
@@ -162,7 +164,7 @@ static int crypto_cfb_decrypt_inplace(st
 	const unsigned int bsize = crypto_cfb_bsize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 *iv = walk->iv;
+	u8 * const iv = walk->iv;
 	u8 tmp[MAX_CIPHER_BLOCKSIZE];
 
 	do {
@@ -172,8 +174,6 @@ static int crypto_cfb_decrypt_inplace(st
 		src += bsize;
 	} while ((nbytes -= bsize) >= bsize);
 
-	memcpy(walk->iv, iv, bsize);
-
 	return nbytes;
 }
 



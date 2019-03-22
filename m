Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0E2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256175;
	bh=35eZKyGqRpwWwasgSWwMR+L9j5D2q9XAyACovu8GCm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aitwb2H7VupFmqr/CXLC2SpIl/9YTgwRkSOsdGzMXP5+iCQytCEZSa25NTdK0h5GH
	 z98loprgB96/zqSiqgEKhpYH2R246OHmTS8YeQGWMTTVaSuyuleFjqHY/GQsQ8u8tg
	 uiNfUx2B7juMOADYF8WQZJUeTfFdSBWE/nqauXGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbfCVMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbfCVMCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E47C2192D;
        Fri, 22 Mar 2019 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256168;
        bh=35eZKyGqRpwWwasgSWwMR+L9j5D2q9XAyACovu8GCm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVC04XSwSfvtnzr2w1D4Yn6Db8hIHI9QfmU/wYpNp5dqHidIrz+ompYXxEnZKtaUK
         e2TTbXqQwL6K2Q0DOqe86PLAVzPNPHcZHr8YKhuU0TUB5Hgb+kpYwmnvX9oUL5/DCy
         WtEThjYqR84rPyiZZR3p6OAyv1JSHI103FLPoDYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 129/280] crypto: pcbc - remove bogus memcpy()s with src == dest
Date:   Fri, 22 Mar 2019 12:14:42 +0100
Message-Id: <20190322111316.371999296@linuxfoundation.org>
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

commit 251b7aea34ba3c4d4fdfa9447695642eb8b8b098 upstream.

The memcpy()s in the PCBC implementation use walk->iv as both the source
and destination, which has undefined behavior.  These memcpy()'s are
actually unneeded, because walk->iv is already used to hold the previous
plaintext block XOR'd with the previous ciphertext block.  Thus,
walk->iv is already updated to its final value.

So remove the broken and unnecessary memcpy()s.

Fixes: 91652be5d1b9 ("[CRYPTO] pcbc: Add Propagated CBC template")
Cc: <stable@vger.kernel.org> # v2.6.21+
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/pcbc.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/crypto/pcbc.c
+++ b/crypto/pcbc.c
@@ -51,7 +51,7 @@ static int crypto_pcbc_encrypt_segment(s
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
 	u8 *dst = walk->dst.virt.addr;
-	u8 *iv = walk->iv;
+	u8 * const iv = walk->iv;
 
 	do {
 		crypto_xor(iv, src, bsize);
@@ -72,7 +72,7 @@ static int crypto_pcbc_encrypt_inplace(s
 	int bsize = crypto_cipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 *iv = walk->iv;
+	u8 * const iv = walk->iv;
 	u8 tmpbuf[MAX_CIPHER_BLOCKSIZE];
 
 	do {
@@ -84,8 +84,6 @@ static int crypto_pcbc_encrypt_inplace(s
 		src += bsize;
 	} while ((nbytes -= bsize) >= bsize);
 
-	memcpy(walk->iv, iv, bsize);
-
 	return nbytes;
 }
 
@@ -121,7 +119,7 @@ static int crypto_pcbc_decrypt_segment(s
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
 	u8 *dst = walk->dst.virt.addr;
-	u8 *iv = walk->iv;
+	u8 * const iv = walk->iv;
 
 	do {
 		crypto_cipher_decrypt_one(tfm, dst, src);
@@ -132,8 +130,6 @@ static int crypto_pcbc_decrypt_segment(s
 		dst += bsize;
 	} while ((nbytes -= bsize) >= bsize);
 
-	memcpy(walk->iv, iv, bsize);
-
 	return nbytes;
 }
 
@@ -144,7 +140,7 @@ static int crypto_pcbc_decrypt_inplace(s
 	int bsize = crypto_cipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 *iv = walk->iv;
+	u8 * const iv = walk->iv;
 	u8 tmpbuf[MAX_CIPHER_BLOCKSIZE] __aligned(__alignof__(u32));
 
 	do {
@@ -156,8 +152,6 @@ static int crypto_pcbc_decrypt_inplace(s
 		src += bsize;
 	} while ((nbytes -= bsize) >= bsize);
 
-	memcpy(walk->iv, iv, bsize);
-
 	return nbytes;
 }
 



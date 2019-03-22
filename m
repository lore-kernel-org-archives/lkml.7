Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE77E2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255806;
	bh=55zJjsNJZMLBtFVBBuk/dGlmVNkhL0j6qxhIMw1KMGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OylXKQ9Pnwh3QyX5Vw+e/toUnZhtLqx3LQeOrZ82hB0L5aEOEVxG9c/xAA8aHETrN
	 RKpU+imL/tLbrGxLRHn7TN2OCOTfhRFqmT6bY/w004uFx/sLqZOMxfN/6jAbv5OgWs
	 VDohVDdXI7SP+hwEaMWO3YJgdN0Eh4/XO+1zw5d4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfCVL4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733132AbfCVL4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FBDC2082C;
        Fri, 22 Mar 2019 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255801;
        bh=55zJjsNJZMLBtFVBBuk/dGlmVNkhL0j6qxhIMw1KMGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUr2pNsttnG9cYeBbGfoDs32tgcwC3MwNFq3VrG3u/pjMMMdhq7kU2aj32xIdwMNY
         NJeEnMOe1Bm5A/Wgrt/1P1H+GELn5Rg+S/wRE0Ho5KE2MDgwcuXocJC8fV437mq1VP
         +JjL2JHr1Qli7BSi5HWAyiBp3fZChhWxcgeoa7WQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 019/280] crypto: cfb - remove bogus memcpy() with src == dest
Date:   Fri, 22 Mar 2019 12:12:52 +0100
Message-Id: <20190322111307.383697661@linuxfoundation.org>
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
 



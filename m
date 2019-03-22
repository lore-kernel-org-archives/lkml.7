Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A6F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258143;
	bh=/Bm9tFpclOoGhePGyNk/1S8mu1/DinNiE5cIb/+1e1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RXBRGFu9J/ht1sgdPpvl328J+3XfiDequoz5crFZFJ512n4IfboMJ7ABI3v4V5rg5
	 YysoyOzkDI7M8Hmwz0+H5CH+xckG03UJK9uvxGeciHiirLMelzw7DvXmJflYyDPqRr
	 m5Wx4B/yQhmUNAn7tpWVKP76N1ZWtiVXdxuPxExA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbfCVMNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389013AbfCVMNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40CA72082C;
        Fri, 22 Mar 2019 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256785;
        bh=/Bm9tFpclOoGhePGyNk/1S8mu1/DinNiE5cIb/+1e1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxFGFEmDllBr8zQ4Bt1Me5U+1K1KUsO4FJh5S9CiG4BKe/DwNm+IKeAeoRX1U7Dp/
         3y9T4lcA0f+LoqJS/S2X7879MYP0Et2m/UFxTEhp5kmUIrhnKsk9ASfKc+Bwnf8+mk
         C1l3NhJFtm90nko0Vh/k/ILlCtVe+MqqG6or4RQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 037/238] crypto: aegis - fix handling chunked inputs
Date:   Fri, 22 Mar 2019 12:14:16 +0100
Message-Id: <20190322111300.549513632@linuxfoundation.org>
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

commit 0f533e67d26f228ea5dfdacc8a4bdeb487af5208 upstream.

The generic AEGIS implementations all fail the improved AEAD tests
because they produce the wrong result with some data layouts.  The issue
is that they assume that if the skcipher_walk API gives 'nbytes' not
aligned to the walksize (a.k.a. walk.stride), then it is the end of the
data.  In fact, this can happen before the end.  Fix them.

Fixes: f606a88e5823 ("crypto: aegis - Add generic AEGIS AEAD implementations")
Cc: <stable@vger.kernel.org> # v4.18+
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/aegis128.c  |   14 +++++++-------
 crypto/aegis128l.c |   14 +++++++-------
 crypto/aegis256.c  |   14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

--- a/crypto/aegis128.c
+++ b/crypto/aegis128.c
@@ -290,19 +290,19 @@ static void crypto_aegis128_process_cryp
 					  const struct aegis128_ops *ops)
 {
 	struct skcipher_walk walk;
-	u8 *src, *dst;
-	unsigned int chunksize;
 
 	ops->skcipher_walk_init(&walk, req, false);
 
 	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
+		unsigned int nbytes = walk.nbytes;
 
-		ops->crypt_chunk(state, dst, src, chunksize);
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, walk.stride);
 
-		skcipher_walk_done(&walk, 0);
+		ops->crypt_chunk(state, walk.dst.virt.addr, walk.src.virt.addr,
+				 nbytes);
+
+		skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 }
 
--- a/crypto/aegis128l.c
+++ b/crypto/aegis128l.c
@@ -353,19 +353,19 @@ static void crypto_aegis128l_process_cry
 					   const struct aegis128l_ops *ops)
 {
 	struct skcipher_walk walk;
-	u8 *src, *dst;
-	unsigned int chunksize;
 
 	ops->skcipher_walk_init(&walk, req, false);
 
 	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
+		unsigned int nbytes = walk.nbytes;
 
-		ops->crypt_chunk(state, dst, src, chunksize);
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, walk.stride);
 
-		skcipher_walk_done(&walk, 0);
+		ops->crypt_chunk(state, walk.dst.virt.addr, walk.src.virt.addr,
+				 nbytes);
+
+		skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 }
 
--- a/crypto/aegis256.c
+++ b/crypto/aegis256.c
@@ -303,19 +303,19 @@ static void crypto_aegis256_process_cryp
 					  const struct aegis256_ops *ops)
 {
 	struct skcipher_walk walk;
-	u8 *src, *dst;
-	unsigned int chunksize;
 
 	ops->skcipher_walk_init(&walk, req, false);
 
 	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
-		chunksize = walk.nbytes;
+		unsigned int nbytes = walk.nbytes;
 
-		ops->crypt_chunk(state, dst, src, chunksize);
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, walk.stride);
 
-		skcipher_walk_done(&walk, 0);
+		ops->crypt_chunk(state, walk.dst.virt.addr, walk.src.virt.addr,
+				 nbytes);
+
+		skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 }
 



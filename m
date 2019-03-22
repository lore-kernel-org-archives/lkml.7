Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E2B2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258589;
	bh=j6tBECERNB6RfUhgxRO40S/K0XCxTPrVJPURPOfccQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XcyxN/dHwvDloGhnlTue9O3MWOQchiNC+DTFO9HTSYbwOzccbnNPw+DnckeN/dMwz
	 Ga2tMIEgn+PFVFCl03zBqwkLyxKhBzL2GrsJJNDInK1pPRkSTcPXkbTt96Zp41R9Xc
	 +Gfgw2W+U9EN6LLNzl2XhxwC/I0QKVYtGiDnUxtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbfCVMnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388054AbfCVMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:03:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 651CC21934;
        Fri, 22 Mar 2019 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256208;
        bh=j6tBECERNB6RfUhgxRO40S/K0XCxTPrVJPURPOfccQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SOUkAID0/mZLyIY0gT74LtFEFj4FH5KklDTFwRp8lIMX0BE4Ouy9wA7NucYRYVMY
         DQyP6oZtnS3A6eoQq0lXbFee0WaZrqxnlkygNp4LOUeccSVTUzVLsQHe7dlvCCHRiw
         AZ7ka0svBEjS4cVmEPykTr+XnJJ3wPjrVOgVhsWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 123/280] crypto: aegis - fix handling chunked inputs
Date:   Fri, 22 Mar 2019 12:14:36 +0100
Message-Id: <20190322111315.390022890@linuxfoundation.org>
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
 



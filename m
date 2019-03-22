Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0B520830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256811;
	bh=yrDc0+aDK/A9feax3ChG0Rwe48iA+C3zaYEfuB+VXu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IIX7KqDNvAtMtW+u9rXtxDEL0Nusxbk0svVxxA8WNyF3934WJIUMxAyfW/LZ5EFkj
	 +K+MV1vrTDAcn7gPWaTqSPJqDpZUO3qQ4M+7N8IV4s9mmU49jChWySTBpeBHLpp1Gc
	 tcgXicUu6antMnO42SKz/QcNGkbG+V8djSRql538=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbfCVMNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389753AbfCVMN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:13:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF932082C;
        Fri, 22 Mar 2019 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256805;
        bh=yrDc0+aDK/A9feax3ChG0Rwe48iA+C3zaYEfuB+VXu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1g0HPkCUcS9Iy7n0l7db2B4bAAi8C0BshYwrTLm8qthLqSKKEngpSlkl88HOYD9n
         uGao5zGnHPddH1Nz4bfIh+jcutE1SelJe8WzBRRCn34X3gHsVe4vUDTnTSp+vqNyZD
         eiffmlp2kdastInDNq3Y6bbKziIBdSawLckeCtEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 042/238] crypto: morus - fix handling chunked inputs
Date:   Fri, 22 Mar 2019 12:14:21 +0100
Message-Id: <20190322111300.883451700@linuxfoundation.org>
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

commit d644f1c8746ed24f81075480f9e9cb3777ae8d65 upstream.

The generic MORUS implementations all fail the improved AEAD tests
because they produce the wrong result with some data layouts.  The issue
is that they assume that if the skcipher_walk API gives 'nbytes' not
aligned to the walksize (a.k.a. walk.stride), then it is the end of the
data.  In fact, this can happen before the end.  Fix them.

Fixes: 396be41f16fd ("crypto: morus - Add generic MORUS AEAD implementations")
Cc: <stable@vger.kernel.org> # v4.18+
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/morus1280.c |   13 +++++++------
 crypto/morus640.c  |   13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

--- a/crypto/morus1280.c
+++ b/crypto/morus1280.c
@@ -366,18 +366,19 @@ static void crypto_morus1280_process_cry
 					   const struct morus1280_ops *ops)
 {
 	struct skcipher_walk walk;
-	u8 *dst;
-	const u8 *src;
 
 	ops->skcipher_walk_init(&walk, req, false);
 
 	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
+		unsigned int nbytes = walk.nbytes;
 
-		ops->crypt_chunk(state, dst, src, walk.nbytes);
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, walk.stride);
 
-		skcipher_walk_done(&walk, 0);
+		ops->crypt_chunk(state, walk.dst.virt.addr, walk.src.virt.addr,
+				 nbytes);
+
+		skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 }
 
--- a/crypto/morus640.c
+++ b/crypto/morus640.c
@@ -365,18 +365,19 @@ static void crypto_morus640_process_cryp
 					  const struct morus640_ops *ops)
 {
 	struct skcipher_walk walk;
-	u8 *dst;
-	const u8 *src;
 
 	ops->skcipher_walk_init(&walk, req, false);
 
 	while (walk.nbytes) {
-		src = walk.src.virt.addr;
-		dst = walk.dst.virt.addr;
+		unsigned int nbytes = walk.nbytes;
 
-		ops->crypt_chunk(state, dst, src, walk.nbytes);
+		if (nbytes < walk.total)
+			nbytes = round_down(nbytes, walk.stride);
 
-		skcipher_walk_done(&walk, 0);
+		ops->crypt_chunk(state, walk.dst.virt.addr, walk.src.virt.addr,
+				 nbytes);
+
+		skcipher_walk_done(&walk, walk.nbytes - nbytes);
 	}
 }
 



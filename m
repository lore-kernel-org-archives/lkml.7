Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BAFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40652196E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256171;
	bh=gbU7pGtIef+itNgU6MySzbbjxqUHKaDNydQkmKfcP2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wEEPZhj4FuA6GV6l8RKNhxzMM42l1iH7s5fWxkIa/E50y7GJpg2zh++9GOq+5Poa2
	 ew/DzfGpsECizxyyCRiSpUr71qc1M8TY2eIAgno3ftACxNGQPDNbF7ZYYnqCjpLDv0
	 TibbiHuQuL7H1k1+EPeMQnItlyv9l03bTQrR9Twk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbfCVMCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388402AbfCVMCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DDEC204FD;
        Fri, 22 Mar 2019 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256165;
        bh=gbU7pGtIef+itNgU6MySzbbjxqUHKaDNydQkmKfcP2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdM+kC5nWkr1z9FrIWLvXlfjTZSvDqOEuVpBIlcAqsbKVdnfKNxEp6sILxN2cOyra
         q7sRhsTcDRMiuLJKzY0vykURKB7c/s7Gg249Q8q0wjBQim6bIOhk4uBJDso+UxkHCn
         wMTwMIoW/YFFQWTqNTIovAsvYXLkd3gTeTCAzTSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 128/280] crypto: morus - fix handling chunked inputs
Date:   Fri, 22 Mar 2019 12:14:41 +0100
Message-Id: <20190322111316.214169084@linuxfoundation.org>
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
 



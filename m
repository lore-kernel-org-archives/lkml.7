Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10427C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6AB207E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099471;
	bh=NELJ4Hu6YiJbJlmxwVlRRrxhcEXBUQ4E/XUnMCsrArw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WyB520zu3hjlDX9GzBK3fxGNu2cex9QP5dpMGk44vSYIXu87txs1sTvTmfN+4tDkm
	 285FipBXu4wxwEXbK64kgQgp0fXV2cFbjL/4tJlLa0Kbt+7GSqptJeQI3Ud9m/Eb3r
	 lOVoRNJ1FPYQV9T6t1sCg381CdUo10YDLVKtGXr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfFIQ5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733230AbfFIQ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:57:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7035206DF;
        Sun,  9 Jun 2019 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099464;
        bh=NELJ4Hu6YiJbJlmxwVlRRrxhcEXBUQ4E/XUnMCsrArw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNCZOsBZrH3ts+STNvbAZgc4fE1KHvtIqLeoQaDP3cMR6AtoFinjGkLHToFdf+b8G
         BhR5gZ3+mXLciWf3IcaOPuwJIHJ5R8UDzZOsh3ubnLoXtYu8eIWUCOFqJZm30QyHZO
         N2aWyjelGVdYP7h4ooQiEqJE3N1ASc9f6C2Fvhfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 005/241] crypto: crct10dif-generic - fix use via crypto_shash_digest()
Date:   Sun,  9 Jun 2019 18:39:07 +0200
Message-Id: <20190609164147.943020718@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 307508d1072979f4435416f87936f87eaeb82054 upstream.

The ->digest() method of crct10dif-generic reads the current CRC value
from the shash_desc context.  But this value is uninitialized, causing
crypto_shash_digest() to compute the wrong result.  Fix it.

Probably this wasn't noticed before because lib/crc-t10dif.c only uses
crypto_shash_update(), not crypto_shash_digest().  Likewise,
crypto_shash_digest() is not yet tested by the crypto self-tests because
those only test the ahash API which only uses shash init/update/final.

This bug was detected by my patches that improve testmgr to fuzz
algorithms against their generic implementation.

Fixes: 2d31e518a428 ("crypto: crct10dif - Wrap crc_t10dif function all to use crypto transform framework")
Cc: <stable@vger.kernel.org> # v3.11+
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/crct10dif_generic.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/crypto/crct10dif_generic.c
+++ b/crypto/crct10dif_generic.c
@@ -65,10 +65,9 @@ static int chksum_final(struct shash_des
 	return 0;
 }
 
-static int __chksum_finup(__u16 *crcp, const u8 *data, unsigned int len,
-			u8 *out)
+static int __chksum_finup(__u16 crc, const u8 *data, unsigned int len, u8 *out)
 {
-	*(__u16 *)out = crc_t10dif_generic(*crcp, data, len);
+	*(__u16 *)out = crc_t10dif_generic(crc, data, len);
 	return 0;
 }
 
@@ -77,15 +76,13 @@ static int chksum_finup(struct shash_des
 {
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 
-	return __chksum_finup(&ctx->crc, data, len, out);
+	return __chksum_finup(ctx->crc, data, len, out);
 }
 
 static int chksum_digest(struct shash_desc *desc, const u8 *data,
 			 unsigned int length, u8 *out)
 {
-	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
-
-	return __chksum_finup(&ctx->crc, data, length, out);
+	return __chksum_finup(0, data, length, out);
 }
 
 static struct shash_alg alg = {



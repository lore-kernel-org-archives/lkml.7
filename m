Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB492C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70672171F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739173;
	bh=QqxshE2Taf0k0xIZzot/QuHMTD8P80Zaz6m6QpJn0Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLOVBUaqVjNXj72qrdvR6QqDuFG5Fe45czV8zAc/QaRYnqyWQo7UpLTXWLXqXgINp
	 WnzkahxX3MD6mm7eSXD4B0PDNwg8q7Vgf2MgaKnlnf1lD5ga58O8TglUJclvLCKaoZ
	 Ml9BRyHcZIffGdF6yLquQgmx0DxqoX4Pj8N1E2FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405491AbfHBJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405486AbfHBJqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:46:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B122086A;
        Fri,  2 Aug 2019 09:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739165;
        bh=QqxshE2Taf0k0xIZzot/QuHMTD8P80Zaz6m6QpJn0Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkkOJau1YfO38NLpoejlH/hs+zOlxzL1BNo4WGV+uKjry0XdXyash88drIaHXFQS8
         IZrU4yXnRDS+p0yGFlJER2cPjytUFs2UiHUvg4m+59MTTU7Cd82hEol0XrHOCTD6Rl
         06BDdSjM51rPrO1wpFAn9eyp0iG7FDqPawUKjhOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Horia Geanta <horia.geanta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 113/223] crypto: caam - limit output IV to CBC to work around CTR mode DMA issue
Date:   Fri,  2 Aug 2019 11:35:38 +0200
Message-Id: <20190802092246.560585727@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit ed527b13d800dd515a9e6c582f0a73eca65b2e1b upstream.

The CAAM driver currently violates an undocumented and slightly
controversial requirement imposed by the crypto stack that a buffer
referred to by the request structure via its virtual address may not
be modified while any scatterlists passed via the same request
structure are mapped for inbound DMA.

This may result in errors like

  alg: aead: decryption failed on test 1 for gcm_base(ctr-aes-caam,ghash-generic): ret=74
  alg: aead: Failed to load transform for gcm(aes): -2

on non-cache coherent systems, due to the fact that the GCM driver
passes an IV buffer by virtual address which shares a cacheline with
the auth_tag buffer passed via a scatterlist, resulting in corruption
of the auth_tag when the IV is updated while the DMA mapping is live.

Since the IV that is returned to the caller is only valid for CBC mode,
and given that the in-kernel users of CBC (such as CTS) don't trigger the
same issue as the GCM driver, let's just disable the output IV generation
for all modes except CBC for the time being.

Fixes: 854b06f76879 ("crypto: caam - properly set IV after {en,de}crypt")
Cc: Horia Geanta <horia.geanta@nxp.com>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ Horia: backported to 4.9 ]
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/caamalg.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -2015,6 +2015,7 @@ static void ablkcipher_encrypt_done(stru
 	struct ablkcipher_request *req = context;
 	struct ablkcipher_edesc *edesc;
 	struct crypto_ablkcipher *ablkcipher = crypto_ablkcipher_reqtfm(req);
+	struct caam_ctx *ctx = crypto_ablkcipher_ctx(ablkcipher);
 	int ivsize = crypto_ablkcipher_ivsize(ablkcipher);
 
 #ifdef DEBUG
@@ -2040,10 +2041,11 @@ static void ablkcipher_encrypt_done(stru
 
 	/*
 	 * The crypto API expects us to set the IV (req->info) to the last
-	 * ciphertext block. This is used e.g. by the CTS mode.
+	 * ciphertext block when running in CBC mode.
 	 */
-	scatterwalk_map_and_copy(req->info, req->dst, req->nbytes - ivsize,
-				 ivsize, 0);
+	if ((ctx->class1_alg_type & OP_ALG_AAI_MASK) == OP_ALG_AAI_CBC)
+		scatterwalk_map_and_copy(req->info, req->dst, req->nbytes -
+					 ivsize, ivsize, 0);
 
 	kfree(edesc);
 
@@ -2056,6 +2058,7 @@ static void ablkcipher_decrypt_done(stru
 	struct ablkcipher_request *req = context;
 	struct ablkcipher_edesc *edesc;
 	struct crypto_ablkcipher *ablkcipher = crypto_ablkcipher_reqtfm(req);
+	struct caam_ctx *ctx = crypto_ablkcipher_ctx(ablkcipher);
 	int ivsize = crypto_ablkcipher_ivsize(ablkcipher);
 
 #ifdef DEBUG
@@ -2080,10 +2083,11 @@ static void ablkcipher_decrypt_done(stru
 
 	/*
 	 * The crypto API expects us to set the IV (req->info) to the last
-	 * ciphertext block.
+	 * ciphertext block when running in CBC mode.
 	 */
-	scatterwalk_map_and_copy(req->info, req->src, req->nbytes - ivsize,
-				 ivsize, 0);
+	if ((ctx->class1_alg_type & OP_ALG_AAI_MASK) == OP_ALG_AAI_CBC)
+		scatterwalk_map_and_copy(req->info, req->src, req->nbytes -
+					 ivsize, ivsize, 0);
 
 	kfree(edesc);
 



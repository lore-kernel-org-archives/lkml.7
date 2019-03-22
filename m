Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96543C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6506820850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255795;
	bh=ckGJvbRgphEyTN7z4J5i8sZV3Qyk0Ow+B1mojxpwnlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WxQj3Qk4injgV9A48Y5fFiWE8mAaktMBn1DGjIweZybpmNbiQIBmVCL8uNFRfMykz
	 KmPQNRkCFjaXSCozsRb9yrGioOKwvRzG5tfqtLs5ZoJEV7EAhCgUCy/CFfKF/ojZBc
	 ue+4gGzDRXvWsgtASM0PFqXbliu7hXgUDy3pAAvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfCVL4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387531AbfCVL4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8F321916;
        Fri, 22 Mar 2019 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255791;
        bh=ckGJvbRgphEyTN7z4J5i8sZV3Qyk0Ow+B1mojxpwnlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtgORCXkoNVxd6C4OaRQlfrqB4gIKc1SrkN/KrHYobdBttR0hB4FOhzY2yzhd2ais
         I9//rwwekjf5miHgc4AsK7NrVnsqdMhTalglY1a2ePeA37R1nkMm9GxPhE7GwI4KYX
         J+rsu8i58If0NxIigG2+QMOitagV2C5Mqg0dMq0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 016/280] crypto: ccree - unmap buffer before copying IV
Date:   Fri, 22 Mar 2019 12:12:49 +0100
Message-Id: <20190322111307.218267113@linuxfoundation.org>
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

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit c139c72e2beb3e3db5148910b3962b7322e24374 upstream.

We were copying the last ciphertext block into the IV field
for CBC before removing the DMA mapping of the output buffer
with the result of the buffer sometime being out-of-sync cache
wise and were getting intermittent cases of bad output IV.

Fix it by moving the DMA buffer unmapping before the copy.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Fixes: 00904aa0cd59 ("crypto: ccree - fix iv handling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_cipher.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -635,6 +635,8 @@ static void cc_cipher_complete(struct de
 	unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
 	unsigned int len;
 
+	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
+
 	switch (ctx_p->cipher_mode) {
 	case DRV_CIPHER_CBC:
 		/*
@@ -664,7 +666,6 @@ static void cc_cipher_complete(struct de
 		break;
 	}
 
-	cc_unmap_cipher_request(dev, req_ctx, ivsize, src, dst);
 	kzfree(req_ctx->iv);
 
 	skcipher_request_complete(req, err);



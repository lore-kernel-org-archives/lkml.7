Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CDAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4061F2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999283;
	bh=1Bzannfh7ohEEvOUXBuSAGFlPT20QPXAz8sCMm5sO3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7uBW+Yhv7n8+NLAiFhOVxOwACnwE7DpvMmApjZW20fTh52x4aT8xso9JxyMc61/a
	 oTQaNl8kQSl7n134zUdNzLDXztKkxzvV/YmfCNI+Szj7oyFTUOAoHD7x74TDQawD3w
	 lVC7vcB8pSbKuL3PcXxgPMNbauySrxSR6u1a/mmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404180AbfGXTzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404473AbfGXTzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:55:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373E121873;
        Wed, 24 Jul 2019 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998100;
        bh=1Bzannfh7ohEEvOUXBuSAGFlPT20QPXAz8sCMm5sO3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9TpwVRuyK+KPiwFpevDHMijeYTZ0cAy8PwhcTB6MH+dx/Jr09MeF3HvTXbNaOma0
         /d/mTZYdeHatnWrKGKrhIleof8hXIGfWkv0Zi4H3wocyAZIs4bjdET+rKsxlYu92eq
         rXOYfLaFK6sAgVS9b5l9Yv3YcLniMinhk/Qa4oRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 245/371] crypto: crypto4xx - fix AES CTR blocksize value
Date:   Wed, 24 Jul 2019 21:19:57 +0200
Message-Id: <20190724191743.155188686@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

commit bfa2ba7d9e6b20aca82b99e6842fe18842ae3a0f upstream.

This patch fixes a issue with crypto4xx's ctr(aes) that was
discovered by libcapi's kcapi-enc-test.sh test.

The some of the ctr(aes) encryptions test were failing on the
non-power-of-two test:

kcapi-enc - Error: encryption failed with error 0
kcapi-enc - Error: decryption failed with error 0
[FAILED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (128 bits):
original file (1d100e..cc96184c) and generated file (e3b0c442..1b7852b855)
[FAILED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (128 bits)
(openssl generated CT): original file (e3b0..5) and generated file (3..8e)
[PASSED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (128 bits)
(openssl generated PT)
[FAILED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (password):
original file (1d1..84c) and generated file (e3b..852b855)

But the 16, 32, 512, 65536 tests always worked.

Thankfully, this isn't a hidden hardware problem like previously,
instead this turned out to be a copy and paste issue.

With this patch, all the tests are passing with and
kcapi-enc-test.sh gives crypto4xx's a clean bill of health:
 "Number of failures: 0" :).

Cc: stable@vger.kernel.org
Fixes: 98e87e3d933b ("crypto: crypto4xx - add aes-ctr support")
Fixes: f2a13e7cba9e ("crypto: crypto4xx - enable AES RFC3686, ECB, CFB and OFB offloads")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/amcc/crypto4xx_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1259,7 +1259,7 @@ static struct crypto4xx_alg_common crypt
 			.cra_flags = CRYPTO_ALG_NEED_FALLBACK |
 				CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_KERN_DRIVER_ONLY,
-			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_blocksize = 1,
 			.cra_ctxsize = sizeof(struct crypto4xx_ctx),
 			.cra_module = THIS_MODULE,
 		},
@@ -1279,7 +1279,7 @@ static struct crypto4xx_alg_common crypt
 			.cra_priority = CRYPTO4XX_CRYPTO_PRIORITY,
 			.cra_flags = CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_KERN_DRIVER_ONLY,
-			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_blocksize = 1,
 			.cra_ctxsize = sizeof(struct crypto4xx_ctx),
 			.cra_module = THIS_MODULE,
 		},



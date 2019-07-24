Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F9CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD4722BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033354;
	bh=njcevMEyVf4qON5xIzjBhRXVYstq/87hRiG0n5sGX8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ox7/n/JsAMZKb57UkxkuL1SCeScNIut7bbivCpa2w1p/RTGoSeXicrlRO3k/ymuns
	 oY8OWqjONH9mURZQle1N3II0dVWJboYc+u1rc6GVCbvYqE7tauQyyHhHKXwqCEtA6J
	 h8E4zZQamwjq87IdVrbg1ZSECb8l7VA/+BFS6QKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390888AbfGYFmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390867AbfGYFma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:42:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E27BA21880;
        Thu, 25 Jul 2019 05:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033349;
        bh=njcevMEyVf4qON5xIzjBhRXVYstq/87hRiG0n5sGX8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4H0Pb1DoQtLp86WCdSEay4qR1dzzGMaU5LkOAH4R4FvWEbaXetceFXxZqw+WANql
         jNxZkP8jKwmlDgTnHtypp0+CtY1419NMfp3h2fEWsnY3moct6ruVZyVS7vgqhiqVxP
         sz/YoZ2HJtrXlvSvtLGh7ZZf+GwrPY/lDBOCQrQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 178/271] crypto: crypto4xx - fix blocksize for cfb and ofb
Date:   Wed, 24 Jul 2019 21:20:47 +0200
Message-Id: <20190724191710.398534455@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

commit 70c4997f34b6c6888b3ac157adec49e01d0df2d5 upstream.

While the hardware consider them to be blockciphers, the
reference implementation defines them as streamciphers.

Do the right thing and set the blocksize to 1. This
was found by CONFIG_CRYPTO_MANAGER_EXTRA_TESTS.

This fixes the following issues:
skcipher: blocksize for ofb-aes-ppc4xx (16) doesn't match generic impl (1)
skcipher: blocksize for cfb-aes-ppc4xx (16) doesn't match generic impl (1)

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org
Fixes: f2a13e7cba9e ("crypto: crypto4xx - enable AES RFC3686, ECB, CFB and OFB offloads")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/amcc/crypto4xx_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1226,7 +1226,7 @@ static struct crypto4xx_alg_common crypt
 			.cra_priority = CRYPTO4XX_CRYPTO_PRIORITY,
 			.cra_flags = CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_KERN_DRIVER_ONLY,
-			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_blocksize = 1,
 			.cra_ctxsize = sizeof(struct crypto4xx_ctx),
 			.cra_module = THIS_MODULE,
 		},
@@ -1245,7 +1245,7 @@ static struct crypto4xx_alg_common crypt
 			.cra_priority = CRYPTO4XX_CRYPTO_PRIORITY,
 			.cra_flags = CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_KERN_DRIVER_ONLY,
-			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_blocksize = 1,
 			.cra_ctxsize = sizeof(struct crypto4xx_ctx),
 			.cra_module = THIS_MODULE,
 		},



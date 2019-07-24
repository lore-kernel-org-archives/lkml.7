Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B771C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AE0218F0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996221;
	bh=bu466d31ZG83S78E9LnHXITEMycjX7VQlNIXd5cHdPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmwH0XRa3Bd1fX5zZNBOYxBYbWuyo6hU92DgPTwvHFSJTrqqyHhUn4nvWzKZrtURw
	 qfAGHHq3O5MWeO8w6p/VXTEows3NxTnuMK3nky1UTzB6++WLEpN9/POwkbwlVPMbab
	 f/OwRpMR2dt6aEE9be8BpDXKUE8njr8j42zgYnKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbfGXTXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfGXTXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:23:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCC822387;
        Wed, 24 Jul 2019 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996216;
        bh=bu466d31ZG83S78E9LnHXITEMycjX7VQlNIXd5cHdPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCkpt5p+RANTzTqkuKD+EMF/GQ04XS1eO1elG6WkH9Yqbx72mkZYer8pJrTkGJCXa
         6BNZYcOwy67iloNxqbukY7BPMJixAFL31fHOPg3ik0rI848UlrPiAW7YyyFMdG5z6p
         BqR/7MDn+IM6kpvhXSLK2mnoAMLaY2gP5FKB/Fpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 020/413] crypto: talitos - fix skcipher failure due to wrong output IV
Date:   Wed, 24 Jul 2019 21:15:11 +0200
Message-Id: <20190724191736.891673121@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3e03e792865ae48b8cfc69a0b4d65f02f467389f ]

Selftests report the following:

[    2.984845] alg: skcipher: cbc-aes-talitos encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
[    2.995377] 00000000: 3d af ba 42 9d 9e b4 30 b4 22 da 80 2c 9f ac 41
[    3.032673] alg: skcipher: cbc-des-talitos encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
[    3.043185] 00000000: fe dc ba 98 76 54 32 10
[    3.063238] alg: skcipher: cbc-3des-talitos encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
[    3.073818] 00000000: 7d 33 88 93 0f 93 b2 42

This above dumps show that the actual output IV is indeed the input IV.
This is due to the IV not being copied back into the request.

This patch fixes that.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/talitos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 8c57c5af0930..396199b2db7d 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1606,11 +1606,15 @@ static void ablkcipher_done(struct device *dev,
 			    int err)
 {
 	struct ablkcipher_request *areq = context;
+	struct crypto_ablkcipher *cipher = crypto_ablkcipher_reqtfm(areq);
+	struct talitos_ctx *ctx = crypto_ablkcipher_ctx(cipher);
+	unsigned int ivsize = crypto_ablkcipher_ivsize(cipher);
 	struct talitos_edesc *edesc;
 
 	edesc = container_of(desc, struct talitos_edesc, desc);
 
 	common_nonsnoop_unmap(dev, edesc, areq);
+	memcpy(areq->info, ctx->iv, ivsize);
 
 	kfree(edesc);
 
-- 
2.20.1




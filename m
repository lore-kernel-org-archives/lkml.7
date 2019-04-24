Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC53C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEE121906
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126085;
	bh=34IH/vJnNMvAFPwy+FEzcjOwkv7bhcmRcN66tSBoigk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zLdyFAWfcGY1x38CsKyGP8PrYf4GJx7fjYGsZjeoRzJ4V4j6xolVR0S6pVMPi9zcy
	 dK2Ag68vUOLkTQAvVBa3Wqy4VdtkbUE6p1u9R10RFEpUtH8s6wuGksrttx2CQzSufT
	 F5u7p+8XaLDn286KIjUgDlNvMESKEwOiSWBs/j58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbfDXROo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387451AbfDXROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:42 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397BD218FE;
        Wed, 24 Apr 2019 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126080;
        bh=34IH/vJnNMvAFPwy+FEzcjOwkv7bhcmRcN66tSBoigk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1bdHslj1D8qRguxvd3sAElTDXVX9vzEg0BNCT1sG6uVnpQ+teTr8XvYCuR5tfJRv
         pc/966AFuoXVjV+tFHELgAdygo9n34Oy/MDLS8gSiH6KDrFknudBa0IiwZay51jhwX
         RylZgVoiE5WLocwUfsjtn7IeVUMN4vaywxKsPNAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 088/104] crypto: crypto4xx - properly set IV after de- and encrypt
Date:   Wed, 24 Apr 2019 19:09:45 +0200
Message-Id: <20190424170908.759325720@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fc340115ffb8235c1bbd200c28855e6373d0dd1a ]

This patch fixes cts(cbc(aes)) test when cbc-aes-ppc4xx is used.
alg: skcipher: Test 1 failed (invalid result) on encryption for cts(cbc-aes-ppc4xx)
00000000: 4b 10 75 fc 2f 14 1b 6a 27 35 37 33 d1 b7 70 05
00000010: 97
alg: skcipher: Failed to load transform for cts(cbc(aes)): -2

The CTS cipher mode expect the IV (req->iv) of skcipher_request
to contain the last ciphertext block after the {en,de}crypt
operation is complete.

Fix this issue for the AMCC Crypto4xx hardware engine.
The tcrypt test case for cts(cbc(aes)) is now correctly passed.

name         : cts(cbc(aes))
driver       : cts(cbc-aes-ppc4xx)
module       : cts
priority     : 300
refcnt       : 1
selftest     : passed
internal     : no
type         : skcipher
async        : yes
blocksize    : 16
min keysize  : 16
max keysize  : 32
ivsize       : 16
chunksize    : 16
walksize     : 16

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/amcc/crypto4xx_alg.c  | 3 ++-
 drivers/crypto/amcc/crypto4xx_core.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/amcc/crypto4xx_alg.c b/drivers/crypto/amcc/crypto4xx_alg.c
index 4afca3968773..e3b8bebfdd30 100644
--- a/drivers/crypto/amcc/crypto4xx_alg.c
+++ b/drivers/crypto/amcc/crypto4xx_alg.c
@@ -138,7 +138,8 @@ static int crypto4xx_setkey_aes(struct crypto_ablkcipher *cipher,
 	sa = (struct dynamic_sa_ctl *) ctx->sa_in;
 	ctx->hash_final = 0;
 
-	set_dynamic_sa_command_0(sa, SA_NOT_SAVE_HASH, SA_NOT_SAVE_IV,
+	set_dynamic_sa_command_0(sa, SA_NOT_SAVE_HASH, (cm == CRYPTO_MODE_CBC ?
+				 SA_SAVE_IV : SA_NOT_SAVE_IV),
 				 SA_LOAD_HASH_FROM_SA, SA_LOAD_IV_FROM_STATE,
 				 SA_NO_HEADER_PROC, SA_HASH_ALG_NULL,
 				 SA_CIPHER_ALG_AES, SA_PAD_TYPE_ZERO,
diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 45df1c74fa03..f8fd4f5f0f1a 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -645,6 +645,15 @@ static u32 crypto4xx_ablkcipher_done(struct crypto4xx_device *dev,
 		addr = dma_map_page(dev->core_dev->device, sg_page(dst),
 				    dst->offset, dst->length, DMA_FROM_DEVICE);
 	}
+
+	if (pd_uinfo->sa_va->sa_command_0.bf.save_iv == SA_SAVE_IV) {
+		struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
+
+		crypto4xx_memcpy_from_le32((u32 *)req->iv,
+			pd_uinfo->sr_va->save_iv,
+			crypto_skcipher_ivsize(skcipher));
+	}
+
 	crypto4xx_ret_sg_desc(dev, pd_uinfo);
 	if (ablk_req->base.complete != NULL)
 		ablk_req->base.complete(&ablk_req->base, 0);
-- 
2.19.1




Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7602DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CE621904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126882;
	bh=3TI1fATtdXMa5M01UKi/AEGYZFKnfYhThuoaWwZgTsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UJniosL13EdtAhXVmxMCuU0uTAYfdOMEYDs/CIl3DWcVkuy/h7grOuBcrcyeiZSaO
	 wXDZEb28ynbpxiblSGrelOBncDXbRht9sFr3839fs0KvhSYt3NlfCQogF8Del7YgPw
	 cOTulETMz22laSArglVr+TquX5bBGsJFqZ3o1YPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbfDXR2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390562AbfDXR14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC25205ED;
        Wed, 24 Apr 2019 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126875;
        bh=3TI1fATtdXMa5M01UKi/AEGYZFKnfYhThuoaWwZgTsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFQGhtPBZVkIG3EtP+bxw21Q4TFb94xTK5yKgGKLXWfVJ1uwknXspEMIAYbTO5F68
         CE1ICAMCwuBBxA/ij2DYtjwSkot0egIxy1VVUtou0vUlno0oTms0Ju/kwC1FAwdV0v
         jz4GkPqCEMw2c0bzb91XvDK8sF7JoHX3uM74EMsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 48/70] crypto: crypto4xx - properly set IV after de- and encrypt
Date:   Wed, 24 Apr 2019 19:10:08 +0200
Message-Id: <20190424170916.496195712@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
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
index 3f9eee7e555f..8d4d8db244e9 100644
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




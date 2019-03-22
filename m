Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF832083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256860;
	bh=+R7KGsCTYhfuq6/Ihxf6lbnJvLVIP1WEEzi/r8S/XPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iO6OTarcpcemRqJ58AR5ECJE6zb0qUWf3XSO1jf2SS6CdvGg63HK/XOA0BmP1PkJi
	 DYnBX9yCOTS2V6dhz2a080tk12LYHrPUUv5oqgV/aZ4xOl9Dyk1NbZYqY7jdDlfqtz
	 aQx5Wc8C5jURgXYPnIwovPfwEhO13iX+REo6bihs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbfCVMOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389869AbfCVMOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA1D21939;
        Fri, 22 Mar 2019 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256851;
        bh=+R7KGsCTYhfuq6/Ihxf6lbnJvLVIP1WEEzi/r8S/XPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHtRPNGxrO3PGcpoObm1y/JWNF2R4EXMqLN5K0uOOAhuSBQvDpVZieaTl1ju+dkMp
         z3G+SD+RWLYvRQAlPYazHjojbn77Mz84o63FgKNVv9EU/p+ONCVwgHwgYFpdhWnlkg
         Y5IGLoD6JIA7EXjTZeZziiTiYNNi501KqP+SFvo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Zhang Zhijie <zhangzj@rock-chips.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 024/238] crypto: rockchip - update new iv to device in multiple operations
Date:   Fri, 22 Mar 2019 12:14:03 +0100
Message-Id: <20190322111259.591606576@linuxfoundation.org>
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

From: Zhang Zhijie <zhangzj@rock-chips.com>

commit c1c214adcb56d36433480c8fedf772498e7e539c upstream.

For chain mode in cipher(eg. AES-CBC/DES-CBC), the iv is continuously
updated in the operation. The new iv value should be written to device
register by software.

Reported-by: Eric Biggers <ebiggers@google.com>
Fixes: 433cd2c617bf ("crypto: rockchip - add crypto driver for rk3288")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Zhang Zhijie <zhangzj@rock-chips.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/rockchip/rk3288_crypto.h            |    1 
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c |   34 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -245,6 +245,7 @@ struct rk_cipher_ctx {
 	struct rk_crypto_info		*dev;
 	unsigned int			keylen;
 	u32				mode;
+	u8				iv[AES_BLOCK_SIZE];
 };
 
 enum alg_type {
--- a/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
@@ -242,6 +242,17 @@ static void crypto_dma_start(struct rk_c
 static int rk_set_data_start(struct rk_crypto_info *dev)
 {
 	int err;
+	struct ablkcipher_request *req =
+		ablkcipher_request_cast(dev->async_req);
+	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	u32 ivsize = crypto_ablkcipher_ivsize(tfm);
+	u8 *src_last_blk = page_address(sg_page(dev->sg_src)) +
+		dev->sg_src->offset + dev->sg_src->length - ivsize;
+
+	/* store the iv that need to be updated in chain mode */
+	if (ctx->mode & RK_CRYPTO_DEC)
+		memcpy(ctx->iv, src_last_blk, ivsize);
 
 	err = dev->load_data(dev, dev->sg_src, dev->sg_dst);
 	if (!err)
@@ -286,6 +297,28 @@ static void rk_iv_copyback(struct rk_cry
 		memcpy_fromio(req->info, dev->reg + RK_CRYPTO_AES_IV_0, ivsize);
 }
 
+static void rk_update_iv(struct rk_crypto_info *dev)
+{
+	struct ablkcipher_request *req =
+		ablkcipher_request_cast(dev->async_req);
+	struct crypto_ablkcipher *tfm = crypto_ablkcipher_reqtfm(req);
+	struct rk_cipher_ctx *ctx = crypto_ablkcipher_ctx(tfm);
+	u32 ivsize = crypto_ablkcipher_ivsize(tfm);
+	u8 *new_iv = NULL;
+
+	if (ctx->mode & RK_CRYPTO_DEC) {
+		new_iv = ctx->iv;
+	} else {
+		new_iv = page_address(sg_page(dev->sg_dst)) +
+			 dev->sg_dst->offset + dev->sg_dst->length - ivsize;
+	}
+
+	if (ivsize == DES_BLOCK_SIZE)
+		memcpy_toio(dev->reg + RK_CRYPTO_TDES_IV_0, new_iv, ivsize);
+	else if (ivsize == AES_BLOCK_SIZE)
+		memcpy_toio(dev->reg + RK_CRYPTO_AES_IV_0, new_iv, ivsize);
+}
+
 /* return:
  *	true	some err was occurred
  *	fault	no err, continue
@@ -307,6 +340,7 @@ static int rk_ablk_rx(struct rk_crypto_i
 		}
 	}
 	if (dev->left_bytes) {
+		rk_update_iv(dev);
 		if (dev->aligned) {
 			if (sg_is_last(dev->sg_src)) {
 				dev_err(dev->dev, "[%s:%d] Lack of data\n",



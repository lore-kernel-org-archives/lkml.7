Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF89C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E96A218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255211;
	bh=SgyA/WqVdREM8jNKAVbjfsMVCSn3uyGuy+4vENzdylU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=082BpdkvzYuJ4dUsggck+fOw6q4PZRR9jhQTV5K8lDrCBHxIT7BjrSo2/v8JKtlco
	 q3mRNvIttE1ln2ducs3DKsxj3YKN0WCoE89t1E0VHKGXxhSZUzg9IotxhNGzlhu2yY
	 CzY0qy26n7VsdamuBliqyJxHA7124FqH7fTE/fsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfCVLqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731766AbfCVLqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D052075E;
        Fri, 22 Mar 2019 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255206;
        bh=SgyA/WqVdREM8jNKAVbjfsMVCSn3uyGuy+4vENzdylU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p22s5nSyXR1+8TqyzXKmVC3TKlXmeJY1DUlXCQz/2ZMR2AI0QVhR6MiumX9QmRkXO
         7PZNgaVTILQ4dPNanGp4x+h673iV8DpK13MuOJX+9Doyc0dPiKuqTu5PtDIxFgYUEm
         gZNTs5Hxm0AyBB2udpL6vbYYpjkLSION/JPjiItM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Zhang Zhijie <zhangzj@rock-chips.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 008/183] crypto: rockchip - fix scatterlist nents error
Date:   Fri, 22 Mar 2019 12:13:56 +0100
Message-Id: <20190322111242.383421791@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Zhijie <zhangzj@rock-chips.com>

commit 4359669a087633132203c52d67dd8c31e09e7b2e upstream.

In some cases, the nents of src scatterlist is different from
dst scatterlist. So two variables are used to handle the nents
of src&dst scatterlist.

Reported-by: Eric Biggers <ebiggers@google.com>
Fixes: 433cd2c617bf ("crypto: rockchip - add crypto driver for rk3288")
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Zhang Zhijie <zhangzj@rock-chips.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/rockchip/rk3288_crypto.c            |    2 +-
 drivers/crypto/rockchip/rk3288_crypto.h            |    3 ++-
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c |    5 +++--
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      |    2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -119,7 +119,7 @@ static int rk_load_data(struct rk_crypto
 		count = (dev->left_bytes > PAGE_SIZE) ?
 			PAGE_SIZE : dev->left_bytes;
 
-		if (!sg_pcopy_to_buffer(dev->first, dev->nents,
+		if (!sg_pcopy_to_buffer(dev->first, dev->src_nents,
 					dev->addr_vir, count,
 					dev->total - dev->left_bytes)) {
 			dev_err(dev->dev, "[%s:%d] pcopy err\n",
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -207,7 +207,8 @@ struct rk_crypto_info {
 	void				*addr_vir;
 	int				aligned;
 	int				align_size;
-	size_t				nents;
+	size_t				src_nents;
+	size_t				dst_nents;
 	unsigned int			total;
 	unsigned int			count;
 	dma_addr_t			addr_in;
--- a/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
@@ -260,8 +260,9 @@ static int rk_ablk_start(struct rk_crypt
 	dev->total = req->nbytes;
 	dev->sg_src = req->src;
 	dev->first = req->src;
-	dev->nents = sg_nents(req->src);
+	dev->src_nents = sg_nents(req->src);
 	dev->sg_dst = req->dst;
+	dev->dst_nents = sg_nents(req->dst);
 	dev->aligned = 1;
 
 	spin_lock_irqsave(&dev->lock, flags);
@@ -297,7 +298,7 @@ static int rk_ablk_rx(struct rk_crypto_i
 
 	dev->unload_data(dev);
 	if (!dev->aligned) {
-		if (!sg_pcopy_from_buffer(req->dst, dev->nents,
+		if (!sg_pcopy_from_buffer(req->dst, dev->dst_nents,
 					  dev->addr_vir, dev->count,
 					  dev->total - dev->left_bytes -
 					  dev->count)) {
--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -206,7 +206,7 @@ static int rk_ahash_start(struct rk_cryp
 	dev->sg_dst = NULL;
 	dev->sg_src = req->src;
 	dev->first = req->src;
-	dev->nents = sg_nents(req->src);
+	dev->src_nents = sg_nents(req->src);
 	rctx = ahash_request_ctx(req);
 	rctx->mode = 0;
 



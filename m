Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E02FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC462084D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544783;
	bh=dUTdEH27/0TdMZv/PHxATEcSeN8pCEOoHAd9DqixFSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZAJKaVvLnEaDIK6WBcPa/0pXQQGXPenkIOCj8xa9a8+/CD4dxBuOptBBJzbV8zUOt
	 gsDEwCwXtJg7EBAPCBzDx/t+w4Amkvm5u4Bu8fgyu/oMQZh0bSdS50Sm9KcEwiYBJ3
	 J7iDpjAlWEcmKUjhQepJNA7Jvl3qYBjZFkcRf7uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfFNUjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFNU2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:28:50 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7C42184D;
        Fri, 14 Jun 2019 20:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544130;
        bh=dUTdEH27/0TdMZv/PHxATEcSeN8pCEOoHAd9DqixFSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8iMaWWIxiL9hayqvVD7lzJHKYM01iS5ZESvBYHP1KoN3y5jMeY6cQEUPAaNSyg3F
         C/syOp+efaOaS9rfB6Hoxv8p8dzwx9R9edSDpl9GB1D8pCppcbI8cDjh6h+PhDhJ4z
         sbIhpE42X4vJ3dRHtw8dbMC2erCu+f7X3EcTLk18=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 05/59] dmaengine: mediatek-cqdma: sleeping in atomic context
Date:   Fri, 14 Jun 2019 16:27:49 -0400
Message-Id: <20190614202843.26941-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 069b3c4214f27b130d0642f32438560db30f452e ]

The mtk_cqdma_poll_engine_done() function takes a true/false parameter
where true means it's called from atomic context.  There are a couple
places where it was set to false but it's actually in atomic context
so it should be true.

All the callers for mtk_cqdma_hard_reset() are holding a spin_lock and
in mtk_cqdma_free_chan_resources() we take a spin_lock before calling
the mtk_cqdma_poll_engine_done() function.

Fixes: b1f01e48df5a ("dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mediatek/mtk-cqdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 814853842e29..723b11c190b3 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -225,7 +225,7 @@ static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
 	mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
 	mtk_dma_clr(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
 
-	return mtk_cqdma_poll_engine_done(pc, false);
+	return mtk_cqdma_poll_engine_done(pc, true);
 }
 
 static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
@@ -671,7 +671,7 @@ static void mtk_cqdma_free_chan_resources(struct dma_chan *c)
 		mtk_dma_set(cvc->pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
 
 		/* wait for the completion of flush operation */
-		if (mtk_cqdma_poll_engine_done(cvc->pc, false) < 0)
+		if (mtk_cqdma_poll_engine_done(cvc->pc, true) < 0)
 			dev_err(cqdma2dev(to_cqdma_dev(c)), "cqdma flush timeout\n");
 
 		/* clear the flush bit and interrupt flag */
-- 
2.20.1


Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E857C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D921A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067388;
	bh=sjobayxK8BQV7kAzsBZ5thsoTl6H6cbirtCozGkDE30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxzCwylFNJU/YpZnuDXUQZITjS28PPsesspv51nijafUuJb+yBx1s+jKc0XHitE8G
	 etN9pED1LxL1vKqnVM8r191Br/CvVQdDFSNFa4GkSsrwpvHtoDU08XFSgnGbbV0erK
	 horHxkif32H5t/9xv7DiBFE6BcsEihgREEGRaez8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406138AbfIIWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392067AbfIIWQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:16:20 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4676821D7B;
        Mon,  9 Sep 2019 22:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067379;
        bh=sjobayxK8BQV7kAzsBZ5thsoTl6H6cbirtCozGkDE30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0FVNnvQ3hp7K8rqP5xme5BJlwhCWSLCGOvSfClu0HKV1SgAeb80zyzl5mbUtns0h
         KBHkA7TY6bRxShbQTRFeroEQLo1mEKXML+U+flZgmIhkB/Vtc7xSnLlYOQ0hjtZ3Hs
         GbywuCdAJ6Rl/dBKHG2g6J42fPLLpbcdTxLpGDBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 08/12] dmaengine: sprd: Fix the DMA link-list configuration
Date:   Mon,  9 Sep 2019 11:40:48 -0400
Message-Id: <20190909154052.30941-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909154052.30941-1-sashal@kernel.org>
References: <20190909154052.30941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

[ Upstream commit 689379c2f383b1fdfdff03e84cf659daf62f2088 ]

For the Spreadtrum DMA link-list mode, when the DMA engine got a slave
hardware request, which will trigger the DMA engine to load the DMA
configuration from the link-list memory automatically. But before the
slave hardware request, the slave will get an incorrect residue due
to the first node used to trigger the link-list was configured as the
last source address and destination address.

Thus we should make sure the first node was configured the start source
address and destination address, which can fix this issue.

Fixes: 4ac695464763 ("dmaengine: sprd: Support DMA link-list mode")
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/77868edb7aff9d5cb12ac3af8827ef2e244441a6.1567150471.git.baolin.wang@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sprd-dma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index baac476c86224..525dc7338fe3b 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -908,6 +908,7 @@ sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
 	struct dma_slave_config *slave_cfg = &schan->slave_cfg;
 	dma_addr_t src = 0, dst = 0;
+	dma_addr_t start_src = 0, start_dst = 0;
 	struct sprd_dma_desc *sdesc;
 	struct scatterlist *sg;
 	u32 len = 0;
@@ -954,6 +955,11 @@ sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			dst = sg_dma_address(sg);
 		}
 
+		if (!i) {
+			start_src = src;
+			start_dst = dst;
+		}
+
 		/*
 		 * The link-list mode needs at least 2 link-list
 		 * configurations. If there is only one sg, it doesn't
@@ -970,8 +976,8 @@ sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		}
 	}
 
-	ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, src, dst, len,
-				 dir, flags, slave_cfg);
+	ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, start_src,
+				 start_dst, len, dir, flags, slave_cfg);
 	if (ret) {
 		kfree(sdesc);
 		return NULL;
-- 
2.20.1


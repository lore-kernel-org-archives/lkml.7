Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE7920643
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710818;
	bh=Ca/rvb3yJ4CpVWB4KDZBBTrJBFoDN4btwzhxYyajGYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G5jln8U5Cc8kp6tFot3bEkXeAMkP/oB8fFlvHeXaQPCzVNDCG/Bm9hD5FUskuRQPx
	 Bx3THdQtBxO+9B5P24pjp/XCOTZPoLbsGY4ge/ntf7tE+l3urdpPtC/LagZ6Al8FnP
	 Py2ql8qhHGvt8QVvXZcdWNOf7RuSeR3zm7WY+77s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbfC0SUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbfC0SUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A14F2184D;
        Wed, 27 Mar 2019 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710805;
        bh=Ca/rvb3yJ4CpVWB4KDZBBTrJBFoDN4btwzhxYyajGYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n17/BvrntdmWoZx44YZKMomqz9e6VqaysC7HiqsgCCVPGCDwxv1GLY0zW7V5k5G1o
         aI93feFRRWBGc/g7x/gZkBxI+s+WfbRZJFh161HeOotwh7p3+26KkLvq4ebrmI0lBI
         dNXyV2fbv3fDbH5+3BzIKLEZdyQ4+OUr62nU2sO4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 109/123] dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*
Date:   Wed, 27 Mar 2019 14:16:13 -0400
Message-Id: <20190327181628.15899-109-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunyong Yang <shunyong.yang@hxt-semitech.com>

[ Upstream commit 875aac8a46424e5b73a9ff7f40b83311b609e407 ]

In async_tx_test_ack(), it uses flags in struct dma_async_tx_descriptor
to check the ACK status. As hidma reuses the descriptor in a free list
when hidma_prep_dma_*(memcpy/memset) is called, the flag will keep ACKed
if the descriptor has been used before. This will cause a BUG_ON in
async_tx_quiesce().

  kernel BUG at crypto/async_tx/async_tx.c:282!
  Internal error: Oops - BUG: 0 1 SMP
  ...
  task: ffff8017dd3ec000 task.stack: ffff8017dd3e8000
  PC is at async_tx_quiesce+0x54/0x78 [async_tx]
  LR is at async_trigger_callback+0x98/0x110 [async_tx]

This patch initializes flags in dma_async_tx_descriptor by the flags
passed from the caller when hidma_prep_dma_*(memcpy/memset) is called.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/qcom/hidma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 177d7a24dd39..dd15a829e792 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -411,6 +411,7 @@ hidma_prep_dma_memcpy(struct dma_chan *dmach, dma_addr_t dest, dma_addr_t src,
 	if (!mdesc)
 		return NULL;
 
+	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
 				     src, dest, len, flags,
 				     HIDMA_TRE_MEMCPY);
@@ -443,6 +444,7 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	if (!mdesc)
 		return NULL;
 
+	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
 				     value, dest, len, flags,
 				     HIDMA_TRE_MEMSET);
-- 
2.19.1


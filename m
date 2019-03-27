Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE084C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D44205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713081;
	bh=TU11IEFQmzAcat+wyr6E/gYvnDZhZQZoN/16brW+tII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E+ITQlYPCuNZBclhbo6//7XkmbPs/+9PBCzISMpbDUT5S5WNlp9NB1xNcQS4sxMRm
	 KaXToZ6iculU17iXLf75gOmbqWXegVJGT2G/x6iksqPFfTWI8dHT7a8jx2GfjUYF0a
	 r9PnJQShneQ6x5CEiwAMu9VCbs72TqCeWdp7q5Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbfC0S6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389885AbfC0SPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D903321738;
        Wed, 27 Mar 2019 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710546;
        bh=TU11IEFQmzAcat+wyr6E/gYvnDZhZQZoN/16brW+tII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcfFPG5tJThnYffwXijXGYv/bqFTw7ODwKOx+aWQKr9wLhlliC8J5yBZ6fbJFbY4N
         NHRD5d6B03SLnnwprogXDBsrFqibzayvNFWmnH4nyWNM8VoepOY5G+jjQnRik35SIJ
         vQg97b6M+obJcB4UtqPjhu4IHHTq2H+eEf7JOjxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 169/192] dmaengine: qcom_hidma: assign channel cookie correctly
Date:   Wed, 27 Mar 2019 14:10:01 -0400
Message-Id: <20190327181025.13507-169-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunyong Yang <shunyong.yang@hxt-semitech.com>

[ Upstream commit 546c0547555efca8ba8c120716c325435e29df1b ]

When dma_cookie_complete() is called in hidma_process_completed(),
dma_cookie_status() will return DMA_COMPLETE in hidma_tx_status(). Then,
hidma_txn_is_success() will be called to use channel cookie
mchan->last_success to do additional DMA status check. Current code
assigns mchan->last_success after dma_cookie_complete(). This causes
a race condition of dma_cookie_status() returns DMA_COMPLETE before
mchan->last_success is assigned correctly. The race will cause
hidma_tx_status() return DMA_ERROR but the transaction is actually a
success. Moreover, in async_tx case, it will cause a timeout panic
in async_tx_quiesce().

 Kernel panic - not syncing: async_tx_quiesce: DMA error waiting for
 transaction
 ...
 Call trace:
 [<ffff000008089994>] dump_backtrace+0x0/0x1f4
 [<ffff000008089bac>] show_stack+0x24/0x2c
 [<ffff00000891e198>] dump_stack+0x84/0xa8
 [<ffff0000080da544>] panic+0x12c/0x29c
 [<ffff0000045d0334>] async_tx_quiesce+0xa4/0xc8 [async_tx]
 [<ffff0000045d03c8>] async_trigger_callback+0x70/0x1c0 [async_tx]
 [<ffff0000048b7d74>] raid_run_ops+0x86c/0x1540 [raid456]
 [<ffff0000048bd084>] handle_stripe+0x5e8/0x1c7c [raid456]
 [<ffff0000048be9ec>] handle_active_stripes.isra.45+0x2d4/0x550 [raid456]
 [<ffff0000048beff4>] raid5d+0x38c/0x5d0 [raid456]
 [<ffff000008736538>] md_thread+0x108/0x168
 [<ffff0000080fb1cc>] kthread+0x10c/0x138
 [<ffff000008084d34>] ret_from_fork+0x10/0x18

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/qcom/hidma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 43d4b00b8138..ea219bca116d 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -138,24 +138,25 @@ static void hidma_process_completed(struct hidma_chan *mchan)
 		desc = &mdesc->desc;
 		last_cookie = desc->cookie;
 
+		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
+
 		spin_lock_irqsave(&mchan->lock, irqflags);
+		if (llstat == DMA_COMPLETE) {
+			mchan->last_success = last_cookie;
+			result.result = DMA_TRANS_NOERROR;
+		} else {
+			result.result = DMA_TRANS_ABORTED;
+		}
+
 		dma_cookie_complete(desc);
 		spin_unlock_irqrestore(&mchan->lock, irqflags);
 
-		llstat = hidma_ll_status(mdma->lldev, mdesc->tre_ch);
 		dmaengine_desc_get_callback(desc, &cb);
 
 		dma_run_dependencies(desc);
 
 		spin_lock_irqsave(&mchan->lock, irqflags);
 		list_move(&mdesc->node, &mchan->free);
-
-		if (llstat == DMA_COMPLETE) {
-			mchan->last_success = last_cookie;
-			result.result = DMA_TRANS_NOERROR;
-		} else
-			result.result = DMA_TRANS_ABORTED;
-
 		spin_unlock_irqrestore(&mchan->lock, irqflags);
 
 		dmaengine_desc_callback_invoke(&cb, &result);
-- 
2.19.1


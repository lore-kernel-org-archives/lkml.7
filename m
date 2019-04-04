Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6357DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC45217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368294;
	bh=1Zdzj7yHMLdb8C4QdFNJ1JWPzk4+wt+kiQ3hdb7sR5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OyIQohH3mZCYP/UhQFeHC7ppiS0SJLmb418RTXLweEdb7CcXp30O24DlWvXz2NQom
	 bl3Iij+EdecFCMCgUszn7GWvq+p4IqBzxLtVBuEp8bltXhk8ZrIYbzYsuKvGB0VDK4
	 oGSMZC65eqgtblQaRO5tXD98JNHkDHgerEV5939Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfDDI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730806AbfDDI6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9229421738;
        Thu,  4 Apr 2019 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368288;
        bh=1Zdzj7yHMLdb8C4QdFNJ1JWPzk4+wt+kiQ3hdb7sR5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQiffxqO93sMhV5NVwymsMyY700rymdd1LxJaaFFCZLcibf58ewEBM3U3qViXxW88
         PS89blfmeThZEiCmbkG76AugVIaHDtA4vFl/oOf0HPS+2SktAdzvW5g9G9786Z/gZN
         S2zm/DefDbamFFDzLu2/njnd1s2e0NdvQ+qtGW9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>,
        Sinan Kaya <okaya@kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 107/121] dmaengine: qcom_hidma: assign channel cookie correctly
Date:   Thu,  4 Apr 2019 10:48:15 +0200
Message-Id: <20190404084551.077962676@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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
index e3669850aef4..177d7a24dd39 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -133,24 +133,25 @@ static void hidma_process_completed(struct hidma_chan *mchan)
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




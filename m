Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D41C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0DC20882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569177987;
	bh=dmdbnGlcQ67LSvX15BeOkemg/oVzkc782wV47LPJXig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A3Wbm6zx7WQtMa6JjljCyRXGx88Dr9KL3lBjh6C6sv8g7EPZ1oBUICHE3xRT13HuB
	 /9GVdyFyXDzSXiaxc9GGwkZAx7IskfqxHWOG3nUrqeBHU3E9RgOb7psb1DTISGJTd3
	 4qYDuhjiRRsI5hp0sP+c7ETYLqrMdAq+6hIoJ8FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389971AbfIVSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389892AbfIVSqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:46:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D164A20882;
        Sun, 22 Sep 2019 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177982;
        bh=dmdbnGlcQ67LSvX15BeOkemg/oVzkc782wV47LPJXig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ciwArBraNaElTAgzUjmvV/lZB3bic6MW7iDqd8ROXlMnsZjIiRMCJG7LuHsIEWg6f
         G8yMMCZbQEhmVXB7NGis9m7KQRbSSrFXAgHPU0iQNGBwo13FGSz/fkHUT7w2mVEtYe
         IPP0gNiIXiT6e3zoMouel9Nw5v2whdqrnagFAOdQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 077/203] dmaengine: iop-adma: use correct printk format strings
Date:   Sun, 22 Sep 2019 14:41:43 -0400
Message-Id: <20190922184350.30563-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 00c9755524fbaa28117be774d7c92fddb5ca02f3 ]

When compile-testing on other architectures, we get lots of warnings
about incorrect format strings, like:

   drivers/dma/iop-adma.c: In function 'iop_adma_alloc_slots':
   drivers/dma/iop-adma.c:307:6: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]

   drivers/dma/iop-adma.c: In function 'iop_adma_prep_dma_memcpy':
>> drivers/dma/iop-adma.c:518:40: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'size_t {aka long unsigned int}' [-Wformat=]

Use %zu for printing size_t as required, and cast the dma_addr_t
arguments to 'u64' for printing with %llx. Ideally this should use
the %pad format string, but that requires an lvalue argument that
doesn't work here.

Link: https://lore.kernel.org/r/20190809163334.489360-3-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/iop-adma.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index c6c0143670d9d..a776857d89c8f 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -116,9 +116,9 @@ static void __iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
 	list_for_each_entry_safe(iter, _iter, &iop_chan->chain,
 					chain_node) {
 		pr_debug("\tcookie: %d slot: %d busy: %d "
-			"this_desc: %#x next_desc: %#x ack: %d\n",
+			"this_desc: %#x next_desc: %#llx ack: %d\n",
 			iter->async_tx.cookie, iter->idx, busy,
-			iter->async_tx.phys, iop_desc_get_next_desc(iter),
+			iter->async_tx.phys, (u64)iop_desc_get_next_desc(iter),
 			async_tx_test_ack(&iter->async_tx));
 		prefetch(_iter);
 		prefetch(&_iter->async_tx);
@@ -306,9 +306,9 @@ iop_adma_alloc_slots(struct iop_adma_chan *iop_chan, int num_slots,
 				int i;
 				dev_dbg(iop_chan->device->common.dev,
 					"allocated slot: %d "
-					"(desc %p phys: %#x) slots_per_op %d\n",
+					"(desc %p phys: %#llx) slots_per_op %d\n",
 					iter->idx, iter->hw_desc,
-					iter->async_tx.phys, slots_per_op);
+					(u64)iter->async_tx.phys, slots_per_op);
 
 				/* pre-ack all but the last descriptor */
 				if (num_slots != slots_per_op)
@@ -516,7 +516,7 @@ iop_adma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dma_dest,
 		return NULL;
 	BUG_ON(len > IOP_ADMA_MAX_BYTE_COUNT);
 
-	dev_dbg(iop_chan->device->common.dev, "%s len: %u\n",
+	dev_dbg(iop_chan->device->common.dev, "%s len: %zu\n",
 		__func__, len);
 
 	spin_lock_bh(&iop_chan->lock);
@@ -549,7 +549,7 @@ iop_adma_prep_dma_xor(struct dma_chan *chan, dma_addr_t dma_dest,
 	BUG_ON(len > IOP_ADMA_XOR_MAX_BYTE_COUNT);
 
 	dev_dbg(iop_chan->device->common.dev,
-		"%s src_cnt: %d len: %u flags: %lx\n",
+		"%s src_cnt: %d len: %zu flags: %lx\n",
 		__func__, src_cnt, len, flags);
 
 	spin_lock_bh(&iop_chan->lock);
@@ -582,7 +582,7 @@ iop_adma_prep_dma_xor_val(struct dma_chan *chan, dma_addr_t *dma_src,
 	if (unlikely(!len))
 		return NULL;
 
-	dev_dbg(iop_chan->device->common.dev, "%s src_cnt: %d len: %u\n",
+	dev_dbg(iop_chan->device->common.dev, "%s src_cnt: %d len: %zu\n",
 		__func__, src_cnt, len);
 
 	spin_lock_bh(&iop_chan->lock);
@@ -620,7 +620,7 @@ iop_adma_prep_dma_pq(struct dma_chan *chan, dma_addr_t *dst, dma_addr_t *src,
 	BUG_ON(len > IOP_ADMA_XOR_MAX_BYTE_COUNT);
 
 	dev_dbg(iop_chan->device->common.dev,
-		"%s src_cnt: %d len: %u flags: %lx\n",
+		"%s src_cnt: %d len: %zu flags: %lx\n",
 		__func__, src_cnt, len, flags);
 
 	if (dmaf_p_disabled_continue(flags))
@@ -683,7 +683,7 @@ iop_adma_prep_dma_pq_val(struct dma_chan *chan, dma_addr_t *pq, dma_addr_t *src,
 		return NULL;
 	BUG_ON(len > IOP_ADMA_XOR_MAX_BYTE_COUNT);
 
-	dev_dbg(iop_chan->device->common.dev, "%s src_cnt: %d len: %u\n",
+	dev_dbg(iop_chan->device->common.dev, "%s src_cnt: %d len: %zu\n",
 		__func__, src_cnt, len);
 
 	spin_lock_bh(&iop_chan->lock);
-- 
2.20.1


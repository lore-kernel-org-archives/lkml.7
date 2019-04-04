Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02BDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF65C21734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369427;
	bh=UoW2iMM9BqUANvtoc1WvaOarFaMZkq93p/DyGAndAH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NV1BmeLkED3vzxVoaBDRokYCHDhyORjZ4fBSWGg2JBUvpi5kci+VnfAWJD0RYW0N2
	 w7R/QfF5cXZXJXcmXZYV1hzTNflYIdvakxKGebnnA7GSsW+kNKQBSywelJgW8OQpk1
	 Jex43+kdT2V+nBSX60laD3rNKRFc5P3dH3es46ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbfDDJRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbfDDJRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA06217D4;
        Thu,  4 Apr 2019 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369420;
        bh=UoW2iMM9BqUANvtoc1WvaOarFaMZkq93p/DyGAndAH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwj7/TqXMPROufZZoSPQHxa7H7HDt52IS0FCvBjmERt/qmZ2kkLhb5ZqRWm3Ws+UC
         2jQhgDyH3mqSfatuhJoUA0ovHu4KUtwxQuNrXjZ9m6RaDmMNuCxxvWEtl4nCpfCV3o
         FiTAjPg5ZYo9ka79zxeRGNFCqUeWCcMa6NInTflg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>,
        Sinan Kaya <okaya@kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 217/246] dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*
Date:   Thu,  4 Apr 2019 10:48:37 +0200
Message-Id: <20190404084626.791999416@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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
index ea219bca116d..411f91fde734 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -416,6 +416,7 @@ hidma_prep_dma_memcpy(struct dma_chan *dmach, dma_addr_t dest, dma_addr_t src,
 	if (!mdesc)
 		return NULL;
 
+	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
 				     src, dest, len, flags,
 				     HIDMA_TRE_MEMCPY);
@@ -448,6 +449,7 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	if (!mdesc)
 		return NULL;
 
+	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
 				     value, dest, len, flags,
 				     HIDMA_TRE_MEMSET);
-- 
2.19.1




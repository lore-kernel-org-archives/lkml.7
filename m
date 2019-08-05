Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F002C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0522075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfHEPwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:52:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58351 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHEPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:52:00 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hufH9-0000B4-1O; Mon, 05 Aug 2019 17:51:55 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH] dma-direct: don't truncate dma_required_mask to bus addressing capabilities
Date:   Mon,  5 Aug 2019 17:51:53 +0200
Message-Id: <20190805155153.11021-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma required_mask needs to reflect the actual addressing capabilities
needed to handle the whole system RAM. When truncated down to the bus
addressing capabilities dma_addressing_limited() will incorrectly signal
no limitations for devices which are restricted by the bus_dma_mask.

Fixes: b4ebe6063204 (dma-direct: implement complete bus_dma_mask handling)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 kernel/dma/direct.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 59bdceea3737..7ba3480fc546 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -47,9 +47,6 @@ u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
 
-	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
-		max_dma = dev->bus_dma_mask;
-
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
-- 
2.20.1


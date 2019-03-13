Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98271C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601C3217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504246;
	bh=yN21YWSjkjnHUTbYYwLQjCrys8QazynvM+ofXuZlgJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IKB7GwkUcsEKoO9gXtVlRP96F0gyzHLaY6jYUZxJU9FAsDXaAZqxzwE17jHA5fGju
	 u0JOy+j0muuOZDY81YPTGYtVQ6j8tafBVYMG8pbbB0KBAHgqShYnSI5jtYg/TpPcEU
	 bi22PjIvyaKTYkfaCiy4S5qwxb75k8unGF7bq6Hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCMTKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfCMTKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA0082183F;
        Wed, 13 Mar 2019 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504241;
        bh=yN21YWSjkjnHUTbYYwLQjCrys8QazynvM+ofXuZlgJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJKKyX72haV2C9MNQ9+YQS5JixptkH83qwxTBXqhYVmhPgFRjIx19uxbPrfbcTeik
         9fn9qbr1p+BjnNss1NdmU1Whb9pSwkpRaWfk9GFtfBPh9VCA//VBomZ7wgmqM8Ke7M
         +e8eOio7julifT0A1nBT3zvXvMkDjnJ+Zv4B44TY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 10/60] ARM: 8835/1: dma-mapping: Clear DMA ops on teardown
Date:   Wed, 13 Mar 2019 15:09:31 -0400
Message-Id: <20190313191021.158171-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit fc67e6f120a388b611d94cc40baf99a5cc56b283 ]

Installing the appropriate non-IOMMU DMA ops in arm_iommu_detch_device()
serves the case where IOMMU-aware drivers choose to control their own
mapping but still make DMA API calls, however it also affects the case
when the arch code itself tears down the mapping upon driver unbinding,
where the ops now get left in place and can inhibit arch_setup_dma_ops()
on subsequent re-probe attempts.

Fix the latter case by making sure that arch_teardown_dma_ops() cleans
up whenever the ops were automatically installed by its counterpart.

Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/dma-mapping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 78de138aa66d..7f8afe3c9072 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2399,4 +2399,6 @@ void arch_teardown_dma_ops(struct device *dev)
 		return;
 
 	arm_teardown_iommu_dma_ops(dev);
+	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
+	set_dma_ops(dev, NULL);
 }
-- 
2.19.1


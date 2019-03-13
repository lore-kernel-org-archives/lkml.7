Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34CB20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505338;
	bh=YuU+tpMYLs2+HSMmvQmAhcaGiUadX9QnrdpCKVNHpZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHf6ztp9tmypOQoJaXgZ/fnDvpCqT6am9hQ8Hf1eVBhLIriosv6gmtsMXIratblk3
	 SUmpAmkC9Y481zTfkuGmzUt9TwpaEyql/TbB/wyxqnJhP7+O40PjtAqKPHV5SSzIsS
	 DFpazbn31Sjkz1OcF/PPrMRBYPGdrLNG1y+V8Xng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfCMT24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfCMTNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CCFD2184D;
        Wed, 13 Mar 2019 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504399;
        bh=YuU+tpMYLs2+HSMmvQmAhcaGiUadX9QnrdpCKVNHpZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDVd/BD9zKkAnNMhqyd6x1QEcMn7UeKVNB0UNA35U3HE9gBD5aI++xhUk+hWMpKXE
         ao8rUzsfnoMg7ZtokNhP6EHcShGPlS2urHp5FxdABUlTwUrhf+D4RGEb2u/8jOPrze
         Jt4bmQZyXof11yopRm/P4UI09+TW1c/bHTS89z/o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 09/48] ARM: 8835/1: dma-mapping: Clear DMA ops on teardown
Date:   Wed, 13 Mar 2019 15:12:11 -0400
Message-Id: <20190313191250.158955-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
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
index 1cb9c0f9b5d6..8211cf45ece1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2400,4 +2400,6 @@ void arch_teardown_dma_ops(struct device *dev)
 		return;
 
 	arm_teardown_iommu_dma_ops(dev);
+	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
+	set_dma_ops(dev, NULL);
 }
-- 
2.19.1


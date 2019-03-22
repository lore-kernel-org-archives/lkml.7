Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9758C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AB021934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255997;
	bh=8/gG9teF3eEOH2EzynJcz+DGH/Hee3eSRT8yKqHgJBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ngdTSVzgxD6FRMBTplMjCxk0rG4SU69sNHXXpkcS3ypwKIrM+tNYnWgMehIl7IrNy
	 Kub+viAiLRfRbzzQwPY5ffVai6d/ohvYjw2NQp+GUi89fiyl5fwsyHEoZgUZnzsIuM
	 88syF2AFy2c2aQ4NkDy1gldmCrDKdBJTCsOn5cdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbfCVL74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbfCVL7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5517920830;
        Fri, 22 Mar 2019 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255988;
        bh=8/gG9teF3eEOH2EzynJcz+DGH/Hee3eSRT8yKqHgJBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EU0cs3qWWRkDb1ZucmcHAIpEgKbOSAbiOHZo8IpZzpGGEza6oVpHjczFvuNSzhNhz
         Hz3Pflrz1dzvQMftj02qs0/qXw2xEhD8lLAtznxs80yDqns72Ae/9DChE6ac1PzJtc
         oCAHS1q4EO8uuLgCSWs9/2aJ0GNhDXqQj2Qgmqko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/280] ARM: 8835/1: dma-mapping: Clear DMA ops on teardown
Date:   Fri, 22 Mar 2019 12:13:48 +0100
Message-Id: <20190322111310.547909991@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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




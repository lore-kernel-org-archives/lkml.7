Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F31EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F2A217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127214;
	bh=9ROhGXK6rd4BaOKuMuPMhYS46hgPSYfBc0TGKxduK+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rVbzMwymL8maa/dRtpcJ5WSFQAIOCWR6GsixVwg6psfvRCZmmn0bdZIVQjjZUyF17
	 fDDTeEcgWcQONhmRmywUnHrwA2peih+Cc+9pw2upEXfQFCRp+wvOUrirdMOH7NBn6I
	 DkUea1vXn2vfN83HmspXRQTK2+AdLQcK4FmfJJrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfHFVdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHFVd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:33:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E160F217F4;
        Tue,  6 Aug 2019 21:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127207;
        bh=9ROhGXK6rd4BaOKuMuPMhYS46hgPSYfBc0TGKxduK+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGYpMKK6/tkud0U+Iu8DI+se9agLP045bN6ncjz9iDJUEOOylxEVF6MrIe5ImGM9x
         zacQXbzoxvaeGGznUEqf4IiPgFIAew2Xexx/A15NGKPxfd095Nl5u2Bzg01p2Y/ALh
         C3T+HyGEL8cCifDdLqDO7l6f9hGMrWdc6JnISWc4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.2 06/59] dma-mapping: check pfn validity in dma_common_{mmap,get_sgtable}
Date:   Tue,  6 Aug 2019 17:32:26 -0400
Message-Id: <20190806213319.19203-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 66d7780f18eae0232827fcffeaded39a6a168236 ]

Check that the pfn returned from arch_dma_coherent_to_pfn refers to
a valid page and reject the mmap / get_sgtable requests otherwise.

Based on the arm implementation of the mmap and get_sgtable methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7afdadb6770b..3401382bbca2f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -116,11 +116,16 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 	int ret;
 
 	if (!dev_is_dma_coherent(dev)) {
+		unsigned long pfn;
+
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
 			return -ENXIO;
 
-		page = pfn_to_page(arch_dma_coherent_to_pfn(dev, cpu_addr,
-				dma_addr));
+		/* If the PFN is not valid, we do not have a struct page */
+		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
+		if (!pfn_valid(pfn))
+			return -ENXIO;
+		page = pfn_to_page(pfn);
 	} else {
 		page = virt_to_page(cpu_addr);
 	}
@@ -170,7 +175,11 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (!dev_is_dma_coherent(dev)) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
 			return -ENXIO;
+
+		/* If the PFN is not valid, we do not have a struct page */
 		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
+		if (!pfn_valid(pfn))
+			return -ENXIO;
 	} else {
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
 	}
-- 
2.20.1


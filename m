Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB018C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC66215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329508;
	bh=tKy5HN1au7aRKS1G0+KswYVtNsaC9sOxpoBq4LDsCac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVHM/f00qAq/LBJtTAnqIDbk7wEpbM7aEIggOWZCjWmRbP3XXhnxRuZjqR+1eWK4x
	 8V5EExqcYG2BIwdZ9r+4LCZ6tSvv8w0UQTGFsNnfq7jwFPnxMEiPyUdY1nPr3H8mUp
	 S/+XcUEDD6c+O+4/WlKkSrAFK5rlFZoTd082PLcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfD0BpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbfD0BoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4189208CB;
        Sat, 27 Apr 2019 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329450;
        bh=tKy5HN1au7aRKS1G0+KswYVtNsaC9sOxpoBq4LDsCac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvqLfGyUc54mllyKAueoQpOnwTRAoamAV4560zKlUDJm3fIedKWHqB8gQkrzN+72a
         1gZV4OqUeXSnRvOcaIWCoL6L/sMVeRDajltGleMIiE8H7k+M/4P/EVzXnc2Ph5AdOs
         avz5G+o2c2TDN2LfDiKe+aXNpNPuBQJfNNSbvHQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.4 9/9] iommu/amd: Set exclusion range correctly
Date:   Fri, 26 Apr 2019 21:43:54 -0400
Message-Id: <20190427014356.8940-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014356.8940-1-sashal@kernel.org>
References: <20190427014356.8940-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 3c677d206210f53a4be972211066c0f1cd47fe12 ]

The exlcusion range limit register needs to contain the
base-address of the last page that is part of the range, as
bits 0-11 of this register are treated as 0xfff by the
hardware for comparisons.

So correctly set the exclusion range in the hardware to the
last page which is _in_ the range.

Fixes: b2026aa2dce44 ('x86, AMD IOMMU: add functions for programming IOMMU MMIO space')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 94f1bf772ec9..db85cc5791dc 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -295,7 +295,7 @@ static void iommu_write_l2(struct amd_iommu *iommu, u8 address, u32 val)
 static void iommu_set_exclusion_range(struct amd_iommu *iommu)
 {
 	u64 start = iommu->exclusion_start & PAGE_MASK;
-	u64 limit = (start + iommu->exclusion_length) & PAGE_MASK;
+	u64 limit = (start + iommu->exclusion_length - 1) & PAGE_MASK;
 	u64 entry;
 
 	if (!iommu->exclusion_start)
-- 
2.19.1


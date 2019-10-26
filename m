Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2E4CA9EBE
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6C221E6F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572095766;
	bh=6ENN7JqKH0dafo1SdCaAf1Eq/G2mTYu6ydXeLUXURlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=elkbGzvQJpkJBvvJiDo6pG+eEJx7nDmI8q88JJF0KhlP1PBqKNxdAE+aEZKXBnqPM
	 Ndp10BV2Y76b2PaF83Bldc/qMbQ2C9y4mAdyDBYZb68iz+sDTGnu490GJkry4fT3ux
	 TBO8NpsECLhgm8RKyki+s+vTT4pOVZcF4vKiRbZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfJZNQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfJZNQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:16:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E193B21655;
        Sat, 26 Oct 2019 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095763;
        bh=6ENN7JqKH0dafo1SdCaAf1Eq/G2mTYu6ydXeLUXURlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ui/Onh4qvlTZ0MnYSfBcn2ukjglC//JeFGIHLq8nnd5PFeqdp34Yd27bVv8/mNO9T
         l0WdPFGipJW63HrkqszrRPZ5m+UTeAip6HkYMCpp823pwFnRPo9xCyo1ad6ce2RUyt
         2aR3I2t0VBlkmZICrYiJhS2XmqNpgKVJEaWFfJ7g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Xiang <liuxiang_1999@126.com>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.3 02/99] iommu/arm-smmu: Free context bitmap in the err path of arm_smmu_init_domain_context
Date:   Sat, 26 Oct 2019 09:14:23 -0400
Message-Id: <20191026131600.2507-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Xiang <liuxiang_1999@126.com>

[ Upstream commit 6db7bfb431220d78e34d2d0afdb7c12683323588 ]

When alloc_io_pgtable_ops is failed, context bitmap which is just allocated
by __arm_smmu_alloc_bitmap should be freed to release the resource.

Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 64977c131ee62..523a641b6196f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -936,6 +936,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	return 0;
 
 out_clear_smmu:
+	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 	smmu_domain->smmu = NULL;
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
-- 
2.20.1


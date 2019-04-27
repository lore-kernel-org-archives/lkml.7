Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE75C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355F521537
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329611;
	bh=PK+mpmAm7MUkBeFcoMfzY206FIHmnQKT5jAUS2yrLkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flsvOfrEXeICEfPWiktfu1lL0XNsgMGoX5gurwOCpUSP8+PWoKSLrxkvCPZhbmG+Y
	 n+p6XSJVHqfKkBtVZggvjvLlt3zjYbFjDm2pXmobm7rm5b0YoFga9Ua/GDfAUv6ajM
	 VA3mJbODWu5g06nSD90M8Si0f49wkB6Gg6QYzctY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfD0Bqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfD0BnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90912168B;
        Sat, 27 Apr 2019 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329398;
        bh=PK+mpmAm7MUkBeFcoMfzY206FIHmnQKT5jAUS2yrLkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnp4kITlg75W5ifoCgKzSY4YjP4ampfIGxKYeC7MB7arWFtqE0LxOl6mFOluDnilg
         IUxBo3Z8cg+S9/NvbK1u1lHt/ln3uFVWlGYRNqnYrAeRnEE1FpBcMlkwM0IJr4FSgb
         bo6WLW3a6RFPfQ3vZAWoCOwbuXbBXawxE+Dm3b3Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 30/32] iommu/amd: Set exclusion range correctly
Date:   Fri, 26 Apr 2019 21:42:21 -0400
Message-Id: <20190427014224.8274-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
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
index b97984a5ddad..9b3d8fd5f7c1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -355,7 +355,7 @@ static void iommu_write_l2(struct amd_iommu *iommu, u8 address, u32 val)
 static void iommu_set_exclusion_range(struct amd_iommu *iommu)
 {
 	u64 start = iommu->exclusion_start & PAGE_MASK;
-	u64 limit = (start + iommu->exclusion_length) & PAGE_MASK;
+	u64 limit = (start + iommu->exclusion_length - 1) & PAGE_MASK;
 	u64 entry;
 
 	if (!iommu->exclusion_start)
-- 
2.19.1


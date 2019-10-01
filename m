Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEEDC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B5E21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569949310;
	bh=Z4oG9QERilkftSaQTqEjgGuTvYWP4lgxuvUNmfwFQVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r7cNPpmIEgsLI5eRb+LhTGD+97p3L/OQZN25AtUtlH3D9T5DIHz+32tEyDreFl4nT
	 YspJJLxzd0kEZKWCviyG/sQ03rJAU3/hNWiHvS1XnmP3fbxtzwMPdP6H+exWMwTEvX
	 MyTwJy8v+lHJPAwWBs/kwhxRVG93sRkgAQ2hO/M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfJARBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbfJAQkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:40:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F3D32190F;
        Tue,  1 Oct 2019 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948014;
        bh=Z4oG9QERilkftSaQTqEjgGuTvYWP4lgxuvUNmfwFQVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZfMfSQRXEtIns/q0Irbk4qmI6AYlpSlaZClwF1vlUjYMutHBZ9HnyieRPUctTDcs
         CX4clo4aFi7muoDxFeLIg5gHUd3tv2TwfnpBN5sMnAv7RpF1Q8SFGZKSrVWtNVGuco
         2jpVrLA7lgJMGJlLwZoqQMbVlvRPoH92lEx6tTM8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrei Dulea <adulea@amazon.de>, Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.3 35/71] iommu/amd: Fix downgrading default page-sizes in alloc_pte()
Date:   Tue,  1 Oct 2019 12:38:45 -0400
Message-Id: <20191001163922.14735-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001163922.14735-1-sashal@kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Dulea <adulea@amazon.de>

[ Upstream commit 6ccb72f8374e17d60b58a7bfd5570496332c54e2 ]

Downgrading an existing large mapping to a mapping using smaller
page-sizes works only for the mappings created with page-mode 7 (i.e.
non-default page size).

Treat large mappings created with page-mode 0 (i.e. default page size)
like a non-present mapping and allow to overwrite it in alloc_pte().

While around, make sure that we flush the TLB only if we change an
existing mapping, otherwise we might end up acting on garbage PTEs.

Fixes: 6d568ef9a622 ("iommu/amd: Allow downgrading page-sizes in alloc_pte()")
Signed-off-by: Andrei Dulea <adulea@amazon.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 61de81965c44e..0fb42a846404b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1490,6 +1490,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		pte_level = PM_PTE_LEVEL(__pte);
 
 		if (!IOMMU_PTE_PRESENT(__pte) ||
+		    pte_level == PAGE_MODE_NONE ||
 		    pte_level == PAGE_MODE_7_LEVEL) {
 			page = (u64 *)get_zeroed_page(gfp);
 			if (!page)
@@ -1500,7 +1501,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 			/* pte could have been changed somewhere. */
 			if (cmpxchg64(pte, __pte, __npte) != __pte)
 				free_page((unsigned long)page);
-			else if (pte_level == PAGE_MODE_7_LEVEL)
+			else if (IOMMU_PTE_PRESENT(__pte))
 				domain->updated = true;
 
 			continue;
-- 
2.20.1


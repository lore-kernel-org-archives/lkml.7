Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A7C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABBE222C8
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067432;
	bh=rbeWn0IPTd+TWEds9YFtOWj5EmQqVblA0ypZpXd4tiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQlEKss6lKrUhOx8Jt5t0x2kY06J0B8QQPFKIG0S9XZaUGnbpP3HNYUK4xWP0NLND
	 UjAMQuDRrlKp1rTRdk27DJOtEoeBfFB1RT36N4hKJoV1dTAwOR1BFmI8OlSl3wGOfR
	 KbzNcv3l3zm5c28EK4C0lbS5TQXJy9dAEtF1kDx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392135AbfIIWRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406262AbfIIWQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:16:54 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A1C222BD;
        Mon,  9 Sep 2019 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067413;
        bh=rbeWn0IPTd+TWEds9YFtOWj5EmQqVblA0ypZpXd4tiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3m8qC90I9xmd2fNQSDpJd5r0A+ZBOUj4j7g776mfVTmoO/JeoDk+kZhb8TrHxIOD
         sakDNQuPM1BnwaZT9bIm51Vgs+jVCv2M80uPFAolNZjcx2shnEKfn41ckc3CfB6BSe
         Lu/OElj5YfV4cwV6jYy3g/rpfZFqT3FPrZLDW/68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 8/8] iommu/amd: Fix race in increase_address_space()
Date:   Mon,  9 Sep 2019 11:41:23 -0400
Message-Id: <20190909154124.31146-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909154124.31146-1-sashal@kernel.org>
References: <20190909154124.31146-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 754265bcab78a9014f0f99cd35e0d610fcd7dfa7 ]

After the conversion to lock-less dma-api call the
increase_address_space() function can be called without any
locking. Multiple CPUs could potentially race for increasing
the address space, leading to invalid domain->mode settings
and invalid page-tables. This has been happening in the wild
under high IO load and memory pressure.

Fix the race by locking this operation. The function is
called infrequently so that this does not introduce
a performance regression in the dma-api path again.

Reported-by: Qian Cai <cai@lca.pw>
Fixes: 256e4621c21a ('iommu/amd: Make use of the generic IOVA allocator')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8b79e2b32d378..69c269dc4f1bf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1340,18 +1340,21 @@ static void domain_flush_devices(struct protection_domain *domain)
  * another level increases the size of the address space by 9 bits to a size up
  * to 64 bits.
  */
-static bool increase_address_space(struct protection_domain *domain,
+static void increase_address_space(struct protection_domain *domain,
 				   gfp_t gfp)
 {
+	unsigned long flags;
 	u64 *pte;
 
-	if (domain->mode == PAGE_MODE_6_LEVEL)
+	spin_lock_irqsave(&domain->lock, flags);
+
+	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
 		/* address space already 64 bit large */
-		return false;
+		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
-		return false;
+		goto out;
 
 	*pte             = PM_LEVEL_PDE(domain->mode,
 					iommu_virt_to_phys(domain->pt_root));
@@ -1359,7 +1362,10 @@ static bool increase_address_space(struct protection_domain *domain,
 	domain->mode    += 1;
 	domain->updated  = true;
 
-	return true;
+out:
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return;
 }
 
 static u64 *alloc_pte(struct protection_domain *domain,
-- 
2.20.1


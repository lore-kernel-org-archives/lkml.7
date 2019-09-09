Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE79C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFFE222BD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568067455;
	bh=EEJyiFOb58dYeSeHP50yL1HEZhSK5Fe9OBqGqb3mxTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xyqK4PPzPsL2S/RLx2/yT0zgF8mGjhY3ezJ4xMo3NEmEztN6cqpnSGsJKxeA4tzx3
	 d9HvK3taPg2RYYjOUs0X9XfzBi7PQ5v02BX5WyRe4u7++i9BasR1DaN6+Q4TYfRWD8
	 bI6tpm6QF9Bq0FjMrcAgj6u25Qx3MALqk4QuJmaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406384AbfIIWRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406338AbfIIWR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:17:29 -0400
Received: from sasha-vm.mshome.net (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8884E21A4A;
        Mon,  9 Sep 2019 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568067448;
        bh=EEJyiFOb58dYeSeHP50yL1HEZhSK5Fe9OBqGqb3mxTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRDKCxrM9q9qA8Li8WJZGN81LYyjTqw4C49Jbw2hcqSOnYEisozyuVR2yryP7pIuG
         3TygeS7SbQ+ZXblHo11hubYDp/IhJ7928FoT7cMHOkMVhpOQW+UgKT1FMpypcFHpHG
         djaigjdKyY6Mhvrh3Y9N9zijmCpAZCt5u/jTaCfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 6/6] iommu/amd: Fix race in increase_address_space()
Date:   Mon,  9 Sep 2019 11:42:05 -0400
Message-Id: <20190909154205.31376-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909154205.31376-1-sashal@kernel.org>
References: <20190909154205.31376-1-sashal@kernel.org>
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
index c1233d0288a03..dd7880de7e4e9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1321,18 +1321,21 @@ static void domain_flush_devices(struct protection_domain *domain)
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
 					virt_to_phys(domain->pt_root));
@@ -1340,7 +1343,10 @@ static bool increase_address_space(struct protection_domain *domain,
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


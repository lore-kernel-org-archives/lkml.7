Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27680C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63A921849
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752081;
	bh=1kTjorHKug1z3+zFnC5XiWcgikyUykEsK13olvWbKPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q5xru2Yx80+00PisrkoCR3NfmgaGdxNpAZOlAJBm+aqUiqe1DOBqxrvGa8BttpD6C
	 9kUa+wyHdaTD9IA/B6Ht4Q19omkNS71WxTX8qATpugN7R8QFRAsuTCcp1HOyZnLKpA
	 sKAibJYUm0Qs96HQVmYeLFE+7pwN/+knAKCPQvpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393555AbfHBNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393513AbfHBNVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:21:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D433B21841;
        Fri,  2 Aug 2019 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752072;
        bh=1kTjorHKug1z3+zFnC5XiWcgikyUykEsK13olvWbKPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQIBhHvuS02pT/aBbxjg/vZDDDhNwLFWzH3U0q9vxl9NMHHkeW7A9jgBqQt18FwC8
         7tnhiNYNrqTpuNVxj0eN4NOZlGZc/CvcZ7zhWKesXyqUoc/9UJriZKsoKQcTk5NYM3
         UAoLem/NZ4xMcJICoYiUPawPprs2VqLN0XHw/uWI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 40/76] iommu/vt-d: Check if domain->pgd was allocated
Date:   Fri,  2 Aug 2019 09:19:14 -0400
Message-Id: <20190802131951.11600-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>

[ Upstream commit 3ee9eca760e7d0b68c55813243de66bbb499dc3b ]

There is a couple of places where on domain_init() failure domain_exit()
is called. While currently domain_init() can fail only if
alloc_pgtable_page() has failed.

Make domain_exit() check if domain->pgd present, before calling
domain_unmap(), as it theoretically should crash on clearing pte entries
in dma_pte_clear_level().

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2101601adf57d..1ad24367373f4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1900,7 +1900,6 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 
 static void domain_exit(struct dmar_domain *domain)
 {
-	struct page *freelist;
 
 	/* Remove associated devices and clear attached or cached domains */
 	rcu_read_lock();
@@ -1910,9 +1909,12 @@ static void domain_exit(struct dmar_domain *domain)
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
 
-	freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+	if (domain->pgd) {
+		struct page *freelist;
 
-	dma_free_pagelist(freelist);
+		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+		dma_free_pagelist(freelist);
+	}
 
 	free_domain_mem(domain);
 }
-- 
2.20.1


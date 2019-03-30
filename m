Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E79AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425542184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908118;
	bh=RR4WGbZ678KnUXmmrIFaR/JZIireJljtlwxDrTiAkbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xse1FHHW0r251ekF3eJMX9fBgbtQcFTYXtSvUmXJi8EAMwhRfK0OM0PIT0Sq9nUAk
	 2n8od7nqDTKq7b3Mq9612OrUncH8EUvTa4S+puss/wq2/tAjr0IkCn3PjECQfUq6LI
	 kOtjCrixbHqoKHgih3YBkE5BfJz7ni1j3AvTvZpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfC3BIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbfC3Awq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC91218D3;
        Sat, 30 Mar 2019 00:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907165;
        bh=RR4WGbZ678KnUXmmrIFaR/JZIireJljtlwxDrTiAkbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U17Vlxqm6uzcs9E4i3yrC49M+7DeUXJG2AcbBEJuD4CSqZvlORIzcRiMxWhQwGyn4
         aAuKhcdYCizpNWeyYKyAB0isyt+Zor8uzOj/2sCnN4gKg/urp1oIORHNm/ruPNVy++
         8WogjyCZqTrUcaweXlDbf6Xwk5OhEPw7acCtUfGo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        mark gross <mgross@intel.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.0 60/67] iommu/vt-d: Check capability before disabling protected memory
Date:   Fri, 29 Mar 2019 20:50:40 -0400
Message-Id: <20190330005047.25998-60-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 5bb71fc790a88d063507dc5d445ab8b14e845591 ]

The spec states in 10.4.16 that the Protected Memory Enable
Register should be treated as read-only for implementations
not supporting protected memory regions (PLMR and PHMR fields
reported as Clear in the Capability register).

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: mark gross <mgross@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: f8bab73515ca5 ("intel-iommu: PMEN support")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..63b427cc13d5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1534,6 +1534,9 @@ static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
 	u32 pmen;
 	unsigned long flags;
 
+	if (!cap_plmr(iommu->cap) && !cap_phmr(iommu->cap))
+		return;
+
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 	pmen = readl(iommu->reg + DMAR_PMEN_REG);
 	pmen &= ~DMA_PMEN_EPM;
-- 
2.19.1


Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3707FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DDE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714991;
	bh=gru6+zxB/qL5GRbcFnmiFmqZz3ht2VVv9COf8ZQJChE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FulSfEaqoUMdw03R5iiMOPaYr9hdKwJzMB+O5cYP1Z4mUFpHSLHCI8bReTK8eeJKY
	 3lYnDNAFUN40Ws+O8trDb7+KK71SDNgoXR9AkqNbmh/Mq7rLTfB9HtisgsvhsxU5OY
	 fHcWXiCDpNNmsGoeu7fWv6s4YWn2y5JQ3qfmPWLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbfC0SDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732659AbfC0SDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B655A2075C;
        Wed, 27 Mar 2019 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709817;
        bh=gru6+zxB/qL5GRbcFnmiFmqZz3ht2VVv9COf8ZQJChE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ke3GjqPLebEyosi8xF85CZ0JdUuCdbMv93HiIfR0wkYsErxUeEc4T9FR014mMwp8I
         NkeXpVHDVY+SVdKMIF1JSprPcD2gzn2RBvFdhKd53MxTrPuDi+2Ul6iiL5fopJijJN
         uOEAsPxn4IeJDPNwmajntTsQStMwEfDwruHojlfA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.0 056/262] iommu/vt-d: Disable ATS support on untrusted devices
Date:   Wed, 27 Mar 2019 13:58:31 -0400
Message-Id: <20190327180158.10245-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit d8b8591054575f33237556c32762d54e30774d28 ]

Commit fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted
devices") disables ATS support on the devices which have been marked
as untrusted. Unfortunately this is not enough to fix the DMA attack
vulnerabiltiies because IOMMU driver allows translated requests as
long as a device advertises the ATS capability. Hence a malicious
peripheral device could use this to bypass IOMMU.

This disables the ATS support on untrusted devices by clearing the
internal per-device ATS mark. As the result, IOMMU driver will block
any translated requests from any device marked as untrusted.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..dbd6824dfffa 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2485,7 +2485,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (!pci_ats_disabled() &&
+		if (!pdev->untrusted &&
+		    !pci_ats_disabled() &&
 		    ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
 		    dmar_find_matched_atsr_unit(pdev))
-- 
2.19.1


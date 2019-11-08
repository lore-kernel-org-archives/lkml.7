Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE74DFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE0222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573226183;
	bh=LpveQr5gCY/b/ZvJFMy1ru71q14LgaJP5KNjnL2W3yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VfrBAGzdUqh1SRUj0Ghm5tuwpgmt6eNo1Hnoy+e6whJTykq8A7qSiAIAb5TzSwkKh
	 VzPZpgnzgejdjaYfaTzvGgwTBcKksus7PpOYsURCFzv6l/wmNOQwphHwZiYlc7Lujl
	 m3I/utJU6GpVRIS8myOFNtx1WPecoMJaJfsUg5WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKHPQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:16:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHPQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:21 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97B06222C6;
        Fri,  8 Nov 2019 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226180;
        bh=LpveQr5gCY/b/ZvJFMy1ru71q14LgaJP5KNjnL2W3yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1j/Uiaswaf35McUWOJYZ16KOpxVDV/mtdbcOZKsq2TplH5DR2VAm7Nbho4u2l6BV
         pES7gp0f1pI4X99RhNEr5osYIaAWXgXoNHerj2mM2ycLrKhz/dgt6HF4Ci7F7LG+46
         mVrXevXy+I6s9wzbyjp8XYSopKYG4J1mkTOENQSo=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 2/9] iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
Date:   Fri,  8 Nov 2019 15:16:01 +0000
Message-Id: <20191108151608.20932-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108151608.20932-1-will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid having to export 'pci_request_acs()' to modular IOMMU drivers,
move the call into the 'of_dma_configure()' path in a similar manner to
the way in which ACS is configured when probing via ACPI/IORT.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..78faa9f73a91 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -177,6 +177,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			.np = master_np,
 		};
 
+		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else if (dev_is_fsl_mc(dev)) {
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog


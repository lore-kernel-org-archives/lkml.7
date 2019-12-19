Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE65C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DB924679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757051;
	bh=+edYjojsjbbD8IDTUOpeEvB++8RboguP7jCnQgWXIwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGD8PHwbqxT2c16MnYTyFaiErLMmA7lfW5tZuSsZgu/i12ygIh9ma0292bpEqK+qV
	 HAE+VIIckHkhZHtZCbzz6JbsrP7ZPJKRfAOAjYhdH83nIeuUQ6UOWWbk5dFAnYHrye
	 sMO5LIKe5V9rOjdl0sH7W9Ua0fs1kNK3HWJr1/jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSMEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfLSMEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:06 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B81324684;
        Thu, 19 Dec 2019 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757046;
        bh=+edYjojsjbbD8IDTUOpeEvB++8RboguP7jCnQgWXIwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lz9OjPmJkPftZ5/yegyrIxJTYzO5uf0aRRbhrJBi8xYk+x9HN/DYLpJ2n9a+Xj+Rb
         teOhqJikPjYK+FJRIg0fBIck/l90+QjdT6fWxz880/ZA2wiI7bucF6pMMUIeS/F9rp
         /3YdBYG/8H2ij1B6EQ42mXTAzf97u6hQWdnddb1E=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 02/16] iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
Date:   Thu, 19 Dec 2019 12:03:38 +0000
Message-Id: <20191219120352.382-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
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
index 026ad2b29dcd..4d2f02132e7a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -179,6 +179,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			.np = master_np,
 		};
 
+		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else if (dev_is_fsl_mc(dev)) {
-- 
2.24.1.735.g03f4e72817-goog


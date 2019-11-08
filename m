Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3CDC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F7B214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573226192;
	bh=uFaLAgrpPHuI/YFOn88Rm5/aUifByC237X9HFHz9J+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0SMhjR3RYJHYyl6W2KwSlaVyJhWDN0G6h4YqbdZv3/0SI+M+wrvbkLDxRlnEAgvgn
	 C/W+ZUBsf8rr94kY6d2OqZGqHFQF2G5tjrZgTeiZ7QswV7d8eyEMHjN3ZONmKdTCJt
	 SdW+L1u1dJd/BHk6xdofnFgXEPChyh4MoYliTUvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKHPQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:16:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHPQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:29 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3909D222CD;
        Fri,  8 Nov 2019 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226188;
        bh=uFaLAgrpPHuI/YFOn88Rm5/aUifByC237X9HFHz9J+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVpaEGWAXqD3t+ULRKRNz9570P3bYyFcit4fo3e3wFUaZPPR2/fEKHUt6BsjlDBZf
         c/yNFGphJAh8A+ngL4/OBoeBMvm0qbiVeGbCLZFGGzQiI1AH53yJs9osHFzyJJ/UvQ
         jaHjKvMV2I2w7VnigaZ/ojohJtymu3Qdypqg7lkg=
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
Subject: [PATCH v2 5/9] iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
Date:   Fri,  8 Nov 2019 15:16:04 +0000
Message-Id: <20191108151608.20932-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108151608.20932-1-will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that we hold a reference to the IOMMU driver module while calling
the '->of_xlate()' callback during early device probing.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/of_iommu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 78faa9f73a91..25491403a0bd 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/limits.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
@@ -89,16 +90,16 @@ static int of_iommu_xlate(struct device *dev,
 {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
-	int err;
+	int ret;
 
 	ops = iommu_ops_from_fwnode(fwnode);
 	if ((ops && !ops->of_xlate) ||
 	    !of_device_is_available(iommu_spec->np))
 		return NO_IOMMU;
 
-	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
-	if (err)
-		return err;
+	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
+	if (ret)
+		return ret;
 	/*
 	 * The otherwise-empty fwspec handily serves to indicate the specific
 	 * IOMMU device we're waiting for, which will be useful if we ever get
@@ -107,7 +108,12 @@ static int of_iommu_xlate(struct device *dev,
 	if (!ops)
 		return driver_deferred_probe_check_state(dev);
 
-	return ops->of_xlate(dev, iommu_spec);
+	if (!try_module_get(ops->owner))
+		return -ENODEV;
+
+	ret = ops->of_xlate(dev, iommu_spec);
+	module_put(ops->owner);
+	return ret;
 }
 
 struct of_pci_iommu_alias_info {
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog


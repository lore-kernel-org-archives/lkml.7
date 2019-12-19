Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B04C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6665C24650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757064;
	bh=+UKbqK2TWf2QwSTy2qG+mcNAplq+KOJBm40P5NqJ1p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qo/lFJu31z9bEPHT8/fBtX+sLt1yzSGZ4fo3u4DIBFH0u/Fy8IdLcm5pHkZgqRWCV
	 7oupsT+B/UJNjmL72RS78nDVXMjdUKllxwp21HK92smXz+sFSJBG2UDJCtKDwu3ZoG
	 WoBYJBrpfvWMs7uES5GXRraNjwLM/d+Wom/zV9r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLSMEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfLSMES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:18 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1342467E;
        Thu, 19 Dec 2019 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757058;
        bh=+UKbqK2TWf2QwSTy2qG+mcNAplq+KOJBm40P5NqJ1p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgPP1GGZxJW8MNzzvkGtex/V1gzuT7tcKZmhXFLgdQibeVcjeGXS8yXe0ceQtSC/m
         kSEPVIOD8SA5TkEd5XJwOcar/bZuRKDtg5pvBhdkU5rmElI5zcVDRmZzsfYVpgnZkv
         k7vYEhCONwdvgMFyrIeUhLS9w9ZKakYDZUI9IFCg=
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
Subject: [PATCH v4 06/16] iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
Date:   Thu, 19 Dec 2019 12:03:42 +0000
Message-Id: <20191219120352.382-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
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
 drivers/iommu/of_iommu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 4d2f02132e7a..e7bc8b721947 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -8,11 +8,12 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include <linux/limits.h>
-#include <linux/pci.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
@@ -91,16 +92,16 @@ static int of_iommu_xlate(struct device *dev,
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
@@ -109,7 +110,12 @@ static int of_iommu_xlate(struct device *dev,
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
2.24.1.735.g03f4e72817-goog


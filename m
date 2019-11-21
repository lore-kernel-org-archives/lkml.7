Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34808C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6D4208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574336978;
	bh=rFa51ueQf+pwORJuugnBWYiOLfrkbP2Z9ytS43pAtgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fGTVfN5n6uLaaUtgDyRXtWGjpZLQqQdYz21pIXTl79U58ZQcONaijY0NPEe2fO/7h
	 zXLQTshOt/UtiqhP7vNbm2VoGrizwB5yiuLIbSRlmuU6YRKq9K+mESdCPhLgnpp1yN
	 3Y9xIztAZn0+DXftWkRBFXtPWBojlpwl7Rhoeq6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKULth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfKULtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:35 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C912E208D4;
        Thu, 21 Nov 2019 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336975;
        bh=rFa51ueQf+pwORJuugnBWYiOLfrkbP2Z9ytS43pAtgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/+udVerl5xd/obteEt4iJpxk0e4PijhYlb+LdCvS+78kfK/yvnCRabJyLiVQ9mX0
         7hrQSMb07q2YQ+9w6DxGn2BgA45NXll7vYRDCEjnY8WJaQErR+WWfrXBAVbZbeWwk4
         EwDv1pCmB3JPjU2yAU6MmJXBmq6I4w47o6fL+yis=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 04/14] drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
Date:   Thu, 21 Nov 2019 11:49:08 +0000
Message-Id: <20191121114918.2293-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid accidental removal of an active IOMMU driver module, take a
reference to the driver module in 'iommu_probe_device()' immediately
prior to invoking the '->add_device()' callback and hold it until the
after the device has been removed by '->remove_device()'.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++--
 include/linux/iommu.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c1aadb570145..4bfecfbbe2cf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
+#include <linux/module.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -185,10 +186,21 @@ int iommu_probe_device(struct device *dev)
 	if (!iommu_get_dev_param(dev))
 		return -ENOMEM;
 
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free_dev_param;
+	}
+
 	ret = ops->add_device(dev);
 	if (ret)
-		iommu_free_dev_param(dev);
+		goto err_module_put;
+
+	return 0;
 
+err_module_put:
+	module_put(ops->owner);
+err_free_dev_param:
+	iommu_free_dev_param(dev);
 	return ret;
 }
 
@@ -199,7 +211,10 @@ void iommu_release_device(struct device *dev)
 	if (dev->iommu_group)
 		ops->remove_device(dev);
 
-	iommu_free_dev_param(dev);
+	if (dev->iommu_param) {
+		module_put(ops->owner);
+		iommu_free_dev_param(dev);
+	}
 }
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29bac5345563..d9dab5a3e912 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -245,6 +245,7 @@ struct iommu_iotlb_gather {
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @owner: Driver module providing these ops
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -308,6 +309,7 @@ struct iommu_ops {
 			     struct iommu_page_response *msg);
 
 	unsigned long pgsize_bitmap;
+	struct module *owner;
 };
 
 /**
-- 
2.24.0.432.g9d3f5f5b63-goog


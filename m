Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E67C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101BF20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfCDNNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:13:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:33932 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfCDNNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:13:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 05:13:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="151870459"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2019 05:13:50 -0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        jean-philippe.brucker@arm.com, peterx@redhat.com,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
        yi.y.sun@intel.com, Liu@vger.kernel.org
Subject: [RFC v1 2/2] vfio/pci: expose only mdev interface if in pci-mdev mode
Date:   Sun,  3 Mar 2019 20:58:01 +0800
Message-Id: <1551617881-8520-3-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
References: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a pci device is wrapped as a mediated device. Then user should
only passthru it via vfio mdev framework. If not, there would be
conflict during the device access. This patch prevents user from
using legacy vfio-pci passthru interface. vfio-pci driver will only
expose mdev interface when working in pci-mdev mode. Thus could
prevent user from passthru device in legacy manner.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index d1c3fe6..422a3ff 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1273,11 +1273,15 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_init(&vdev->ioeventfds_lock);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
 
-	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
-	if (ret) {
-		vfio_iommu_group_put(group, &pdev->dev);
-		kfree(vdev);
-		return ret;
+	if (vfio_pci_mdev_mode) {
+		pci_set_drvdata(pdev, vdev);
+	} else {
+		ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
+		if (ret) {
+			vfio_iommu_group_put(group, &pdev->dev);
+			kfree(vdev);
+			return ret;
+		}
 	}
 
 	ret = vfio_pci_reflck_attach(vdev);
@@ -1329,7 +1333,10 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 {
 	struct vfio_pci_device *vdev;
 
-	vdev = vfio_del_group_dev(&pdev->dev);
+	if (vfio_pci_mdev_mode)
+		vdev = pci_get_drvdata(pdev);
+	else
+		vdev = vfio_del_group_dev(&pdev->dev);
 	if (!vdev)
 		return;
 
-- 
2.7.4


Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B56C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5993027B0B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfFCO6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:58:41 -0400
Received: from foss.arm.com ([217.140.101.70]:52626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfFCO6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:58:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 220C1A78;
        Mon,  3 Jun 2019 07:58:39 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55AB83F246;
        Mon,  3 Jun 2019 07:58:37 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org, alex.williamson@redhat.com
Cc:     jacob.jun.pan@linux.intel.com, eric.auger@redhat.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: [PATCH v2 1/4] driver core: Add per device iommu param
Date:   Mon,  3 Jun 2019 15:57:46 +0100
Message-Id: <20190603145749.46347-2-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

DMA faults can be detected by IOMMU at device level. Adding a pointer
to struct device allows IOMMU subsystem to report relevant faults
back to the device driver for further handling.
For direct assigned device (or user space drivers), guest OS holds
responsibility to handle and respond per device IOMMU fault.
Therefore we need fault reporting mechanism to propagate faults beyond
IOMMU subsystem.

There are two other IOMMU data pointers under struct device today, here
we introduce iommu_param as a parent pointer such that all device IOMMU
data can be consolidated here. The idea was suggested here by Greg KH
and Joerg. The name iommu_param is chosen here since iommu_data has been
used.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lkml.org/lkml/2017/10/6/81
---
 include/linux/device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index e85264fb6616..f0a975abd6e9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -42,6 +42,7 @@ struct iommu_ops;
 struct iommu_group;
 struct iommu_fwspec;
 struct dev_pin_info;
+struct iommu_param;
 
 struct bus_attribute {
 	struct attribute	attr;
@@ -959,6 +960,7 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu_fwspec: IOMMU-specific properties supplied by firmware.
+ * @iommu_param: Per device generic IOMMU runtime data
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -1052,6 +1054,7 @@ struct device {
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
 	struct iommu_fwspec	*iommu_fwspec;
+	struct iommu_param	*iommu_param;
 
 	bool			offline_disabled:1;
 	bool			offline:1;
-- 
2.21.0


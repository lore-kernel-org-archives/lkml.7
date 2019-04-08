Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1085C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD3220863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfDHX6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:58:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:9984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfDHX5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169941"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:07 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 04/18] driver core: add per device iommu param
Date:   Mon,  8 Apr 2019 16:59:19 -0700
Message-Id: <1554767973-30125-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
and Joerg. The name iommu_param is chosen here since iommu_data has been used.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lkml.org/lkml/2017/10/6/81
---
 include/linux/device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4e6987e..2cd48a6 100644
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
2.7.4


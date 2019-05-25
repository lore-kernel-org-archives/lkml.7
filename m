Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1093C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12BF2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfEYFtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEYFtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:49:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:49:07 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 10/15] iommu/vt-d: Probe DMA-capable ACPI name space devices
Date:   Sat, 25 May 2019 13:41:31 +0800
Message-Id: <20190525054136.27810-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms may support ACPI name-space enumerated devices
that are capable of generating DMA requests. Platforms which
support DMA remapping explicitly declares any such DMA-capable
ACPI name-space devices in the platform through ACPI Name-space
Device Declaration (ANDD) structure and enumerate them through
the Device Scope of the appropriate remapping hardware unit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b7f5a6390be6..7f9cf9188f5f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4816,6 +4816,48 @@ static int __init platform_optin_force_iommu(void)
 	return 1;
 }
 
+static int __init probe_acpi_namespace_devices(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	struct device *dev;
+	int i, ret = 0;
+
+	for_each_active_iommu(iommu, drhd) {
+		for_each_active_dev_scope(drhd->devices,
+					  drhd->devices_cnt, i, dev) {
+			struct acpi_device_physical_node *pn;
+			struct iommu_group *group;
+			struct acpi_device *adev;
+
+			if (dev->bus != &acpi_bus_type)
+				continue;
+
+			adev = to_acpi_device(dev);
+			mutex_lock(&adev->physical_node_lock);
+			list_for_each_entry(pn,
+					    &adev->physical_node_list, node) {
+				group = iommu_group_get(pn->dev);
+				if (group) {
+					iommu_group_put(group);
+					continue;
+				}
+
+				pn->dev->bus->iommu_ops = &intel_iommu_ops;
+				ret = iommu_probe_device(pn->dev);
+				if (ret)
+					break;
+			}
+			mutex_unlock(&adev->physical_node_lock);
+
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
@@ -4928,6 +4970,9 @@ int __init intel_iommu_init(void)
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
 
+	if (probe_acpi_namespace_devices())
+		pr_warn("ACPI name space devices didn't probe correctly\n");
+
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
 		if (!translation_pre_enabled(iommu))
-- 
2.17.1


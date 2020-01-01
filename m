Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DA2C2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A71F206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgAAF20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 00:28:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:55757 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgAAF2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 00:28:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 21:28:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,382,1571727600"; 
   d="scan'208";a="244319515"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2019 21:28:23 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for iommu passthrough
Date:   Wed,  1 Jan 2020 13:26:46 +0800
Message-Id: <20200101052648.14295-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101052648.14295-1-baolu.lu@linux.intel.com>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new parameter takes a list of devices separated by a semicolon.
Each device specified will have its iommu_passthrough bit in struct
device set. This is very similar to the existing 'disable_acs_redir'
parameter.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/pci/pci.c                             | 34 +++++++++++++++++++
 drivers/pci/pci.h                             |  1 +
 drivers/pci/probe.c                           |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..d3edc2cb6696 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3583,6 +3583,11 @@
 				may put more devices in an IOMMU group.
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
+		iommu_passthrough=<pci_dev>[; ...]
+				Specify one or more PCI devices (in the format
+				specified above) separated by semicolons.
+				Each device specified will bypass IOMMU DMA
+				translation.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 90dbd7c70371..05bf3f4acc36 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6401,6 +6401,37 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_fixup_cardbus);
 
+static const char *iommu_passthrough_param;
+bool pci_iommu_passthrough_match(struct pci_dev *dev)
+{
+	int ret = 0;
+	const char *p = iommu_passthrough_param;
+
+	if (!p)
+		return false;
+
+	while (*p) {
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret < 0) {
+			pr_info_once("PCI: Can't parse iommu_passthrough parameter: %s\n",
+				     iommu_passthrough_param);
+
+			break;
+		} else if (ret == 1) {
+			pci_info(dev, "PCI: IOMMU passthrough\n");
+			return true;
+		}
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		p++;
+	}
+
+	return false;
+}
+
 static int __init pci_setup(char *str)
 {
 	while (str) {
@@ -6462,6 +6493,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "iommu_passthrough=", 18)) {
+				iommu_passthrough_param = str + 18;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
@@ -6486,6 +6519,7 @@ static int __init pci_realloc_setup_params(void)
 	resource_alignment_param = kstrdup(resource_alignment_param,
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
+	iommu_passthrough_param = kstrdup(iommu_passthrough_param, GFP_KERNEL);
 
 	return 0;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd05a0b..95f6af06aba6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -288,6 +288,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
 void pci_bus_put(struct pci_bus *bus);
+bool pci_iommu_passthrough_match(struct pci_dev *dev);
 
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb4312ddd..4c571ee75621 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2404,6 +2404,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	dev->state_saved = false;
 
+	dev->dev.iommu_passthrough = pci_iommu_passthrough_match(dev);
+
 	pci_init_capabilities(dev);
 
 	/*
-- 
2.17.1


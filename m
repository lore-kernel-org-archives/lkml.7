Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6874CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAACA20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfJVWB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:01:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33324 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732174AbfJVWB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:01:26 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN2DU-0004Kq-By; Tue, 22 Oct 2019 16:01:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN2DT-0000Ir-7R; Tue, 22 Oct 2019 16:01:23 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>
Cc:     Kit Chow <kchow@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 22 Oct 2019 16:01:20 -0600
Message-Id: <20191022220121.1120-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022220121.1120-1-logang@deltatee.com>
References: <20191022220121.1120-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 1/2] iommu/amd: Support multiple PCI DMA aliases in device table
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-Transparent Bridge (NTB) devices (among others) may have many DMA
aliases seeing the hardware will send requests with different device ids
depending on their origin across the bridged hardware.

See commit ad281ecf1c7d ("PCI: Add DMA alias quirk for Microsemi
Switchtec NTB") for more information on this.

The AMD IOMMU ignores all the PCI aliases except the last one so DMA
transfers from these aliases will be blocked on AMD hardware with the
IOMMU enabled.

To fix this, ensure the DTEs are cloned for every PCI alias. This is
done by copying the DTE data for each alias as well as the IVRS alias
every time it is changed.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/amd_iommu.c       | 133 +++++++++++++++-----------------
 drivers/iommu/amd_iommu_types.h |   2 +-
 2 files changed, 62 insertions(+), 73 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index cb1b5ba93f37..585c2a94a7e9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -204,71 +204,61 @@ static struct iommu_dev_data *search_dev_data(u16 devid)
 	return NULL;
 }
 
-static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
+static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
-	*(u16 *)data = alias;
-	return 0;
-}
-
-static u16 get_alias(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	u16 devid, ivrs_alias, pci_alias;
+	u16 devid = pci_dev_id(pdev);
 
-	/* The callers make sure that get_device_id() does not fail here */
-	devid = get_device_id(dev);
-
-	/* For ACPI HID devices, we simply return the devid as such */
-	if (!dev_is_pci(dev))
-		return devid;
+	if (devid == alias)
+		return 0;
 
-	ivrs_alias = amd_iommu_alias_table[devid];
+	amd_iommu_rlookup_table[alias] =
+		amd_iommu_rlookup_table[devid];
+	memcpy(amd_iommu_dev_table[alias].data,
+	       amd_iommu_dev_table[devid].data,
+	       sizeof(amd_iommu_dev_table[alias].data));
 
-	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
+	return 0;
+}
 
-	if (ivrs_alias == pci_alias)
-		return ivrs_alias;
+static void clone_aliases(struct pci_dev *pdev)
+{
+	if (!pdev)
+		return;
 
 	/*
-	 * DMA alias showdown
-	 *
-	 * The IVRS is fairly reliable in telling us about aliases, but it
-	 * can't know about every screwy device.  If we don't have an IVRS
-	 * reported alias, use the PCI reported alias.  In that case we may
-	 * still need to initialize the rlookup and dev_table entries if the
-	 * alias is to a non-existent device.
+	 * The IVRS alias stored in the alias table may not be
+	 * part of the PCI DMA aliases if it's bus differs
+	 * from the original device.
 	 */
-	if (ivrs_alias == devid) {
-		if (!amd_iommu_rlookup_table[pci_alias]) {
-			amd_iommu_rlookup_table[pci_alias] =
-				amd_iommu_rlookup_table[devid];
-			memcpy(amd_iommu_dev_table[pci_alias].data,
-			       amd_iommu_dev_table[devid].data,
-			       sizeof(amd_iommu_dev_table[pci_alias].data));
-		}
+	clone_alias(pdev, amd_iommu_alias_table[pci_dev_id(pdev)], NULL);
 
-		return pci_alias;
-	}
+	pci_for_each_dma_alias(pdev, clone_alias, NULL);
+}
 
-	pci_info(pdev, "Using IVRS reported alias %02x:%02x.%d "
-		"for device [%04x:%04x], kernel reported alias "
-		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
-		PCI_FUNC(ivrs_alias), pdev->vendor, pdev->device,
-		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
-		PCI_FUNC(pci_alias));
+static struct pci_dev *setup_aliases(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 ivrs_alias;
+
+	/* For ACPI HID devices, there are no aliases */
+	if (!dev_is_pci(dev))
+		return NULL;
 
 	/*
-	 * If we don't have a PCI DMA alias and the IVRS alias is on the same
-	 * bus, then the IVRS table may know about a quirk that we don't.
+	 * Add the IVRS alias to the pci aliases if it is on the same
+	 * bus. The IVRS table may know about a quirk that we don't.
 	 */
-	if (pci_alias == devid &&
+	ivrs_alias = amd_iommu_alias_table[pci_dev_id(pdev)];
+	if (ivrs_alias != pci_dev_id(pdev) &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
 		pci_info(pdev, "Added PCI DMA alias %02x.%d\n",
 			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias));
 	}
 
-	return ivrs_alias;
+	clone_aliases(pdev);
+
+	return pdev;
 }
 
 static struct iommu_dev_data *find_dev_data(u16 devid)
@@ -406,7 +396,7 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
-	dev_data->alias = get_alias(dev);
+	dev_data->pdev = setup_aliases(dev);
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -431,20 +421,16 @@ static int iommu_init_device(struct device *dev)
 
 static void iommu_ignore_device(struct device *dev)
 {
-	u16 alias;
 	int devid;
 
 	devid = get_device_id(dev);
 	if (devid < 0)
 		return;
 
-	alias = get_alias(dev);
-
+	amd_iommu_rlookup_table[devid] = NULL;
 	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
-	memset(&amd_iommu_dev_table[alias], 0, sizeof(struct dev_table_entry));
 
-	amd_iommu_rlookup_table[devid] = NULL;
-	amd_iommu_rlookup_table[alias] = NULL;
+	setup_aliases(dev);
 }
 
 static void iommu_uninit_device(struct device *dev)
@@ -1213,6 +1199,13 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	return iommu_queue_command(iommu, &cmd);
 }
 
+static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct amd_iommu *iommu = data;
+
+	return iommu_flush_dte(iommu, alias);
+}
+
 /*
  * Command send function for invalidating a device table entry
  */
@@ -1223,14 +1216,22 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	int ret;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
-	alias = dev_data->alias;
 
-	ret = iommu_flush_dte(iommu, dev_data->devid);
-	if (!ret && alias != dev_data->devid)
-		ret = iommu_flush_dte(iommu, alias);
+	if (dev_data->pdev)
+		ret = pci_for_each_dma_alias(dev_data->pdev,
+					     device_flush_dte_alias, iommu);
+	else
+		ret = iommu_flush_dte(iommu, dev_data->devid);
 	if (ret)
 		return ret;
 
+	alias = amd_iommu_alias_table[dev_data->devid];
+	if (alias != dev_data->devid) {
+		ret = iommu_flush_dte(iommu, alias);
+		if (ret)
+			return ret;
+	}
+
 	if (dev_data->ats.enabled)
 		ret = device_flush_iotlb(dev_data, 0, ~0UL);
 
@@ -1945,11 +1946,9 @@ static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
-	u16 alias;
 	bool ats;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
-	alias = dev_data->alias;
 	ats   = dev_data->ats.enabled;
 
 	/* Update data structures */
@@ -1962,8 +1961,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain, ats, dev_data->iommu_v2);
-	if (alias != dev_data->devid)
-		set_dte_entry(alias, domain, ats, dev_data->iommu_v2);
+	clone_aliases(dev_data->pdev);
 
 	device_flush_dte(dev_data);
 }
@@ -1972,17 +1970,14 @@ static void do_detach(struct iommu_dev_data *dev_data)
 {
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
-	u16 alias;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
-	alias = dev_data->alias;
 
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
-	if (alias != dev_data->devid)
-		clear_dte_entry(alias);
+	clone_aliases(dev_data->pdev);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
@@ -2283,13 +2278,7 @@ static void update_device_table(struct protection_domain *domain)
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
 		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled,
 			      dev_data->iommu_v2);
-
-		if (dev_data->devid == dev_data->alias)
-			continue;
-
-		/* There is an alias, update device table entry for it */
-		set_dte_entry(dev_data->alias, domain, dev_data->ats.enabled,
-			      dev_data->iommu_v2);
+		clone_aliases(dev_data->pdev);
 	}
 }
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 512cb3970a2e..f52f59d5c6bd 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -638,8 +638,8 @@ struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
+	struct pci_dev *pdev;
 	u16 devid;			  /* PCI Device ID */
-	u16 alias;			  /* Alias Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
 	bool passthrough;		  /* Device is identity mapped */
 	struct {
-- 
2.20.1


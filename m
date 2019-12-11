Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C29C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8630D2465E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077655;
	bh=kB4e3pgdX5avATnnjByo+dKmmI8eRu5xSq64oDIVJq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cEwpGrhvlUZLVZo3OIoUI9lVS9BpyMVfePg++CJzNLeDMIEGBsurSvThxmnj6Bz/3
	 vGt24suDAe4R5O8XuY3zvuq7ScwgnCCkPNXm7dzrux4ceHJydwP3Magm4t5JXOSgHE
	 tAJlrcbM7qKg0ugscL4/fLC2r5FBS7wxQIG+gGV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfLKPUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbfLKPUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:20:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB10F2465C;
        Wed, 11 Dec 2019 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077652;
        bh=kB4e3pgdX5avATnnjByo+dKmmI8eRu5xSq64oDIVJq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3kkHf4Cv8GuDix/BK03PXSp99rQMMJu4PVbY8EIYhrikF4wzaeLWz4RiOzn8H8l0
         9G8YTzki4h6hgsWR06VpMhpmmF/E61IHuaOYsUfVlgOdOT4vBG85hAYjrIeoi9n379
         zBT+HXv+zEV5tKINQeLwkjNw9fOD4Cl2QRmaUIJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 120/243] iommu/amd: Fix line-break in error log reporting
Date:   Wed, 11 Dec 2019 16:04:42 +0100
Message-Id: <20191211150347.232612062@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 1a21ee1aabf7ff9484f2eb122476d80c7f60a620 ]

With the switch to dev_err for reporting errors from the
iommu log there was an unwanted newline introduced. The
reason was that the reporting was done in multiple dev_err()
calls, and dev_err adds a newline after every call.

Fix it by printing the log messages with only one dev_err()
call.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fe18804a50083..9991386fb7000 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -549,7 +549,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 		dev_data = get_dev_data(&pdev->dev);
 
 	if (dev_data && __ratelimit(&dev_data->rs)) {
-		dev_err(&pdev->dev, "AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		dev_err(&pdev->dev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			domain_id, address, flags);
 	} else if (printk_ratelimit()) {
 		pr_err("AMD-Vi: Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
@@ -589,43 +589,41 @@ retry:
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(devid, pasid, address, flags);
 		return;
-	} else {
-		dev_err(dev, "AMD-Vi: Event logged [");
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		dump_dte_entry(devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
 			"address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x domain=0x%04x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
-		dev_err(dev, "ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
+		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%016llx]\n", address);
 		dump_command(address);
 		break;
 	case EVENT_TYPE_CMD_HARD_ERR:
-		dev_err(dev, "COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [COMMAND_HARDWARE_ERROR address=0x%016llx flags=0x%04x]\n",
 			address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		dev_err(dev, "IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
+		dev_err(dev, "Event logged [IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%016llx]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		dev_err(dev, "INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
@@ -633,12 +631,12 @@ retry:
 		pasid = ((event[0] >> 16) & 0xFFFF)
 			| ((event[1] << 6) & 0xF0000);
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	default:
-		dev_err(dev, "UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
+		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
 	}
 
-- 
2.20.1




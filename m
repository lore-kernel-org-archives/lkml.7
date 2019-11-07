Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9618C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E692084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfKGJjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:39:52 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:63390 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfKGJjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:39:52 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id xA79aoag094479;
        Thu, 7 Nov 2019 17:36:51 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id xA79aiNP024677;
        Thu, 7 Nov 2019 17:36:44 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from ubuntu.localdomain (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 7 Nov 2019
 17:36:46 +0800
From:   Jiasen Lin <linjiasen@hygon.cn>
To:     <jdmason@kudzu.us>, <Shyam-sundar.S-k@amd.com>,
        <dave.jiang@intel.com>, <allenbh@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linjiasen@hygon.cn>, <linjiasen007@gmail.com>
Subject: [PATCH] NTB: Fix an error in get link status
Date:   Thu, 7 Nov 2019 01:35:36 -0800
Message-ID: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn xA79aoag094479
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset of PCIe Capability Header for AMD and HYGON NTB is 0x64,
but the macro which named "AMD_LINK_STATUS_OFFSET" is defined as 0x68.
It is offset of Device Capabilities Reg rather than Link Control Reg.

This code trigger an error in get link statsus:

	cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
		LNK STA -               0x8fa1
		Link Status -           Up
		Link Speed -            PCI-E Gen 0
		Link Width -            x0

This patch use pcie_capability_read_dword to get link status.
After fix this issue, we can get link status accurately:

	cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
		LNK STA -               0x11030042
		Link Status -           Up
		Link Speed -            PCI-E Gen 3
		Link Width -            x16

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++--
 drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 156c2a1..ae91105 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -855,8 +855,8 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
 	ndev->cntl_sta = reg;
 
-	rc = pci_read_config_dword(ndev->ntb.pdev,
-				   AMD_LINK_STATUS_OFFSET, &stat);
+	rc = pcie_capability_read_dword(ndev->ntb.pdev,
+				   PCI_EXP_LNKCTL, &stat);
 	if (rc)
 		return 0;
 	ndev->lnk_sta = stat;
@@ -1139,6 +1139,7 @@ static const struct ntb_dev_data dev_data[] = {
 static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 139a307..39e5d18 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 
 #define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
-#define AMD_LINK_STATUS_OFFSET	0x68
 #define NTB_LIN_STA_ACTIVE_BIT	0x00000002
 #define NTB_LNK_STA_SPEED_MASK	0x000F0000
 #define NTB_LNK_STA_WIDTH_MASK	0x03F00000
-- 
2.7.4


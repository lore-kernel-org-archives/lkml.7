Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA60C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBC2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hr+cdaiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfKZPCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:02:31 -0500
Received: from mail-eopbgr720063.outbound.protection.outlook.com ([40.107.72.63]:5709
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbfKZPCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:02:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imGfv7f/YVQS/7A2u4mDLcMhXYHkxg4K3XceZlUpp3ZraMhC7h6scPHJov9SeT6/40dInbLPSDjyFWtwOhBl9vaK3XMi/9ytRjRYEjJfBa++TYeQCi+LHhtSjp2Dl7pfTysmQP11Nx6jsr/H5hHw+pKlF3zhSt8udcNzhLnmRpVY9YWa3bt7qt+bY7fU/ocy4/xbSmpB/SrXQ1QHh2QQ5T2NahgqzjR3Yjvy8ng0nPE+0t85OmLWp3k0MczFG7XI/O02sFE1ZozXBZdcZ5z4FCmkzhRj2BeWPkECt7W0kFduHVshHvZStgISHtXI2aKHnE6lcBk3Ttt9WPd5BUBVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybb6ak0lL/TnI7k8HEVFxKgIOsXWvEhizwQp4rOuq68=;
 b=l/i1JCP6w1j7FeBps3m9aI0tervL9RqmS63t2itUNkOr79WoFLifYAiaV09TRKTtAsc7dwCV9BvCF+YRrwr946yelR0uB6dDbAcdr6e14UhhI4/57/fVG7JXCSn3JPh7xmjrXJxZ1CMzC4bE4xKulWEphFujs2D/ec5/Djs/GkH0JWtAHhz5y++Tzmjm08e4c+5nayc9d11tUVxm8QF9rWveH8irHeajvFOvbuiaRzoD7EBhuAUlgl+DR/hk5rXsiHGwbsmmB/MWdfCK2ReuIszkAcwlFi4BwkZ40dxgm5elQI+e29QmcIb2dZJBLh3JtOlLBq6LLlUngnXg+faSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybb6ak0lL/TnI7k8HEVFxKgIOsXWvEhizwQp4rOuq68=;
 b=hr+cdaiUtHayKeZXCHvaBQK4LPHFiP0rtUwYNryQaJdfdtCZRMheqcL2cQnc2OT/8/L7CGP20siuMkSxGc+jOrZPoecC8ZshhwVBwUh28tzx8L1A4aWCyf07ZDH/PtNmZC4cnNxn6Es48jbs5ngh6s0imAj3CSTl2kJ+ZPq+WtE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3119.namprd12.prod.outlook.com (20.178.242.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 26 Nov 2019 15:02:29 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::b927:9d83:f11:941b]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::b927:9d83:f11:941b%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 15:02:28 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     Shyam-sundar.S-k@amd.com, linjiasen@hygon.cn, arindam.nath@amd.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] NTB: Fix access to link status and control register
Date:   Tue, 26 Nov 2019 09:01:16 -0600
Message-Id: <1574780476-4423-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::19) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7bcbdb1-6fca-47fc-68d5-08d77281a7c7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3119:|MN2PR12MB3119:|MN2PR12MB3119:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3119E3C933D8979776347BAAE5450@MN2PR12MB3119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(186003)(5660300002)(66556008)(26005)(66476007)(48376002)(66946007)(50466002)(14454004)(386003)(6506007)(51416003)(52116002)(478600001)(6666004)(99286004)(305945005)(7736002)(16586007)(316002)(2616005)(81156014)(86362001)(66066001)(8936002)(50226002)(6512007)(47776003)(6116002)(4326008)(3846002)(6486002)(2906002)(36756003)(6436002)(25786009)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3119;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fz8jzWTL8IlYLnTDQP51i0t+0LMkGpKAvY/ZbNHS8Gn3S311jDFjqSqTRqHLSVn6cVscsfSOdtnEUPtG4vF69gTIFlUcqbJgbtr4m4nPsDzi0up8+m0Ig8/VYE4YNjxmWKqgIzXSBSaNjYu7ZZxFWoiMlbD4WhTrceOTK/BVml0BvCh+V+21xH/HsD0AyWV9GLlBazBnCFHQvj0g6ICMPfmYlGBxpgiu8QIaWZcosu4SrCd02yeaoAaA1UbzXl40qhRHlZCQy0eiuSwhoBYRMtVEmP/eD+WQkmYaQjL1xaGerz6gYWW+NdfPCEjBagJroUGeQdhODPTrzJSO2NaQhK+mY6OLMUgHDlwd0hEiHOYhaIsxnaszCIfc7gzT26TsZfTr2icCdbT73ninbmgSuIp2QKixSf4EC15Is+zCFQFivsUWIFAIYIqffHvvXmIc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bcbdb1-6fca-47fc-68d5-08d77281a7c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 15:02:28.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kBnLU213OxhIstOlDyV/nB0gjmnS9SYpOPgdLs1v0fmVnkzswXMfaejGXeWTd3SDnboE4fJmE43e+HYuWHeKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

The design of AMD NTB implementation is such that
the NTB secondary endpoint is behind a combination
of Upstream Switch (SWUS) and a Downstream Switch
(SWDS). The link training happens on the SWUS and
not on the secondary endpoint. So to correctly
return the link status on the NTB secondary, we
need to read the link status of the SWUS.

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 45 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index ae91105..758f748 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -842,6 +842,9 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 static int amd_poll_link(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->peer_mmio;
+	struct pci_dev *pdev = NULL;
+	struct pci_dev *pci_swds = NULL;
+	struct pci_dev *pci_swus = NULL;
 	u32 reg, stat;
 	int rc;
 
@@ -855,10 +858,44 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
 	ndev->cntl_sta = reg;
 
-	rc = pcie_capability_read_dword(ndev->ntb.pdev,
-				   PCI_EXP_LNKCTL, &stat);
-	if (rc)
-		return 0;
+	if (ndev->ntb.topo == NTB_TOPO_SEC) {
+		/*
+		 * Locate the pointer to Downstream Switch for
+		 * this device
+		 */
+		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
+		if (pci_swds) {
+			/*
+			 * Locate the pointer to Upstream Switch for
+			 * this device
+			 */
+			pci_swus = pci_upstream_bridge(pci_swds);
+			if (pci_swus) {
+				/*
+				 * Read the PCIe Link Control and
+				 * Status register
+				 */
+				rc = pcie_capability_read_dword(pci_swus,
+						PCI_EXP_LNKCTL, &stat);
+				if (rc)
+					return 0;
+			} else {
+				return 0;
+			}
+		} else {
+			return 0;
+		}
+	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {
+		/*
+		 * For NTB primary, we simply read the Link Status and control
+		 * register of the NTB device itself.
+		 */
+		pdev = ndev->ntb.pdev;
+		rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
+		if (rc)
+			return 0;
+	}
+
 	ndev->lnk_sta = stat;
 
 	return 1;
-- 
2.7.4


Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA958C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7165C2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q9NAWP2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfKSOKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:10:01 -0500
Received: from mail-eopbgr800081.outbound.protection.outlook.com ([40.107.80.81]:34688
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfKSOKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:10:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1ppSMStwJV2eNW+Bfht9fwuOF6+ECCGG70A+wRhD7gAGdPjIeMxBCHqQ+KVh/vF0Hj7KgAEXJ0NH12aIRTAeyXCMPYuTGuWd+N4kwowlGK4eRlpejr6Xe07KKKxvoW7s40q4Ry9t96Qo6VffjKMWWFCSjHz1/zdaoLS7lY64IizjWjR+8vW4Badhya9XJdXcLQ0xyQcT16dtlVeszMP/cErIId375/mS2Y9DD+hIh44XlmpF/+NPVqosjCg6O/sE1+FwZ3hIjc5hTwNsCZa2r/LNV6riARDTo7Vi0+EXcHET4l6Pz+sFrU1fvShg8K6pdfJigYNSqnyTyEuneBlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHtyt9MZvqldLJO2OBG9Yfg1Jmv8fU9HitUJQS5/qMs=;
 b=TQn2xhmUtmqXAqzwe9lJutAUV5LV8kOlMtxfUIcBZbbMcNe3pSnAzAlK+Ykm7wG6Somrxb7xb5d6OeOUXK880Ym4MaqNI9qQLS3IlUHRP+Ze5SdnC7DaZFsy5y/PoL2Cg0pUvpjPOM21Kk4ULWQuSq/pYVaZ6BcOLkKuziK3j28wUguGyoajk1jbTC+UpUek5HP9eshea/2kQAymCESHDhSTQcvnJ9TcGNHX/EH9rfswCpzELASw06jt/Sd+c3oYCOmpsyPg5EV3coSzRow7WC7DlZOZJuV6G9oAoZdxWKEqNZn1GPZlIblb66TdDNiOkWRZwc/Nxl6PPVqkaPUoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHtyt9MZvqldLJO2OBG9Yfg1Jmv8fU9HitUJQS5/qMs=;
 b=q9NAWP2dT8lPX4kLB2t5NJ0XPqfL7CYcaWMtd1oRajYjd8WpXw5B6w+KNiaxEbfYXifkURZiuURbZ0GCYs3gUCP5/DzWy7SQ0OuEjQJnBK+k56uEpadyFDJJW0LB3zeYV+/VxPCEMvj5EQ8VdvUp7UKtXcCvL2QhziHVXzMAPPg=
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by MN2PR12MB3215.namprd12.prod.outlook.com (2603:10b6:208:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Tue, 19 Nov
 2019 14:09:57 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Tue, 19 Nov 2019 14:09:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 14:09:57 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 08:09:42 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 08:09:39 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <Akshu.Agrawal@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/6] ASoC: amd:Create multiple I2S platform device endpoint
Date:   Tue, 19 Nov 2019 19:38:23 +0530
Message-ID: <1574172508-26546-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574172508-26546-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574172508-26546-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(428003)(189003)(199004)(186003)(76176011)(51416003)(4326008)(2906002)(109986005)(305945005)(86362001)(6666004)(356004)(70586007)(70206006)(478600001)(47776003)(5660300002)(26005)(1671002)(50226002)(48376002)(8676002)(126002)(50466002)(36756003)(81156014)(426003)(81166006)(8936002)(336012)(316002)(486006)(16586007)(446003)(2616005)(7696005)(11346002)(54906003)(53416004)(476003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3215;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58eddb09-e6e6-4991-89f3-08d76cfa2864
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB321505B1258DC37A1A92DF5DE74C0@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:182;
X-Forefront-PRVS: 022649CC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFpTp9s9Fat+RcD6Kgzt/55FJmvYOqh1nx4jp5mTyOt+eSwMBBdF6F0ib1JfWsbJ9nCW3JpMWx9+DywMgLaOPzfn+9pqKf6lxIVoRgL3G6P1qOTqYl5X8QCRDE9xWK1LtveKVxiGlKJII7F6Y7UGmTAo6ADkOpbdKuRGzgsRUJ+tTx6qhtKKnPOtCE8YdKzDXpUnk2sVZS6+HgveY1+VQaEbvH+fI28Ap5zbs/MllUMiVhtpQ3lWS8W8MJnRPWHAfhCQwC1aAg/pB6qLTIeAnOqGmFmzJyBEYEnMxsjxT9FILm59UG/R/QnBeCk//aFM9v5+rhBW4Q4XX7YawhTnCkoTtW3elxlUKXQCVHiJz/vPkLKsMSiKl/jgXP2Qa5Y5NbSvzKVQ3SSoubfK1u+7kUXU5+WlFskzofFlVgMaRw3ldZhE+211ED/ZWEFDY9Rk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 14:09:57.0677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eddb09-e6e6-4991-89f3-08d76cfa2864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates Platform Device endpoints for multiple
I2S instances: SP and  BT endpoints device.
Pass PCI resources like MMIO, irq to the platform devices.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x.h     |  5 +++
 sound/soc/amd/raven/pci-acp3x.c | 95 +++++++++++++++++++++++++++--------------
 2 files changed, 68 insertions(+), 32 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 4f2cadd..2f15fe1 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -7,10 +7,15 @@
 
 #include "chip_offset_byte.h"
 
+#define ACP3x_DEVS		3
 #define ACP3x_PHY_BASE_ADDRESS 0x1240000
 #define	ACP3x_I2S_MODE	0
 #define	ACP3x_REG_START	0x1240000
 #define	ACP3x_REG_END	0x1250200
+#define ACP3x_I2STDM_REG_START	0x1242400
+#define ACP3x_I2STDM_REG_END	0x1242410
+#define ACP3x_BT_TDM_REG_START	0x1242800
+#define ACP3x_BT_TDM_REG_END	0x1242810
 #define I2S_MODE	0x04
 #define	BT_TX_THRESHOLD 26
 #define	BT_RX_THRESHOLD 25
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index facec24..94f5f21 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -16,17 +16,17 @@ struct acp3x_dev_data {
 	void __iomem *acp3x_base;
 	bool acp3x_audio_mode;
 	struct resource *res;
-	struct platform_device *pdev;
+	struct platform_device *pdev[ACP3x_DEVS];
 };
 
 static int snd_acp3x_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
-	int ret;
-	u32 addr, val;
 	struct acp3x_dev_data *adata;
-	struct platform_device_info pdevinfo;
+	struct platform_device_info pdevinfo[ACP3x_DEVS];
 	unsigned int irqflags;
+	int ret, i;
+	u32 addr, val;
 
 	if (pci_enable_device(pci)) {
 		dev_err(&pci->dev, "pci_enable_device failed\n");
@@ -56,10 +56,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		irqflags = 0;
 
 	addr = pci_resource_start(pci, 0);
-	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
+	adata->acp3x_base = devm_ioremap(&pci->dev, addr,
+					pci_resource_len(pci, 0));
 	if (!adata->acp3x_base) {
 		ret = -ENOMEM;
-		goto release_regions;
+		goto disable_msi;
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
@@ -68,11 +69,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	switch (val) {
 	case I2S_MODE:
 		adata->res = devm_kzalloc(&pci->dev,
-					  sizeof(struct resource) * 2,
+					  sizeof(struct resource) * 4,
 					  GFP_KERNEL);
 		if (!adata->res) {
 			ret = -ENOMEM;
-			goto unmap_mmio;
+			goto disable_msi;
 		}
 
 		adata->res[0].name = "acp3x_i2s_iomem";
@@ -80,40 +81,67 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		adata->res[0].start = addr;
 		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
 
-		adata->res[1].name = "acp3x_i2s_irq";
-		adata->res[1].flags = IORESOURCE_IRQ;
-		adata->res[1].start = pci->irq;
-		adata->res[1].end = pci->irq;
+		adata->res[1].name = "acp3x_i2s_sp";
+		adata->res[1].flags = IORESOURCE_MEM;
+		adata->res[1].start = addr + ACP3x_I2STDM_REG_START;
+		adata->res[1].end = addr + ACP3x_I2STDM_REG_END;
+
+		adata->res[2].name = "acp3x_i2s_bt";
+		adata->res[2].flags = IORESOURCE_MEM;
+		adata->res[2].start = addr + ACP3x_BT_TDM_REG_START;
+		adata->res[2].end = addr + ACP3x_BT_TDM_REG_END;
+
+		adata->res[3].name = "acp3x_i2s_irq";
+		adata->res[3].flags = IORESOURCE_IRQ;
+		adata->res[3].start = pci->irq;
+		adata->res[3].end = adata->res[3].start;
 
 		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
 
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
-		pdevinfo.name = "acp3x_rv_i2s";
-		pdevinfo.id = 0;
-		pdevinfo.parent = &pci->dev;
-		pdevinfo.num_res = 2;
-		pdevinfo.res = adata->res;
-		pdevinfo.data = &irqflags;
-		pdevinfo.size_data = sizeof(irqflags);
-
-		adata->pdev = platform_device_register_full(&pdevinfo);
-		if (IS_ERR(adata->pdev)) {
-			dev_err(&pci->dev, "cannot register %s device\n",
-				pdevinfo.name);
-			ret = PTR_ERR(adata->pdev);
-			goto unmap_mmio;
+		pdevinfo[0].name = "acp3x_rv_i2s_dma";
+		pdevinfo[0].id = 0;
+		pdevinfo[0].parent = &pci->dev;
+		pdevinfo[0].num_res = 4;
+		pdevinfo[0].res = &adata->res[0];
+		pdevinfo[0].data = &irqflags;
+		pdevinfo[0].size_data = sizeof(irqflags);
+
+		pdevinfo[1].name = "acp3x_i2s_playcap";
+		pdevinfo[1].id = 0;
+		pdevinfo[1].parent = &pci->dev;
+		pdevinfo[1].num_res = 1;
+		pdevinfo[1].res = &adata->res[1];
+
+		pdevinfo[2].name = "acp3x_i2s_playcap";
+		pdevinfo[2].id = 1;
+		pdevinfo[2].parent = &pci->dev;
+		pdevinfo[2].num_res = 1;
+		pdevinfo[2].res = &adata->res[2];
+		for (i = 0; i < ACP3x_DEVS ; i++) {
+			adata->pdev[i] =
+				platform_device_register_full(&pdevinfo[i]);
+			if (IS_ERR(adata->pdev[i])) {
+				dev_err(&pci->dev, "cannot register %s device\n",
+					pdevinfo[i].name);
+				ret = PTR_ERR(adata->pdev[i]);
+				goto unregister_devs;
+			}
 		}
 		break;
 	default:
 		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
 		ret = -ENODEV;
-		goto unmap_mmio;
+		goto disable_msi;
 	}
 	return 0;
 
-unmap_mmio:
+unregister_devs:
+	if (val == I2S_MODE)
+		for (i = 0 ; i < ACP3x_DEVS ; i++)
+			platform_device_unregister(adata->pdev[i]);
+disable_msi:
 	pci_disable_msi(pci);
-	iounmap(adata->acp3x_base);
 release_regions:
 	pci_release_regions(pci);
 disable_pci:
@@ -125,10 +153,12 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 static void snd_acp3x_remove(struct pci_dev *pci)
 {
 	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
+	int i;
 
-	platform_device_unregister(adata->pdev);
-	iounmap(adata->acp3x_base);
-
+	if (adata->acp3x_audio_mode == ACP3x_I2S_MODE) {
+		for (i = 0 ; i <  ACP3x_DEVS ; i++)
+			platform_device_unregister(adata->pdev[i]);
+	}
 	pci_disable_msi(pci);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
@@ -151,6 +181,7 @@ static struct pci_driver acp3x_driver  = {
 
 module_pci_driver(acp3x_driver);
 
+MODULE_AUTHOR("Vishnuvardhanrao.Ravulapati@amd.com");
 MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
 MODULE_DESCRIPTION("AMD ACP3x PCI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4


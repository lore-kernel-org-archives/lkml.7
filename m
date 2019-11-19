Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA71C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91C322302
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jIt+zi6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfKSJeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:34:12 -0500
Received: from mail-eopbgr690084.outbound.protection.outlook.com ([40.107.69.84]:24446
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfKSJeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:34:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsBCS9DSVV6tlF7Vi1KZBS8wvriUC8qlGUN3T7+zbH2ctRUMj6W2rEEwIE2JHOpVORuuVy5MspZ9EaPizftGI0fYMoh/dH0V3rJK88Zmy6FRBT5n5VZoEm1vQ6RBMSDS8ZTakVBj1cZzN3IkJ0LCLknu52Gusqx/RwBea6Jhvhq7fbSpKEbGwj3GIfAl5F4HY4cQjB16tarM+t9avWXXlGbd5IiyrJFvQVN96SJz4H2mPXDYgu/MdFSRLN0ejdUYS7qG0J3kRtwidoYJZVgXARHpwId1GN4NaiJvlwqfQ8fNf5cCEHJj1FzFOB4wXPsYr89HDkhw22tItliNE2qmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgojnpA9IFKWOtV2KydtCWmKhWX5z9dvrfmrRKWWgXk=;
 b=huk4Igx8hR2P8Pdp0LsejlOzlhYHPgSqIgTXZPJzd003+QSt43flLeXZ5WvM49xFZhISKVpF75FkXbdCig40GJZa/SnjRKfCcj1vOR4ES0+bXDiEu7ZmjKXw5Hpu0cvE3yGkbknjwqJcg1TT+XiaNPpHP3ofjcc3VpaOpX6cHFwWrvYmvjSBHgMFls2BvORa3iE/QBWrQ2SE64vzF9UAda4iKCRTDe7G+z0Cvs3Wzfx0mRMeFyIxZ+9i1pS50LoVxLv2mFJ+nveinakBTShi3OrgGsjaCW8hB1ueBA7k5WLjzWfqtBX4+HCYdls6cB3sbCqc6cdZJQxjgdcxtpL6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgojnpA9IFKWOtV2KydtCWmKhWX5z9dvrfmrRKWWgXk=;
 b=jIt+zi6Xj/50spE8QXt19uwUqpsUtTnGE4++FDPu6OFFETHTShXrSPTDrNJ5htDRnIRxy4ZvSRngFq6fIob/UVuIeYU5S70+ljQt3I5tcUVFIeqQZIeG22QbTV50cfP69aHoAXEHXyNRQd5ysfwZmLwmjU53JO6M/fSMttb1o3I=
Received: from DM6PR12CA0022.namprd12.prod.outlook.com (2603:10b6:5:1c0::35)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Tue, 19 Nov
 2019 09:34:07 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by DM6PR12CA0022.outlook.office365.com
 (2603:10b6:5:1c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.24 via Frontend
 Transport; Tue, 19 Nov 2019 09:34:07 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 09:34:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 03:34:06 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 03:34:05 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 03:34:02 -0600
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
Subject: [PATCH v8 1/6] ASoC: amd:Create multiple I2S platform device endpoint
Date:   Tue, 19 Nov 2019 15:02:42 +0530
Message-ID: <1574155967-1315-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574155967-1315-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574155967-1315-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(189003)(199004)(2616005)(8936002)(109986005)(70206006)(86362001)(70586007)(53416004)(305945005)(16586007)(36756003)(316002)(1671002)(4326008)(54906003)(48376002)(50466002)(478600001)(5660300002)(6666004)(336012)(446003)(50226002)(76176011)(26005)(486006)(476003)(81156014)(126002)(8676002)(81166006)(2906002)(186003)(47776003)(426003)(356004)(7696005)(11346002)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR12MB4259;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c200e92-e8c6-4c81-79af-08d76cd3a010
X-MS-TrafficTypeDiagnostic: BY5PR12MB4259:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4259201658ACF014CE626D92E74C0@BY5PR12MB4259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:182;
X-Forefront-PRVS: 022649CC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bb8SGPuSx1NP4/aaHSwFgzvMVxk9btyiEavIMAKVeoTju0jnQtinVwm4T2lr9bP2BcPfNICA6gWMtZkGRy28HJDaQ839XisiBAonnoRAbCuAGaeW7AAu7pkDb+REkG1CHTlrFP22bU5LviPqIphzZAdB0b7PRemp5zCYGGYA04rBID9mmBXfYNT9fhkMZqBvqZStL7JSjtAO6+N0KdodHa8+FZ828XhQpQ+1kGA7SRxMJyjS8ZqTfUnKlCGIAL0DwtMwV34ztYMsxk5FjpXJQZsGO4AVybZ3689EYNxb5cNoy8yEtPbchYnC4L56cxGN0zI/UeVXT1USNrGJLidQk1pBjkg/cfrWv3OKqQ1GFDUvHrMGcGqGFhXJFvXGZdb253Xu0K4YirBIbbTkDULYM4+xhAdULtt3ZxRH5SQFy7iC5BcWx8Kh0dsLODZlvkmW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 09:34:07.1795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c200e92-e8c6-4c81-79af-08d76cd3a010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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
index facec24..be2670f 100644
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
+	int ret, val, i;
+	u32 addr;
 
 	if (pci_enable_device(pci)) {
 		dev_err(&pci->dev, "pci_enable_device failed\n");
@@ -43,7 +43,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 			     GFP_KERNEL);
 	if (!adata) {
 		ret = -ENOMEM;
-		goto release_regions;
+		goto adata_free;
 	}
 
 	/* check for msi interrupt support */
@@ -56,7 +56,8 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		irqflags = 0;
 
 	addr = pci_resource_start(pci, 0);
-	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
+	adata->acp3x_base = devm_ioremap(&pci->dev, addr,
+					pci_resource_len(pci, 0));
 	if (!adata->acp3x_base) {
 		ret = -ENOMEM;
 		goto release_regions;
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
+			goto release_regions;
 		}
 
 		adata->res[0].name = "acp3x_i2s_iomem";
@@ -80,41 +81,68 @@ static int snd_acp3x_probe(struct pci_dev *pci,
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
+				goto unmap_mmio;
+			}
 		}
 		break;
 	default:
 		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
 		ret = -ENODEV;
-		goto unmap_mmio;
+		goto release_regions;
 	}
 	return 0;
 
 unmap_mmio:
-	pci_disable_msi(pci);
-	iounmap(adata->acp3x_base);
+	if (val == I2S_MODE)
+		for (i = 0 ; i < ACP3x_DEVS ; i++)
+			platform_device_unregister(adata->pdev[i]);
 release_regions:
+	pci_disable_msi(pci);
+adata_free:
 	pci_release_regions(pci);
 disable_pci:
 	pci_disable_device(pci);
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


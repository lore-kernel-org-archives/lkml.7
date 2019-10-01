Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D092C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AF120842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nD3bD/6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfI3OHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:07:39 -0400
Received: from mail-eopbgr790048.outbound.protection.outlook.com ([40.107.79.48]:41768
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfI3OHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUkTtppUSMqGLiJlk4rgXhApqTPZ0QUpW6GN4UUuGPBU33l7IBAsZUEFOnL5RFWyfyueGsFmqw1tj/djVaF9XlUrqKziwqNdgIIEy2OzxKwoKPd+jEuChJBoK+JEvQupaxCNc76nnt/mwudA3X3ImiE1S0Nlqk/pWGNeHFacSbnd9GmB45ngovsUULw0hnZCAxHBXG5M9Nws7ID1sFAd/Ngp8dKIM0vQvw2CjBAp2fLxjuxoNJgdIC4PL8H4NROYATOFkDVGBCbzlfZj4P2Y4xgcuducEXmWu2N5T7/BoTkfZ9O0kjfnQFS3a7B8SrnDmENtUZujqbRXlT5fFlG+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zj4J1monzztHvLn/9/E6Oprs41hNIAObi+6+n23KcE=;
 b=HGgaH+gI7Ac0gxPWMseEWw95PiS5E/fAkEK78Ua8lH0cRItbEZeQyjbstgExEz0Eoo6Fsa2zzfQJkmsm6xcrFQmbpTYaV3ivR/5BZ6XNcn8XF1VQAzEH4f7PZcoVV+cG6AdCajBC9Hpei1ynVqjc/S936D+I/1BR5U1iKh2Gm9uT2vPeULqFel+I/eDKydCCIBUIv7cX+J/q5xvHraawlXAtU7peYV/Ed2ueGFpczUPU3D0/Tw03Q4QwvIkF1lB0AF1h4ybYkvedo3bgfWNUVEOQhF0yzi6sj0/UbD3siIyqTQIBcS/q3K3fQt00PueDPL/sMuBXxyI7iX3v/5c9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zj4J1monzztHvLn/9/E6Oprs41hNIAObi+6+n23KcE=;
 b=nD3bD/6qE1lz/DMhzWlZM45dTm8viCmsSkzszV8dlS8AlP0tTrugFIenbyPi4GfyEes7Ub62rUteOb4ctg8RnsBOVabV/U+Noz7gYQM6zfU/gKXX71+7WVVqXlFNt6yzDRX8mAedJQ5jiIwTaJAQjy3tf4+rQV9kb4QoKuT/sWI=
Received: from DM6PR12CA0007.namprd12.prod.outlook.com (2603:10b6:5:1c0::20)
 by BYAPR12MB2821.namprd12.prod.outlook.com (2603:10b6:a03:96::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.18; Mon, 30 Sep
 2019 14:05:56 +0000
Received: from CO1NAM03FT016.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::207) by DM6PR12CA0007.outlook.office365.com
 (2603:10b6:5:1c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19 via Frontend
 Transport; Mon, 30 Sep 2019 14:05:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT016.mail.protection.outlook.com (10.152.80.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 14:05:56 +0000
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXCHOV01.amd.com (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1;
 Mon, 30 Sep 2019 09:05:54 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Maruthi Srinivas Bayyavarapu" <Maruthi.Bayyavarapu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD framework
Date:   Tue, 1 Oct 2019 06:28:10 +0530
Message-ID: <1569891524-18875-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(428003)(199004)(189003)(86362001)(47776003)(486006)(426003)(76176011)(356004)(50466002)(4326008)(50226002)(51416003)(7696005)(305945005)(6666004)(48376002)(1671002)(109986005)(5660300002)(16586007)(316002)(26005)(336012)(186003)(54906003)(53416004)(36756003)(2906002)(81156014)(81166006)(446003)(70206006)(478600001)(70586007)(2616005)(8676002)(11346002)(476003)(8936002)(126002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2821;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a143658-4d27-4978-c545-08d745af5031
X-MS-TrafficTypeDiagnostic: BYAPR12MB2821:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28214DC5DB891FA8E4A480E9E7820@BYAPR12MB2821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-Forefront-PRVS: 01762B0D64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oV239+70idZI47zaBxmD/5R3NenEXPmC0CKkWtczdE6aJr9MvjQRrqbQvlfKOi6nnXZq+anWXjji4DW/fEwXutxMw/K7HSFy3YxZluHvUdq2g/4PVWSkT6KTjhHWvou/FX0BwsB2EOyNzDeTWEHMk8RmSEIcZnRJ2MmNlFDhE86Do6EQKGjivZy+ymz0/QE1cc+e9gi2ACi13x37vTVXsNUNyVLNHwWfKUn9nzKue6TmKUOJOWFkMa5g3emTt5RtafOWUGQgMQ76u63W/cNUna3qiVRCwONs0wU6dQ9UadSbYJvQ9LCWTzckMcBMBwhypCGJ5URPCyAYVATywZUZd1nz7KPCqvm8GT2m9bDWNkj9v8udeBC7w0d42+KPTfy9IxHFvTsZ98oWZu9b+v0nfR6yB1s4pffR1tSUqQYNUfM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 14:05:56.1375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a143658-4d27-4978-c545-08d745af5031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed platform based endpoint registering in ACP-PCI driver.
Now Registering PCM DMA and multiple I2S instances: SP and  BT endpoint
devices automatically by using MFD framework.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x.h     |   8 +++
 sound/soc/amd/raven/pci-acp3x.c | 123 ++++++++++++++++++++++++++--------------
 2 files changed, 90 insertions(+), 41 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 4f2cadd..c122dc6 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -7,13 +7,21 @@
 
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
+#define	I2S_RX_THRESHOLD	27
+#define	I2S_TX_THRESHOLD	28
 #define	BT_TX_THRESHOLD 26
 #define	BT_RX_THRESHOLD 25
+#define ACP_ERR_INTR_MASK	29
 #define ACP3x_POWER_ON 0x00
 #define ACP3x_POWER_ON_IN_PROGRESS 0x01
 #define ACP3x_POWER_OFF 0x02
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 8f6bf00..d9f5bc0 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -9,13 +9,21 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/core.h>
 
 #include "acp3x.h"
 
+struct i2s_platform_data {
+	unsigned int cap;
+	int channel;
+	u32 snd_rates;
+};
 struct acp3x_dev_data {
+	struct device *parent;
+	struct mfd_cell *cell;
+	struct resource *res;
 	void __iomem *acp3x_base;
 	bool acp3x_audio_mode;
-	struct resource *res;
 	struct platform_device *pdev;
 };
 
@@ -23,9 +31,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	int ret;
-	u32 addr, val;
+	resource_size_t addr;
+	int val, i, r;
 	struct acp3x_dev_data *adata;
-	struct platform_device_info pdevinfo;
+	struct device *dev;
+	struct i2s_platform_data *i2s_pdata;
 	unsigned int irqflags;
 
 	if (pci_enable_device(pci)) {
@@ -56,55 +66,87 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
-
+	adata->parent = &pci->dev;
 	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
 	switch (val) {
 	case I2S_MODE:
 		adata->res = devm_kzalloc(&pci->dev,
-					  sizeof(struct resource) * 2,
-					  GFP_KERNEL);
-		if (!adata->res) {
+				sizeof(struct resource) * 4,
+						GFP_KERNEL);
+		adata->cell = devm_kzalloc(&pci->dev,
+				sizeof(struct mfd_cell) * ACP3x_DEVS,
+						GFP_KERNEL);
+		if (!adata->cell) {
 			ret = -ENOMEM;
 			goto unmap_mmio;
 		}
 
-		adata->res[0].name = "acp3x_i2s_iomem";
-		adata->res[0].flags = IORESOURCE_MEM;
-		adata->res[0].start = addr;
-		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
-
-		adata->res[1].name = "acp3x_i2s_irq";
-		adata->res[1].flags = IORESOURCE_IRQ;
-		adata->res[1].start = pci->irq;
-		adata->res[1].end = pci->irq;
-
-		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
-
-		memset(&pdevinfo, 0, sizeof(pdevinfo));
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
+		i2s_pdata = devm_kzalloc(&pci->dev,
+				sizeof(struct i2s_platform_data) * ACP3x_DEVS,
+						GFP_KERNEL);
+		if (i2s_pdata == NULL) {
+			kfree(adata->res);
+			kfree(adata->cell);
+			return -ENOMEM;
 		}
+		adata->res[0].name	= "acp3x_i2s_iomem";
+		adata->res[0].flags	= IORESOURCE_MEM;
+		adata->res[0].start	= addr;
+		adata->res[0].end	= addr +
+			(ACP3x_REG_END - ACP3x_REG_START);
+		i2s_pdata[0].cap	= 0;
+		i2s_pdata[0].snd_rates	= SNDRV_PCM_RATE_8000_96000;
+
+		adata->res[1].name	= "acp3x_i2s_sp_play_cap";
+		adata->res[1].flags	= IORESOURCE_MEM;
+		adata->res[1].start	= addr + ACP3x_I2STDM_REG_START;
+		adata->res[1].end	= addr + ACP3x_I2STDM_REG_END;
+		i2s_pdata[1].cap	= 0;
+		i2s_pdata[1].snd_rates	= SNDRV_PCM_RATE_8000_96000;
+
+		adata->res[2].name	= "acp3x_i2s_bt_play_cap";
+		adata->res[2].flags	= IORESOURCE_MEM;
+		adata->res[2].start	= addr + ACP3x_BT_TDM_REG_START;
+		adata->res[2].end	= addr + ACP3x_BT_TDM_REG_END;
+		i2s_pdata[2].cap	= 0;
+		i2s_pdata[2].snd_rates	= SNDRV_PCM_RATE_8000_96000;
+
+		adata->res[3].name	= "acp3x_i2s_irq";
+		adata->res[3].flags	= IORESOURCE_IRQ;
+		adata->res[3].start	= pci->irq;
+		adata->res[3].end	= adata->res[3].start;
+
+		adata->acp3x_audio_mode	= ACP3x_I2S_MODE;
+
+		adata->cell[0].name	=	"acp3x_rv_i2s_dma";
+		adata->cell[0].num_resources	= 4;
+		adata->cell[0].resources	= &adata->res[0];
+		adata->cell[0].platform_data	= &irqflags;
+		adata->cell[0].pdata_size	= sizeof(irqflags);
+
+		adata->cell[1].name		= "acp3x_i2s_playcap";
+		adata->cell[1].num_resources	= 1;
+		adata->cell[1].resources	= &adata->res[1];
+		adata->cell[1].platform_data	= &i2s_pdata[0];
+		adata->cell[1].pdata_size	=
+				sizeof(struct i2s_platform_data);
+
+		adata->cell[2].name		= "acp3x_i2s_playcap";
+		adata->cell[2].num_resources	= 1;
+		adata->cell[2].resources	= &adata->res[2];
+		adata->cell[2].platform_data	= &i2s_pdata[1];
+		adata->cell[2].pdata_size	=
+				sizeof(struct i2s_platform_data);
+		r = mfd_add_hotplug_devices(adata->parent,
+					adata->cell, ACP3x_DEVS);
 		break;
-	default:
-		dev_err(&pci->dev, "Invalid ACP audio mode : %d\n", val);
-		ret = -ENODEV;
-		goto unmap_mmio;
 	}
 	return 0;
 
 unmap_mmio:
+	mfd_remove_devices(adata->parent);
+	kfree(adata->res);
+	kfree(adata->cell);
 	iounmap(adata->acp3x_base);
 release_regions:
 	pci_release_regions(pci);
@@ -117,10 +159,8 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 static void snd_acp3x_remove(struct pci_dev *pci)
 {
 	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
-
-	platform_device_unregister(adata->pdev);
+	mfd_remove_devices(adata->parent);
 	iounmap(adata->acp3x_base);
-
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
@@ -142,6 +182,7 @@ static struct pci_driver acp3x_driver  = {
 
 module_pci_driver(acp3x_driver);
 
+MODULE_AUTHOR("Vishnuvardhanrao.Ravulapati@amd.com");
 MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
 MODULE_DESCRIPTION("AMD ACP3x PCI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4


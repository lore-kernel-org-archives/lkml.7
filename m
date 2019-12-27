Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F62C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFC120882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VcTJsZ5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfL0Mxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:53:43 -0500
Received: from mail-eopbgr770042.outbound.protection.outlook.com ([40.107.77.42]:43399
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfL0Mxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:53:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+0TIIwwphvEZ9Ynu2R1Xfdshi7MkEEr3hrhsaGjfUefo2IPDosIxc5uGhf8Hbd+/H6mdH6O8FjpLpUHeKcAH3dnf6XAlHXLbMFBaYTIx77oW6p43lPOhA/GhrVf8Toqykwvpl5yNaoJYKgL+VXRn80XJZkpFUYwJ3LmbUKIo2fQdlWq9K7RoG8qkYzzEw2uLsIR/X7Ic8d77TkQGw6U72Ad2AcuM4w4OLHCpIb0hhGz4lDV5MVCboUnYGOIMPKDNb8sX7rGaqAXyW1Rcn1VXg7Lq7O60HJg4B9Z+NG74Xl+z5jpKRr47xSOjP4QEgJbvnjHfno9mVYVTzgADA/eRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1FlodFoeDC9LVCp2t/iJ0m8vM6G5Y/iNkYwKfMx6sg=;
 b=jrKp7OMDVxzbZj68URtDeiYBHOfPHOuSkBRlsYlimlDBwX77A9gdXb894YaP3VcHL6JpMHVLC2xdm+twydkzNCvEAJ0BnU44svdPnYLFRIq/RSwO9oIONiUyGwwS7iV9MtwMclh/Io5lSM837h99GZO1a7MqBIZwkGawJTNKG8J/xOcanNP4JVf8QMdpiuahTAMqtqJUvnWQaRHGkDdCQpnzLX67q1OiHVs+vfISKtj7tjFJbz/hN+sfzrs8MgJynYjzajCjwQ8nDVSslvSzyo56rpg0fmiwC8NbZWbHb14UkSffPZIoC7fuU+uQMgmSpSxB2GJ9XMRizaWHFafJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1FlodFoeDC9LVCp2t/iJ0m8vM6G5Y/iNkYwKfMx6sg=;
 b=VcTJsZ5yjBSzbg61B9H8axjaA8uRzLSCHegXfNJNXBpprVwePotI4rSJVrxRxoS8krYflr2Bf+OGH2oDzS+35N/hMtvNi2IiZWIRTkV/FCKhhFJgzMPmD1Zw6tiowlYQgVKlfC6v6QJnp1dHlaKNL102+409PXxqGMq5X7m6fZs=
Received: from BN6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:405:70::18)
 by MWHPR1201MB0109.namprd12.prod.outlook.com (2603:10b6:301:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Fri, 27 Dec
 2019 12:53:25 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by BN6PR12CA0032.outlook.office365.com
 (2603:10b6:405:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Fri, 27 Dec 2019 12:53:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2581.11 via Frontend Transport; Fri, 27 Dec 2019 12:53:24 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 27 Dec
 2019 06:53:22 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 27 Dec 2019 06:53:18 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] ASoC: amd: Added ACP3x system resume and runtime pm
Date:   Fri, 27 Dec 2019 18:20:54 +0530
Message-ID: <1577451055-9182-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577451055-9182-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1577451055-9182-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(23433003)(199004)(189003)(8676002)(81166006)(70586007)(2616005)(7416002)(8936002)(5660300002)(36756003)(426003)(70206006)(30864003)(54906003)(81156014)(86362001)(2906002)(356004)(186003)(336012)(6666004)(7696005)(4326008)(478600001)(26005)(316002)(109986005)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0109;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f73103b-6653-4436-b9a5-08d78acbc286
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:|MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0109E06C621DBC32C0C5ADD8E72A0@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:21;
X-Forefront-PRVS: 0264FEA5C3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BT5wwePbiNtgHoSvdSaqHfFboKgSKW5Ag9zJGPn9APJubWmMR5tZjhdJ6mbYJJ0MfWAWZAHLc0o0TcX0Fehh41ftPt4LGm6psCmSzEOrpiCxXPor5FRJ3vOTaHHlm7Is2tl6hmJpHu9Sq1Z+dPEMpcCZKLPdcl8bNKwc2wFbb5oijgO/0aDKWsKiKzyFuPiSIVaCrL3mCHnitV0XQyfakTlarNMEjxpv2XDeLE9aNDMtz4LRvU3pRwcTnCSUijs7wG/InypngBsD59J6O54Q5qLeXZons4hbbdbEwTgIawxFCChbyadGSXTrRC1dYpHbeX5GQ7gbTZsMr3RKpDyt62La+9shuRZOfj3NWyw0VZNLvnIPsy0UrVOmWaCL2AWOBVVO59Gr2Gr73fufwV5NG4JFxqZvAVdfsdPmNPBy3mSXrVqyzgkCE2Pbq/R0zwhABbLnTJPJER72jtyUU3j5kLqobdLS7QEAxv11Kpdb83D//1hiY4OMJn9Xk4CN5GZVBey3/0W/Vfi1CrljC3GD7ZBdZtOC17XL2VHhYIdqZUc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2019 12:53:24.1235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f73103b-6653-4436-b9a5-08d78acbc286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system wide suspend happens, ACP will be powered off
and when system resumes,for audio usecase to continue,all
the runtime configuration data needs to be programmed again.
Added resume pm call back to ACP pm ops and also added runtime
PM operations for ACP3x PCM platform device.
Device will enter into D3 state when there is no activity
on audio I2S lines

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 149 ++-----------------------------
 sound/soc/amd/raven/acp3x.h         |   7 ++
 sound/soc/amd/raven/pci-acp3x.c     | 173 ++++++++++++++++++++++++++++++++++--
 3 files changed, 180 insertions(+), 149 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 1bd4f76..7045a34 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -58,106 +58,6 @@ static const struct snd_pcm_hardware acp3x_pcm_hardware_capture = {
 	.periods_max = CAPTURE_MAX_NUM_PERIODS,
 };
 
-static int acp3x_power_on(void __iomem *acp3x_base, bool on)
-{
-	u16 val, mask;
-	u32 timeout;
-
-	if (on == true) {
-		val = 1;
-		mask = ACP3x_POWER_ON;
-	} else {
-		val = 0;
-		mask = ACP3x_POWER_OFF;
-	}
-
-	rv_writel(val, acp3x_base + mmACP_PGFSM_CONTROL);
-	timeout = 0;
-	while (true) {
-		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
-		if ((val & ACP3x_POWER_OFF_IN_PROGRESS) == mask)
-			break;
-		if (timeout > 100) {
-			pr_err("ACP3x power state change failure\n");
-			return -ENODEV;
-		}
-		timeout++;
-		cpu_relax();
-	}
-	return 0;
-}
-
-static int acp3x_reset(void __iomem *acp3x_base)
-{
-	u32 val, timeout;
-
-	rv_writel(1, acp3x_base + mmACP_SOFT_RESET);
-	timeout = 0;
-	while (true) {
-		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
-		if ((val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK) ||
-		     timeout > 100) {
-			if (val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK)
-				break;
-			return -ENODEV;
-		}
-		timeout++;
-		cpu_relax();
-	}
-
-	rv_writel(0, acp3x_base + mmACP_SOFT_RESET);
-	timeout = 0;
-	while (true) {
-		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
-		if (!val || timeout > 100) {
-			if (!val)
-				break;
-			return -ENODEV;
-		}
-		timeout++;
-		cpu_relax();
-	}
-	return 0;
-}
-
-static int acp3x_init(void __iomem *acp3x_base)
-{
-	int ret;
-
-	/* power on */
-	ret = acp3x_power_on(acp3x_base, true);
-	if (ret) {
-		pr_err("ACP3x power on failed\n");
-		return ret;
-	}
-	/* Reset */
-	ret = acp3x_reset(acp3x_base);
-	if (ret) {
-		pr_err("ACP3x reset failed\n");
-		return ret;
-	}
-	return 0;
-}
-
-static int acp3x_deinit(void __iomem *acp3x_base)
-{
-	int ret;
-
-	/* Reset */
-	ret = acp3x_reset(acp3x_base);
-	if (ret) {
-		pr_err("ACP3x reset failed\n");
-		return ret;
-	}
-	/* power off */
-	ret = acp3x_power_on(acp3x_base, false);
-	if (ret) {
-		pr_err("ACP3x power off failed\n");
-		return ret;
-	}
-	return 0;
-}
-
 static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 {
 	struct i2s_dev_data *rv_i2s_data;
@@ -480,7 +380,7 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct i2s_dev_data *adata;
 	unsigned int irqflags;
-	int status, ret;
+	int status;
 
 	if (!pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "platform_data not retrieved\n");
@@ -512,53 +412,29 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 	adata->i2s_irq = res->start;
 
 	dev_set_drvdata(&pdev->dev, adata);
-	/* Initialize ACP */
-	status = acp3x_init(adata->acp3x_base);
-	if (status)
-		return -ENODEV;
-
 	status = devm_snd_soc_register_component(&pdev->dev,
 						 &acp3x_i2s_component,
 						 NULL, 0);
 	if (status) {
 		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
-		ret = -ENODEV;
-		goto dev_err;
+		return -ENODEV;
 	}
 	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
 				  irqflags, "ACP3x_I2S_IRQ", adata);
 	if (status) {
 		dev_err(&pdev->dev, "ACP3x I2S IRQ request failed\n");
-		ret = -ENODEV;
-		goto dev_err;
+		return -ENODEV;
 	}
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
 	return 0;
-
-dev_err:
-	status = acp3x_deinit(adata->acp3x_base);
-	if (status)
-		dev_err(&pdev->dev, "ACP de-init failed\n");
-	else
-		dev_dbg(&pdev->dev, "ACP de-initialized\n");
-	return ret;
 }
 
 static int acp3x_audio_remove(struct platform_device *pdev)
 {
-	struct i2s_dev_data *adata;
-	int ret;
-
-	adata = dev_get_drvdata(&pdev->dev);
-	ret = acp3x_deinit(adata->acp3x_base);
-	if (ret)
-		dev_err(&pdev->dev, "ACP de-init failed\n");
-	else
-		dev_dbg(&pdev->dev, "ACP de-initialized\n");
-
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
@@ -566,15 +442,11 @@ static int acp3x_audio_remove(struct platform_device *pdev)
 static int acp3x_resume(struct device *dev)
 {
 	struct i2s_dev_data *adata;
-	int status;
 	u32 val, reg_val, frmt_val;
 
 	reg_val = 0;
 	frmt_val = 0;
 	adata = dev_get_drvdata(dev);
-	status = acp3x_init(adata->acp3x_base);
-	if (status)
-		return -ENODEV;
 
 	if (adata->play_stream && adata->play_stream->runtime) {
 		struct i2s_stream_instance *rtd =
@@ -621,14 +493,8 @@ static int acp3x_resume(struct device *dev)
 static int acp3x_pcm_runtime_suspend(struct device *dev)
 {
 	struct i2s_dev_data *adata;
-	int status;
 
 	adata = dev_get_drvdata(dev);
-	status = acp3x_deinit(adata->acp3x_base);
-	if (status)
-		dev_err(dev, "ACP de-init failed\n");
-	else
-		dev_dbg(dev, "ACP de-initialized\n");
 
 	rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
 
@@ -638,12 +504,9 @@ static int acp3x_pcm_runtime_suspend(struct device *dev)
 static int acp3x_pcm_runtime_resume(struct device *dev)
 {
 	struct i2s_dev_data *adata;
-	int status;
 
 	adata = dev_get_drvdata(dev);
-	status = acp3x_init(adata->acp3x_base);
-	if (status)
-		return -ENODEV;
+
 	rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 43213ae..b6a80dc 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -68,6 +68,13 @@
 #define SLOT_WIDTH_16 0x10
 #define SLOT_WIDTH_24 0x18
 #define SLOT_WIDTH_32 0x20
+#define ACP_PGFSM_CNTL_POWER_ON_MASK	0x01
+#define ACP_PGFSM_CNTL_POWER_OFF_MASK	0x00
+#define ACP_PGFSM_STATUS_MASK		0x03
+#define ACP_POWERED_ON			0x00
+#define ACP_POWER_ON_IN_PROGRESS	0x01
+#define ACP_POWERED_OFF			0x02
+#define ACP_POWER_OFF_IN_PROGRESS	0x03
 
 struct acp3x_platform_info {
 	u16 play_i2s_instance;
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 94f5f21..2f9f5290 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -9,6 +9,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
 
 #include "acp3x.h"
 
@@ -19,6 +21,109 @@ struct acp3x_dev_data {
 	struct platform_device *pdev[ACP3x_DEVS];
 };
 
+static int acp3x_power_on(void __iomem *acp3x_base)
+{
+	u32 val;
+	int timeout;
+
+	val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
+
+	if (val == 0)
+		return val;
+
+	if (!((val & ACP_PGFSM_STATUS_MASK) ==
+				ACP_POWER_ON_IN_PROGRESS))
+		rv_writel(ACP_PGFSM_CNTL_POWER_ON_MASK,
+			acp3x_base + mmACP_PGFSM_CONTROL);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
+		if (!val)
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp3x_power_off(void __iomem *acp3x_base)
+{
+	u32 val;
+	int timeout;
+
+	rv_writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
+			acp3x_base + mmACP_PGFSM_CONTROL);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
+		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp3x_reset(void __iomem *acp3x_base)
+{
+	u32 val;
+	int timeout;
+
+	rv_writel(1, acp3x_base + mmACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
+		if (val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK)
+			break;
+		cpu_relax();
+	}
+	rv_writel(0, acp3x_base + mmACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
+		if (!val)
+			return 0;
+		cpu_relax();
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp3x_init(void __iomem *acp3x_base)
+{
+	int ret;
+
+	/* power on */
+	ret = acp3x_power_on(acp3x_base);
+	if (ret) {
+		pr_err("ACP3x power on failed\n");
+		return ret;
+	}
+	/* Reset */
+	ret = acp3x_reset(acp3x_base);
+	if (ret) {
+		pr_err("ACP3x reset failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int acp3x_deinit(void __iomem *acp3x_base)
+{
+	int ret;
+
+	/* Reset */
+	ret = acp3x_reset(acp3x_base);
+	if (ret) {
+		pr_err("ACP3x reset failed\n");
+		return ret;
+	}
+	/* power off */
+	ret = acp3x_power_off(acp3x_base);
+	if (ret) {
+		pr_err("ACP3x power off failed\n");
+		return ret;
+	}
+	return 0;
+}
+
 static int snd_acp3x_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
@@ -64,6 +169,9 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
+	ret = acp3x_init(adata->acp3x_base);
+	if (ret)
+		goto disable_msi;
 
 	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
 	switch (val) {
@@ -73,7 +181,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 					  GFP_KERNEL);
 		if (!adata->res) {
 			ret = -ENOMEM;
-			goto disable_msi;
+			goto de_init;
 		}
 
 		adata->res[0].name = "acp3x_i2s_iomem";
@@ -118,7 +226,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		pdevinfo[2].parent = &pci->dev;
 		pdevinfo[2].num_res = 1;
 		pdevinfo[2].res = &adata->res[2];
-		for (i = 0; i < ACP3x_DEVS ; i++) {
+		for (i = 0; i < ACP3x_DEVS; i++) {
 			adata->pdev[i] =
 				platform_device_register_full(&pdevinfo[i]);
 			if (IS_ERR(adata->pdev[i])) {
@@ -134,12 +242,21 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		ret = -ENODEV;
 		goto disable_msi;
 	}
+	pm_runtime_set_autosuspend_delay(&pci->dev, 2000);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_set_active(&pci->dev);
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_enable(&pci->dev);
+	pm_runtime_allow(&pci->dev);
 	return 0;
 
 unregister_devs:
 	if (val == I2S_MODE)
-		for (i = 0 ; i < ACP3x_DEVS ; i++)
+		for (i = 0; i < ACP3x_DEVS; i++)
 			platform_device_unregister(adata->pdev[i]);
+de_init:
+	if (acp3x_deinit(adata->acp3x_base))
+		dev_err(&pci->dev, "ACP de-init failed\n");
 disable_msi:
 	pci_disable_msi(pci);
 release_regions:
@@ -150,15 +267,56 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	return ret;
 }
 
+static int snd_acp3x_suspend(struct device *dev)
+{
+	int ret;
+	struct acp3x_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	ret = acp3x_deinit(adata->acp3x_base);
+	if (ret)
+		dev_err(dev, "ACP de-init failed\n");
+	else
+		dev_dbg(dev, "ACP de-initialized\n");
+
+	return 0;
+}
+
+static int snd_acp3x_resume(struct device *dev)
+{
+	int ret;
+	struct acp3x_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	ret = acp3x_init(adata->acp3x_base);
+	if (ret) {
+		dev_err(dev, "ACP init failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops acp3x_pm = {
+	.runtime_suspend = snd_acp3x_suspend,
+	.runtime_resume =  snd_acp3x_resume,
+	.resume =	snd_acp3x_resume,
+};
+
 static void snd_acp3x_remove(struct pci_dev *pci)
 {
-	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
-	int i;
+	struct acp3x_dev_data *adata;
+	int i, ret;
 
+	adata = pci_get_drvdata(pci);
 	if (adata->acp3x_audio_mode == ACP3x_I2S_MODE) {
-		for (i = 0 ; i <  ACP3x_DEVS ; i++)
+		for (i = 0; i < ACP3x_DEVS; i++)
 			platform_device_unregister(adata->pdev[i]);
 	}
+	ret = acp3x_deinit(adata->acp3x_base);
+	if (ret)
+		dev_err(&pci->dev, "ACP de-init failed\n");
+	pm_runtime_disable(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
 	pci_disable_msi(pci);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
@@ -177,6 +335,9 @@ static struct pci_driver acp3x_driver  = {
 	.id_table = snd_acp3x_ids,
 	.probe = snd_acp3x_probe,
 	.remove = snd_acp3x_remove,
+	.driver = {
+		.pm = &acp3x_pm,
+	}
 };
 
 module_pci_driver(acp3x_driver);
-- 
2.7.4


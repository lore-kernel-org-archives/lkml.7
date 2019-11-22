Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3B8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745FA2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XJmSbDkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfKVJq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:46:29 -0500
Received: from mail-eopbgr680076.outbound.protection.outlook.com ([40.107.68.76]:7924
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727255AbfKVJqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:46:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCZqJLoy0VET67e+8MqP7wWHftYmAWZQvu9EmaQhRS1C5T2Q39tqUE8HR5KcX+tk4eAhhkTmg4MDfD8+G2Vo9BCz5+sBT3vduWHsPJS+dgeKhDsOtbL1SrzQySQYKqPS5p+j0uFjl4AvMrroczEckE9dqcBleeHnWqx40ju9NVCrXYbUSkc2bD4TZR8wZXJLpbIrDkQ4CIC0WkIm+RmcPblZMsNutDpl8ZkBulKhgUSyXW80tKArl7zFnCoSeomv0Qg1pd3SrC5cxXoGc291usO89/Xg6AH6eQLL2hXYq29CXdDuERPvY3okDW7ikDYgJWwXtSPxOKV9etkxEAauTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQlDUbuHpuF8Q6HyuDsvjG0HzPcAn12o5c+oxC7q8go=;
 b=eO9uk7DxZl3xOYzGgPguPJcrVNIXGEU1nr9ma2u+PrNIo1ZuMJjRrd9l08q7i2IAuuh8XDm6AVOqHDXNM7nS5nrtqWqk7div1ngOph8DgfR8sBHK6/muSElm9dBUmmcu/x5Wvk/Dsd2s+O9T/CR7Ylq8/NYJI7m06Ld9ggnLcnoWHR4rgO80t/CwmgOD11arMPx1806wDJ9oQyC+d/OzvyiCvIITSFDcPQxWnh7xn2NRESgonp6x5zgPNgzwx0XLsKWWy+N2R9lrVwiT9+gCOyKNX8q7oyvK5h6yKr902glXqnq8MEDVDqxCrE3P7QVUCXUWLSFBU0/gifvFRfWXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQlDUbuHpuF8Q6HyuDsvjG0HzPcAn12o5c+oxC7q8go=;
 b=XJmSbDkZ3CRA5smrHOr3Yloy7svgbz6PndagYbZ5izX/b2/ORMO0Iz+/8ZMYKX+kGn5fwrELzMFy8s9fvJASIXSo8ZnOuzjX2YpUfqg1ffOf1Ij4J1BJc0LqoXj4SdzF0f+759ixDRYdzJj2LqojS32BpIIROIa10JRxIkrXKOM=
Received: from MN2PR12CA0034.namprd12.prod.outlook.com (2603:10b6:208:a8::47)
 by BN7PR12MB2834.namprd12.prod.outlook.com (2603:10b6:408:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Fri, 22 Nov
 2019 09:46:19 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::206) by MN2PR12CA0034.outlook.office365.com
 (2603:10b6:208:a8::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Fri, 22 Nov 2019 09:46:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 22 Nov 2019 09:46:19 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 22 Nov
 2019 03:46:19 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 03:46:15 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>, <Akshu.Agrawal@amd.com>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH v12 6/6] ASoC: amd: Added ACP3x system resume and runtime pm
Date:   Fri, 22 Nov 2019 15:14:26 +0530
Message-ID: <1574415866-29715-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574415866-29715-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1574415866-29715-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(1496009)(39860400002)(396003)(346002)(136003)(376002)(428003)(23433003)(189003)(199004)(70586007)(14444005)(54906003)(7416002)(16586007)(478600001)(305945005)(70206006)(316002)(6666004)(356004)(5660300002)(446003)(2616005)(426003)(47776003)(336012)(86362001)(11346002)(53416004)(8936002)(1671002)(51416003)(7696005)(8676002)(76176011)(109986005)(81166006)(186003)(36756003)(50226002)(26005)(2906002)(4326008)(48376002)(81156014)(50466002)(30864003)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2834;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b76a379-fd68-4759-8777-08d76f30d3c4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2834:|BN7PR12MB2834:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2834EF4ADF022C5CDD919946E7490@BN7PR12MB2834.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHrM6OAbFr6X1PUA5POmC9FjcfWSjrdxIF9ih8gS55fGnfh7NQrxbH4BRw8X3CUZM6g83w1lW/QR3mt8/pUyq1kN0hmThx8YAi8J8S7j39Axtw8zglhGXddJraylTMaaz/eO9LmroVomFOKYH5xNtNi+xCWx7McRmEomxCQBr1xSPm61vE+OUNEBY+sonYlZN0zb9/4K70XXWK7ypZNuwOkN7P2SVRShF1OA8xQw4qrAvKZz82Bhk/I6Ha5SKMgazwVdX2z0kS548/oGkytWRv3fws3+ypplTicRjKP4YAYEmjIJFZgiWxO4BOlqga8pY0Bqae2gEsQAZBWNknycUvsgBImL3am+8sp0wWN5JN2l2iRI0axNxzT9MrWnvMOaz/F+o0BXFo2Bg0IDLq/ysVR8avGhHDNQjCTdJTl/a5krU/C1ygDcdARUm4297v/s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 09:46:19.7769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b76a379-fd68-4759-8777-08d76f30d3c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2834
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
on audio I2S lines.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 144 +-----------------------------
 sound/soc/amd/raven/acp3x.h         |   7 ++
 sound/soc/amd/raven/pci-acp3x.c     | 173 ++++++++++++++++++++++++++++++++++--
 3 files changed, 177 insertions(+), 147 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index a6bc9c1..d52d043 100644
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
@@ -534,53 +434,28 @@ static int acp3x_audio_probe(struct platform_device *pdev)
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
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
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
@@ -588,13 +463,9 @@ static int acp3x_audio_remove(struct platform_device *pdev)
 static int acp3x_resume(struct device *dev)
 {
 	struct i2s_dev_data *adata;
-	int status;
 	u32 val, reg_val, frmt_val;
 
 	adata = dev_get_drvdata(dev);
-	status = acp3x_init(adata->acp3x_base);
-	if (status)
-		return -ENODEV;
 
 	if (adata->play_stream && adata->play_stream->runtime) {
 		struct i2s_stream_instance *rtd =
@@ -640,14 +511,8 @@ static int acp3x_resume(struct device *dev)
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
 
@@ -657,12 +522,9 @@ static int acp3x_pcm_runtime_suspend(struct device *dev)
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
index 3c28644..b64f8b0 100644
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
index 94f5f21..d46a6d6 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -9,6 +9,9 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/delay.h>
+#include <sound/pcm.h>
 
 #include "acp3x.h"
 
@@ -19,6 +22,109 @@ struct acp3x_dev_data {
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
+			return 0;
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
@@ -64,6 +170,9 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
+	ret = acp3x_init(adata->acp3x_base);
+	if (ret)
+		goto disable_msi;
 
 	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
 	switch (val) {
@@ -73,7 +182,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 					  GFP_KERNEL);
 		if (!adata->res) {
 			ret = -ENOMEM;
-			goto disable_msi;
+			goto de_init;
 		}
 
 		adata->res[0].name = "acp3x_i2s_iomem";
@@ -118,7 +227,7 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		pdevinfo[2].parent = &pci->dev;
 		pdevinfo[2].num_res = 1;
 		pdevinfo[2].res = &adata->res[2];
-		for (i = 0; i < ACP3x_DEVS ; i++) {
+		for (i = 0; i < ACP3x_DEVS; i++) {
 			adata->pdev[i] =
 				platform_device_register_full(&pdevinfo[i]);
 			if (IS_ERR(adata->pdev[i])) {
@@ -134,12 +243,20 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		ret = -ENODEV;
 		goto disable_msi;
 	}
+	pm_runtime_set_autosuspend_delay(&pci->dev, 5000);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_set_active(&pci->dev);
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_enable(&pci->dev);
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


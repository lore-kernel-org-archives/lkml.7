Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87994CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5571C21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UgnVX6HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633507AbfJRKOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:14:21 -0400
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:6850
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633484AbfJRKOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi37szwimSH75B1tOLpVmlEmqSI8kOVHpMSOGUOFquH/dm+Y6al47U2G/kAkRVtRQelUPFDqPdqodaOxRC/UOnzYb73eTUyk0QOt/99S0m1fHvGygUHtbZ3J2NuO3XYIuVzhtJpqNjYuL536pjvry6uO+pjg7jYnjli5hlDT0C+s391jolz4f9cUo/qakzJXy3MR51KGIzuyP1nBkhlCfnxFjDcsnmmIlQXnG5YqnIfaCIWYECev58i1dkjGH4s3ZQ4QIgk29qFhl4PCCsfd/2tbrKzCSYTLYDGjnZqs+FQBP3NJ7UJvXNWJXZ2PCXCgVzSY7ElckJ/h+RKCRi4R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MGGiyrrLr1vVm/pYlJkP4AC0TQMkbhkx2InrFVh8rE=;
 b=JLrjipappHJwaTq1vY8QtwJp/Mqy0A9DuC/ElG0DAy5Q+f9l7UYXM69ZEf+fwTX+D+g1fT4yzw4+avQFRwUcRX4zPkmEqGG5/UirVbwaRanM/yxOWjqg+IVqXJcsZ0l5yQVUfsnL6Bqc1KG+JdJ0krzELRsaRnJyB7yFS52CxCp53WnrLMqszdOk7o99b5NTrcopVuHz3fhoVJLlQq5jO29oz0h407G4OaBIpMedI1mvRYG6SgqSsjYiw4m0owUQkTqRVFZ/gu2KLYDxoxuRqEWJY+zzRQZQ9WZWDa4gtGrI4jLUoT4KeBC1tJuESfAhspd9d5iNXwsPjbNJx1GGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MGGiyrrLr1vVm/pYlJkP4AC0TQMkbhkx2InrFVh8rE=;
 b=UgnVX6HDlGEfD+EuC214sdyuX+Whby6hCnWh/oQjDVrfMepqhGDLkk9NAmS2FXkiynMGd/WybDOsLtDbLUjuvhMXFDH88Q1eHgt05S9DP7/ohIa/R5a6F9MYTImHqgfEGNyavRqNOmigv88a+6fnOx14npfNXjTQcCnXt9SzUT0=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:6f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Fri, 18 Oct
 2019 10:14:16 +0000
Received: from CO1NAM03FT027.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Fri, 18 Oct 2019 10:14:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT027.mail.protection.outlook.com (10.152.80.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2367.14 via Frontend Transport; Fri, 18 Oct 2019 10:14:15 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 18 Oct
 2019 05:14:14 -0500
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 05:14:11 -0500
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
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] ASoC: amd: Added ACP3x system resume and runtime pm ops
Date:   Sat, 19 Oct 2019 02:35:45 +0530
Message-ID: <1571432760-3008-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(199004)(189003)(47776003)(2906002)(1671002)(5660300002)(50466002)(478600001)(48376002)(54906003)(53416004)(70586007)(316002)(305945005)(70206006)(14444005)(76176011)(11346002)(426003)(8676002)(446003)(51416003)(36756003)(336012)(186003)(26005)(109986005)(356004)(7696005)(4326008)(6666004)(16586007)(8936002)(81156014)(86362001)(476003)(81166006)(126002)(2616005)(486006)(50226002)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2686;H:SATLEXMB01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 397a4a19-6620-47e3-a5d7-08d753b3ee2b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686157F81B56160267245A2E76C0@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 01949FE337
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46tWl6R1Ng0LWbt5z5P3iYnPqN+Q1NL/HISz1He4tR/iuu4Q81hfsIG0OBpzqZFWF7n/5t7wWKMp39McnXpUReSv3wh7FvbAbw5rFxLra+j3CIaf0K4oreJYL3LeqOWvFW72keePdikxmSMTTINvP4ZdWsyokf4yAQF7bMv67oZNxd5B9AL8CoX7TmBJpoOQa2brdXREDbD+jg/erbcVuXo4tOS/KqVxq5G04j7k4YDST4DzXa7vvxVfBjN9rdGq5Ps8mUBNpah72/se5aIw7oGhtNg27kThP9GTIvGpy6xwLotbTMd9VlEBZIk4XNVfhKfT8b78MLS+qm9R6gopIS7jRrreNaAtcKXWIsMB0eSCl7EVyhNW1cz4LqOWhzaFJic6WAn5BjOuO8thKkVl7jBPr4exKabugcHqdUTp91E=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 10:14:15.4695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397a4a19-6620-47e3-a5d7-08d753b3ee2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system wide suspend happens, ACP will be powered off
and when system resumes,for audio usecase to continue,
all the runtime configuration data needs to be programmed again.
Added resume pm call back to ACP pm ops and
also Added runtime PM operations for ACP3x PCM platform device.
Device will enter into D3 state when there is no activity
on audio I2S lines.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index b74ecf6..192a7b9 100644
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
 
@@ -262,6 +265,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		}
 		break;
 	}
+	pm_runtime_set_autosuspend_delay(&pci->dev, 10000);
+	pm_runtime_use_autosuspend(&pci->dev);
+	pm_runtime_set_active(&pci->dev);
+	pm_runtime_put_noidle(&pci->dev);
+	pm_runtime_enable(&pci->dev);
 	return 0;
 
 unmap_mmio:
@@ -282,6 +290,39 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	return ret;
 }
 
+static int  snd_acp3x_suspend(struct device *dev)
+{
+	int status;
+	struct acp3x_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_deinit(adata->acp3x_base);
+	if (status)
+		dev_err(dev, "ACP de-init failed\n");
+	else
+		dev_info(dev, "ACP de-initialized\n");
+
+	return 0;
+}
+static int  snd_acp3x_resume(struct device *dev)
+{
+	int status;
+	struct acp3x_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_init(adata->acp3x_base);
+	if (status) {
+		dev_err(dev, "ACP init failed\n");
+		return status;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops acp3x_pm = {
+	.runtime_suspend = snd_acp3x_suspend,
+	.runtime_resume =  snd_acp3x_resume,
+	.resume =       snd_acp3x_resume,
+};
+
 static void snd_acp3x_remove(struct pci_dev *pci)
 {
 	int i;
@@ -297,7 +338,9 @@ static void snd_acp3x_remove(struct pci_dev *pci)
 	else
 		dev_info(&pci->dev, "ACP de-initialized\n");
 	iounmap(adata->acp3x_base);
-
+	pm_runtime_disable(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
+	pci_disable_msi(pci);
 	pci_disable_msi(pci);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
@@ -316,6 +359,9 @@ static struct pci_driver acp3x_driver  = {
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


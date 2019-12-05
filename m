Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC87C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346CE22525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PivV54Em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfLENjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:39:42 -0500
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:10534
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729417AbfLENjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:39:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os84K7iWBKvybs+zeYW2aeykeltL/aOVY6j8p/sHWK96/DSo+ZhaIJjFBo3Yhv09JIPJZHqg5aW8lLrqHRkb/ghS+XlLx9JwId+Hx9Pg82gGaUrMkj6TtNd1hkTGje52hC9ZeL2gW+Mix8QMRA11yp+4Mbmo3G2LmKw8KN506piAuF/7r+jPAqAhSDry+XG181Qh4SSooC+WcHz4qzenCei2HxX580Gnwd/0JsIZEo8fyR05sMxrNORcuIgaQrGd6ZT7SokKpLu1Yp9xDxY2T+UxDDk0oYgfltpLZto5coyDeXH7/MGUJ8J/TN0G+zOVFSXkgd025YS4vAnJrStI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+PJA8YsSavTKQ4DUxOIyr2gdRZwUH2qDtnbKAyINNI=;
 b=Ata0mBKenQtTR5+8pm8Dp7VNxifRNqWDd5eMqXB+lzcdARbbLL+NAMYPPcH+0UWZTu12h2QfCvNTkQ1VgzVtfBgMewDWm6XrFb1ddnMFjGprDhyp9kkV1eTP6eXwoNhqa8ZIU74DxRX6gCNrG5jrrfhBfnfti/LR93JVuMqn1i867U4WnHlISuyi27SpMNIlivHCkxcaU/xvpBPzCpevbIL15QGs3wURREwjHofWr9UAEnlXp3MC6xiIoT8VD5QjVVp3/9imO6LFyLJiLMIhd2KS2S14YgsH4OJEEQYiKD4TC1TPv4kyVY8uElnwev3QVcUe7FBUMjLK39akgXvJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+PJA8YsSavTKQ4DUxOIyr2gdRZwUH2qDtnbKAyINNI=;
 b=PivV54Em2j0ROjhdnhCiBK7Ymr0oGIO7lUVmVn9euBnIqwL+RrRm4JDosRtLjl3OSLyof2TzXQsKi5JhxIc7XH33OAj9qaRtzMU9z9ztgR+ZB2WgGpwPWwlWANmFmVV+wGbYwhViJLH43DLPBHffpXrCBn5cjVmoRz250u1JC0E=
Received: from MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) by DM6PR12MB3660.namprd12.prod.outlook.com
 (2603:10b6:5:1c3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Thu, 5 Dec
 2019 13:39:37 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by MWHPR1201CA0002.outlook.office365.com
 (2603:10b6:301:4a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 13:39:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 5 Dec 2019 13:39:36 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Dec 2019
 07:39:36 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 5 Dec 2019 07:39:33 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <djkurtz@google.com>,
        <pierre-louis.bossart@linux.intel.com>,
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
Subject: [PATCH v14 4/7] ASoC: amd: add ACP3x TDM mode support
Date:   Thu, 5 Dec 2019 19:07:29 +0530
Message-ID: <1575553053-18344-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575553053-18344-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1575553053-18344-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(428003)(189003)(199004)(336012)(50466002)(51416003)(109986005)(16586007)(54906003)(7696005)(86362001)(426003)(76176011)(81156014)(48376002)(81166006)(8936002)(8676002)(70206006)(70586007)(498600001)(305945005)(26005)(53416004)(4326008)(2616005)(2906002)(36756003)(186003)(5660300002)(50226002)(356004)(11346002)(6666004)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3660;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c68d71-dd82-48b4-d044-08d77988920e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3660:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36605D61ADA5CE5BF8F296B5E75C0@DM6PR12MB3660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVNbep6klw6nS61CyH+9VJcetgXVgCnQX/1mpxfd+UunFlLtA/l8n+slajNRz6zCVJyQvwyghcmxXfHErkc1xzrnn/8W36crXKOz4RUNYNjUS74Cn+5JZiAxjhX4qj/eLzK9nOljvpNo9OQRqK7k24gh0AL2ItCbzZZ0+Zdkp1kZkvibdXpFMCRyLHRxm/rjBtYRbQ3CIUIUjLyYKei9tzzqh1rNDTL5098UJxOqqwbupEj6xrOTMd8jijGvI5K8FJfN4MVjewEIuYO/OlnqmkL69ZuKgfaKvrStDv1G3+jNJ2fxnXk8y6a0Cqgv6kd3641XP8TbvjGixgRuZMMWA/IciZoxQXb+SB9+wwed7TKoFCumd/2rjKCUxC/VwdrtROtLIit8guAff5oYjpR/cWC+cQ5hjdTcY7jNhNqzElE6YNbxakgVLs4N8bok7pZTVOvtGgD00RiWkZVlTBV4JpQV7zymSWqQ+vEnJyMDvmd9dVocmGOGaD9a/e1ISxgc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 13:39:36.8751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c68d71-dd82-48b4-d044-08d77988920e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3660
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes. Added support
for TDM mode. Desired mode can be selected from ASoC machine driver.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 28 ++++++++++++++++++++++------
 sound/soc/amd/raven/acp3x.h     |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 7f05782..0856e0c 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -43,7 +43,7 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 		u32 tx_mask, u32 rx_mask, int slots, int slot_width)
 {
 	struct i2s_dev_data *adata;
-	u32 val, reg_val, frmt_val, frm_len;
+	u32 val, reg_val, frmt_reg, frm_len;
 	u16 slot_len;
 
 	adata = snd_soc_dai_get_drvdata(cpu_dai);
@@ -70,15 +70,31 @@ static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,
 
 	frm_len = FRM_LEN | (slots << 15) | (slot_len << 18);
 	if (adata->substream_type == SNDRV_PCM_STREAM_PLAYBACK) {
-		reg_val = mmACP_BTTDM_ITER;
-		frmt_val = mmACP_BTTDM_TXFRMT;
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			reg_val = mmACP_BTTDM_ITER;
+			frmt_reg = mmACP_BTTDM_TXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = mmACP_I2STDM_ITER;
+			frmt_reg = mmACP_I2STDM_TXFRMT;
+		}
 	} else {
-		reg_val = mmACP_BTTDM_IRER;
-		frmt_val = mmACP_BTTDM_RXFRMT;
+		switch (adata->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			reg_val = mmACP_BTTDM_IRER;
+			frmt_reg = mmACP_BTTDM_RXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = mmACP_I2STDM_IRER;
+			frmt_reg = mmACP_I2STDM_RXFRMT;
+		}
 	}
 	val = rv_readl(adata->acp3x_base + reg_val);
 	rv_writel(val | 0x2, adata->acp3x_base + reg_val);
-	rv_writel(frm_len, adata->acp3x_base + frmt_val);
+	rv_writel(frm_len, adata->acp3x_base + frmt_reg);
 	adata->tdm_fmt = frm_len;
 	return 0;
 }
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index ed1acbc..3c28644 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -78,6 +78,7 @@ struct acp3x_platform_info {
 struct i2s_dev_data {
 	bool tdm_mode;
 	unsigned int i2s_irq;
+	u16 i2s_instance;
 	u32 tdm_fmt;
 	u32 substream_type;
 	void __iomem *acp3x_base;
-- 
2.7.4

